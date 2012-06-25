From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: fix naming collision of variable nr_irqs
Date: Mon, 25 Jun 2012 15:56:39 +0530
Message-ID: <1340620000-27074-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755054Ab2FYK1N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 06:27:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Venkatraman S <svenkatr@ti.com>

Using nr_irqs as local variable name triggers the sparse warning..
./arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'nr_irqs' shadows an earlier one
./linux/include/linux/irqnr.h:26:12: originally declared here

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/irq.c        |    8 ++++----
 arch/arm/mach-omap2/prm_common.c |    8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index 6038a8c..4c35366 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -262,7 +262,7 @@ int __init omap_intc_of_init(struct device_node *node,
 			     struct device_node *parent)
 {
 	struct resource res;
-	u32 nr_irqs = 96;
+	u32 nr_irq = 96;
 
 	if (WARN_ON(!node))
 		return -ENODEV;
@@ -272,10 +272,10 @@ int __init omap_intc_of_init(struct device_node *node,
 		return -EINVAL;
 	}
 
-	if (of_property_read_u32(node, "ti,intc-size", &nr_irqs))
-		pr_warn("unable to get intc-size, default to %d\n", nr_irqs);
+	if (of_property_read_u32(node, "ti,intc-size", &nr_irq))
+		pr_warn("unable to get intc-size, default to %d\n", nr_irq);
 
-	omap_init_irq(res.start, nr_irqs, of_node_get(node));
+	omap_init_irq(res.start, nr_irq, of_node_get(node));
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index dfe00dd..534d732 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -85,7 +85,7 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long priority_pending[OMAP_PRCM_MAX_NR_PENDING_REG];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virtirq;
-	int nr_irqs = prcm_irq_setup->nr_regs * 32;
+	int nr_irq = prcm_irq_setup->nr_regs * 32;
 
 	/*
 	 * If we are suspended, mask all interrupts from PRCM level,
@@ -110,7 +110,7 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 		prcm_irq_setup->read_pending_irqs(pending);
 
 		/* No bit set, then all IRQs are handled */
-		if (find_first_bit(pending, nr_irqs) >= nr_irqs)
+		if (find_first_bit(pending, nr_irq) >= nr_irq)
 			break;
 
 		omap_prcm_events_filter_priority(pending, priority_pending);
@@ -121,11 +121,11 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 		 */
 
 		/* Serve priority events first */
-		for_each_set_bit(virtirq, priority_pending, nr_irqs)
+		for_each_set_bit(virtirq, priority_pending, nr_irq)
 			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
 
 		/* Serve normal events next */
-		for_each_set_bit(virtirq, pending, nr_irqs)
+		for_each_set_bit(virtirq, pending, nr_irq)
 			generic_handle_irq(prcm_irq_setup->base_irq + virtirq);
 	}
 	if (chip->irq_ack)
-- 
1.7.0.4

