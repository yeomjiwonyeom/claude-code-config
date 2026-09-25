---
name: agent-system-design
description: Design or review RAG and agent systems with explicit reliability, evaluation, latency, cost, security, and operational tradeoffs.
---

# Agent System Design

Design the simplest system that meets the stated requirements.

Clarify the user task, data sources, freshness, latency, quality target, volume, budget, security boundary, and failure tolerance. Separate responsibilities among deterministic application code, retrieval or action tools, the model, and guardrails.

Choose an agent loop only when a simpler workflow is insufficient. For retrieval, define indexing, chunking, filters, reranking, citations, access control, and freshness. For tools, require bounded inputs and outputs, clear errors, timeouts, idempotency where possible, and least privilege.

Include a compact architecture, key tradeoffs, failure handling, observability, and an evaluation plan with representative examples and explicit pass criteria. Do not prescribe fixed parameter values without workload evidence or imply proposed tests were completed.
