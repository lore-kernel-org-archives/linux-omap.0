From: Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH v3 10/21] irqchip: GIC: get rid of routable domain
Date: Mon, 12 Jan 2015 18:26:16 +0000
Message-ID: <1421087187-26988-11-git-send-email-marc.zyngier@arm.com>
References: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60446 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbbALS1N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 13:27:13 -0500
In-Reply-To: <1421087187-26988-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: Stefan Agner <stefan@agner.ch>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org

The only user of the so called "routable domain" functionality
now being fixed, let's clean up the GIC.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c       | 59 ++++-------------------------------------
 include/linux/irqchip/arm-gic.h |  6 -----
 2 files changed, 5 insertions(+), 60 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index d617ee5..9c30a76 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -795,15 +795,12 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic_chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-
-		gic_routable_irq_domain_ops->map(d, irq, hw);
 	}
 	return 0;
 }
 
 static void gic_irq_domain_unmap(struct irq_domain *d, unsigned int irq)
 {
-	gic_routable_irq_domain_ops->unmap(d, irq);
 }
 
 static int gic_irq_domain_xlate(struct irq_domain *d,
@@ -822,16 +819,8 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
 	*out_hwirq = intspec[1] + 16;
 
 	/* For SPIs, we need to add 16 more to get the GIC irq ID number */
-	if (!intspec[0]) {
-		ret = gic_routable_irq_domain_ops->xlate(d, controller,
-							 intspec,
-							 intsize,
-							 out_hwirq,
-							 out_type);
-
-		if (IS_ERR_VALUE(ret))
-			return ret;
-	}
+	if (!intspec[0])
+		*out_hwirq += 16;
 
 	*out_type = intspec[2] & IRQ_TYPE_SENSE_MASK;
 
@@ -888,37 +877,6 @@ static const struct irq_domain_ops gic_irq_domain_ops = {
 	.xlate = gic_irq_domain_xlate,
 };
 
-/* Default functions for routable irq domain */
-static int gic_routable_irq_domain_map(struct irq_domain *d, unsigned int irq,
-			      irq_hw_number_t hw)
-{
-	return 0;
-}
-
-static void gic_routable_irq_domain_unmap(struct irq_domain *d,
-					  unsigned int irq)
-{
-}
-
-static int gic_routable_irq_domain_xlate(struct irq_domain *d,
-				struct device_node *controller,
-				const u32 *intspec, unsigned int intsize,
-				unsigned long *out_hwirq,
-				unsigned int *out_type)
-{
-	*out_hwirq += 16;
-	return 0;
-}
-
-static const struct irq_domain_ops gic_default_routable_irq_domain_ops = {
-	.map = gic_routable_irq_domain_map,
-	.unmap = gic_routable_irq_domain_unmap,
-	.xlate = gic_routable_irq_domain_xlate,
-};
-
-const struct irq_domain_ops *gic_routable_irq_domain_ops =
-					&gic_default_routable_irq_domain_ops;
-
 void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 			   void __iomem *dist_base, void __iomem *cpu_base,
 			   u32 percpu_offset, struct device_node *node)
@@ -926,7 +884,6 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	irq_hw_number_t hwirq_base;
 	struct gic_chip_data *gic;
 	int gic_irqs, irq_base, i;
-	int nr_routable_irqs;
 
 	BUG_ON(gic_nr >= MAX_GIC_NR);
 
@@ -982,15 +939,9 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
 	gic->gic_irqs = gic_irqs;
 
 	if (node) {		/* DT case */
-		const struct irq_domain_ops *ops = &gic_irq_domain_hierarchy_ops;
-
-		if (!of_property_read_u32(node, "arm,routable-irqs",
-					  &nr_routable_irqs)) {
-			ops = &gic_irq_domain_ops;
-			gic_irqs = nr_routable_irqs;
-		}
-
-		gic->domain = irq_domain_add_linear(node, gic_irqs, ops, gic);
+		gic->domain = irq_domain_add_linear(node, gic_irqs,
+						    &gic_irq_domain_hierarchy_ops,
+						    gic);
 	} else {		/* Non-DT case */
 		/*
 		 * For primary GICs, skip over SGIs.
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index 71d706d..3978c5b 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -115,11 +115,5 @@ int gic_get_cpu_id(unsigned int cpu);
 void gic_migrate_target(unsigned int new_cpu_id);
 unsigned long gic_get_sgir_physaddr(void);
 
-extern const struct irq_domain_ops *gic_routable_irq_domain_ops;
-static inline void __init register_routable_domain_ops
-					(const struct irq_domain_ops *ops)
-{
-	gic_routable_irq_domain_ops = ops;
-}
 #endif /* __ASSEMBLY */
 #endif
-- 
2.1.4

