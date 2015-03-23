From: <grygorii.strashko@linaro.org>
Subject: [PATCH v2 1/8] gpio: omap: convert omap_gpio_is_input() to use gpio offset
Date: Mon, 23 Mar 2015 14:18:23 +0200
Message-ID: <1427113110-20813-2-git-send-email-grygorii.strashko@linaro.org>
References: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427113110-20813-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Convert omap_gpio_is_input() to use GPIO offset instead of mask and,
in such way, make code simpler and remove few lines of code.

Tested-by: Tony Lindgren <tony@atomide.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 2b2fc4b..ce71239 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -472,11 +472,11 @@ static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 	}
 }
 
-static int omap_gpio_is_input(struct gpio_bank *bank, int mask)
+static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
 {
 	void __iomem *reg = bank->base + bank->regs->direction;
 
-	return readl_relaxed(reg) & mask;
+	return readl_relaxed(reg) & BIT(offset);
 }
 
 static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned gpio,
@@ -519,7 +519,7 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	offset = GPIO_INDEX(bank, gpio);
 	retval = omap_set_gpio_triggering(bank, offset, type);
 	omap_gpio_init_irq(bank, gpio, offset);
-	if (!omap_gpio_is_input(bank, BIT(offset))) {
+	if (!omap_gpio_is_input(bank, offset)) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
 	}
@@ -976,12 +976,10 @@ static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
 static int omap_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
-	u32 mask;
 
 	bank = container_of(chip, struct gpio_bank, chip);
-	mask = (BIT(offset));
 
-	if (omap_gpio_is_input(bank, mask))
+	if (omap_gpio_is_input(bank, offset))
 		return omap_get_gpio_datain(bank, offset);
 	else
 		return omap_get_gpio_dataout(bank, offset);
-- 
1.9.1
