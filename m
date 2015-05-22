From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 6/7] gpio: omap: clean up omap_gpio_irq_type
Date: Fri, 22 May 2015 17:35:53 +0300
Message-ID: <1432305354-5968-7-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35567 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757257AbbEVOgO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:36:14 -0400
Received: by lbbuc2 with SMTP id uc2so14320532lbb.2
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2015 07:36:12 -0700 (PDT)
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

The omap_gpio_irq_type() can do only configuration of GPIO IRQ
triggering type, because now OMAP GPIO driver has implemented
.irq_startup()/.irq_shutdown() which are responsible for
GPIO bank enabling and pin direction configuration.

Hence, remove redundant code and omap_gpio_init_irq() which is
not used any more.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1c226f1..f02b3fa 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -472,15 +472,6 @@ static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
 	return readl_relaxed(reg) & BIT(offset);
 }
 
-static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
-{
-	if (!LINE_USED(bank->mod_usage, offset)) {
-		omap_enable_gpio_module(bank, offset);
-		omap_set_gpio_direction(bank, offset, 1);
-	}
-	bank->irq_usage |= BIT(offset);
-}
-
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -502,12 +493,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	if (retval)
 		goto error;
-	omap_gpio_init_irq(bank, offset);
-	if (!omap_gpio_is_input(bank, offset)) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		retval = -EINVAL;
-		goto error;
-	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
-- 
1.9.1

