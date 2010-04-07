From: felipe.balbi@nokia.com
Subject: [PATCH 1/3] omap: fix clocksource_32k to start from zero
Date: Wed,  7 Apr 2010 12:57:22 +0300
Message-ID: <1270634244-22741-1-git-send-email-felipe.balbi@nokia.com>
References: <20100407072102.GU16297@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25085 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756747Ab0DGJ5x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 05:57:53 -0400
In-Reply-To: <20100407072102.GU16297@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Aaro Koskinen <aaro.koskinen@nokia.com>

From: Aaro Koskinen <aaro.koskinen@nokia.com>

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
 arch/arm/plat-omap/common.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 088c1a0..01cbb48 100644
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
1.7.0.rc0.33.g7c3932

