From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/5] OMAP3: PM: Prevent hang in prcm_interrupt_handler
Date: Fri,  2 Oct 2009 11:14:51 -0700
Message-ID: <1254507295-11381-2-git-send-email-khilman@deeprootsystems.com>
References: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:44292 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757975AbZJBSOy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 14:14:54 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so1224757pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 02 Oct 2009 11:14:58 -0700 (PDT)
In-Reply-To: <1254507295-11381-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

There are two scenarios where a race condition could result in a hang
in the prcm_interrupt handler. These are:

1). Waiting for PRM_IRQSTATUS_MPU register to clear.
Bit 0 of the PRM_IRQSTATUS_MPU register indicates that a wake-up event
is pending for the MPU. This bit can only be cleared if the all the
wake-up events latched in the various PM_WKST_x registers have been
cleared. If a wake-up event occurred during the processing of the prcm
interrupt handler, after the corresponding PM_WKST_x register was
checked but before the PRM_IRQSTATUS_MPU was cleared, then the CPU
would be stuck forever waiting for bit 0 in PRM_IRQSTATUS_MPU to be
cleared.

2). Waiting for the PM_WKST_x register to clear.
Some power domains have more than one wake-up source. The PM_WKST_x
registers indicate the source of a wake-up event and need to be cleared
after a wake-up event occurs. When the PM_WKST_x registers are read and
before they are cleared, it is possible that another wake-up event
could occur causing another bit to be set in one of the PM_WKST_x
registers. If this did occur after reading a PM_WKST_x register then
the CPU would miss this event and get stuck forever in a loop waiting
for that PM_WKST_x register to clear.

This patch address the above race conditions that would result in a
hang.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c |  143 ++++++++++++++++++------------------------
 1 files changed, 60 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0ff5a6c..1e7aae2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -51,97 +51,74 @@ static void (*_omap_sram_idle)(u32 *addr, int save_state);
 
 static struct powerdomain *mpu_pwrdm;
 
-/* PRCM Interrupt Handler for wakeups */
-static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+/*
+ * PRCM Interrupt Handler Helper Function
+ *
+ * The purpose of this function is to clear any wake-up events latched
+ * in the PRCM PM_WKST_x registers. It is possible that a wake-up event
+ * may occur whilst attempting to clear a PM_WKST_x register and thus
+ * set another bit in this register. A while loop is used to ensure
+ * that any peripheral wake-up events occurring while attempting to
+ * clear the PM_WKST_x are detected and cleared.
+ */
+static void prcm_clear_mod_irqs(s16 module, u8 regs)
 {
-	u32 wkst, irqstatus_mpu;
-	u32 fclk, iclk;
+	u32 wkst, fclk, iclk;
+	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
+	u16 fclk_off = (regs == 3) ? OMAP3430ES2_CM_FCLKEN3 : CM_FCLKEN1;
+	u16 iclk_off = (regs == 3) ? CM_ICLKEN3 : CM_ICLKEN1;
 
-	/* WKUP */
-	wkst = prm_read_mod_reg(WKUP_MOD, PM_WKST);
+	wkst = prm_read_mod_reg(module, wkst_off);
 	if (wkst) {
-		iclk = cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
-		fclk = cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
-		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_ICLKEN);
-		cm_set_mod_reg_bits(wkst, WKUP_MOD, CM_FCLKEN);
-		prm_write_mod_reg(wkst, WKUP_MOD, PM_WKST);
-		while (prm_read_mod_reg(WKUP_MOD, PM_WKST))
-			cpu_relax();
-		cm_write_mod_reg(iclk, WKUP_MOD, CM_ICLKEN);
-		cm_write_mod_reg(fclk, WKUP_MOD, CM_FCLKEN);
-	}
-
-	/* CORE */
-	wkst = prm_read_mod_reg(CORE_MOD, PM_WKST1);
-	if (wkst) {
-		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
-		fclk = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN1);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_FCLKEN1);
-		prm_write_mod_reg(wkst, CORE_MOD, PM_WKST1);
-		while (prm_read_mod_reg(CORE_MOD, PM_WKST1))
-			cpu_relax();
-		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN1);
-		cm_write_mod_reg(fclk, CORE_MOD, CM_FCLKEN1);
-	}
-	wkst = prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3);
-	if (wkst) {
-		iclk = cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
-		fclk = cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, CM_ICLKEN3);
-		cm_set_mod_reg_bits(wkst, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-		prm_write_mod_reg(wkst, CORE_MOD, OMAP3430ES2_PM_WKST3);
-		while (prm_read_mod_reg(CORE_MOD, OMAP3430ES2_PM_WKST3))
-			cpu_relax();
-		cm_write_mod_reg(iclk, CORE_MOD, CM_ICLKEN3);
-		cm_write_mod_reg(fclk, CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
-	}
-
-	/* PER */
-	wkst = prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST);
-	if (wkst) {
-		iclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
-		fclk = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
-		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_ICLKEN);
-		cm_set_mod_reg_bits(wkst, OMAP3430_PER_MOD, CM_FCLKEN);
-		prm_write_mod_reg(wkst, OMAP3430_PER_MOD, PM_WKST);
-		while (prm_read_mod_reg(OMAP3430_PER_MOD, PM_WKST))
-			cpu_relax();
-		cm_write_mod_reg(iclk, OMAP3430_PER_MOD, CM_ICLKEN);
-		cm_write_mod_reg(fclk, OMAP3430_PER_MOD, CM_FCLKEN);
+		iclk = cm_read_mod_reg(module, iclk_off);
+		fclk = cm_read_mod_reg(module, fclk_off);
+		while (wkst) {
+			cm_set_mod_reg_bits(wkst, module, iclk_off);
+			cm_set_mod_reg_bits(wkst, module, fclk_off);
+			prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = prm_read_mod_reg(module, wkst_off);
+		}
+		cm_write_mod_reg(iclk, module, iclk_off);
+		cm_write_mod_reg(fclk, module, fclk_off);
 	}
+}
 
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		/* USBHOST */
-		wkst = prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, PM_WKST);
-		if (wkst) {
-			iclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-					       CM_ICLKEN);
-			fclk = cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-					       CM_FCLKEN);
-			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
-					    CM_ICLKEN);
-			cm_set_mod_reg_bits(wkst, OMAP3430ES2_USBHOST_MOD,
-					    CM_FCLKEN);
-			prm_write_mod_reg(wkst, OMAP3430ES2_USBHOST_MOD,
-					  PM_WKST);
-			while (prm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
-						PM_WKST))
-				cpu_relax();
-			cm_write_mod_reg(iclk, OMAP3430ES2_USBHOST_MOD,
-					 CM_ICLKEN);
-			cm_write_mod_reg(fclk, OMAP3430ES2_USBHOST_MOD,
-					 CM_FCLKEN);
+/*
+ * PRCM Interrupt Handler
+ *
+ * The PRM_IRQSTATUS_MPU register indicates if there are any pending
+ * interrupts from the PRCM for the MPU. These bits must be cleared in
+ * order to clear the PRCM interrupt. The PRCM interrupt handler is
+ * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
+ * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
+ * register indicates that a wake-up event is pending for the MPU and
+ * this bit can only be cleared if the all the wake-up events latched
+ * in the various PM_WKST_x registers have been cleared. The interrupt
+ * handler is implemented using a do-while loop so that if a wake-up
+ * event occurred during the processing of the prcm interrupt handler
+ * (setting a bit in the corresponding PM_WKST_x register and thus
+ * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
+ * this would be handled.
+ */
+static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+{
+	u32 irqstatus_mpu;
+
+	do {
+		prcm_clear_mod_irqs(WKUP_MOD, 1);
+		prcm_clear_mod_irqs(CORE_MOD, 1);
+		prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
+		if (omap_rev() > OMAP3430_REV_ES1_0) {
+			prcm_clear_mod_irqs(CORE_MOD, 3);
+			prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
 		}
-	}
 
-	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-	prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
-			  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
+					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-	while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET))
-		cpu_relax();
+	} while (prm_read_mod_reg(OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET));
 
 	return IRQ_HANDLED;
 }
-- 
1.6.4.3

