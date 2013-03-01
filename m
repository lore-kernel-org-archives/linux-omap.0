From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 1/2] gpio/omap: convert gpio irq domain to linear mapping
Date: Fri, 1 Mar 2013 11:22:47 -0600
Message-ID: <1362158568-1624-2-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51637 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab3CARYP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 12:24:15 -0500
In-Reply-To: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently the OMAP GPIO driver uses a legacy mapping for the GPIO IRQ
domain. This is not necessary because we do not need to assign a
specific interrupt number to the GPIO IRQ domain. Therefore, convert
the OMAP GPIO driver to use a linear mapping instead.

Please note that this also allows to simplify the logic in the OMAP
gpio_irq_handler() routine, by using irq_find_mapping() to obtain the
virtual irq number from the GPIO bank and bank index.

Reported-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 drivers/gpio/gpio-omap.c |   72 ++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 41 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..c3598d1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -53,7 +53,6 @@ struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
 	u16 irq;
-	int irq_base;
 	struct irq_domain *domain;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -89,7 +88,14 @@ struct gpio_bank {
 
 static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
-	return gpio_irq - bank->irq_base + bank->chip.base;
+	return bank->chip.base + gpio_irq;
+}
+
+static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
+
+	return irq_find_mapping(bank->domain, offset);
 }
 
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
@@ -427,7 +433,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 #endif
 
 	if (!gpio)
-		gpio = irq_to_gpio(bank, d->irq);
+		gpio = irq_to_gpio(bank, d->hwirq);
 
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
@@ -580,7 +586,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 
 	return _set_gpio_wakeup(bank, gpio, enable);
 }
@@ -680,7 +686,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
-	unsigned int gpio_irq, gpio_index;
+	unsigned int i;
 	struct gpio_bank *bank;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -721,15 +727,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (!isr)
 			break;
 
-		gpio_irq = bank->irq_base;
-		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			int gpio = irq_to_gpio(bank, gpio_irq);
-
+		for (i = 0; isr != 0; isr >>= 1, i++) {
 			if (!(isr & 1))
 				continue;
 
-			gpio_index = GPIO_INDEX(bank, gpio);
-
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -737,10 +738,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * to respond to the IRQ for the opposite direction.
 			 * This will be indicated in the bank toggle_mask.
 			 */
-			if (bank->toggle_mask & (1 << gpio_index))
-				_toggle_gpio_edge_triggering(bank, gpio_index);
+			if (bank->toggle_mask & (1 << i))
+				_toggle_gpio_edge_triggering(bank, i);
 
-			generic_handle_irq(gpio_irq);
+			generic_handle_irq(irq_find_mapping(bank->domain, i));
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
@@ -756,7 +757,7 @@ exit:
 static void gpio_irq_shutdown(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -767,7 +768,7 @@ static void gpio_irq_shutdown(struct irq_data *d)
 static void gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 
 	_clear_gpio_irqstatus(bank, gpio);
 }
@@ -775,7 +776,7 @@ static void gpio_ack_irq(struct irq_data *d)
 static void gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -787,7 +788,7 @@ static void gpio_mask_irq(struct irq_data *d)
 static void gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
@@ -953,14 +954,6 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct gpio_bank *bank;
-
-	bank = container_of(chip, struct gpio_bank, chip);
-	return bank->irq_base + offset;
-}
-
 /*---------------------------------------------------------------------*/
 
 static void __init omap_gpio_show_rev(struct gpio_bank *bank)
@@ -1057,7 +1050,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.direction_output = gpio_output;
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
-	bank->chip.to_irq = gpio_2irq;
+	bank->chip.to_irq = omap_gpio_to_irq;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1072,15 +1065,16 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 
 	gpiochip_add(&bank->chip);
 
-	for (j = bank->irq_base; j < bank->irq_base + bank->width; j++) {
-		irq_set_lockdep_class(j, &gpio_lock_class);
-		irq_set_chip_data(j, bank);
+	for (j = 0; j < bank->width; j++) {
+		int irq = irq_create_mapping(bank->domain, j);
+		irq_set_lockdep_class(irq, &gpio_lock_class);
+		irq_set_chip_data(irq, bank);
 		if (bank->is_mpuio) {
-			omap_mpuio_alloc_gc(bank, j, bank->width);
+			omap_mpuio_alloc_gc(bank, irq, bank->width);
 		} else {
-			irq_set_chip(j, &gpio_irq_chip);
-			irq_set_handler(j, handle_simple_irq);
-			set_irq_flags(j, IRQF_VALID);
+			irq_set_chip_and_handler(irq, &gpio_irq_chip,
+						 handle_simple_irq);
+			set_irq_flags(irq, IRQF_VALID);
 		}
 	}
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
@@ -1130,14 +1124,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	bank->chip.of_node = of_node_get(node);
 #endif
 
-	bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
-	if (bank->irq_base < 0) {
-		dev_err(dev, "Couldn't allocate IRQ numbers\n");
+	bank->domain = irq_domain_add_linear(node, bank->width,
+					     &irq_domain_simple_ops, NULL);
+	if (!bank->domain)
 		return -ENODEV;
-	}
-
-	bank->domain = irq_domain_add_legacy(node, bank->width, bank->irq_base,
-					     0, &irq_domain_simple_ops, NULL);
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
-- 
1.7.10.4

