# 🌍 Online Deployment Guide

## Optie 1: Netlify (Aanbevolen)

1. **Ga naar**: https://www.netlify.com
2. **Registreer** een gratis account
3. **Drag & Drop deployment**:
   - Sleep het bestand `deploy.html` naar de Netlify deployment zone
   - Of upload als `index.html`
4. **Krijg onmiddellijk een URL** zoals: `https://amazing-name-123456.netlify.app`

## Optie 2: Vercel

1. **Ga naar**: https://vercel.com
2. **Registreer** een gratis account  
3. **Upload** het `deploy.html` bestand
4. **Hernoem** naar `index.html` tijdens upload
5. **Deploy** en krijg een URL zoals: `https://smarttv-dashboard-abc123.vercel.app`

## Optie 3: GitHub Pages

1. **Maak** een nieuwe GitHub repository
2. **Upload** `deploy.html` als `index.html`
3. **Ga naar** Settings > Pages
4. **Selecteer** source als "Deploy from a branch"
5. **Kies** main branch
6. **Krijg URL**: `https://username.github.io/repository-name`

## 🔧 CORS Configuratie

De online versie gebruikt een CORS proxy voor Todoist API calls. Als deze niet werkt:

1. **Ga naar**: https://cors-anywhere.herokuapp.com/corsdemo
2. **Klik** "Request temporary access to the demo server"
3. **Refresh** je dashboard

## 📱 Smart TV Configuratie

Na deployment, configureer uw Smart TV:

1. **Open** webbrowser op Smart TV
2. **Navigeer** naar de deployment URL
3. **Bookmark** de pagina
4. **Stel in** als standaard sleep mode pagina

## ⚡ Auto-refresh

De online versie heeft dezelfde auto-refresh functionaliteit:
- **Todoist taken**: elke 5 minuten
- **Google Calendar**: elke 30 minuten  
- **Klok**: elke seconde

Beide versies (lokaal en online) blijven automatisch gesynchroniseerd.
