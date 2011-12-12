From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 3/8] ARM: OMAP: prm: add support for chain interrupt handler
Date: Mon, 12 Dec 2011 20:15:28 +0200
Message-ID: <1323713733-13115-4-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45882 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753418Ab1LLSQD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Dec 2011 13:16:03 -0500
In-Reply-To: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, "Avinash.H.M" <avinashhm@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>

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
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/prcm-common.h  |   29 +++++
 arch/arm/mach-omap2/prcm.c         |  229 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   21 ++++
 arch/arm/mach-omap2/prm44xx.c      |   21 ++++
 4 files changed, 300 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 0363dcb..3c54e3c 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -408,6 +408,35 @@
 extern void __iomem *prm_base;
 extern void __iomem *cm_base;
 extern void __iomem *cm2_base;
+
+struct omap_prcm_irq {
+	const char *name;
+	unsigned int offset;
+	bool priority;
+};
+
+struct omap_prcm_irq_setup {
+	u32 ack;
+	u32 mask;
+	int nr_regs;
+	int nr_irqs;
+	const struct omap_prcm_irq *irqs;
+	u32 *saved_mask;
+	u32 *priority_mask;
+	int base_irq;
+	int irq;
+};
+
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
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 597e2da..948247f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -24,6 +24,9 @@
 #include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
 
 #include <mach/system.h>
 #include <plat/common.h>
@@ -45,6 +48,10 @@ void __iomem *cm_base;
 void __iomem *cm2_base;
 
 #define MAX_MODULE_ENABLE_WAIT		100000
+#define OMAP_PRCM_MAX_NR_PENDING_REG	2
+
+static struct irq_chip_generic **prcm_irq_chips;
+static struct omap_prcm_irq_setup *prcm_irq_setup;
 
 u32 omap_prcm_get_reset_sources(void)
 {
@@ -159,3 +166,225 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 	if (omap2_globals->cm2)
 		cm2_base = omap2_globals->cm2;
 }
+
+static inline u32 prcm_irq_read_reg(int offset)
+{
+	return __raw_readl(prm_base + offset);
+}
+
+static inline void prcm_irq_write_reg(u32 value, int offset)
+{
+	__raw_writel(value, prm_base + offset);
+}
+
+static void omap_prm_pending_events(unsigned long *events)
+{
+	u32 mask, st;
+	int i;
+
+	memset(events, 0, prcm_irq_setup->nr_regs * sizeof(unsigned long));
+
+	for (i = 0; i < prcm_irq_setup->nr_regs; i++) {
+		mask = prcm_irq_read_reg(prcm_irq_setup->mask + i * 4);
+		st = prcm_irq_read_reg(prcm_irq_setup->ack + i * 4);
+		events[i] = mask & st;
+	}
+}
+
+/*
+ * Move priority events from events to priority_events array
+ */
+static void omap_prm_events_filter_priority(unsigned long *events,
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
+ * interrupts are detected by a call to prm_pending_events and
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
+		omap_prm_pending_events(pending);
+
+		/* No bit set, then all IRQs are handled */
+		if (find_first_bit(pending, nr_irqs) >= nr_irqs)
+			break;
+
+		omap_prm_events_filter_priority(pending, priority_pending);
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
+	if (!prcm_irq_setup)
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
+/*
+ * Reverses memory allocated and other steps done by
+ * omap_prcm_register_chain_handler
+ */
+void omap_prcm_irq_cleanup(void)
+{
+	int i;
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
+	kfree(prcm_irq_setup->saved_mask);
+	prcm_irq_setup->saved_mask = NULL;
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
+/*
+ * Initializes the prcm chain handler based on provided parameters
+ */
+int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
+{
+	int nr_regs = irq_setup->nr_regs;
+	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
+	int offset;
+	int max_irq = 0;
+	int i;
+	struct irq_chip_generic *gc;
+	struct irq_chip_type *ct;
+
+	if (nr_regs > OMAP_PRCM_MAX_NR_PENDING_REG) {
+		pr_err("PRCM: nr_regs too large\n");
+	goto err;
+	}
+
+	prcm_irq_setup = irq_setup;
+
+	prcm_irq_chips = kzalloc(sizeof(void *) * nr_regs, GFP_KERNEL);
+	prcm_irq_setup->saved_mask = kzalloc(sizeof(u32) * nr_regs, GFP_KERNEL);
+	prcm_irq_setup->priority_mask = kzalloc(sizeof(u32) * nr_regs,
+		GFP_KERNEL);
+
+	if (!prcm_irq_chips || !prcm_irq_setup->saved_mask ||
+	    !prcm_irq_setup->priority_mask) {
+		pr_err("PRCM: kzalloc failed\n");
+		goto err;
+	}
+
+	memset(mask, 0, sizeof(mask));
+
+	for (i = 0; i < irq_setup->nr_irqs; i++) {
+		offset = irq_setup->irqs[i].offset;
+		mask[offset >> 5] |= 1 << (offset & 0x1f);
+		if (offset > max_irq)
+			max_irq = offset;
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
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index f02d87f..9f1aad3 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -27,6 +27,20 @@
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
 
+static const struct omap_prcm_irq omap3_prcm_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",	0,	0),
+	OMAP_PRCM_IRQ("io",	9,	1),
+};
+
+static struct omap_prcm_irq_setup omap3_prcm_irq_setup = {
+	.ack		= OMAP3_PRM_IRQSTATUS_MPU_OFFSET,
+	.mask		= OMAP3_PRM_IRQENABLE_MPU_OFFSET,
+	.nr_regs	= 1,
+	.irqs		= omap3_prcm_irqs,
+	.nr_irqs	= ARRAY_SIZE(omap3_prcm_irqs),
+	.irq		= INT_34XX_PRCM_MPU_IRQ,
+};
+
 u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(prm_base + module + idx);
@@ -212,3 +226,10 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
 {
 	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset);
 }
+
+static int __init omap3xxx_prcm_init(void)
+{
+	if (cpu_is_omap34xx())
+		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 495a31a..17614f7 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -27,6 +27,20 @@
 #include "prcm44xx.h"
 #include "prminst44xx.h"
 
+static const struct omap_prcm_irq omap4_prcm_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",   0,      0),
+	OMAP_PRCM_IRQ("io",     9,      1),
+};
+
+static struct omap_prcm_irq_setup omap4_prcm_irq_setup = {
+	.ack		= OMAP4_PRM_IRQSTATUS_MPU_OFFSET,
+	.mask		= OMAP4_PRM_IRQENABLE_MPU_OFFSET,
+	.nr_regs	= 2,
+	.irqs		= omap4_prcm_irqs,
+	.nr_irqs	= ARRAY_SIZE(omap4_prcm_irqs),
+	.irq		= OMAP44XX_IRQ_PRCM,
+};
+
 /* PRM low-level functions */
 
 /* Read a register in a CM/PRM instance in the PRM module */
@@ -121,3 +135,10 @@ u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
 					       OMAP4430_PRM_DEVICE_INST,
 					       offset);
 }
+
+static int __init omap4xxx_prcm_init(void)
+{
+	if (cpu_is_omap44xx())
+		return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
+	return 0;
+}
-- 
1.7.4.1

