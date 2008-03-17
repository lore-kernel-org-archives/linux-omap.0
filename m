From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/14] ARM: OMAP: TimerMPU: Remove MPU-timer based sched_clock()
Date: Mon, 17 Mar 2008 11:42:38 +0200
Message-ID: <1205746958-11242-15-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
 <1205746958-11242-5-git-send-email-tony@atomide.com>
 <1205746958-11242-6-git-send-email-tony@atomide.com>
 <1205746958-11242-7-git-send-email-tony@atomide.com>
 <1205746958-11242-8-git-send-email-tony@atomide.com>
 <1205746958-11242-9-git-send-email-tony@atomide.com>
 <1205746958-11242-10-git-send-email-tony@atomide.com>
 <1205746958-11242-11-git-send-email-tony@atomide.com>
 <1205746958-11242-12-git-send-email-tony@atomide.com>
 <1205746958-11242-13-git-send-email-tony@atomide.com>
 <1205746958-11242-14-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64783 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400AbYCQJnz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:55 -0400
In-Reply-To: <1205746958-11242-14-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@mvista.com>, Tony Lindgren <tony@atomide.com>

From: Kevin Hilman <khilman@mvista.com>

Remove MPU-timer based sched_clock() in favor of the common one based
on 32k sync timer which works across all OMAP1/2/3 platforms.

Using 32k based one also gives a valid sched_clock() very early in the
boot process.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/time.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index f6cf2b7..5d2b270 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -227,22 +227,6 @@ static void __init omap_init_clocksource(unsigned long rate)
 		printk(err, clocksource_mpu.name);
 }
 
-
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long ticks = 0 - omap_mpu_timer_read(1);
-	unsigned long long ticks64;
-
-	ticks64 = omap_mpu_timer2_overflows;
-	ticks64 <<= 32;
-	ticks64 |= ticks;
-
-	return cycles_2_ns(ticks64);
-}
-
 /*
  * ---------------------------------------------------------------------------
  * Timer initialization
-- 
1.5.3.6

