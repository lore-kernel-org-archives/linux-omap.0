From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH-next 17/20] gpio: gpio-omap: constify register tables
Date: Mon, 10 Jun 2019 20:11:00 +0300
Message-ID: <20190610171103.30903-18-grygorii.strashko@ti.com>
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

We must never alter the register tables; these are read-only as far
as the driver is concerned.  Constify these tables.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/gpio/gpio-omap.c                | 12 ++++++------
 include/linux/platform_data/gpio-omap.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1c5fa12bcf9f..039bbb1ae6cb 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -48,6 +48,8 @@ struct gpio_regs {
 
 struct gpio_bank {
 	void __iomem *base;
+	const struct omap_gpio_reg_offs *regs;
+
 	int irq;
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
@@ -75,8 +77,6 @@ struct gpio_bank {
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
 	int (*get_context_loss_count)(struct device *dev);
-
-	struct omap_gpio_reg_offs *regs;
 };
 
 #define GPIO_MOD_CTRL_BIT	BIT(0)
@@ -1075,7 +1075,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 
 static void omap_gpio_init_context(struct gpio_bank *p)
 {
-	struct omap_gpio_reg_offs *regs = p->regs;
+	const struct omap_gpio_reg_offs *regs = p->regs;
 	void __iomem *base = p->base;
 
 	p->context.ctrl		= readl_relaxed(base + regs->ctrl);
@@ -1094,7 +1094,7 @@ static void omap_gpio_init_context(struct gpio_bank *p)
 
 static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	struct omap_gpio_reg_offs *regs = bank->regs;
+	const struct omap_gpio_reg_offs *regs = bank->regs;
 	void __iomem *base = bank->base;
 
 	writel_relaxed(bank->context.wake_en, base + regs->wkup_en);
@@ -1267,7 +1267,7 @@ static int gpio_omap_cpu_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static struct omap_gpio_reg_offs omap2_gpio_regs = {
+static const struct omap_gpio_reg_offs omap2_gpio_regs = {
 	.revision =		OMAP24XX_GPIO_REVISION,
 	.direction =		OMAP24XX_GPIO_OE,
 	.datain =		OMAP24XX_GPIO_DATAIN,
@@ -1290,7 +1290,7 @@ static struct omap_gpio_reg_offs omap2_gpio_regs = {
 	.fallingdetect =	OMAP24XX_GPIO_FALLINGDETECT,
 };
 
-static struct omap_gpio_reg_offs omap4_gpio_regs = {
+static const struct omap_gpio_reg_offs omap4_gpio_regs = {
 	.revision =		OMAP4_GPIO_REVISION,
 	.direction =		OMAP4_GPIO_OE,
 	.datain =		OMAP4_GPIO_DATAIN,
diff --git a/include/linux/platform_data/gpio-omap.h b/include/linux/platform_data/gpio-omap.h
index 17edc43201d2..8b30b14b47d3 100644
--- a/include/linux/platform_data/gpio-omap.h
+++ b/include/linux/platform_data/gpio-omap.h
@@ -186,7 +186,7 @@ struct omap_gpio_platform_data {
 	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
-	struct omap_gpio_reg_offs *regs;
+	const struct omap_gpio_reg_offs *regs;
 
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
-- 
2.17.1
