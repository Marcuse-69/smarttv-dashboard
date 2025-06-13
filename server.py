#!/usr/bin/env python3
"""
Smart TV Dashboard Local Server
Serves the dashboard on port 8080 with CORS support for API calls
"""

import http.server
import socketserver
import os
import threading
import time
from pathlib import Path

class CORSHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type, Authorization')
        super().end_headers()
    
    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

def start_server():
    PORT = 58080
    DIRECTORY = Path(__file__).parent
    
    os.chdir(DIRECTORY)
    
    with socketserver.TCPServer(("", PORT), CORSHTTPRequestHandler) as httpd:
        print(f"Dashboard server running at http://localhost:{PORT}")
        print(f"Serving files from: {DIRECTORY}")
        print("Press Ctrl+C to stop the server")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\nServer stopped")
            httpd.shutdown()

if __name__ == "__main__":
    start_server()
