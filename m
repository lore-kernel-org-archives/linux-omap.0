From: <grygorii.strashko@linaro.org>
Subject: [RFT OMAP1 PATCH 7/8] gpio: omap: get rid of omap_irq_to_gpio()
Date: Thu, 19 Mar 2015 19:25:43 +0200
Message-ID: <1426785944-17255-8-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35218 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757407AbbCSR0F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 13:26:05 -0400
Received: by lbcgn8 with SMTP id gn8so57937592lbc.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 10:26:03 -0700 (PDT)
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now OMAP GPIO driver prepared for omap_irq_to_gpio() removing.
Do it ;)

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index dd7934a..615e950 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -89,11 +89,6 @@ struct gpio_bank {
 
 static void omap_gpio_unmask_irq(struct irq_data *d);
 
-static int omap_irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
-{
-	return bank->chip.base + gpio_irq;
-}
-
 static inline struct gpio_bank *omap_irq_data_get_bank(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
@@ -490,22 +485,21 @@ static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned gpio = 0;
 	int retval;
 	unsigned long flags;
-	unsigned offset;
+	unsigned offset = d->hwirq;
 
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
 #ifdef CONFIG_ARCH_OMAP1
-	if (d->irq > IH_MPUIO_BASE)
+	if (d->irq > IH_MPUIO_BASE) {
+		unsigned gpio = 0;
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
+		offset = GPIO_INDEX(bank, gpio);
+	}
 #endif
 
-	if (!gpio)
-		gpio = omap_irq_to_gpio(bank, d->hwirq);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -514,7 +508,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	omap_gpio_init_irq(bank, offset);
 	if (!omap_gpio_is_input(bank, offset)) {
-- 
1.9.1

