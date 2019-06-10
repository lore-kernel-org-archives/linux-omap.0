From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 10/20] gpio: gpio-omap: simplify set_multiple()
Date: Mon, 10 Jun 2019 20:10:53 +0300
Message-ID: <20190610171103.30903-11-grygorii.strashko@ti.com>
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

One of the reasons for set_multiple() to exist is to allow multiple
GPIOs on the same chip to be changed simultaneously - see commit
5f42424354f5 ("gpiolib: allow simultaneous setting of multiple GPIO
outputs"):

 - Simultaneous glitch-free setting of multiple pins on any kind of
   parallel bus attached to GPIOs provided they all reside on the
   same chip and bank.

In order for this to work, we should not use the atomic set/clear
registers, but instead read-modify-write the dataout register.  We
already take the spinlock to ensure that happens atomically, so
move the code into the set_multiple() function and kill the two
helper functions.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 45 +++++++---------------------------------
 1 file changed, 7 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a26decc5c611..8fdac6e4a929 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -74,8 +74,6 @@ struct gpio_bank {
 	int context_loss_count;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
-	void (*set_dataout_multiple)(struct gpio_bank *bank,
-				     unsigned long *mask, unsigned long *bits);
 	int (*get_context_loss_count)(struct device *dev);
 
 	struct omap_gpio_reg_offs *regs;
@@ -146,35 +144,6 @@ static void omap_set_gpio_dataout_mask(struct gpio_bank *bank, unsigned offset,
 	bank->context.dataout = l;
 }
 
-/* set multiple data out values using dedicate set/clear register */
-static void omap_set_gpio_dataout_reg_multiple(struct gpio_bank *bank,
-					       unsigned long *mask,
-					       unsigned long *bits)
-{
-	void __iomem *reg = bank->base;
-	u32 l;
-
-	l = *bits & *mask;
-	writel_relaxed(l, reg + bank->regs->set_dataout);
-	bank->context.dataout |= l;
-
-	l = ~*bits & *mask;
-	writel_relaxed(l, reg + bank->regs->clr_dataout);
-	bank->context.dataout &= ~l;
-}
-
-/* set multiple data out values using mask register */
-static void omap_set_gpio_dataout_mask_multiple(struct gpio_bank *bank,
-						unsigned long *mask,
-						unsigned long *bits)
-{
-	void __iomem *reg = bank->base + bank->regs->dataout;
-	u32 l = (readl_relaxed(reg) & ~*mask) | (*bits & *mask);
-
-	writel_relaxed(l, reg);
-	bank->context.dataout = l;
-}
-
 static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = readl_relaxed(base + reg);
@@ -1037,10 +1006,14 @@ static void omap_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
 				   unsigned long *bits)
 {
 	struct gpio_bank *bank = gpiochip_get_data(chip);
+	void __iomem *reg = bank->base + bank->regs->dataout;
 	unsigned long flags;
+	u32 l;
 
 	raw_spin_lock_irqsave(&bank->lock, flags);
-	bank->set_dataout_multiple(bank, mask, bits);
+	l = (readl_relaxed(reg) & ~*mask) | (*bits & *mask);
+	writel_relaxed(l, reg);
+	bank->context.dataout = l;
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -1530,14 +1503,10 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				pdata->get_context_loss_count;
 	}
 
-	if (bank->regs->set_dataout && bank->regs->clr_dataout) {
+	if (bank->regs->set_dataout && bank->regs->clr_dataout)
 		bank->set_dataout = omap_set_gpio_dataout_reg;
-		bank->set_dataout_multiple = omap_set_gpio_dataout_reg_multiple;
-	} else {
+	else
 		bank->set_dataout = omap_set_gpio_dataout_mask;
-		bank->set_dataout_multiple =
-				omap_set_gpio_dataout_mask_multiple;
-	}
 
 	raw_spin_lock_init(&bank->lock);
 	raw_spin_lock_init(&bank->wa_lock);
-- 
2.17.1
