From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH 4/5] gpio: omap: convert driver to use gpiolib irqchip
Date: Sun,  6 Apr 2014 16:58:16 +0200
Message-ID: <1396796297-13002-5-git-send-email-javier.martinez@collabora.co.uk>
References: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40491 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753998AbaDFO67 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2014 10:58:59 -0400
In-Reply-To: <1396796297-13002-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Converts the GPIO OMAP driver to register its chained irq
handler and irqchip using the helpers in the gpiolib core.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/gpio/Kconfig     |   1 +
 drivers/gpio/gpio-omap.c | 107 ++++++++++++++++++++++-------------------------
 2 files changed, 52 insertions(+), 56 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index bfe5cf0..2092b1d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -247,6 +247,7 @@ config GPIO_OMAP
 	bool "TI OMAP GPIO support"
 	default y if ARCH_OMAP
 	depends on ARM && ARCH_OMAP
+	select GPIOLIB_IRQCHIP
 	help
 	  Say yes here to enable GPIO support for TI OMAP SoCs.
 
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index e717888..8cc9e91 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -24,7 +24,6 @@
 #include <linux/pm.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/irqdomain.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/gpio.h>
 #include <linux/platform_data/gpio-omap.h>
@@ -52,7 +51,6 @@ struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
 	u16 irq;
-	struct irq_domain *domain;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 	struct gpio_regs context;
@@ -95,11 +93,10 @@ static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 	return bank->chip.base + gpio_irq;
 }
 
-static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
+static inline struct gpio_bank *_irq_data_get_bank(struct irq_data *d)
 {
-	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-
-	return irq_find_mapping(bank->domain, offset);
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	return container_of(chip, struct gpio_bank, chip);
 }
 
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
@@ -479,7 +476,7 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 
 static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned gpio = 0;
 	int retval;
 	unsigned long flags;
@@ -514,14 +511,6 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 	}
 
-	retval = gpio_lock_as_irq(&bank->chip, offset);
-	if (retval) {
-		dev_err(bank->dev, "unable to lock offset %d for IRQ\n",
-			offset);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return retval;
-	}
-
 	bank->irq_usage |= 1 << GPIO_INDEX(bank, gpio);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
@@ -664,7 +653,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 
 	return _set_gpio_wakeup(bank, gpio, enable);
@@ -732,11 +721,12 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned int bit;
 	struct gpio_bank *bank;
 	int unmasked = 0;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_chip *irqchip = irq_desc_get_chip(desc);
+	struct gpio_chip *chip = irq_get_handler_data(irq);
 
-	chained_irq_enter(chip, desc);
+	chained_irq_enter(irqchip, desc);
 
-	bank = irq_get_handler_data(irq);
+	bank = container_of(chip, struct gpio_bank, chip);
 	isr_reg = bank->base + bank->regs->irqstatus;
 	pm_runtime_get_sync(bank->dev);
 
@@ -764,7 +754,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask && !unmasked) {
 			unmasked = 1;
-			chained_irq_exit(chip, desc);
+			chained_irq_exit(irqchip, desc);
 		}
 
 		if (!isr)
@@ -784,7 +774,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			if (bank->toggle_mask & (1 << bit))
 				_toggle_gpio_edge_triggering(bank, bit);
 
-			generic_handle_irq(irq_find_mapping(bank->domain, bit));
+			generic_handle_irq(irq_find_mapping(bank->chip.irqdomain,
+							    bit));
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
@@ -793,13 +784,13 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	interrupt */
 exit:
 	if (!unmasked)
-		chained_irq_exit(chip, desc);
+		chained_irq_exit(irqchip, desc);
 	pm_runtime_put(bank->dev);
 }
 
 static void gpio_irq_shutdown(struct irq_data *d)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
@@ -821,7 +812,7 @@ static void gpio_irq_shutdown(struct irq_data *d)
 
 static void gpio_ack_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 
 	_clear_gpio_irqstatus(bank, gpio);
@@ -829,7 +820,7 @@ static void gpio_ack_irq(struct irq_data *d)
 
 static void gpio_mask_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
@@ -841,7 +832,7 @@ static void gpio_mask_irq(struct irq_data *d)
 
 static void gpio_unmask_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	struct gpio_bank *bank = _irq_data_get_bank(d);
 	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
@@ -1085,6 +1076,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 {
 	int j;
 	static int gpio;
+	int irq_base = 0;
 	int ret;
 
 	/*
@@ -1098,7 +1090,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.direction_output = gpio_output;
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
-	bank->chip.to_irq = omap_gpio_to_irq;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1113,24 +1104,46 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 
 	ret = gpiochip_add(&bank->chip);
 	if (ret) {
-		dev_err(bank->dev, "Could not register gpio chip\n", ret);
+		dev_err(bank->dev, "Could not register gpio chip %d\n", ret);
 		return ret;
 	}
 
+#ifdef CONFIG_ARCH_OMAP1
+	/*
+	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
+	 * irq_alloc_descs() since a base IRQ offset will no longer be needed.
+	 */
+	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
+	if (irq_base < 0) {
+		dev_err(bank->dev, "Couldn't allocate IRQ numbers\n");
+		return -ENODEV;
+	}
+#endif
+
+	ret = gpiochip_irqchip_add(&bank->chip, &gpio_irq_chip,
+				   irq_base, gpio_irq_handler,
+				   IRQ_TYPE_NONE);
+
+	if (ret) {
+		dev_err(bank->dev, "Couldn't add irqchip to gpiochip %d\n", ret);
+		ret = gpiochip_remove(&bank->chip);
+		return -ENODEV;
+	}
+
+	gpiochip_set_chained_irqchip(&bank->chip, &gpio_irq_chip,
+				     bank->irq, gpio_irq_handler);
+
 	for (j = 0; j < bank->width; j++) {
-		int irq = irq_create_mapping(bank->domain, j);
+		int irq = irq_find_mapping(bank->chip.irqdomain, j);
 		irq_set_lockdep_class(irq, &gpio_lock_class);
-		irq_set_chip_data(irq, bank);
 		if (bank->is_mpuio) {
 			omap_mpuio_alloc_gc(bank, irq, bank->width);
-		} else {
-			irq_set_chip_and_handler(irq, &gpio_irq_chip,
-						 handle_simple_irq);
-			set_irq_flags(irq, IRQF_VALID);
+			irq_set_chip_and_handler(irq, NULL, NULL);
+			set_irq_flags(irq, 0);
 		}
 	}
-	irq_set_chained_handler(bank->irq, gpio_irq_handler);
-	irq_set_handler_data(bank->irq, bank);
+
+	return 0;
 }
 
 static const struct of_device_id omap_gpio_match[];
@@ -1143,7 +1156,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	const struct omap_gpio_platform_data *pdata;
 	struct resource *res;
 	struct gpio_bank *bank;
-	int irq_base = 0;
 	int ret;
 
 	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
@@ -1166,6 +1178,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 
 	bank->irq = res->start;
 	bank->dev = dev;
+	bank->chip.dev = dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
@@ -1186,24 +1199,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				pdata->get_context_loss_count;
 	}
 
-#ifdef CONFIG_ARCH_OMAP1
-	/*
-	 * REVISIT: Once we have OMAP1 supporting SPARSE_IRQ, we can drop
-	 * irq_alloc_descs() since a base IRQ offset will no longer be needed.
-	 */
-	irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
-	if (irq_base < 0) {
-		dev_err(dev, "Couldn't allocate IRQ numbers\n");
-		return -ENODEV;
-	}
-#endif
-	bank->domain = irq_domain_add_simple(node, bank->width, irq_base,
-					     &irq_domain_simple_ops, NULL);
-	if (!bank->domain) {
-		dev_err(dev, "Couldn't register an IRQ domain\n");
-		return -ENODEV;
-	}
-
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
 	else
@@ -1215,7 +1210,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	bank->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(bank->base)) {
-		irq_domain_remove(bank->domain);
+		irq_domain_remove(bank->chip.irqdomain);
 		return PTR_ERR(bank->base);
 	}
 
-- 
1.9.0

