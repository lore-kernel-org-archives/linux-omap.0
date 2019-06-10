From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 08/20] gpio: gpio-omap: simplify get() method
Date: Mon, 10 Jun 2019 20:10:51 +0300
Message-ID: <20190610171103.30903-9-grygorii.strashko@ti.com>
References: <20190610171103.30903-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190610171103.30903-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, Russell King <rmk+kernel@armlinux.org.uk>, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

omap_gpio_get() calls omap_get_gpio_datain() or omap_get_gpio_dataout()
to read the GPIO state. These two functions are only called from this
method, so they don't add much value.  Move their contents into
omap_gpio_get() method and simplify.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 44a4287cce9e..bf1e6f1d0de7 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -146,20 +146,6 @@ static void omap_set_gpio_dataout_mask(struct gpio_bank *bank, unsigned offset,
 	bank->context.dataout = l;
 }
 
-static int omap_get_gpio_datain(struct gpio_bank *bank, int offset)
-{
-	void __iomem *reg = bank->base + bank->regs->datain;
-
-	return (readl_relaxed(reg) & (BIT(offset))) != 0;
-}
-
-static int omap_get_gpio_dataout(struct gpio_bank *bank, int offset)
-{
-	void __iomem *reg = bank->base + bank->regs->dataout;
-
-	return (readl_relaxed(reg) & (BIT(offset))) != 0;
-}
-
 /* set multiple data out values using dedicate set/clear register */
 static void omap_set_gpio_dataout_reg_multiple(struct gpio_bank *bank,
 					       unsigned long *mask,
@@ -973,14 +959,15 @@ static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int omap_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_bank *bank;
-
-	bank = gpiochip_get_data(chip);
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	void __iomem *reg;
 
 	if (omap_gpio_is_input(bank, offset))
-		return omap_get_gpio_datain(bank, offset);
+		reg = bank->base + bank->regs->datain;
 	else
-		return omap_get_gpio_dataout(bank, offset);
+		reg = bank->base + bank->regs->dataout;
+
+	return (readl_relaxed(reg) & BIT(offset)) != 0;
 }
 
 static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
-- 
2.17.1
