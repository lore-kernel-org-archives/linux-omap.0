From: Pavel Machek <pavel@ucw.cz>
Subject: outdated documentation for lp5523 LED driver?
Date: Fri, 15 Jul 2016 09:32:14 +0200
Message-ID: <20160715073214.GC13429@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
Cc: samu.p.onkalo@nokia.com, milo.kim@ti.com, toshik@chromium.org, j.anaszewski@samsung.com, cooloney@gmail.com
List-Id: linux-omap@vger.kernel.org

Hi!

Documentation says that load/leds are only visible in the load mode,
but that does not seem to be true (kernel 4.4.0 on N900).

# 1) Legacy interface - enginex_mode, enginex_load and enginex_leds
#  Control interface for the engines:
#    x is 1 .. 3
#      enginex_mode : disabled, load, run
#      enginex_load : microcode load (visible only in load mode)
#      enginex_leds : led mux control (visible only in load mode)

pavel@n900:/sys/class/leds/lp5523:r/device$ ls -al engine*
-rw-r--r-- 1 root root 4096 Jul  6 22:47 engine1_leds
--w------- 1 root root 4096 Jul  6 22:47 engine1_load
-rw-r--r-- 1 root root 4096 Jul  6 23:41 engine1_mode
-rw-r--r-- 1 root root 4096 Jul  6 22:47 engine2_leds
--w------- 1 root root 4096 Jul  6 22:47 engine2_load
-rw-r--r-- 1 root root 4096 Jul  6 23:41 engine2_mode
-rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_leds
--w------- 1 root root 4096 Jul  6 22:47 engine3_load
-rw-r--r-- 1 root root 4096 Jul  6 22:47 engine3_mode
pavel@n900:/sys/class/leds/lp5523:r/device$ grep . engine*mode
engine1_mode:run
engine2_mode:load
engine3_mode:run
pavel@n900:/sys/class/leds/lp5523:r/device$

I got both the legacy and the firmware interface to work... but the
firmware interface only seems to work once for me.

How new and old interface are expected to interact with each other is
not clear to me.

What should be done there?

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
