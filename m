From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 03/35] ARM: OMAP2+: PRM: add generic API for clear_mod_irqs
Date: Wed, 25 Feb 2015 21:04:13 +0200
Message-ID: <1424891085-10392-4-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753287AbbBYTEw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Feb 2015 14:04:52 -0500
In-Reply-To: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

OMAP2/3 now use generic API for the prm_clear_mod_irqs, the SoC specific
implementation details are provided through prm_ll_data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm24xx.c     |   24 +++++++++++-------------
 arch/arm/mach-omap2/pm34xx.c     |   18 ++++++++----------
 arch/arm/mach-omap2/prm.h        |    2 ++
 arch/arm/mach-omap2/prm2xxx.c    |    4 +++-
 arch/arm/mach-omap2/prm2xxx.h    |    2 --
 arch/arm/mach-omap2/prm3xxx.c    |    3 ++-
 arch/arm/mach-omap2/prm3xxx.h    |    1 -
 arch/arm/mach-omap2/prm_common.c |   21 +++++++++++++++++++++
 8 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index fe01c5a..b1aad7e 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -75,9 +75,9 @@ static int omap2_enter_full_retention(void)
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
-	omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-	omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
-	omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
+	omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+	omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
+	omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
 
 	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_RET);
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
@@ -104,18 +104,16 @@ no_sleep:
 	clk_enable(osc_ck);
 
 	/* clear CORE wake-up events */
-	omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-	omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
+	omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+	omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
 
 	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
-	omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, 0x4 | 0x1);
+	omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, 0x4 | 0x1);
 
 	/* MPU domain wake events */
-	omap2xxx_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET,
-				    0x1);
+	omap_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET, 0x1);
 
-	omap2xxx_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET,
-				    0x20);
+	omap_prm_clear_mod_irqs(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET, 0x20);
 
 	pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_ON);
 	pwrdm_set_next_pwrst(core_pwrdm, PWRDM_POWER_ON);
@@ -143,9 +141,9 @@ static void omap2_enter_mpu_retention(void)
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
 		/* REVISIT: These write to reserved bits? */
-		omap2xxx_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
-		omap2xxx_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
-		omap2xxx_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
+		omap_prm_clear_mod_irqs(CORE_MOD, PM_WKST1, ~0);
+		omap_prm_clear_mod_irqs(CORE_MOD, OMAP24XX_PM_WKST2, ~0);
+		omap_prm_clear_mod_irqs(WKUP_MOD, PM_WKST, ~0);
 
 		/* Try to enter MPU retention */
 		pwrdm_set_next_pwrst(mpu_pwrdm, PWRDM_POWER_RET);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2581329..87b98bf9 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -137,8 +137,8 @@ static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
 {
 	int c;
 
-	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1, OMAP3430_ST_IO_MASK |
-					OMAP3430_ST_IO_CHAIN_MASK);
+	c = omap_prm_clear_mod_irqs(WKUP_MOD, 1, OMAP3430_ST_IO_MASK |
+				    OMAP3430_ST_IO_CHAIN_MASK);
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -152,15 +152,13 @@ static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 	 * these are handled in a separate handler to avoid acking
 	 * IO events before parsing in mux code
 	 */
-	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1,
-					~(OMAP3430_ST_IO_MASK |
-					  OMAP3430_ST_IO_CHAIN_MASK));
-	c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 1, ~0);
-	c += omap3xxx_prm_clear_mod_irqs(OMAP3430_PER_MOD, 1, ~0);
+	c = omap_prm_clear_mod_irqs(WKUP_MOD, 1, ~(OMAP3430_ST_IO_MASK |
+						   OMAP3430_ST_IO_CHAIN_MASK));
+	c += omap_prm_clear_mod_irqs(CORE_MOD, 1, ~0);
+	c += omap_prm_clear_mod_irqs(OMAP3430_PER_MOD, 1, ~0);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 3, ~0);
-		c += omap3xxx_prm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1,
-						 ~0);
+		c += omap_prm_clear_mod_irqs(CORE_MOD, 3, ~0);
+		c += omap_prm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, ~0);
 	}
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index ba9b933..2a01a58 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -146,6 +146,7 @@ struct prm_ll_data {
 	int (*is_hardreset_asserted)(u8 shift, u8 part, s16 prm_mod,
 				     u16 offset);
 	void (*reset_system)(void);
+	int (*clear_mod_irqs)(s16 module, u8 regs, u32 wkst_mask);
 };
 
 extern int prm_register(struct prm_ll_data *pld);
@@ -161,6 +162,7 @@ extern void prm_clear_context_loss_flags_old(u8 part, s16 inst, u16 idx);
 void omap_prm_reset_system(void);
 
 void omap_prm_reconfigure_io_chain(void);
+int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index af0f152..bacb05e 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -123,13 +123,14 @@ static void omap2xxx_prm_dpll_reset(void)
  * Clears wakeup status bits for a given module, so that the device can
  * re-enter idle.
  */
-void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
+static int omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
 {
 	u32 wkst;
 
 	wkst = omap2_prm_read_mod_reg(module, regs);
 	wkst &= wkst_mask;
 	omap2_prm_write_mod_reg(wkst, module, regs);
+	return 0;
 }
 
 int omap2xxx_clkdm_sleep(struct clockdomain *clkdm)
@@ -216,6 +217,7 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
 	.reset_system = &omap2xxx_prm_dpll_reset,
+	.clear_mod_irqs = &omap2xxx_prm_clear_mod_irqs,
 };
 
 int __init omap2xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index 1d51643..9c91f4f 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -124,8 +124,6 @@
 extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
 extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
-void omap2xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
-
 extern int __init omap2xxx_prm_init(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 4cc72e8..a444334 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -226,7 +226,7 @@ static void omap3xxx_prm_restore_irqen(u32 *saved_mask)
  * that any peripheral wake-up events occurring while attempting to
  * clear the PM_WKST_x are detected and cleared.
  */
-int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
+static int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
 {
 	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
@@ -664,6 +664,7 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
 	.reset_system = &omap3xxx_prm_dpll3_reset,
+	.clear_mod_irqs = &omap3xxx_prm_clear_mod_irqs,
 };
 
 int __init omap3xxx_prm_init(void)
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 856f3c5..5a09a74 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -145,7 +145,6 @@ extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 extern int __init omap3xxx_prm_init(void);
-int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index c5cfaa9..2c2e7ed 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -534,6 +534,27 @@ void omap_prm_reset_system(void)
 }
 
 /**
+ * omap_prm_clear_mod_irqs - clear wake-up events from PRCM interrupt
+ * @module: PRM module to clear wakeups from
+ * @regs: register to clear
+ * @wkst_mask: wkst bits to clear
+ *
+ * Clears any wakeup events for the module and register set defined.
+ * Uses SoC specific implementation to do the actual wakeup status
+ * clearing.
+ */
+int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
+{
+	if (!prm_ll_data->clear_mod_irqs) {
+		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return prm_ll_data->clear_mod_irqs(module, regs, wkst_mask);
+}
+
+/**
  * prm_register - register per-SoC low-level data with the PRM
  * @pld: low-level per-SoC OMAP PRM data & function pointers to register
  *
-- 
1.7.9.5

