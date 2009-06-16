From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: OMAP3 PM: off-mode during idle, problem with UART1 console
Date: Tue, 16 Jun 2009 14:05:02 -0700
Message-ID: <87iqiv28ld.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:45223 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbZFPVFD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jun 2009 17:05:03 -0400
Received: by pxi27 with SMTP id 27so1200403pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 16 Jun 2009 14:05:04 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>, Richard Woodruff <r-woodruff2@ti.com>
Cc: linux-omap@vger.kernel.org

Rajendra, Richard,

Hoping you can shed some light, or give me some direction on where to
debug this further...

With the latest PM branch, I've notice that off-while idle isn't
working on the SDP, but the same kernel works fine on the RX51.
RET-while-idle works fine on both.  This is with CPUidle disabled, so
just using the default idle where MPU and CORE are changed together.

More specifically, it seems to be the UART1 (CORE) console that never
comes back from off-while-idle, but the UART3 (PER) console on RX51
works.

On SDP, if I

# echo 1 > /sys/power/enable_off_mode
# echo 1 > /sys/power/voltage_off_while_idle
# echo 1 > /sys/power/sleep_while_idle

After the UART inactivty timeout of 5 seconds, I start to see the
sys_off_mode LED toggling between red and green with system timer
wakeups.

If I then push a key on the UART1 console, the LED goes green, stays
for the 5 second UART inactivity and then goes back to toggling
red/green again.  However, I never get my console back and never see
the characters on my console.

If I keep typing, I keep the system from going back off (based on
sys_off_mode LED) and as soon as I stop typing long enough for the
inactivity timer to expiere (5 seconds) it goes back into off.

Any ideas what's going on here?

On RX51, the same thing works using UART3.

Kevin

