From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 13/19] clocksource: convert OMAP1 to 32-bit down counting
 clocksource
Date: Mon, 16 May 2011 18:29:55 +0100
Message-ID: <E1QM1cB-0003E5-Qm@rmk-PC.arm.linux.org.uk>
References: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753964Ab1EPRcY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 13:32:24 -0400
In-Reply-To: <20110516172334.GD13659@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-omap@vger.kernel.org

Convert the OMAP1 32-bit down counting clocksource to the generic
clocksource infrastructure.

Tested-by: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/time.c |   23 ++++++-----------------
 arch/arm/plat-omap/Kconfig |    1 +
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index e7ab616..03e1e10 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -190,24 +190,11 @@ static __init void omap_init_mpu_timer(unsigned long rate)
  * ---------------------------------------------------------------------------
  */
 
-static cycle_t mpu_read(struct clocksource *cs)
-{
-	return ~omap_mpu_timer_read(1);
-}
-
-static struct clocksource clocksource_mpu = {
-	.name		= "mpu_timer2",
-	.rating		= 300,
-	.read		= mpu_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static DEFINE_CLOCK_DATA(cd);
 
 static inline unsigned long long notrace _omap_mpu_sched_clock(void)
 {
-	u32 cyc = mpu_read(&clocksource_mpu);
+	u32 cyc = ~omap_mpu_timer_read(1);
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
@@ -225,20 +212,22 @@ static unsigned long long notrace omap_mpu_sched_clock(void)
 
 static void notrace mpu_update_sched_clock(void)
 {
-	u32 cyc = mpu_read(&clocksource_mpu);
+	u32 cyc = ~omap_mpu_timer_read(1);
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static void __init omap_init_clocksource(unsigned long rate)
 {
+	omap_mpu_timer_regs_t __iomem *timer = omap_mpu_timer_base(1);
 	static char err[] __initdata = KERN_ERR
 			"%s: can't register clocksource!\n";
 
 	omap_mpu_timer_start(1, ~0, 1);
 	init_sched_clock(&cd, mpu_update_sched_clock, 32, rate);
 
-	if (clocksource_register_hz(&clocksource_mpu, rate))
-		printk(err, clocksource_mpu.name);
+	if (clocksource_mmio_init(&timer->read_tim, "mpu_timer2", rate,
+			300, 32, clocksource_mmio_readl_down))
+		printk(err, "mpu_timer2");
 }
 
 static void __init omap_mpu_timer_init(void)
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index cd5f993..e9c0efc 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -12,6 +12,7 @@ choice
 config ARCH_OMAP1
 	bool "TI OMAP1"
 	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
 	help
 	  "Systems based on omap7xx, omap15xx or omap16xx"
 
-- 
1.7.4.4

