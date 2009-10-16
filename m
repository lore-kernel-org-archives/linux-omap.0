From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: [PATCHV2] OMAP3: PM: Removing redundant and potentially dangerous
 PRCM configration
Date: Fri, 16 Oct 2009 21:26:37 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA174C6D@dbde02.ent.ti.com>
References: <FCCFB4CDC6E5564B9182F639FC35608702FA1748E0@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56056 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932637AbZJPP5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Oct 2009 11:57:33 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC35608702FA1748E0@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>

As part of Core domain context restoration while coming out of off mode
there are some registers being restored which are not required to be restored.
ROM code should have restored them already. Overwriting some of them can have
potential side effect. Eg: CM_CLKEN_PLL register should not be written while dpll is locked.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index fb864cc..88182a8 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -43,7 +43,6 @@ struct omap3_prcm_regs {
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
 	u32 sgx_cm_clksel;
-	u32 wkup_cm_clksel;
 	u32 dss_cm_clksel;
 	u32 cam_cm_clksel;
 	u32 per_cm_clksel;
@@ -52,7 +51,6 @@ struct omap3_prcm_regs {
 	u32 pll_cm_autoidle2;
 	u32 pll_cm_clksel4;
 	u32 pll_cm_clksel5;
-	u32 pll_cm_clken;
 	u32 pll_cm_clken2;
 	u32 cm_polctrl;
 	u32 iva2_cm_fclken;
@@ -76,7 +74,6 @@ struct omap3_prcm_regs {
 	u32 usbhost_cm_iclken;
 	u32 iva2_cm_autiidle2;
 	u32 mpu_cm_autoidle2;
-	u32 pll_cm_autoidle;
 	u32 iva2_cm_clkstctrl;
 	u32 mpu_cm_clkstctrl;
 	u32 core_cm_clkstctrl;
@@ -279,7 +276,6 @@ void omap3_prcm_save_context(void)
 	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
 	prcm_context.sgx_cm_clksel =
 			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
-	prcm_context.wkup_cm_clksel = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_context.dss_cm_clksel =
 			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
 	prcm_context.cam_cm_clksel =
@@ -296,8 +292,6 @@ void omap3_prcm_save_context(void)
 			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
 	prcm_context.pll_cm_clksel5 =
 			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
-	prcm_context.pll_cm_clken =
-			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_context.pll_cm_clken2 =
 			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
@@ -343,8 +337,6 @@ void omap3_prcm_save_context(void)
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
 	prcm_context.mpu_cm_autoidle2 =
 			 cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
-	prcm_context.pll_cm_autoidle =
-			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
 	prcm_context.iva2_cm_clkstctrl =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
 	prcm_context.mpu_cm_clkstctrl =
@@ -436,7 +428,6 @@ void omap3_prcm_restore_context(void)
 	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
 	cm_write_mod_reg(prcm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
 					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.wkup_cm_clksel, WKUP_MOD, CM_CLKSEL);
 	cm_write_mod_reg(prcm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
 					 CM_CLKSEL);
 	cm_write_mod_reg(prcm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
@@ -453,7 +444,6 @@ void omap3_prcm_restore_context(void)
 					OMAP3430ES2_CM_CLKSEL4);
 	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
 					 OMAP3430ES2_CM_CLKSEL5);
-	cm_write_mod_reg(prcm_context.pll_cm_clken, PLL_MOD, CM_CLKEN);
 	cm_write_mod_reg(prcm_context.pll_cm_clken2, PLL_MOD,
 					OMAP3430ES2_CM_CLKEN2);
 	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
@@ -492,7 +482,6 @@ void omap3_prcm_restore_context(void)
 	cm_write_mod_reg(prcm_context.iva2_cm_autiidle2, OMAP3430_IVA2_MOD,
 					CM_AUTOIDLE2);
 	cm_write_mod_reg(prcm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.pll_cm_autoidle, PLL_MOD, CM_AUTOIDLE);
 	cm_write_mod_reg(prcm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
 					CM_CLKSTCTRL);
 	cm_write_mod_reg(prcm_context.mpu_cm_clkstctrl, MPU_MOD, CM_CLKSTCTRL);
