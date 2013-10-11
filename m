From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/11] ARM: OMAP3: PRM: move PRCM interrupt handler helper to PRM driver
Date: Fri, 11 Oct 2013 19:15:40 +0300
Message-ID: <1381508141-15244-11-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56934 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758558Ab3JKQQk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 12:16:40 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

PM core code should not directly access PRM registers. Thus move the
PRCM interrupt handler helper out of the core PM code to PRM driver,
and use the new API from the core.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   65 ++-------------------------------
 arch/arm/mach-omap2/prm3xxx.c |   79 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    2 ++
 3 files changed, 83 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 4320541..6a5302a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -132,60 +132,11 @@ static void omap3_save_secure_ram_context(void)
 	}
 }
 
-/*
- * PRCM Interrupt Handler Helper Function
- *
- * The purpose of this function is to clear any wake-up events latched
- * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
- * may occur whilst attempting to clear a PM_WKST_x register and thus
- * set another bit in this register. A while loop is used to ensure
- * that any peripheral wake-up events occurring while attempting to
- * clear the PM_WKST_x are detected and cleared.
- */
-static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
-{
-	u32 wkst, fclk, iclk, clken;
-	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
-	u16 grpsel_off = (regs == 3) ?
-		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
-	int c = 0;
-
-	wkst = omap2_prm_read_mod_reg(module, wkst_off);
-	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
-	wkst &= ~ignore_bits;
-	if (wkst) {
-		iclk = omap3_cm_read_module_clken(module, regs, false);
-		fclk = omap3_cm_read_module_clken(module, regs, true);
-		while (wkst) {
-			clken = wkst;
-			omap3_cm_write_module_clken(module, regs, false,
-						    iclk | clken);
-			/*
-			 * For USBHOST, we don't know whether HOST1 or
-			 * HOST2 woke us up, so enable both f-clocks
-			 */
-			if (module == OMAP3430ES2_USBHOST_MOD)
-				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
-			omap3_cm_write_module_clken(module, regs, true,
-						    fclk | clken);
-			omap2_prm_write_mod_reg(wkst, module, wkst_off);
-			wkst = omap2_prm_read_mod_reg(module, wkst_off);
-			wkst &= ~ignore_bits;
-			c++;
-		}
-		omap3_cm_write_module_clken(module, regs, false, iclk);
-		omap3_cm_write_module_clken(module, regs, true, fclk);
-	}
-
-	return c;
-}
-
 static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
 {
 	int c;
 
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
-		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
+	c = omap3_prcm_clear_io_irq();
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -194,19 +145,7 @@ static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 {
 	int c;
 
-	/*
-	 * Clear all except ST_IO and ST_IO_CHAIN for wkup module,
-	 * these are handled in a separate handler to avoid acking
-	 * IO events before parsing in mux code
-	 */
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
-		OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK);
-	c += prcm_clear_mod_irqs(CORE_MOD, 1, 0);
-	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += prcm_clear_mod_irqs(CORE_MOD, 3, 0);
-		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
-	}
+	c = omap3_prcm_clear_wkup_irq();
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
 }
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 3813e9a..50177e9 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -27,6 +27,7 @@
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
 #include "cm3xxx.h"
+#include "cm-regbits-34xx.h"
 #include "control.h"
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
@@ -399,6 +400,84 @@ struct pwrdm_ops omap3_pwrdm_operations = {
 };
 
 /**
+ * omap3_prcm_clear_mod_irqs: PRCM interrupt handler helper function
+ * @module: module offset
+ * @regs: register index
+ * @ignore_bits: bit-mask to ignore while checking wakeup status
+ *
+ * The purpose of this function is to clear any wake-up events latched
+ * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
+ * may occur whilst attempting to clear a PM_WKST_x register and thus
+ * set another bit in this register. A while loop is used to ensure
+ * that any peripheral wake-up events occurring while attempting to
+ * clear the PM_WKST_x are detected and cleared.
+ */
+static int omap3_prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
+{
+	u32 wkst, fclk, iclk, clken;
+	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
+	u16 grpsel_off = (regs == 3) ?
+		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
+	int c = 0;
+
+	wkst = omap2_prm_read_mod_reg(module, wkst_off);
+	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
+	wkst &= ~ignore_bits;
+	if (wkst) {
+		iclk = omap3_cm_read_module_clken(module, regs, false);
+		fclk = omap3_cm_read_module_clken(module, regs, true);
+		while (wkst) {
+			clken = wkst;
+			omap3_cm_write_module_clken(module, regs, false,
+						    iclk | clken);
+			/*
+			 * For USBHOST, we don't know whether HOST1 or
+			 * HOST2 woke us up, so enable both f-clocks
+			 */
+			if (module == OMAP3430ES2_USBHOST_MOD)
+				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
+			omap3_cm_write_module_clken(module, regs, true,
+						    fclk | clken);
+			omap2_prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = omap2_prm_read_mod_reg(module, wkst_off);
+			wkst &= ~ignore_bits;
+			c++;
+		}
+		omap3_cm_write_module_clken(module, regs, false, iclk);
+		omap3_cm_write_module_clken(module, regs, true, fclk);
+	}
+
+	return c;
+}
+
+int omap3_prcm_clear_io_irq(void)
+{
+	return omap3_prcm_clear_mod_irqs(WKUP_MOD, 1,
+		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
+}
+
+int omap3_prcm_clear_wkup_irq(void)
+{
+	int c;
+
+	/*
+	 * Clear all except ST_IO and ST_IO_CHAIN for wkup module,
+	 * these are handled in a separate handler to avoid acking
+	 * IO events before parsing in mux code
+	 */
+	c = omap3_prcm_clear_mod_irqs(WKUP_MOD, 1,
+		OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK);
+	c += omap3_prcm_clear_mod_irqs(CORE_MOD, 1, 0);
+	c += omap3_prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		c += omap3_prcm_clear_mod_irqs(CORE_MOD, 3, 0);
+		c += omap3_prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
+	}
+
+	return c;
+}
+
+/**
  * omap3_prcm_force_idle_iva: ensure IVA is in idle so it can be put into
  *                           retention
  *
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 1befb23..c7d1616 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -154,6 +154,8 @@ extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
 extern void omap3xxx_prm_dpll3_reset(void);
 
+extern int omap3_prcm_clear_io_irq(void);
+extern int omap3_prcm_clear_wkup_irq(void);
 extern void omap3_prm_force_idle_iva(void);
 
 extern int __init omap3xxx_prm_init(void);
-- 
1.7.9.5

