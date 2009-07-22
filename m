From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH/RFT 3/3] OMAP3: PM: PRCM interrupt: only handle selected PRCM interrupts
Date: Wed, 22 Jul 2009 11:48:22 -0700
Message-ID: <1248288502-3496-4-git-send-email-khilman@deeprootsystems.com>
References: <1248288502-3496-1-git-send-email-khilman@deeprootsystems.com>
 <1248288502-3496-2-git-send-email-khilman@deeprootsystems.com>
 <1248288502-3496-3-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.229]:22850 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577AbZGVSsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 14:48:33 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1312772rvb.5
        for <linux-omap@vger.kernel.org>; Wed, 22 Jul 2009 11:48:33 -0700 (PDT)
In-Reply-To: <1248288502-3496-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

From: Paul Walmsley <paul@pwsan.com>

Clearing wakeup sources is now only done when the PRM indicates a
wakeup source interrupt.  Since we don't handle any other types of
PRCM interrupts right now, warn if we get any other type of PRCM
interrupt.  Either code needs to be added to the PRCM interrupt
handler to react to these, or these other interrupts should be masked
off at init.
---
 arch/arm/mach-omap2/pm34xx.c |   46 +++++++++++++++++++++++++++++++++--------
 1 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 25372b7..348a683 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -204,7 +204,7 @@ static void omap3_save_secure_ram_context(u32 target_mpu_state)
  * that any peripheral wake-up events occurring while attempting to
  * clear the PM_WKST_x are detected and cleared.
  */
-static void prcm_clear_mod_irqs(s16 module, u8 regs)
+static int prcm_clear_mod_irqs(s16 module, u8 regs)
 {
 	u32 wkst, fclk, iclk;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
@@ -212,6 +212,7 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
 	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
 	u16 grpsel_off = (regs == 3) ?
 		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
+	int c = 0;
 
 	wkst = prm_read_mod_reg(module, wkst_off);
 	wkst &= prm_read_mod_reg(module, grpsel_off);
@@ -223,10 +224,28 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
 			cm_set_mod_reg_bits(wkst, module, fclk_off);
 			prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = prm_read_mod_reg(module, wkst_off);
+			c++;
 		}
 		cm_write_mod_reg(iclk, module, iclk_off);
 		cm_write_mod_reg(fclk, module, fclk_off);
 	}
+
+	return c;
+}
+
+static int _prcm_int_handle_wakeup(void)
+{
+	int c;
+
+	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
+	c += prcm_clear_mod_irqs(CORE_MOD, 1);
+	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		c += prcm_clear_mod_irqs(CORE_MOD, 3);
+		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
+	}
+
+	return c;
 }
 
 /*
@@ -249,18 +268,27 @@ static void prcm_clear_mod_irqs(s16 module, u8 regs)
 static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 {
 	u32 irqstatus_mpu;
+	int c = 0;
 
 	do {
-		prcm_clear_mod_irqs(WKUP_MOD, 1);
-		prcm_clear_mod_irqs(CORE_MOD, 1);
-		prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
-		if (omap_rev() > OMAP3430_REV_ES1_0) {
-			prcm_clear_mod_irqs(CORE_MOD, 3);
-			prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
-		}
-
 		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+
+		if (irqstatus_mpu & (OMAP3430_WKUP_ST | OMAP3430_IO_ST)) {
+			c = _prcm_int_handle_wakeup();
+
+			/*
+			 * Is the MPU PRCM interrupt handler racing with the
+			 * IVA2 PRCM interrupt handler ?
+			 */
+			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
+			     "but no wakeup sources are marked\n");
+		} else {
+			/* XXX we need to expand our PRCM interrupt handler */
+			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
+			     "no code to handle it (%08x)\n", irqstatus_mpu);
+		}
+
 		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-- 
1.6.3.3

