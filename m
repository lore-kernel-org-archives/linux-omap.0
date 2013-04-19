From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v2] gpio/omap: implement irq mask/disable with proper semantic.
Date: Fri, 19 Apr 2013 21:20:55 +0200
Message-ID: <1366399255-30245-1-git-send-email-andreas.fenkart@streamunlimited.com>
References: <5167DFC8.8060202@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:62882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab3DSTVI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Apr 2013 15:21:08 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0LxrcA-1UYixh1L2i-015GZ1 for
 <linux-omap@vger.kernel.org>; Fri, 19 Apr 2013 21:21:05 +0200
In-Reply-To: <5167DFC8.8060202@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

When a gpio interrupt is masked, the gpio event will still be latched in
the interrupt status register so when you unmask it later you may get an
interrupt straight away. However, if the interrupt is disabled then gpio
events occurring will not be latched/stored.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..9ab7ba5 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -780,7 +780,7 @@ static void gpio_mask_irq(struct irq_data *d)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_irqenable(bank, gpio, 0);
-	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	/* latching new IRQ, but don't signal */
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -789,24 +789,48 @@ static void gpio_unmask_irq(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 	unsigned int gpio = irq_to_gpio(bank, d->irq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
-	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	if (trigger)
-		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
-	/* For level-triggered GPIOs, the clearing must be done after
-	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & irq_mask) {
-		_set_gpio_irqenable(bank, gpio, 0);
+	/* For level-triggered GPIOs, clear the IRQ. If the HW
+	 * still needs service, IRQ will be latched again */
+	if (bank->level_mask & irq_mask)
 		_clear_gpio_irqstatus(bank, gpio);
-	}
 
 	_set_gpio_irqenable(bank, gpio, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void gpio_disable_irq(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	/* stop latching new IRQ */
+	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	_set_gpio_irqenable(bank, gpio, 0);
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
+static void gpio_enable_irq(struct irq_data *d)
+{
+	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
+	unsigned int gpio = irq_to_gpio(bank, d->irq);
+	unsigned int irq_mask = GPIO_BIT(bank, gpio);
+	u32 trigger = irqd_get_trigger_type(d);
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	if (trigger)
+		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
+	_clear_gpio_irqstatus(bank, gpio);
+	_set_gpio_irqenable(bank, gpio, 1);
+	spin_unlock_irqrestore(&bank->lock, flags);
+}
+
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_shutdown	= gpio_irq_shutdown,
@@ -815,6 +839,9 @@ static struct irq_chip gpio_irq_chip = {
 	.irq_unmask	= gpio_unmask_irq,
 	.irq_set_type	= gpio_irq_type,
 	.irq_set_wake	= gpio_wake_enable,
+	.irq_disable    = gpio_disable_irq,
+	.irq_enable     = gpio_enable_irq,
+
 };
 
 /*---------------------------------------------------------------------*/
-- 
1.7.10.4

