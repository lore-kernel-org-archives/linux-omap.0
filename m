From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 08/13] OMAP3: PM: Removing redundant and potentially dangerous PRCM configration
Date: Fri,  8 Jan 2010 09:59:26 -0800
Message-ID: <1262973571-25796-9-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-2-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-3-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-4-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-5-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-6-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-7-git-send-email-khilman@deeprootsystems.com>
 <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:47107 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0AHR7t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 12:59:49 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so160327pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 08 Jan 2010 09:59:49 -0800 (PST)
In-Reply-To: <1262973571-25796-8-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

From: Sripathy, Vishwanath <vishwanath.bs@ti.com>

As part of Core domain context restoration while coming out of off mode
there are some registers being restored which are not required to be restored.
ROM code will have restored them already. Overwriting some of them can have
potential side effect. Eg: CM_CLKEN_PLL register should not be written while dpll is locked.
Tested on OMAP 3430 SDP for suspend/resume and off mode with sleep_while_idle enabled.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..cf466ea 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -44,7 +44,6 @@ struct omap3_prcm_regs {
 	u32 iva2_cm_clksel2;
 	u32 cm_sysconfig;
 	u32 sgx_cm_clksel;
-	u32 wkup_cm_clksel;
 	u32 dss_cm_clksel;
 	u32 cam_cm_clksel;
 	u32 per_cm_clksel;
@@ -53,7 +52,6 @@ struct omap3_prcm_regs {
 	u32 pll_cm_autoidle2;
 	u32 pll_cm_clksel4;
 	u32 pll_cm_clksel5;
-	u32 pll_cm_clken;
 	u32 pll_cm_clken2;
 	u32 cm_polctrl;
 	u32 iva2_cm_fclken;
@@ -77,7 +75,6 @@ struct omap3_prcm_regs {
 	u32 usbhost_cm_iclken;
 	u32 iva2_cm_autiidle2;
 	u32 mpu_cm_autoidle2;
-	u32 pll_cm_autoidle;
 	u32 iva2_cm_clkstctrl;
 	u32 mpu_cm_clkstctrl;
 	u32 core_cm_clkstctrl;
@@ -274,7 +271,6 @@ void omap3_prcm_save_context(void)
 	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
 	prcm_context.sgx_cm_clksel =
 			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
-	prcm_context.wkup_cm_clksel = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_context.dss_cm_clksel =
 			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
 	prcm_context.cam_cm_clksel =
@@ -291,8 +287,6 @@ void omap3_prcm_save_context(void)
 			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
 	prcm_context.pll_cm_clksel5 =
 			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
-	prcm_context.pll_cm_clken =
-			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_context.pll_cm_clken2 =
 			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
@@ -338,8 +332,6 @@ void omap3_prcm_save_context(void)
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
 	prcm_context.mpu_cm_autoidle2 =
 			 cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
-	prcm_context.pll_cm_autoidle =
-			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
 	prcm_context.iva2_cm_clkstctrl =
 			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
 	prcm_context.mpu_cm_clkstctrl =
@@ -431,7 +423,6 @@ void omap3_prcm_restore_context(void)
 	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
 	cm_write_mod_reg(prcm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
 					 CM_CLKSEL);
-	cm_write_mod_reg(prcm_context.wkup_cm_clksel, WKUP_MOD, CM_CLKSEL);
 	cm_write_mod_reg(prcm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
 					 CM_CLKSEL);
 	cm_write_mod_reg(prcm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
@@ -448,7 +439,6 @@ void omap3_prcm_restore_context(void)
 					OMAP3430ES2_CM_CLKSEL4);
 	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
 					 OMAP3430ES2_CM_CLKSEL5);
-	cm_write_mod_reg(prcm_context.pll_cm_clken, PLL_MOD, CM_CLKEN);
 	cm_write_mod_reg(prcm_context.pll_cm_clken2, PLL_MOD,
 					OMAP3430ES2_CM_CLKEN2);
 	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
@@ -487,7 +477,6 @@ void omap3_prcm_restore_context(void)
 	cm_write_mod_reg(prcm_context.iva2_cm_autiidle2, OMAP3430_IVA2_MOD,
 					CM_AUTOIDLE2);
 	cm_write_mod_reg(prcm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(prcm_context.pll_cm_autoidle, PLL_MOD, CM_AUTOIDLE);
 	cm_write_mod_reg(prcm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
 					CM_CLKSTCTRL);
 	cm_write_mod_reg(prcm_context.mpu_cm_clkstctrl, MPU_MOD, CM_CLKSTCTRL);
-- 
1.6.6.rc2.1.g42108

