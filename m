From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/10] OMAP2/3 clockdomains: split shared structures so
	usecounting works
Date: Tue, 05 Jan 2010 15:54:48 -0700
Message-ID: <20100105225445.16474.79779.stgit@localhost.localdomain>
References: <20100105225217.16474.44114.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49852 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539Ab0AEW6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 17:58:22 -0500
In-Reply-To: <20100105225217.16474.44114.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Previously some of the clockdomain wakeup/sleep dependency structures
were shared between several domains.  For the subsequent wakeup and sleep
dependency usecounting patch to work, these can no longer be
shared.  This patch splits the shared structures apart.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains.h |  163 ++++++++++++++++++++++++++++--------
 1 files changed, 127 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index c7cc0e7..894973c 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -52,6 +52,8 @@
  * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
  * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
  * 3430ES2 PM_WKDEP_SGX: adds IVA2, removes CORE
+ * These can share data since they will never be present simultaneously
+ * on the same device.
  */
 static struct clkdm_dep gfx_sgx_wkdeps[] = {
 	{
@@ -86,11 +88,32 @@ static struct clkdm_dep gfx_sgx_wkdeps[] = {
 
 /* Wakeup dependency source arrays */
 
+/* 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP */
+static struct clkdm_dep dsp_24xx_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
+	},
+	{ NULL },
+};
+
 /*
- * 2420/2430 PM_WKDEP_DSP: CORE, MPU, WKUP
- * 2420/2430 PM_WKDEP_MDM: same as DSP
+ * 2420/2430 PM_WKDEP_MDM: CORE, MPU, WKUP
+ * XXX This is probably 2430-only; 2420 did not have a stacked modem config.
  */
-static struct clkdm_dep dsp_mdm_24xx_wkdeps[] = {
+static struct clkdm_dep mdm_24xx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX)
@@ -172,11 +195,8 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 
 #ifdef CONFIG_ARCH_OMAP34XX
 
-/*
- * 3430: PM_WKDEP_{PER,USBHOST}: CORE, IVA2, MPU, WKUP
- * (USBHOST is ES2 only)
- */
-static struct clkdm_dep per_usbhost_wkdeps[] = {
+/* 3430: PM_WKDEP_PER: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep per_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -200,9 +220,32 @@ static struct clkdm_dep per_usbhost_wkdeps[] = {
 	{ NULL },
 };
 
-/*
- * 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER
- */
+/* 3430ES2: PM_WKDEP_USBHOST: CORE, IVA2, MPU, WKUP */
+static struct clkdm_dep usbhost_wkdeps[] = {
+	{
+		.clkdm_name = "core_l3_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "core_l4_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_MPU: CORE, IVA2, DSS, PER */
 static struct clkdm_dep mpu_34xx_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
@@ -227,9 +270,7 @@ static struct clkdm_dep mpu_34xx_wkdeps[] = {
 	{ NULL },
 };
 
-/*
- * 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER
- */
+/* 3430 PM_WKDEP_IVA2: CORE, MPU, WKUP, DSS, PER */
 static struct clkdm_dep iva2_wkdeps[] = {
 	{
 		.clkdm_name = "core_l3_clkdm",
@@ -259,8 +300,25 @@ static struct clkdm_dep iva2_wkdeps[] = {
 };
 
 
-/* 3430 PM_WKDEP_{CAM,DSS}: IVA2, MPU, WKUP */
-static struct clkdm_dep cam_dss_wkdeps[] = {
+/* 3430 PM_WKDEP_CAM: IVA2, MPU, WKUP */
+static struct clkdm_dep cam_wkdeps[] = {
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "wkup_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430 PM_WKDEP_DSS: IVA2, MPU, WKUP */
+static struct clkdm_dep dss_wkdeps[] = {
 	{
 		.clkdm_name = "iva2_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -288,11 +346,8 @@ static struct clkdm_dep neon_wkdeps[] = {
 
 /* Sleep dependency source arrays for 34xx-specific clkdms - 34XX only */
 
-/*
- * 3430: CM_SLEEPDEP_{DSS,PER}: MPU, IVA
- * 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA
- */
-static struct clkdm_dep dss_per_usbhost_sleepdeps[] = {
+/* 3430: CM_SLEEPDEP_DSS: MPU, IVA */
+static struct clkdm_dep dss_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -304,12 +359,48 @@ static struct clkdm_dep dss_per_usbhost_sleepdeps[] = {
 	{ NULL },
 };
 
+/* 3430: CM_SLEEPDEP_PER: MPU, IVA */
+static struct clkdm_dep per_sleepdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430ES2: CM_SLEEPDEP_USBHOST: MPU, IVA */
+static struct clkdm_dep usbhost_sleepdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{
+		.clkdm_name = "iva2_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
+/* 3430: CM_SLEEPDEP_CAM: MPU */
+static struct clkdm_dep cam_sleepdeps[] = {
+	{
+		.clkdm_name = "mpu_clkdm",
+		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
+	},
+	{ NULL },
+};
+
 /*
- * 3430: CM_SLEEPDEP_CAM: MPU
  * 3430ES1: CM_SLEEPDEP_GFX: MPU
  * 3430ES2: CM_SLEEPDEP_SGX: MPU
+ * These can share data since they will never be present simultaneously
+ * on the same device.
  */
-static struct clkdm_dep cam_gfx_sleepdeps[] = {
+static struct clkdm_dep gfx_sgx_sleepdeps[] = {
 	{
 		.clkdm_name = "mpu_clkdm",
 		.omap_chip = OMAP_CHIP_INIT(CHIP_IS_OMAP3430)
@@ -376,7 +467,7 @@ static struct clockdomain iva1_2420_clkdm = {
 	.clkstctrl_reg  = OMAP2420_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
+	.wkdep_srcs	= dsp_24xx_wkdeps,
 	.clktrctrl_mask = OMAP2420_AUTOSTATE_IVA_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
@@ -458,7 +549,7 @@ static struct clockdomain mdm_clkdm = {
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP2430_MDM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP2430_PM_WKDEP_MPU_EN_MDM_SHIFT,
-	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
+	.wkdep_srcs	= mdm_24xx_wkdeps,
 	.clktrctrl_mask = OMAP2430_AUTOSTATE_MDM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -470,7 +561,7 @@ static struct clockdomain dsp_2430_clkdm = {
 	.clkstctrl_reg  = OMAP2430_CM_REGADDR(OMAP24XX_DSP_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP24XX_PM_WKDEP_MPU_EN_DSP_SHIFT,
-	.wkdep_srcs	= dsp_mdm_24xx_wkdeps,
+	.wkdep_srcs	= dsp_24xx_wkdeps,
 	.clktrctrl_mask = OMAP24XX_AUTOSTATE_DSP_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
@@ -575,7 +666,7 @@ static struct clockdomain gfx_3430es1_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(GFX_MOD, OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.sleepdep_srcs	= cam_gfx_sleepdeps,
+	.sleepdep_srcs	= gfx_sgx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES1_CLKTRCTRL_GFX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
 };
@@ -587,7 +678,7 @@ static struct clockdomain sgx_clkdm = {
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.wkdep_srcs	= gfx_sgx_wkdeps,
-	.sleepdep_srcs	= cam_gfx_sleepdeps,
+	.sleepdep_srcs	= gfx_sgx_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -646,8 +737,8 @@ static struct clockdomain dss_34xx_clkdm = {
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_PM_WKDEP_MPU_EN_DSS_SHIFT,
-	.wkdep_srcs	= cam_dss_wkdeps,
-	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
+	.wkdep_srcs	= dss_wkdeps,
+	.sleepdep_srcs	= dss_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_DSS_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -658,8 +749,8 @@ static struct clockdomain cam_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD,
 						 OMAP2_CM_CLKSTCTRL),
-	.wkdep_srcs	= cam_dss_wkdeps,
-	.sleepdep_srcs	= cam_gfx_sleepdeps,
+	.wkdep_srcs	= cam_wkdeps,
+	.sleepdep_srcs	= cam_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_CAM_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
@@ -670,8 +761,8 @@ static struct clockdomain usbhost_clkdm = {
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD,
 						 OMAP2_CM_CLKSTCTRL),
-	.wkdep_srcs	= per_usbhost_wkdeps,
-	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
+	.wkdep_srcs	= usbhost_wkdeps,
+	.sleepdep_srcs	= usbhost_sleepdeps,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
@@ -683,8 +774,8 @@ static struct clockdomain per_clkdm = {
 	.clkstctrl_reg	= OMAP34XX_CM_REGADDR(OMAP3430_PER_MOD,
 						 OMAP2_CM_CLKSTCTRL),
 	.dep_bit	= OMAP3430_EN_PER_SHIFT,
-	.wkdep_srcs	= per_usbhost_wkdeps,
-	.sleepdep_srcs	= dss_per_usbhost_sleepdeps,
+	.wkdep_srcs	= per_wkdeps,
+	.sleepdep_srcs	= per_sleepdeps,
 	.clktrctrl_mask = OMAP3430_CLKTRCTRL_PER_MASK,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };


