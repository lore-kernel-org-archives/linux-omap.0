From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/18] ARM: OMAP3: PRM: move prcm wakeup helper to prm driver
Date: Tue, 4 Mar 2014 18:19:04 +0200
Message-ID: <1393949958-816-5-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbaCDQUW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Mar 2014 11:20:22 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to make the prm an individual driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   60 +++++------------------------------------
 arch/arm/mach-omap2/prm3xxx.c |   53 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 60 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 1f3770a..bba96c1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -132,59 +132,11 @@ static void omap3_save_secure_ram_context(void)
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
-	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
-	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
-	u16 grpsel_off = (regs == 3) ?
-		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
-	int c = 0;
-
-	wkst = omap2_prm_read_mod_reg(module, wkst_off);
-	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
-	wkst &= ~ignore_bits;
-	if (wkst) {
-		iclk = omap2_cm_read_mod_reg(module, iclk_off);
-		fclk = omap2_cm_read_mod_reg(module, fclk_off);
-		while (wkst) {
-			clken = wkst;
-			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
-			/*
-			 * For USBHOST, we don't know whether HOST1 or
-			 * HOST2 woke us up, so enable both f-clocks
-			 */
-			if (module == OMAP3430ES2_USBHOST_MOD)
-				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
-			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
-			omap2_prm_write_mod_reg(wkst, module, wkst_off);
-			wkst = omap2_prm_read_mod_reg(module, wkst_off);
-			wkst &= ~ignore_bits;
-			c++;
-		}
-		omap2_cm_write_mod_reg(iclk, module, iclk_off);
-		omap2_cm_write_mod_reg(fclk, module, fclk_off);
-	}
-
-	return c;
-}
-
 static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
 {
 	int c;
 
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
+	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1,
 		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
@@ -199,13 +151,13 @@ static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 	 * these are handled in a separate handler to avoid acking
 	 * IO events before parsing in mux code
 	 */
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
+	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1,
 		OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK);
-	c += prcm_clear_mod_irqs(CORE_MOD, 1, 0);
-	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
+	c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 1, 0);
+	c += omap3xxx_prm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += prcm_clear_mod_irqs(CORE_MOD, 3, 0);
-		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
+		c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 3, 0);
+		c += omap3xxx_prm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
 	}
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 7721990..7d17edc 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -26,6 +26,8 @@
 #include "prm2xxx_3xxx.h"
 #include "cm2xxx_3xxx.h"
 #include "prm-regbits-34xx.h"
+#include "cm3xxx.h"
+#include "cm-regbits-34xx.h"
 
 static const struct omap_prcm_irq omap3_prcm_irqs[] = {
 	OMAP_PRCM_IRQ("wkup",	0,	0),
@@ -205,6 +207,57 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 }
 
 /**
+ * omap3xxx_prm_clear_mod_irqs - clear wake-up events from PRCM interrupt
+ * @module: PRM module to clear wakeups from
+ * @regs: register set to clear, 1 or 3
+ * @ignore_bits: wakeup status bits to ignore
+ *
+ * The purpose of this function is to clear any wake-up events latched
+ * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
+ * may occur whilst attempting to clear a PM_WKST_x register and thus
+ * set another bit in this register. A while loop is used to ensure
+ * that any peripheral wake-up events occurring while attempting to
+ * clear the PM_WKST_x are detected and cleared.
+ */
+int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
+{
+	u32 wkst, fclk, iclk, clken;
+	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
+	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
+	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
+	u16 grpsel_off = (regs == 3) ?
+		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
+	int c = 0;
+
+	wkst = omap2_prm_read_mod_reg(module, wkst_off);
+	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
+	wkst &= ~ignore_bits;
+	if (wkst) {
+		iclk = omap2_cm_read_mod_reg(module, iclk_off);
+		fclk = omap2_cm_read_mod_reg(module, fclk_off);
+		while (wkst) {
+			clken = wkst;
+			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
+			/*
+			 * For USBHOST, we don't know whether HOST1 or
+			 * HOST2 woke us up, so enable both f-clocks
+			 */
+			if (module == OMAP3430ES2_USBHOST_MOD)
+				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
+			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
+			omap2_prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = omap2_prm_read_mod_reg(module, wkst_off);
+			wkst &= ~ignore_bits;
+			c++;
+		}
+		omap2_cm_write_mod_reg(iclk, module, iclk_off);
+		omap2_cm_write_mod_reg(fclk, module, fclk_off);
+	}
+
+	return c;
+}
+
+/**
  * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
  *
  * Clear any previously-latched I/O wakeup events and ensure that the
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index f8eb833..ba602f5 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -162,6 +162,7 @@ extern void omap3xxx_prm_dpll3_reset(void);
 
 extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
+int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5

