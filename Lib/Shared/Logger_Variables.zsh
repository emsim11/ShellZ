# ~/ZSH_DIR/Lib/Shared/Logger_Variables.zsh
# ─────────────────────────────────────────────────────────────────────────────
# Log Type Mappings For ZLog
# ─────────────────────────────────────────────────────────────────────────────

typeset -gA LOG_COLORS=(
  "Custom"    ""
  "Emphasis"  "$MAGENTA"
  "Error"     "$RED"
  "Info"      "$CYAN"
  "Success"   "$GREEN"
  "Warning"   "$YELLOW"
)

typeset -gA LOG_INDICATORS=(
  "Custom"    ""
  "Emphasis"  "➤"
  "Error"     "✖"
  "Info"      "→"
  "Success"   "✔"
  "Warning"   "⚠"
)

typeset -gA LOG_SUFFIXES=(
  "Custom"    ""
  "Emphasis"  ""
  "Error"     "!"
  "Info"      "…"
  "Success"   "!"
  "Warning"   "!"
)