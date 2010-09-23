From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 6/8] OMAP: PRM: split the prm accessor api funcs for omap2/3 and omap4
Date: Thu, 23 Sep 2010 18:04:49 +0530
Message-ID: <1285245291-26442-7-git-send-email-rnayak@ti.com>
References: <1285245291-26442-1-git-send-email-rnayak@ti.com>
 <1285245291-26442-2-git-send-email-rnayak@ti.com>
 <1285245291-26442-3-git-send-email-rnayak@ti.com>
 <1285245291-26442-4-git-send-email-rnayak@ti.com>
 <1285245291-26442-5-git-send-email-rnayak@ti.com>
 <1285245291-26442-6-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53548 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755179Ab0IWMfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 08:35:03 -0400
In-Reply-To: <1285245291-26442-6-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@deeprootsystems.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

With the powerdomain framework now being split into a platform
dependent and platform independent part, its now possible
to have discreet set of prm accessor apis for omap2/3 and omap4.
This certainlly helps avoid the extra overhead/checks unneccesarily
added on omap2/3 for every prm register access.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/clockdomain.c      |   16 ++--
 arch/arm/mach-omap2/control.c          |    8 +-
 arch/arm/mach-omap2/pm-debug.c         |    4 +-
 arch/arm/mach-omap2/pm24xx.c           |   48 ++++++------
 arch/arm/mach-omap2/pm34xx.c           |   98 +++++++++++++-------------
 arch/arm/mach-omap2/powerdomains2xxx.c |   34 +++++-----
 arch/arm/mach-omap2/powerdomains44xx.c |   26 ++++----
 arch/arm/mach-omap2/prcm.c             |  123 +++++++++++++++++++++-----------
 arch/arm/mach-omap2/prm.h              |   26 +++++--
 arch/arm/plat-omap/include/plat/prcm.h |   12 ++-
 10 files changed, 224 insertions(+), 171 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 5d80cb8..ccb0c88 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -289,7 +289,7 @@ static void _init_wkdep_usecount(struct clockdomain *clkdm)
 			continue;
 		}
 
-		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+		v = omap2_prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
 					    PM_WKDEP,
 					    (1 << cd->clkdm->dep_bit));
 
@@ -336,7 +336,7 @@ static void _init_sleepdep_usecount(struct clockdomain *clkdm)
 			continue;
 		}
 
-		v = prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
+		v = omap2_prm_read_mod_bits_shift(clkdm->pwrdm.ptr->prcm_offs,
 					    OMAP3430_CM_SLEEPDEP,
 					    (1 << cd->clkdm->dep_bit));
 
@@ -495,7 +495,7 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
 			 "up\n", clkdm1->name, clkdm2->name);
 
-		prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
 				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
 	}
 
@@ -530,7 +530,7 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will no longer wake up %s "
 			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-		prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
 				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
 	}
 
@@ -566,7 +566,7 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic wkdep_usecount */
-	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
 				       (1 << clkdm2->dep_bit));
 }
 
@@ -597,7 +597,7 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 		atomic_set(&cd->wkdep_usecount, 0);
 	}
 
-	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
 
 	return 0;
 }
@@ -722,7 +722,7 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic sleepdep_usecount */
-	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
 				       OMAP3430_CM_SLEEPDEP,
 				       (1 << clkdm2->dep_bit));
 }
@@ -757,7 +757,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 		atomic_set(&cd->sleepdep_usecount, 0);
 	}
 
-	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
 			       OMAP3430_CM_SLEEPDEP);
 
 	return 0;
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index a8d20ee..e27e9cd 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -193,11 +193,11 @@ void omap3_clear_scratchpad_contents(void)
 	u32 *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
-	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
+	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
 	    OMAP3430_GLOBAL_COLD_RST_MASK) {
 		for ( ; offset <= max_offset; offset += 0x4)
 			__raw_writel(0x0, (v_addr + offset));
-		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
+		omap2_prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
 				     OMAP3430_GR_MOD,
 				     OMAP3_PRM_RSTST_OFFSET);
 	}
@@ -231,9 +231,9 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.sdrc_block_offset = 0x64;
 
 	/* Populate the PRCM block contents */
-	prcm_block_contents.prm_clksrc_ctrl = prm_read_mod_reg(OMAP3430_GR_MOD,
+	prcm_block_contents.prm_clksrc_ctrl = omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
 			OMAP3_PRM_CLKSRC_CTRL_OFFSET);
-	prcm_block_contents.prm_clksel = prm_read_mod_reg(OMAP3430_CCR_MOD,
+	prcm_block_contents.prm_clksel = omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
 			OMAP3_PRM_CLKSEL_OFFSET);
 	prcm_block_contents.cm_clksel_core =
 			cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 723b44e..022c4f4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -40,7 +40,7 @@ int omap2_pm_debug;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
-	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
+	regs[reg_count++].val = omap2_prm_read_mod_reg(mod, reg)
 #define DUMP_CM_MOD_REG(mod, reg)     \
 	regs[reg_count].name = #mod "." #reg; \
 	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
@@ -309,7 +309,7 @@ static void pm_dbg_regset_store(u32 *ptr)
 				val = cm_read_mod_reg(
 					pm_dbg_reg_modules[i].offset, j);
 			else
-				val = prm_read_mod_reg(
+				val = omap2_prm_read_mod_reg(
 					pm_dbg_reg_modules[i].offset, j);
 			*(ptr++) = val;
 		}
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index 6aeedea..14ed7ca 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -91,9 +91,9 @@ static void omap2_enter_full_retention(void)
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
-	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-	prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 	/*
 	 * Set MPU powerdomain's next power state to RETENTION;
@@ -145,23 +145,23 @@ no_sleep:
 	clk_enable(osc_ck);
 
 	/* clear CORE wake-up events */
-	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 
 	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
-	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
+	omap2_prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
-	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x01)
-		prm_write_mod_reg(0x01, OCP_MOD,
+		omap2_prm_write_mod_reg(0x01, OCP_MOD,
 				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x20)
-		prm_write_mod_reg(0x20, OCP_MOD,
+		omap2_prm_write_mod_reg(0x20, OCP_MOD,
 				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 
 	/* Mask future PRCM-to-MPU interrupts */
-	prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	omap2_prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 }
 
 static int omap2_i2c_active(void)
@@ -208,18 +208,18 @@ static void omap2_enter_mpu_retention(void)
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
 		/* REVISIT: These write to reserved bits? */
-		prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-		prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-		prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+		omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 		/* Try to enter MPU retention */
-		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
+		omap2_prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
 				  OMAP_LOGICRETSTATE_MASK,
 				  MPU_MOD, OMAP2_PM_PWSTCTRL);
 	} else {
 		/* Block MPU retention */
 
-		prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
+		omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 						 OMAP2_PM_PWSTCTRL);
 		only_idle = 1;
 	}
@@ -286,9 +286,9 @@ static int omap2_pm_suspend(void)
 {
 	u32 wken_wkup, mir1;
 
-	wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	wken_wkup = omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 	wken_wkup &= ~OMAP24XX_EN_GPT1_MASK;
-	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	/* Mask GPT1 */
 	mir1 = omap_readl(0x480fe0a4);
@@ -298,7 +298,7 @@ static int omap2_pm_suspend(void)
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
-	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	return 0;
 }
@@ -351,7 +351,7 @@ static void __init prcm_setup_regs(void)
 	struct powerdomain *pwrdm;
 
 	/* Enable autoidle */
-	prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
+	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
 	/*
@@ -455,13 +455,13 @@ static void __init prcm_setup_regs(void)
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
-	prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
 			  OMAP2_PRCM_CLKSSETUP_OFFSET);
 
 	/* Configure automatic voltage transition */
-	prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+	omap2_prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
 			  OMAP2_PRCM_VOLTSETUP_OFFSET);
-	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
+	omap2_prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
 			  (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
 			  OMAP24XX_MEMRETCTRL_MASK |
 			  (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
@@ -469,7 +469,7 @@ static void __init prcm_setup_regs(void)
 			  OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
 
 	/* Enable wake-up events */
-	prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
+	omap2_prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
 			  WKUP_MOD, PM_WKEN);
 }
 
@@ -481,7 +481,7 @@ static int __init omap2_pm_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
+	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	/* Look up important powerdomains */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 7b03426..b805969 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -94,12 +94,12 @@ static void omap3_enable_io_chain(void)
 	int timeout = 0;
 
 	if (omap_rev() >= OMAP3430_REV_ES3_1) {
-		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				     PM_WKEN);
 		/* Do a readback to assure write has been done */
-		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -107,7 +107,7 @@ static void omap3_enable_io_chain(void)
 				       "activation failed.\n");
 				return;
 			}
-			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
+			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
 					     WKUP_MOD, PM_WKEN);
 		}
 	}
@@ -116,7 +116,7 @@ static void omap3_enable_io_chain(void)
 static void omap3_disable_io_chain(void)
 {
 	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				       PM_WKEN);
 }
 
@@ -210,8 +210,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
 	int c = 0;
 
-	wkst = prm_read_mod_reg(module, wkst_off);
-	wkst &= prm_read_mod_reg(module, grpsel_off);
+	wkst = omap2_prm_read_mod_reg(module, wkst_off);
+	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
 	if (wkst) {
 		iclk = cm_read_mod_reg(module, iclk_off);
 		fclk = cm_read_mod_reg(module, fclk_off);
@@ -225,8 +225,8 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 			if (module == OMAP3430ES2_USBHOST_MOD)
 				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
 			cm_set_mod_reg_bits(clken, module, fclk_off);
-			prm_write_mod_reg(wkst, module, wkst_off);
-			wkst = prm_read_mod_reg(module, wkst_off);
+			omap2_prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = omap2_prm_read_mod_reg(module, wkst_off);
 			c++;
 		}
 		cm_write_mod_reg(iclk, module, iclk_off);
@@ -273,9 +273,9 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
 
-	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+	irqenable_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+	irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 	irqstatus_mpu &= irqenable_mpu;
 
@@ -296,10 +296,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 			     "no code to handle it (%08x)\n", irqstatus_mpu);
 		}
 
-		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
+		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+		irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 		irqstatus_mpu &= irqenable_mpu;
 
@@ -388,7 +388,7 @@ void omap_sram_idle(void)
 	if (omap3_has_io_wakeup() && \
 			(per_next_state < PWRDM_POWER_ON ||
 			core_next_state < PWRDM_POWER_ON)) {
-		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
 
@@ -462,7 +462,7 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
-			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
+			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
@@ -483,7 +483,7 @@ void omap_sram_idle(void)
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_disable_io_chain();
 	}
 
@@ -704,7 +704,7 @@ static void __init omap3_iva_idle(void)
 		return;
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
 			  OMAP3430_RST2_IVA2_MASK |
 			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
@@ -718,13 +718,13 @@ static void __init omap3_iva_idle(void)
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
 
 	/* Un-reset IVA2 */
-	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Disable IVA2 clock */
 	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
 			  OMAP3430_RST2_IVA2_MASK |
 			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
@@ -748,27 +748,27 @@ static void __init omap3_d2d_idle(void)
 	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
 
 	/* reset modem */
-	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
 			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK,
 			  CORE_MOD, OMAP2_RM_RSTCTRL);
-	prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
 }
 
 static void __init prcm_setup_regs(void)
 {
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
-	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
-		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	} else
-		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 
 	/*
 	 * Enable interface clock autoidle for all modules.
@@ -894,38 +894,38 @@ static void __init prcm_setup_regs(void)
 	 * sys_clkreq. In the long run clock framework should
 	 * take care of this.
 	 */
-	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
 			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
 			     OMAP3430_GR_MOD,
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
 			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
 			  OMAP3430_GRPSEL_GPT1_MASK |
 			  OMAP3430_GRPSEL_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
-	prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
+	omap2_prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
 	/* Enable PM_WKEN to support DSS LPR */
-	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
+	omap2_prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
-	prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
 			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
 			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
 			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
 			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
 			  OMAP3430_GRPSEL_GPIO3_MASK |
 			  OMAP3430_GRPSEL_GPIO4_MASK |
 			  OMAP3430_GRPSEL_GPIO5_MASK |
@@ -937,22 +937,22 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+	omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
 
 	/* Clear any pending 'reset' flags */
-	prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
 
 	/* Clear any pending PRCM interrupts */
-	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
 	omap3_iva_idle();
 	omap3_d2d_idle();
diff --git a/arch/arm/mach-omap2/powerdomains2xxx.c b/arch/arm/mach-omap2/powerdomains2xxx.c
index ac173cc..544adc3 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx.c
@@ -38,26 +38,26 @@ int omap2_get_mem_bank_lastmemst_mask(u8 bank)
 
 int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	return prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+	return omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 				(pwrst << OMAP_POWERSTATE_SHIFT),
 				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 }
 
 int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP2_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
 }
 
 int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
 }
 
 int omap2_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
 				OMAP3430_LASTPOWERSTATEENTERED_MASK);
 }
 
@@ -66,7 +66,7 @@ int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	u32 v;
 
 	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
-	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
+	omap2_prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
 				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
@@ -78,7 +78,7 @@ int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 	m = _get_mem_bank_onstate_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
 				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
@@ -90,7 +90,7 @@ int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 	m = _get_mem_bank_retst_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
 					OMAP2_PM_PWSTCTRL);
 
 	return 0;
@@ -98,20 +98,20 @@ int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 int omap2_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
 					OMAP3430_LOGICSTATEST_MASK);
 }
 
 
 int omap2_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
 					OMAP3430_LASTLOGICSTATEENTERED_MASK);
 }
 
 int omap2_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
 					OMAP3430_LOGICSTATEST_MASK);
 }
 
@@ -121,7 +121,7 @@ int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = _get_mem_bank_stst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP2_PM_PWSTST, m);
 }
 
@@ -131,7 +131,7 @@ int omap2_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap2_get_mem_bank_lastmemst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP3430_PM_PREPWSTST, m);
 }
 
@@ -141,25 +141,25 @@ int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 
 	m = _get_mem_bank_retst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP2_PM_PWSTCTRL, m);
 }
 
 int omap2_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
-	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
+	omap2_prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
 	return 0;
 }
 
 int omap2_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 {
-	return prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
+	return omap2_prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
 					pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 }
 
 int omap2_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 {
-	return prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
+	return omap2_prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
 					pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 }
 
@@ -174,7 +174,7 @@ int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
+	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
 		(c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
diff --git a/arch/arm/mach-omap2/powerdomains44xx.c b/arch/arm/mach-omap2/powerdomains44xx.c
index d9686cc..3c4b060 100644
--- a/arch/arm/mach-omap2/powerdomains44xx.c
+++ b/arch/arm/mach-omap2/powerdomains44xx.c
@@ -20,7 +20,7 @@
 
 int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+	omap4_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 				(pwrst << OMAP_POWERSTATE_SHIFT),
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
@@ -28,25 +28,25 @@ int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP4_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
 }
 
 int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP4_PM_PWSTST, OMAP_POWERSTATEST_MASK);
 }
 
 int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
 int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
-	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
+	omap4_prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
 				(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
@@ -57,7 +57,7 @@ int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	u32 v;
 
 	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
-	prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
+	omap4_prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -69,7 +69,7 @@ int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 	m = _get_mem_bank_onstate_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
+	omap4_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)),
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -81,7 +81,7 @@ int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 	m = _get_mem_bank_retst_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+	omap4_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
 					OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -89,13 +89,13 @@ int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst)
 
 int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
 					OMAP4430_LOGICSTATEST_MASK);
 }
 
 int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
 					OMAP4430_LOGICRETSTATE_MASK);
 }
 
@@ -105,7 +105,7 @@ int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = _get_mem_bank_stst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP4_PM_PWSTST, m);
 }
 
@@ -115,7 +115,7 @@ int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 
 	m = _get_mem_bank_retst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap4_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 					OMAP4_PM_PWSTCTRL, m);
 }
 
@@ -130,7 +130,7 @@ int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
+	while ((omap4_prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
 		(c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 124e866..7584227 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -125,9 +125,9 @@ u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
 	if (cpu_is_omap44xx())
-		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
+		return omap4_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 
 	return 0;
 }
@@ -159,10 +159,10 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 		WARN_ON(1);
 
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
+		omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP2_RM_RSTCTRL);
 	if (cpu_is_omap44xx())
-		prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
+		omap4_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
 						 OMAP4_RM_RSTCTRL);
 }
 
@@ -180,7 +180,13 @@ static inline void __omap_prcm_write(u32 value, void __iomem *base,
 }
 
 /* Read a register in a PRM module */
-u32 prm_read_mod_reg(s16 module, u16 idx)
+u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	return __omap_prcm_read(prm_base, module, idx);
+}
+
+/* Read a register in a PRM module */
+u32 omap4_prm_read_mod_reg(s16 module, u16 idx)
 {
 	u32 base = 0;
 
@@ -199,7 +205,13 @@ u32 prm_read_mod_reg(s16 module, u16 idx)
 }
 
 /* Write into a register in a PRM module */
-void prm_write_mod_reg(u32 val, s16 module, u16 idx)
+void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	__omap_prcm_write(val, prm_base, module, idx);
+}
+
+/* Write into a register in a PRM module */
+void omap4_prm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	u32 base = 0;
 
@@ -219,24 +231,49 @@ void prm_write_mod_reg(u32 val, s16 module, u16 idx)
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+{
+	u32 v;
+
+	v = omap2_prm_read_mod_reg(module, idx);
+	v &= ~mask;
+	v |= bits;
+	omap2_prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read-modify-write a register in a PRM module. Caller must lock */
+u32 omap4_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 {
 	u32 v;
 
-	v = prm_read_mod_reg(module, idx);
+	v = omap4_prm_read_mod_reg(module, idx);
 	v &= ~mask;
 	v |= bits;
-	prm_write_mod_reg(v, module, idx);
+	omap4_prm_write_mod_reg(v, module, idx);
+
+	return v;
+}
+
+/* Read a PRM register, AND it, and shift the result down to bit 0 */
+u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	u32 v;
+
+	v = omap2_prm_read_mod_reg(domain, idx);
+	v &= mask;
+	v >>= __ffs(mask);
 
 	return v;
 }
 
 /* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+u32 omap4_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 {
 	u32 v;
 
-	v = prm_read_mod_reg(domain, idx);
+	v = omap4_prm_read_mod_reg(domain, idx);
 	v &= mask;
 	v >>= __ffs(mask);
 
@@ -478,37 +515,37 @@ void omap3_prcm_save_context(void)
 		 cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
 	prcm_context.cm_clkout_ctrl = cm_read_mod_reg(OMAP3430_CCR_MOD,
 		 OMAP3_CM_CLKOUT_CTRL_OFFSET);
-	prcm_context.prm_clkout_ctrl = prm_read_mod_reg(OMAP3430_CCR_MOD,
+	prcm_context.prm_clkout_ctrl = omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
 		OMAP3_PRM_CLKOUT_CTRL_OFFSET);
 	prcm_context.sgx_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430ES2_SGX_MOD, PM_WKDEP);
 	prcm_context.dss_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430_DSS_MOD, PM_WKDEP);
 	prcm_context.cam_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430_CAM_MOD, PM_WKDEP);
 	prcm_context.per_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKDEP);
 	prcm_context.neon_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430_NEON_MOD, PM_WKDEP);
 	prcm_context.usbhost_pm_wkdep =
-		 prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+		 omap2_prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	prcm_context.core_pm_mpugrpsel1 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
+		 omap2_prm_read_mod_reg(CORE_MOD, OMAP3430_PM_MPUGRPSEL1);
 	prcm_context.iva2_pm_ivagrpsel1 =
-		 prm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_PM_IVAGRPSEL1);
+		 omap2_prm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_PM_IVAGRPSEL1);
 	prcm_context.core_pm_mpugrpsel3 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
+		 omap2_prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_MPUGRPSEL3);
 	prcm_context.core_pm_ivagrpsel3 =
-		 prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+		 omap2_prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
 	prcm_context.wkup_pm_mpugrpsel =
-		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
+		 omap2_prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	prcm_context.wkup_pm_ivagrpsel =
-		 prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+		 omap2_prm_read_mod_reg(WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
 	prcm_context.per_pm_mpugrpsel =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
+		 omap2_prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 	prcm_context.per_pm_ivagrpsel =
-		 prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
-	prcm_context.wkup_pm_wken = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+		 omap2_prm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+	prcm_context.wkup_pm_wken = omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 	return;
 }
 
@@ -622,37 +659,37 @@ void omap3_prcm_restore_context(void)
 				OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
 	cm_write_mod_reg(prcm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
 					OMAP3_CM_CLKOUT_CTRL_OFFSET);
-	prm_write_mod_reg(prcm_context.prm_clkout_ctrl, OMAP3430_CCR_MOD,
+	omap2_prm_write_mod_reg(prcm_context.prm_clkout_ctrl, OMAP3430_CCR_MOD,
 					OMAP3_PRM_CLKOUT_CTRL_OFFSET);
-	prm_write_mod_reg(prcm_context.sgx_pm_wkdep, OMAP3430ES2_SGX_MOD,
+	omap2_prm_write_mod_reg(prcm_context.sgx_pm_wkdep, OMAP3430ES2_SGX_MOD,
 					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.dss_pm_wkdep, OMAP3430_DSS_MOD,
+	omap2_prm_write_mod_reg(prcm_context.dss_pm_wkdep, OMAP3430_DSS_MOD,
 					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.cam_pm_wkdep, OMAP3430_CAM_MOD,
+	omap2_prm_write_mod_reg(prcm_context.cam_pm_wkdep, OMAP3430_CAM_MOD,
 					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.per_pm_wkdep, OMAP3430_PER_MOD,
+	omap2_prm_write_mod_reg(prcm_context.per_pm_wkdep, OMAP3430_PER_MOD,
 					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.neon_pm_wkdep, OMAP3430_NEON_MOD,
+	omap2_prm_write_mod_reg(prcm_context.neon_pm_wkdep, OMAP3430_NEON_MOD,
 					PM_WKDEP);
-	prm_write_mod_reg(prcm_context.usbhost_pm_wkdep,
+	omap2_prm_write_mod_reg(prcm_context.usbhost_pm_wkdep,
 					OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
-	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel1, CORE_MOD,
+	omap2_prm_write_mod_reg(prcm_context.core_pm_mpugrpsel1, CORE_MOD,
 					OMAP3430_PM_MPUGRPSEL1);
-	prm_write_mod_reg(prcm_context.iva2_pm_ivagrpsel1, OMAP3430_IVA2_MOD,
+	omap2_prm_write_mod_reg(prcm_context.iva2_pm_ivagrpsel1, OMAP3430_IVA2_MOD,
 					OMAP3430_PM_IVAGRPSEL1);
-	prm_write_mod_reg(prcm_context.core_pm_mpugrpsel3, CORE_MOD,
+	omap2_prm_write_mod_reg(prcm_context.core_pm_mpugrpsel3, CORE_MOD,
 					OMAP3430ES2_PM_MPUGRPSEL3);
-	prm_write_mod_reg(prcm_context.core_pm_ivagrpsel3, CORE_MOD,
+	omap2_prm_write_mod_reg(prcm_context.core_pm_ivagrpsel3, CORE_MOD,
 					OMAP3430ES2_PM_IVAGRPSEL3);
-	prm_write_mod_reg(prcm_context.wkup_pm_mpugrpsel, WKUP_MOD,
+	omap2_prm_write_mod_reg(prcm_context.wkup_pm_mpugrpsel, WKUP_MOD,
 					OMAP3430_PM_MPUGRPSEL);
-	prm_write_mod_reg(prcm_context.wkup_pm_ivagrpsel, WKUP_MOD,
+	omap2_prm_write_mod_reg(prcm_context.wkup_pm_ivagrpsel, WKUP_MOD,
 					OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(prcm_context.per_pm_mpugrpsel, OMAP3430_PER_MOD,
+	omap2_prm_write_mod_reg(prcm_context.per_pm_mpugrpsel, OMAP3430_PER_MOD,
 					OMAP3430_PM_MPUGRPSEL);
-	prm_write_mod_reg(prcm_context.per_pm_ivagrpsel, OMAP3430_PER_MOD,
+	omap2_prm_write_mod_reg(prcm_context.per_pm_ivagrpsel, OMAP3430_PER_MOD,
 					 OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(prcm_context.wkup_pm_wken, WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(prcm_context.wkup_pm_wken, WKUP_MOD, PM_WKEN);
 	return;
 }
 #endif
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 11eeda5..a30b278 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -231,21 +231,33 @@
 #ifndef __ASSEMBLER__
 
 /* Power/reset management domain register get/set */
-extern u32 prm_read_mod_reg(s16 module, u16 idx);
-extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
+extern u32 omap4_prm_read_mod_reg(s16 module, u16 idx);
+extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern void omap4_prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+extern u32 omap4_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
 /* Read-modify-write bits in a PRM register (by domain) */
-static inline u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
+	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
 
-static inline u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+static inline u32 omap4_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+	return omap4_prm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
 
+static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
+
+static inline u32 omap4_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	return omap4_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+}
 #endif
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 9fbd914..6c9df94 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -34,10 +34,14 @@ int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 void omap3_prcm_save_context(void);
 void omap3_prcm_restore_context(void);
 
-u32 prm_read_mod_reg(s16 module, u16 idx);
-void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
+u32 omap4_prm_read_mod_reg(s16 module, u16 idx);
+void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
+void omap4_prm_write_mod_reg(u32 val, s16 module, u16 idx);
+u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+u32 omap4_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+u32 omap4_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 u32 cm_read_mod_reg(s16 module, u16 idx);
 void cm_write_mod_reg(u32 val, s16 module, u16 idx);
 u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-- 
1.7.0.4

