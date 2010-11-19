From: Rabin Vincent <rabin@rab.in>
Subject: [PATCH] ARM: omap: ensure sched_clock() is notrace
Date: Fri, 19 Nov 2010 21:36:23 +0530
Message-ID: <1290182785-22352-2-git-send-email-rabin@rab.in>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37128 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755036Ab0KSQHj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Nov 2010 11:07:39 -0500
Received: by gyh4 with SMTP id 4so2771069gyh.19
        for <linux-omap@vger.kernel.org>; Fri, 19 Nov 2010 08:07:38 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Rabin Vincent <rabin@rab.in>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Include sched.h to ensure sched_clock() has the notrace
annotation, and mark any functions it calls as notrace
too.

Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/plat-omap/counter_32k.c |   13 +++++++------
 arch/arm/plat-omap/io.c          |    2 +-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 155fe43..c542de3 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -13,6 +13,7 @@
  * NOTE: This timer is not the same timer as the old OMAP1 MPU timer.
  */
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -44,7 +45,7 @@
 static u32 offset_32k __read_mostly;
 
 #ifdef CONFIG_ARCH_OMAP16XX
-static cycle_t omap16xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap16xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP16XX_TIMER_32K_SYNCHRONIZED) - offset_32k;
 }
@@ -53,7 +54,7 @@ static cycle_t omap16xx_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2420
-static cycle_t omap2420_32k_read(struct clocksource *cs)
+static cycle_t notrace omap2420_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -62,7 +63,7 @@ static cycle_t omap2420_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
-static cycle_t omap2430_32k_read(struct clocksource *cs)
+static cycle_t notrace omap2430_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -71,7 +72,7 @@ static cycle_t omap2430_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
-static cycle_t omap34xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap34xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP3430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -80,7 +81,7 @@ static cycle_t omap34xx_32k_read(struct clocksource *cs)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-static cycle_t omap44xx_32k_read(struct clocksource *cs)
+static cycle_t notrace omap44xx_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP4430_32KSYNCT_BASE + 0x10) - offset_32k;
 }
@@ -92,7 +93,7 @@ static cycle_t omap44xx_32k_read(struct clocksource *cs)
  * Kernel assumes that sched_clock can be called early but may not have
  * things ready yet.
  */
-static cycle_t omap_32k_read_dummy(struct clocksource *cs)
+static cycle_t notrace omap_32k_read_dummy(struct clocksource *cs)
 {
 	return 0;
 }
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index b0078cf..1b9a4c2 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -159,7 +159,7 @@ u16 omap_readw(u32 pa)
 }
 EXPORT_SYMBOL(omap_readw);
 
-u32 omap_readl(u32 pa)
+u32 notrace omap_readl(u32 pa)
 {
 	if (cpu_class_is_omap1())
 		return __raw_readl(OMAP1_IO_ADDRESS(pa));
-- 
1.7.2.3

