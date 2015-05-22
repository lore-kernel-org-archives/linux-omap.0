From: Grygorii Strashko <grygorii.strashko@linaro.org>
Subject: [RFC/RFT PATCH 4/7] gpio: omap: rework omap_gpio_request to touch only gpio specific registers
Date: Fri, 22 May 2015 17:35:51 +0300
Message-ID: <1432305354-5968-5-git-send-email-grygorii.strashko@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:32826 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757252AbbEVOgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 10:36:10 -0400
Received: by lbbzk7 with SMTP id zk7so14373753lbb.0
        for <linux-omap@vger.kernel.org>; Fri, 22 May 2015 07:36:08 -0700 (PDT)
In-Reply-To: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, tony@atomide.com
Cc: Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

The GPIO Chip and GPIO IRQ Chip functionality are essentially orthogonal,
so GPIO Chip implementation shouldn't touch GPIO IRQ specific registers
and vise versa.

Hence, rework omap_gpio_request:
- don't reset GPIO IRQ triggering type to IRQ_TYPE_NONE, because
  GPIO irqchip should be responsible for that;
- call directly omap_enable_gpio_module as all needed checks are already
  present inside it.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d933b99..2fbd569 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -668,14 +668,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 		pm_runtime_get_sync(bank->dev);
 
 	spin_lock_irqsave(&bank->lock, flags);
-	/* Set trigger to none. You need to enable the desired trigger with
-	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
-	 * not already been requested.
-	 */
-	if (!LINE_USED(bank->irq_usage, offset)) {
-		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-		omap_enable_gpio_module(bank, offset);
-	}
+	omap_enable_gpio_module(bank, offset);
 	bank->mod_usage |= BIT(offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
-- 
1.9.1

