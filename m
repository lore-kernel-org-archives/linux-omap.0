From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V3 3/3] ARM: OMAP: am33xx: Hook-up am33xx support to existing prm code
Date: Fri, 3 Feb 2012 17:13:56 +0530
Message-ID: <1328269436-18668-4-git-send-email-hvaibhav@ti.com>
References: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51585 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753366Ab2BCLs2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 06:48:28 -0500
In-Reply-To: <1328269436-18668-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, rnayak@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Reuse existing omap4 prminst code for am33xx device,
add separate prm base table for am33xx device and initialize
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
 arch/arm/mach-omap2/io.c          |    1 +
 arch/arm/mach-omap2/omap_hwmod.c  |   44 ++++++++++++++++++++++++++-----------
 arch/arm/mach-omap2/prcm44xx.h    |    2 +
 arch/arm/mach-omap2/prminst44xx.c |    9 +++++++
 4 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index aa33cfb..df94693 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -475,6 +475,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
+	omap44xx_prminst_init();
 	omap3xxx_clk_init();
 }
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e91c4a0..0fb5287 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1289,14 +1289,20 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
-						  ohri.rst_shift);
-	else if (cpu_is_omap44xx())
+	/*
+	 * In order to use omap4 prm code for am33xx family of devices,
+	 * first check cpu_is_am33xx here.
+	 *
+	 * Note: cpu_is_omap34xx is true for am33xx device as well.
+	 */
+	if (cpu_is_omap44xx() || cpu_is_am33xx())
 		return omap4_prminst_assert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
+						  ohri.rst_shift);
 	else
 		return -EINVAL;
 }
@@ -1323,11 +1329,13 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
-						   ohri.rst_shift,
-						   ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	/*
+	 * In order to use omap4 prm code for am33xx family of devices,
+	 * first check cpu_is_am33xx here.
+	 *
+	 * Note: cpu_is_omap34xx is true for am33xx device as well.
+	 */
+	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
 		if (ohri.st_shift)
 			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
 			       oh->name, name);
@@ -1335,6 +1343,10 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
+						   ohri.rst_shift,
+						   ohri.st_shift);
 	} else {
 		return -EINVAL;
 	}
@@ -1365,14 +1377,20 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
-						       ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	/*
+	 * In order to use omap4 prm code for am33xx family of devices,
+	 * first check cpu_is_am33xx here.
+	 *
+	 * Note: cpu_is_omap34xx is true for am33xx device as well.
+	 */
+	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
 		return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
+						       ohri.st_shift);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/prcm44xx.h b/arch/arm/mach-omap2/prcm44xx.h
index 7334ffb..02e5a8b 100644
--- a/arch/arm/mach-omap2/prcm44xx.h
+++ b/arch/arm/mach-omap2/prcm44xx.h
@@ -31,6 +31,8 @@
 #define OMAP4430_CM2_PARTITION			3
 #define OMAP4430_SCRM_PARTITION			4
 #define OMAP4430_PRCM_MPU_PARTITION		5
+/* AM33XX PRCM is closer to OMAP4, so try to reuse all API's */
+#define AM33XX_PRM_PARTITION			1

 /*
  * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 68e13bd..5fd13b4 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -19,6 +19,7 @@
 #include "common.h"

 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
@@ -36,6 +37,11 @@ static u32 *omap44xx_prm_bases[] = {
 	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
 };

+static u32 *am33xx_prm_bases[] = {
+	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
+	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
+};
+
 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
@@ -182,5 +188,8 @@ void __init omap44xx_prminst_init(void)
 	if (cpu_is_omap44xx()) {
 		_prm_bases = omap44xx_prm_bases;
 		max_prm_partitions = ARRAY_SIZE(omap44xx_prm_bases);
+	} else if (cpu_is_am33xx()) {
+		_prm_bases = am33xx_prm_bases;
+		max_prm_partitions = ARRAY_SIZE(am33xx_prm_bases);
 	}
 }
--
1.7.0.4

