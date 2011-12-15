From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] ARM: OMAP: PRCM: add support for chain interrupt handler
Date: Thu, 15 Dec 2011 14:36:18 -0700
Message-ID: <20111215213617.26632.37506.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41004 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759518Ab1LOVhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:40 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, "Avinash.H.M" <avinashhm@ti.com>

From: Tero Kristo <t-kristo@ti.com>

Introduce a chained interrupt handler mechanism for the PRCM
interrupt, so that individual PRCM event can cleanly be handled by
handlers in separate drivers. We do this by introducing PRCM event
names, which are then matched to the particular PRCM interrupt bit
depending on the specific OMAP SoC being used.

PRCM interrupts have two priority levels, high or normal. High priority
is needed for IO event handling, so that we can be sure that IO events
are processed before other events. This reduces latency for IO event
customers and also prevents incorrect ack sequence on OMAP3.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Avinash.H.M <avinashhm@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: drop some dead code; use SoC-specific pending IRQ
 detection; move code to prm_common.c; add lots of documentation;
 remove saved_mask; add OCP barrier on ISR exit; improved error
 handling; split out per-SoC initialization to a separate patch]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile      |    5 -
 arch/arm/mach-omap2/prcm-common.h |   63 ++++++++
 arch/arm/mach-omap2/prm_common.c  |  277 +++++++++++++++++++++++++++++++++++++
 3 files changed, 342 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-omap2/prm_common.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b009f17..2e1ab22 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -14,7 +14,7 @@ clock-common				= clock.o clock_common_data.o \
 
 obj-$(CONFIG_ARCH_OMAP2) += $(omap-2-3-common) $(hwmod-common)
 obj-$(CONFIG_ARCH_OMAP3) += $(omap-2-3-common) $(hwmod-common)
-obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
+obj-$(CONFIG_ARCH_OMAP4) += $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
@@ -77,6 +77,7 @@ endif
 endif
 
 # PRCM
+obj-y					+= prm_common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 					   vc3xxx_data.o vp3xxx_data.o
@@ -86,7 +87,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
+					   vp44xx_data.o prm44xx.o
 
 # OMAP voltage domains
 voltagedomain-common			:= voltage.o vc.o vp.o
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 0363dcb..76db379 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -4,7 +4,7 @@
 /*
  * OMAP2/3 PRCM base and module definitions
  *
- * Copyright (C) 2007-2009 Texas Instruments, Inc.
+ * Copyright (C) 2007-2009, 2011 Texas Instruments, Inc.
  * Copyright (C) 2007-2009 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -408,6 +408,67 @@
 extern void __iomem *prm_base;
 extern void __iomem *cm_base;
 extern void __iomem *cm2_base;
+
+/**
+ * struct omap_prcm_irq - describes a PRCM interrupt bit
+ * @name: a short name describing the interrupt type, e.g. "wkup" or "io"
+ * @offset: the bit shift of the interrupt inside the IRQ{ENABLE,STATUS} regs
+ * @priority: should this interrupt be handled before @priority=false IRQs?
+ *
+ * Describes interrupt bits inside the PRM_IRQ{ENABLE,STATUS}_MPU* registers.
+ * On systems with multiple PRM MPU IRQ registers, the bitfields read from
+ * the registers are concatenated, so @offset could be > 31 on these systems -
+ * see omap_prm_irq_handler() for more details.  I/O ring interrupts should
+ * have @priority set to true.
+ */
+struct omap_prcm_irq {
+	const char *name;
+	unsigned int offset;
+	bool priority;
+};
+
+/**
+ * struct omap_prcm_irq_setup - PRCM interrupt controller details
+ * @ack: PRM register offset for the first PRM_IRQSTATUS_MPU register
+ * @mask: PRM register offset for the first PRM_IRQENABLE_MPU register
+ * @nr_regs: number of PRM_IRQ{STATUS,ENABLE}_MPU* registers
+ * @nr_irqs: number of entries in the @irqs array
+ * @irqs: ptr to an array of PRCM interrupt bits (see @nr_irqs)
+ * @irq: MPU IRQ asserted when a PRCM interrupt arrives
+ * @read_pending_irqs: fn ptr to determine if any PRCM IRQs are pending
+ * @ocp_barrier: fn ptr to force buffered PRM writes to complete
+ * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
+ * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
+ *
+ * @priority_mask and @base_irq are populated dynamically during
+ * omap_prcm_register_chain_handler() - these fields are not to be
+ * specified in static initializers.
+ */
+struct omap_prcm_irq_setup {
+	u16 ack;
+	u16 mask;
+	u8 nr_regs;
+	u8 nr_irqs;
+	const struct omap_prcm_irq *irqs;
+	int irq;
+	void (*read_pending_irqs)(unsigned long *events);
+	void (*ocp_barrier)(void);
+	u32 *priority_mask;
+	int base_irq;
+};
+
+/* OMAP_PRCM_IRQ: convenience macro for creating struct omap_prcm_irq records */
+#define OMAP_PRCM_IRQ(_name, _offset, _priority) {	\
+	.name = _name,					\
+	.offset = _offset,				\
+	.priority = _priority				\
+	}
+
+extern void omap_prcm_irq_cleanup(void);
+extern int omap_prcm_register_chain_handler(
+	struct omap_prcm_irq_setup *irq_setup);
+extern int omap_prcm_event_to_irq(const char *event);
+
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
new file mode 100644
index 0000000..5694be5
--- /dev/null
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -0,0 +1,277 @@
+/*
+ * OMAP2+ common Power & Reset Management (PRM) IP block functions
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *
+ * For historical purposes, the API used to configure the PRM
+ * interrupt handler refers to it as the "PRCM interrupt."  The
+ * underlying registers are located in the PRM on OMAP3/4.
+ *
+ * XXX This code should eventually be moved to a PRM driver.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+
+#include <mach/system.h>
+#include <plat/common.h>
+#include <plat/prcm.h>
+#include <plat/irqs.h>
+
+#include "prm2xxx_3xxx.h"
+#include "prm44xx.h"
+
+/*
+ * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
+ * XXX this is technically not needed, since
+ * omap_prcm_register_chain_handler() could allocate this based on the
+ * actual amount of memory needed for the SoC
+ */
+#define OMAP_PRCM_MAX_NR_PENDING_REG		2
+
+/*
+ * prcm_irq_chips: an array of all of the "generic IRQ chips" in use
+ * by the PRCM interrupt handler code.  There will be one 'chip' per
+ * PRM_{IRQSTATUS,IRQENABLE}_MPU register pair.  (So OMAP3 will have
+ * one "chip" and OMAP4 will have two.)
+ */
+static struct irq_chip_generic **prcm_irq_chips;
+
+/*
+ * prcm_irq_setup: the PRCM IRQ parameters for the hardware the code
+ * is currently running on.  Defined and passed by initialization code
+ * that calls omap_prcm_register_chain_handler().
+ */
+static struct omap_prcm_irq_setup *prcm_irq_setup;
+
+/* Private functions */
+
+/*
+ * Move priority events from events to priority_events array
+ */
+static void omap_prcm_events_filter_priority(unsigned long *events,
+	unsigned long *priority_events)
+{
+	int i;
+
+	for (i = 0; i < prcm_irq_setup->nr_regs; i++) {
+		priority_events[i] =
+			events[i] & prcm_irq_setup->priority_mask[i];
+		events[i] ^= priority_events[i];
+	}
+}
+
+/*
+ * PRCM Interrupt Handler
+ *
+ * This is a common handler for the OMAP PRCM interrupts. Pending
+ * interrupts are detected by a call to prcm_pending_events and
+ * dispatched accordingly. Clearing of the wakeup events should be
+ * done by the SoC specific individual handlers.
+ */
+static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	unsigned long priority_pending[OMAP_PRCM_MAX_NR_PENDING_REG];
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int virtirq;
+	int nr_irqs = prcm_irq_setup->nr_regs * 32;
+
+	/*
+	 * Loop until all pending irqs are handled, since
+	 * generic_handle_irq() can cause new irqs to come
+	 */
+	while (1) {
+		prcm_irq_setup->read_pending_irqs(pending);
+
+		/* No bit set, then all IRQs are handled */
+		if (find_first_bit(pending, nr_irqs) >= nr_irqs)
+			break;
+
+		omap_prcm_events_filter_priority(pending, priority_pending);
+
+		/*
+		 * Loop on all currently pending irqs so that new irqs
+		 * cannot starve previously pending irqs
+		 */
+
+		/* Serve priority events first */
+		for_each_set_bit(virtirq, priority_pending, nr_irqs)
+			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
+
+		/* Serve normal events next */
+		for_each_set_bit(virtirq, pending, nr_irqs)
+			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
+	}
+	if (chip->irq_ack)
+		chip->irq_ack(&desc->irq_data);
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+	chip->irq_unmask(&desc->irq_data);
+
+	prcm_irq_setup->ocp_barrier(); /* avoid spurious IRQs */
+}
+
+/* Public functions */
+
+/**
+ * omap_prcm_event_to_irq - given a PRCM event name, returns the
+ * corresponding IRQ on which the handler should be registered
+ * @name: name of the PRCM interrupt bit to look up - see struct omap_prcm_irq
+ *
+ * Returns the Linux internal IRQ ID corresponding to @name upon success,
+ * or -ENOENT upon failure.
+ */
+int omap_prcm_event_to_irq(const char *name)
+{
+	int i;
+
+	if (!prcm_irq_setup || !name)
+		return -ENOENT;
+
+	for (i = 0; i < prcm_irq_setup->nr_irqs; i++)
+		if (!strcmp(prcm_irq_setup->irqs[i].name, name))
+			return prcm_irq_setup->base_irq +
+				prcm_irq_setup->irqs[i].offset;
+
+	return -ENOENT;
+}
+
+/**
+ * omap_prcm_irq_cleanup - reverses memory allocated and other steps
+ * done by omap_prcm_register_chain_handler()
+ *
+ * No return value.
+ */
+void omap_prcm_irq_cleanup(void)
+{
+	int i;
+
+	if (!prcm_irq_setup) {
+		pr_err("PRCM: IRQ handler not initialized; cannot cleanup\n");
+		return;
+	}
+
+	if (prcm_irq_chips) {
+		for (i = 0; i < prcm_irq_setup->nr_regs; i++) {
+			if (prcm_irq_chips[i])
+				irq_remove_generic_chip(prcm_irq_chips[i],
+					0xffffffff, 0, 0);
+			prcm_irq_chips[i] = NULL;
+		}
+		kfree(prcm_irq_chips);
+		prcm_irq_chips = NULL;
+	}
+
+	kfree(prcm_irq_setup->priority_mask);
+	prcm_irq_setup->priority_mask = NULL;
+
+	irq_set_chained_handler(prcm_irq_setup->irq, NULL);
+
+	if (prcm_irq_setup->base_irq > 0)
+		irq_free_descs(prcm_irq_setup->base_irq,
+			prcm_irq_setup->nr_regs * 32);
+	prcm_irq_setup->base_irq = 0;
+}
+
+/**
+ * omap_prcm_register_chain_handler - initializes the prcm chained interrupt
+ * handler based on provided parameters
+ * @irq_setup: hardware data about the underlying PRM/PRCM
+ *
+ * Set up the PRCM chained interrupt handler on the PRCM IRQ.  Sets up
+ * one generic IRQ chip per PRM interrupt status/enable register pair.
+ * Returns 0 upon success, -EINVAL if called twice or if invalid
+ * arguments are passed, or -ENOMEM on any other error.
+ */
+int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
+{
+	int nr_regs = irq_setup->nr_regs;
+	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
+	int offset, i;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	if (!irq_setup)
+		return -EINVAL;
+
+	if (prcm_irq_setup) {
+		pr_err("PRCM: already initialized; won't reinitialize\n");
+		return -EINVAL;
+	}
+
+	if (nr_regs > OMAP_PRCM_MAX_NR_PENDING_REG) {
+		pr_err("PRCM: nr_regs too large\n");
+		return -EINVAL;
+	}
+
+	prcm_irq_setup = irq_setup;
+
+	prcm_irq_chips = kzalloc(sizeof(void *) * nr_regs, GFP_KERNEL);
+	prcm_irq_setup->priority_mask = kzalloc(sizeof(u32) * nr_regs,
+		GFP_KERNEL);
+
+	if (!prcm_irq_chips || !prcm_irq_setup->priority_mask) {
+		pr_err("PRCM: kzalloc failed\n");
+		goto err;
+	}
+
+	memset(mask, 0, sizeof(mask));
+
+	for (i = 0; i < irq_setup->nr_irqs; i++) {
+		offset = irq_setup->irqs[i].offset;
+		mask[offset >> 5] |= 1 << (offset & 0x1f);
+		if (irq_setup->irqs[i].priority)
+			irq_setup->priority_mask[offset >> 5] |=
+				1 << (offset & 0x1f);
+	}
+
+	irq_set_chained_handler(irq_setup->irq, omap_prcm_irq_handler);
+
+	irq_setup->base_irq = irq_alloc_descs(-1, 0, irq_setup->nr_regs * 32,
+		0);
+
+	if (irq_setup->base_irq < 0) {
+		pr_err("PRCM: failed to allocate irq descs: %d\n",
+			irq_setup->base_irq);
+		goto err;
+	}
+
+	for (i = 0; i <= irq_setup->nr_regs; i++) {
+		gc = irq_alloc_generic_chip("PRCM", 1,
+			irq_setup->base_irq + i * 32, prm_base,
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
+		ct->regs.ack = irq_setup->ack + i * 4;
+		ct->regs.mask = irq_setup->mask + i * 4;
+
+		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
+		prcm_irq_chips[i] = gc;
+	}
+
+	return 0;
+
+err:
+	omap_prcm_irq_cleanup();
+	return -ENOMEM;
+}


