From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 06/16] power: omap-prm: added chain interrupt handler
Date: Fri, 16 Sep 2011 19:05:40 +0300
Message-ID: <1316189150-21448-7-git-send-email-t-kristo@ti.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37931 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755315Ab1IPQGe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:34 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

Introduce a chained interrupt handler mechanism for the PRCM
interrupt, so that individual PRCM event can cleanly be handled by
handlers in separate drivers. We do this by introducing PRCM event
names, which are then matched to the particular PRCM interrupt bit
depending on the specific OMAP SoC being used.

Driver detects the version of the PRM module in use via PRM hwmod
revision. This hwmod also defines the interrupt number for the chain
handler. Driver itself contains SoC specific data for register offsets
within the PRM module, and contains a list of supported PRCM interrupt
events.

PRCM interrupts have two priority levels, high or normal. High priority
is needed for IO event handling, so that we can be sure that IO events
are processed before other events. This reduces latency for IO event
customers and also prevents incorrect ack sequence on OMAP3.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Avinash.H.M <avinashhm@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/power/omap_prm.c       |  351 +++++++++++++++++++++++++++++++++++++++-
 include/linux/power/omap_prm.h |   19 +++
 2 files changed, 368 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/power/omap_prm.h

diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
index dfc0920..880748a 100644
--- a/drivers/power/omap_prm.c
+++ b/drivers/power/omap_prm.c
@@ -15,15 +15,59 @@
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
+#include <plat/omap_hwmod.h>
+
 #define DRIVER_NAME "omap-prm"
+#define OMAP_PRCM_MAX_NR_PENDING_REG 2
+
+struct omap_prcm_irq_setup {
+	u32 ack;
+	u32 mask;
+	int nr_regs;
+};
 
 struct omap_prm_device {
-	struct platform_device		pdev;
+	struct platform_device			pdev;
+	const struct omap_prcm_irq_setup	*irq_setup;
+	struct irq_chip_generic			**irq_chips;
+	int					suspended;
+	u32					*saved_ena;
+	u32					*priority_mask;
+	int					base_irq;
+	int					irq;
+	void __iomem				*base;
+	int					revision;
+};
+
+#define OMAP3_PRM_REVISION		0x10
+#define OMAP4_PRM_REVISION		0x40000100
+
+#define PRM_OMAP3			0x1
+#define PRM_OMAP4			0x2
+
+#define OMAP3_PRM_IRQSTATUS_OFFSET	0x818
+#define OMAP3_PRM_IRQENABLE_OFFSET	0x81c
+#define OMAP4_PRM_IRQSTATUS_OFFSET	0x10
+#define OMAP4_PRM_IRQENABLE_OFFSET	0x18
+
+static const struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
+	.ack		= OMAP3_PRM_IRQSTATUS_OFFSET,
+	.mask		= OMAP3_PRM_IRQENABLE_OFFSET,
+	.nr_regs	= 1,
+};
+
+static const struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
+	.ack		= OMAP4_PRM_IRQSTATUS_OFFSET,
+	.mask		= OMAP4_PRM_IRQENABLE_OFFSET,
+	.nr_regs	= 2,
 };
 
 static struct omap_prm_device prm_dev = {
@@ -33,20 +77,321 @@ static struct omap_prm_device prm_dev = {
 	},
 };
 
-static int __init omap_prm_probe(struct platform_device *pdev)
+struct omap_prcm_irq {
+	const char *name;
+	unsigned int offset;
+	bool priority;
+	u32 supported_rev;
+};
+
+#define OMAP_PRCM_IRQ(_name, _offset, _high_priority, _rev) {	\
+	.name = _name,				\
+	.offset = _offset,			\
+	.priority = _high_priority,		\
+	.supported_rev = _rev			\
+	}
+
+static struct omap_prcm_irq omap_prcm_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",		0,	0,	PRM_OMAP3),
+	OMAP_PRCM_IRQ("io",		9,	1,	PRM_OMAP3 | PRM_OMAP4),
+};
+
+static inline u32 prm_read_reg(int offset)
+{
+	return __raw_readl(prm_dev.base + offset);
+}
+
+static inline void prm_write_reg(u32 value, int offset)
+{
+	__raw_writel(value, prm_dev.base + offset);
+}
+
+static void prm_pending_events(unsigned long *events)
+{
+	u32 ena, st;
+	int i;
+
+	memset(events, 0, prm_dev.irq_setup->nr_regs * 4);
+
+	for (i = 0; i < prm_dev.irq_setup->nr_regs; i++) {
+		ena = prm_read_reg(prm_dev.irq_setup->mask + i * 4);
+		st = prm_read_reg(prm_dev.irq_setup->ack + i * 4);
+		events[i] = ena & st;
+	}
+}
+
+static void prm_events_filter_priority(unsigned long *events,
+	unsigned long *priority_events)
+{
+	int i;
+
+	for (i = 0; i < prm_dev.irq_setup->nr_regs; i++) {
+		priority_events[i] = events[i] & prm_dev.priority_mask[i];
+		events[i] ^= priority_events[i];
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
+	int i;
+	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	unsigned long priority_pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int virtirq;
+	int nr_irqs = prm_dev.irq_setup->nr_regs * 32;
+
+	if (prm_dev.suspended)
+		for (i = 0; i < prm_dev.irq_setup->nr_regs; i++) {
+			prm_dev.saved_ena[i] =
+				prm_read_reg(prm_dev.irq_setup->mask + i * 4);
+			prm_write_reg(0, prm_dev.irq_setup->mask + i * 4);
+		}
+
+	/*
+	 * Loop until all pending irqs are handled, since
+	 * generic_handle_irq() can cause new irqs to come
+	 */
+	while (!prm_dev.suspended) {
+		prm_pending_events(pending);
+
+		/* No bit set, then all IRQs are handled */
+		if (find_first_bit(pending, nr_irqs) >= nr_irqs)
+			break;
+
+		prm_events_filter_priority(pending, priority_pending);
+
+		/*
+		 * Loop on all currently pending irqs so that new irqs
+		 * cannot starve previously pending irqs
+		 */
+
+		/* Serve priority events first */
+		for_each_set_bit(virtirq, priority_pending, nr_irqs)
+			generic_handle_irq(prm_dev.base_irq + virtirq);
+
+		/* Serve normal events next */
+		for_each_set_bit(virtirq, pending, nr_irqs)
+			generic_handle_irq(prm_dev.base_irq + virtirq);
+	}
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+	chip->irq_unmask(&desc->irq_data);
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
+			return prm_dev.base_irq + omap_prcm_irqs[i].offset;
+
+	return -ENOENT;
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
+	if (prm_dev.irq_chips) {
+		for (i = 0; i < prm_dev.irq_setup->nr_regs; i++) {
+			if (prm_dev.irq_chips[i])
+				irq_remove_generic_chip(prm_dev.irq_chips[i],
+					0xffffffff, 0, 0);
+			prm_dev.irq_chips[i] = NULL;
+		}
+		kfree(prm_dev.irq_chips);
+		prm_dev.irq_chips = NULL;
+	}
+
+	kfree(prm_dev.saved_ena);
+	prm_dev.saved_ena = NULL;
+
+	kfree(prm_dev.priority_mask);
+	prm_dev.priority_mask = NULL;
+
+	irq_set_chained_handler(prm_dev.irq, NULL);
+
+	if (prm_dev.base_irq > 0)
+		irq_free_descs(prm_dev.base_irq,
+			prm_dev.irq_setup->nr_regs * 32);
+	prm_dev.base_irq = 0;
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
+	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
+	int offset;
+	int max_irq = 0;
+
+	prm_dev.irq_chips = kzalloc(sizeof(void *) * prm_dev.irq_setup->nr_regs,
+		GFP_KERNEL);
+
+	prm_dev.saved_ena = kzalloc(sizeof(u32) * prm_dev.irq_setup->nr_regs,
+		GFP_KERNEL);
+
+	prm_dev.priority_mask = kzalloc(sizeof(u32) *
+		prm_dev.irq_setup->nr_regs, GFP_KERNEL);
+
+	if (!prm_dev.irq_chips || !prm_dev.saved_ena ||
+	    !prm_dev.priority_mask) {
+		pr_err("PRCM: kzalloc failed\n");
+		goto err;
+	}
+
+	memset(mask, 0, sizeof(mask));
+	for (i = 0; i < ARRAY_SIZE(omap_prcm_irqs); i++)
+		if (prm_dev.revision & omap_prcm_irqs[i].supported_rev) {
+			offset = omap_prcm_irqs[i].offset;
+			mask[offset >> 5] |= 1 << (offset & 0x1f);
+			if (offset > max_irq)
+				max_irq = offset;
+			if (omap_prcm_irqs[i].priority)
+				prm_dev.priority_mask[offset >> 5] |=
+					1 << (offset & 0x1f);
+		}
+
+	irq_set_chained_handler(prm_dev.irq, prcm_irq_handler);
+
+	prm_dev.base_irq =
+		irq_alloc_descs(-1, 0, prm_dev.irq_setup->nr_regs * 32, 0);
+
+	if (prm_dev.base_irq < 0) {
+		pr_err("PRCM: failed to allocate irq descs\n");
+		goto err;
+	}
+
+	for (i = 0; i <= prm_dev.irq_setup->nr_regs; i++) {
+		gc = irq_alloc_generic_chip("PRCM", 1,
+			prm_dev.base_irq + i * 32, prm_dev.base,
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
+		ct->regs.ack = prm_dev.irq_setup->ack + (i << 2);
+		ct->regs.mask = prm_dev.irq_setup->mask + (i << 2);
+
+		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
+		prm_dev.irq_chips[i] = gc;
+	}
+
+	return 0;
+
+err:
+	omap_prcm_irq_cleanup();
+	return -ENOMEM;
+}
+
+static int omap_prm_prepare(struct device *kdev)
 {
+	prm_dev.suspended = 1;
 	return 0;
 }
 
+static void omap_prm_complete(struct device *kdev)
+{
+	int i;
+
+	prm_dev.suspended = 0;
+
+	for (i = 0; i < prm_dev.irq_setup->nr_regs; i++)
+		prm_write_reg(prm_dev.saved_ena[i],
+			prm_dev.irq_setup->mask + i * 4);
+}
+
 static int __devexit omap_prm_remove(struct platform_device *pdev)
 {
 	return 0;
 }
 
+static int __init omap_prm_probe(struct platform_device *pdev)
+{
+	struct omap_hwmod *oh;
+	int rev;
+
+	oh = omap_hwmod_lookup("prm");
+
+	if (!oh) {
+		pr_err("prm hwmod not found\n");
+		return -ENODEV;
+	}
+
+	prm_dev.base = omap_hwmod_get_mpu_rt_va(oh);
+
+	rev = prm_read_reg(oh->class->sysc->rev_offs);
+
+	switch (rev) {
+	case OMAP3_PRM_REVISION:
+		prm_dev.irq_setup = &omap3_prcm_irq_setup;
+		prm_dev.revision = PRM_OMAP3;
+		break;
+	case OMAP4_PRM_REVISION:
+		prm_dev.irq_setup = &omap4_prcm_irq_setup;
+		prm_dev.revision = PRM_OMAP4;
+		break;
+	default:
+		pr_err("unknown PRM revision: %08x\n", rev);
+		return -ENODEV;
+	}
+
+	prm_dev.irq = oh->mpu_irqs[0].irq;
+
+	omap_prcm_irq_init();
+
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
 

