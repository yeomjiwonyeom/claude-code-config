# Claude Code Portable Config

Personal agents and skills for Claude Code.

## Contents

### Agents (7)
| Agent | Purpose |
|-------|---------|
| python-pro | Type-safe Python development |
| search-specialist | Information retrieval |
| cloud-architect | AWS architecture review |
| sales-engineer | Technical pre-sales, PoC |
| competitive-analyst | Competitor comparison |
| business-analyst | Requirements analysis |
| technical-writer | Documentation |

### Skills (4)
| Skill | Purpose |
|-------|---------|
| ai-value-framing | Transform AI ideas into business value |
| agent-system-design | RAG/Agent architecture design |
| ai-ready-data-diagnostic | Data infrastructure AI readiness |
| stakeholder-strategy | Navigate stakeholder dynamics |

## Installation

```bash
./install.sh
```

Or manually:
```bash
cp -r agents/* ~/.claude/agents/
cp -r skills/* ~/.claude/skills/
```

## Usage

Skills are invoked with slash commands:
- `/ai-value-framing`
- `/agent-system-design`
- `/ai-ready-data-diagnostic`
- `/stakeholder-strategy`

Agents are automatically selected based on task context.
