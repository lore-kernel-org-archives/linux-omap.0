From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/10] ARM: OMAP24xx: PRM: add API for clearing wakeup status bits
Date: Fri, 4 Jul 2014 17:10:31 +0300
Message-ID: <1404483035-21666-7-git-send-email-t-kristo@ti.com>
References: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55087 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756085AbaGDOKn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Jul 2014 10:10:43 -0400
In-Reply-To: <1404483035-21666-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This helps to isolate the PRM into its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c  |   31 +++++++++++++------------------
 arch/arm/mach-omap2/prm2xxx.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx.h |    1 +
 3 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index a5ea988..d76694b 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -75,9 +75,9 @@ static int omap2_enter_full_retention(void)
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
-	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-	omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+	omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+	omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
+	omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
 
 	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
@@ -104,23 +104,18 @@ no_sleep:
 	clk_enable(osc_ck);
 
 	/* clear CORE wake-up events */
-	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+	omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
 
 	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
-	omap2_prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
+	omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, 0x4 | 0x1);
 
 	/* MPU domain wake events */
-	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
-	if (l & 0x01)
-		omap2_prm_write_mod_reg(0x01, OCP_MOD,
-				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
-	if (l & 0x20)
-		omap2_prm_write_mod_reg(0x20, OCP_MOD,
-				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	omap2xxx_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET,
+				    0x1);
 
-	/* Mask future PRCM-to-MPU interrupts */
-	omap2_prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	omap2xxx_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET,
+				    0x20);
 
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
@@ -148,9 +143,9 @@ static void omap2_enter_mpu_retention(void)
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
 		/* REVISIT: These write to reserved bits? */
-		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-		omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+		omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+		omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
+		omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
 
 		/* Try to enter MPU retention */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index a3a3cca..8695805 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -114,6 +114,24 @@ void omap2xxx_prm_dpll_reset(void)
 	omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTCTRL);
 }
 
+/**
+ * omap2xxx_prm_clear_mod_irqs - clear wakeup status bits for a module
+ * @module: PRM module to clear wakeups from
+ * @regs: register offset to clear
+ * @wkst_mask: wakeup status mask to clear
+ *
+ * Clears wakeup status bits for a given module, so that the device can
+ * re-enter idle.
+ */
+void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
+{
+	u32 wkst;
+
+	wkst = omap2_prm_read_mod_reg(module, regs);
+	wkst &= wkst_mask;
+	omap2_prm_write_mod_reg(wkst, module, regs);
+}
+
 int omap2xxx_clkdm_sleep(struct clockdomain *clkdm)
 {
 	omap2_prm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index d2cb636..d734141 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -125,6 +125,7 @@ extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
 extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
 extern void omap2xxx_prm_dpll_reset(void);
+void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 
 extern int __init omap2xxx_prm_init(void);
 
-- 
1.7.9.5

