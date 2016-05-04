From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V3 04/17] irqdomain: Fix handling of type settings for existing mappings
Date: Wed, 4 May 2016 17:25:17 +0100
Message-ID: <1462379130-11742-5-git-send-email-jonathanh@nvidia.com>
References: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462379130-11742-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>
List-Id: linux-omap@vger.kernel.org

When mapping an IRQ, it is possible that a mapping for the IRQ already
exists. If mapping does exist then there are the following issues with
regard to the handling of the IRQ type settings ...
1. If the domain is part of a hierarchy, then:
   a. We do not check that the type settings for the existing mapping
      match those of the new mapping.
   b. We do not check to see if the type settings have been programmed
      yet (and they might not have been) and so we may never set the
      type.
2. If the domain is NOT part of a hierarchy, we will overwrite the
   current type settings programmed if they are different from the
   previous mapping. Please note that irq_create_mapping()
   calls irq_find_mapping() to check if a mapping already exists.

Although, it may be unlikely that the type settings for a shared
interrupt would not match, nonetheless we should check for this.
Therefore, to fix this check if a mapping exists (regardless of whether
the domain is part of a hierarchy or not) and if it does then:
1. Return the IRQ number if the type settings match or are not
   specified.
2. Program the type settings and return the IRQ number if the type
   settings have not been programmed yet.
3. Otherwise if the type setting do not match, then print a warning
   and don't return the IRQ number.

Furthermore, add a warning if the type return by irq_domain_translate()
has bits outside the sense mask set and then clear these bits. If these
bits are not cleared then this will cause the comparision of the type
settings for an existing mapping to fail with that of the new mapping
even if the sense bit themselves match. The reason being is that the
existing type settings are read by calling irq_get_trigger_type() which
will clear any bits outside the sense mask. This will allow us to detect
irqchips that are not correctly clearing these bits and fix them.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
---
 kernel/irq/irqdomain.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e564e16f2530..d68371213fc9 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -587,15 +587,42 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
 	if (irq_domain_translate(domain, fwspec, &hwirq, &type))
 		return 0;
 
-	if (irq_domain_is_hierarchy(domain)) {
+	/*
+	 * WARN if the irqchip returns a type with bits
+	 * outside the sense mask set and clear these bits.
+	 */
+	if (WARN_ON(type & ~IRQ_TYPE_SENSE_MASK))
+		type &= IRQ_TYPE_SENSE_MASK;
+
+	/*
+	 * If we've already configured this interrupt,
+	 * don't do it again, or hell will break loose.
+	 */
+	virq = irq_find_mapping(domain, hwirq);
+	if (virq) {
 		/*
-		 * If we've already configured this interrupt,
-		 * don't do it again, or hell will break loose.
+		 * If the trigger type is not specified or matches the
+		 * current trigger type then we are done so return the
+		 * interrupt number.
 		 */
-		virq = irq_find_mapping(domain, hwirq);
-		if (virq)
+		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
 			return virq;
 
+		/*
+		 * If the trigger type has not been set yet, then set
+		 * it now and return the interrupt number.
+		 */
+		if (irq_get_trigger_type(virq) == IRQ_TYPE_NONE) {
+			irq_set_irq_type(virq, type);
+			return virq;
+		}
+
+		pr_warn("type mismatch, failed to map hwirq-%lu for %s!\n",
+			hwirq, of_node_full_name(to_of_node(fwspec->fwnode)));
+		return 0;
+	}
+
+	if (irq_domain_is_hierarchy(domain)) {
 		virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, fwspec);
 		if (virq <= 0)
 			return 0;
-- 
2.1.4
