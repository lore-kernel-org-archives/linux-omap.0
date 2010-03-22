From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v2] omap: fix clocksource_32k to start from zero
Date: Mon, 22 Mar 2010 19:03:23 +0200
Message-ID: <1269277403-461-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:45944 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755350Ab0CVRBI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Mar 2010 13:01:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: khilman@deeprootsystems.com

When the 32k sync timer is used for sched_clock(), it should count
time from the kernel boot (clocksource init) instead of the last HW
reset. Otherwise printk.time values will jump suddenly during the boot:

	[    0.000000] calling  omap2_clk_arch_init+0x0/0x138 @ 1
	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned -22 after 0 usecs
	[    0.000000] initcall omap2_clk_arch_init+0x0/0x138 returned with error code -22
	[    0.000000] calling  omap_init_clocksource_32k+0x0/0x98 @ 1
	[  508.697937] initcall omap_init_clocksource_32k+0x0/0x98 returned 0 after 0 usecs
	[  508.697967] calling  omap_init_devices+0x0/0x38 @ 1
	[  508.698425] initcall omap_init_devices+0x0/0x38 returned 0 after 0 usecs

This will confuse tools such as scripts/bootgraph.pl.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
---

v2: Added a comment explaining the offset_32k variable.

The previous version of the patch:
https://patchwork.kernel.org/patch/86945/

 arch/arm/plat-omap/common.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 088c1a0..bd2df89 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -100,10 +100,17 @@ EXPORT_SYMBOL(omap_get_var_config);
 
 #include <linux/clocksource.h>
 
+/*
+ * offset_32k holds the init time counter value. It is then subtracted
+ * from every counter read to achieve a counter that counts time from the
+ * kernel boot (needed for sched_clock()).
+ */
+static u32 offset_32k __read_mostly;
+
 #ifdef CONFIG_ARCH_OMAP16XX
 static cycle_t omap16xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED);
+	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
 }
 #else
 #define omap16xx_32k_read	NULL
@@ -112,7 +119,7 @@ static cycle_t omap16xx_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP2420
 static cycle_t omap2420_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10);
+	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
 }
 #else
 #define omap2420_32k_read	NULL
@@ -121,7 +128,7 @@ static cycle_t omap2420_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP2430
 static cycle_t omap2430_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10);
+	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
 #else
 #define omap2430_32k_read	NULL
@@ -130,7 +137,7 @@ static cycle_t omap2430_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP3
 static cycle_t omap34xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10);
+	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
 #else
 #define omap34xx_32k_read	NULL
@@ -139,7 +146,7 @@ static cycle_t omap34xx_32k_read(struct clocksource *cs)
 #ifdef CONFIG_ARCH_OMAP4
 static cycle_t omap44xx_32k_read(struct clocksource *cs)
 {
-	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10);
+	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
 #else
 #define omap44xx_32k_read	NULL
@@ -227,6 +234,8 @@ static int __init omap_init_clocksource_32k(void)
 		clocksource_32k.mult = clocksource_hz2mult(32768,
 					    clocksource_32k.shift);
 
+		offset_32k = clocksource_32k.read(&clocksource_32k);
+
 		if (clocksource_register(&clocksource_32k))
 			printk(err, clocksource_32k.name);
 	}
-- 
1.5.6.5

