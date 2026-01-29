# SimShip Digital Asset Finder - Agent Testing Checklist

**Agent Name:** SimShip Digital Asset Finder  
**Test Date:** _______________  
**Tester Name:** _______________  
**Environment:** SimShip Test  
**Status:** Ready for Testing

---

## TEST SUITE 1: TOPIC 1 - SEARCH DIGITAL ASSETS (12 Tests)

### T1.1: Search by Exact Asset Name
- **Steps:**
  1. Open agent
  2. Type: "Search for digital assets"
  3. Select type: "Presentation"
  4. Enter keyword: "Q1 2026 Sales Strategy"
- **Expected Result:** Returns "Q1 2026 Sales Strategy" with full description and URL
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.2: Search by Asset Type - Presentation
- **Steps:**
  1. Trigger: "Show me Presentation assets"
  2. Select: "Presentation" type
  3. Keyword: Leave blank or "any"
- **Expected Result:** Returns all Presentation type assets (Q1 2026 Sales Strategy)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.3: Search by Asset Type - Document
- **Steps:**
  1. Trigger: "Search for Document assets"
  2. Select: "Document" type
  3. Keyword: "Employee"
- **Expected Result:** Returns "Employee Onboarding Checklist" (Document)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.4: Search by Asset Type - Video
- **Steps:**
  1. Trigger: "Show me Video assets"
  2. Select: "Video" type
  3. Keyword: Leave blank
- **Expected Result:** Returns "Product Features Overview" (Video)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.5: Search by Asset Type - Spreadsheet
- **Steps:**
  1. Trigger: "Search for Spreadsheet assets"
  2. Select: "Spreadsheet" type
  3. Keyword: Leave blank
- **Expected Result:** Returns "Financial Reporting Template" (Spreadsheet)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.6: Search by Keyword - "Guidelines"
- **Steps:**
  1. Trigger: "Search for content"
  2. Type: Any
  3. Keyword: "Guidelines"
- **Expected Result:** Returns "Brand Guidelines 2026" (Document)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.7: Search by Keyword - "Overview"
- **Steps:**
  1. Trigger: "Search assets by topic"
  2. Type: Any
  3. Keyword: "Overview"
- **Expected Result:** Returns "Product Features Overview" (Video)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.8: Search Returns Correct Columns
- **Steps:**
  1. Perform any search (T1.1-T1.7)
  2. Verify response includes: Name, Type, Description, URL
- **Expected Result:** Each result shows [Name] ([Type]), Description: [desc], Source: [URL]
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.9: Search with No Results
- **Steps:**
  1. Type: "Search for digital assets"
  2. Type: "Presentation"
  3. Keyword: "NONEXISTENT_ASSET_XYZ"
- **Expected Result:** "No assets found matching that criteria. Try a different keyword or asset type."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.10: Search Results Limited to Top 10
- **Steps:**
  1. Perform search that returns multiple results
  2. Count results in response
- **Expected Result:** Returns maximum 10 results (or fewer if fewer exist)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.11: Search Offers Log Reuse Option
- **Steps:**
  1. Perform search and get results
  2. Check if agent asks: "Would you like to log that you used any of these assets?"
  3. Answer "YES"
- **Expected Result:** Transitions to Topic 2 (Log Reuse)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T1.12: Search Allows "No" to Reuse Logging
- **Steps:**
  1. Perform search
  2. Agent asks about logging reuse
  3. Answer "NO"
- **Expected Result:** Conversation ends gracefully, offers to search again
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

## TEST SUITE 2: TOPIC 2 - LOG CONTENT REUSE (15 Tests)

### T2.1: Log Reuse - Q1 2026 Sales Strategy
- **Steps:**
  1. Trigger: "I used an asset"
  2. Asset: "Q1 2026 Sales Strategy"
  3. Context: "Regional sales meeting"
  4. Hours: 2
  5. Value: 500
- **Expected Result:** Confirms "Logged reuse of Q1 2026 Sales Strategy. Value captured: $500, 2 hours saved."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.2: Log Reuse - Employee Onboarding Checklist
- **Steps:**
  1. Trigger: "Log reuse"
  2. Asset: "Employee Onboarding Checklist"
  3. Context: "New employee onboarding"
  4. Hours: 1
  5. Value: 250
- **Expected Result:** Confirms reuse logged successfully
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.3: Verify Dataverse Record Created - Table
- **Steps:**
  1. Log a reuse (per T2.1 or T2.2)
  2. Go to Power Apps > Tables > cr846_contentsreuselog
  3. Check for new record
- **Expected Result:** New record exists with today's date
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.4: Verify Dataverse Record - Asset Lookup
- **Steps:**
  1. Open new reuse log record (from T2.3)
  2. Check cr846_digitalassetid column
- **Expected Result:** Contains correct asset ID (lookup to Digital Asset table works)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.5: Verify Dataverse Record - Username
- **Steps:**
  1. Open new reuse log record
  2. Check cr846_username column
- **Expected Result:** Contains current user's email address
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.6: Verify Dataverse Record - Context
- **Steps:**
  1. Open new reuse log record
  2. Check cr846_context column
- **Expected Result:** Contains exact context entered by user
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.7: Verify Dataverse Record - Date
- **Steps:**
  1. Open new reuse log record
  2. Check cr846_reusedate column
- **Expected Result:** Contains today's date
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.8: Verify Dataverse Record - Hours
- **Steps:**
  1. Open new reuse log record
  2. Check cr846_savinghours column
- **Expected Result:** Contains hours value entered (as number)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.9: Verify Dataverse Record - Amount
- **Steps:**
  1. Open new reuse log record
  2. Check cr846_savingamount column
- **Expected Result:** Contains dollar value entered (as currency)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.10: Log Reuse - Asset Not Found
- **Steps:**
  1. Trigger: "Log reuse"
  2. Asset: "NONEXISTENT_ASSET"
  3. Try to proceed
- **Expected Result:** "Asset not found. Please provide the exact asset name."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.11: Log Reuse - Zero Hours Input
- **Steps:**
  1. Log reuse with Hours: 0
  2. Value: 0
- **Expected Result:** Accepts entry and logs record
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.12: Log Reuse - Large Numbers
- **Steps:**
  1. Log reuse with Hours: 100
  2. Value: 50000
- **Expected Result:** Accepts and logs without errors
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.13: Log Reuse - Special Characters in Context
- **Steps:**
  1. Log reuse with Context: "Client meeting @ XYZ Corp (Q1 2026)"
- **Expected Result:** Accepts and stores exact string
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.14: Log Reuse - Multiple Records Same Asset
- **Steps:**
  1. Log reuse of "Q1 2026 Sales Strategy" (first time)
  2. Repeat logging same asset with different context/values (second time)
- **Expected Result:** Both records created (cr846_reusecount not auto-incremented by agent)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T2.15: Log Reuse - Navigate to Statistics
- **Steps:**
  1. Complete logging reuse
  2. Agent asks: "Would you like to... or log another reuse?"
  3. Choose: "View statistics"
- **Expected Result:** Transitions to Topic 3 (View Statistics)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

## TEST SUITE 3: TOPIC 3 - VIEW REUSE STATISTICS (10 Tests)

### T3.1: View Statistics - Q1 2026 Sales Strategy
- **Steps:**
  1. Trigger: "Show reuse statistics"
  2. Asset: "Q1 2026 Sales Strategy"
- **Expected Result:** Shows: Total Uses: 2, Total Hours Saved: 6, Total Value: $1500, Last Used: [date]
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.2: View Statistics - Single Use Asset
- **Steps:**
  1. Trigger: "Asset impact report"
  2. Asset: "Employee Onboarding Checklist"
- **Expected Result:** Shows: Total Uses: 1, Total Hours Saved: 1, Total Value: $250
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.3: View Statistics - Asset Not Found
- **Steps:**
  1. Trigger: "View statistics"
  2. Asset: "NONEXISTENT_ASSET"
- **Expected Result:** "No statistics found for that asset. Try searching for assets first."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.4: View Statistics - Verify Count Calculation
- **Steps:**
  1. Check: How many times was asset logged in T2?
  2. Run statistics query
  3. Compare count
- **Expected Result:** Count matches number of reuse log records for that asset
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.5: View Statistics - Verify Hours Sum
- **Steps:**
  1. Manually add hours from all reuse logs for asset
  2. Run statistics query
  3. Compare total
- **Expected Result:** Total Hours matches sum of cr846_savinghours
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.6: View Statistics - Verify Value Sum
- **Steps:**
  1. Manually add amounts from all reuse logs for asset
  2. Run statistics query
  3. Compare total
- **Expected Result:** Total Value matches sum of cr846_savingamount
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.7: View Statistics - Last Used Date
- **Steps:**
  1. Log reuse of asset on [date 1]
  2. Log reuse again on [date 2] (later)
  3. Run statistics
- **Expected Result:** "Last Used" shows [date 2] (most recent)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.8: View Statistics - Response Formatting
- **Steps:**
  1. Trigger statistics query
  2. Check response format
- **Expected Result:** Formatted as: "Statistics for [Asset Name]:" with separated metrics
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.9: View Statistics - Currency Formatting
- **Steps:**
  1. View statistics for asset with value of 1500
- **Expected Result:** Displays as "$1500" (currency format)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T3.10: View Statistics - Search Again Option
- **Steps:**
  1. View statistics
  2. Agent offers options
  3. Choose: "Search for another asset"
- **Expected Result:** Returns to Topic 1 (Search)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

## TEST SUITE 4: CONVERSATION FLOW (7 Tests)

### T4.1: Agent Greeting
- **Steps:**
  1. Open agent
  2. Wait for initial message
- **Expected Result:** "Hello! I'm the SimShip Digital Asset Finder. I help you discover digital assets and track how we're reusing them. What would you like to do? (Search for assets / Log asset reuse / View statistics)"
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.2: Off-Topic Question
- **Steps:**
  1. Trigger agent
  2. Ask: "What's the weather today?"
- **Expected Result:** "I'm specialized in helping with digital asset discovery and usage tracking. Would you like to search for assets, log reuse, or view statistics?"
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.3: Navigate Search to Reuse
- **Steps:**
  1. Search for assets (Topic 1)
  2. Answer "YES" to log reuse
- **Expected Result:** Seamlessly transitions to Topic 2 (Log Reuse)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.4: Navigate Reuse to Statistics
- **Steps:**
  1. Log reuse (Topic 2)
  2. Answer to view statistics
- **Expected Result:** Seamlessly transitions to Topic 3 (View Statistics)
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.5: Cancel Mid-Topic
- **Steps:**
  1. Start searching for assets
  2. Type: "Cancel" or "Never mind"
- **Expected Result:** "No problem. Type something to get started again."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.6: Exit Conversation
- **Steps:**
  1. Complete a full flow (Search > Reuse > Statistics)
  2. End conversation
- **Expected Result:** "Thank you for using SimShip Digital Asset Finder. Your asset usage has been recorded and will help optimize our content strategy."
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T4.7: Error Recovery
- **Steps:**
  1. Trigger error (search with bad input, asset not found, etc.)
  2. Receive error message
  3. Try again with correct input
- **Expected Result:** Agent recovers and processes new request correctly
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

## TEST SUITE 5: DATAVERSE INTEGRATION (3 Tests)

### T5.1: Connection Health Check
- **Steps:**
  1. Open Copilot Studio
  2. Go to Settings > Connectors
  3. Check "SimShip-Dataverse" connection status
- **Expected Result:** Status shows "Connected" or "Healthy"
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T5.2: Query Performance
- **Steps:**
  1. Search for assets (returns 10 results)
  2. Check response time
- **Expected Result:** Results return in less than 5 seconds
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

### T5.3: Data Integrity - Reuse Log to Digital Asset Relationship
- **Steps:**
  1. Log reuse of "Q1 2026 Sales Strategy"
  2. Go to Power Apps > cr846_contentsreuselog
  3. Open new record
  4. Click on cr846_digitalassetid (lookup field)
- **Expected Result:** Lookup correctly resolves to "Q1 2026 Sales Strategy" in Digital Asset table
- **Status:** ☐ Pass | ☐ Fail | ☐ N/A
- **Notes:** ________________________________________

---

## SUMMARY

| Test Suite | Total | Passed | Failed | N/A |
|-----------|-------|--------|--------|-----|
| T1: Search Digital Assets | 12 | ___ | ___ | ___ |
| T2: Log Content Reuse | 15 | ___ | ___ | ___ |
| T3: View Statistics | 10 | ___ | ___ | ___ |
| T4: Conversation Flow | 7 | ___ | ___ | ___ |
| T5: Dataverse Integration | 3 | ___ | ___ | ___ |
| **TOTAL** | **47** | ___ | ___ | ___ |

---

## OVERALL STATUS

**Ready for Production:** ☐ YES | ☐ NO

**Blockers/Issues:**
```
[List any failed tests that must be fixed before deployment]




```

**Sign-Off:**

Tester: _________________________ Date: __________

QA Lead: ________________________ Date: __________

**Notes for Future Testing:**
```
[Document any enhancements, edge cases, or additional tests needed]




```
