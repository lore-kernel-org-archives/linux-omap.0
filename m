From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] omap: prcm: switch to a chained IRQ handler mechanism
Date: Wed, 17 Nov 2010 13:16:19 +0100
Message-ID: <1289996179-17698-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:41282 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab0KQMQh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Nov 2010 07:16:37 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <t-petazzoni@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>

From: Thomas Petazzoni <t-petazzoni@ti.com>

Until this patch, the PRCM interrupt was handled through a normal,
single interrupt handler. However, the PRCM notifies various types of
events, which might be of interest to different drivers. In
preparation for the usage of the PRCM interrupt by those drivers, we
switch to a chained interrupt handler model, so that each driver will
be able to register its own interrupt handler on a particular
interrupt line, depending on the event the driver is interested in.

Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c           |  191 +++++++++++++++++++++-----------
 arch/arm/plat-omap/include/plat/irqs.h |   38 ++++++-
 2 files changed, 161 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d068348..77a9a49 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <plat/sram.h>
 #include <plat/clockdomain.h>
@@ -243,7 +244,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 	return c;
 }
 
-static int _prcm_int_handle_wakeup(void)
+static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 {
 	int c;
 
@@ -255,64 +256,10 @@ static int _prcm_int_handle_wakeup(void)
 		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
 	}
 
-	return c;
-}
-
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
-{
-	u32 irqenable_mpu, irqstatus_mpu;
-	int c = 0;
-
-	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
-					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
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
-		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
-					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
-		irqstatus_mpu &= irqenable_mpu;
-
-	} while (irqstatus_mpu);
-
-	return IRQ_HANDLED;
+	if (c)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 static void restore_control_register(u32 val)
@@ -998,11 +945,104 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void prcm_irq_ack(unsigned irq)
+{
+	int prcm_irq = irq - OMAP_PRCM_IRQ_BASE;
+
+	prm_write_mod_reg((1 << prcm_irq), OCP_MOD,
+			  OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+}
+
+static void prcm_irq_mask(unsigned irq)
+{
+	int prcm_irq = irq - OMAP_PRCM_IRQ_BASE;
+
+	prm_rmw_mod_reg_bits((1 << prcm_irq), 0, OCP_MOD,
+			     OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+}
+
+static void prcm_irq_unmask(unsigned irq)
+{
+	int prcm_irq = irq - OMAP_PRCM_IRQ_BASE;
+
+	prm_rmw_mod_reg_bits(0, (1 << prcm_irq), OCP_MOD,
+			     OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+}
+
+static struct irq_chip prcm_irq_chip = {
+	.name     = "PRCM",
+	.ack      = prcm_irq_ack,
+	.mask     = prcm_irq_mask,
+	.unmask   = prcm_irq_unmask,
+};
+
+static u32 prcm_irq_pending(void)
+{
+	u32 irqenable_mpu, irqstatus_mpu;
+
+	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	return irqstatus_mpu & irqenable_mpu;
+}
+
+static void prcm_irq_handle_virtirqs(u32 pending)
+{
+	int virtirq;
+
+	/* Loop on all currently pending irqs so that new irqs cannot
+	 * starve previously pending irqs
+	 */
+	for (virtirq = 0; virtirq < 32; virtirq++)
+		if (pending & (1 << virtirq))
+			generic_handle_irq(OMAP_PRCM_IRQ_BASE + virtirq);
+}
+
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
+static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	u32 pending;
+
+	/* Loop until all pending irqs are handled, since
+	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
+	 * can cause new irqs to come
+	 */
+	while (1) {
+		desc->chip->ack(irq);
+
+		pending = prcm_irq_pending();
+		if (!pending) {
+			desc->chip->unmask(irq);
+			break;
+		}
+
+		prcm_irq_handle_virtirqs(pending);
+		desc->chip->unmask(irq);
+	}
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
 	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
-	int ret;
+	int ret, i;
 
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
@@ -1013,19 +1053,34 @@ static int __init omap3_pm_init(void)
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
 
-	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
-			  (irq_handler_t)prcm_interrupt_handler,
-			  IRQF_DISABLED, "prcm", NULL);
+	for (i = OMAP_PRCM_IRQ_BASE; i < OMAP_PRCM_IRQ_END; i++) {
+		set_irq_chip(i, &prcm_irq_chip);
+		set_irq_handler(i, handle_level_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+
+	set_irq_chained_handler(INT_34XX_PRCM_MPU_IRQ, prcm_irq_handler);
+
+	ret = request_irq(INT_34XX_PRCM_WKUP_EN, _prcm_int_handle_wakeup,
+			  IRQF_NO_SUSPEND, "prcm_wkup", NULL);
 	if (ret) {
 		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
-		       INT_34XX_PRCM_MPU_IRQ);
+		       INT_34XX_PRCM_WKUP_EN);
 		goto err1;
 	}
 
+	ret = request_irq(INT_34XX_PRCM_IO_EN, _prcm_int_handle_wakeup,
+			  IRQF_NO_SUSPEND, "prcm_io", NULL);
+	if (ret) {
+		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
+		       INT_34XX_PRCM_IO_EN);
+		goto err2;
+	}
+
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-		goto err2;
+		goto err3;
 	}
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
@@ -1033,7 +1088,7 @@ static int __init omap3_pm_init(void)
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
-		goto err2;
+		goto err3;
 	}
 
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
@@ -1080,7 +1135,9 @@ static int __init omap3_pm_init(void)
 err1:
 	return ret;
 err2:
-	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+	free_irq(INT_34XX_PRCM_WKUP_EN, NULL);
+err3:
+	free_irq(INT_34XX_PRCM_IO_EN, NULL);
 	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
 		list_del(&pwrst->node);
 		kfree(pwrst);
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 65e20a6..6c5eb1c 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -363,7 +363,43 @@
 #define OMAP_MAX_GPIO_LINES	192
 #define IH_GPIO_BASE		(128 + IH2_BASE)
 #define IH_MPUIO_BASE		(OMAP_MAX_GPIO_LINES + IH_GPIO_BASE)
-#define OMAP_IRQ_END		(IH_MPUIO_BASE + 16)
+#define OMAP_MPUIO_IRQ_END	(IH_MPUIO_BASE + 16)
+
+/* 32 IRQs for the PRCM */
+#define OMAP_PRCM_IRQ_BASE                 (OMAP_MPUIO_IRQ_END)
+#define INT_34XX_PRCM_WKUP_EN              (OMAP_PRCM_IRQ_BASE +  0)
+#define INT_34XX_PRCM_EVGENON_EN           (OMAP_PRCM_IRQ_BASE +  2)
+#define INT_34XX_PRCM_EVGENOFF_EN          (OMAP_PRCM_IRQ_BASE +  3)
+#define INT_34XX_PRCM_TRANSITION_EN        (OMAP_PRCM_IRQ_BASE +  4)
+#define INT_34XX_PRCM_CORE_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  5)
+#define INT_34XX_PRCM_PERIPH_DPLL_RECAL_EN (OMAP_PRCM_IRQ_BASE +  6)
+#define INT_34XX_PRCM_MPU_DPLL_RECAL_EN_EN (OMAP_PRCM_IRQ_BASE +  7)
+#define INT_34XX_PRCM_IVA2_DPLL_RECAL_EN   (OMAP_PRCM_IRQ_BASE +  8)
+#define INT_34XX_PRCM_IO_EN                (OMAP_PRCM_IRQ_BASE +  9)
+#define INT_34XX_PRCM_VP1_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 10)
+#define INT_34XX_PRCM_VP1_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 11)
+#define INT_34XX_PRCM_VP1_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 12)
+#define INT_34XX_PRCM_VP1_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 13)
+#define INT_34XX_PRCM_VP1_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 14)
+#define INT_34XX_PRCM_VP1_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 15)
+#define INT_34XX_PRCM_VP2_OPPCHANGEDONE_EN (OMAP_PRCM_IRQ_BASE + 16)
+#define INT_34XX_PRCM_VP2_MINVDD_EN        (OMAP_PRCM_IRQ_BASE + 17)
+#define INT_34XX_PRCM_VP2_MAXVDD_EN        (OMAP_PRCM_IRQ_BASE + 18)
+#define INT_34XX_PRCM_VP2_NOSMPSACK_EN     (OMAP_PRCM_IRQ_BASE + 19)
+#define INT_34XX_PRCM_VP2_EQVALUE_EN       (OMAP_PRCM_IRQ_BASE + 20)
+#define INT_34XX_PRCM_VP2_TRANXDONE_EN     (OMAP_PRCM_IRQ_BASE + 21)
+#define INT_34XX_PRCM_VC_SAERR_EN          (OMAP_PRCM_IRQ_BASE + 22)
+#define INT_34XX_PRCM_VC_RAERR_EN          (OMAP_PRCM_IRQ_BASE + 23)
+#define INT_34XX_PRCM_VC_TIMEOUT_ERR_EN    (OMAP_PRCM_IRQ_BASE + 24)
+#define INT_34XX_PRCM_SND_PERIPH_RECAL_EN  (OMAP_PRCM_IRQ_BASE + 25)
+#define INT_36XX_PRCM_ABB_LDO_TRANXDONE_EN (OMAP_PRCM_IRQ_BASE + 26)
+#define INT_36XX_PRCM_VC_VP1_ACK_EN        (OMAP_PRCM_IRQ_BASE + 27)
+#define INT_36XX_PRCM_VC_BYPASS_ACK_EN     (OMAP_PRCM_IRQ_BASE + 28)
+#define OMAP_PRCM_NR_IRQS                  32
+#define OMAP_PRCM_IRQ_END                  (OMAP_PRCM_IRQ_BASE + \
+					    OMAP_PRCM_NR_IRQS)
+
+#define OMAP_IRQ_END                       (OMAP_PRCM_IRQ_END)
 
 /* External FPGA handles interrupts on Innovator boards */
 #define	OMAP_FPGA_IRQ_BASE	(OMAP_IRQ_END)
-- 
1.7.0.4

