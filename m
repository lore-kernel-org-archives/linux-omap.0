From: <grygorii.strashko@linaro.org>
Subject: [PATCH v2 8/8] gpio: omap: get rid of GPIO_INDEX() macro
Date: Mon, 23 Mar 2015 14:18:30 +0200
Message-ID: <1427113110-20813-9-git-send-email-grygorii.strashko@linaro.org>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now OMAP GPIO driver prepared for GPIO_INDEX() macro removing.
Do It ;)

Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
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
