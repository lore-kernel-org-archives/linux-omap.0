From: <grygorii.strashko@linaro.org>
Subject: [PATCH 2/8] gpio: omap: simplify omap_set_gpio_dataout_x()
Date: Thu, 19 Mar 2015 19:25:38 +0200
Message-ID: <1426785944-17255-3-git-send-email-grygorii.strashko@linaro.org>
References: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1426785944-17255-1-git-send-email-grygorii.strashko@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@linaro.org>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@linaro.org>

Both functions omap_set_gpio_dataout_reg() and
omap_set_gpio_dataout_mask() accept GPIO offset
as 'gpio' input parameter, so rename it to 'offset' and
drop usage of GPIO_BIT() macro.

Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
---
 drivers/gpio/gpio-omap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ce71239..7aeee7b 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -75,7 +75,7 @@ struct gpio_bank {
 	int power_mode;
 	bool workaround_enabled;
 
-	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
+	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
 	int (*get_context_loss_count)(struct device *dev);
 
 	struct omap_gpio_reg_offs *regs;
@@ -119,11 +119,11 @@ static void omap_set_gpio_direction(struct gpio_bank *bank, int gpio,
 
 
 /* set data out value using dedicate set/clear register */
-static void omap_set_gpio_dataout_reg(struct gpio_bank *bank, int gpio,
+static void omap_set_gpio_dataout_reg(struct gpio_bank *bank, unsigned offset,
 				      int enable)
 {
 	void __iomem *reg = bank->base;
-	u32 l = GPIO_BIT(bank, gpio);
+	u32 l = BIT(offset);
 
 	if (enable) {
 		reg += bank->regs->set_dataout;
@@ -137,11 +137,11 @@ static void omap_set_gpio_dataout_reg(struct gpio_bank *bank, int gpio,
 }
 
 /* set data out value using mask register */
-static void omap_set_gpio_dataout_mask(struct gpio_bank *bank, int gpio,
+static void omap_set_gpio_dataout_mask(struct gpio_bank *bank, unsigned offset,
 				       int enable)
 {
 	void __iomem *reg = bank->base + bank->regs->dataout;
-	u32 gpio_bit = GPIO_BIT(bank, gpio);
+	u32 gpio_bit = BIT(offset);
 	u32 l;
 
 	l = readl_relaxed(reg);
-- 
1.9.1

