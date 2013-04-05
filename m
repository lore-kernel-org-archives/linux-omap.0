From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 1/1] of/irq: store IRQ trigger/level in struct resource flags
Date: Fri,  5 Apr 2013 09:48:08 +0200
Message-ID: <1365148088-11175-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:54590 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932534Ab3DEHsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Apr 2013 03:48:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@nvidia.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

According to Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
the "#interrupt-cells" property of an "interrupt-controller" is used
to define the number of cells needed to specify a single interrupt.

A commonly used variant is two cell on which #interrupt-cells = <2>
and the first cell defines the index of the interrupt in the controller
and the second cell is used to specify any of the following flags:

    - bits[3:0] trigger type and level flags
        1 = low-to-high edge triggered
        2 = high-to-low edge triggered
        4 = active high level-sensitive
        8 = active low level-sensitive

An example of an interrupt controller which use the two cell format is
the OMAP GPIO controller that allows GPIO lines to be used as IRQ
(Documentation/devicetree/bindings/gpio/gpio-omap.txt)

But setting #interrupt-cells = <2> on the OMAP GPIO device node and
specifying the GPIO-IRQ type and level flags on the second cell does not
store this value on the populated IORESOURCE_IRQ struct resource.

This is because when using an IRQ from an interrupt controller and
setting both cells (e.g:)

	interrupt-parent = <&gpio6>;
	interrupts = <16 8>;

A call to of_irq_to_resource() is made and this function calls to
irq_of_parse_and_map_type() to get the virtual IRQ mapped to the real
index for this interrupt controller. This IRQ number is populated on
the struct resource:

int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
{
	int irq = irq_of_parse_and_map(dev, index);
	..
	r->start = r->end = irq;
}

irq_of_parse_and_map() calls to irq_create_of_mapping() which calls to
the correct xlate function handler according to "#interrupt-cells"
(irq_domain_xlate_onecell or irq_domain_xlate_twocell) and to
irq_set_irq_type() to set the IRQ type.

But the type is never returned so it can't be saved on the IRQ struct
resource flags member.

This means that drivers that need the IRQ type/level flags defined in
the DT won't be able to get it.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/of/irq.c       |   30 ++++++++++++++++++++++++------
 include/linux/of_irq.h |    4 ++++
 kernel/irq/irqdomain.c |   14 ++++++++++++--
 3 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a3c1c5a..6f6aa75 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -27,22 +27,39 @@
 #include <linux/slab.h>
 
 /**
- * irq_of_parse_and_map - Parse and map an interrupt into linux virq space
+ * irq_of_parse_and_map_type - Parse and map an interrupt into linux virq space
  * @device: Device node of the device whose interrupt is to be mapped
  * @index: Index of the interrupt to map
+ * @type: Interrupt trigger type and level flags filled by this function
  *
  * This function is a wrapper that chains of_irq_map_one() and
  * irq_create_of_mapping() to make things easier to callers
  */
-unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
+static unsigned int irq_of_parse_and_map_type(struct device_node *dev,
+					      int index, unsigned int *type)
 {
 	struct of_irq oirq;
+	unsigned int virq;
 
 	if (of_irq_map_one(dev, index, &oirq))
 		return 0;
 
-	return irq_create_of_mapping(oirq.controller, oirq.specifier,
-				     oirq.size);
+	virq = irq_create_of_mapping_type(oirq.controller, oirq.specifier,
+					  oirq.size, type);
+	return virq;
+}
+
+/**
+ * irq_of_parse_and_map - Parse and map an interrupt into linux virq space
+ * @device: Device node of the device whose interrupt is to be mapped
+ * @index: Index of the interrupt to map
+ *
+ * This function is a wrapper of irq_of_parse_and_map_type() when the IRQ
+ * type and level flags are not needed
+ */
+unsigned int irq_of_parse_and_map(struct device_node *dev, int index)
+{
+	return irq_of_parse_and_map_type(dev, index, NULL);
 }
 EXPORT_SYMBOL_GPL(irq_of_parse_and_map);
 
@@ -338,7 +355,8 @@ EXPORT_SYMBOL_GPL(of_irq_map_one);
  */
 int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 {
-	int irq = irq_of_parse_and_map(dev, index);
+	int type = IRQ_TYPE_NONE;
+	int irq = irq_of_parse_and_map_type(dev, index, &type);
 
 	/* Only dereference the resource if both the
 	 * resource and the irq are valid. */
@@ -353,7 +371,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 					      &name);
 
 		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ;
+		r->flags = (IORESOURCE_IRQ | type);
 		r->name = name ? name : dev->full_name;
 	}
 
diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
index 535cecf..98aec57 100644
--- a/include/linux/of_irq.h
+++ b/include/linux/of_irq.h
@@ -66,6 +66,10 @@ extern int of_irq_map_one(struct device_node *device, int index,
 extern unsigned int irq_create_of_mapping(struct device_node *controller,
 					  const u32 *intspec,
 					  unsigned int intsize);
+extern unsigned int irq_create_of_mapping_type(struct device_node *controller,
+					       const u32 *intspec,
+					       unsigned int intsize,
+					       unsigned int *otype);
 extern int of_irq_to_resource(struct device_node *dev, int index,
 			      struct resource *r);
 extern int of_irq_count(struct device_node *dev);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 96f3a1d..4a2f222 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -636,8 +636,9 @@ int irq_create_strict_mappings(struct irq_domain *domain, unsigned int irq_base,
 }
 EXPORT_SYMBOL_GPL(irq_create_strict_mappings);
 
-unsigned int irq_create_of_mapping(struct device_node *controller,
-				   const u32 *intspec, unsigned int intsize)
+unsigned int irq_create_of_mapping_type(struct device_node *controller,
+					const u32 *intspec, unsigned int intsize,
+					unsigned int *otype)
 {
 	struct irq_domain *domain;
 	irq_hw_number_t hwirq;
@@ -681,8 +682,17 @@ unsigned int irq_create_of_mapping(struct device_node *controller,
 	if (type != IRQ_TYPE_NONE &&
 	    type != (irqd_get_trigger_type(irq_get_irq_data(virq))))
 		irq_set_irq_type(virq, type);
+	if (otype)
+		*otype = type;
 	return virq;
 }
+EXPORT_SYMBOL_GPL(irq_create_of_mapping_type);
+
+unsigned int irq_create_of_mapping(struct device_node *controller,
+				   const u32 *intspec, unsigned int intsize)
+{
+	return irq_create_of_mapping_type(controller, intspec, intsize, NULL);
+}
 EXPORT_SYMBOL_GPL(irq_create_of_mapping);
 
 /**
-- 
1.7.7.6

