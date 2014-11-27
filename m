From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/23] ARM: OMAP3: PRM: invert the wkst_mask for the prm_clear_mod_irqs
Date: Thu, 27 Nov 2014 17:51:37 +0200
Message-ID: <1417103514-17027-7-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37102 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbaK0Pvp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:51:45 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This makes the API the same as used with OMAP2, and makes it possible
to implement a generic driver API for the functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   18 +++++++++---------
 arch/arm/mach-omap2/prm3xxx.c |    8 ++++----
 arch/arm/mach-omap2/prm3xxx.h |    2 +-
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 175564c..990d802 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -137,9 +137,8 @@ static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
 {
 	int c;
 
-	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1,
-					~(OMAP3430_ST_IO_MASK |
-					  OMAP3430_ST_IO_CHAIN_MASK));
+	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1, OMAP3430_ST_IO_MASK |
+					OMAP3430_ST_IO_CHAIN_MASK);
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
 }
@@ -154,13 +153,14 @@ static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 	 * IO events before parsing in mux code
 	 */
 	c = omap3xxx_prm_clear_mod_irqs(WKUP_MOD, 1,
-					OMAP3430_ST_IO_MASK |
-					OMAP3430_ST_IO_CHAIN_MASK);
-	c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 1, 0);
-	c += omap3xxx_prm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
+					~(OMAP3430_ST_IO_MASK |
+					  OMAP3430_ST_IO_CHAIN_MASK));
+	c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 1, ~0);
+	c += omap3xxx_prm_clear_mod_irqs(OMAP3430_PER_MOD, 1, ~0);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 3, 0);
-		c += omap3xxx_prm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
+		c += omap3xxx_prm_clear_mod_irqs(CORE_MOD, 3, ~0);
+		c += omap3xxx_prm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1,
+						 ~0);
 	}
 
 	return c ? IRQ_HANDLED : IRQ_NONE;
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index c5e00c6..3ec1ff4 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -217,7 +217,7 @@ static void omap3xxx_prm_restore_irqen(u32 *saved_mask)
  * omap3xxx_prm_clear_mod_irqs - clear wake-up events from PRCM interrupt
  * @module: PRM module to clear wakeups from
  * @regs: register set to clear, 1 or 3
- * @ignore_bits: wakeup status bits to ignore
+ * @wkst_mask: wkst bits to clear
  *
  * The purpose of this function is to clear any wake-up events latched
  * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
@@ -226,7 +226,7 @@ static void omap3xxx_prm_restore_irqen(u32 *saved_mask)
  * that any peripheral wake-up events occurring while attempting to
  * clear the PM_WKST_x are detected and cleared.
  */
-int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
+int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
 {
 	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
@@ -238,7 +238,7 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 
 	wkst = omap2_prm_read_mod_reg(module, wkst_off);
 	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
-	wkst &= ~ignore_bits;
+	wkst &= wkst_mask;
 	if (wkst) {
 		iclk = omap2_cm_read_mod_reg(module, iclk_off);
 		fclk = omap2_cm_read_mod_reg(module, fclk_off);
@@ -254,7 +254,7 @@ int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
 			omap2_prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = omap2_prm_read_mod_reg(module, wkst_off);
-			wkst &= ~ignore_bits;
+			wkst &= wkst_mask;
 			c++;
 		}
 		omap2_cm_write_mod_reg(iclk, module, iclk_off);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index cfde3f4..24edef6 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -146,7 +146,7 @@ extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
 extern int __init omap3xxx_prm_init(void);
 extern u32 omap3xxx_prm_get_reset_sources(void);
-int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
+int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
-- 
1.7.9.5

