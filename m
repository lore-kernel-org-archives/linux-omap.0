From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 2/2] ARM: OMAP: am33xx: Hook-up am33xx support to existing cm code
Date: Tue, 14 Feb 2012 20:59:08 +0530
Message-ID: <1329233348-23356-3-git-send-email-hvaibhav@ti.com>
References: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49984 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720Ab2BNPfc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 10:35:32 -0500
In-Reply-To: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

Reuse existing omap4 cminst code for am33xx device,
add separate cm base table for am33xx device and initialize
it during __init for future use.

Also, since cpu_is_omap34xx() check is true for am33xx family of
devices, we must change the order of cpu_is_xxxx check, so first
check for cpu_is_am33xx() to follow right execution path.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
CC: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.c |    9 +++++++++
 arch/arm/mach-omap2/io.c         |    1 +
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++--------
 3 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index f709708..402d35a 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -31,6 +31,7 @@
 #include "cm-regbits-44xx.h"
 #include "prcm44xx.h"
 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prcm_mpu44xx.h"
 
 /*
@@ -61,6 +62,11 @@ static u32 *omap44xx_cm_bases[] = {
 	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };
 
+static u32 *am33xx_cm_bases[] = {
+	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
+	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
+};
+
 /* Private functions */
 
 /**
@@ -358,5 +364,8 @@ void __init omap44xx_cminst_init(void)
 	if (cpu_is_omap44xx()) {
 		_cm_bases = omap44xx_cm_bases;
 		max_cm_partitions = ARRAY_SIZE(omap44xx_cm_bases);
+	} else if (cpu_is_am33xx()) {
+		_cm_bases =am33xx_cm_bases;
+		max_cm_partitions = ARRAY_SIZE(am33xx_cm_bases);
 	}
 }
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index ebcc242..b318b44 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -479,6 +479,7 @@ void __init am33xx_init_early(void)
 	am33xx_voltagedomains_init();
 	omap44xx_prminst_init();
 	am33xx_powerdomains_init();
+	omap44xx_cminst_init();
 	omap3xxx_clk_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 612701e..e4ae811 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -737,7 +737,7 @@ static void _disable_optional_clocks(struct omap_hwmod *oh)
 static void _enable_module(struct omap_hwmod *oh)
 {
 	/* The module mode does not exist prior OMAP4 */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
+	if (!cpu_is_omap44xx() && !cpu_is_am33xx())
 		return;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
@@ -764,7 +764,7 @@ static void _enable_module(struct omap_hwmod *oh)
  */
 static int _omap4_wait_target_disable(struct omap_hwmod *oh)
 {
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() && !cpu_is_am33xx())
 		return 0;
 
 	if (!oh)
@@ -794,7 +794,7 @@ static int _omap4_disable_module(struct omap_hwmod *oh)
 	int v;
 
 	/* The module mode does not exist prior OMAP4 */
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() && !cpu_is_am33xx())
 		return -EINVAL;
 
 	if (!oh->clkdm || !oh->prcm.omap4.modulemode)
@@ -1219,11 +1219,13 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 
 	/* XXX check clock enable states */
 
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_cm_wait_module_ready(oh->prcm.omap2.module_offs,
-						 oh->prcm.omap2.idlest_reg_id,
-						 oh->prcm.omap2.idlest_idle_bit);
-	} else if (cpu_is_omap44xx()) {
+	/*
+	 * In order to use omap4 cminst code for am33xx family of devices,
+	 * first check cpu_is_am33xx here.
+	 *
+	 * Note: cpu_is_omap34xx is true for am33xx device as well.
+	 */
+	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
 		if (!oh->clkdm)
 			return -EINVAL;
 
@@ -1231,6 +1233,11 @@ static int _wait_target_ready(struct omap_hwmod *oh)
 						     oh->clkdm->cm_inst,
 						     oh->clkdm->clkdm_offs,
 						     oh->prcm.omap4.clkctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+			ret = omap2_cm_wait_module_ready(
+						oh->prcm.omap2.module_offs,
+						oh->prcm.omap2.idlest_reg_id,
+						oh->prcm.omap2.idlest_idle_bit);
 	} else {
 		BUG();
 	};
-- 
1.7.0.4

