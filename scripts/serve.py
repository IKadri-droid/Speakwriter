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


class ReusableThreadingServer(socketserver.ThreadingMixIn, socketserver.TCPServer):
    # A plain TCPServer handles one connection at a time; a lingering
    # keep-alive connection from the browser can then block every other
    # request (including page reloads) until it's closed. ThreadingMixIn
    # spins up a thread per connection so the server stays responsive.
    allow_reuse_address = True
    daemon_threads = True


with ReusableThreadingServer(("127.0.0.1", PORT), QuietHandler) as httpd:
    httpd.serve_forever()
