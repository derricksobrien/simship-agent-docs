# Local Development Workflow - SimShip Agent Docs

This guide explains how to use your local website instance to preview and update the GitHub.io site at `https://derricksobrien.github.io/simship-agent-docs/`

## Architecture Overview

```
Your Local Files                Local Preview                 GitHub Pages
─────────────────────────────────────────────────────────────────────────
docs/                    mkdocs serve               GitHub Auto-Deploy
├── index.md        →    (localhost:8000)    →     (derricksobrien.github.io)
├── *.md files
├── mkdocs.yml
└── (all markdown)
```

**Workflow:** Edit files locally → Preview in browser → Commit & push → Auto-publish

---

## Prerequisites

Install the required tools **one time only**:

```powershell
pip install mkdocs mkdocs-material
```

Verify installation:
```powershell
mkdocs --version
```

---

## Step 1: Start Local Development Server

From your workspace folder (`c:\Users\derri\Code\SimShip status site`):

```powershell
mkdocs serve
```

**Output will show:**
```
INFO     -  Building documentation...
INFO     -  Serving on http://127.0.0.1:8000/
```

### Access Your Local Site
- Open browser: `http://localhost:8000`
- Your documentation site appears with all navigation, styling, and search
- **Hot reload enabled** - changes appear automatically when you save files

---

## Step 2: Edit Content Locally

Edit any markdown files in the `docs/` folder:

```
docs/
├── index.md                                    (Home page)
├── SIMSHIP_AGENT_V2_START_HERE.md             (First doc in nav)
├── SIMSHIP_AGENT_V2_STATUS.md                 (Status report)
├── SIMSHIP_AGENT_V2_GAP_ANALYSIS.md           (Technical analysis)
├── SIMSHIP_AGENT_V2_IMPLEMENTATION_CHECKLIST.md
├── SIMSHIP_AGENT_V2_FEATURE_MATRIX.md
├── PRIORITY_FEATURES_AND_TEST_CASES.md
├── COPILOT_STUDIO_BUILD_GUIDE.md
├── AGENT_TESTING_CHECKLIST.md
└── mkdocs.yml                                 (Site configuration)
```

**Examples of changes:**
- Update [docs/index.md](docs/index.md) → Homepage changes reflect instantly at `http://localhost:8000`
- Update [docs/SIMSHIP_AGENT_V2_STATUS.md](docs/SIMSHIP_AGENT_V2_STATUS.md) → Status page refreshes
- Add new `.md` file → Add entry to `mkdocs.yml` nav section

---

## Step 3: Preview Changes

1. **Save your file** in VS Code
2. **Switch to browser** (localhost:8000)
3. **Refresh** - changes appear immediately (or auto-refresh if enabled)
4. **Test navigation** - click links, test search, verify styling

### Common Preview Checks
- [ ] Text formatting (bold, italics, code blocks)
- [ ] Links work correctly
- [ ] Images display properly
- [ ] Code syntax highlighting works
- [ ] Table of contents generates correctly
- [ ] Navigation menu shows new items

---

## Step 4: Publish to GitHub Pages

Once satisfied with your local preview, push changes to GitHub:

### Option A: Command Line (Recommended)

```powershell
# Navigate to your workspace
cd "c:\Users\derri\Code\SimShip status site"

# Stage all changes
git add .

# Commit with descriptive message
git commit -m "Update: [describe what changed]"

# Push to GitHub
git push origin main
```

**Examples of good commit messages:**
- `git commit -m "Update status report - Q1 2026 progress"`
- `git commit -m "Add new testing checklist section"`
- `git commit -m "Fix formatting in gap analysis"`

### Option B: VS Code Git UI

1. Click **Source Control** (left sidebar)
2. Stage changes (click `+` icon)
3. Enter commit message in text box
4. Click **Commit**
5. Click **Sync Changes**

---

## Step 5: Verify Live Site

After pushing, your changes auto-publish within 30-60 seconds:

1. **Wait** ~1 minute for GitHub to build and deploy
2. **Visit** `https://derricksobrien.github.io/simship-agent-docs/`
3. **Verify** your changes appear on the live site
4. **Check browser cache** - hard refresh with `Ctrl+Shift+R` if needed

---

## Typical Daily Workflow

```powershell
# 1. Start the server (once per session)
mkdocs serve

# 2. In VS Code: Edit docs/ files
# 3. In browser: Preview at localhost:8000
# 4. Repeat steps 2-3 until satisfied
# 5. Commit and push
git add .
git commit -m "Update: [description]"
git push origin main

# 6. Browser: Verify at https://derricksobrien.github.io/simship-agent-docs/
```

---

## Configuration Reference

### Site Configuration: [mkdocs.yml](mkdocs.yml)

Key settings you can modify:

```yaml
site_name: SimShip Agent v2 Documentation    # Shown in browser tab & header
site_url: https://derricksobrien.github.io/simship-agent-docs/

theme:
  name: material                              # Material Design theme
  palette:
    scheme: slate                             # Dark theme
    primary: blue                             # Primary color
    accent: cyan                              # Accent color

nav:                                          # Left sidebar navigation
  - Home: index.md
  - Start Here: SIMSHIP_AGENT_V2_START_HERE.md
  # ... more pages
```

### Add New Navigation Items

Edit `mkdocs.yml` nav section:

```yaml
nav:
  - Home: index.md
  - Start Here: SIMSHIP_AGENT_V2_START_HERE.md
  - New Page Title: NEW_FILE.md               # ← Add this line
  - Next Item: OTHER_FILE.md
```

Then create the markdown file: `docs/NEW_FILE.md`

---

## Troubleshooting

### Local Server Not Starting

**Problem:** `mkdocs serve` fails with error

**Solution:**
```powershell
# Verify mkdocs is installed
pip install --upgrade mkdocs mkdocs-material

# Try serving again
mkdocs serve
```

### Changes Not Showing in Browser

1. **Hard refresh browser:** `Ctrl+Shift+R` (Windows)
2. **Check file was saved:** Verify in VS Code (no dot indicator on filename)
3. **Check server is running:** Terminal should show active server messages
4. **Restart server:** Press `Ctrl+C` in terminal, run `mkdocs serve` again

### GitHub Site Not Updating

1. **Wait 2-3 minutes** - GitHub Actions needs time to build
2. **Check Actions tab** - Go to your repo on GitHub.com:
   - Click **Actions**
   - Look for failed deployments (red X)
   - Click to see error details
3. **Verify branch** - Make sure you're pushing to `main` (or master)

### Port Already in Use

**Problem:** `Address already in use`

**Solution:** Kill existing process or use different port
```powershell
# Use alternative port
mkdocs serve -a localhost:8001
```
Then visit `http://localhost:8001`

---

## Quick Commands Reference

| Task | Command |
|------|---------|
| Start local server | `mkdocs serve` |
| Build static HTML | `mkdocs build` |
| View site status | `http://localhost:8000` |
| Commit changes | `git add . && git commit -m "message"` |
| Push to GitHub | `git push origin main` |
| View live site | `https://derricksobrien.github.io/simship-agent-docs/` |

---

## Important Notes

✅ **What Publishes to GitHub.io:**
- All `.md` files in `docs/` folder
- Navigation structure from `mkdocs.yml`
- Theme styling from `mkdocs.yml`
- Images and files referenced in markdown

❌ **What Does NOT Publish:**
- Local-only files outside `docs/`
- Draft files you don't want public
- Development cache folders

⚠️ **Best Practices:**
- Test changes locally first (always preview before pushing)
- Use clear commit messages so you can track changes
- One feature/fix per commit when possible
- Pull latest before major edits (in case of external changes)

---

## Need Help?

- **MkDocs Docs:** https://www.mkdocs.org/
- **Material Theme:** https://squidfunk.github.io/mkdocs-material/
- **GitHub Pages:** https://pages.github.com/
- **Markdown Guide:** https://www.markdownguide.org/

---

**Last Updated:** January 28, 2026
