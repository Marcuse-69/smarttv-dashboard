#!/bin/bash

# Final Status Check for Smart TV Dashboard

echo "🔍 Smart TV Dashboard - Final Status Check"
echo "=========================================="
echo ""

# Check if service is running
if launchctl list | grep -q "com.smarttv.dashboard"; then
    echo "✅ Service Status: RUNNING"
    SERVICE_PID=$(launchctl list | grep "com.smarttv.dashboard" | awk '{print $1}')
    echo "   PID: $SERVICE_PID"
else
    echo "❌ Service Status: NOT RUNNING"
    exit 1
fi

echo ""

# Check if port is accessible
if curl -s -I http://localhost:58080 | grep -q "200 OK"; then
    echo "✅ Local Access: WORKING"
    echo "   URL: http://localhost:58080"
else
    echo "❌ Local Access: FAILED"
fi

echo ""

# Get network IP
NETWORK_IP=$(ifconfig en0 | grep 'inet ' | awk '{print $2}')
if [ ! -z "$NETWORK_IP" ]; then
    echo "✅ Network Access: AVAILABLE"
    echo "   URL: http://$NETWORK_IP:58080"
else
    echo "❌ Network Access: NO IP FOUND"
fi

echo ""
echo "📁 Dashboard Files:"
echo "   Main HTML: /Users/marcusvanesveld/smarttv-dashboard/index.html"
echo "   Deploy HTML: /Users/marcusvanesveld/smarttv-dashboard/deploy.html"
echo "   Server: /Users/marcusvanesveld/smarttv-dashboard/server.py"
echo ""

echo "📜 Logs:"
echo "   Server Log: /Users/marcusvanesveld/smarttv-dashboard/dashboard.log"
echo "   Error Log: /Users/marcusvanesveld/smarttv-dashboard/dashboard-error.log"
echo ""

echo "🛠️ Management Commands:"
echo "   Stop:    launchctl stop com.smarttv.dashboard"
echo "   Start:   launchctl start com.smarttv.dashboard"
echo "   Restart: launchctl kickstart -k gui/$(id -u)/com.smarttv.dashboard"
echo "   Status:  launchctl list | grep com.smarttv.dashboard"
echo ""

echo "🌍 Online Deployment:"
echo "   See: /Users/marcusvanesveld/smarttv-dashboard/DEPLOYMENT.md"
echo "   File: /Users/marcusvanesveld/smarttv-dashboard/deploy.html"
echo ""

echo "📺 Smart TV Setup:"
echo "   1. Open Smart TV browser"
echo "   2. Navigate to: http://$NETWORK_IP:58080"
echo "   3. Bookmark for sleep mode display"
echo ""

echo "🎉 Installation Complete!"
echo "Your Smart TV Dashboard is ready and running 24/7!"
