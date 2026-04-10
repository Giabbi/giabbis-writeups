---
layout: default
title: "Giabbi's Writeups"
---


<!-- HERO HEADER -->

<section class="hero" style="
    width: 100vw;
    margin-left: calc(50% - 50vw);
    position: relative;
    overflow: hidden;
    text-align: center;
    padding: 60px 20px;
    color: #0f0;
    background: url({{'/assets/images/banner.png' | relative_url }}) top center repeat;
    background-size: auto 260px;
    box-sizing: border-box;
  ">
  <div style="
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: rgba(0, 0, 0, 0.75);
      z-index: 1;
    "></div>
  <div style="
      position: relative;
      z-index: 2;
      max-width: 100%;
      margin: 0 auto;
    ">
    <h1 style="
        font-size: min(2.5em, 10vw);
        margin-bottom: 0.5em;
        line-height: 1.2;
      ">
      Giabbi's CTF Writeups
    </h1>
    <p style="
        font-size: min(1.2em, 5vw);
        margin-bottom: 1em;
        line-height: 1.4;
      ">
      If it worked on the first try, I'd be suspicious
    </p>
  </div>
</section>


<!-- BIO SECTION -->
<section class="bio-section" style=" padding: 10px; border-radius: 6px; margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">About Me</h2>
  <p>
    Ciao bello! I’m <strong>Giabbi</strong>, short for my name, Giancarlo Umberto. I'm an Italian-born cybersecurity enthusiast and CS student at Carnegie Mellon University. I built this site to both track my journey and have some fun (and by fun I mean flexing my skills of course). Here's some stuff I like to do:
  </p>
  <ul style="margin-left: 1.2em; line-height: 1.6;">
    <li>Solving challenges on TryHackMe or similar websites and learning from every win (and every “wait, why did that work?”)</li>
    <li>Teaching CS to people of every age, which secretly helps me sharpen my own skills</li>
    <li>Experimenting with AWS, tinkering with my raspberry pi, and the occasional overly ambitious Python project (hey, no one died... yet)</li>
  </ul>
  <p>
    I log everything here, failures included, because if I forget how I solved something, chances are someone else might too. If you’re learning like me, benvenuto amico mio! 
  </p>
</section>


<!-- STATS SECTION -->
<section class="stats" style="margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">My Stats</h2>
<div style="width: 100%; max-width: 360px; margin: 0 auto; text-align: center;">
    <iframe
      src="https://tryhackme.com/api/v2/badges/public-profile?userPublicId=2870064"
      style="
        border: none;
        width: 360px;
        height: 120px;
        transform: scale(1.5);
        transform-origin: center top;
        display: block;
      "
      scrolling="no"
      loading="lazy"
    ></iframe>
  </div>
</section>

<!-- FEATURED CHALLENGES -->
<section id="featured" style="margin: 40px 0; text-align:center;">
  <h2 style="color: #0f0; margin-bottom: 1em;">Featured Challenges</h2>
    <div style="display: grid;
                grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                gap: 100px;">

      {% comment %}
        1. Filter to pages that have a banner
        2. Sort by date descending
        3. Take the first 3
      {% endcomment %}
      {% assign candidates = site.writeups | where_exp:"p","p.banner" %}
      {% assign sorted     = candidates  | sort: "date" | reverse %}
      {% assign featured   = sorted      | slice: 0, 3 %}

      {% for page in featured %}
      <div style="
          padding: 20px;
          border: 1px solid #333;
          border-radius: 6px;
          text-align: center;
          background-color: #1a1a1a;
        ">
        <h3 style="margin-bottom: 0.5em; color: #fff;">
          {% if forloop.first %}
            <span style="
                color: #0f0;
                font-size: 1em;          
                font-weight: bold;
                margin-right: 0.3em;     
              ">
              [NEW]
            </span>
          {% endif %}
          {{ page.title 
            | split: "|" 
            | first 
            | strip 
          }}
        </h3>

        <img
          src="{{ page.banner | relative_url }}"
          alt="{{ page.title }} banner"
          style="
            width: 100%;
            height: auto;
            border-radius: 4px;
            margin-bottom: 1em;
          " />

        <a href="{{ page.url | relative_url }}"
          style="
            color: #0f0;
            background-color: #111;
            padding: 8px 16px;
            text-decoration: none;
            display: inline-block;
            border: 1px solid #0f0;
            border-radius: 4px;
          "
          onmouseover="this.style.backgroundColor='#0f0'; this.style.color='#000';"
          onmouseout="this.style.backgroundColor='#111'; this.style.color='#0f0';">
          Read Write‑up ⟶
        </a>
      </div>
    {% endfor %}
  </div>


  <p style="text-align: center; margin-top: 1em;">
    <a href="{{ '/writeups/' | relative_url }}"
       style="color: #0f0; text-decoration: none; font-weight: bold;">
      See all write‑ups ⟶
    </a>
  </p>
</section>



<!-- WHAT’S INSIDE -->
<section id="features" style="margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">What’s Inside</h2>
  <ul style="margin-left: 1.2em; line-height: 1.6;">
    <li>Step‑by‑step solutions to CTF challenges</li>
    <li>Insights into cybersecurity concepts like XSS, SQL injection, network exploitation, and more.</li>
    <li>Useful payloads, tools, and techniques applied during the challenges.</li>
    <li>Key takeaways and lessons learned.</li>
    <li>Some Italian stuff (bisogna portare avanti il tricolore 🇮🇹)</li>
  </ul>
</section>

<!-- WRITEUP STRUCTURE -->
<section id="structure" style="margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">Structure of Each Write‑up</h2>
  <ol style="margin-left: 1.2em; line-height: 1.6;">
    <li><strong>Introduction:</strong>  A brief description of the challenge and its objectives.</li>
    <li><strong>Steps to Solve:</strong> Walkthrough with payloads &amp; screenshots</li>
    <li><strong>Key Learnings:</strong> What I picked up (or tripped on)</li>
    <li><strong>Conclusion:</strong> Final thoughts on the challenge, and the aforementioned Italian stuff (evviva!) </li>
  </ol>
</section>

<!-- TOOLS & TECHNOLOGIES -->
<section id="tools" style="margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">Tools &amp; Tech</h2>
  <p>
    Python &nbsp;•&nbsp; Burp Suite &nbsp;•&nbsp; Wireshark &nbsp;•&nbsp; Nmap &nbsp;•&nbsp; Custom Scripts
  </p>
  <p style="font-style: italic; margin-top: 0.5em;">
      Remember! You are not a script kiddie if you know what's going on (I hope).
  </p>
</section>

<!-- CONTRIBUTING -->
<section id="contributing" style="margin: 40px 0; color: #ccc;">
  <h2 style="color: #0f0; margin-bottom: 0.5em;">Contributing</h2>
  <p>
    While this repository is primarily for my personal learning journey, contributions and suggestions are welcome! If you'd like to share your own insights or point out improvements, feel free to open an issue or create a pull request. The repository containing this website can be found <a href="https://github.com/Giabbi/giabbis-writeups">here</a>.
  </p>
</section>

<!-- CALL TO ACTION -->
<section id="cta" style="text-align: center; padding: 40px 20px; margin: 40px 0; color: #0f0;">
  <p style="font-size: 1.2em; margin: 0;">
    Ed ora hackerate miei amici, e portate in alto il nome del Gabibbo!
  </p>
</section>
<script>
  function adjustTHMBadge() {
    const badge = document.querySelector('.stats iframe');
    if (!badge) return;

    badge.style.display = 'inline-block';
    
    if (window.innerWidth < 768) {
      // Mobile: drop the scale, let it fill its container
      badge.style.transform       = 'none';
      badge.style.width           = '100%';
      badge.style.height          = 'auto';
      badge.style.transformOrigin = '';
    } else {
      // Desktop: restore 1.5× look
      badge.style.transform       = 'scale(1.5)';
      badge.style.transformOrigin = 'center top';
      badge.style.width           = '360px';
      badge.style.height          = '120px';
    }
  }

  document.addEventListener('DOMContentLoaded', adjustTHMBadge);
  window.addEventListener('resize',   adjustTHMBadge);
</script>
