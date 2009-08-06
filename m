From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 4/6] OMAP3: Show coprocessor details during boot
Date: Thu,  6 Aug 2009 16:06:17 +0530
Message-ID: <1249554977-20429-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47024 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751332AbZHFKgX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 06:36:23 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n76AaHuD026835
	for <linux-omap@vger.kernel.org>; Thu, 6 Aug 2009 05:36:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

Extract details related to coprocessors and print during
the boot process.

Parts of this patch have been derived from an earlier
earlier patch submitted by Tony Lindgren <tony@atomide.com>

 [1] http://marc.info/?l=linux-omap&m=123301852702797&w=2
 [2] http://marc.info/?l=linux-omap&m=123334055822212&w=2

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c                  |  106 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/control.h |   24 +++++++
 2 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 06770aa..da35c01 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -86,6 +86,14 @@ EXPORT_SYMBOL(omap_type);
 #define OMAP_TAP_DIE_ID_2	0x0220
 #define OMAP_TAP_DIE_ID_3	0x0224
 
+#define FEAT_MPU_ONLY		((OMAP343X_SGX_NONE << \
+					OMAP343X_FEATURE_SGX_SHIFT) | \
+						OMAP343X_FEATURE_IVA2_HW_NONE)
+#define FEAT_MPU_SGX		OMAP343X_FEATURE_IVA2_HW_NONE
+#define FEAT_MPU_IVA		(OMAP343X_SGX_NONE << \
+					OMAP343X_FEATURE_SGX_SHIFT)
+#define FEAT_MPU_IVA_SGX	0
+
 #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
 
 struct omap_id {
@@ -163,8 +171,52 @@ void __init omap24xx_check_revision(void)
 	pr_info("\n");
 }
 
-static void __init omap34xx_set_revision(u8 rev, char *rev_name)
+static u32 __init omap3_get_features(char *feat_name)
+{
+	u32 features, module;
+
+	features = omap_ctrl_readl(OMAP343X_CONTROL_FEATURE_OMAP_STATUS) &
+					(OMAP343X_FEATURE_SGX_MASK |
+						OMAP343X_FEATURE_IVA2_HW_NONE);
+
+	module = (features & OMAP343X_FEATURE_SGX_MASK) >>
+					OMAP343X_FEATURE_SGX_SHIFT;
+	switch (module) {
+	case OMAP343X_SGX_FULL:
+		strcat(feat_name, "full speed SGX, ");
+		break;
+	case OMAP343X_SGX_HALF:
+		strcat(feat_name, "half speed SGX, ");
+		break;
+	case OMAP343X_SGX_NONE:
+		strcat(feat_name, "no SGX, ");
+		break;
+	default:
+		strcat(feat_name, "unknown SGX, ");
+		break;
+	}
+
+	module = features & OMAP343X_FEATURE_IVA2_HW_NONE;
+	switch (module) {
+	case 0:
+		strcat(feat_name, "IVA2");
+		break;
+	case OMAP343X_FEATURE_IVA2_HW_NONE:
+		strcat(feat_name, "no IVA2");
+		break;
+	default:
+		break;
+	}
+
+	return features;
+}
+
+static void __init omap34xx_set_revision(u8 rev, char *rev_name, char *features)
 {
+	u32 coprocessors;
+
+	coprocessors = omap3_get_features(features);
+
 	switch (rev) {
 	case 0:
 		omap_revision = OMAP3430_REV_ES2_0;
@@ -189,9 +241,46 @@ static void __init omap34xx_set_revision(u8 rev, char *rev_name)
 	}
 }
 
-static void __init omap35xx_set_revision(u8 rev, u8 gen, char *rev_name)
+static void __init omap35xx_set_revision(u8 rev, u8 gen, char *rev_name,
+						char *features)
 {
-	omap_revision = OMAP35XX_CLASS ;
+	u32 coprocessors;
+
+	coprocessors = omap3_get_features(features);
+
+	if (gen == OMAP35XX_G1) {
+		switch (coprocessors) {
+		case FEAT_MPU_ONLY:
+			omap_revision |= OMAP3503_MASK;
+			break;
+		case FEAT_MPU_SGX:
+			omap_revision |= OMAP3515_MASK;
+			break;
+		case FEAT_MPU_IVA:
+			omap_revision |= OMAP3525_MASK;
+			break;
+		case FEAT_MPU_IVA_SGX:
+			omap_revision |= OMAP3530_MASK;
+			break;
+		default:
+			/* Assume full-featured device */
+			omap_revision |= OMAP3530_MASK;
+			break;
+		}
+	} else {
+		switch (coprocessors) {
+		case FEAT_MPU_ONLY:
+			omap_revision |= OMAP3505_MASK;
+			break;
+		case FEAT_MPU_SGX:
+			omap_revision |= OMAP3517_MASK;
+			break;
+		default:
+			/* Assume full featured device */
+			omap_revision |= OMAP3517_MASK;
+			break;
+		}
+	}
 
 	if (gen == OMAP35XX_G1) {
 		switch (rev) {
@@ -227,7 +316,7 @@ void __init omap34xx_check_revision(void)
 	u32 cpuid, idcode;
 	u16 hawkeye;
 	u8 rev;
-	char rev_name[16] = "";
+	char rev_name[16] = "", feat_name[32] = "";
 
 	/*
 	 * We cannot access revision registers on ES1.0.
@@ -252,15 +341,16 @@ void __init omap34xx_check_revision(void)
 
 	if (hawkeye == 0xb7ae) {
 		if (cpu_is_omap35xx())
-			omap35xx_set_revision(rev, OMAP35XX_G1, rev_name);
+			omap35xx_set_revision(rev, OMAP35XX_G1,
+						rev_name, feat_name);
 		else
-			omap34xx_set_revision(rev, rev_name);
+			omap34xx_set_revision(rev, rev_name, feat_name);
 	} else if (hawkeye == 0xb868) {
-		omap35xx_set_revision(rev, OMAP35XX_G2, rev_name);
+		omap35xx_set_revision(rev, OMAP35XX_G2, rev_name, feat_name);
 	}
 
 out:
-	pr_info("OMAP%04x %s\n", omap_rev() >> 16, rev_name);
+	pr_info("OMAP%04x %s (%s)\n", omap_rev() >> 16, rev_name, feat_name);
 }
 
 /*
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 8140dbc..43e0a92 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -181,6 +181,30 @@
 #define OMAP2_SYSBOOT_1_MASK		(1 << 1)
 #define OMAP2_SYSBOOT_0_MASK		(1 << 0)
 
+/* CONTROL_FEATURE_OMAP_STATUS register and bits */
+#define OMAP343X_CONTROL_FEATURE_OMAP_STATUS  0x044c
+
+#define OMAP343X_FEATURE_SGX_MASK		(0x3 << 13)
+#define OMAP343X_FEATURE_SGX_SHIFT		13
+#define OMAP343X_SGX_FULL			0
+#define OMAP343X_SGX_HALF			1
+#define OMAP343X_SGX_NONE			2
+
+#define OMAP343X_FEATURE_IVA2_HW_NONE		(1 << 12)
+
+#define OMAP343X_FEATURE_L2_CACHE_MASK		(0x3 << 10)
+#define OMAP343X_FEATURE_L2_CACHE_SHIFT		10
+#define OMAP343X_L2_0KB				0
+#define OMAP343X_L2_64KB			1
+#define OMAP343X_L2_128KB			2
+#define OMAP343X_L2_256KB			3
+
+#define OMAP343X_FEATURE_ARM_MHZ_MASK		(0x3 << 8)
+#define OMAP343X_FEATURE_ARM_MHZ_SHIFT		8
+
+#define OMAP343X_FEATURE_IVA2_MHZ_MASK		(0x3 << 6)
+#define OMAP343X_FEATURE_IVA2_MHZ_SHIFT		6
+
 /* CONTROL_PBIAS_LITE bits */
 #define OMAP343X_PBIASLITESUPPLY_HIGH1	(1 << 15)
 #define OMAP343X_PBIASLITEVMODEERROR1	(1 << 11)
-- 
1.6.2.2

