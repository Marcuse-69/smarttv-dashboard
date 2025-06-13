#!/bin/bash

# Smart TV Dashboard Installation Script for Mac Mini M4
# This script sets up the dashboard to run 24/7 automatically

echo "🚀 Installing Smart TV Dashboard..."

# Variabelen
DASHBOARD_DIR="/Users/marcusvanesveld/smarttv-dashboard"
PLIST_FILE="com.smarttv.dashboard.plist"
LAUNCHD_DIR="/Users/marcusvanesveld/Library/LaunchAgents"

# Maak LaunchAgents directory als het niet bestaat
mkdir -p "$LAUNCHD_DIR"

# Kopieer plist naar LaunchAgents
echo "📝 Installing launch daemon..."
cp "$DASHBOARD_DIR/$PLIST_FILE" "$LAUNCHD_DIR/"

# Maak server.py executable
chmod +x "$DASHBOARD_DIR/server.py"

# Laad de launch daemon
echo "🔧 Loading launch daemon..."
launchctl load "$LAUNCHD_DIR/$PLIST_FILE"

# Start de service
echo "▶️ Starting dashboard service..."
launchctl start com.smarttv.dashboard

# Wacht even en check status
sleep 3

echo "🔍 Checking service status..."
if launchctl list | grep -q "com.smarttv.dashboard"; then
    echo "✅ Dashboard service is running!"
    echo ""
    echo "🌐 Dashboard URLs:"
    echo "   Local:    http://localhost:8080"
    echo "   Network:  http://$(ifconfig en0 | grep 'inet ' | awk '{print $2}'):8080"
    echo ""
    echo "📁 Dashboard directory: $DASHBOARD_DIR"
    echo "📜 Logs location: $DASHBOARD_DIR/dashboard.log"
    echo ""
    echo "📺 To view on Smart TV, navigate to one of the URLs above"
    echo ""
    echo "🛠️ Management commands:"
    echo "   Stop:    launchctl stop com.smarttv.dashboard"
    echo "   Start:   launchctl start com.smarttv.dashboard" 
    echo "   Restart: launchctl kickstart -k gui/$(id -u)/com.smarttv.dashboard"
    echo "   Unload:  launchctl unload $LAUNCHD_DIR/$PLIST_FILE"
else
    echo "❌ Service failed to start. Check logs:"
    echo "   Dashboard log: $DASHBOARD_DIR/dashboard.log"
    echo "   Error log: $DASHBOARD_DIR/dashboard-error.log"
fi

echo ""
echo "🎉 Installation complete!"
