# SimShip Agent v2 - Implementation Checklist
## 3-Week Build Plan to Complete All Deliverables

**Start Date:** January 27, 2026  
**Target Completion:** February 17, 2026  
**Status:** Ready to execute  

---

## WEEK 1: Fix Deliverable 1 (Surface Content Sources)

### Day 1-2: Enhance Dataverse Table
- [ ] Open Digital Assets table in Power Platform
- [ ] Add missing columns:
  ```
  Field Name                Type              Required?
  ─────────────────────────────────────────────────────
  content_type              Choice            Yes (PDF/Lab/Slide/Video)
  owner_phone              Text               No
  owner_department         Text               No
  target_audience          Multi-select      No (Beginner/Intermediate/Advanced/Executive)
  complexity_level         Choice            No (Beginner/Intermediate/Advanced)
  learning_objectives      Multi-line text   No
  tags                     Multi-line text   No (comma-separated)
  section_start            Whole number      No
  section_end              Whole number      No
  hash_group_id            Text              No (for dedup grouping)
  similar_versions_count   Whole number      No (formula: count siblings)
  created_date             Date/Time         No
  ```
- [ ] Update existing Digital Assets with new data
  - Content types for each asset
  - Owner phone/department (pull from Azure AD or manual)
  - Learning objectives (e.g., "Understand Teams architecture, Deploy Teams, Troubleshoot")
  - Complexity levels
  - Tags

### Day 3-4: Update Copilot Studio Search Topic
- [ ] Open agent in Copilot Studio
- [ ] Edit "Discover Content" topic
- [ ] Add filter decision node:
  ```
  "Would you like to filter by:
   A) Content type (PDF/Lab/Slide/Video)
   B) Complexity level (Beginner/Intermediate/Advanced)
   C) Target audience
   D) No filter, show all"
  ```
- [ ] Create 4 conditional branches for each filter type
- [ ] Update Dataverse query to include filter in WHERE clause

### Day 5: Update Result Display
- [ ] Redesign "Format Results" node to show rich card:
  ```
  📄 [TITLE]
  Type: [CONTENT_TYPE] | Level: [COMPLEXITY]
  👤 [OWNER_NAME] | 📧 [EMAIL] | 📞 [PHONE]
  🏢 [DEPARTMENT]
  📝 [DESCRIPTION] (truncate to 100 chars)
  📖 Pages: [SECTION_START]-[SECTION_END]
  🎯 Objectives: [LEARNING_OBJECTIVES]
  🔗 [View in SharePoint]
  👥 [SIMILAR_VERSIONS_COUNT] similar versions
  ```
- [ ] Test with sample queries
- [ ] Verify <2 second response time
- [ ] Get sign-off from Simon

---

## WEEK 2: Implement Deliverable 2 (Capture Reuse & Savings)

### Day 1-2: Create Dataverse Table
- [ ] Create new table: "Content Reuse Log"
- [ ] Add columns:
  ```
  Field Name                Type              Notes
  ─────────────────────────────────────────────────────
  DigitalAssetId           Lookup            → Digital Assets
  UserEmail                Text              Captured from context
  UserDepartment           Text              Optional
  DateReused               Date/Time         Auto-populate with today
  HoursSaved               Decimal           User input
  HourlyRate               Decimal           User selected
  CostAvoided              Calculated        = HoursSaved × HourlyRate
  LearnersImpacted         Whole number      Optional
  Context                  Multi-line text   "Why did you reuse it?"
  SourceAssetTitle         Text              Denormalized copy
  SourceAssetOwner         Text              Denormalized copy
  ManagerApproved          Two options       Default: No (future audit)
  ```
- [ ] Add relationships & set up cascading
- [ ] Add to solution
- [ ] Load 0 sample records (ready for live data)

### Day 3-4: Build Power Automate Flow
- [ ] Create flow: "Log Asset Reuse"
- [ ] Trigger: "Call from Copilot Studio action"
- [ ] Inputs:
  ```
  Input Name          Type      Notes
  ──────────────────────────────────
  assetId             GUID      From Copilot selection
  assetTitle          String    Display name
  hoursSaved          Number    User input
  hourlyRate          Number    User selected
  learnersCount       Number    Optional
  context             String    Why reuse
  userEmail           String    From context
  ```
- [ ] Actions:
  1. Create row in Content Reuse Log
  2. Calculate CostAvoided
  3. Return success with calculated values
- [ ] Test with manually created inputs

### Day 5: Update Copilot Studio Agent
- [ ] Create new topic: "Log Reuse"
- [ ] Trigger phrases:
  ```
  - I'm using this
  - Yes, I'll reuse this
  - Log this reuse
  - Track this usage
  - Save time entry
  ```
- [ ] Build conversation flow:
  1. Acknowledge: "Great! Let me capture this..."
  2. Prompt: "How many hours saved?" (text input)
  3. Prompt: "Select hourly rate" (choice: Junior/Mid/Senior)
  4. Optional: "How many learners will use it?" (number)
  5. Call Power Automate flow with inputs
  6. Show confirmation: "✅ Saved! You've saved $X"
  7. Offer: "Log another reuse?" or "View report?"
- [ ] Test with real asset
- [ ] Verify Dataverse logging works
- [ ] Check cost calculation accuracy

---

## WEEK 3: Implement Deliverable 3 (Generate Reports)

### Day 1-2: Create Power BI Report
**Option A: Power BI (Recommended)**
- [ ] Open Power BI Desktop
- [ ] Connect to Dataverse (Content Reuse Log table)
- [ ] Create relationships (join with Digital Assets)
- [ ] Create measures (DAX formulas):
  ```
  Total Hours Saved = SUM(ContentReuseLog[HoursSaved])
  Total Cost Avoided = SUM(ContentReuseLog[CostAvoided])
  Unique Users = DISTINCTCOUNT(ContentReuseLog[UserEmail])
  Unique Assets Reused = DISTINCTCOUNT(ContentReuseLog[DigitalAssetId])
  Avg Time to Reuse = CALCULATE(...)  // from data timestamp
  ```
- [ ] Create visualizations:
  1. **Executive Summary Card:**
     - Total Cost: $23,400
     - Total Hours: 156
     - Users: 12
     - Assets: 47
  2. **Top Assets Table:**
     - Rank | Asset | Reuse Count | Hours | Cost
  3. **Cost by Week Line Chart**
  4. **Reuse by Team Bar Chart**
  5. **ROI KPI Card**
- [ ] Publish to Power BI Service
- [ ] Get dashboard URL

**Option B: Power Apps (Alternative)**
- [ ] Create Model-Driven App based on Content Reuse Log
- [ ] Create views:
  - List (all reuses, sortable)
  - By Asset (grouped)
  - By Team (grouped)
  - Timeline (by week)
- [ ] Create dashboard with charts
- [ ] Add filters (date range, team, asset)

### Day 3-4: Build Power Automate Report Flow
- [ ] Create flow: "Get Reuse Report"
- [ ] Trigger: "Call from Copilot Studio action"
- [ ] Inputs:
  ```
  Input Name          Type        Notes
  ─────────────────────────────────────
  dateFrom            DateTime    e.g., "Start of month"
  dateTo              DateTime    e.g., "Today"
  filterTeam          String      Optional (All/Sales/Learning/etc)
  ```
- [ ] Actions:
  1. List rows in Content Reuse Log (apply date/team filter)
  2. Create objects for summary:
     ```
     totalCostAvoided = SUM(all costs in filtered set)
     totalHoursSaved = SUM(all hours)
     uniqueUsers = COUNT DISTINCT users
     uniqueAssets = COUNT DISTINCT assets
     topAssets = [ { title, reuses, cost, owner }, ...]
     ```
  3. Return JSON to Copilot with all metrics + URL to full report
- [ ] Test with sample date ranges

### Day 5: Update Copilot Studio Agent
- [ ] Create new topic: "View Reuse Report"
- [ ] Trigger phrases:
  ```
  - Show me the reuse report
  - What's our savings
  - How much time saved
  - ROI report
  - Reuse statistics
  - Cost summary
  ```
- [ ] Build conversation flow:
  1. Acknowledge: "Let me pull your reuse report..."
  2. Offer filters:
     ```
     "What period?
      A) This week
      B) This month
      C) This quarter
      D) Custom date"
     ```
  3. Get user selection → set dates
  4. Offer: "Filter by team?"
     ```
     A) All teams
     B) Sales Enablement
     C) Learning & Dev
     D) Product Training
     ```
  5. Get user selection
  6. Call Power Automate "Get Reuse Report" flow
  7. Display results in formatted message:
     ```
     📊 REUSE SUMMARY
     Period: [DATE RANGE]
     Team: [FILTER]
     
     💰 Cost Avoided: $[TOTAL]
     ⏱️ Hours Saved: [TOTAL]
     👥 Users: [COUNT]
     📦 Assets: [COUNT]
     
     🏆 Top Assets
     1. [ASSET] - [REUSES] uses, $[COST]
     2. [ASSET] - [REUSES] uses, $[COST]
     3. [ASSET] - [REUSES] uses, $[COST]
     
     📈 [Link to Power BI/Power Apps Report]
     ```
  8. Offer: "View full report" or "Ask another question"
- [ ] Test with sample dates
- [ ] Verify links to Power BI/Power Apps work

---

## FULL SYSTEM TEST (Days 16-17)

### End-to-End Scenario
```
Scenario: "Sarah discovers and logs content reuse"

Step 1: Discovery (Deliverable 1)
┌─────────────────────────────────────┐
│ Sarah: "Find Azure security labs"   │
│ Agent: [Shows 3 labs with owners]   │
│        Filter option shown           │
└─────────────────────────────────────┘

Step 2: Reuse Capture (Deliverable 2)
┌─────────────────────────────────────┐
│ Sarah: "I'll use the first one"     │
│ Agent: "How many hours saved?"      │
│ Sarah: "6 hours"                    │
│ Agent: "Pick your rate..."          │
│ Sarah: "Senior ($200/hr)"           │
│ Agent: "✅ Saved! $1,200 logged"    │
└─────────────────────────────────────┘

Step 3: View Report (Deliverable 3)
┌─────────────────────────────────────┐
│ Sarah: "Show me this month's ROI"   │
│ Agent: "Filtering by this month..." │
│ Agent: [Shows summary + top assets] │
│        [Link to full report]        │
└─────────────────────────────────────┘
```

### Test Cases to Run
- [ ] DISC-001 through DISC-008 (Search tests)
- [ ] REUSE-001 through REUSE-007 (Capture tests)
- [ ] REPORT-001 through REPORT-006 (Reporting tests)
- [ ] E2E-001: Full discovery → reuse → report flow
- [ ] E2E-002: Multiple assets in one session
- [ ] E2E-003: Different user roles (Junior/Mid/Senior rates)

### Performance Validation
- [ ] Search latency: <2 seconds ✓
- [ ] Reuse logging: <5 seconds ✓
- [ ] Report generation: <10 seconds ✓
- [ ] No errors in telemetry ✓

### Sign-Off
- [ ] Simon reviews Deliverable 1
- [ ] Simon reviews Deliverable 2
- [ ] Simon reviews Deliverable 3
- [ ] All 3 working together in conversation
- [ ] Final approval

---

## File Checklist (What Gets Updated)

### Dataverse Tables
- [x] Digital Assets - ADD 10 new columns
- [ ] Create Content Reuse Log - NEW TABLE
- [ ] Add both to solution

### Power Automate
- [ ] Create "Log Asset Reuse" flow
- [ ] Create "Get Reuse Report" flow
- [ ] Test both with sample data

### Copilot Studio
- [ ] Update "Discover Content" topic (add filters)
- [ ] Create "Log Reuse" topic
- [ ] Create "View Report" topic
- [ ] Update result formatting
- [ ] Update main conversation router

### Power BI or Power Apps
- [ ] Create report/dashboard
- [ ] Connect to Dataverse
- [ ] Publish & share

### Documentation
- [ ] Update COPILOT_STUDIO_BUILD_GUIDE.md (with new flows)
- [ ] Update AGENT_TESTING_CHECKLIST.md (full test cases)
- [ ] Add deployment notes

---

## Risk Mitigation

| Risk | Mitigation |
|------|-----------|
| Dataverse schema changes break agent | Test flow before publishing |
| Power Automate flow fails | Use error handling, test with manual inputs |
| Report dashboard is slow | Optimize DAX queries, use aggregations |
| User confusion on filters | Add help text, use clear button labels |
| Data quality issues in logs | Validate inputs, show confirmation before save |

---

## Success Criteria (Simon's Approval)

✅ **Deliverable 1:** User asks question → Gets 3+ relevant assets with owner info in <2 seconds  
✅ **Deliverable 2:** User confirms reuse → Agent captures time/cost → Shows calculated savings  
✅ **Deliverable 3:** User requests report → Shows key metrics + top assets + link to Power BI  
✅ **All 3 working together:** Single coherent conversation with no context loss  
✅ **Data integrity:** All reuse logged to Dataverse with audit trail  
✅ **Performance:** <10 seconds for any operation  

---

## Who Does What

| Task | Owner | Timeline |
|------|-------|----------|
| Dataverse table updates | Darin (or you) | Day 1-2 |
| Power Automate flows | You or Darin | Day 3-4 (Week 2-3) |
| Copilot Studio topics | You | Day 5 each week + Day 5 Week 3 |
| Power BI/Power Apps report | You or Power BI dev | Day 1-2 (Week 3) |
| Testing | You + Simon | Day 16-17 |
| Documentation | You | Ongoing |

---

## Commands to Execute (When Ready)

```powershell
# Check current state
pac auth select -i 2  # Select SimShip Test environment
pac copilot list  # List agents
pac copilot status --bot-id "43954037-60f7-f011-8406-7ced8d04f302"

# After completion: Publish agent
pac copilot publish --bot-id "43954037-60f7-f011-8406-7ced8d04f302"
```

---

## Next Steps (Start Tomorrow)

1. **Read this document** → Understand full scope
2. **Read SIMSHIP_AGENT_V2_GAP_ANALYSIS.md** → Understand what's missing
3. **Open Power Platform** → Start Day 1 (Dataverse table updates)
4. **Schedule 30-min sync with Simon** → Show him this plan, get approval
5. **Block calendar for 3 weeks** → Focused execution
6. **Create project tracking** → Update daily progress

**You've got this! 🚀**
