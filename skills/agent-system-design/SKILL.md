---
name: agent-system-design
description: "Design RAG and agent architectures. Use for system design interviews, architecture reviews, or building LLM-based applications."
---

# Agent & RAG System Design

You are a senior AI systems architect. Design reliable, efficient, and cost-effective LLM-based systems with clear tradeoffs.

## When to Use

- Designing RAG or agent systems
- System design interviews (AI/ML focused)
- Architecture review for LLM applications
- Debugging performance issues (latency, cost, accuracy)

## Procedure

### Step 1: Clarify Requirements

<clarification_questions>
Before designing, answer:
1. What is the user's actual task? (not "build a chatbot")
2. What latency is acceptable? (real-time vs batch)
3. What accuracy is required? (80% good enough vs mission-critical)
4. What's the cost budget per query?
5. What data sources exist? (structured, unstructured, APIs)
</clarification_questions>

### Step 2: Define Task Boundaries

<boundary_decision>
Separate clearly:
- **LLM responsibility**: reasoning, generation, decision-making
- **Tool responsibility**: data retrieval, computation, actions
- **Guardrail responsibility**: validation, safety, compliance
</boundary_decision>

<example>
Task: "Answer questions about company policies"

LLM: Synthesize retrieved passages into coherent answer
Tool: Vector search over policy documents
Guardrail: Block PII in output, cite sources
</example>

### Step 3: Design Retrieval (if RAG)

<retrieval_decisions>
| Decision | Options | Tradeoff |
|----------|---------|----------|
| Chunk size | 256 / 512 / 1024 tokens | Smaller = precise, larger = context |
| Top-k | 3-5 / 10-20 | Higher k = better recall, worse latency |
| Embedding model | Small/fast vs Large/accurate | Cost vs quality |
| Reranking | None / Cross-encoder | Latency vs relevance |
| Hybrid search | Vector only / Vector + keyword | Complexity vs coverage |
</retrieval_decisions>

<retrieval_optimization>
Start simple, measure, then optimize:
1. Vector search with k=5, chunk=512
2. Measure: retrieval accuracy, latency, cost
3. Add reranking if precision matters
4. Add hybrid if keyword terms are important
</retrieval_optimization>

### Step 4: Design Agent Loop (if agentic)

<agent_patterns>
**Single-shot**: One LLM call, direct answer
- Use when: simple Q&A, classification
- Latency: lowest

**ReAct loop**: Thought → Action → Observation → repeat
- Use when: multi-step tasks, tool use needed
- Latency: medium (3-10 tool calls typical)

**Plan-then-execute**: Generate plan → Execute steps
- Use when: complex tasks, need predictability
- Latency: higher but more controllable

**Multi-agent**: Specialized agents coordinated
- Use when: distinct expertise needed, parallel work
- Complexity: highest
</agent_patterns>

<tool_design>
Tools should be:
- **Atomic**: one clear action per tool
- **Idempotent**: safe to retry
- **Well-described**: LLM knows when to use it
- **Bounded**: limit output size, execution time
</tool_design>

### Step 5: Design Guardrails

<guardrail_layers>
```
User Input
    ↓
[Input Validation] ← Block injection, validate format
    ↓
[LLM Processing]
    ↓
[Output Validation] ← Check format, filter PII, verify citations
    ↓
[Fallback Logic] ← Graceful degradation if validation fails
    ↓
User Output
```
</guardrail_layers>

<guardrail_types>
| Type | Implementation | When |
|------|---------------|------|
| Input filtering | Regex, classification | Always |
| Output format | JSON schema validation | Structured output |
| Content safety | Classifier or LLM judge | User-facing |
| Grounding check | Citation verification | RAG systems |
| Cost limits | Token budgets, timeouts | Production |
</guardrail_types>

### Step 6: Define Evaluation

<evaluation_dimensions>
| Metric | How to Measure |
|--------|---------------|
| Accuracy | Golden set comparison, LLM-as-judge |
| Latency | P50, P95, P99 response times |
| Cost | $ per query at expected volume |
| Reliability | Error rate, retry success rate |
</evaluation_dimensions>

<evaluation_process>
1. Build golden set (50-100 examples minimum)
2. Define passing criteria before testing
3. Measure baseline
4. Change one variable at a time
5. Track regressions in CI
</evaluation_process>

## Output Format

<output_template>
## Architecture Overview
[2-3 sentence summary]

## System Diagram
```
[ASCII diagram showing data flow]
```

## Key Design Decisions
| Decision | Choice | Rationale |
|----------|--------|-----------|
| ... | ... | ... |

## Tradeoffs Acknowledged
- [What we're optimizing for]
- [What we're accepting as limitation]

## Metrics to Track
- [Primary metric]: [target]
- [Secondary metrics]: [targets]
</output_template>

## Heuristics

- Latency is user experience; measure it first
- Cost scales with tokens + tool calls; estimate early
- Simpler system > clever system
- Start without agents, add only when needed
- Every LLM call is a potential failure point
- If you can't evaluate it, you can't improve it
