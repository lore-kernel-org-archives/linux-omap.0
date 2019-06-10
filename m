From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 15/20] gpio: gpio-omap: remove dataout variation in context handling
Date: Mon, 10 Jun 2019 20:10:58 +0300
Message-ID: <20190610171103.30903-16-grygorii.strashko@ti.com>
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

When a GPIO block has the set/clear dataout registers implemented, it
also has the normal dataout register implemented. Reading this register
reads the current GPIO output state, and writing it sets the GPIOs to
the explicit state. This is the behaviour that we want when saving and
restoring the context, so use the dataout register exclusively.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index a90e27d7ce5e..c24a91b2df97 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1087,11 +1087,7 @@ static void omap_gpio_init_context(struct gpio_bank *p)
 	p->context.fallingdetect = readl_relaxed(base + regs->fallingdetect);
 	p->context.irqenable1	= readl_relaxed(base + regs->irqenable);
 	p->context.irqenable2	= readl_relaxed(base + regs->irqenable2);
-
-	if (regs->set_dataout && p->regs->clr_dataout)
-		p->context.dataout = readl_relaxed(base + regs->set_dataout);
-	else
-		p->context.dataout = readl_relaxed(base + regs->dataout);
+	p->context.dataout	= readl_relaxed(base + regs->dataout);
 
 	p->context_valid = true;
 }
@@ -1109,11 +1105,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank)
 				bank->base + bank->regs->risingdetect);
 	writel_relaxed(bank->context.fallingdetect,
 				bank->base + bank->regs->fallingdetect);
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
-		writel_relaxed(bank->context.dataout,
-				bank->base + bank->regs->set_dataout);
-	else
-		writel_relaxed(bank->context.dataout,
+	writel_relaxed(bank->context.dataout,
 				bank->base + bank->regs->dataout);
 	writel_relaxed(bank->context.oe, bank->base + bank->regs->direction);
 
-- 
2.17.1
