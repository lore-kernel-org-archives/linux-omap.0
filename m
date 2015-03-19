From: <grygorii.strashko@linaro.org>
Subject: [PATCH 6/8] gpio: omap: get rid of GPIO_BIT() macro
Date: Thu, 19 Mar 2015 19:25:42 +0200
Message-ID: <1426785944-17255-7-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Now OMAP GPIO driver prepared for GPIO_BIT() macro removing.
Do it ;)

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index b39faa8..dd7934a 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -82,7 +82,6 @@ struct gpio_bank {
 };
 
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
-#define GPIO_BIT(bank, gpio) (BIT(GPIO_INDEX(bank, gpio)))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
 
 #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
@@ -863,7 +862,6 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
 	unsigned offset = d->hwirq;
-	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
@@ -873,7 +871,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
-	if (bank->level_mask & irq_mask) {
+	if (bank->level_mask & BIT(offset)) {
 		omap_set_gpio_irqenable(bank, offset, 0);
 		omap_clear_gpio_irqstatus(bank, offset);
 	}
-- 
1.9.1
