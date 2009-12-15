From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [v2 PATCH 2/5] ARM: OMAP4: PM: OMAP4 Power Domain Porting Related Clean-up.
Date: Tue, 15 Dec 2009 19:15:31 +0530
Message-ID: <1260884734-24579-2-git-send-email-abhijitpagare@ti.com>
References: <1260884734-24579-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43433 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbZLONpr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 08:45:47 -0500
In-Reply-To: <1260884734-24579-1-git-send-email-abhijitpagare@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Module offsets were same for OMAP2 and OMAP3 while they differ for OMAP4.
Hence we need different macros for identifying platform specific offsets.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c |    4 +-
 arch/arm/mach-omap2/pm-debug.c    |   14 ++++++------
 arch/arm/mach-omap2/pm24xx.c      |    5 ++-
 arch/arm/mach-omap2/pm34xx.c      |   38 ++++++++++++++++++------------------
 arch/arm/mach-omap2/powerdomain.c |   22 ++++++++++----------
 arch/arm/mach-omap2/prcm-common.h |    9 ++++++++
 arch/arm/mach-omap2/prcm.c        |   17 +++++++++++++--
 arch/arm/mach-omap2/prm.h         |   17 +++++++++++----
 arch/arm/mach-omap2/sleep34xx.S   |    2 +-
 9 files changed, 78 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index dd285f0..50c8cd7 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -413,7 +413,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx()) {
 
 		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE,
-				    clkdm->pwrdm.ptr->prcm_offs, PM_PWSTCTRL);
+			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx()) {
 
@@ -455,7 +455,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 	if (cpu_is_omap24xx()) {
 
 		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE,
-				      clkdm->pwrdm.ptr->prcm_offs, PM_PWSTCTRL);
+			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx()) {
 
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 860b755..e79e0b1 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -70,8 +70,8 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		/* MPU */
 		DUMP_PRM_MOD_REG(OCP_MOD, OMAP2_PRM_IRQENABLE_MPU_OFFSET);
 		DUMP_CM_MOD_REG(MPU_MOD, CM_CLKSTCTRL);
-		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTCTRL);
-		DUMP_PRM_MOD_REG(MPU_MOD, PM_PWSTST);
+		DUMP_PRM_MOD_REG(MPU_MOD, OMAP2_PM_PWSTCTRL);
+		DUMP_PRM_MOD_REG(MPU_MOD, OMAP2_PM_PWSTST);
 		DUMP_PRM_MOD_REG(MPU_MOD, PM_WKDEP);
 #endif
 #if 0
@@ -95,7 +95,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 		DUMP_CM_MOD_REG(WKUP_MOD, CM_ICLKEN);
 		DUMP_CM_MOD_REG(PLL_MOD, CM_CLKEN);
 		DUMP_CM_MOD_REG(PLL_MOD, CM_AUTOIDLE);
-		DUMP_PRM_MOD_REG(CORE_MOD, PM_PWSTST);
+		DUMP_PRM_MOD_REG(CORE_MOD, OMAP2_PM_PWSTST);
 #endif
 #if 0
 		/* DSP */
@@ -106,10 +106,10 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_AUTOIDLE);
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSEL);
 			DUMP_CM_MOD_REG(OMAP24XX_DSP_MOD, CM_CLKSTCTRL);
-			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTCTRL);
-			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, RM_RSTST);
-			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTCTRL);
-			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, PM_PWSTST);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_RM_RSTCTRL);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_RM_RSTST);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_PM_PWSTCTRL);
+			DUMP_PRM_MOD_REG(OMAP24XX_DSP_MOD, OMAP2_PM_PWSTST);
 		}
 #endif
 	} else {
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index cba05b9..7543818 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -219,11 +219,12 @@ static void omap2_enter_mpu_retention(void)
 		/* Try to enter MPU retention */
 		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
 				  OMAP_LOGICRETSTATE,
-				  MPU_MOD, PM_PWSTCTRL);
+				  MPU_MOD, OMAP2_PM_PWSTCTRL);
 	} else {
 		/* Block MPU retention */
 
-		prm_write_mod_reg(OMAP_LOGICRETSTATE, MPU_MOD, PM_PWSTCTRL);
+		prm_write_mod_reg(OMAP_LOGICRETSTATE, MPU_MOD,
+						 OMAP2_PM_PWSTCTRL);
 		only_idle = 1;
 	}
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 81ed252..3189acc 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -672,7 +672,7 @@ static void __init omap3_iva_idle(void)
 	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
 			  OMAP3430_RST2_IVA2 |
 			  OMAP3430_RST3_IVA2,
-			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
 	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2,
@@ -683,7 +683,7 @@ static void __init omap3_iva_idle(void)
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
 
 	/* Un-reset IVA2 */
-	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, RM_RSTCTRL);
+	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Disable IVA2 clock */
 	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
@@ -692,7 +692,7 @@ static void __init omap3_iva_idle(void)
 	prm_write_mod_reg(OMAP3430_RST1_IVA2 |
 			  OMAP3430_RST2_IVA2 |
 			  OMAP3430_RST3_IVA2,
-			  OMAP3430_IVA2_MOD, RM_RSTCTRL);
+			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 }
 
 static void __init omap3_d2d_idle(void)
@@ -715,8 +715,8 @@ static void __init omap3_d2d_idle(void)
 	/* reset modem */
 	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON |
 			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST,
-			  CORE_MOD, RM_RSTCTRL);
-	prm_write_mod_reg(0, CORE_MOD, RM_RSTCTRL);
+			  CORE_MOD, OMAP2_RM_RSTCTRL);
+	prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
 }
 
 static void __init prcm_setup_regs(void)
@@ -893,13 +893,13 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
 
 	/* Clear any pending 'reset' flags */
-	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
 
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
@@ -911,13 +911,13 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
 
 	/* Clear any pending 'reset' flags */
-	prm_write_mod_reg(0xffffffff, MPU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, RM_RSTST);
+	prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
+	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
 
 	/* Clear any pending PRCM interrupts */
 	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 26b3f3e..e503050 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -710,7 +710,7 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 			     (pwrst << OMAP_POWERSTATE_SHIFT),
-			     pwrdm->prcm_offs, PM_PWSTCTRL);
+			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -728,7 +728,7 @@ int pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTCTRL,
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
 					OMAP_POWERSTATE_MASK);
 }
 
@@ -745,7 +745,7 @@ int pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST,
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
 					OMAP_POWERSTATEST_MASK);
 }
 
@@ -796,7 +796,7 @@ int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	 */
 	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE,
 			     (pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE)),
-			     pwrdm->prcm_offs, PM_PWSTCTRL);
+			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -856,7 +856,7 @@ int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	}
 
 	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
-			     pwrdm->prcm_offs, PM_PWSTCTRL);
+			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -917,7 +917,7 @@ int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 	}
 
 	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-			     PM_PWSTCTRL);
+			     OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -936,7 +936,7 @@ int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST,
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
 					OMAP3430_LOGICSTATEST);
 }
 
@@ -1010,7 +1010,7 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 		return -EEXIST;
 	}
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, PM_PWSTST, m);
+	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST, m);
 }
 
 /**
@@ -1114,7 +1114,7 @@ int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 		 pwrdm->name);
 
 	prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-			     pwrdm->prcm_offs, PM_PWSTCTRL);
+			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -1142,7 +1142,7 @@ int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 		 pwrdm->name);
 
 	prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
-			     pwrdm->prcm_offs, PM_PWSTCTRL);
+			     pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -1183,7 +1183,7 @@ int pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, PM_PWSTST) &
+	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
 		OMAP_INTRANSITION) &&
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
 		udelay(1);
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 61ac2a4..90f603d 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -119,6 +119,15 @@
 #define OMAP4430_CHIRONSS_CHIRONSS_CPU0_MOD		0x0400
 #define OMAP4430_CHIRONSS_CHIRONSS_CPU1_MOD		0x0800
 
+/* Base Addresses for the OMAP4 */
+
+#define OMAP4430_CM1_BASE		0x4a004000
+#define OMAP4430_CM2_BASE		0x4a008000
+#define OMAP4430_PRM_BASE		0x4a306000
+#define OMAP4430_SCRM_BASE		0x4a30a000
+#define OMAP4430_CHIRONSS_BASE		0x48243000
+
+
 /* 24XX register bits shared between CM & PRM registers */
 
 /* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..920caae 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -11,6 +11,7 @@
  * Rajendra Nayak <rnayak@ti.com>
  *
  * Some pieces of code Copyright (C) 2005 Texas Instruments, Inc.
+ * Upgraded with OMAP4 support by Abhijit Pagare <abhijitpagare@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -124,7 +125,10 @@ struct omap3_prcm_regs prcm_context;
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
-	return prm_read_mod_reg(WKUP_MOD, RM_RSTST) & 0x7f;
+	if (cpu_is_omap24xx() | cpu_is_omap34xx())
+		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+	if (cpu_is_omap44xx())
+		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 }
 EXPORT_SYMBOL(omap_prcm_get_reset_sources);
 
@@ -147,10 +151,17 @@ void omap_prcm_arch_reset(char mode)
 		 * cf. OMAP34xx TRM, Initialization / Software Booting
 		 * Configuration. */
 		omap_writel(l, OMAP343X_SCRATCHPAD + 4);
-	} else
+	} else if (cpu_is_omap44xx())
+		prcm_offs = OMAP4430_PRM_DEVICE_MOD;
+	else
 		WARN_ON(1);
 
-	prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs, RM_RSTCTRL);
+	if (cpu_is_omap24xx() | cpu_is_omap34xx())
+		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs,
+						 OMAP2_RM_RSTCTRL);
+	if (cpu_is_omap44xx())
+		prm_set_mod_reg_bits(OMAP_RST_DPLL3, prcm_offs,
+						 OMAP4_RM_RSTCTRL);
 }
 
 static inline u32 __omap_prcm_read(void __iomem *base, s16 module, u16 reg)
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index ea050ce..8e7094c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -177,9 +177,11 @@
 
 /* Registers appearing on both 24xx and 34xx */
 
-#define RM_RSTCTRL					0x0050
-#define RM_RSTTIME					0x0054
-#define RM_RSTST					0x0058
+#define OMAP2_RM_RSTCTRL				0x0050
+#define OMAP2_RM_RSTTIME				0x0054
+#define OMAP2_RM_RSTST					0x0058
+#define OMAP2_PM_PWSTCTRL				0x00e0
+#define OMAP2_PM_PWSTST					0x00e4
 
 #define PM_WKEN						0x00a0
 #define PM_WKEN1					PM_WKEN
@@ -189,8 +191,6 @@
 #define PM_EVGENCTRL					0x00d4
 #define PM_EVGENONTIM					0x00d8
 #define PM_EVGENOFFTIM					0x00dc
-#define PM_PWSTCTRL					0x00e0
-#define PM_PWSTST					0x00e4
 
 /* Omap2 specific registers */
 #define OMAP24XX_PM_WKEN2				0x00a4
@@ -218,6 +218,13 @@
 #define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
 
+/* Omap4 specific registers */
+#define OMAP4_RM_RSTCTRL				0x0000
+#define OMAP4_RM_RSTTIME				0x0004
+#define OMAP4_RM_RSTST					0x0008
+#define OMAP4_PM_PWSTCTRL				0x0000
+#define OMAP4_PM_PWSTST					0x0004
+
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 15268f8..063623b 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -38,7 +38,7 @@
 #define PM_PREPWSTST_CORE_P	0x48306AE8
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
+#define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define SRAM_BASE_P		0x40200000
 #define CONTROL_STAT		0x480022F0
-- 
1.5.4.7

