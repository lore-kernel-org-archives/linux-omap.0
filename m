From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 3/3] arm:omap:omap4: Hook-up am33xx support to existing prm code
Date: Sun, 8 Jan 2012 15:48:14 +0530
Message-ID: <1326017894-7632-4-git-send-email-hvaibhav@ti.com>
References: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59038 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751869Ab2AHKSY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Jan 2012 05:18:24 -0500
In-Reply-To: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

AM33XX PRM module (L4_WK domain) will be treated as another seperate
partition in _prm_bases[] table.
Also, since cpu_is_omap34xx check is true for am33xx family of
devices, we must check cpu_is_am33xx fisrt, in order to follow
omap4 execution path.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c  |   44 ++++++++++++++++++++++++++-----------
 arch/arm/mach-omap2/prcm44xx.h    |    4 ++-
 arch/arm/mach-omap2/prminst44xx.c |    2 +
 3 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..3639f80 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1288,14 +1288,20 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
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
@@ -1322,11 +1328,13 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
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
@@ -1334,6 +1342,10 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
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
@@ -1364,14 +1376,20 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
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
index 7334ffb..d193f91 100644
--- a/arch/arm/mach-omap2/prcm44xx.h
+++ b/arch/arm/mach-omap2/prcm44xx.h
@@ -31,12 +31,14 @@
 #define OMAP4430_CM2_PARTITION			3
 #define OMAP4430_SCRM_PARTITION			4
 #define OMAP4430_PRCM_MPU_PARTITION		5
+/* AM33XX PRCM is closer to OMAP4, so try to reuse all API's */
+#define AM33XX_PRM_PARTITION			6

 /*
  * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
  * IDs, plus one
  */
-#define OMAP4_MAX_PRCM_PARTITIONS		6
+#define OMAP4_MAX_PRCM_PARTITIONS		7


 #endif
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 3d9894f..fcc4123 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -19,6 +19,7 @@
 #include "common.h"

 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
@@ -31,6 +32,7 @@ static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
 	[OMAP4430_CM2_PARTITION]		= 0,
 	[OMAP4430_SCRM_PARTITION]		= 0,
 	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
+	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE),
 };

 /* Read a register in a PRM instance */
--
1.7.0.4

