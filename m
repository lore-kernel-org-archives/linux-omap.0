From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 11/40] ARM: omap: update clock source registration
Date: Fri, 17 Dec 2010 11:39:03 +0000
Message-ID: <E1PTYeN-0006iM-HY@rmk-PC.arm.linux.org.uk>
References: <20101217113223.GC9937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35723 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751153Ab0LQLj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 06:39:26 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

In d7e81c2 (clocksource: Add clocksource_register_hz/khz interface) new
interfaces were added which simplify (and optimize) the selection of the
divisor shift/mult constants.  Switch over to using this new interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c       |    6 +-----
 arch/arm/mach-omap2/timer-gp.c   |    5 +----
 arch/arm/plat-omap/counter_32k.c |    6 +-----
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index 1be6a21..abb34ff 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -208,7 +208,6 @@ static struct clocksource clocksource_mpu = {
 	.rating		= 300,
 	.read		= mpu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -217,13 +216,10 @@ static void __init omap_init_clocksource(unsigned long rate)
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
-	clocksource_mpu.mult
-		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
-
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
 	omap_mpu_timer_start(1, ~0, 1);
 
-	if (clocksource_register(&clocksource_mpu))
+	if (clocksource_register_hz(&clocksource_mpu, rate))
 		printk(err, clocksource_mpu.name);
 }
 
diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
index e13c29e..a7816db 100644
--- a/arch/arm/mach-omap2/timer-gp.c
+++ b/arch/arm/mach-omap2/timer-gp.c
@@ -195,7 +195,6 @@ static struct clocksource clocksource_gpt = {
 	.rating		= 300,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -220,9 +219,7 @@ static void __init omap2_gp_clocksource_init(void)
 
 	omap_dm_timer_set_load_start(gpt, 1, 0);
 
-	clocksource_gpt.mult =
-		clocksource_khz2mult(tick_rate/1000, clocksource_gpt.shift);
-	if (clocksource_register(&clocksource_gpt))
+	if (clocksource_register_hz(&clocksource_gpt, tick_rate))
 		printk(err2, clocksource_gpt.name);
 }
 #endif
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 155fe43..8f149f5 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -102,7 +102,6 @@ static struct clocksource clocksource_32k = {
 	.rating		= 250,
 	.read		= omap_32k_read_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
-	.shift		= 10,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
@@ -167,12 +166,9 @@ static int __init omap_init_clocksource_32k(void)
 		if (sync_32k_ick)
 			clk_enable(sync_32k_ick);
 
-		clocksource_32k.mult = clocksource_hz2mult(32768,
-					    clocksource_32k.shift);
-
 		offset_32k = clocksource_32k.read(&clocksource_32k);
 
-		if (clocksource_register(&clocksource_32k))
+		if (clocksource_register_hz(&clocksource_32k, 32768))
 			printk(err, clocksource_32k.name);
 	}
 	return 0;
-- 
1.6.2.5

