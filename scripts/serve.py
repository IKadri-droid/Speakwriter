"""Tiny local static file server for SpeakWritter.

Serves the app over http://127.0.0.1 instead of a file:// URL. Chrome/Edge
only remember a "granted" microphone permission reliably for real HTTP(S)
origins; on file:// pages the permission prompt can resurface on every
launch. Loopback HTTP is treated as a secure context, so once the mic is
allowed here it stays allowed for good -- no browser restart, no policy
tweaks required.
"""
import http.server
import socketserver
import sys
import os

if len(sys.argv) < 3:
    print("Usage: serve.py <port> <root_dir>")
    sys.exit(1)

PORT = int(sys.argv[1])
ROOT = sys.argv[2]
os.chdir(ROOT)


class QuietHandler(http.server.SimpleHTTPRequestHandler):
    def log_message(self, format, *args):
        pass  # keep the background process silent


class ReusableServer(socketserver.TCPServer):
    allow_reuse_address = True


with ReusableServer(("127.0.0.1", PORT), QuietHandler) as httpd:
    httpd.serve_forever()
