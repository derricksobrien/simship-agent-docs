# Deploy site to gh-pages
$site = "site"
$workdir = "$PSScriptRoot\gh-pages-temp"

# Build site first if needed
if (-not (Test-Path $site)) {
    Write-Host "Building site first..."
    python -m pip install mkdocs mkdocs-material 2>&1 | Out-Null
    python -m mkdocs build
}

# Remove temp directory if it exists
if (Test-Path $workdir) { rm $workdir -Recurse -Force }

# Clone gh-pages branch to temp directory
git clone --branch gh-pages --depth 1 https://github.com/derricksobrien/simship-agent-docs.git $workdir

# Copy built site files
if (Test-Path $site) {
    Copy-Item "$site\*" $workdir -Recurse -Force
} else {
    Write-Host "Error: site folder not found!"
    exit 1
}

# Commit and push
cd $workdir
git add .
git commit -m "Deploy: Update documentation with demo completion summary"
git push origin gh-pages

# Cleanup
cd ..
rm $workdir -Recurse -Force

Write-Host "Deployment complete!"
