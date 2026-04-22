#!/bin/bash
# Claude Code portable config installer

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "Installing Claude Code configuration..."

# Create directories if needed
mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"

# Copy agents
cp -r "$SCRIPT_DIR/agents/"* "$CLAUDE_DIR/agents/"
echo "✓ Installed 7 agents"

# Copy skills
cp -r "$SCRIPT_DIR/skills/"* "$CLAUDE_DIR/skills/"
echo "✓ Installed 4 skills"

# Copy CLAUDE.md if it doesn't exist
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/"
  echo "✓ Installed CLAUDE.md"
else
  echo "⚠ CLAUDE.md already exists, skipping (merge manually if needed)"
fi

echo ""
echo "Done! Installed to $CLAUDE_DIR"
echo ""
echo "Agents:"
ls "$CLAUDE_DIR/agents/"
echo ""
echo "Skills:"
ls "$CLAUDE_DIR/skills/"
