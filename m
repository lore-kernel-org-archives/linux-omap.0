From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH] gpio: omap: fix debounce time calculation
Date: Thu, 12 Nov 2015 11:50:40 -0600
Message-ID: <1447350640-20347-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-omap@vger.kernel.org

According to TRM, debounce is measured in periods of
the functional clock of the GPIO IP. This means that
we should divide by the rate of functional clock.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/gpio/gpio-omap.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 56d2d026e62e..2b29fd195521 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -217,15 +217,29 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 	u32			val;
 	u32			l;
 	bool			enable = !!debounce;
+	unsigned long		flags;
 
 	if (!bank->dbck_flag)
 		return;
 
 	if (enable) {
-		debounce = DIV_ROUND_UP(debounce, 31) - 1;
+		struct clk	*clk;
+		unsigned long	rate;
+
+		clk = clk_get(bank->dev, "fck");
+		if (IS_ERR(clk)) {
+			dev_err(bank->dev, "can't get clock\n");
+			return;
+		}
+
+		rate = clk_get_rate(clk);
+		clk_put(clk);
+
+		debounce = DIV_ROUND_UP(debounce, rate);
 		debounce &= OMAP4_GPIO_DEBOUNCINGTIME_MASK;
 	}
 
+	raw_spin_lock_irqsave(&bank->lock, flags);
 	l = BIT(offset);
 
 	clk_enable(bank->dbck);
@@ -256,6 +270,7 @@ static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 		bank->context.debounce = debounce;
 		bank->context.debounce_en = val;
 	}
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 /**
@@ -1002,14 +1017,9 @@ static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
 			      unsigned debounce)
 {
-	struct gpio_bank *bank;
-	unsigned long flags;
-
-	bank = container_of(chip, struct gpio_bank, chip);
+	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 
-	raw_spin_lock_irqsave(&bank->lock, flags);
 	omap2_set_gpio_debounce(bank, offset, debounce);
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
-- 
2.6.2

