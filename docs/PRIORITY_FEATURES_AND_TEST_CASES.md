# SimShip Agent - Priority Features & Test Cases
## Based on Meeting Notes (Jan 13 & 16, 2026)

**Analysis Date:** January 21, 2026  
**Source:** Simon's Deliverables + Darin's Technical Constraints  
**Status:** Aligned with actual project requirements

---

## Executive Summary

The meeting notes reveal the **actual priorities** are different from the initial vision. Here's what matters:

### Simon's 3 Core Deliverables (PRIORITY ORDER)

1. **TIER 1 (Critical):** Surface Content Sources
   - Find & display reusable assets (slides, PDFs, labs, videos)
   - Direct access to original sources
   - Answer: "What content exists on topic X?"

2. **TIER 2 (Important):** Capture Reuse & Savings
   - Track WHEN content is reused
   - Ask users "How much time did you save?"
   - Quantify cost avoidance

3. **TIER 3 (Report):** Generate Savings Reports
   - Dollar-value ROI
   - Hours saved aggregates
   - Leadership dashboards

### Darin's Technical Constraints (HARD BOUNDARIES)

✅ **APPROVED:**
- Copilot Studio (primary agent framework)
- Power Platform (connectors, data flows)
- SharePoint (document repository)
- Dataverse (structured metadata)

❌ **AVOID:**
- Azure resources (hard no - "creates compliance layers")
- Code deployment (unless absolutely necessary)
- Local replicas (keep live sources only)
- Repository migrations (scan-in-place instead)

### Key Insight from Meeting
> "The agent needs to read STRUCTURED DATA... we have the solution in place... don't waste time on unstructured stuff."

**Translation:** Darin's Power Platform solution is already scanning files and creating metadata. The agent should **consume that metadata**, not reinvent the wheel.

---

## Technology Stack (NO AZURE)

### Recommended Architecture

```
┌─────────────────────────────────────────┐
│   Copilot Studio                        │
│   (Agent Logic & Chat Interface)        │
└────────────┬────────────────────────────┘
             │
             ├─────────────────┬────────────────┐
             │                 │                │
             ▼                 ▼                ▼
        ┌──────────┐    ┌──────────────┐  ┌──────────┐
        │ Power    │    │ Dataverse    │  │SharePoint│
        │Platform  │    │ Tables       │  │Connector │
        │Connector │    │ (Metadata)   │  │          │
        │          │    │              │  │          │
        │• Scans   │    │• Structured  │  │• Digital │
        │• Queries │    │• Asset Info  │  │  Asset   │
        │• Flows   │    │• Reuse Log   │  │  Repo    │
        └──────────┘    └──────────────┘  └──────────┘
```

### Technology Breakdown

| Component | Technology | Purpose | Notes |
|-----------|-----------|---------|-------|
| **Agent Engine** | Copilot Studio | Conversational interface | No code needed |
| **Data Access** | Power Platform Connector | Query Dataverse tables | Existing flows |
| **Metadata Store** | Dataverse | Structured asset info | Already scanning |
| **Document Source** | SharePoint | Live documents | No copying |
| **Reuse Tracking** | Dataverse table + Power Automate | Log user reuse | New flow needed |
| **Reporting** | Power BI or Power Apps | Visualize savings | Consume Dataverse |
| **Approval/Compliance** | Built-in Power Platform RBAC | Access control | No new layer |

### Why This Stack

✅ **No Azure** - Everything stays in Power Platform  
✅ **Uses existing infra** - Darin's scanning solution already in place  
✅ **Low code** - Copilot Studio handles chat logic  
✅ **Compliance-friendly** - Already approved by Microsoft  
✅ **Minimal maintenance** - Darin's team owns it  

---

## Simon's 3 Deliverables - Detailed Breakdown

### DELIVERABLE 1: Surface Content Sources

**What the user asks:**
```
"I'm building a new M365 course. What existing content can I reuse on collaboration, 
document management, and Teams?"
```

**What the agent returns:**
```
Sources Found:
┌─ Microsoft 365 Collaboration Essentials (PDF, 45 pages)
│  Source: Sales Skilling SharePoint
│  Owner: Sarah Chen (sarah.chen@microsoft.com)
│  Description: Overview of Teams, OneDrive, SharePoint
│  Specific reusable section: Pages 12-18 (Teams overview)
│  │
├─ Teams Administration Lab (hands-on)
│  Source: Learning Labs
│  Owner: John Smith (john.smith@microsoft.com)
│  Description: Step-by-step Teams deployment guide
│  Duration: 90 minutes
│  │
└─ OneDrive Best Practices (Slide Deck, 25 slides)
   Source: Digital Asset Repository
   Owner: Jane Wilson (jane.wilson@microsoft.com)
   Description: File management and sharing in OneDrive
   Specific reusable section: Slides 8-15 (sharing policies)
   Direct URL: [Link to SharePoint]
```

**What needs to work:**
- [ ] Query Dataverse for assets matching keywords (M365, collaboration, Teams)
- [ ] Filter by content type (PDF, lab, slides, video)
- [ ] Show owner contact info
- [ ] Provide direct links to source documents
- [ ] Highlight granular reusable pieces (pages/slides/time ranges)
- [ ] Indicate source location (Sales Skilling vs Digital Asset Repo)

**Data Source:**
- Power Platform solution's Digital Asset Table (already scanned by Darin's solution)

**Test Case 1A:**
```
INPUT: "Find content about Azure security I can add to a new course"
EXPECTED OUTPUT:
- 3-5 relevant assets
- Each with owner name + email
- Clear description of what's reusable
- Direct link to source
- Time to get result: <2 seconds
```

---

### DELIVERABLE 2: Capture Reuse & Savings

**User Journey:**

```
Step 1: Agent finds content (Deliverable 1)
Step 2: User says "Yes, I'll use this"
Step 3: Agent asks follow-up questions
  ├─ "How many hours would you have spent creating this?"
  ├─ "How many people will use this in your course?"
  └─ "What's the hourly rate for your team?"
Step 4: Agent calculates & logs savings
  └─ Hours Saved: 8
  └─ Cost Avoided: $1,200 (8 hrs × $150/hr)
Step 5: Data stored in Dataverse for reporting
```

**What the agent captures in Dataverse:**
```
Reuse Log Entry:
├─ Source Asset ID: [GUID]
├─ Source Title: "Azure Security Best Practices"
├─ User Who Reused: jane.doe@microsoft.com
├─ Date of Reuse: 2026-01-21
├─ Hours Saved: 8
├─ Cost Avoided: $1,200
├─ Context: "Added to new M365 security course"
├─ Team/Department: "Learning & Development"
└─ Timestamp: 2026-01-21T14:32:00Z
```

**What needs to work:**
- [ ] Agent asks for time/cost inputs after finding content
- [ ] Calculate total cost avoided (hours × rate)
- [ ] Store in Dataverse table with audit trail
- [ ] Link back to original asset
- [ ] Attribution to user/team
- [ ] Support bulk logging (user reusing multiple assets)

**Data Store:**
- New Dataverse table: "Content Reuse Log"
- Fields: asset_id, user_email, hours_saved, cost_avoided, date, context

**Test Case 2A:**
```
INPUT: 
  User finds "Azure Fundamentals" slide deck (8 slides)
  User action: "I'm using slides 3-5"
  Hours saved: 6
  Hourly rate: $150
  
EXPECTED OUTPUT:
  ✓ System logs reuse
  ✓ Calculation: 6 × $150 = $900 cost avoided
  ✓ Dataverse entry created with timestamp
  ✓ Confirmation: "Great! You've saved 6 hours and $900"
```

**Test Case 2B:**
```
INPUT:
  User reusing 3 assets in same session
  Asset 1: 8 hours
  Asset 2: 4 hours
  Asset 3: 2 hours
  
EXPECTED OUTPUT:
  ✓ Total: 14 hours, $2,100 cost avoided
  ✓ All 3 reuse entries in Dataverse
  ✓ Linked to user's department
```

---

### DELIVERABLE 3: Generate Savings Reports

**Executive Dashboard Report:**

```
SIMSHIP CONTENT REUSE REPORT
Period: January 2026

Key Metrics:
├─ Total Assets Reused: 47
├─ Total Hours Saved: 156 hours
├─ Total Cost Avoided: $23,400
├─ Average Time to Reuse: 4 minutes (from discovery to usage)
├─ Users Participating: 12
└─ Teams Benefiting: 4 (L&D, Sales Enablement, Product Training, IT)

Top Reused Content:
1. "Azure Fundamentals" (PDF)
   - Reused 8 times
   - 48 hours saved
   - $7,200 cost avoided
   - Owner: Sarah Chen

2. "Teams Administration Lab"
   - Reused 6 times
   - 36 hours saved
   - $5,400 cost avoided
   - Owner: John Smith

3. "M365 Security Best Practices"
   - Reused 5 times
   - 30 hours saved
   - $4,500 cost avoided
   - Owner: Jane Wilson

ROI Analysis:
├─ Content Created (Darin's scanning): ~40 hours investment
├─ Cost to Create Agent: ~80 hours
├─ Total Investment: 120 hours ($18,000)
├─ Benefit in First Month: $23,400 (156 hours saved)
└─ Net Benefit: $5,400 in Month 1 (and growing)

Chart 1: Hours Saved by Team
Chart 2: Cost Avoided by Week
Chart 3: Asset Reuse Frequency
Chart 4: Time from Discovery to Reuse (histogram)
```

**What needs to work:**
- [ ] Aggregate reuse data by asset
- [ ] Sum hours & cost by user/team/timeframe
- [ ] Rank assets by reuse count
- [ ] Calculate ROI (benefit - investment cost)
- [ ] Create visualizations (charts, tables)
- [ ] Filter by date range, team, asset type
- [ ] Export to PDF for leadership

**Data Source:**
- Query Dataverse "Content Reuse Log" table
- Join with "Digital Asset" table for context

**Test Case 3A:**
```
INPUT: 
  Report request for "Last 30 days, by team"
  
EXPECTED OUTPUT:
  ✓ Report with:
    - Total hours saved: 156
    - Total cost avoided: $23,400
    - Breakdown by team
    - Top 5 assets
    - Charts showing trends
    - Generated in <5 seconds
```

**Test Case 3B:**
```
INPUT: 
  Report request for "Assets reused more than 3 times"
  
EXPECTED OUTPUT:
  ✓ List of high-value assets
  ✓ Reuse count per asset
  ✓ Total hours/cost per asset
  ✓ Owner contact info
  ✓ Suggestion: "Consider these assets for broader promotion"
```

---

## Test Data & Sample Scenarios

### Sample Asset Repository (Dataverse)

```json
{
  "assets": [
    {
      "id": "asset-001",
      "title": "Azure Fundamentals",
      "type": "pdf",
      "pages": 45,
      "owner_email": "sarah.chen@microsoft.com",
      "source": "Digital Asset Repository",
      "description": "Complete intro to Azure services",
      "keywords": ["azure", "cloud", "fundamentals"],
      "reusable_sections": [
        {
          "description": "Compute services overview",
          "pages": "12-18"
        },
        {
          "description": "Storage options",
          "pages": "19-25"
        }
      ]
    },
    {
      "id": "asset-002",
      "title": "Teams Administration Lab",
      "type": "lab",
      "duration_minutes": 90,
      "owner_email": "john.smith@microsoft.com",
      "source": "Learning Labs",
      "description": "Hands-on Teams deployment",
      "keywords": ["teams", "administration", "deployment"]
    },
    {
      "id": "asset-003",
      "title": "OneDrive Best Practices",
      "type": "slides",
      "slides": 25,
      "owner_email": "jane.wilson@microsoft.com",
      "source": "Digital Asset Repository",
      "description": "File management and sharing",
      "keywords": ["onedrive", "sharepoint", "files"],
      "reusable_sections": [
        {
          "description": "Sharing policies",
          "slides": "8-15"
        }
      ]
    }
  ]
}
```

### Test Scenario 1: Content Discovery

**User Input:**
```
Agent: "Hi! I'm building a new M365 security training course. What existing content 
        do you have on security, Teams, and collaboration?"

User: "I need beginner-level content that covers security and Teams collaboration"
```

**Expected Agent Output:**
```
Great! I found 3 relevant assets for your M365 security course:

📄 ASSET 1: Teams Administration Lab
   Type: Hands-on Lab (90 minutes)
   Owner: John Smith (john.smith@microsoft.com)
   Source: Learning Labs
   Description: Step-by-step Teams deployment and security setup
   Why it's relevant: Covers Teams security best practices
   Link: [Direct link to Learning Labs]
   
🎯 ASSET 2: Azure Security Best Practices  
   Type: Slide Deck (25 slides)
   Owner: Sarah Chen (sarah.chen@microsoft.com)
   Source: Digital Asset Repository
   Description: Security fundamentals for Azure and Microsoft 365
   Reusable Sections: Slides 8-15 (Access control and permissions)
   Link: [Direct link to SharePoint]
   
📋 ASSET 3: OneDrive Best Practices
   Type: PDF (45 pages)
   Owner: Jane Wilson (jane.wilson@microsoft.com)
   Source: Digital Asset Repository
   Description: Secure file management in OneDrive
   Reusable Sections: Pages 19-25 (Sharing & permissions)
   Link: [Direct link to SharePoint]

Would you like to:
[ ] Use one of these assets
[ ] Get more details about an asset
[ ] Search for other topics
```

---

### Test Scenario 2: Capture Reuse & Calculate Savings

**User Action:**
```
User clicks "Use Asset 1 - Teams Administration Lab"

Agent: "Great choice! Let me ask a few quick questions:
        1. How many hours would it have taken you to create this lab from scratch?
        2. How many learners will go through this course?
        3. What's your hourly rate? (or pick your level: Junior/Mid/Senior)"

User Input:
  Hours from scratch: 16
  Learners: 50
  Hourly rate: $150/hour (Senior L&D Designer)
```

**Expected System Output:**
```
Perfect! Here's what you're saving:

💰 Cost Analysis:
   Hours saved (you): 16 hours
   Your rate: $150/hour
   Direct cost avoided: $2,400
   
   Multiplier effect (50 learners): 
   If each learner would have spent 1 hour finding/adapting this...
   Additional hours saved: 50 hours
   Additional cost avoided: $7,500
   
   TOTAL: 66 hours saved, $9,900 cost avoided

✅ Logged to reuse tracker
   Entry ID: reuse-log-2026-01-21-001
   Saved to: Content Reuse Log
   Your name: [user_email]
   Date: 2026-01-21
   
Would you like to:
[ ] Log usage of another asset
[ ] View your savings summary
[ ] Share this with your team
```

**Dataverse Table Entry Created:**
```
Content Reuse Log Entry:
{
  "id": "reuse-log-2026-01-21-001",
  "asset_id": "asset-002",
  "asset_title": "Teams Administration Lab",
  "user_email": "instructor@microsoft.com",
  "user_team": "Learning & Development",
  "date_reused": "2026-01-21",
  "hours_saved": 16,
  "cost_avoided": "$2,400",
  "multiplier_effect": {
    "learners": 50,
    "hours_per_learner": 1,
    "total_hours": 50,
    "total_cost": "$7,500"
  },
  "total_impact": {
    "total_hours": 66,
    "total_cost": "$9,900"
  },
  "context": "Added to new M365 security training course",
  "approval_status": "logged",
  "timestamp": "2026-01-21T14:32:00Z"
}
```

---

### Test Scenario 3: Generate Monthly Report

**Leadership Request:**
```
CFO: "I need to see the ROI on the SimShip project. What's the actual cost savings?"

L&D Manager: Pulls SimShip Report for January 2026
```

**Expected Report Output:**

```
═══════════════════════════════════════════════════════════════
  SIMSHIP AGENT - JANUARY 2026 REUSE & SAVINGS REPORT
═══════════════════════════════════════════════════════════════

EXECUTIVE SUMMARY
─────────────────────────────────────────────────────────────
Period:                January 1-31, 2026
Total Content Reused:  12 assets
Reuse Instances:       47 occurrences
Total Hours Saved:     156 hours
Total Cost Avoided:    $23,400
Active Users:          12 L&D designers
Teams Benefiting:      4 teams

COST-BENEFIT ANALYSIS
─────────────────────────────────────────────────────────────
System Development Cost:        $18,000 (120 hours @ $150/hr)
Asset Scanning Setup:           $8,000 (already done by Darin)
Monthly Operations:             $2,000 (Darin's team, 13 hrs)

SUBTOTAL INVESTMENT:            $28,000

Monthly Benefit (Jan):          $23,400 (156 hours @ $150/hr)

MONTH 1 NET:                    -$4,600 (expected - ramping up)

PROJECTED MONTH 3:
  Assuming 150% growth:         $35,100 benefit
  ROI: +124% (system pays for itself)

─────────────────────────────────────────────────────────────

TOP REUSED ASSETS (by hours saved)
─────────────────────────────────────────────────────────────
1. Azure Fundamentals (PDF, 45 pg)
   Reused: 8 times        Hours Saved: 64        Cost: $9,600
   Owner: Sarah Chen      Contact: sarah.chen@microsoft.com

2. Teams Administration Lab (90 min)
   Reused: 6 times        Hours Saved: 36        Cost: $5,400
   Owner: John Smith      Contact: john.smith@microsoft.com

3. M365 Security Best Practices (25 slides)
   Reused: 5 times        Hours Saved: 30        Cost: $4,500
   Owner: Jane Wilson     Contact: jane.wilson@microsoft.com

4. OneDrive File Management (40 slides)
   Reused: 4 times        Hours Saved: 16        Cost: $2,400
   Owner: John Doe        Contact: john.doe@microsoft.com

5. Exchange Administration (PDF, 35 pg)
   Reused: 3 times        Hours Saved: 10        Cost: $1,500
   Owner: Mike Brown      Contact: mike.brown@microsoft.com

─────────────────────────────────────────────────────────────

REUSE BY TEAM
─────────────────────────────────────────────────────────────
Learning & Development:  32 reuses   $12,800 value
Sales Enablement:        10 reuses   $7,500 value
Product Training:         4 reuses   $2,400 value
IT Operations:            1 reuse    $300 value

─────────────────────────────────────────────────────────────

REUSE TIMELINE (Daily Trend)
─────────────────────────────────────────────────────────────
Week 1: 8 reuses         $2,400
Week 2: 12 reuses        $5,600  (40% growth)
Week 3: 15 reuses        $7,800  (25% growth)
Week 4: 12 reuses        $7,600  (slight decline)

OBSERVATIONS:
✓ Growth trajectory is positive
✓ Early adoption from 4 key teams
✓ Content quality appears high (multiple reuses)
! Some week-to-week variation (normal in month 1)

─────────────────────────────────────────────────────────────

RECOMMENDATIONS
─────────────────────────────────────────────────────────────
1. Highlight Azure Fundamentals and Teams Lab as anchor content
   (8 and 6 reuses respectively - promote to other teams)

2. Contact Sarah Chen and John Smith
   (Top contributors - opportunity for expanded collaboration)

3. Expand to 2 more teams in Feb
   (Currently 4 teams; aim for 6 by end of Feb)

4. Promote in all-hands meeting
   (Data shows real ROI; confidence for funding)

═══════════════════════════════════════════════════════════════

Generated: 2026-01-31T17:00:00Z
Next Report: 2026-02-28T17:00:00Z
```

---

## Implementation Roadmap

### Phase 1: Agent MVP (Week 1-2)
**Goal:** Get Deliverable 1 working (Content Discovery)

- [ ] Create Copilot Studio agent
- [ ] Connect to Dataverse connector (read Digital Asset table)
- [ ] Implement search by keyword
- [ ] Show results with owner contact
- [ ] Test with 10 sample queries

### Phase 2: Reuse Capture (Week 3-4)
**Goal:** Get Deliverable 2 working (Capture Savings)

- [ ] Build new "Content Reuse Log" Dataverse table
- [ ] Create Power Automate flow to log reuse
- [ ] Agent asks follow-up questions (hours, rate, context)
- [ ] Calculate and store savings
- [ ] Test with 5 different reuse scenarios

### Phase 3: Reporting (Week 5-6)
**Goal:** Get Deliverable 3 working (Generate Reports)

- [ ] Build Power BI dashboard on Reuse Log data
- [ ] Create summary report
- [ ] Add monthly/weekly filtering
- [ ] Export to PDF capability
- [ ] Test with sample reuse data

### Phase 4: Integration & Handoff (Week 7-8)
**Goal:** Hand off to Microsoft

- [ ] Document architecture (Copilot Studio → Power Platform → SharePoint)
- [ ] Create step-by-step setup guide
- [ ] Package for Microsoft deployment
- [ ] Run through validation tests
- [ ] Handoff documentation

---

## Success Criteria (Validation Checklist)

### Deliverable 1: Content Discovery ✅
- [ ] Agent finds 3+ relevant assets within 2 seconds
- [ ] Owner name and email displayed
- [ ] Direct link to source provided
- [ ] Handles 10+ different keyword searches
- [ ] Works with all asset types (PDF, slides, lab, video transcript)

### Deliverable 2: Reuse Capture ✅
- [ ] Agent asks for hours/cost input
- [ ] Calculates cost avoided correctly
- [ ] Stores in Dataverse with audit trail
- [ ] Handles single and multi-asset reuse
- [ ] User receives confirmation of logged reuse

### Deliverable 3: Reporting ✅
- [ ] Report aggregates data correctly
- [ ] Shows hours saved and cost avoided
- [ ] Ranks assets by reuse frequency
- [ ] Displays team/user breakdowns
- [ ] Generates in <5 seconds
- [ ] Can be exported to PDF

---

## Next Steps

1. **Clarify Data Access:** Get exact Dataverse connection details from Darin
2. **Get Sample Data:** Request 20-30 real assets from Digital Asset Repository
3. **Build Agent Skeleton:** Start with Copilot Studio agent for Deliverable 1
4. **Create Reuse Table:** Design schema for Content Reuse Log
5. **Test & Validate:** Run through all 3 test scenarios above

---

**Status:** Ready to build on Copilot Studio (no Azure needed per Darin's requirement)
