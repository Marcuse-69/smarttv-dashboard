#!/bin/bash

# Ultra-Robust Dashboard Status Monitor
# Checks the health of all dashboard components

echo "🔍 Smart TV Dashboard - Status Monitor"
echo "======================================"

# Configuration
GITHUB_URL="https://marcuse-69.github.io/smarttv-dashboard/"
LOCAL_URL="http://localhost:58080"
NETWORK_IP=$(ipconfig getifaddr en0 2>/dev/null || echo "N/A")
NETWORK_URL="http://$NETWORK_IP:58080"
TODOIST_API="https://api.todoist.com/rest/v2/tasks"
API_KEY="51b1e593329f927afe4f1ac8a1638b14cfe72f4d"

# Test functions
test_url() {
    local url=$1
    local name=$2
    local timeout=${3:-10}
    
    local status=$(curl -s -o /dev/null -w "%{http_code}" --max-time $timeout "$url" 2>/dev/null)
    local response_time=$(curl -s -o /dev/null -w "%{time_total}" --max-time $timeout "$url" 2>/dev/null)
    
    if [ "$status" = "200" ]; then
        echo "✅ $name: ONLINE (${response_time}s)"
        return 0
    elif [ "$status" = "000" ]; then
        echo "❌ $name: TIMEOUT/UNREACHABLE"
        return 1
    else
        echo "⚠️  $name: HTTP $status"
        return 1
    fi
}

test_todoist_api() {
    echo -n "🔧 Todoist API: "
    local response=$(curl -s -w "%{http_code}" \
        -H "Authorization: Bearer $API_KEY" \
        -H "Content-Type: application/json" \
        --max-time 10 \
        "$TODOIST_API" 2>/dev/null)
    
    local status="${response: -3}"
    local body="${response%???}"
    
    case $status in
        200)
            local task_count=$(echo "$body" | grep -o '"content"' | wc -l | tr -d ' ')
            echo "✅ WORKING ($task_count tasks available)"
            return 0
            ;;
        401)
            echo "❌ UNAUTHORIZED (Check API key)"
            return 1
            ;;
        403)
            echo "❌ FORBIDDEN (API access restricted)"
            return 1
            ;;
        429)
            echo "⚠️  RATE LIMITED (Try again later)"
            return 1
            ;;
        000)
            echo "❌ TIMEOUT/UNREACHABLE"
            return 1
            ;;
        *)
            echo "⚠️  HTTP $status"
            return 1
            ;;
    esac
}

check_local_server() {
    echo -n "🏠 Local Server: "
    if pgrep -f "server.py" > /dev/null; then
        local pid=$(pgrep -f "server.py")
        echo "✅ RUNNING (PID: $pid)"
        return 0
    else
        echo "❌ NOT RUNNING"
        return 1
    fi
}

check_cors_demo() {
    echo -n "🌐 CORS Demo: "
    local status=$(curl -s -o /dev/null -w "%{http_code}" --max-time 10 "https://cors-anywhere.herokuapp.com/corsdemo" 2>/dev/null)
    if [ "$status" = "200" ]; then
        echo "✅ ACCESSIBLE"
        return 0
    else
        echo "⚠️  HTTP $status (May affect online deployment)"
        return 1
    fi
}

# Header with timestamp
echo "📅 $(date)"
echo ""

# Test all components
echo "🌍 HOSTING STATUS:"
test_url "$GITHUB_URL" "GitHub Pages" 15
test_url "$LOCAL_URL" "Local Host" 5
if [ "$NETWORK_IP" != "N/A" ]; then
    test_url "$NETWORK_URL" "Network Access" 5
else
    echo "❌ Network Access: NO IP DETECTED"
fi

echo ""
echo "🔗 API & SERVICES:"
test_todoist_api
check_cors_demo

echo ""
echo "⚙️  LOCAL COMPONENTS:"
check_local_server

# File status
echo ""
echo "📁 FILE STATUS:"
if [ -f "index.html" ]; then
    size=$(stat -f%z "index.html" 2>/dev/null || stat -c%s "index.html" 2>/dev/null)
    modified=$(stat -f%Sm "index.html" 2>/dev/null || stat -c%y "index.html" 2>/dev/null | cut -d' ' -f1)
    echo "✅ index.html: EXISTS (${size} bytes, modified: $modified)"
else
    echo "❌ index.html: MISSING"
fi

if [ -f "index-ultra-robust.html" ]; then
    echo "✅ index-ultra-robust.html: EXISTS"
else
    echo "❌ index-ultra-robust.html: MISSING"
fi

# Git status
echo ""
echo "📤 GIT STATUS:"
if git status >/dev/null 2>&1; then
    local branch=$(git branch --show-current)
    local status=$(git status --porcelain)
    local last_commit=$(git log -1 --pretty=format:"%h %s" 2>/dev/null)
    
    echo "✅ Git Repository: INITIALIZED"
    echo "   📍 Branch: $branch"
    echo "   📝 Last commit: $last_commit"
    
    if [ -n "$status" ]; then
        echo "   ⚠️  Uncommitted changes detected"
    else
        echo "   ✅ Working directory clean"
    fi
else
    echo "❌ Git Repository: NOT INITIALIZED"
fi

echo ""
echo "======================================"
echo "🎯 QUICK ACCESS URLS:"
echo "   🌍 Primary:  $GITHUB_URL"
echo "   🏠 Local:    $LOCAL_URL"
if [ "$NETWORK_IP" != "N/A" ]; then
    echo "   📱 Network:  $NETWORK_URL"
fi
echo ""
echo "🔧 CORS Setup (if needed):"
echo "   🔗 https://cors-anywhere.herokuapp.com/corsdemo"
echo ""
echo "📊 Status check complete: $(date)"
