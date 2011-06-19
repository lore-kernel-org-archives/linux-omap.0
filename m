From: linxz02@ovi.com
Subject: [pm] keep Cortex M3 cores running while OMAP4 is suspended?
Date: Sat, 18 Jun 2011 22:07:31 -0700 (PDT)
Message-ID: <882569.33615.qm@web121412.mail.ne1.yahoo.com>
Reply-To: linxz02@ovi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nm18-vm1.bullet.mail.ne1.yahoo.com ([98.138.91.64]:49094 "HELO
	nm18-vm1.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750789Ab1FSFNZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 19 Jun 2011 01:13:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi All,

I was wondering whether it is possible to keep the Cortex M3 cores running while the OMAP processor is suspended. 

My testing environment was simple: I used Pandaboard (OMAP4430) and kernel 2.6.35. I wrote an M3 program to toggle one GPIO pin (which drives a LED). As long as the M3 program is running, the LED will blink.

On the kernel side, I tried to change the suspend functions in arch/arm/mach-omap2/pm44xx.c. I set the states of core_pwrdm and l4per_pwrdm to ON, right before the system suspends. However, when the system was suspended (omap4_pm_suspend() was invoked), the LED stopped to blink. I think the M3 cores were powered off then.

Did I miss anything? I'll really appreciate any input. Thanks!

-Felix

