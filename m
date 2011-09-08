From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 4/9] power: omap-prm: added prcm chain interrupt handler
Date: Thu, 8 Sep 2011 18:22:19 +0300
Message-ID: <1315495344-23133-5-git-send-email-t-kristo@ti.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40791 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753772Ab1IHPWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:38 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

The implementation in this patch still requires the irq_setup to be done
properly, and also lacks the supported interrupts. These will be added
in separate patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/power/omap_prm.c       |  214 +++++++++++++++++++++++++++++++++++++++-
 include/linux/power/omap_prm.h |   19 ++++
 2 files changed, 231 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/power/omap_prm.h

diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
index dfc0920..745a4bc 100644
--- a/drivers/power/omap_prm.c
+++ b/drivers/power/omap_prm.c
@@ -15,15 +15,32 @@
 #include <linux/ctype.h>
 #include <linux/module.h>
 #include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 
+#include <plat/irqs.h>
+
 #define DRIVER_NAME "omap-prm"
+#define OMAP_PRCM_MAX_NR_PENDING_REG 2
+
+struct omap_prcm_irq_setup {
+	u32 ack;
+	u32 mask;
+	int irq;
+	int io_irq;
+	int base_irq;
+	int nr_regs;
+	int nr_irqs;
+};
 
 struct omap_prm_device {
 	struct platform_device		pdev;
+	struct omap_prcm_irq_setup	irq_setup;
+	struct irq_chip_generic		**irq_chips;
 };
 
 static struct omap_prm_device prm_dev = {
@@ -33,20 +50,213 @@ static struct omap_prm_device prm_dev = {
 	},
 };
 
-static int __init omap_prm_probe(struct platform_device *pdev)
+static void prm_pending_events(unsigned long *events)
+{
+	u32 ena, st;
+	int i;
+
+	memset(events, 0, prm_dev.irq_setup.nr_regs * 8);
+
+	for (i = 0; i < prm_dev.irq_setup.nr_regs; i++) {
+		ena = readl(prm_dev.irq_setup.mask);
+		st = readl(prm_dev.irq_setup.ack);
+		events[i] = ena & st;
+	}
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
+	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int virtirq;
+	int nr_irqs = prm_dev.irq_setup.nr_irqs;
+
+	/*
+	 * Loop until all pending irqs are handled, since
+	 * generic_handle_irq() can cause new irqs to come
+	 */
+	while (1) {
+		chip->irq_ack(&desc->irq_data);
+
+		prm_pending_events(pending);
+
+		/* No bit set, then all IRQs are handled */
+		if (find_first_bit(pending, nr_irqs) >= nr_irqs) {
+			chip->irq_unmask(&desc->irq_data);
+			break;
+		}
+
+		/*
+		 * Loop on all currently pending irqs so that new irqs
+		 * cannot starve previously pending irqs
+		 */
+		for_each_set_bit(virtirq, pending, nr_irqs)
+			generic_handle_irq(prm_dev.irq_setup.base_irq +
+				virtirq);
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
+	for (i = 0; i < ARRAY_SIZE(omap_prcm_irqs); i++)
+		if (!strcmp(omap_prcm_irqs[i].name, name))
+			return prm_dev.irq_setup.base_irq +
+				omap_prcm_irqs[i].offset;
+
+	return -ENOENT;
+}
+
+/*
+ * Reverses memory allocated and other setups done by
+ * omap_prcm_irq_init().
+ */
+void omap_prcm_irq_cleanup(void)
 {
+	int i;
+
+	if (prm_dev.irq_chips) {
+		for (i = 0; i < prm_dev.irq_setup.nr_regs; i++) {
+			if (prm_dev.irq_chips[i])
+				irq_remove_generic_chip(prm_dev.irq_chips[i],
+					0xffffffff, 0, 0);
+			prm_dev.irq_chips[i] = NULL;
+		}
+		kfree(prm_dev.irq_chips);
+		prm_dev.irq_chips = NULL;
+	}
+
+	irq_set_chained_handler(prm_dev.irq_setup.irq, NULL);
+
+	if (prm_dev.irq_setup.base_irq > 0)
+		irq_free_descs(prm_dev.irq_setup.base_irq,
+				prm_dev.irq_setup.nr_irqs);
+	prm_dev.irq_setup.base_irq = 0;
+}
+
+/*
+ * Prepare the array of PRCM events corresponding to the current SoC,
+ * and set-up the chained interrupt handler mechanism.
+ */
+static int __init omap_prcm_irq_init(void)
+{
+	int i;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+	int offset;
+	int max_irq = 64;
+
+	/* XXX: supported irqs should be setup here */
+
+	irq_set_chained_handler(prm_dev.irq_setup.irq, prcm_irq_handler);
+
+	prm_dev.irq_setup.base_irq =
+		irq_alloc_descs(-1, 0, prm_dev.irq_setup.nr_irqs, 0);
+
+	if (prm_dev.irq_setup.base_irq < 0) {
+		pr_err("PRCM: failed to allocate irq descs\n");
+		goto err;
+	}
+
+	prm_dev.irq_chips = kzalloc(sizeof(void *) * prm_dev.irq_setup.nr_regs,
+		GFP_KERNEL);
+
+	if (!prm_dev.irq_chips) {
+		pr_err("PRCM: kzalloc failed\n");
+		goto err;
+	}
+
+	for (i = 0; i <= max_irq / 32; i++) {
+		gc = irq_alloc_generic_chip("PRCM", 1,
+			prm_dev.irq_setup.base_irq + i * 32, NULL,
+			handle_level_irq);
+
+		if (!gc) {
+			pr_err("PRCM: failed to allocate generic chip\n");
+			goto err;
+		}
+		ct = gc->chip_types;
+		ct->chip.irq_ack = irq_gc_ack_set_bit;
+		ct->chip.irq_mask = irq_gc_mask_clr_bit;
+		ct->chip.irq_unmask = irq_gc_mask_set_bit;
+
+		ct->regs.ack = prm_dev.irq_setup.ack + (i << 2);
+		ct->regs.mask = prm_dev.irq_setup.mask + (i << 2);
+
+		irq_setup_generic_chip(gc, 0xffffffff, 0, IRQ_NOREQUEST, 0);
+		prm_dev.irq_chips[i] = gc;
+	}
+
 	return 0;
+
+err:
+	omap_prcm_irq_cleanup();
+	return -ENOMEM;
 }
 
-static int __devexit omap_prm_remove(struct platform_device *pdev)
+static int omap_prm_prepare(struct device *kdev)
 {
+	disable_irq(prm_dev.irq_setup.io_irq);
 	return 0;
 }
 
+static void omap_prm_complete(struct device *kdev)
+{
+	enable_irq(prm_dev.irq_setup.io_irq);
+}
+
+static int __devexit omap_prm_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int __init omap_prm_probe(struct platform_device *pdev)
+{
+	/* XXX: prm_dev.irq_setup should be populated here */
+
+	/* XXX: following calls should be enabled once irq_setup is done */
+#if 0
+	omap_prcm_irq_init();
+
+	prm_dev.irq_setup.io_irq = omap_prcm_event_to_irq("io");
+#endif
+	return 0;
+}
+
+static const struct dev_pm_ops prm_pm_ops = {
+	.prepare = omap_prm_prepare,
+	.complete = omap_prm_complete,
+};
+
 static struct platform_driver prm_driver = {
 	.remove		= __exit_p(omap_prm_remove),
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.pm	= &prm_pm_ops,
 	},
 };
 
diff --git a/include/linux/power/omap_prm.h b/include/linux/power/omap_prm.h
new file mode 100644
index 0000000..9b161b5
--- /dev/null
+++ b/include/linux/power/omap_prm.h
@@ -0,0 +1,19 @@
+/*
+ * OMAP Power and Reset Management (PRM) driver
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ *
+ * Author: Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_POWER_OMAP_PRM_H__
+#define __LINUX_POWER_OMAP_PRM_H__
+
+int omap_prcm_event_to_irq(const char *name);
+
+#endif
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

