#!/bin/zsh

function _aws::help() {
  cat <<'EOF'
Usage:
  aws::rotate_keys [profile]

Arguments:
  profile   AWS SSO profile name to use.
            Default: playground

Description:
  Rotates AWS temporary credentials using AWS SSO.

Examples:
  aws::rotate_keys
  aws::rotate_keys myprofile
  aws::rotate_keys --help

EOF
}

function _aws::check_dependencies() {
  local tool
  for tool in "$@"; do
    if ! command -v "$tool" &>/dev/null; then
      printf "[ERROR] '%s' is not installed. Please install it.\n" "$tool" >&2
      return 1
    fi
  done
  return 0
}

#######################################
# Rotates AWS Access Keys from SSO to [default] and specified profile.
#
# Arguments:
#   1: profile (optional, default: "playground")
#      Pass -h or --help to see usage.
# Outputs:
#   Writes status to stdout/stderr.
#   Updates ~/.aws/credentials.
#######################################
function aws::rotate_keys() {
  if [[ "$1" == "--help" ]]; then
    _aws::help
    return 0
  fi
  if [[ "$1" == -* ]]; then
    printf "[ERROR] Unknown option: %s\n" "$1" >&2
    printf "Run with --help for usage.\n"
    return 1
  fi
  if ! _aws::check_dependencies aws jq; then
    return 1
  fi

  local profile="${1:-playground}"
  local cred_file="$HOME/.aws/credentials"

  printf "=> Running AWS Key Rotation for profile: %s\n" "$profile"

  if aws sts get-caller-identity --profile "$profile" >/dev/null 2>&1; then
    printf "[OK] Already logged in to SSO.\n"
  else
    printf "[WARN] SSO session expired or missing.\n"
    printf "==> Logging in to '%s'...\n" "$profile"

    if ! aws sso login --profile "$profile"; then
      printf "[ERROR] Login failed.\n" >&2
      return 1
    fi
    printf "[OK] Login successful.\n"
  fi

  printf "=> Fetching temporary role credentials...\n"

  local creds_json
  creds_json=$(aws configure export-credentials --profile "$profile" 2>/dev/null)

  if [[ -z "$creds_json" ]]; then
    printf "[ERROR] Failed to retrieve credentials.\n" >&2
    return 1
  fi

  local key_id=$(echo "$creds_json" | jq -r '.AccessKeyId')
  local secret_key=$(echo "$creds_json" | jq -r '.SecretAccessKey')
  local session_token=$(echo "$creds_json" | jq -r '.SessionToken')

  printf "=> Saving credentials to [default] profile in %s...\n" "$cred_file"

  aws configure set aws_access_key_id "$key_id" --profile default
  aws configure set aws_secret_access_key "$secret_key" --profile default
  aws configure set aws_session_token "$session_token" --profile default

  aws configure set aws_access_key_id "$key_id" --profile "$profile"
  aws configure set aws_secret_access_key "$secret_key" --profile "$profile"
  aws configure set aws_session_token "$session_token" --profile "$profile"

  printf "----------------------------------------\n"
  printf "[SUCCESS]\n"
  printf "Access Key ID: %s\n" "$key_id"
  printf "[default] and [%s] profile updated.\n" "$profile"
  printf "----------------------------------------\n"
}
