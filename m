From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 01/11] OMAP: prcm: switch to a chained IRQ handler mechanism
Date: Tue, 5 Jul 2011 13:27:47 +0300
Message-ID: <1309861677-2769-2-git-send-email-t-kristo@ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44335 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754501Ab1GEK2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:28:12 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>, Felipe Balbi <balbi@ti.com>

Introduce a chained interrupt handler mechanism for the PRCM
interrupt, so that individual PRCM event can cleanly be handled by
handlers in separate drivers. We do this by introducing PRCM event
names, which are then matched to the particular PRCM interrupt bit
depending on the specific OMAP SoC being used.

arch/arm/mach-omap2/prcm.c implements the chained interrupt mechanism
itself, with individual PRCM events for OMAP3 and OMAP4 being
described in arch/arm/mach-omap2/prcm3xxx.c and
arch/arm/mach-omap2/prcm4xxx.c respectively. At initialization time,
the set of PRCM events is filtered against the SoC on which we are
running, keeping only the ones that are actually useful. All the logic
is written to be generic with regard to OMAP3/OMAP4, even though OMAP3
has single PRCM event registers and OMAP4 has two PRCM event
registers.

Patch tested on OMAP3 beagleboard.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Avinash.H.M <avinashhm@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Makefile           |    4 +
 arch/arm/mach-omap2/pm34xx.c           |  108 ++++++++--------------
 arch/arm/mach-omap2/prcm.c             |  158 ++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm3xxx.c         |  112 ++++++++++++++++++++++
 arch/arm/mach-omap2/prcm4xxx.c         |  137 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/prcm.h |   46 +++++++++
 6 files changed, 495 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prcm3xxx.c
 create mode 100644 arch/arm/mach-omap2/prcm4xxx.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 027958c..8ee70ed 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -39,6 +39,10 @@ AFLAGS_sram242x.o			:=-Wa,-march=armv6
 AFLAGS_sram243x.o			:=-Wa,-march=armv6
 AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
 
+# PRCM
+obj-$(CONFIG_ARCH_OMAP3)                += prcm3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)                += prcm4xxx.o
+
 # Pin multiplexing
 obj-$(CONFIG_SOC_OMAP2420)		+= mux2420.o
 obj-$(CONFIG_SOC_OMAP2430)		+= mux2430.o
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 3279569..d80bf8b 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -64,6 +64,9 @@ static inline bool is_suspending(void)
 }
 #endif
 
+static int prcm_io_irq;
+static int prcm_wkup_irq;
+
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
 
@@ -235,7 +238,7 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 	return c;
 }
 
-static int _prcm_int_handle_wakeup(void)
+static irqreturn_t _prcm_int_handle_wakeup(int irq, void *unused)
 {
 	int c;
 
@@ -247,64 +250,9 @@ static int _prcm_int_handle_wakeup(void)
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
-
-	} while (irqstatus_mpu);
-
-	return IRQ_HANDLED;
+	if (c)
+		return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 static void omap34xx_do_sram_idle(unsigned long save_state)
@@ -854,20 +802,35 @@ static int __init omap3_pm_init(void)
 	/* XXX prcm_setup_regs needs to be before enabling hw
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
+	ret = omap_prcm_irq_init();
+	if (ret) {
+		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
+		goto err_prcm_irq_init;
+	}
+
+	prcm_wkup_irq = omap_prcm_event_to_irq("wkup");
+	prcm_io_irq = omap_prcm_event_to_irq("io");
+
+	ret = request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
+			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
 
-	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
-			  (irq_handler_t)prcm_interrupt_handler,
-			  IRQF_DISABLED, "prcm", NULL);
 	if (ret) {
-		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
-		       INT_34XX_PRCM_MPU_IRQ);
-		goto err1;
+		printk(KERN_ERR "Failed to request prcm_wkup irq\n");
+		goto err_prcm_wkup;
+	}
+
+	ret = request_irq(prcm_io_irq, _prcm_int_handle_wakeup,
+			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_io", NULL);
+
+	if (ret) {
+		printk(KERN_ERR "Failed to request prcm_io irq\n");
+		goto err_prcm_io;
 	}
 
 	ret = pwrdm_for_each(pwrdms_setup, NULL);
 	if (ret) {
 		printk(KERN_ERR "Failed to setup powerdomains\n");
-		goto err2;
+		goto err_pwrdms_setup;
 	}
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
@@ -875,7 +838,7 @@ static int __init omap3_pm_init(void)
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
 	if (mpu_pwrdm == NULL) {
 		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
-		goto err2;
+		goto err_pwrdms_setup;
 	}
 
 	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
@@ -924,14 +887,19 @@ static int __init omap3_pm_init(void)
 	}
 
 	omap3_save_scratchpad_contents();
-err1:
+
 	return ret;
-err2:
-	free_irq(INT_34XX_PRCM_MPU_IRQ, NULL);
+
+ err_pwrdms_setup:
 	list_for_each_entry_safe(pwrst, tmp, &pwrst_list, node) {
 		list_del(&pwrst->node);
 		kfree(pwrst);
 	}
+ err_prcm_io:
+	free_irq(prcm_wkup_irq, NULL);
+ err_prcm_wkup:
+	omap_prcm_irq_cleanup();
+ err_prcm_irq_init:
 	return ret;
 }
 
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 6be1438..e7d602c 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -23,6 +23,8 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
 
 #include <mach/system.h>
 #include <plat/common.h>
@@ -45,6 +47,162 @@ void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
 
+/* Setup for the interrupt handling based on used platform */
+static struct omap_prcm_irq_setup *irq_setup;
+
+static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PENDING_REG];
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
+	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	/*
+	 * Loop until all pending irqs are handled, since
+	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
+	 * can cause new irqs to come
+	 */
+	while (1) {
+		unsigned int virtirq;
+
+		chip->irq_ack(&desc->irq_data);
+
+		memset(pending, 0, sizeof(pending));
+		irq_setup->pending_events(pending);
+
+		/* No bit set, then all IRQs are handled */
+		if (find_first_bit(pending, OMAP_PRCM_NR_IRQS)
+		    >= OMAP_PRCM_NR_IRQS) {
+			chip->irq_unmask(&desc->irq_data);
+			break;
+		}
+
+		/*
+		 * Loop on all currently pending irqs so that new irqs
+		 * cannot starve previously pending irqs
+		 */
+		for_each_set_bit(virtirq, pending, OMAP_PRCM_NR_IRQS)
+			generic_handle_irq(irq_setup->base_irq + virtirq);
+
+		chip->irq_unmask(&desc->irq_data);
+	}
+}
+
+/*
+ * Given a PRCM event name, returns the corresponding IRQ on which the
+ * handler should be registered.
+ */
+int omap_prcm_event_to_irq(const char *name)
+{
+	int i;
+
+	for (i = 0; i < irq_setup->num_irqs; i++)
+		if (!strcmp(irq_setup->irqs[i].name, name))
+			return irq_setup->base_irq + irq_setup->irqs[i].offset;
+
+	return -ENOENT;
+}
+
+/*
+ * Prepare the array of PRCM events corresponding to the current SoC,
+ * and set-up the chained interrupt handler mechanism.
+ */
+int __init omap_prcm_irq_init(void)
+{
+	int i;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	u32 mask[2] = { 0, 0 };
+	int offset;
+	int max_irq = 0;
+
+	for (i = 0; i < irq_setup->num_irqs; i++)
+		if (omap_chip_is(irq_setup->irqs[i].omap_chip)) {
+			offset = irq_setup->irqs[i].offset;
+			if (offset < 32)
+				mask[0] |= 1 << offset;
+			else
+				mask[1] |= 1 << (offset - 32);
+			if (offset > max_irq)
+				max_irq = offset;
+		}
+
+	irq_set_chained_handler(irq_setup->irq, prcm_irq_handler);
+
+	irq_setup->base_irq = irq_alloc_descs(-1, 0, OMAP_PRCM_NR_IRQS, 0);
+
+	if (irq_setup->base_irq < 0) {
+		pr_err("PRCM: failed to allocate irq descs\n");
+		irq_set_chained_handler(irq_setup->irq, NULL);
+		return irq_setup->base_irq;
+	}
+
+	for (i = 0; i <= max_irq / 32; i++) {
+		gc = irq_alloc_generic_chip("PRCM", 1,
+			irq_setup->base_irq + i * 32, NULL, handle_level_irq);
+
+		ct = gc->chip_types;
+		ct->chip.irq_ack = irq_gc_ack;
+		ct->chip.irq_mask = irq_gc_mask_clr_bit;
+		ct->chip.irq_unmask = irq_gc_mask_set_bit;
+
+		ct->regs.ack = irq_setup->ack + (i << 2);
+		ct->regs.mask = irq_setup->mask + (i << 2);
+
+		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
+		prcm_irq_chips[i] = gc;
+	}
+	return 0;
+}
+
+/*
+ * Reverses memory allocated and other setups done by
+ * omap_prcm_irq_init().
+ */
+void omap_prcm_irq_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < OMAP_PRCM_MAX_NR_PENDING_REG; i++)
+		irq_remove_generic_chip(prcm_irq_chips[i], 0xffffffff, 0, 0);
+
+	irq_set_chained_handler(irq_setup->irq, NULL);
+
+	irq_free_descs(irq_setup->base_irq, OMAP_PRCM_NR_IRQS);
+}
+
+void __init omap_prcm_irq_setup(struct omap_prcm_irq_setup *setup)
+{
+	struct omap_prcm_irq *irqs;
+
+	/* Copy setup from __initdata section */
+	irq_setup = kmalloc(sizeof(struct omap_prcm_irq_setup), GFP_KERNEL);
+	memcpy(irq_setup, setup, sizeof(struct omap_prcm_irq_setup));
+
+	irqs = kmalloc(sizeof(struct omap_prcm_irq) *
+		setup->num_irqs, GFP_KERNEL);
+	memcpy(irqs, setup->irqs, sizeof(struct omap_prcm_irq) *
+		setup->num_irqs);
+	irq_setup->irqs = irqs;
+}
+
 u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
diff --git a/arch/arm/mach-omap2/prcm3xxx.c b/arch/arm/mach-omap2/prcm3xxx.c
new file mode 100644
index 0000000..dea8cca
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm3xxx.c
@@ -0,0 +1,112 @@
+/*
+ * OMAP 3xxx Power Reset and Clock Management (PRCM) interrupt
+ * definitions
+ *
+ * Written by Thomas Petazzoni <t-petazzoni@ti.com>
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+#include <plat/prcm.h>
+#include <plat/cpu.h>
+#include <plat/irqs.h>
+#include <plat/io.h>
+
+#include "prm-regbits-24xx.h"
+
+static void omap3_prcm_pending_events(unsigned long *events);
+
+static struct omap_prcm_irq  __initdata omap_prcm_3xxx_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",                  0,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("evgenon",               2,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("evgenoff",              3,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("transition",            4,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("core_dpll_recal",       5,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("periph_dpll_recal",     6,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("mpu_dpll_recal",        7,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("iva2_dpll_recal",       8,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("io",	            9,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_oppchangedone",    10,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_minvdd",           11,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_maxvdd",           12,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_nosmpsack",        13,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_eqvalue",          14,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp1_tranxdone",        15,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_oppchangedone",    16,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_minvdd",           17,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_maxvdd",           18,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_nosmpsack",        19,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_eqvalue",          20,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vp2_tranxdone",        21,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vc_saerr",             22,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vc_raerr",             23,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vc_timeout_err",       24,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("snd_periph_recal",     25,
+		      CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("abb_ldo_tranxdone",    26,
+		      CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vc_vp1_ack",           27,
+		      CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("vc_bypass_ack",        28,
+		      CHIP_GE_OMAP3630ES1_1),
+};
+
+static struct omap_prcm_irq_setup __initdata omap3_prcm_irq_setup = {
+	.ack = (u32)OMAP3430_PRM_IRQSTATUS_MPU,
+	.mask = (u32)OMAP3430_PRM_IRQENABLE_MPU,
+	.pending_events = omap3_prcm_pending_events,
+	.irqs = omap_prcm_3xxx_irqs,
+	.num_irqs = ARRAY_SIZE(omap_prcm_3xxx_irqs),
+	.irq = INT_34XX_PRCM_MPU_IRQ,
+};
+
+static void omap3_prcm_pending_events(unsigned long *events)
+{
+	u32 irqenable_mpu =
+		omap2_prm_read_mod_reg(OCP_MOD,
+				       OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	u32 irqstatus_mpu =
+		omap2_prm_read_mod_reg(OCP_MOD,
+				       OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	events[0] = irqenable_mpu & irqstatus_mpu;
+}
+
+static int __init omap3_prcm_setup_irq(void)
+{
+	if (!cpu_is_omap34xx())
+		return -ENODEV;
+	omap_prcm_irq_setup(&omap3_prcm_irq_setup);
+	return 0;
+}
+arch_initcall(omap3_prcm_setup_irq);
diff --git a/arch/arm/mach-omap2/prcm4xxx.c b/arch/arm/mach-omap2/prcm4xxx.c
new file mode 100644
index 0000000..b1f9201
--- /dev/null
+++ b/arch/arm/mach-omap2/prcm4xxx.c
@@ -0,0 +1,137 @@
+/*
+ * OMAP 4xxx Power Reset and Clock Management (PRCM) interrupt
+ * definitions
+ *
+ * Written by Thomas Petazzoni <t-petazzoni@ti.com>
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+
+#include <plat/prcm.h>
+#include <plat/cpu.h>
+#include <plat/irqs.h>
+#include <plat/io.h>
+
+#include "prcm44xx.h"
+#include "prm44xx.h"
+
+static void omap4_prcm_pending_events(unsigned long *events);
+
+struct omap_prcm_irq __initdata omap_prcm_4xxx_irqs[] = {
+	OMAP_PRCM_IRQ("dpll_core_recal",       0,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_mpu_recal",        1,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_iva_recal",        2,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_per_recal",        3,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_abe_recal",        4,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_usb_recal",        5,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("dpll_unipro_recal",     7,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("transition",            8,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("io",                    9,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vc_saerr",              11,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vc_raerr",              12,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vc_toerr",              13,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vc_bypassack",          14,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_oppchangedone", 16,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_minvdd",        17,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_maxvdd",        18,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_nosmpsack",     19,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_eqvalue",       20,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_core_tranxdone",     21,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_oppchangedone",  24,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_minvdd",         25,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_maxvdd",         26,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_nosmpsack",      27,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_eqvalue",        28,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_tranxdone",      29,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_iva_vpack",          30,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("abb_iva_done",          31,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_oppchangedone",  32,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_minvdd",         33,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_maxvdd",         34,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_nosmpsack",      35,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_eqvalue",        36,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_tranxdone",      37,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("vp_mpu_vpack",          38,
+		      CHIP_IS_OMAP4430),
+	OMAP_PRCM_IRQ("abb_mpu_done",          39,
+		      CHIP_IS_OMAP4430),
+};
+
+static struct omap_prcm_irq_setup __initdata omap4_prcm_irq_setup = {
+	.ack = (u32)OMAP44XX_PRM_REGADDR(OMAP4430_PRM_OCP_SOCKET_INST,
+			OMAP4_PRM_IRQSTATUS_MPU_OFFSET),
+	.mask = (u32)OMAP44XX_PRM_REGADDR(OMAP4430_PRM_OCP_SOCKET_INST,
+			OMAP4_PRM_IRQENABLE_MPU_OFFSET),
+	.pending_events = omap4_prcm_pending_events,
+	.irqs = omap_prcm_4xxx_irqs,
+	.num_irqs = ARRAY_SIZE(omap_prcm_4xxx_irqs),
+	.irq = OMAP44XX_IRQ_PRCM,
+};
+
+void omap4_prcm_pending_events(unsigned long *events)
+{
+	u32 irqenable_mpu, irqstatus_mpu;
+	int i;
+
+	/* OMAP4 has two enable/status registers for the PRCM */
+	for (i = 0; i < 2; i++) {
+		irqenable_mpu =
+			omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+						OMAP4_PRM_IRQENABLE_MPU_OFFSET
+						+ i * 4);
+		irqstatus_mpu =
+			omap4_prm_read_inst_reg(OMAP4430_PRM_OCP_SOCKET_INST,
+						OMAP4_PRM_IRQSTATUS_MPU_OFFSET
+						+ i * 4);
+		events[i] = irqenable_mpu & irqstatus_mpu;
+	}
+}
+
+int __init omap4_prcm_setup_irq(void)
+{
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+	omap_prcm_irq_setup(&omap4_prcm_irq_setup);
+	return 0;
+}
+arch_initcall(omap4_prcm_setup_irq);
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 267f43b..76acbb7 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -27,6 +27,52 @@
 #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
 #define __ASM_ARM_ARCH_OMAP_PRCM_H
 
+#include <plat/cpu.h>
+
+/*
+ * Structure describing the interrupt corresponding to each PRCM event
+ */
+struct omap_prcm_irq {
+	/* Logical name for the interrupt */
+	const char *name;
+
+	/*
+	 * Corresponding offset in the status/enable register. The
+	 * offset can be greater than 32, in which case it spans over
+	 * the second status register
+	 */
+	unsigned int offset;
+
+	/* OMAP chip for which this PRCM event exists */
+	const struct omap_chip_id omap_chip;
+};
+
+#define OMAP_PRCM_IRQ(_name, _offset, _chip)   \
+	{ .name = _name,                       \
+	  .offset = _offset,                   \
+	  .omap_chip = OMAP_CHIP_INIT(_chip) }
+
+/* Maximum number of PRCM interrupt status registers */
+#define OMAP_PRCM_MAX_NR_PENDING_REG	2
+
+/* 64 interrupts needed on OMAP4, 32 on OMAP3 */
+#define OMAP_PRCM_NR_IRQS		64
+
+/* Setup for the PRCM interrupt handler */
+struct omap_prcm_irq_setup {
+	void (*pending_events)(unsigned long *);
+	u32 ack;
+	u32 mask;
+	struct omap_prcm_irq *irqs;
+	int num_irqs;
+	int irq;
+	int base_irq;
+};
+
+int omap_prcm_event_to_irq(const char *name);
+int omap_prcm_irq_init(void);
+void omap_prcm_irq_setup(struct omap_prcm_irq_setup *setup);
+void omap_prcm_irq_cleanup(void);
 u32 omap_prcm_get_reset_sources(void);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

