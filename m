From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT
Date: Fri, 28 Jun 2013 17:27:02 +0200
Message-ID: <1372433223-9053-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40768 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab3F1P1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jun 2013 11:27:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Grant Likely <grant.likely@linaro.org>, jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tony Lindgren <tony@atomide.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, aaro.koskinen@iki.fi, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

When a GPIO is defined as an interrupt line using Device
Tree, a call to irq_create_of_mapping() is made that calls
irq_create_mapping(). So, is not necessary to do the mapping
for all OMAP GPIO lines and explicitly call irq_create_mapping()
on the driver probe() when booting with Device Tree.

Add a custom IRQ domain .map function handler that will be
called by irq_create_mapping() to map the GPIO lines used as IRQ.
This also allows to execute needed setup code such as configuring
a GPIO as input and enabling the GPIO bank.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Tested-by: Enric Balletbo i Serra <eballetbo@gmail.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---

Changes since v3:
  - Use bank->chip.of_node instead of_have_populated_dt() to check
    DT or legacy boot as suggested by Jean-Christophe PLAGNIOL-VILLARD

Changes since v2:
  - Unconditionally do the IRQ setup in the .map() function and
    only call irq_create_mapping() in the gpio chip init to avoid
    code duplication as suggested by Grant Likely.

Changes since v1:
  - Split the addition of the .map function handler and the
    automatic gpio request in two different patches.
  - Add GPIO IRQ setup logic to the irq domain mapping function.
  - Only call irq_create_mapping for every GPIO on legacy boot.
  - Only setup a GPIO IRQ on the .map function for DeviceTree boot.

 drivers/gpio/gpio-omap.c |   54 ++++++++++++++++++++++++++++++++++------------
 1 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4a43036..e260590 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1068,24 +1068,50 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 
 	gpiochip_add(&bank->chip);
 
-	for (j = 0; j < bank->width; j++) {
-		int irq = irq_create_mapping(bank->domain, j);
-		irq_set_lockdep_class(irq, &gpio_lock_class);
-		irq_set_chip_data(irq, bank);
-		if (bank->is_mpuio) {
-			omap_mpuio_alloc_gc(bank, irq, bank->width);
-		} else {
-			irq_set_chip_and_handler(irq, &gpio_irq_chip,
-						 handle_simple_irq);
-			set_irq_flags(irq, IRQF_VALID);
-		}
-	}
+	/*
+	 * REVISIT these explicit calls to irq_create_mapping()
+	 * to do the GPIO to IRQ domain mapping for each GPIO in
+	 * the bank can be removed once all OMAP platforms have
+	 * been migrated to Device Tree boot only.
+	 * Since in DT boot irq_create_mapping() is called from
+	 * irq_create_of_mapping() only for the GPIO lines that
+	 * are used as interrupts.
+	 */
+	if (!bank->chip.of_node)
+		for (j = 0; j < bank->width; j++)
+			irq_create_mapping(bank->domain, j);
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
 	irq_set_handler_data(bank->irq, bank);
 }
 
 static const struct of_device_id omap_gpio_match[];
 
+static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
+			     irq_hw_number_t hwirq)
+{
+	struct gpio_bank *bank = d->host_data;
+
+	if (!bank)
+		return -EINVAL;
+
+	irq_set_lockdep_class(virq, &gpio_lock_class);
+	irq_set_chip_data(virq, bank);
+	if (bank->is_mpuio) {
+		omap_mpuio_alloc_gc(bank, virq, bank->width);
+	} else {
+		irq_set_chip_and_handler(virq, &gpio_irq_chip,
+					 handle_simple_irq);
+		set_irq_flags(virq, IRQF_VALID);
+	}
+
+	return 0;
+}
+
+static struct irq_domain_ops omap_gpio_irq_ops = {
+	.xlate  = irq_domain_xlate_onetwocell,
+	.map    = omap_gpio_irq_map,
+};
+
 static int omap_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1151,10 +1177,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	bank->domain = irq_domain_add_legacy(node, bank->width, irq_base,
-					     0, &irq_domain_simple_ops, NULL);
+					     0, &omap_gpio_irq_ops, bank);
 #else
 	bank->domain = irq_domain_add_linear(node, bank->width,
-					     &irq_domain_simple_ops, NULL);
+					     &omap_gpio_irq_ops, bank);
 #endif
 	if (!bank->domain) {
 		dev_err(dev, "Couldn't register an IRQ domain\n");
-- 
1.7.7.6

