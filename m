From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 06/14] omap3: pm: use prcm chain handler
Date: Fri, 9 Dec 2011 16:27:29 +0200
Message-ID: <1323440857-385-7-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754181Ab1LIO2T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:19 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

PM interrupt handling is now done through the PRCM chain handler. The
interrupt handling logic is also split in two parts, to serve IO and
WKUP events separately. This allows us to handle IO chain events in a
clean way.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |  110 ++++++++++++++----------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |    1 +
 2 files changed, 44 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index efa6649..f6cbb48 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -194,7 +194,7 @@ static void omap3_save_secure_ram_context(void)
  * that any peripheral wake-up events occurring while attempting to
  * clear the PM_WKST_x are detected and cleared.
  */
-static int prcm_clear_mod_irqs(s16 module, u8 regs)
+static int prcm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits)
 {
 	u32 wkst, fclk, iclk, clken;
 	u16 wkst_off = (regs == 3) ? OMAP3430ES2_PM_WKST3 : PM_WKST1;
@@ -206,6 +206,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 
 	wkst = omap2_prm_read_mod_reg(module, wkst_off);
 	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
+	wkst &= ~ignore_bits;
 	if (wkst) {
 		iclk = omap2_cm_read_mod_reg(module, iclk_off);
 		fclk = omap2_cm_read_mod_reg(module, fclk_off);
@@ -221,6 +222,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
 			omap2_prm_write_mod_reg(wkst, module, wkst_off);
 			wkst = omap2_prm_read_mod_reg(module, wkst_off);
+			wkst &= ~ignore_bits;
 			c++;
 		}
 		omap2_cm_write_mod_reg(iclk, module, iclk_off);
@@ -230,76 +232,35 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 	return c;
 }
 
-static int _prcm_int_handle_wakeup(void)
+static irqreturn_t _prcm_int_handle_io(int irq, void *unused)
 {
 	int c;
 
-	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
-	c += prcm_clear_mod_irqs(CORE_MOD, 1);
-	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		c += prcm_clear_mod_irqs(CORE_MOD, 3);
-		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
-	}
+	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
+		~(OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK));
 
-	return c;
+	return c ? IRQ_HANDLED : IRQ_NONE;
 }
 
-/*
- * PRCM Interrupt Handler
- *
- * The PRM_IRQSTATUS_MPU register indicates if there are any pending
- * interrupts from the PRCM for the MPU. These bits must be cleared in
- * order to clear the PRCM interrupt. The PRCM interrupt handler is
- * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
- * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
- * register indicates that a wake-up event is pending for the MPU and
- * this bit can only be cleared if the all the wake-up events latched
- * in the various PM_WKST_x registers have been cleared. The interrupt
- * handler is implemented using a do-while loop so that if a wake-up
- * event occurred during the processing of the prcm interrupt handler
- * (setting a bit in the corresponding PM_WKST_x register and thus
- * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
- * this would be handled.
- */
-static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
+static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 {
-	u32 irqenable_mpu, irqstatus_mpu;
-	int c = 0;
-
-	irqenable_mpu = omap2_prm_read_mod_reg(OCP_MOD,
-					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-	irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
-					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-	irqstatus_mpu &= irqenable_mpu;
-
-	do {
-		if (irqstatus_mpu & (OMAP3430_WKUP_ST_MASK |
-				     OMAP3430_IO_ST_MASK)) {
-			c = _prcm_int_handle_wakeup();
-
-			/*
-			 * Is the MPU PRCM interrupt handler racing with the
-			 * IVA2 PRCM interrupt handler ?
-			 */
-			WARN(c == 0, "prcm: WARNING: PRCM indicated MPU wakeup "
-			     "but no wakeup sources are marked\n");
-		} else {
-			/* XXX we need to expand our PRCM interrupt handler */
-			WARN(1, "prcm: WARNING: PRCM interrupt received, but "
-			     "no code to handle it (%08x)\n", irqstatus_mpu);
-		}
-
-		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-
-		irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-		irqstatus_mpu &= irqenable_mpu;
+	int c;
 
-	} while (irqstatus_mpu);
+	/*
+	 * Clear all except ST_IO and ST_IO_CHAIN for wkup module,
+	 * these are handled in a separate handler to avoid acking
+	 * IO events before parsing in mux code
+	 */
+	c = prcm_clear_mod_irqs(WKUP_MOD, 1,
+		OMAP3430_ST_IO_MASK | OMAP3430_ST_IO_CHAIN_MASK);
+	c += prcm_clear_mod_irqs(CORE_MOD, 1, 0);
+	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1, 0);
+	if (omap_rev() > OMAP3430_REV_ES1_0) {
+		c += prcm_clear_mod_irqs(CORE_MOD, 3, 0);
+		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1, 0);
+	}
 
-	return IRQ_HANDLED;
+	return c ? IRQ_HANDLED : IRQ_NONE;
 }
 
 static void omap34xx_save_context(u32 *save)
@@ -580,6 +541,7 @@ static int omap3_pm_begin(suspend_state_t state)
 	disable_hlt();
 	suspend_state = state;
 	omap_uart_enable_irqs(0);
+	omap_prcm_irq_prepare();
 	return 0;
 }
 
@@ -591,10 +553,16 @@ static void omap3_pm_end(void)
 	return;
 }
 
+static void omap3_pm_finish(void)
+{
+	omap_prcm_irq_complete();
+}
+
 static const struct platform_suspend_ops omap_pm_ops = {
 	.begin		= omap3_pm_begin,
 	.end		= omap3_pm_end,
 	.enter		= omap3_pm_enter,
+	.finish		= omap3_pm_finish,
 	.valid		= suspend_valid_only_mem,
 };
 #endif /* CONFIG_SUSPEND */
@@ -880,12 +848,20 @@ static int __init omap3_pm_init(void)
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
 
-	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
-			  (irq_handler_t)prcm_interrupt_handler,
-			  IRQF_DISABLED, "prcm", NULL);
+	ret = request_irq(omap_prcm_event_to_irq("wkup"),
+		_prcm_int_handle_wakeup, 0, "pm_wkup", NULL);
+
+	if (ret) {
+		printk(KERN_ERR "Failed to request pm_wkup irq\n");
+		goto err1;
+	}
+
+	/* IO interrupt is shared with mux code */
+	ret = request_irq(omap_prcm_event_to_irq("io"),
+		_prcm_int_handle_io, IRQF_SHARED, "pm_io", omap3_pm_init);
+
 	if (ret) {
-		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
-		       INT_34XX_PRCM_MPU_IRQ);
+		printk(KERN_ERR "Failed to request pm_io irq\n");
 		goto err1;
 	}
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9f1aad3..0fc72a4 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -233,3 +233,4 @@ static int __init omap3xxx_prcm_init(void)
 		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
 	return 0;
 }
+subsys_initcall(omap3xxx_prcm_init);
-- 
1.7.4.1

