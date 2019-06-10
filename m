From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 16/20] gpio: gpio-omap: clean up omap_gpio_restore_context()
Date: Mon, 10 Jun 2019 20:10:59 +0300
Message-ID: <20190610171103.30903-17-grygorii.strashko@ti.com>
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

Use local variables to store the base iomem address and regs table
pointer like omap_gpio_init_context() does. Not only does this make
the function neater, it also avoids unnecessary reloads of the same
data multiple times.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c24a91b2df97..1c5fa12bcf9f 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1094,32 +1094,26 @@ static void omap_gpio_init_context(struct gpio_bank *p)
 
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	writel_relaxed(bank->context.wake_en,
-				bank->base + bank->regs->wkup_en);
-	writel_relaxed(bank->context.ctrl, bank->base + bank->regs->ctrl);
-	writel_relaxed(bank->context.leveldetect0,
-				bank->base + bank->regs->leveldetect0);
-	writel_relaxed(bank->context.leveldetect1,
-				bank->base + bank->regs->leveldetect1);
-	writel_relaxed(bank->context.risingdetect,
-				bank->base + bank->regs->risingdetect);
-	writel_relaxed(bank->context.fallingdetect,
-				bank->base + bank->regs->fallingdetect);
-	writel_relaxed(bank->context.dataout,
-				bank->base + bank->regs->dataout);
-	writel_relaxed(bank->context.oe, bank->base + bank->regs->direction);
+	struct omap_gpio_reg_offs *regs = bank->regs;
+	void __iomem *base = bank->base;
+
+	writel_relaxed(bank->context.wake_en, base + regs->wkup_en);
+	writel_relaxed(bank->context.ctrl, base + regs->ctrl);
+	writel_relaxed(bank->context.leveldetect0, base + regs->leveldetect0);
+	writel_relaxed(bank->context.leveldetect1, base + regs->leveldetect1);
+	writel_relaxed(bank->context.risingdetect, base + regs->risingdetect);
+	writel_relaxed(bank->context.fallingdetect, base + regs->fallingdetect);
+	writel_relaxed(bank->context.dataout, base + regs->dataout);
+	writel_relaxed(bank->context.oe, base + regs->direction);
 
 	if (bank->dbck_enable_mask) {
-		writel_relaxed(bank->context.debounce, bank->base +
-					bank->regs->debounce);
+		writel_relaxed(bank->context.debounce, base + regs->debounce);
 		writel_relaxed(bank->context.debounce_en,
-					bank->base + bank->regs->debounce_en);
+			       base + regs->debounce_en);
 	}
 
-	writel_relaxed(bank->context.irqenable1,
-				bank->base + bank->regs->irqenable);
-	writel_relaxed(bank->context.irqenable2,
-				bank->base + bank->regs->irqenable2);
+	writel_relaxed(bank->context.irqenable1, base + regs->irqenable);
+	writel_relaxed(bank->context.irqenable2, base + regs->irqenable2);
 }
 
 static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
-- 
2.17.1
