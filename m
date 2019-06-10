From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 09/20] gpio: gpio-omap: simplify get_multiple()
Date: Mon, 10 Jun 2019 20:10:52 +0300
Message-ID: <20190610171103.30903-10-grygorii.strashko@ti.com>
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

There is no reason to have helper functions to read the datain and
dataout registers when they are only used in one location.  Simplify
this code to make it more readable.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index bf1e6f1d0de7..a26decc5c611 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -175,22 +175,6 @@ static void omap_set_gpio_dataout_mask_multiple(struct gpio_bank *bank,
 	bank->context.dataout = l;
 }
 
-static unsigned long omap_get_gpio_datain_multiple(struct gpio_bank *bank,
-					      unsigned long *mask)
-{
-	void __iomem *reg = bank->base + bank->regs->datain;
-
-	return readl_relaxed(reg) & *mask;
-}
-
-static unsigned long omap_get_gpio_dataout_multiple(struct gpio_bank *bank,
-					       unsigned long *mask)
-{
-	void __iomem *reg = bank->base + bank->regs->dataout;
-
-	return readl_relaxed(reg) & *mask;
-}
-
 static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = readl_relaxed(base + reg);
@@ -987,18 +971,20 @@ static int omap_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
 				  unsigned long *bits)
 {
 	struct gpio_bank *bank = gpiochip_get_data(chip);
-	void __iomem *reg = bank->base + bank->regs->direction;
-	unsigned long in = readl_relaxed(reg), l;
+	void __iomem *base = bank->base;
+	u32 direction, m, val = 0;
+
+	direction = readl_relaxed(base + bank->regs->direction);
 
-	*bits = 0;
+	m = direction & *mask;
+	if (m)
+		val |= readl_relaxed(base + bank->regs->datain) & m;
 
-	l = in & *mask;
-	if (l)
-		*bits |= omap_get_gpio_datain_multiple(bank, &l);
+	m = ~direction & *mask;
+	if (m)
+		val |= readl_relaxed(base + bank->regs->dataout) & m;
 
-	l = ~in & *mask;
-	if (l)
-		*bits |= omap_get_gpio_dataout_multiple(bank, &l);
+	*bits = val;
 
 	return 0;
 }
-- 
2.17.1
