From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH V2 04/14] irqdomain: Fix handling of type settings for existing mappings
Date: Wed, 20 Apr 2016 12:03:47 +0100
Message-ID: <1461150237-15580-5-git-send-email-jonathanh@nvidia.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1461150237-15580-1-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
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

Signed-off-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 kernel/irq/irqdomain.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 245a485ffb61..88e9328b7aab 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -592,15 +592,43 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
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
+		 * interrupt number. Otherwise, if the trigger type does
+		 * not match return 0.
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
