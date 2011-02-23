From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: clocksource: fix crash on boot when
 !CONFIG_OMAP_32K_TIMER
Date: Tue, 22 Feb 2011 19:59:49 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102221958190.22636@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39549 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab1BWC7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 21:59:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


OMAP2+ kernels built without CONFIG_OMAP_32K_TIMER crash on boot after the
2.6.38 sched_clock changes:

[    0.000000] OMAP clockevent source: GPTIMER1 at 13000000 Hz
[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.000000] pgd = c0004000
[    0.000000] [00000000] *pgd=00000000
[    0.000000] Internal error: Oops: 80000005 [#1] SMP
[    0.000000] last sysfs file:
[    0.000000] Modules linked in:
[    0.000000] CPU: 0    Not tainted  (2.6.38-rc5-00057-g04aa67d #152)
[    0.000000] PC is at 0x0
[    0.000000] LR is at sched_clock_poll+0x2c/0x3c

Without CONFIG_OMAP_32K_TIMER, the kernel has an clockevent and
clocksource resolution about three orders of magnitude higher than
with CONFIG_OMAP_32K_TIMER set.  The tradeoff is that the lowest
power consumption states are not available.

Fix by calling init_sched_clock() from the GPTIMER clocksource init code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/timer-gp.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index 7b7c268..0fc550e 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -39,6 +39,7 @@
 #include <asm/mach/time.h>
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
+#include <asm/sched_clock.h>
 
 #include "timer-gp.h"
 
@@ -190,6 +191,7 @@ static void __init omap2_gp_clocksource_init(void)
 /*
  * clocksource
  */
+static DEFINE_CLOCK_DATA(cd);
 static struct omap_dm_timer *gpt_clocksource;
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
@@ -204,6 +206,15 @@ static struct clocksource clocksource_gpt = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+static void notrace dmtimer_update_sched_clock(void)
+{
+	u32 cyc;
+
+	cyc = omap_dm_timer_read_counter(gpt_clocksource);
+
+	update_sched_clock(&cd, cyc, (u32)~0);
+}
+
 /* Setup free-running counter for clocksource */
 static void __init omap2_gp_clocksource_init(void)
 {
@@ -224,6 +235,8 @@ static void __init omap2_gp_clocksource_init(void)
 
 	omap_dm_timer_set_load_start(gpt, 1, 0);
 
+	init_sched_clock(&cd, dmtimer_update_sched_clock, 32, tick_rate);
+
 	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
 		printk(err2, clocksource_gpt.name);
 }
-- 
1.7.2.3

