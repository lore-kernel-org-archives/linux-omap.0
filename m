From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 18/20] gpio: gpio-omap: clean up wakeup handling
Date: Mon, 10 Jun 2019 20:11:01 +0300
Message-ID: <20190610171103.30903-19-grygorii.strashko@ti.com>
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

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 039bbb1ae6cb..61e32c7e6670 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -305,12 +305,6 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	bank->level_mask = bank->context.leveldetect0 |
 			   bank->context.leveldetect1;
 
-	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		omap_gpio_rmw(base + bank->regs->wkup_en, gpio_bit, trigger != 0);
-		bank->context.wake_en =
-			readl_relaxed(bank->base + bank->regs->wkup_en);
-	}
-
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
 	if (!bank->regs->irqctrl && !omap_gpio_is_off_wakeup_capable(bank, gpio)) {
 		/*
@@ -343,7 +337,6 @@ static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
 				    unsigned trigger)
 {
 	void __iomem *reg = bank->base;
-	void __iomem *base = bank->base;
 	u32 l = 0;
 
 	if (bank->regs->leveldetect0 && bank->regs->wkup_en) {
@@ -375,11 +368,6 @@ static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
 			l |= 2 << (gpio << 1);
 		if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l |= BIT(gpio << 1);
-
-		/* Enable wake-up during idle for dynamic tick */
-		omap_gpio_rmw(base + bank->regs->wkup_en, BIT(gpio), trigger);
-		bank->context.wake_en =
-			readl_relaxed(bank->base + bank->regs->wkup_en);
 		writel_relaxed(l, reg);
 	}
 	return 0;
@@ -408,17 +396,6 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
 
 static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 {
-	void __iomem *base = bank->base;
-
-	if (bank->regs->wkup_en &&
-	    !LINE_USED(bank->mod_usage, offset) &&
-	    !LINE_USED(bank->irq_usage, offset)) {
-		/* Disable wake-up during idle for dynamic tick */
-		omap_gpio_rmw(base + bank->regs->wkup_en, BIT(offset), 0);
-		bank->context.wake_en =
-			readl_relaxed(bank->base + bank->regs->wkup_en);
-	}
-
 	if (bank->regs->ctrl && !BANK_USED(bank)) {
 		void __iomem *reg = bank->base + bank->regs->ctrl;
 		u32 ctrl;
@@ -549,6 +526,19 @@ static inline void omap_set_gpio_irqenable(struct gpio_bank *bank,
 			omap_gpio_rmw(reg + bank->regs->irqenable, gpio_mask,
 				      enable ^ bank->regs->irqenable_inv);
 	}
+
+	/*
+	 * Program GPIO wakeup along with IRQ enable to satisfy OMAP4430 TRM
+	 * note requiring correlation between the IRQ enable registers and
+	 * the wakeup registers.  In any case, we want wakeup from idle
+	 * enabled for the GPIOs which support this feature.
+	 */
+	if (bank->regs->wkup_en &&
+	    (bank->regs->edgectrl1 || !(bank->non_wakeup_gpios & gpio_mask))) {
+		bank->context.wake_en =
+			omap_gpio_rmw(bank->base + bank->regs->wkup_en,
+				      gpio_mask, enable);
+	}
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-- 
2.17.1
