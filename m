From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 13/20] gpio: gpio-omap: simplify omap_toggle_gpio_edge_triggering()
Date: Mon, 10 Jun 2019 20:10:56 +0300
Message-ID: <20190610171103.30903-14-grygorii.strashko@ti.com>
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

This function open-codes an exclusive-or bitwise operation using an
if() statement and explicitly setting or clearing the bit. Instead,
use an exclusive-or operation instead, and simplify the function.

We can combine the preprocessor conditional using IS_ENABLED() and
gain some additional compilation coverage.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1a0890586b45..097ed8d1a117 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -326,32 +326,18 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	}
 }
 
-#ifdef CONFIG_ARCH_OMAP1
 /*
  * This only applies to chips that can't do both rising and falling edge
  * detection at once.  For all other chips, this function is a noop.
  */
 static void omap_toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg = bank->base;
-	u32 l = 0;
-
-	if (!bank->regs->irqctrl)
-		return;
-
-	reg += bank->regs->irqctrl;
+	if (IS_ENABLED(CONFIG_ARCH_OMAP1) && bank->regs->irqctrl) {
+		void __iomem *reg = bank->base + bank->regs->irqctrl;
 
-	l = readl_relaxed(reg);
-	if ((l >> gpio) & 1)
-		l &= ~(BIT(gpio));
-	else
-		l |= BIT(gpio);
-
-	writel_relaxed(l, reg);
+		writel_relaxed(readl_relaxed(reg) ^ BIT(gpio), reg);
+	}
 }
-#else
-static void omap_toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
-#endif
 
 static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
 				    unsigned trigger)
-- 
2.17.1
