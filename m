From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 06/15] irqdomain: Ensure type settings match for an existing mapping
Date: Thu, 17 Mar 2016 14:19:10 +0000
Message-ID: <1458224359-32665-7-git-send-email-jonathanh@nvidia.com>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

When mapping an IRQ, if a mapping already exists, then we simply return
the virtual IRQ number. However, we do not check that the type settings
for the existing mapping match those for the mapping that is about to be
created. It may be unlikely that the type settings would not match, but
check for this and don't return a valid IRQ mapping if the type settings
do not match.

WARN if the type return by irq_domain_translate() has bits outside the
sense mask set and then clear these bits. If these bits are not cleared
then this will cause the comparision of the type settings for an
existing mapping to fail with that of the new mapping even if the sense
bit themselves match. The reason being is that the existing type
settings are read by calling irq_get_trigger_type() which will clear
any bits outside the sense mask. This will allow us to detect irqchips
that are not correctly clearing these bits and fix them.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 kernel/irq/irqdomain.c | 59 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3a519a01118b..0ea285baa619 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -549,6 +549,13 @@ static int irq_domain_translate(struct irq_domain *d,
 				     fwspec->param, fwspec->param_count,
 				     hwirq, type);
 
+	/*
+	 * WARN if the irqchip returns a type with bits
+	 * outside the sense mask set and clear these bits.
+	 */
+	if (WARN_ON(*type & ~IRQ_TYPE_SENSE_MASK))
+		*type &= IRQ_TYPE_SENSE_MASK;
+
 	/* If domain has no translation, then we assume interrupt line */
 	*hwirq = fwspec->param[0];
 	return 0;
@@ -570,6 +577,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 {
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
+	unsigned int cur_type = IRQ_TYPE_NONE;
 	unsigned int type = IRQ_TYPE_NONE;
 	int virq;
 
@@ -592,23 +600,42 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (irq_domain_translate(domain, fwspec, &hwirq, &type))
 		return 0;
 
-	if (irq_domain_is_hierarchy(domain)) {
-		/*
-		 * If we've already configured this interrupt,
-		 * don't do it again, or hell will break loose.
-		 */
-		virq = irq_find_mapping(domain, hwirq);
-		if (virq)
-			return virq;
-
-		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
-		if (virq <= 0)
-			return 0;
+	/*
+	 * If we've already configured this interrupt,
+	 * don't do it again, or hell will break loose.
+	 */
+	virq = irq_find_mapping(domain, hwirq);
+	if (!virq) {
+		if (irq_domain_is_hierarchy(domain)) {
+			virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE,
+						     fwspec);
+			if (virq <= 0)
+				return 0;
+		} else {
+			/* Create mapping */
+			virq = irq_create_mapping(domain, hwirq);
+			if (!virq)
+				return virq;
+		}
 	} else {
-		/* Create mapping */
-		virq = irq_create_mapping(domain, hwirq);
-		if (!virq)
-			return virq;
+		cur_type = irq_get_trigger_type(virq);
+	}
+
+	/*
+	 * If the trigger type is not specified or matches the current
+	 * trigger type then we are done so return the interrupt number.
+	 */
+	if (type == IRQ_TYPE_NONE || type == cur_type)
+		return virq;
+
+	/*
+	 * If the trigger type is already set and does
+	 * not match this interrupt, then return 0.
+	 */
+	if (cur_type != IRQ_TYPE_NONE) {
+		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
+			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
+		return 0;
 	}
 
 	/* Set type if specified and different than the current one */
-- 
2.1.4
