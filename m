From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 11/20] gpio: gpio-omap: simplify bank->level_mask
Date: Mon, 10 Jun 2019 20:10:54 +0300
Message-ID: <20190610171103.30903-12-grygorii.strashko@ti.com>
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

bank->level_mask is merely the bitwise or of the level detection
context which we have already read in this function.  Rather than
repeating additional reads, compute it from the values already
read.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 8fdac6e4a929..369ce46e2b09 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -325,6 +325,9 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	bank->context.fallingdetect =
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
+	bank->level_mask = bank->context.leveldetect0 |
+			   bank->context.leveldetect1;
+
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
 		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
 		bank->context.wake_en =
@@ -344,10 +347,6 @@ static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 		else
 			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
 	}
-
-	bank->level_mask =
-		readl_relaxed(bank->base + bank->regs->leveldetect0) |
-		readl_relaxed(bank->base + bank->regs->leveldetect1);
 }
 
 #ifdef CONFIG_ARCH_OMAP1
-- 
2.17.1
