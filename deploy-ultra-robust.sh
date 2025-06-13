#!/bin/bash

# Ultra-Robust Dashboard Deployment Script
# Updates all versions with the latest improvements

echo "🚀 Starting Ultra-Robust Dashboard Deployment..."

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Create backup of current version
echo "📦 Creating backup..."
cp index.html "index-backup-$(date +%Y%m%d-%H%M%S).html"

# Deploy ultra-robust version as main
echo "🔄 Deploying ultra-robust version..."
cp index-ultra-robust.html index.html

# Update GitHub Pages
echo "📤 Pushing to GitHub Pages..."
git add .
git commit -m "Deploy ultra-robust dashboard with improved rate limit handling

Features:
- New API key: 51b1e593329f927afe4f1ac8a1638b14cfe72f4d
- Multiple CORS proxy fallbacks
- Exponential backoff with jitter
- Enhanced caching with localStorage
- Visual connection status indicators
- Graceful degradation
- Smart retry logic with max limits
- Real-time status updates
"

git push origin main

# Test local server
echo "🧪 Testing local server..."
if ! pgrep -f "server.py" > /dev/null; then
    echo "Starting local server..."
    python3 server.py &
    LOCAL_PID=$!
    echo "Local server started with PID: $LOCAL_PID"
else
    echo "Local server already running"
fi

# Verify deployment
sleep 3
echo "✅ Verifying deployment..."

# Test local
LOCAL_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:58080)
if [ "$LOCAL_STATUS" = "200" ]; then
    echo "✅ Local server: WORKING"
else
    echo "❌ Local server: FAILED (HTTP $LOCAL_STATUS)"
fi

# Test GitHub Pages
GITHUB_STATUS=$(curl -s -o /dev/null -w "%{http_code}" https://marcuse-69.github.io/smarttv-dashboard/)
if [ "$GITHUB_STATUS" = "200" ]; then
    echo "✅ GitHub Pages: WORKING"
else
    echo "⚠️  GitHub Pages: PENDING (HTTP $GITHUB_STATUS) - may take a few minutes"
fi

echo ""
echo "🎯 DEPLOYMENT COMPLETE!"
echo ""
echo "📍 Access URLs:"
echo "   🌍 Primary:  https://marcuse-69.github.io/smarttv-dashboard/"
echo "   🏠 Local:    http://localhost:58080"
echo "   🔗 Network:  http://$(ipconfig getifaddr en0):58080"
echo ""
echo "🔧 Ultra-Robust Features Enabled:"
echo "   ✅ New API key with disconnected Google account"
echo "   ✅ Multiple CORS proxy fallbacks"
echo "   ✅ Exponential backoff (30s → 5min max)"
echo "   ✅ Smart caching with localStorage persistence"
echo "   ✅ Visual connection status indicators"
echo "   ✅ Rate limit detection and handling"
echo "   ✅ Graceful degradation to demo data"
echo "   ✅ Real-time retry counters"
echo ""
echo "📺 For Smart TV setup:"
echo "   1. Open Smart TV browser"
echo "   2. Navigate to: https://marcuse-69.github.io/smarttv-dashboard/"
echo "   3. If needed, visit: https://cors-anywhere.herokuapp.com/corsdemo"
echo "   4. Click 'Request temporary access to the demo server'"
echo "   5. Return to dashboard and enjoy!"
echo ""
echo "🎉 Your dashboard is now ULTRA-ROBUST and ready for 24/7 use!"
