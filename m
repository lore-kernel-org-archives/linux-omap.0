From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 04/27] OMAP3: PM: PRCM context save/restore
Date: Wed, 14 Oct 2009 14:57:47 -0700
Message-ID: <1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

Additional registers (CM_CLKSEL4, CM_CLKEN, CM_CLKEN2) added by Tero
Kristo.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/prcm.c                |  384 +++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/control.h |    2 +
 arch/arm/plat-omap/include/mach/prcm.h    |    5 +
 3 files changed, 391 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index ced555a..9322447 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -7,6 +7,9 @@
  *
  * Written by Tony Lindgren <tony.lindgren@nokia.com>
  *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
  * Some pieces of code Copyright (C) 2005 Texas Instruments, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
@@ -21,8 +24,11 @@
 
 #include <mach/common.h>
 #include <mach/prcm.h>
+#include <mach/irqs.h>
+#include <mach/control.h>
 
 #include "clock.h"
+#include "cm.h"
 #include "prm.h"
 #include "prm-regbits-24xx.h"
 
@@ -31,6 +37,87 @@ static void __iomem *cm_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
+struct omap3_prcm_regs {
+	u32 control_padconf_sys_nirq;
+	u32 iva2_cm_clksel2;
+	u32 cm_sysconfig;
+	u32 sgx_cm_clksel;
+	u32 wkup_cm_clksel;
+	u32 dss_cm_clksel;
+	u32 cam_cm_clksel;
+	u32 per_cm_clksel;
+	u32 emu_cm_clksel;
+	u32 emu_cm_clkstctrl;
+	u32 pll_cm_autoidle2;
+	u32 pll_cm_clksel4;
+	u32 pll_cm_clksel5;
+	u32 pll_cm_clken;
+	u32 pll_cm_clken2;
+	u32 cm_polctrl;
+	u32 iva2_cm_fclken;
+	u32 core_cm_fclken1;
+	u32 core_cm_fclken3;
+	u32 sgx_cm_fclken;
+	u32 wkup_cm_fclken;
+	u32 dss_cm_fclken;
+	u32 cam_cm_fclken;
+	u32 per_cm_fclken;
+	u32 usbhost_cm_fclken;
+	u32 core_cm_iclken1;
+	u32 core_cm_iclken2;
+	u32 core_cm_iclken3;
+	u32 sgx_cm_iclken;
+	u32 wkup_cm_iclken;
+	u32 dss_cm_iclken;
+	u32 cam_cm_iclken;
+	u32 per_cm_iclken;
+	u32 usbhost_cm_iclken;
+	u32 iva2_cm_autiidle2;
+	u32 mpu_cm_autoidle2;
+	u32 pll_cm_autoidle;
+	u32 iva2_cm_clkstctrl;
+	u32 mpu_cm_clkstctrl;
+	u32 core_cm_clkstctrl;
+	u32 sgx_cm_clkstctrl;
+	u32 dss_cm_clkstctrl;
+	u32 cam_cm_clkstctrl;
+	u32 per_cm_clkstctrl;
+	u32 neon_cm_clkstctrl;
+	u32 usbhost_cm_clkstctrl;
+	u32 core_cm_autoidle1;
+	u32 core_cm_autoidle2;
+	u32 core_cm_autoidle3;
+	u32 wkup_cm_autoidle;
+	u32 dss_cm_autoidle;
+	u32 cam_cm_autoidle;
+	u32 per_cm_autoidle;
+	u32 usbhost_cm_autoidle;
+	u32 sgx_cm_sleepdep;
+	u32 dss_cm_sleepdep;
+	u32 cam_cm_sleepdep;
+	u32 per_cm_sleepdep;
+	u32 usbhost_cm_sleepdep;
+	u32 cm_clkout_ctrl;
+	u32 prm_clkout_ctrl;
+	u32 sgx_pm_wkdep;
+	u32 dss_pm_wkdep;
+	u32 cam_pm_wkdep;
+	u32 per_pm_wkdep;
+	u32 neon_pm_wkdep;
+	u32 usbhost_pm_wkdep;
+	u32 core_pm_mpugrpsel1;
+	u32 iva2_pm_ivagrpsel1;
+	u32 core_pm_mpugrpsel3;
+	u32 core_pm_ivagrpsel3;
+	u32 wkup_pm_mpugrpsel;
+	u32 wkup_pm_ivagrpsel;
+	u32 per_pm_mpugrpsel;
+	u32 per_pm_ivagrpsel;
+	u32 wkup_pm_wken;
+};
+
+struct omap3_prcm_regs prcm_context;
+
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
@@ -168,3 +255,300 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 	prm_base = omap2_globals->prm;
 	cm_base = omap2_globals->cm;
 }
+
+#ifdef CONFIG_ARCH_OMAP3
+void omap3_prcm_save_context(void)
+{
+	prcm_context.control_padconf_sys_nirq =
+			 omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	prcm_context.iva2_cm_clksel2 =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
+	prcm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
+	prcm_context.sgx_cm_clksel =
+			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
+	prcm_context.wkup_cm_clksel = cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+	prcm_context.dss_cm_clksel =
+			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
+	prcm_context.cam_cm_clksel =
+			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
+	prcm_context.per_cm_clksel =
+			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
+	prcm_context.emu_cm_clksel =
+			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
+	prcm_context.emu_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSTCTRL);
+	prcm_context.pll_cm_autoidle2 =
+			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
+	prcm_context.pll_cm_clksel4 =
+			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
+	prcm_context.pll_cm_clksel5 =
+			 cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+	prcm_context.pll_cm_clken =
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	prcm_context.pll_cm_clken2 =
+			cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
+	prcm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
+	prcm_context.iva2_cm_fclken =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
+	prcm_context.core_cm_fclken1 =
+			 cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	prcm_context.core_cm_fclken3 =
+			 cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+	prcm_context.sgx_cm_fclken =
+			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
+	prcm_context.wkup_cm_fclken =
+			 cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
+	prcm_context.dss_cm_fclken =
+			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
+	prcm_context.cam_cm_fclken =
+			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
+	prcm_context.per_cm_fclken =
+			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
+	prcm_context.usbhost_cm_fclken =
+			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+	prcm_context.core_cm_iclken1 =
+			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
+	prcm_context.core_cm_iclken2 =
+			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
+	prcm_context.core_cm_iclken3 =
+			 cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+	prcm_context.sgx_cm_iclken =
+			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
+	prcm_context.wkup_cm_iclken =
+			 cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
+	prcm_context.dss_cm_iclken =
+			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
+	prcm_context.cam_cm_iclken =
+			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
+	prcm_context.per_cm_iclken =
+			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
+	prcm_context.usbhost_cm_iclken =
+			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+	prcm_context.iva2_cm_autiidle2 =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+	prcm_context.mpu_cm_autoidle2 =
+			 cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
+	prcm_context.pll_cm_autoidle =
+			 cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+	prcm_context.iva2_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSTCTRL);
+	prcm_context.mpu_cm_clkstctrl =
+			 cm_read_mod_reg(MPU_MOD, CM_CLKSTCTRL);
+	prcm_context.core_cm_clkstctrl =
+			 cm_read_mod_reg(CORE_MOD, CM_CLKSTCTRL);
+	prcm_context.sgx_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSTCTRL);
+	prcm_context.dss_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSTCTRL);
+	prcm_context.cam_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSTCTRL);
+	prcm_context.per_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSTCTRL);
+	prcm_context.neon_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430_NEON_MOD, CM_CLKSTCTRL);
+	prcm_context.usbhost_cm_clkstctrl =
+			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
+	prcm_context.core_cm_autoidle1 =
+			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
+	prcm_context.core_cm_autoidle2 =
+			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
+	prcm_context.core_cm_autoidle3 =
+			 cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
+	prcm_context.wkup_cm_autoidle =
+			 cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
+	prcm_context.dss_cm_autoidle =
+			 cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
+	prcm_context.cam_cm_autoidle =
+			 cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
+	prcm_context.per_cm_autoidle =
+			 cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	prcm_context.usbhost_cm_autoidle =
+			 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+	prcm_context.sgx_cm_sleepdep =
+		 cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
+	prcm_context.dss_cm_sleepdep =
+		 cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
+	prcm_context.cam_cm_sleepdep =
+		 cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
+	prcm_context.per_cm_sleepdep =
+		 cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
+	prcm_context.usbhost_cm_sleepdep =
+		 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+	prcm_context.cm_clkout_ctrl = cm_read_mod_reg(OMAP3430_CCR_MOD,
+		 OMAP3_CM_CLKOUT_CTRL_OFFSET);
+	prcm_context.prm_clkout_ctrl = prm_read_mod_reg(OMAP3430_CCR_MOD,
+		OMAP3_PRM_CLKOUT_CTRL_OFFSET);
+	prcm_context.sgx_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
+	prcm_context.dss_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
+	prcm_context.cam_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
+	prcm_context.per_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
+	prcm_context.neon_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
+	prcm_context.usbhost_pm_wkdep =
+		 prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+	prcm_context.core_pm_mpugrpsel1 =
+		 prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
+	prcm_context.iva2_pm_ivagrpsel1 =
+		 prm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_PM_IVAGRPSEL1);
+	prcm_context.core_pm_mpugrpsel3 =
+		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
+	prcm_context.core_pm_ivagrpsel3 =
+		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+	prcm_context.wkup_pm_mpugrpsel =
+		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
+	prcm_context.wkup_pm_ivagrpsel =
+		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+	prcm_context.per_pm_mpugrpsel =
+		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
+	prcm_context.per_pm_ivagrpsel =
+		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+	prcm_context.wkup_pm_wken = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	return;
+}
+
+void omap3_prcm_restore_context(void)
+{
+	omap_ctrl_writel(prcm_context.control_padconf_sys_nirq,
+					 OMAP343X_CONTROL_PADCONF_SYSNIRQ);
+	cm_write_mod_reg(prcm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
+					 CM_CLKSEL2);
+	__raw_writel(prcm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
+	cm_write_mod_reg(prcm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
+					 CM_CLKSEL);
+	cm_write_mod_reg(prcm_context.wkup_cm_clksel, WKUP_MOD, CM_CLKSEL);
+	cm_write_mod_reg(prcm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
+					 CM_CLKSEL);
+	cm_write_mod_reg(prcm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
+					 CM_CLKSEL);
+	cm_write_mod_reg(prcm_context.per_cm_clksel, OMAP3430_PER_MOD,
+					 CM_CLKSEL);
+	cm_write_mod_reg(prcm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
+					 CM_CLKSEL1);
+	cm_write_mod_reg(prcm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
+					 CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.pll_cm_autoidle2, PLL_MOD,
+					 CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_context.pll_cm_clksel4, PLL_MOD,
+					OMAP3430ES2_CM_CLKSEL4);
+	cm_write_mod_reg(prcm_context.pll_cm_clksel5, PLL_MOD,
+					 OMAP3430ES2_CM_CLKSEL5);
+	cm_write_mod_reg(prcm_context.pll_cm_clken, PLL_MOD, CM_CLKEN);
+	cm_write_mod_reg(prcm_context.pll_cm_clken2, PLL_MOD,
+					OMAP3430ES2_CM_CLKEN2);
+	__raw_writel(prcm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
+	cm_write_mod_reg(prcm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
+					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
+	cm_write_mod_reg(prcm_context.core_cm_fclken3, CORE_MOD,
+					 OMAP3430ES2_CM_FCLKEN3);
+	cm_write_mod_reg(prcm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
+					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
+					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
+					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.per_cm_fclken, OMAP3430_PER_MOD,
+					 CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.usbhost_cm_fclken,
+					 OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+	cm_write_mod_reg(prcm_context.core_cm_iclken1, CORE_MOD, CM_ICLKEN1);
+	cm_write_mod_reg(prcm_context.core_cm_iclken2, CORE_MOD, CM_ICLKEN2);
+	cm_write_mod_reg(prcm_context.core_cm_iclken3, CORE_MOD, CM_ICLKEN3);
+	cm_write_mod_reg(prcm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
+					CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
+					CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
+					CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.per_cm_iclken, OMAP3430_PER_MOD,
+					CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.usbhost_cm_iclken,
+					OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+	cm_write_mod_reg(prcm_context.iva2_cm_autiidle2, OMAP3430_IVA2_MOD,
+					CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_context.pll_cm_autoidle, PLL_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.mpu_cm_clkstctrl, MPU_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.core_cm_clkstctrl, CORE_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
+					CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.usbhost_cm_clkstctrl,
+					OMAP3430ES2_USBHOST_MOD, CM_CLKSTCTRL);
+	cm_write_mod_reg(prcm_context.core_cm_autoidle1, CORE_MOD,
+					CM_AUTOIDLE1);
+	cm_write_mod_reg(prcm_context.core_cm_autoidle2, CORE_MOD,
+					CM_AUTOIDLE2);
+	cm_write_mod_reg(prcm_context.core_cm_autoidle3, CORE_MOD,
+					CM_AUTOIDLE3);
+	cm_write_mod_reg(prcm_context.wkup_cm_autoidle, WKUP_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
+					CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
+					CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.per_cm_autoidle, OMAP3430_PER_MOD,
+					CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.usbhost_cm_autoidle,
+					OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+	cm_write_mod_reg(prcm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
+					OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
+					OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
+					OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
+					OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_context.usbhost_cm_sleepdep,
+				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+	cm_write_mod_reg(prcm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
+					OMAP3_CM_CLKOUT_CTRL_OFFSET);
+	prm_write_mod_reg(prcm_context.prm_clkout_ctrl, OMAP3430_CCR_MOD,
+					OMAP3_PRM_CLKOUT_CTRL_OFFSET);
+	prm_write_mod_reg(prcm_context.sgx_pm_wkdep, OMAP3430ES2_SGX_MOD,
+					PM_WKDEP);
+	prm_write_mod_reg(prcm_context.dss_pm_wkdep, OMAP3430_DSS_MOD,
+					PM_WKDEP);
+	prm_write_mod_reg(prcm_context.cam_pm_wkdep, OMAP3430_CAM_MOD,
+					PM_WKDEP);
+	prm_write_mod_reg(prcm_context.per_pm_wkdep, OMAP3430_PER_MOD,
+					PM_WKDEP);
+	prm_write_mod_reg(prcm_context.neon_pm_wkdep, OMAP3430_NEON_MOD,
+					PM_WKDEP);
+	prm_write_mod_reg(prcm_context.usbhost_pm_wkdep,
+					OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel1, CORE_MOD,
+					OMAP3430_PM_MPUGRPSEL1);
+	prm_write_mod_reg(prcm_context.iva2_pm_ivagrpsel1, OMAP3430_IVA2_MOD,
+					OMAP3430_PM_IVAGRPSEL1);
+	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel3, CORE_MOD,
+					OMAP3430ES2_PM_MPUGRPSEL3);
+	prm_write_mod_reg(prcm_context.core_pm_ivagrpsel3, CORE_MOD,
+					OMAP3430ES2_PM_IVAGRPSEL3);
+	prm_write_mod_reg(prcm_context.wkup_pm_mpugrpsel, WKUP_MOD,
+					OMAP3430_PM_MPUGRPSEL);
+	prm_write_mod_reg(prcm_context.wkup_pm_ivagrpsel, WKUP_MOD,
+					OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(prcm_context.per_pm_mpugrpsel, OMAP3430_PER_MOD,
+					OMAP3430_PM_MPUGRPSEL);
+	prm_write_mod_reg(prcm_context.per_pm_ivagrpsel, OMAP3430_PER_MOD,
+					 OMAP3430_PM_IVAGRPSEL);
+	prm_write_mod_reg(prcm_context.wkup_pm_wken, WKUP_MOD, PM_WKEN);
+	return;
+}
+#endif
diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index fdb6300..3cdfe31 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -112,6 +112,8 @@
 #define OMAP24XX_CONTROL_TEST_KEY_8	(OMAP2_CONTROL_GENERAL + 0x00e0)
 #define OMAP24XX_CONTROL_TEST_KEY_9	(OMAP2_CONTROL_GENERAL + 0x00e4)
 
+#define OMAP343X_CONTROL_PADCONF_SYSNIRQ (OMAP2_CONTROL_INTERFACE + 0x01b0)
+
 /* 34xx-only CONTROL_GENERAL register offsets */
 #define OMAP343X_CONTROL_PADCONF_OFF	(OMAP2_CONTROL_GENERAL + 0x0000)
 #define OMAP343X_CONTROL_MEM_DFTRW0	(OMAP2_CONTROL_GENERAL + 0x0008)
diff --git a/arch/arm/plat-omap/include/mach/prcm.h b/arch/arm/plat-omap/include/mach/prcm.h
index cda2a70..ca7dd0c 100644
--- a/arch/arm/plat-omap/include/mach/prcm.h
+++ b/arch/arm/plat-omap/include/mach/prcm.h
@@ -27,6 +27,11 @@ u32 omap_prcm_get_reset_sources(void);
 void omap_prcm_arch_reset(char mode);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
 
+#define START_PADCONF_SAVE 0x2
+#define PADCONF_SAVE_DONE  0x1
+
+void omap3_prcm_save_context(void);
+void omap3_prcm_restore_context(void);
 #endif
 
 
-- 
1.6.4.3
