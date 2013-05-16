From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Fri, 17 May 2013 00:00:06 +0300
Message-ID: <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:41796 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967Ab3EPVAP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 May 2013 17:00:15 -0400
Content-Disposition: inline
In-Reply-To: <20130516180933.GG5600@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, Grant Likely <grant.likely@secretlab.ca>

On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
> * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
> > I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
> > 
> > [    2.264221] retu-mfd 2-0001: Retu v3.2 found
> > [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
> > [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
> > 
> > The error is coming from regmap code. According to git bisect, it is
> > caused by:
> > 
> > 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
> > 	Author: Jon Hunter <jon-hunter@ti.com>
> > 	Date:   Fri Mar 1 11:22:47 2013 -0600
> > 
> > 	    gpio/omap: convert gpio irq domain to linear mapping
> > 
> > The commit does not anymore revert cleanly, and I haven't yet tried
> > crafting a manual revert, so any fix proposals/ideas are welcome...
> 
> Hmm this might be a bit trickier to fix. Obviously the real solution
> is to convert omap1 to SPARSE_IRQ like we did for omap2+.
> 
> For the -rc cycle, it might be possible to fix this by adding a
> different irq_to_gpio() and gpio_to_irq() functions for omap1.

The commit reverts cleanly if we also revert
3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
service routine), which seems to be just some minor optimization. The
result is below, and with it 770 works again.

A.

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2050891..a9b5813 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -52,6 +52,7 @@ struct gpio_bank {
 	struct list_head node;
 	void __iomem *base;
 	u16 irq;
+	int irq_base;
 	struct irq_domain *domain;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -87,14 +88,7 @@ struct gpio_bank {
 
 static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
-	return bank->chip.base + gpio_irq;
-}
-
-static int omap_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
-{
-	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-
-	return irq_find_mapping(bank->domain, offset);
+	return gpio_irq - bank->irq_base + bank->chip.base;
 }
 
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
@@ -435,7 +429,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 #endif
 
 	if (!gpio)
-		gpio = irq_to_gpio(bank, d->hwirq);
+		gpio = irq_to_gpio(bank, d->irq);
 
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
@@ -588,7 +582,7 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 
 	return _set_gpio_wakeup(bank, gpio, enable);
 }
@@ -688,7 +682,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
-	unsigned int bit;
+	unsigned int gpio_irq, gpio_index;
 	struct gpio_bank *bank;
 	int unmasked = 0;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -729,9 +723,14 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		if (!isr)
 			break;
 
-		while (isr) {
-			bit = __ffs(isr);
-			isr &= ~(1 << bit);
+		gpio_irq = bank->irq_base;
+		for (; isr != 0; isr >>= 1, gpio_irq++) {
+			int gpio = irq_to_gpio(bank, gpio_irq);
+
+			if (!(isr & 1))
+				continue;
+
+			gpio_index = GPIO_INDEX(bank, gpio);
 
 			/*
 			 * Some chips can't respond to both rising and falling
@@ -740,10 +739,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * to respond to the IRQ for the opposite direction.
 			 * This will be indicated in the bank toggle_mask.
 			 */
-			if (bank->toggle_mask & (1 << bit))
-				_toggle_gpio_edge_triggering(bank, bit);
+			if (bank->toggle_mask & (1 << gpio_index))
+				_toggle_gpio_edge_triggering(bank, gpio_index);
 
-			generic_handle_irq(irq_find_mapping(bank->domain, bit));
+			generic_handle_irq(gpio_irq);
 		}
 	}
 	/* if bank has any level sensitive GPIO pin interrupt
@@ -759,7 +758,7 @@ exit:
 static void gpio_irq_shutdown(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -770,7 +769,7 @@ static void gpio_irq_shutdown(struct irq_data *d)
 static void gpio_ack_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 
 	_clear_gpio_irqstatus(bank, gpio);
 }
@@ -778,7 +777,7 @@ static void gpio_ack_irq(struct irq_data *d)
 static void gpio_mask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
@@ -790,7 +789,7 @@ static void gpio_mask_irq(struct irq_data *d)
 static void gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
@@ -956,6 +955,14 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
+{
+	struct gpio_bank *bank;
+
+	bank = container_of(chip, struct gpio_bank, chip);
+	return bank->irq_base + offset;
+}
+
 /*---------------------------------------------------------------------*/
 
 static void __init omap_gpio_show_rev(struct gpio_bank *bank)
@@ -1052,7 +1059,7 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.direction_output = gpio_output;
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
-	bank->chip.to_irq = omap_gpio_to_irq;
+	bank->chip.to_irq = gpio_2irq;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1067,16 +1074,15 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
 
 	gpiochip_add(&bank->chip);
 
-	for (j = 0; j < bank->width; j++) {
-		int irq = irq_create_mapping(bank->domain, j);
-		irq_set_lockdep_class(irq, &gpio_lock_class);
-		irq_set_chip_data(irq, bank);
+	for (j = bank->irq_base; j < bank->irq_base + bank->width; j++) {
+		irq_set_lockdep_class(j, &gpio_lock_class);
+		irq_set_chip_data(j, bank);
 		if (bank->is_mpuio) {
-			omap_mpuio_alloc_gc(bank, irq, bank->width);
+			omap_mpuio_alloc_gc(bank, j, bank->width);
 		} else {
-			irq_set_chip_and_handler(irq, &gpio_irq_chip,
-						 handle_simple_irq);
-			set_irq_flags(irq, IRQF_VALID);
+			irq_set_chip(j, &gpio_irq_chip);
+			irq_set_handler(j, handle_simple_irq);
+			set_irq_flags(j, IRQF_VALID);
 		}
 	}
 	irq_set_chained_handler(bank->irq, gpio_irq_handler);
@@ -1131,10 +1137,14 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 
-	bank->domain = irq_domain_add_linear(node, bank->width,
-					     &irq_domain_simple_ops, NULL);
-	if (!bank->domain)
+	bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
+	if (bank->irq_base < 0) {
+		dev_err(dev, "Couldn't allocate IRQ numbers\n");
 		return -ENODEV;
+	}
+
+	bank->domain = irq_domain_add_legacy(node, bank->width, bank->irq_base,
+					     0, &irq_domain_simple_ops, NULL);
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = _set_gpio_dataout_reg;
