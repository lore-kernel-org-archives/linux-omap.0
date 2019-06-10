From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 20/20] gpio: gpio-omap: clean up register access in omap2_set_gpio_debounce()
Date: Mon, 10 Jun 2019 20:11:03 +0300
Message-ID: <20190610171103.30903-21-grygorii.strashko@ti.com>
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
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 94b10dfbff3f..52592eac0895 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -181,7 +181,6 @@ static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
 static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 				   unsigned debounce)
 {
-	void __iomem		*reg;
 	u32			val;
 	u32			l;
 	bool			enable = !!debounce;
@@ -198,8 +197,7 @@ static int omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned offset,
 	l = BIT(offset);
 
 	clk_enable(bank->dbck);
-	reg = bank->base + bank->regs->debounce;
-	writel_relaxed(debounce, reg);
+	writel_relaxed(debounce, bank->base + bank->regs->debounce);
 
 	val = omap_gpio_rmw(bank->base + bank->regs->debounce_en, l, enable);
 	bank->dbck_enable_mask = val;
-- 
2.17.1
