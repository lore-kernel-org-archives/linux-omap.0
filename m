From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 07/20] gpio: gpio-omap: simplify omap_gpio_get_direction()
Date: Mon, 10 Jun 2019 20:10:50 +0300
Message-ID: <20190610171103.30903-8-grygorii.strashko@ti.com>
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

Architectures are single-copy atomic, which means that simply reading
a register is an inherently atomic operation.  There is no need to
take a spinlock here.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index cc320d09d074..44a4287cce9e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -953,17 +953,10 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 static int omap_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_bank *bank;
-	unsigned long flags;
-	void __iomem *reg;
-	int dir;
+	struct gpio_bank *bank = gpiochip_get_data(chip);
 
-	bank = gpiochip_get_data(chip);
-	reg = bank->base + bank->regs->direction;
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	dir = !!(readl_relaxed(reg) & BIT(offset));
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-	return dir;
+	return !!(readl_relaxed(bank->base + bank->regs->direction) &
+		  BIT(offset));
 }
 
 static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
-- 
2.17.1
