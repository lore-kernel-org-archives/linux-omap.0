From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 3/7] gpio: omap: rework omap_x_irq_shutdown to touch only irqs specific registers
Date: Fri, 22 May 2015 17:35:50 +0300
Message-ID: <1432305354-5968-4-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36269 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486AbbEVOgI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:36:08 -0400
Received: by lbbqq2 with SMTP id qq2so14263969lbb.3
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2015 07:36:07 -0700 (PDT)
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

The GPIO Chip and GPIO IRQ Chip functionality are essentially orthogonal,
so GPIO IRQ Chip implementation shouldn't touch GPIO specific
registers and vise versa.

Hence, rework omap_gpio_irq_shutdown and try to touch only irqs specific
registers:
- don't configure GPIO as input (it, actually, should be already configured
  as input).
- don't clear debounce configuration if GPIO is still used as GPIO.
  We need to take in to account here commit c9c55d921115
  ("gpio/omap: fix off-mode bug: clear debounce settings on free/reset").

Also remove omap_reset_gpio() function as it is not used any more.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f6cc638..d933b99 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -646,15 +646,6 @@ static int omap_set_gpio_wakeup(struct gpio_bank *bank, unsigned offset,
 	return 0;
 }
 
-static void omap_reset_gpio(struct gpio_bank *bank, unsigned offset)
-{
-	omap_set_gpio_direction(bank, offset, 1);
-	omap_set_gpio_irqenable(bank, offset, 0);
-	omap_clear_gpio_irqstatus(bank, offset);
-	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-	omap_clear_gpio_debounce(bank, offset);
-}
-
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
 static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
@@ -821,8 +812,12 @@ static void omap_gpio_irq_shutdown(struct irq_data *d)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->irq_usage &= ~(BIT(offset));
+	omap_set_gpio_irqenable(bank, offset, 0);
+	omap_clear_gpio_irqstatus(bank, offset);
+	omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+	if (!LINE_USED(bank->mod_usage, offset))
+		omap_clear_gpio_debounce(bank, offset);
 	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
-- 
1.9.1

