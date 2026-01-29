# Copilot Studio Build Guide: SimShip Agent
## Step-by-Step Instructions for Derrick

**Version:** 1.0  
**Target Audience:** Derrick (building in Copilot Studio)  
**Timeline:** Week 1-2  
**Status:** Ready to follow

---

## Table of Contents
1. [Setup & Preparation](#setup--preparation)
2. [Part 1: Discovery Agent](#part-1-discovery-agent)
3. [Part 2: Reuse Capture Flow](#part-2-reuse-capture-flow)
4. [Part 3: Testing & Validation](#part-3-testing--validation)

---

# SETUP & PREPARATION

## Prerequisites

**What You Need:**
- [ ] Access to Copilot Studio (https://copilotstudio.microsoft.com)
- [ ] Microsoft 365 tenant with Power Platform enabled
- [ ] Dataverse environment with existing Digital Assets table
- [ ] SharePoint access to document repositories
- [ ] 30 sample assets loaded in Digital Assets table for testing

**Connection Setup (Do This First):**

### Step 1: Create Dataverse Connection

1. Go to **Copilot Studio** → **Environments** → Select your environment
2. Go to **Settings** → **Secrets** (or connectors area)
3. Create new connection: **Dataverse**
   - Connection name: `SimShip-Dataverse`
   - Select your Dataverse environment
   - Test connection ✓

### Step 2: Create SharePoint Connection

1. In Connectors, add **SharePoint** connection
   - Connection name: `SimShip-SharePoint`
   - Select your SharePoint tenant
   - Test connection ✓

### Step 3: Sample Data Setup

Create 30 sample assets in Dataverse **Digital Assets** table:

```
Sample Assets to Add:

1. Azure Fundamentals
   - Type: PDF
   - Pages: 45
   - Keywords: azure, fundamentals, cloud
   - Owner: Sarah Chen
   - Email: sarah.chen@microsoft.com
   - SharePoint URL: [your-site]/Azure_Fundamentals.pdf

2. Teams Administration Lab
   - Type: Lab
   - Duration: 90 minutes
   - Keywords: teams, administration, deployment
   - Owner: John Smith
   - Email: john.smith@microsoft.com
   - SharePoint URL: [your-site]/Teams_Lab.aspx

3. M365 Security Best Practices
   - Type: Slides
   - Slides: 25
   - Keywords: m365, security, compliance
   - Owner: Jane Wilson
   - Email: jane.wilson@microsoft.com
   - SharePoint URL: [your-site]/M365_Security.pptx

[... continue for 27 more sample assets ...]
```

---

# PART 1: DISCOVERY AGENT

## Overview
The agent listens for user questions about content, searches Dataverse, and returns matching assets with owner information and links.

## Architecture

```
User: "Show me Azure content"
         ↓
Copilot Studio Agent
  ├─ Parse intent & extract keywords
  ├─ Call Power Platform Connector
  │    └─ Query Dataverse Digital Assets table
  ├─ Format results
  └─ Return to user with options
         ↓
User sees: 3 assets with owners, descriptions, links
```

---

## Agent Creation Steps

### Step 1: Create New Agent

1. Open **Copilot Studio**
2. Click **+ Create** → **Agent**
3. Enter name: `SimShip Content Discovery Agent`
4. Enter description:
   ```
   Helps instructional designers find and reuse learning content 
   from across Microsoft's digital asset repositories. Discovers 
   content by topic and tracks reuse for ROI reporting.
   ```
5. Click **Create**

### Step 2: Configure Agent Trigger

The agent should activate when users ask questions. Copilot Studio automatically listens for natural language input.

**Default behavior:** ✓ Already enabled in Copilot Studio

### Step 3: Build Discovery Topic (Main Conversation Flow)

Navigate to **Topics** → **+ New topic** or edit **Greeting** topic

**Topic Name:** `Discover Content`

**Trigger Phrases** (add these so agent recognizes different ways users ask):
```
- Show me [subject] content
- What [subject] training do we have
- Find [subject] learning materials
- Do we have any [subject] content
- I need [subject] content for my course
- What reusable [subject] resources exist
- Search for [subject] materials
- Show [subject] assets
- [subject] training content
- Azure fundamentals
- Microsoft Teams
- M365 security
```

---

### Step 4: Build the Discovery Flow (Visual Designer)

In the Copilot Studio visual editor, create this flow:

```
START
  ↓
[User Input] "Show me Azure content"
  ↓
[Message] "Let me search our learning asset library..."
  ↓
[Power Platform Connector Action]
  ACTION: "List rows in a table (Dataverse)"
  TABLE: "Digital Assets"
  FILTER: keywords contains (extracted from user input)
  ↓
[Condition Check]
  IF: Number of results > 0
    → Go to "Format Results"
  ELSE:
    → Go to "No Results Found"
```

**Detailed Steps in Copilot Studio:**

1. Click **+ Add node** (new message/action block)
2. Select **Send a message**
   ```
   Message text:
   "Let me search our learning asset repository for content about [topic]..."
   
   Variable mapping:
   [topic] = extract from user input
   ```

3. Click **+ Add node** → **Call an action**
   - Action type: **Power Platform Connector**
   - Connector: **Dataverse**
   - Action: **List rows in a table**
   - Configuration:
     ```
     Table: Digital Assets
     Filter rows: 
       keywords contains @{topic}
     
     Columns to return:
     - id
     - title
     - type
     - description
     - owner_name
     - owner_email
     - sharepoint_link
     - pages (if PDF)
     - slide_count (if slides)
     - duration_minutes (if lab/video)
     ```

4. Click **+ Add node** → **Condition**
   ```
   Condition: Number of items returned > 0
   
   If TRUE: Continue to format and display results
   If FALSE: Go to "No results" message
   ```

5. Click **+ Add node** → **Loop** (for each result)
   ```
   Loop over: Rows returned from Dataverse query
   For each item:
     Format as card/message with:
     - Title
     - Type (PDF, Slides, Lab, Video)
     - Owner: Name (Email)
     - Description
     - Link button to SharePoint
   ```

6. Add **Buttons/Actions** at end of each result:
   ```
   [Use This Content] → trigger "Reuse Capture" topic
   [Get More Info] → show full description
   [Search Again] → return to search
   ```

---

### Step 5: Create "No Results" Fallback

Add another **Topic** for when search returns nothing:

**Topic Name:** `No Results Handling`

```
Message: "I didn't find any assets matching '[topic]'. 

Try these alternatives:
- Cloud fundamentals
- Security training
- Teams administration
- M365 essentials

What would you like to search for?"

[Search Again Button]
```

---

### Step 6: Test Discovery (in Copilot Studio)

Click **Test** (bottom left of editor)

```
Test Query 1: "Show me Azure content"
Expected: Returns Azure Fundamentals + Azure Security assets

Test Query 2: "Teams administration training"
Expected: Returns Teams Lab + Teams Best Practices

Test Query 3: "blockchain content"
Expected: Shows "No Results" message with alternatives

Test Query 4: "M365 security"
Expected: Returns security-related assets
```

All 4 should pass ✓

---

## Discovery Agent: Complete YAML/Configuration

If you want to export or backup the agent, here's what the configuration looks like:

```yaml
Agent:
  Name: SimShip Content Discovery Agent
  Description: Find and reuse learning content
  
Topics:
  - Name: Discover Content
    Trigger Phrases:
      - Show me [subject] content
      - What [subject] training do we have
      - Find [subject] learning materials
    
    Nodes:
      1. Message:
           Text: "Let me search for [subject] content..."
      
      2. Power Platform Action:
           Connector: Dataverse
           Action: List rows in table
           Table: Digital Assets
           Filter: keywords contains @{subject}
           Return columns: [id, title, type, owner_name, owner_email, sharepoint_link]
      
      3. Condition:
           Check: Count(results) > 0
           If True → Node 4
           If False → "No Results" topic
      
      4. Loop:
           Over: Each result
           For each:
             - Display title, type, owner, description
             - Add buttons: [Use This] [More Info]
      
      5. Button Actions:
           [Use This] → Call "Reuse Capture" topic
           [Search Again] → Restart "Discover Content"

  - Name: No Results Handling
    Trigger: Automatic (from Condition node)
    Message: "No assets found. Try searching for..."
    Buttons: [Try Again]
```

---

# PART 2: REUSE CAPTURE FLOW

## Overview
When user clicks "I'll use this content," agent captures:
- Hours to create from scratch
- Hourly rate
- Number of benefiting learners
- Context/notes

Then logs to Dataverse "Content Reuse Log" table.

---

## Part 2 Setup: Create Reuse Log Table (Prerequisite)

**Before building the flow, Darin needs to create this table in Dataverse:**

### Table: Content Reuse Log

| Column Name | Type | Required? | Notes |
|-------------|------|-----------|-------|
| id | GUID | Auto | Auto-generated |
| asset_id | Lookup | Yes | Links to Digital Assets table |
| user_email | Text | Yes | Captured from Power Platform user context |
| hours_saved | Number | Yes | Integer, > 0 |
| hourly_rate | Currency | Yes | USD, > 0 |
| cost_avoided | Currency | Auto | Calculated: hours_saved × hourly_rate |
| benefiting_learners | Number | No | For multiplier effect |
| learner_hours_saved | Number | No | learner_impact × benefiting_learners |
| date_reused | Date | Auto | Today's date |
| timestamp | DateTime | Auto | Exact moment logged |
| context | Text (Long) | No | Why/how content was used |
| department | Text | No | Auto-populated from user profile |
| approval_status | Dropdown | Auto | Values: ["logged", "approved", "flagged"] |

**In Dataverse, this is a standard table with formula columns:**

```
cost_avoided (calculated field):
  = hours_saved * hourly_rate

learner_hours_saved (calculated field):
  = benefiting_learners * learner_hours_saved

total_cost_impact (calculated field):
  = cost_avoided + (learner_hours_saved * hourly_rate)
```

✓ **Darin: Create this table before proceeding**

---

## Reuse Capture Flow Steps

### Step 1: Create "Reuse Capture" Topic

In Copilot Studio, create new **Topic**:

**Topic Name:** `Capture Reuse and Savings`

**Trigger:** Called from Discovery topic when user clicks [Use This]

**Variables to track:**
```
- selected_asset_id (passed from Discovery)
- selected_asset_title (passed from Discovery)
- hours_to_create (user input)
- hourly_rate (user input)
- benefiting_learners (user input, optional)
- context (user input, optional)
```

---

### Step 2: Build the Conversation Flow

```
START
  ↓
[Message] "Great! I found reusable content for you.
           Let me capture the impact..."
  ↓
[Question] "How many hours would it have taken 
           to create this from scratch?"
  ├─ Wait for input (number)
  ├─ Validate: > 0
  └─ Store in: hours_to_create
  ↓
[Question] "What's your hourly rate?"
  ├─ Offer quick options:
  │  □ $75/hr (Junior)
  │  □ $120/hr (Mid-level)
  │  □ $150/hr (Senior)
  │  □ Custom: ____ /hr
  └─ Store in: hourly_rate
  ↓
[Calculate] cost_avoided = hours_to_create × hourly_rate
  ↓
[Message] "Direct impact: {hours_to_create} hours, 
           ${cost_avoided} cost avoided"
  ↓
[Question] "Will other people benefit from this content?
           (Optional: How many learners? How many hours each?)"
  ├─ If YES:
  │  ├─ How many learners?
  │  ├─ Hours saved per learner?
  │  └─ Calculate multiplier effect
  ├─ If NO:
  │  └─ Continue without multiplier
  └─ Store in: benefiting_learners, learner_hours_saved
  ↓
[Message] "TOTAL IMPACT:
           {total_hours} hours saved
           ${total_cost} cost avoided"
  ↓
[Power Platform Action] Create row in Dataverse
  TABLE: Content Reuse Log
  FIELDS:
    - asset_id: @{selected_asset_id}
    - user_email: @{User.Email}
    - hours_saved: @{hours_to_create}
    - hourly_rate: @{hourly_rate}
    - benefiting_learners: @{benefiting_learners}
    - learner_hours_saved: @{learner_hours_saved}
    - context: @{context}
    - date_reused: Today
  ↓
[Message] "✓ Logged! Great work finding reusable content.
           Your team saved {total_hours} hours and 
           ${total_cost} in creation time.
           
           [View Reports] [Find More Content]"
  ↓
END
```

---

### Step 3: Detailed Node Configuration

**Node 1: Opening Message**
```
Node Type: Send a message
Text: "Excellent! I found reusable content for you.
       
       Let me ask a few quick questions so we can 
       track your time savings..."
```

**Node 2: Hours Input**
```
Node Type: Ask for input
Question: "How many hours would it have taken you 
           to create this from scratch?"
Input Type: Number
Validation: Must be > 0
Error message: "Please enter a number greater than 0"
Variable: hours_to_create

[Continue button to next step]
```

**Node 3: Rate Selection**
```
Node Type: Ask with options
Question: "What's your hourly rate?"

Options:
  □ $75/hour (Junior)
  □ $120/hour (Mid-level)
  □ $150/hour (Senior)
  □ Custom: [text input]

Variable: hourly_rate

[Each option stores different value]
```

**Node 4: Calculation Display**
```
Node Type: Send a message
Text: "Direct impact:
       Hours: @{hours_to_create} hours
       Rate: $@{hourly_rate}/hour
       Cost avoided: $@{multiply(hours_to_create, hourly_rate)}
       
       Does this content benefit others in your team?"

[Yes] → Go to Node 5
[No] → Go to Node 7
[Skip] → Go to Node 7
```

**Node 5: Multiplier Input (If Yes)**
```
Node Type: Ask for input
Question: "How many people will benefit from this 
           reusable content?"
Input Type: Number
Variable: benefiting_learners

[Next]
  ↓
Question: "On average, how many hours will each 
           person save?"
Input Type: Number
Variable: learner_hours_each

[Calculate and show multiplier]
```

**Node 6: Show Multiplier Result**
```
Node Type: Send a message
Text: "Multiplier effect:
       @{benefiting_learners} learners × 
       @{learner_hours_each} hours each = 
       @{multiply(benefiting_learners, learner_hours_each)} hours
       
       TOTAL IMPACT:
       @{add(hours_to_create, multiply(benefiting_learners, learner_hours_each))} hours
       ${multiply(add(hours_to_create, multiply(benefiting_learners, learner_hours_each)), hourly_rate)} cost avoided"
```

**Node 7: Context/Notes (Optional)**
```
Node Type: Ask for input
Question: "Any notes about how you'll use this content?
           (Optional - helps us understand impact)"
Input Type: Text (long)
Variable: context
Allow skip: Yes

[Next]
```

**Node 8: Save to Dataverse**
```
Node Type: Call an action
Action: Power Platform Connector → Dataverse
Connector: Dataverse
Action: "Create a new row"

Table: Content Reuse Log

Map these fields:
  asset_id → @{selected_asset_id}
  user_email → @{User.Email}
  hours_saved → @{hours_to_create}
  hourly_rate → @{hourly_rate}
  benefiting_learners → @{benefiting_learners}
  learner_hours_saved → @{multiply(benefiting_learners, learner_hours_each)}
  context → @{context}
  
Output variable: reuse_log_entry
```

**Node 9: Confirmation Message**
```
Node Type: Send a message
Text: "✓ LOGGED!

Asset: @{selected_asset_title}
Hours saved (your time): @{hours_to_create} hours
Cost avoided: $@{multiply(hours_to_create, hourly_rate)}

Great work finding reusable content! 🎉

[View My Reuse Summary] [Find More Content] [Done]"
```

---

### Step 4: Test Reuse Capture

```
Test Scenario 1: Basic Reuse
  - Select: Azure Fundamentals
  - Hours: 8
  - Rate: $150
  - Learners: No
  Expected: Entry logged, cost = $1,200

Test Scenario 2: With Multiplier
  - Select: Teams Lab
  - Hours: 16
  - Rate: $150
  - Learners: Yes, 50 learners, 1 hour each
  Expected: Entry logged
           Direct: 16 × $150 = $2,400
           Multiplier: 50 × $150 = $7,500
           Total: $9,900

Test Scenario 3: Invalid Input
  - Hours: -5 (negative)
  Expected: Validation error, re-prompt for input

Test Scenario 4: Multiple Reuses Same Session
  - Log 3 assets in sequence
  Expected: All 3 Dataverse entries created
           Each with correct asset_id
           User sees running total
```

All 4 should pass ✓

---

## Power Fx Formulas Used in Flows

For complex calculations, Copilot Studio uses **Power Fx** syntax:

```powerfx
// Basic multiplication
multiply(hours_to_create, hourly_rate)

// Addition
add(hours_to_create, learner_hours_saved)

// Conditional
if(benefiting_learners > 0, 
   multiply(benefiting_learners, learner_hours_each),
   0)

// Date functions
Today()
Now()

// String concatenation
"Cost avoided: $" & multiply(hours, rate)
```

---

# PART 3: TESTING & VALIDATION

## Test Checklist for Agent

### Discovery Tests

```
✓ Test 1: Agent finds assets by keyword
  Input: "Azure content"
  Output: Returns 3+ Azure assets with owners

✓ Test 2: Agent handles multiple keywords
  Input: "Azure AND security"
  Output: Returns only assets with both

✓ Test 3: Agent handles no results
  Input: "blockchain"
  Output: Shows helpful alternatives

✓ Test 4: Links are clickable
  Input: Click [View] on any asset
  Output: Opens actual SharePoint document

✓ Test 5: Owner info is accurate
  Input: Any asset result
  Output: Correct name + email shown

✓ Test 6: Response time is fast
  Input: Query
  Output: Response in < 3 seconds
```

### Reuse Capture Tests

```
✓ Test 1: Basic flow works
  Input: Hours=8, Rate=$150
  Output: Entry in Dataverse, cost=$1,200

✓ Test 2: Multiplier calculation
  Input: Hours=8, Learners=50, per-learner=1
  Output: Total hours=58, cost=$8,700

✓ Test 3: Validation rejects bad input
  Input: Hours=-5
  Output: Error message, re-prompt

✓ Test 4: Data stored correctly
  Input: Complete reuse capture
  Output: Row in Dataverse with all fields

✓ Test 5: Multiple reuses in session
  Input: Log 3 assets
  Output: 3 separate rows, running total shown
```

### Integration Tests

```
✓ Test 1: Discovery → Reuse flow
  Input: Find asset, click [Use This]
  Output: Reuse capture starts with asset_id pre-filled

✓ Test 2: User context captured
  Input: Log reuse as jane.doe@microsoft.com
  Output: Dataverse shows jane.doe@microsoft.com

✓ Test 3: No data loss
  Input: Complete full flow
  Output: All data in Dataverse matches user inputs
```

---

## How to Run Tests in Copilot Studio

1. Click **Test** button (bottom left)
2. Chat window opens
3. Type test queries
4. Verify responses match expected output
5. Check Dataverse table directly for logged entries

---

## Troubleshooting Common Issues

### Issue 1: "Connection failed" error
```
Solution:
1. Go to Settings → Connections
2. Re-authenticate Dataverse connector
3. Test connection
4. Retry agent
```

### Issue 2: Query returns no results unexpectedly
```
Solution:
1. Check if sample data was added to Digital Assets
2. Verify keywords in Dataverse match test query
3. Check filter syntax in the action
4. Try broader keyword search
```

### Issue 3: Dataverse write fails
```
Solution:
1. Verify Content Reuse Log table exists
2. Check all required fields are mapped
3. Verify user has write permissions
4. Check table relationships (asset_id lookup)
```

### Issue 4: Agent responses are slow (>3 sec)
```
Solution:
1. Check Dataverse query (reduce columns returned)
2. Check if table has indexes on keywords column
3. Reduce number of results displayed per query
4. Test with smaller dataset first
```

---

## Deployment Checkpoint

Before handing off to Microsoft:

- [ ] Discovery agent finds content correctly
- [ ] All 8 discovery tests pass
- [ ] Reuse capture logs data to Dataverse
- [ ] All 5 reuse capture tests pass
- [ ] Integration tests pass
- [ ] Agent responds in < 3 seconds
- [ ] Sample data set is robust (30+ assets)
- [ ] Agent documented with usage guide
- [ ] Backup/export of agent configuration

**Once all checkboxes ✓, agent is ready for:**
→ Power BI reporting (next step)  
→ Web dashboard integration (next step)  
→ Handoff to Microsoft

---

## Next Steps After Agent is Built

1. **Configure Power BI Dashboard**
   - Connect to Content Reuse Log table
   - Create aggregations (hours, cost by asset/team/date)
   - Visualize trends and top content

2. **Build Web Dashboard** (React frontend)
   - Connect to Dataverse API
   - Show same reports with more control
   - Add user collaboration features

3. **Create Deployment Package**
   - Export agent configuration
   - Document all connections and tables
   - Create setup guide for Microsoft IT
   - Package for production handoff

---

**Status:** Agent build guide complete  
**Next Document:** Power BI Dashboard Configuration  
**Then:** React Web Dashboard (for frontend reporting)

---

**Questions?**
- If tests fail, check troubleshooting section above
- If unclear on any step, refer to screenshot positions described
- If Power Fx formula syntax unclear, refer to examples in section above
