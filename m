From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] omap2+: Rename timer-gp.c into timer.c to combine timer
	init functions
Date: Mon, 20 Jun 2011 02:23:50 -0700
Message-ID: <20110620092350.357.24851.stgit@kaulin>
References: <20110620091754.357.56441.stgit@kaulin>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:54598 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753057Ab1FTJXv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Jun 2011 05:23:51 -0400
In-Reply-To: <20110620091754.357.56441.stgit@kaulin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We can keep everything sys_timer and gptimer.c related code in
timer.c as the code will be very minimal.

Later on we can also remove timer-mpu.c, as it can be called from
omap4_timer_init function.

This allows us to get rid of confusing existing files. We currently
have timer-gp.c, timer-mpu.c, and patches have been posted to add
dmtimer.c. There's no need to have these multiple files, we can
put everything into timer.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile   |    2 +-
 arch/arm/mach-omap2/timer.c    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/mach-omap2/{timer-gp.c => timer.c} (99%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b148077..adbe82d 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o
 
 omap-2-3-common				= irq.o sdrc.o
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer.c
similarity index 99%
rename from arch/arm/mach-omap2/timer-gp.c
rename to arch/arm/mach-omap2/timer.c
index 08cbb34..796b935 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -1,5 +1,5 @@
 /*
- * linux/arch/arm/mach-omap2/timer-gp.c
+ * linux/arch/arm/mach-omap2/timer.c
  *
  * OMAP2 GP timer support.
  *
@@ -230,7 +230,7 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 /* Clocksource code */
 
 #ifdef CONFIG_OMAP_32K_TIMER
-/* 
+/*
  * When 32k-timer is enabled, don't use GPTimer for clocksource
  * instead, just leave default clocksource which uses the 32k
  * sync counter.  See clocksource setup in plat-omap/counter_32k.c

