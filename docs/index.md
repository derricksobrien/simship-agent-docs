# SimShip Content Reuse Agent v2 Documentation

Welcome to the comprehensive documentation for **SimShip** – a semantic search and content deduplication platform for discovering reusable learning content across SharePoint, Power Platform, and enterprise data sources.

## Quick Navigation

### 🚀 **New to SimShip?**
Start here: [**SIMSHIP_AGENT_V2_START_HERE.md**](SIMSHIP_AGENT_V2_START_HERE.md)

### 📊 **Executive Summary**
- **Status Report**: [SIMSHIP_AGENT_V2_STATUS.md](SIMSHIP_AGENT_V2_STATUS.md) – For leadership and project stakeholders
- **Delivery Summary**: [SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md](SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md) – What's been delivered

### 🔍 **Technical Deep Dive**
- **Gap Analysis**: [SIMSHIP_AGENT_V2_GAP_ANALYSIS.md](SIMSHIP_AGENT_V2_GAP_ANALYSIS.md) – What's missing and why
- **Analysis & Overview**: [SIMSHIP_AGENT_V2_ANALYSIS_README.md](SIMSHIP_AGENT_V2_ANALYSIS_README.md) – Technical context

### ✅ **Build & Execution**
- **Implementation Checklist**: [SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md](SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md) – Day-by-day build plan
- **Feature Matrix**: [SIMSHIP_AGENT_V2_FEATURE_MATRIX.md](SIMSHIP_AGENT_V2_FEATURE_MATRIX.md) – Progress tracking

---

## What is SimShip?

A **semantic search and content deduplication platform** that:

- ✅ Extracts learning content from multiple sources (Excel, Dataverse, Power Platform)
- ✅ Deduplicates using hash, embedding, and metadata analysis
- ✅ Enables fast semantic search with precise citations
- ✅ Tracks content reuse and savings across enterprises
- ✅ Powers a Copilot Studio agent for discovery and logging

### Core Architecture
**Extract → Deduplicate → Embed → Store → Search**

---

## Documentation Structure

| Document | Purpose | Audience |
|----------|---------|----------|
| [START_HERE](SIMSHIP_AGENT_V2_START_HERE.md) | Orientation guide | Everyone |
| [STATUS](SIMSHIP_AGENT_V2_STATUS.md) | Executive summary | Leadership, Stakeholders |
| [ANALYSIS](SIMSHIP_AGENT_V2_ANALYSIS_README.md) | Technical overview | Developers |
| [GAP_ANALYSIS](SIMSHIP_AGENT_V2_GAP_ANALYSIS.md) | Detailed gaps & solutions | Technical leads |
| [CHECKLIST](SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md) | Daily build tasks | Development team |
| [FEATURE_MATRIX](SIMSHIP_AGENT_V2_FEATURE_MATRIX.md) | Progress metrics | Project managers |
| [DELIVERY](SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md) | What's been built | Stakeholders |

---

## Getting Started

### For Developers
1. Read [SIMSHIP_AGENT_V2_ANALYSIS_README.md](SIMSHIP_AGENT_V2_ANALYSIS_README.md)
2. Review [SIMSHIP_AGENT_V2_GAP_ANALYSIS.md](SIMSHIP_AGENT_V2_GAP_ANALYSIS.md)
3. Follow [SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md](SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md)

### For Project Managers
1. Start with [SIMSHIP_AGENT_V2_STATUS.md](SIMSHIP_AGENT_V2_STATUS.md)
2. Track progress using [SIMSHIP_AGENT_V2_FEATURE_MATRIX.md](SIMSHIP_AGENT_V2_FEATURE_MATRIX.md)
3. Review [SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md](SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md)

### For Stakeholders
1. Review [SIMSHIP_AGENT_V2_STATUS.md](SIMSHIP_AGENT_V2_STATUS.md)
2. Check [SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md](SIMSHIP_AGENT_V2_DELIVERY_SUMMARY.md)

---

## Key Concepts

### Lowest Common Unit of Reuse (LCUR)
The smallest independently reusable content chunk:
- Learning modules, slides, assessment questions
- Code examples, use cases, video segments
- Graphics and reference materials

Each LCUR tracks: owner, access level, complexity, learning objectives, and creation date.

### Three-Tier Deduplication
1. **Hash-based**: Exact text matches
2. **Embedding-based**: Semantic similarity (cosine distance)
3. **Metadata-based**: Unit type + target audience + learning objectives

### SourcePosition Tracking
Pinpoint exact content location:
- **Excel**: Sheet name, row, column
- **Dataverse**: Entity name, record ID, field name
- **Documents**: Line start/end

---

## Project Status

**Phase 3 (Configuration)** – Setting up Dataverse tables and sample data

✅ Complete:
- Architecture designed
- Python agents built (local + Azure versions)
- Power Platform solution scaffolded
- 900+ pages of documentation

🟡 In Progress:
- Copilot Studio agent configuration
- Table creation and data import
- Testing and validation

---

## Questions?

Refer to the specific document for your role (see table above), or start with [SIMSHIP_AGENT_V2_START_HERE.md](SIMSHIP_AGENT_V2_START_HERE.md).

---

*Last Updated: January 27, 2026*
