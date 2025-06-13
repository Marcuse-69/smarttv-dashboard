#!/bin/bash

# Smart TV Dashboard Update Script
# Updates the dashboard with the correct port (8090 instead of 8080)

echo "🔧 Updating Smart TV Dashboard to use port 8090..."

DASHBOARD_DIR="/Users/marcusvanesveld/smarttv-dashboard"

# Stop service
echo "⏹️ Stopping dashboard service..."
launchctl stop com.smarttv.dashboard

# Wait a moment
sleep 2

# Start service
echo "▶️ Starting dashboard service..."
launchctl start com.smarttv.dashboard

# Wait and check
sleep 3

echo "🔍 Checking service status..."
if curl -s -I http://localhost:8090 | grep -q "200 OK"; then
    echo "✅ Dashboard is running successfully!"
    echo ""
    echo "🌐 Updated Dashboard URLs:"
    echo "   Local:    http://localhost:8090"
    echo "   Network:  http://$(ifconfig en0 | grep 'inet ' | awk '{print $2}'):8090"
    echo ""
    echo "📺 Update your Smart TV bookmark to use port 8090"
else
    echo "❌ Service check failed. Please check logs:"
    echo "   tail -f $DASHBOARD_DIR/dashboard-error.log"
fi

echo ""
echo "🎉 Update complete!"
