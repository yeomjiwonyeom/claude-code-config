#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install_claude=false
install_codex=false

case "${1:-both}" in
  both) install_claude=true; install_codex=true ;;
  --claude) install_claude=true ;;
  --codex) install_codex=true ;;
  *)
    echo "Usage: $0 [both|--claude|--codex]" >&2
    exit 2
    ;;
esac

timestamp="$(date +%Y%m%d-%H%M%S)"
backup_root="${HOME}/.ai-config-backups/${timestamp}"

backup_if_present() {
  local target="$1"
  if [[ -e "$target" ]]; then
    local relative="${target#"$HOME"/}"
    mkdir -p "$backup_root/$(dirname "$relative")"
    cp -R "$target" "$backup_root/$relative"
  fi
}

install_tree() {
  local source_dir="$1"
  local target_dir="$2"
  mkdir -p "$target_dir"
  local source
  for source in "$source_dir"/*; do
    [[ -e "$source" ]] || continue
    local target="$target_dir/$(basename "$source")"
    backup_if_present "$target"
    rm -rf "$target"
    cp -R "$source" "$target"
  done
}

remove_legacy_agents() {
  local target_dir="${HOME}/.claude/agents"
  local name
  for name in \
    business-analyst.md \
    cloud-architect.md \
    competitive-analyst.md \
    python-pro.md \
    sales-engineer.md \
    search-specialist.md \
    technical-writer.md; do
    local target="$target_dir/$name"
    if [[ -e "$target" ]]; then
      backup_if_present "$target"
      rm -f "$target"
    fi
  done
}

validate_skills() {
  local skill_file
  for skill_file in "$script_dir"/skills/*/SKILL.md; do
    [[ -f "$skill_file" ]] || continue
    grep -q '^name: ' "$skill_file"
    grep -q '^description: ' "$skill_file"
  done
}

merge_claude_preferences() {
  local target="${HOME}/.claude/CLAUDE.md"
  local begin='<!-- portable-ai-config:begin -->'
  local end='<!-- portable-ai-config:end -->'
  mkdir -p "$(dirname "$target")"
  backup_if_present "$target"
  if [[ -f "$target" ]]; then
    awk -v begin="$begin" -v end="$end" '
      $0 == begin { skipping=1; next }
      $0 == end { skipping=0; next }
      !skipping { print }
    ' "$target" > "${target}.tmp"
  else
    : > "${target}.tmp"
  fi
  {
    printf '\n%s\n' "$begin"
    cat "$script_dir/CLAUDE.md"
    printf '%s\n' "$end"
  } >> "${target}.tmp"
  mv "${target}.tmp" "$target"
}

validate_skills

if $install_claude; then
  remove_legacy_agents
  install_tree "$script_dir/agents" "${HOME}/.claude/agents"
  install_tree "$script_dir/skills" "${HOME}/.claude/skills"
  merge_claude_preferences
fi

if $install_codex; then
  install_tree "$script_dir/skills" "${CODEX_HOME:-${HOME}/.codex}/skills"
fi

echo "Installed portable AI configuration."
if [[ -d "$backup_root" ]]; then
  echo "Backups: $backup_root"
fi
