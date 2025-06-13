# Smart TV Dashboard

Een volledig geautomatiseerd dashboard voor uw Smart TV met Google Calendar en Todoist Eisenhower Matrix.

## 🎯 Functionaliteiten

- **Google Calendar** integratie in dark mode
- **Todoist Eisenhower Matrix** met vier kwadranten:
  - 🔥 Urgent & Important
  - 🎯 Not Urgent & Important  
  - ⚡ Urgent & Not Important
  - 📋 Not Urgent & Not Important
- **Dark theme** geoptimaliseerd voor 32" Full HD op 5m afstand
- **Auto-refresh** elke 5 minuten voor taken, elke 30 minuten voor agenda
- **24/7 automatische hosting** op Mac Mini M4
- **Live klok** met Nederlandse datum/tijd

## 🚀 Installatie

### Automatische installatie:
```bash
cd /Users/marcusvanesveld/smarttv-dashboard
chmod +x install.sh
./install.sh
```

### Handmatige installatie:
1. **Kopieer launch daemon:**
   ```bash
   cp com.smarttv.dashboard.plist ~/Library/LaunchAgents/
   ```

2. **Laad en start service:**
   ```bash
   launchctl load ~/Library/LaunchAgents/com.smarttv.dashboard.plist
   launchctl start com.smarttv.dashboard
   ```

## 🌐 URLs

Na installatie is het dashboard beschikbaar op:
- **Lokaal:** http://localhost:58080
- **Netwerk:** http://192.168.0.117:58080

## 🛠️ Beheer

### Service beheer:
```bash
# Status controleren
launchctl list | grep com.smarttv.dashboard

# Service stoppen
launchctl stop com.smarttv.dashboard

# Service starten  
launchctl start com.smarttv.dashboard

# Service herstarten
launchctl kickstart -k gui/$(id -u)/com.smarttv.dashboard

# Service verwijderen
launchctl unload ~/Library/LaunchAgents/com.smarttv.dashboard.plist
```

### Logs bekijken:
```bash
# Server logs
tail -f dashboard.log

# Error logs  
tail -f dashboard-error.log

# Complete status check
./status.sh
```

## 📁 Bestandsstructuur

```
smarttv-dashboard/
├── index.html                    # Hoofd dashboard
├── server.py                     # Python HTTP server
├── com.smarttv.dashboard.plist   # macOS launch daemon
├── install.sh                    # Installatiescript
├── README.md                     # Deze documentatie
├── dashboard.log                 # Server logs
└── dashboard-error.log           # Error logs
```

## 🔧 Configuratie

### Todoist API
- API key: `e5a7ba7f8c84cfabd09f1b198e688357f90c6026`
- Filter IDs zijn geconfigureerd in `index.html`

### Google Calendar
- Iframe URL is vooraf geconfigureerd in dark mode
- Refresh interval: 30 minuten

### Auto-refresh
- Todoist taken: elke 5 minuten
- Google Calendar: elke 30 minuten
- Klok: elke seconde

## 📺 Smart TV Setup

1. Open de webbrowser op uw Smart TV
2. Navigeer naar `http://[mac-mini-ip]:8080`
3. Stel de TV in om deze URL te tonen bij sleep mode

## 🛡️ Troubleshooting

### Service start niet:
```bash
# Check logs
cat dashboard-error.log

# Herstart service
launchctl kickstart -k gui/$(id -u)/com.smarttv.dashboard
```

### Poort 58080 al in gebruik:
1. Edit `server.py` en wijzig `PORT = 58080` naar een andere poort
2. Herstart service

### Todoist taken laden niet:
1. Controleer internetverbinding
2. Verifieer API key in `index.html`
3. Check browser console voor errors

## 🌍 Online Hosting (Optioneel)

Voor online toegang kunt u de `index.html` deployen naar:
- **Netlify**: Drag & drop `index.html`
- **Vercel**: Upload als static site
- **GitHub Pages**: Push naar repository

Let op: Online hosting vereist CORS-compatibele Todoist API calls.

## 📄 Licentie

Voor persoonlijk gebruik. Todoist API gebruik valt onder hun gebruiksvoorwaarden.
