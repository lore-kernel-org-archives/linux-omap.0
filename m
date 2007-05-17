From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/18] omap2: add OMAP24XX Power/Reset Management register
	bit defines
Date: Wed, 16 May 2007 18:11:40 -0600
Message-ID: <20070517005443.944430679@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0008-omap2-add-OMAP24XX-Power-Reset-Management-register.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add symbolic constants for Power/Reset Management register bits for
the OMAP2420 and OMAP2430 architectures.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm_regbits_24xx.h |  279 ++++++++++++++++++++++++++++++++
 1 files changed, 279 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm_regbits_24xx.h

diff --git a/arch/arm/mach-omap2/prm_regbits_24xx.h b/arch/arm/mach-omap2/prm_regbits_24xx.h
new file mode 100644
index 0000000..c6d17a3
--- /dev/null
+++ b/arch/arm/mach-omap2/prm_regbits_24xx.h
@@ -0,0 +1,279 @@
+#ifndef __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
+#define __ARCH_ARM_MACH_OMAP2_PRM_REGBITS_24XX_H
+
+/*
+ * OMAP24XX Power/Reset Management register bits
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Copyright (C) 2007 Nokia Corporation
+ *
+ * Written by Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "prm.h"
+
+/* Bits shared between registers */
+
+/* PRCM_IRQSTATUS_MPU, PM_IRQSTATUS_DSP, PRCM_IRQSTATUS_IVA shared bits */
+#define OMAP24XX_VOLTTRANS_ST				(1 << 2)
+#define OMAP24XX_WKUP2_ST				(1 << 1)
+#define OMAP24XX_WKUP1_ST				(1 << 0)
+
+/* PRCM_IRQENABLE_MPU, PM_IRQENABLE_DSP, PRCM_IRQENABLE_IVA shared bits */
+#define OMAP24XX_VOLTTRANS_EN				(1 << 2)
+#define OMAP24XX_WKUP2_EN				(1 << 1)
+#define OMAP24XX_WKUP1_EN				(1 << 0)
+
+/* PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_DSP, PM_WKDEP_MDM shared bits */
+#define OMAP24XX_EN_MPU					(1 << 1)
+#define OMAP24XX_EN_CORE				(1 << 0)
+
+/*
+ * PM_PWSTCTRL_MPU, PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM
+ * shared bits
+ */
+#define OMAP24XX_MEMONSTATE_SHIFT			10
+#define OMAP24XX_MEMONSTATE_MASK			(0x3 << 10)
+#define OMAP24XX_MEMRETSTATE				(1 << 3)
+
+/* PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSP, PM_PWSTCTRL_MDM shared bits */
+#define OMAP24XX_FORCESTATE				(1 << 18)
+
+/*
+ * PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP,
+ * PM_PWSTST_MDM shared bits
+ */
+#define OMAP24XX_CLKACTIVITY				(1 << 19)
+
+/* PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_DSP shared bits */
+#define OMAP24XX_LASTSTATEENTERED_SHIFT			4
+#define OMAP24XX_LASTSTATEENTERED_MASK			(0x3 << 4)
+
+/* PM_PWSTST_MPU and PM_PWSTST_DSP shared bits */
+#define OMAP2430_MEMSTATEST_SHIFT			10
+#define OMAP2430_MEMSTATEST_MASK			(0x3 << 10)
+
+/* PM_PWSTST_GFX, PM_PWSTST_DSP, PM_PWSTST_MDM shared bits */
+#define OMAP24XX_POWERSTATEST_SHIFT			0
+#define OMAP24XX_POWERSTATEST_MASK			(0x3 << 0)
+
+
+/* Bits specific to each register */
+
+/* PRCM_REVISION */
+#define OMAP24XX_REV_SHIFT				0
+#define OMAP24XX_REV_MASK				(0xff << 0)
+
+/* PRCM_SYSCONFIG */
+#define OMAP24XX_AUTOIDLE				(1 << 0)
+
+/* PRCM_IRQSTATUS_MPU specific bits */
+#define OMAP2430_DPLL_RECAL_ST				(1 << 6)
+#define OMAP24XX_TRANSITION_ST				(1 << 5)
+#define OMAP24XX_EVGENOFF_ST				(1 << 4)
+#define OMAP24XX_EVGENON_ST				(1 << 3)
+
+/* PRCM_IRQENABLE_MPU specific bits */
+#define OMAP2430_DPLL_RECAL_EN				(1 << 6)
+#define OMAP24XX_TRANSITION_EN				(1 << 5)
+#define OMAP24XX_EVGENOFF_EN				(1 << 4)
+#define OMAP24XX_EVGENON_EN				(1 << 3)
+
+/* PRCM_VOLTCTRL */
+#define OMAP24XX_AUTO_EXTVOLT				(1 << 15)
+#define OMAP24XX_FORCE_EXTVOLT				(1 << 14)
+#define OMAP24XX_SETOFF_LEVEL_SHIFT			12
+#define OMAP24XX_SETOFF_LEVEL_MASK			(0x3 << 12)
+#define OMAP24XX_MEMRETCTRL				(1 << 8)
+#define OMAP24XX_SETRET_LEVEL_SHIFT			6
+#define OMAP24XX_SETRET_LEVEL_MASK			(0x3 << 6)
+#define OMAP24XX_VOLT_LEVEL_SHIFT			0
+#define OMAP24XX_VOLT_LEVEL_MASK			(0x3 << 0)
+
+/* PRCM_VOLTST */
+#define OMAP24XX_ST_VOLTLEVEL_SHIFT			0
+#define OMAP24XX_ST_VOLTLEVEL_MASK			(0x3 << 0)
+
+/* PRCM_CLKSRC_CTRL specific bits */
+
+/* PRCM_CLKOUT_CTRL */
+#define OMAP2420_CLKOUT2_EN_SHIFT			15
+#define OMAP2420_CLKOUT2_EN				(1 << 15)
+#define OMAP2420_CLKOUT2_DIV_SHIFT			11
+#define OMAP2420_CLKOUT2_DIV_MASK			(0x7 << 11)
+#define OMAP2420_CLKOUT2_SOURCE_SHIFT			8
+#define OMAP2420_CLKOUT2_SOURCE_MASK			(0x3 << 8)
+#define OMAP24XX_CLKOUT_EN_SHIFT			7
+#define OMAP24XX_CLKOUT_EN				(1 << 7)
+#define OMAP24XX_CLKOUT_DIV_SHIFT			3
+#define OMAP24XX_CLKOUT_DIV_MASK			(0x7 << 3)
+#define OMAP24XX_CLKOUT_SOURCE_SHIFT			0
+#define OMAP24XX_CLKOUT_SOURCE_MASK			(0x3 << 0)
+
+/* PRCM_CLKEMUL_CTRL */
+#define OMAP24XX_EMULATION_EN_SHIFT			0
+#define OMAP24XX_EMULATION_EN				(1 << 0)
+
+/* PRCM_CLKCFG_CTRL */
+#define OMAP24XX_VALID_CONFIG				(1 << 0)
+
+/* PRCM_CLKCFG_STATUS */
+#define OMAP24XX_CONFIG_STATUS				(1 << 0)
+
+/* PRCM_VOLTSETUP specific bits */
+
+/* PRCM_CLKSSETUP specific bits */
+
+/* PRCM_POLCTRL */
+#define OMAP2420_CLKOUT2_POL				(1 << 10)
+#define OMAP24XX_CLKOUT_POL				(1 << 9)
+#define OMAP24XX_CLKREQ_POL				(1 << 8)
+#define OMAP2430_USE_POWEROK				(1 << 2)
+#define OMAP2430_POWEROK_POL				(1 << 1)
+#define OMAP24XX_EXTVOL_POL				(1 << 0)
+
+/* RM_RSTST_MPU specific bits */
+/* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" instead */
+
+/* PM_WKDEP_MPU specific bits */
+#define OMAP2430_PM_WKDEP_MPU_EN_MDM			(1 << 5)
+#define OMAP24XX_PM_WKDEP_MPU_EN_DSP			(1 << 2)
+
+/* PM_EVGENCTRL_MPU specific bits */
+
+/* PM_EVEGENONTIM_MPU specific bits */
+
+/* PM_EVEGENOFFTIM_MPU specific bits */
+
+/* PM_PWSTCTRL_MPU specific bits */
+#define OMAP2430_FORCESTATE				(1 << 18)
+
+/* PM_PWSTST_MPU specific bits */
+/* INTRANSITION, CLKACTIVITY, POWERSTATE, MEMSTATEST are 2430 only */
+
+/* PM_WKEN1_CORE specific bits */
+
+/* PM_WKEN2_CORE specific bits */
+
+/* PM_WKST1_CORE specific bits*/
+
+/* PM_WKST2_CORE specific bits */
+
+/* PM_WKDEP_CORE specific bits*/
+#define OMAP2430_PM_WKDEP_CORE_EN_MDM			(1 << 5)
+#define OMAP24XX_PM_WKDEP_CORE_EN_GFX			(1 << 3)
+#define OMAP24XX_PM_WKDEP_CORE_EN_DSP			(1 << 2)
+
+/* PM_PWSTCTRL_CORE specific bits */
+#define OMAP24XX_MEMORYCHANGE				(1 << 20)
+#define OMAP24XX_MEM3ONSTATE_SHIFT			14
+#define OMAP24XX_MEM3ONSTATE_MASK			(0x3 << 14)
+#define OMAP24XX_MEM2ONSTATE_SHIFT			12
+#define OMAP24XX_MEM2ONSTATE_MASK			(0x3 << 12)
+#define OMAP24XX_MEM1ONSTATE_SHIFT			10
+#define OMAP24XX_MEM1ONSTATE_MASK			(0x3 << 10)
+#define OMAP24XX_MEM3RETSTATE				(1 << 5)
+#define OMAP24XX_MEM2RETSTATE				(1 << 4)
+#define OMAP24XX_MEM1RETSTATE				(1 << 3)
+
+/* PM_PWSTST_CORE specific bits */
+#define OMAP24XX_MEM3STATEST_SHIFT			14
+#define OMAP24XX_MEM3STATEST_MASK			(0x3 << 14)
+#define OMAP24XX_MEM2STATEST_SHIFT			12
+#define OMAP24XX_MEM2STATEST_MASK			(0x3 << 12)
+#define OMAP24XX_MEM1STATEST_SHIFT			10
+#define OMAP24XX_MEM1STATEST_MASK			(0x3 << 10)
+
+/* RM_RSTCTRL_GFX */
+#define OMAP24XX_GFX_RST				(1 << 0)
+
+/* RM_RSTST_GFX specific bits */
+#define OMAP24XX_GFX_SW_RST				(1 << 4)
+
+/* PM_PWSTCTRL_GFX specific bits */
+
+/* PM_WKDEP_GFX specific bits */
+/* 2430 often calls EN_WAKEUP "EN_WKUP" */
+
+/* RM_RSTCTRL_WKUP specific bits */
+
+/* RM_RSTTIME_WKUP specific bits */
+
+/* RM_RSTST_WKUP specific bits */
+/* 2430 calls EXTWMPU_RST "EXTWARM_RST" and GLOBALWMPU_RST "GLOBALWARM_RST" */
+#define OMAP24XX_EXTWMPU_RST				(1 << 6)
+#define OMAP24XX_SECU_WD_RST				(1 << 5)
+#define OMAP24XX_MPU_WD_RST				(1 << 4)
+#define OMAP24XX_SECU_VIOL_RST				(1 << 3)
+
+/* PM_WKEN_WKUP specific bits */
+
+/* PM_WKST_WKUP specific bits */
+
+/* RM_RSTCTRL_DSP */
+#define OMAP2420_RST_IVA				(1 << 8)
+#define OMAP24XX_RST2_DSP				(1 << 1)
+#define OMAP24XX_RST1_DSP				(1 << 0)
+
+/* RM_RSTST_DSP specific bits */
+/* 2430 calls GLOBALWMPU_RST "GLOBALWARM_RST" */
+#define OMAP2420_IVA_SW_RST				(1 << 8)
+#define OMAP24XX_DSP_SW_RST2				(1 << 5)
+#define OMAP24XX_DSP_SW_RST1				(1 << 4)
+
+/* PM_WKDEP_DSP specific bits */
+
+/* PM_PWSTCTRL_DSP specific bits */
+/* 2430 only: MEMONSTATE, MEMRETSTATE */
+#define OMAP2420_MEMIONSTATE_SHIFT			12
+#define OMAP2420_MEMIONSTATE_MASK			(0x3 << 12)
+#define OMAP2420_MEMIRETSTATE				(1 << 4)
+
+/* PM_PWSTST_DSP specific bits */
+/* MEMSTATEST is 2430 only */
+#define OMAP2420_MEMISTATEST_SHIFT			12
+#define OMAP2420_MEMISTATEST_MASK			(0x3 << 12)
+
+/* PRCM_IRQSTATUS_DSP specific bits */
+
+/* PRCM_IRQENABLE_DSP specific bits */
+
+/* RM_RSTCTRL_MDM */
+/* 2430 only */
+#define OMAP2430_PWRON1_MDM				(1 << 1)
+#define OMAP2430_RST1_MDM				(1 << 0)
+
+/* RM_RSTST_MDM specific bits */
+/* 2430 only */
+#define OMAP2430_MDM_SECU_VIOL				(1 << 6)
+#define OMAP2430_MDM_SW_PWRON1				(1 << 5)
+#define OMAP2430_MDM_SW_RST1				(1 << 4)
+
+/* PM_WKEN_MDM */
+/* 2430 only */
+#define OMAP2430_PM_WKEN_MDM_EN_MDM			(1 << 0)
+
+/* PM_WKST_MDM specific bits */
+/* 2430 only */
+
+/* PM_WKDEP_MDM specific bits */
+/* 2430 only */
+
+/* PM_PWSTCTRL_MDM specific bits */
+/* 2430 only */
+#define OMAP2430_KILLDOMAINWKUP				(1 << 19)
+
+/* PM_PWSTST_MDM specific bits */
+/* 2430 only */
+
+/* PRCM_IRQSTATUS_IVA */
+/* 2420 only */
+
+/* PRCM_IRQENABLE_IVA */
+/* 2420 only */
+
+#endif
-- 
1.5.1.3

-- 
