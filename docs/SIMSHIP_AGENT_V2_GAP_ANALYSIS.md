# SimShip Agent v2 - Gap Analysis vs Design
## What's Missing Based on 3 Deliverables

**Analysis Date:** January 26, 2026  
**Last Updated:** January 27, 2026  
**Agent:** SimShip Digital Asset Finder (43954037-60f7-f011-8406-7ced8d04f302)  
**Status:** Provisioned & Active (Deliverable 2 In Progress)  

---

## Executive Summary

Your Copilot Studio agent is **partially implemented** with active remediation underway:
- ✅ Agent created and provisioned
- ✅ Connection to Dataverse
- ✅ Deliverable 2 framework complete (80% - flow built, topic in progress)
- ⏳ Deliverable 2 topic creation in progress
- ❌ Deliverable 1 & 3 not yet started

**Progress Update:** Deliverable 2 (Capture Reuse & Savings) has completed:
1. **Power Automate Flow** - ✅ COMPLETE (Log Asset Reuse flow created & added to solution)
2. **Copilot Topic** - ⏳ IN PROGRESS (Schema ready, UI creation started)
3. **Testing Framework** - ✅ READY (7 comprehensive test cases documented)

**Core Deliverables Status:**
1. **Surface Content Sources** - 30-40% done (search exists, but missing rich context)
2. **Capture Reuse & Savings** - 75% done (flow complete, topic in progress, tests ready)
3. **Generate Reports** - 0% done (queued after D2 completion)

---

## DELIVERABLE 1: Surface Content Sources

### Current State (What Works)
```
✅ Agent listens for queries
✅ Dataverse connection active
✅ Digital Assets table accessible
✅ Basic search by keywords
✅ Returns asset title, type, owner
```

### Missing Pieces (What Doesn't Work)
```
❌ Fuzzy/semantic search (only exact matches now)
❌ Filter by content type (PDF, lab, slide, video)
❌ Filter by complexity level (beginner, intermediate, advanced)
❌ Filter by audience/target group
❌ Return granular sections (pages 12-18, slides 3-5, time ranges)
❌ Show multiple similar assets (dedup variants)
❌ Direct SharePoint/source links not working
❌ Rich formatting of results (cards with metadata)
❌ Owner phone number missing
❌ Owner department missing
❌ Escalation contact (manager email)
```

### Design Requirements (from PRIORITY_FEATURES_AND_TEST_CASES.md)

**User Story:**
```
"I'm building a new M365 course. What existing content can I reuse 
on collaboration, document management, and Teams?"
```

**Expected Response:**
```
3-5 relevant assets with:
├─ Title
├─ Content type (PDF/Lab/Slide/Video)
├─ Owner name + email + phone
├─ Department
├─ Description
├─ Specific reusable sections (pages/slides/time)
├─ Source repository (Sales Skilling vs Learning Labs)
├─ Direct link to SharePoint
├─ Complexity level
├─ Learning objectives
└─ Time to retrieve: <2 seconds
```

### Required Dataverse Fields to Surface

**From Digital Assets table (new_DigitalAssets):**
```
- id (GUID)
- title ✅ (implemented)
- description ✅ (implemented)
- content_type ❌ (missing: PDF/Lab/Slide/Video)
- owner_name ✅ (implemented)
- owner_email ✅ (implemented)
- owner_phone ❌ (missing)
- owner_department ❌ (missing)
- owner_manager_email ❌ (missing)
- target_audience ❌ (missing)
- complexity_level ❌ (missing: beginner/intermediate/advanced)
- learning_objectives ❌ (missing: array of strings)
- tags ❌ (missing: keyword array)
- sharepoint_url ✅ (implemented but not displayed richly)
- source_location ❌ (missing: Sales Skilling vs Learning Labs)
- section_start ❌ (missing: page/slide number)
- section_end ❌ (missing: page/slide number)
- similar_versions_count ❌ (missing: count of duplicates)
- hash_group_id ❌ (missing: dedup group ID)
- created_date ❌ (missing: ISO date)
```

### Recommended Copilot Studio Changes

1. **Add Rich Response Card:**
   ```
   Modify "Format Results" node to show card layout:
   
   ┌─────────────────────────────────┐
   │ 📄 Azure Fundamentals (PDF)     │
   │ Owner: Sarah Chen               │
   │ 📧 sarah.chen@microsoft.com    │
   │ 📞 +1-425-555-0123             │
   │ 🏢 Learning & Development       │
   │ ⏱️ Complexity: Beginner         │
   │ 📝 Pages 12-18 (Teams overview) │
   │ 🔗 [Open in SharePoint]         │
   │ 👥 Similar versions: 2          │
   └─────────────────────────────────┘
   ```

2. **Add Filter Branch:**
   ```
   After user query, ask:
   "Filter by content type?"
   Options: PDF | Lab | Slide | Video | All
   ```

3. **Add Topic: "Search with Filters"**
   - Trigger: "Find [type] content about [topic]"
   - Filter by type, complexity, audience
   - Return top 5 with highest similarity

4. **Implement Dedup Display:**
   - Show canonical asset prominently
   - Show variant count: "2 similar versions available"
   - Allow user to "View variants"

---

## DELIVERABLE 2: Capture Reuse & Savings

### Current State
```
✅ Power Automate Flow "Log Asset Reuse" - COMPLETE
   ├─ 9 inputs (AssetTitle, HoursSaved, HourlyRate, etc.)
   ├─ 3 variables (CostAvoided, TotalHoursSaved, Timestamp)
   ├─ Cost calculation (Hours × Rate)
   ├─ Learner impact calculation (Hours × Learners)
   ├─ Dataverse record creation (cr846_contentsreuselog)
   ├─ Success/error responses
   └─ Added to DigitalAssetFinder_v2 solution

✅ Dataverse Tables Enhanced - COMPLETE
   ├─ Digital Assets: 9 new fields added (ownerphone, ownerdepartment, targetaudience, etc.)
   ├─ Content Reuse Log: 5 new fields added (useremail, userdepartment, hourlyrate, etc.)
   ├─ Customizations.xml updated with all field definitions
   └─ All 13 fields in ContentReuseLog now populated

✅ Sample Data Created - COMPLETE
   ├─ 11 Digital Assets records with full field population
   ├─ 15 Content Reuse Log records with cost calculations
   ├─ CSV files ready for import testing
   └─ Realistic scenarios (onboarding, training, workshops)

✅ Build Guides & Documentation - COMPLETE
   ├─ Power Automate flow build guide (8 steps)
   ├─ Copilot Studio topic integration guide (10 steps)
   ├─ Complete testing framework (7 test cases)
   ├─ Sample JSON definitions for flow and topic
   └─ Troubleshooting guides

⏳ Copilot Studio Topic "Log Asset Reuse" - IN PROGRESS
   ├─ Trigger phrases defined
   ├─ 5-question conversation flow designed
   ├─ Power Automate flow integration mapped
   ├─ Success/error messaging prepared
   └─ Ready for UI creation (15-20 minutes)

⏳ Testing - READY TO EXECUTE (7 test cases)
   ├─ Test 2.1: Basic reuse capture
   ├─ Test 2.2: Cost calculation accuracy
   ├─ Test 2.3: Dataverse record creation
   ├─ Test 2.4: User attribution
   ├─ Test 2.5: Learner impact multiplier
   ├─ Test 2.6: Multiple reuses in sequence
   └─ Test 2.7: Confirmation message display
```

**Progress:** 75% Complete (Flow built, topic UI pending, tests ready)

### Design Requirements (from PRIORITY_FEATURES_AND_TEST_CASES.md)

**User Journey:**
```
Step 1: Agent finds content (Deliverable 1) ✅
Step 2: User says "Yes, I'll use this" ❌ (missing)
Step 3: Agent asks follow-up questions ❌ (missing)
  ├─ "How many hours would you have spent creating this?"
  ├─ "How many people will use this in your course?"
  └─ "What's your hourly rate?" (or pick: Junior/Mid/Senior)
Step 4: Agent calculates & logs savings ❌ (missing)
  ├─ Cost Avoided = hours × rate
  ├─ Store in Dataverse
  └─ Link to original asset
Step 5: Confirmation message ❌ (missing)
  └─ "Great! You've saved X hours and $Y"
```

### Required Dataverse Table (NEW)

**Table Name:** `cr846_ContentReuseLog` (or `new_ContentReuseLogs`)

```
Columns needed:
├─ cr846_ContentReuseLogId (Primary Key)
├─ cr846_DigitalAssetId (Lookup to Digital Assets)
├─ cr846_UserId (Lookup to SystemUser)
├─ cr846_UserEmail (Text - captured from user)
├─ cr846_UserDepartment (Text)
├─ cr846_DateReused (DateTime)
├─ cr846_HoursSaved (Decimal)
├─ cr846_HourlyRate (Decimal)
├─ cr846_CostAvoided (Calculated: HoursSaved × HourlyRate)
├─ cr846_Context (Text - why they reused it)
├─ cr846_LearnersImpacted (Integer)
├─ cr846_ReuseCount (Integer - tracking multiple uses)
├─ cr846_SourceAssetTitle (Text - denormalized for reports)
├─ cr846_SourceAssetOwner (Text)
├─ cr846_ManagerApproved (Yes/No - optional audit trail)
└─ StateCode/StatusCode (Active/Inactive)
```

### Required Copilot Studio Topic: "Log Content Reuse"

**Topic Name:** `Log Reuse`  
**Trigger Phrases:**
```
- I'm using this
- Yes, I'll reuse this
- Log this reuse
- I'm reusing [asset name]
- Track this usage
- Save time entry
```

**Conversation Flow:**

```
User: "I'm using Azure Fundamentals"
       ↓
Agent: "Great! Let me capture this reuse.
        First, how many hours would you have spent 
        creating this content from scratch?"
       ↓
User: "8 hours"
       ↓
Agent: "And what's your hourly rate?
        Junior L&D Designer ($100/hr)
        Mid-level L&D Designer ($150/hr)
        Senior L&D Designer ($200/hr)"
       ↓
User: "Senior ($200/hr)"
       ↓
Agent: "Perfect! You're saving 8 hours × $200 = $1,600.
        
        How many learners will use this content?"
       ↓
User: "50 learners"
       ↓
Agent: "Fantastic! Here's what you're saving:
        
        💰 Direct Cost Avoided: $1,600 (8 hours × $200)
        
        If each of 50 learners saves 30 min finding/adapting:
        📊 Additional impact: 25 hours × $200 = $5,000
        
        Total value created: $6,600
        
        ✅ Logged to Dataverse
        ✅ You can find this in your reuse report"
       ↓
System: [Store in Content Reuse Log table]
```

### Required Copilot Studio Actions

1. **Create Topic "Log Reuse"** with nodes:
   - Message: "Let me capture this reuse"
   - Collect input: Hours saved
   - Present options: Hourly rate picker
   - Collect input: Number of learners (optional)
   - **Action node: Call Power Automate Flow** → Create log entry
   - Message: Confirmation with calculated savings
   - Message: Link to reports dashboard

2. **Create Power Automate Flow: "Log Asset Reuse"**
   ```
   Trigger: Copilot Studio action call
   
   Inputs:
   - AssetId (GUID)
   - AssetTitle (string)
   - HoursSaved (number)
   - HourlyRate (number)
   - LearnersCount (number)
   - UserEmail (string from user context)
   
   Actions:
   1. Create row in Content Reuse Log table
      ├─ DigitalAssetId = AssetId
      ├─ UserEmail = User's email
      ├─ DateReused = Today
      ├─ HoursSaved = Input hours
      ├─ HourlyRate = Input rate
      ├─ CostAvoided = HoursSaved × HourlyRate
      ├─ LearnersImpacted = Learners count
      ├─ Context = [captured from user]
      └─ SourceAssetTitle = AssetTitle
   
   2. Send HTTP response back to Copilot
      ├─ Success = true
      ├─ LogId = Created record ID
      ├─ CostAvoided = Calculated amount
      └─ Message = "Saved successfully"
   ```

---

## DELIVERABLE 3: Generate Reports

### Current State
```
❌ NO reporting dashboard exists
❌ NO aggregation of reuse data
❌ NO ROI calculations
❌ NO visualizations (charts/tables)
❌ NO export functionality
```

### Design Requirements (from PRIORITY_FEATURES_AND_TEST_CASES.md)

**Report Should Show:**

```
SIMSHIP CONTENT REUSE REPORT
Period: January 2026

Key Metrics:
├─ Total Assets Reused: 47
├─ Total Hours Saved: 156 hours
├─ Total Cost Avoided: $23,400
├─ Average Time to Reuse: 4 minutes
├─ Users Participating: 12
└─ Teams Benefiting: 4

Top Reused Assets:
1. Azure Fundamentals (PDF)
   - Reused 8 times
   - 48 hours saved
   - $7,200 cost avoided
   - Owner: Sarah Chen

2. Teams Administration Lab
   - Reused 6 times
   - 36 hours saved
   - $5,400 cost avoided
   - Owner: John Smith

3. M365 Security Best Practices
   - Reused 5 times
   - 30 hours saved
   - $4,500 cost avoided
   - Owner: Jane Wilson

ROI Analysis:
├─ Content Creation Investment: ~40 hours
├─ Agent Development: ~80 hours
├─ Total Investment: 120 hours ($18,000)
├─ First Month Benefit: $23,400 (156 hours)
└─ Net Benefit Month 1: $5,400 ✅

Visualizations:
├─ Chart 1: Hours Saved by Team (bar chart)
├─ Chart 2: Cost Avoided by Week (line chart)
├─ Chart 3: Asset Reuse Frequency (ranking)
└─ Chart 4: Time to Reuse Distribution (histogram)
```

### Required: Build Power BI or Power Apps Report

**Option A: Power BI Dashboard** (Recommended - More powerful)
```
Data Source: Dataverse (Content Reuse Log + Digital Assets join)

Pages/Reports:
1. Executive Summary
   - KPIs (Total saved, hours, users)
   - Top 5 assets
   - ROI calculation

2. Asset Details
   - Filter by asset owner
   - Filter by date range
   - Reuse count × cost

3. Team Performance
   - Group by department
   - Savings by team
   - Participation metrics

4. Trends
   - Weekly savings curve
   - Adoption rate
   - Most-used asset types
```

**Option B: Power Apps Model-Driven App**
```
Entity: Content Reuse Log
Views:
- All Reuses (list)
- By Asset (grouped)
- By Team (grouped)
- By Week (timeline)

Dashboards:
- Summary (KPIs + charts)
- Trending (line charts)
- ROI (calculated column)
```

### Required: Add Reporting Topic to Agent

**Topic Name:** `View Reuse Report`  
**Trigger Phrases:**
```
- Show me the reuse report
- What's our savings so far
- How much time have we saved
- ROI report
- Reuse statistics
- Cost avoidance summary
```

**Flow:**
```
User: "Show me the reuse report"
       ↓
Agent: "Let me pull your reuse report.
        Filter by:
        - Date range (This week / This month / This quarter)
        - Team (All / Sales / Learning / Product)
        - Asset type (All / PDF / Lab / Video)"
       ↓
User: "This month, all teams"
       ↓
Agent: [Calls Power BI / Power Apps report]
       ↓
Agent: "Here's your report:
        
        📊 Summary
        Total Saved: 156 hours ($23,400)
        Assets Reused: 47
        Users: 12
        
        🏆 Top Assets
        1. Azure Fundamentals (8 reuses, $7,200)
        2. Teams Lab (6 reuses, $5,400)
        ...
        
        📈 Trend
        Week 1: $4,200
        Week 2: $6,800
        Week 3: $7,400
        Week 4: $5,000
        
        [View full report] [Download PDF]"
```

### Copilot Studio + Power Automate Integration

1. **Create Power Automate Flow: "Get Reuse Report"**
   ```
   Trigger: Copilot Studio action
   
   Inputs:
   - DateFrom (date)
   - DateTo (date)
   - FilterTeam (string)
   
   Actions:
   1. List rows in Content Reuse Log
      Filter: DateReused between DateFrom & DateTo
      AND Team = FilterTeam
   
   2. Apply transformation to group by asset
   3. Create summary objects
      - Total cost = Sum(CostAvoided)
      - Total hours = Sum(HoursSaved)
      - Unique assets = Count distinct
      - User count = Count distinct users
   
   4. Create top 5 list (ordered by reuse count)
   5. Return JSON to Copilot with all metrics
   ```

2. **Link to Power BI/Power Apps:**
   ```
   In Copilot Studio message:
   "🔗 [View Full Report in Power BI]"
   Link to: https://app.powerbi.com/...
   or Power Apps: https://apps.powerapps.com/...
   ```

---

## Implementation Priorities

### Priority 1 (ACTIVE): Deliverable 2 - Complete Topic & Testing
**Status:** 75% complete, on schedule for January 27, 2026

```
[✅] Create Power Automate Flow "Log Asset Reuse"
    ├─ Accept 9 inputs (AssetTitle, HoursSaved, HourlyRate, etc.)
    ├─ Calculate cost avoided (Hours × Rate)
    ├─ Calculate learner impact (Hours × Learners)
    ├─ Store in Dataverse cr846_contentsreuselog
    ├─ Return success response with Log ID
    └─ Added to DigitalAssetFinder_v2 solution

[✅] Enhance Dataverse Tables
    ├─ Digital Assets: Added 9 fields (phone, department, audience, complexity, etc.)
    ├─ Content Reuse Log: Added 5 fields (email, department, hourlyrate, etc.)
    ├─ Updated customizations.xml with all definitions
    └─ Created sample data (11 assets, 15 reuse logs)

[⏳] Create Copilot Studio Topic "Log Asset Reuse" (15-20 minutes)
    ├─ Add trigger phrases (log reuse, I'm using, etc.)
    ├─ Build 5-question conversation flow
    ├─ Map Power Automate flow integration
    ├─ Add success messaging
    └─ Publish and test

[⏳] Execute 7 Test Cases (15-20 minutes)
    ├─ Test 2.1-2.7 from DELIVERABLE_2_TESTING_GUIDE.md
    ├─ Verify cost calculations
    ├─ Verify Dataverse record creation
    ├─ Verify success messages
    └─ Log results

**Next Step:** Create topic in Copilot Studio UI (15 minutes)
```

### Priority 2 (QUEUED): Deliverable 1 - Surface Content Sources
**Status:** 30-40% complete, starting after D2

```
[ ] Update Digital Assets table with missing fields:
    ├─ content_type (enum: PDF/Lab/Slide/Video)
    ├─ target_audience (multi-select)
    ├─ section_start/section_end
    └─ similar_versions_count, hash_group_id

[ ] Update Copilot Studio agent:
    ├─ Create "Search with Filters" topic
    ├─ Add filter branches (by type, level, audience)
    ├─ Update result cards with rich metadata
    ├─ Add variant/dedup display
    ├─ Test with 10 sample queries
    └─ Performance check (<2 seconds)

**Estimated Time:** 90-120 minutes
```

### Priority 3 (QUEUED): Deliverable 3 - Generate Reports
**Status:** 0% complete, starting after D1 & D2

```
[ ] Create Power BI or Power Apps report
    ├─ Connect to Content Reuse Log
    ├─ Build executive summary (KPIs)
    ├─ Add top assets ranking
    ├─ Add ROI calculation
    └─ Add visualizations (charts, trends)

[ ] Create Power Automate Flow: "Get Reuse Report"
    ├─ Query Content Reuse Log
    ├─ Aggregate by asset/team/date
    ├─ Calculate totals
    └─ Format for display

[ ] Update Copilot Studio agent:
    ├─ Create "View Report" topic
    ├─ Add filter options (date/team)
    ├─ Call report flow
    ├─ Display results with link to full report
    └─ Test with sample data
```

**Estimated Time:** 120-150 minutes

[ ] Update Copilot Studio agent:
    ├─ Create "View Report" topic
    ├─ Add filter options (date/team)
    ├─ Call report flow
    ├─ Display results with link to full report
    └─ Test with sample data
```

---

## Testing Checklist (from AGENT_TESTING_CHECKLIST.md)

### Deliverable 1 Tests (8 cases)
- [ ] DISC-001: Basic keyword search
- [ ] DISC-002: Multiple keyword search
- [ ] DISC-003: No results found
- [ ] DISC-004: Asset type filtering
- [ ] DISC-005: Complexity level filtering
- [ ] DISC-006: Multiple similar assets shown
- [ ] DISC-007: Owner contact info displayed
- [ ] DISC-008: Search latency <2 seconds

### Deliverable 2 Tests (7 cases)
- [ ] REUSE-001: Capture single asset reuse
- [ ] REUSE-002: Calculate cost avoided correctly
- [ ] REUSE-003: Log to Dataverse successfully
- [ ] REUSE-004: Multiple assets in one session
- [ ] REUSE-005: User attribution working
- [ ] REUSE-006: Learner multiplier calculation
- [ ] REUSE-007: Department/team tracking

### Deliverable 3 Tests (6 cases)
- [ ] REPORT-001: View monthly summary
- [ ] REPORT-002: Filter by team
- [ ] REPORT-003: Filter by date range
- [ ] REPORT-004: Top assets ranking correct
- [ ] REPORT-005: ROI calculation accurate
- [ ] REPORT-006: Export to PDF

---

## Quick Reference: What to Build Next

| Deliverable | What | Where | Est. Hours |
|---|---|---|---|
| 1 | Add filter fields | Digital Assets table | 4 |
| 1 | Update search topic | Copilot Studio | 8 |
| 1 | Design result cards | Copilot Studio | 6 |
| 2 | Create reuse log table | Dataverse | 4 |
| 2 | Build capture flow | Power Automate | 8 |
| 2 | Add log topic | Copilot Studio | 8 |
| 3 | Build report dashboard | Power BI/Apps | 12 |
| 3 | Query flow | Power Automate | 6 |
| 3 | Add report topic | Copilot Studio | 6 |
| Test | Full E2E validation | All components | 12 |

**Total Effort:** ~74 hours (roughly 2-3 weeks with parallel work)

---

## Key Success Metrics (Simon's Requirements)

✅ **Deliverable 1:** Agent finds relevant content in <2 seconds, shows owner contact info  
✅ **Deliverable 2:** Captures reuse decision + hours/cost, stores in Dataverse with audit trail  
✅ **Deliverable 3:** Executive dashboard shows ROI ($$ saved, hours saved, top assets, trends)

All three must work together in **single coherent conversation flow**.
