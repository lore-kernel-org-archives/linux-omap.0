From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 14/20] gpio: gpio-omap: simplify omap_set_gpio_irqenable()
Date: Mon, 10 Jun 2019 20:10:57 +0300
Message-ID: <20190610171103.30903-15-grygorii.strashko@ti.com>
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

omap_set_gpio_irqenable() calls two helpers that are almost the same
apart from whether they set or clear bits. We can consolidate these:

- in the set/clear bit register case, we can perform the operation on
  our saved context copy and write the appropriate set/clear register.
- otherwise, we can use our read-modify-write helper and invert enable
  if irqenable_inv is set.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 61 ++++++++++------------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 097ed8d1a117..a90e27d7ce5e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -529,57 +529,26 @@ static u32 omap_get_gpio_irqbank_mask(struct gpio_bank *bank)
 	return l;
 }
 
-static void omap_enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
-{
-	void __iomem *reg = bank->base;
-	u32 l;
-
-	if (bank->regs->set_irqenable) {
-		reg += bank->regs->set_irqenable;
-		l = gpio_mask;
-		bank->context.irqenable1 |= gpio_mask;
-	} else {
-		reg += bank->regs->irqenable;
-		l = readl_relaxed(reg);
-		if (bank->regs->irqenable_inv)
-			l &= ~gpio_mask;
-		else
-			l |= gpio_mask;
-		bank->context.irqenable1 = l;
-	}
-
-	writel_relaxed(l, reg);
-}
-
-static void omap_disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
+static inline void omap_set_gpio_irqenable(struct gpio_bank *bank,
+					   unsigned offset, int enable)
 {
 	void __iomem *reg = bank->base;
-	u32 l;
+	u32 gpio_mask = BIT(offset);
 
-	if (bank->regs->clr_irqenable) {
-		reg += bank->regs->clr_irqenable;
-		l = gpio_mask;
-		bank->context.irqenable1 &= ~gpio_mask;
+	if (bank->regs->set_irqenable && bank->regs->clr_irqenable) {
+		if (enable) {
+			reg += bank->regs->set_irqenable;
+			bank->context.irqenable1 |= gpio_mask;
+		} else {
+			reg += bank->regs->clr_irqenable;
+			bank->context.irqenable1 &= ~gpio_mask;
+		}
+		writel_relaxed(gpio_mask, reg);
 	} else {
-		reg += bank->regs->irqenable;
-		l = readl_relaxed(reg);
-		if (bank->regs->irqenable_inv)
-			l |= gpio_mask;
-		else
-			l &= ~gpio_mask;
-		bank->context.irqenable1 = l;
+		bank->context.irqenable1 =
+			omap_gpio_rmw(reg + bank->regs->irqenable, gpio_mask,
+				      enable ^ bank->regs->irqenable_inv);
 	}
-
-	writel_relaxed(l, reg);
-}
-
-static inline void omap_set_gpio_irqenable(struct gpio_bank *bank,
-					   unsigned offset, int enable)
-{
-	if (enable)
-		omap_enable_gpio_irqbank(bank, BIT(offset));
-	else
-		omap_disable_gpio_irqbank(bank, BIT(offset));
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
2.17.1
