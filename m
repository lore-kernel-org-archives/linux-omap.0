From: <grygorii.strashko@linaro.org>
Subject: [RFT OMAP1 PATCH 8/8] gpio: omap: get rid of GPIO_INDEX() macro
Date: Thu, 19 Mar 2015 19:25:44 +0200
Message-ID: <1426785944-17255-9-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:35237 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756567AbbCSR0G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 13:26:06 -0400
Received: by lbcgn8 with SMTP id gn8so57938026lbc.2
        for <linux-omap@vger.kernel.org>; Thu, 19 Mar 2015 10:26:05 -0700 (PDT)
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now OMAP GPIO driver prepared for GPIO_INDEX() macro removing.
Do It ;)

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 615e950..cd1d5bf 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -81,7 +81,6 @@ struct gpio_bank {
 	struct omap_gpio_reg_offs *regs;
 };
 
-#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_MOD_CTRL_BIT	BIT(0)
 
 #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
@@ -492,14 +491,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	if (!BANK_USED(bank))
 		pm_runtime_get_sync(bank->dev);
 
-#ifdef CONFIG_ARCH_OMAP1
-	if (d->irq > IH_MPUIO_BASE) {
-		unsigned gpio = 0;
-		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
-		offset = GPIO_INDEX(bank, gpio);
-	}
-#endif
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
-- 
1.9.1

