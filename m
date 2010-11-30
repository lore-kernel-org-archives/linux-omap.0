From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: [PATCH 51/54] ARM: plat-omap: irq_data conversion.
Date: Tue, 30 Nov 2010 14:41:23 +0100
Message-ID: <20101130134123.GZ15575@mail.wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fw.wantstofly.org ([80.101.37.227]:33893 "EHLO
	mail.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab0K3OJd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 09:09:33 -0500
Content-Disposition: inline
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/plat-omap/gpio.c |   93 ++++++++++++++++++++++-----------------------
 1 files changed, 46 insertions(+), 47 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c05c653..1e83b6b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -878,17 +878,17 @@ bad:
 	return -EINVAL;
 }
 
-static int gpio_irq_type(unsigned irq, unsigned type)
+static int gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank;
 	unsigned gpio;
 	int retval;
 	unsigned long flags;
 
-	if (!cpu_class_is_omap2() && irq > IH_MPUIO_BASE)
-		gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
+	if (!cpu_class_is_omap2() && d->irq > IH_MPUIO_BASE)
+		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
 	else
-		gpio = irq - IH_GPIO_BASE;
+		gpio = d->irq - IH_GPIO_BASE;
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
@@ -901,19 +901,19 @@ static int gpio_irq_type(unsigned irq, unsigned type)
 			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
-	bank = get_irq_chip_data(irq);
+	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
 	if (retval == 0) {
-		irq_desc[irq].status &= ~IRQ_TYPE_SENSE_MASK;
-		irq_desc[irq].status |= type;
+		irq_desc[d->irq].status &= ~IRQ_TYPE_SENSE_MASK;
+		irq_desc[d->irq].status |= type;
 	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-		__set_irq_handler_unlocked(irq, handle_level_irq);
+		__set_irq_handler_unlocked(d->irq, handle_level_irq);
 	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
-		__set_irq_handler_unlocked(irq, handle_edge_irq);
+		__set_irq_handler_unlocked(d->irq, handle_edge_irq);
 
 	return retval;
 }
@@ -1170,15 +1170,15 @@ static void _reset_gpio(struct gpio_bank *bank, int gpio)
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-static int gpio_wake_enable(unsigned int irq, unsigned int enable)
+static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
-	unsigned int gpio = irq - IH_GPIO_BASE;
+	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank;
 	int retval;
 
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
-	bank = get_irq_chip_data(irq);
+	bank = irq_data_get_irq_chip_data(d);
 	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
 
 	return retval;
@@ -1291,7 +1291,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	u32 retrigger = 0;
 	int unmasked = 0;
 
-	desc->chip->ack(irq);
+	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = get_irq_data(irq);
 #ifdef CONFIG_ARCH_OMAP1
@@ -1343,7 +1343,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		configured, we could unmask GPIO bank interrupt immediately */
 		if (!level_mask && !unmasked) {
 			unmasked = 1;
-			desc->chip->unmask(irq);
+			desc->irq_data.chip->irq_unmask(&desc->irq_data);
 		}
 
 		isr |= retrigger;
@@ -1378,41 +1378,40 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	handler(s) are executed in order to avoid spurious bank
 	interrupt */
 	if (!unmasked)
-		desc->chip->unmask(irq);
-
+		desc->irq_data.chip->irq_unmask(&desc->irq_data);
 }
 
-static void gpio_irq_shutdown(unsigned int irq)
+static void gpio_irq_shutdown(struct irq_data *d)
 {
-	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = d->irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_reset_gpio(bank, gpio);
 }
 
-static void gpio_ack_irq(unsigned int irq)
+static void gpio_ack_irq(struct irq_data *d)
 {
-	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = d->irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_clear_gpio_irqstatus(bank, gpio);
 }
 
-static void gpio_mask_irq(unsigned int irq)
+static void gpio_mask_irq(struct irq_data *d)
 {
-	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = d->irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_set_gpio_irqenable(bank, gpio, 0);
 	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
 }
 
-static void gpio_unmask_irq(unsigned int irq)
+static void gpio_unmask_irq(struct irq_data *d)
 {
-	unsigned int gpio = irq - IH_GPIO_BASE;
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = d->irq - IH_GPIO_BASE;
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned int irq_mask = 1 << get_gpio_index(gpio);
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc = irq_to_desc(d->irq);
 	u32 trigger = desc->status & IRQ_TYPE_SENSE_MASK;
 
 	if (trigger)
@@ -1430,12 +1429,12 @@ static void gpio_unmask_irq(unsigned int irq)
 
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
-	.shutdown	= gpio_irq_shutdown,
-	.ack		= gpio_ack_irq,
-	.mask		= gpio_mask_irq,
-	.unmask		= gpio_unmask_irq,
-	.set_type	= gpio_irq_type,
-	.set_wake	= gpio_wake_enable,
+	.irq_shutdown	= gpio_irq_shutdown,
+	.irq_ack	= gpio_ack_irq,
+	.irq_mask	= gpio_mask_irq,
+	.irq_unmask	= gpio_unmask_irq,
+	.irq_set_type	= gpio_irq_type,
+	.irq_set_wake	= gpio_wake_enable,
 };
 
 /*---------------------------------------------------------------------*/
@@ -1444,36 +1443,36 @@ static struct irq_chip gpio_irq_chip = {
 
 /* MPUIO uses the always-on 32k clock */
 
-static void mpuio_ack_irq(unsigned int irq)
+static void mpuio_ack_irq(struct irq_data *d)
 {
 	/* The ISR is reset automatically, so do nothing here. */
 }
 
-static void mpuio_mask_irq(unsigned int irq)
+static void mpuio_mask_irq(struct irq_data *d)
 {
-	unsigned int gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_set_gpio_irqenable(bank, gpio, 0);
 }
 
-static void mpuio_unmask_irq(unsigned int irq)
+static void mpuio_unmask_irq(struct irq_data *d)
 {
-	unsigned int gpio = OMAP_MPUIO(irq - IH_MPUIO_BASE);
-	struct gpio_bank *bank = get_irq_chip_data(irq);
+	unsigned int gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_set_gpio_irqenable(bank, gpio, 1);
 }
 
 static struct irq_chip mpuio_irq_chip = {
 	.name		= "MPUIO",
-	.ack		= mpuio_ack_irq,
-	.mask		= mpuio_mask_irq,
-	.unmask		= mpuio_unmask_irq,
-	.set_type	= gpio_irq_type,
+	.irq_ack	= mpuio_ack_irq,
+	.irq_mask	= mpuio_mask_irq,
+	.irq_unmask	= mpuio_unmask_irq,
+	.irq_set_type	= gpio_irq_type,
 #ifdef CONFIG_ARCH_OMAP16XX
 	/* REVISIT: assuming only 16xx supports MPUIO wake events */
-	.set_wake	= gpio_wake_enable,
+	.irq_set_wake	= gpio_wake_enable,
 #endif
 };
 
-- 
1.7.1

