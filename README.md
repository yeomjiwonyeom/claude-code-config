# Portable AI Assistant Config

Concise personal skills and Claude Code agents. The skills use the common
`SKILL.md` format and can be installed for both Claude Code and Codex.

## Contents

### Claude Code agents (4)
| Agent | Purpose |
|-------|---------|
| python-engineer | Production Python implementation and review |
| aws-architect | AWS architecture and tradeoff review |
| business-strategist | AI value, requirements, stakeholders, and GTM |
| research-writer | Source-grounded research and documentation |

### Skills (4)
| Skill | Purpose |
|-------|---------|
| ai-value-framing | Transform AI ideas into business value |
| agent-system-design | RAG/Agent architecture design |
| ai-ready-data-diagnostic | Data infrastructure AI readiness |
| stakeholder-strategy | Navigate stakeholder dynamics |

## Installation

Install for both assistants:

```bash
./install.sh
```

Choose one target:

```bash
./install.sh --claude
./install.sh --codex
```

The installer validates skills, backs up replaced files, installs agents only
for Claude Code, and merges the preference block without replacing unrelated
Claude configuration.

Claude Desktop 3P and Claude Code are separate surfaces. This repository does
not edit Claude Desktop 3P's `managedMcpServers` configuration.

## Usage

Skills are invoked with slash commands:
- `/ai-value-framing`
- `/agent-system-design`
- `/ai-ready-data-diagnostic`
- `/stakeholder-strategy`

In Codex, mention a skill with `$skill-name`. Claude Code can invoke installed
skills and select agents based on task context.
