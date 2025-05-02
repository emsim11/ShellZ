#!/usr/bin env zsh

# ~/$ZSH_DIR/Init.zsh
# ─────────────────────────────────────────────────────────────────────────────
# ZSH Framework Bootstrapping
# ─────────────────────────────────────────────────────────────────────────────

# ── CORE CONFIGURATION ───────────────────────────────────────────────────────
: "${ZSH_DIR:=$HOME/ShellZ}"
: "${ZSH_FUNCTIONS_DIR:=$ZSH_DIR/Lib/Functions}"
: "${ZSH_PLUGINS_DIR:=$ZSH_DIR/Lib/Plugins}"
: "${ZSH_SHARED_DIR:=$ZSH_DIR/Lib/Shared}"
: "${ZLOGIN_FILE:=$HOME/.zlogin}"
: "${ZLOGOUT_FILE:=$HOME/.zlogout}"
: "${ZPROFILE_FILE:=$HOME/.zprofile}"
: "${ZSHENV_FILE:=$HOME/.zshenv}"
: "${ZSHRC_FILE:=$HOME/.zshrc}"

typeset -a FPATH_DIRS=(
  $ZSH_FUNCTIONS_DIR
  $ZSH_PLUGINS_DIR
)

typeset -a SITE_FPATH=(
  /opt/homebrew/share/zsh/site-functions
  /usr/local/share/zsh/site-functions
  /usr/share/zsh/site-functions
  /usr/share/zsh/$(zsh --version | cut -d' ' -f2)/functions
)

# ── VALIDATIONS ──────────────────────────────────────────────────────────────
for D in $ZSH; do
  [[ -d $D ]] || {
    print -P "%B%F{red}!%f%b %BError:%b Directory Not Found: %U$D%u\n" >&2
    return 1
  }
done

for D in $FPATH_DIRS; do
  [[ -d $D ]] || {
    print -P "%B%F{yellow}⚠%f%b %BWarning:%b Missing Directory: %U$D%u" >&2
  }
done

# ── SOURCE GLOBAL VARIABLES ──────────────────────────────────────────────────
source "$ZSH_DIR/Lib/Modules/Source_Files_Matching.zsh"
Source_Files_Matching "$ZSH_SHARED_DIR" "*_Variables.zsh"

# ── SCAN $ZSH_FUNCTIONS_DIR ──────────────────────────────────────────────────
print -P "\n%B%F{cyan}→%f%b Scanning %U%BFunction%b%u Directory Paths…"

typeset -aU FUNCTION_DIRS=()
typeset -aU FUNCTION_FILES=()

while IFS= read -r -d $'\0' Item; do
  if [[ -d $Item ]]; then
    FUNCTION_DIRS+=("$Item")
  elif [[ -f $Item ]]; then
    FUNCTION_FILES+=("${Item:t}")
  fi
done < <(find "$ZSH_FUNCTIONS_DIR" -print0)

FUNCTION_DIRS=(${(on)FUNCTION_DIRS})
FUNCTION_FILES=(${(on)FUNCTION_FILES})

print -P "  %B%F{cyan}↪%f%b %BFunction Directories:%b"
for D in "${FUNCTION_DIRS[@]}"; do print -P "    %B%F{cyan}•%f%b $D"; done
print -P "  %B%F{cyan}↪%f%b %BFunction Files:%b"
for D in "${FUNCTION_FILES[@]}"; do print -P "    %B%F{cyan}•%f%b $D"; done

# ── SCAN $ZSH_PLUGINS_DIR ────────────────────────────────────────────────────
print -P "\n%B%F{cyan}→%f%b Scanning %U%BPlugins%b%u Directory Paths…"

typeset -aU PLUGIN_DIRS=()
typeset -aU PLUGIN_FILES=()

while IFS= read -r -d $'\0' Item; do
  if [[ -d $Item ]]; then
    PLUGIN_DIRS+=("$Item")
  elif [[ -f $Item ]]; then
    PLUGIN_FILES+=("${Item:t}")
  fi
done < <(find "$ZSH_PLUGINS_DIR" -print0)

PLUGIN_DIRS=(${(on)PLUGIN_DIRS})
PLUGIN_FILES=(${(on)PLUGIN_FILES})

print -P "  %B%F{cyan}↪%f%b %BPlugin Directories:%b"
for D in "${PLUGIN_DIRS[@]}"; do print -P "    %B%F{cyan}•%f%b $D"; done
print -P "  %B%F{cyan}↪%f%b %BPlugin Files:%b"
for D in "${PLUGIN_FILES[@]}"; do print -P "    %B%F{cyan}•%f%b $D"; done

# ── $FPATH ───────────────────────────────────────────────────────────────────
print -P "\n%B%F{cyan}→%f%b Setting Up \$fpath…"

typeset -aU fpath=()

fpath=("${SITE_FPATH[@]}")

FUNCTION_DIRS=("${(@u)FUNCTION_DIRS}" "${fpath[@]}")
fpath=("${FUNCTION_DIRS[@]}")
fpath=(${(on)fpath})

PLUGIN_DIRS=("${(@u)PLUGIN_DIRS}" "${fpath[@]}")
fpath=("${PLUGIN_DIRS[@]}")
fpath=(${(on)fpath})

print -P "  %B%F{cyan}↪%f%b %B\$fpath:%b"
for D in "${fpath[@]}"; do print -P "    %B%F{cyan}•%f%b $D"; done
print -P "  %B%F{cyan}↪%f%b Run %B\"print -rl -- \$fpath\"%b To View All Directories"

# ── AUTOLOAD ─────────────────────────────────────────────────────────────────
# TODO: Find Way To Automatically "Unfunction" Functions That Are No Longer Apart Of List
print -P "\n%B%F{cyan}→%f%b Autoloading Functions…"

if (( ${#FUNCTION_FILES} )); then
  FUNCTION_FILES=("${(@u)FUNCTION_FILES}")
  print -P "  %B%F{cyan}↪%f%b Autoloaded %U%B${#FUNCTION_FILES}%b%u Functions:"
  for F in "${FUNCTION_FILES[@]}"; do print -P "    %B%F{cyan}•%f%b $F"; done
  autoload -Uz -- "${FUNCTION_FILES[@]}"
else
  print -P "  %B%F{cyan}↪%f%b No Functions Found In: %U$ZSH_FUNCTIONS_DIR%u"
fi

if (( ${#PLUGIN_FILES} )); then
  PLUGIN_FILES=("${(@u)PLUGIN_FILES}")
  print -P "  %B%F{cyan}↪%f%b Autoloaded %U%B${#PLUGIN_FILES}%b%u Plugins:"
  for F in "${PLUGIN_FILES[@]}"; do print -P "    %B%F{cyan}•%f%b $F"; done
  autoload -Uz -- "${PLUGIN_FILES[@]}"
else
  print -P "  %B%F{cyan}↪%f%b No Functions Found In: %U$ZSH_PLUGINS_DIR%u"
fi

print -P "  %B%F{cyan}↪%f%b Run %B\"functions -U\"%b To View All Autoloaded Functions"

# ── EXIT WITH SUCCESS STATUS  ────────────────────────────────────────────────
return 0