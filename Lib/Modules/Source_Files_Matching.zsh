# ~/$ZSH_DIR/Lib/Modules/Source_Files_Matching.zsh
# ─────────────────────────────────────────────────────────────────────────────
# Find And Source All Matching Files Given A Directory Path And Glob Pattern
# ─────────────────────────────────────────────────────────────────────────────

function Source_Files_Matching() {
  # ── ARGUMENTS ──────────────────────────────────────────────────────────────
  local Path=$1
  local Glob_Pattern=$2

  # ── VARIABLES ──────────────────────────────────────────────────────────────
  local -a Files=()

  # ── VALIDATIONS ────────────────────────────────────────────────────────────
  if [[ -z $Path || ! -d $Path ]]; then
    print -P "%B%F{red}!%f%b %BError:%b Invalid Directory Provided To %BSource_Files_Matching()%b: %U${Path}%u\n" >&2
    return 1
  fi

  if [[ -z $Glob_Pattern ]]; then
    print -P "%B%F{red}!%f%b %BError:%b A Glob Pattern Must Be Provided To %BSource_Files_Matching()%b!\n" >&2
    return 1
  fi

  # ── LOG MESSAGE ────────────────────────────────────────────────────────────
  print -P "\n%B%F{cyan}→%f%b Sourcing Files Matching \"%B${Glob_Pattern}%b\" In %U${Path}%u:"

  # ── COLLECT FILES ──────────────────────────────────────────────────────────
  while IFS= read -r -d '' File; do
    Files+=("$File")
  done < <(find "$Path" -type f -name "$Glob_Pattern" -print0)

  if (( ${#Files} == 0 )); then
    print -P "  %B↳%b No Matching Files Found!"
    return 0
  fi

  # ── SOURCE AND LOG FILES ───────────────────────────────────────────────────
  Files=(${(on)Files})

  for File in "${Files[@]}"; do
    print -P "  %B%F{cyan}↪%f%b Sourced: %U${File:t}%u"
    source "$File"
  done

  # ── EXIT WITH SUCCESS STATUS ───────────────────────────────────────────────
  return 0
}