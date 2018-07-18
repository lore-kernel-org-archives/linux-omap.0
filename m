From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
Date: Thu, 19 Jul 2018 01:57:08 +0200
Message-ID: <20180718235710.18242-7-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

This should make applications utilizing whole banks work faster.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 drivers/gpio/gpio-omap.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 86 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index d1afedf4dcbf..e81008678a38 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -77,6 +77,8 @@ struct gpio_bank {
 	bool workaround_enabled;
 
 	void (*set_dataout)(struct gpio_bank *bank, unsigned gpio, int enable);
+	void (*set_dataout_multiple)(struct gpio_bank *bank,
+				     unsigned long *mask, unsigned long *bits);
 	int (*get_context_loss_count)(struct device *dev);
 
 	struct omap_gpio_reg_offs *regs;
@@ -161,6 +163,51 @@ static int omap_get_gpio_dataout(struct gpio_bank *bank, int offset)
 	return (readl_relaxed(reg) & (BIT(offset))) != 0;
 }
 
+/* set multiple data out values using dedicate set/clear register */
+static void omap_set_gpio_dataout_reg_multiple(struct gpio_bank *bank,
+					       unsigned long *mask,
+					       unsigned long *bits)
+{
+	void __iomem *reg = bank->base;
+	u32 l;
+
+	l = *bits & *mask;
+	writel_relaxed(l, reg + bank->regs->set_dataout);
+	bank->context.dataout |= l;
+
+	l = ~*bits & *mask;
+	writel_relaxed(l, reg + bank->regs->clr_dataout);
+	bank->context.dataout &= ~l;
+}
+
+/* set multiple data out values using mask register */
+static void omap_set_gpio_dataout_mask_multiple(struct gpio_bank *bank,
+						unsigned long *mask,
+						unsigned long *bits)
+{
+	void __iomem *reg = bank->base + bank->regs->dataout;
+	u32 l = (readl_relaxed(reg) & ~*mask) | (*bits & *mask);
+
+	writel_relaxed(l, reg);
+	bank->context.dataout = l;
+}
+
+static unsigned long omap_get_gpio_datain_multiple(struct gpio_bank *bank,
+					      unsigned long *mask)
+{
+	void __iomem *reg = bank->base + bank->regs->datain;
+
+	return readl_relaxed(reg) & *mask;
+}
+
+static unsigned long omap_get_gpio_dataout_multiple(struct gpio_bank *bank,
+					       unsigned long *mask)
+{
+	void __iomem *reg = bank->base + bank->regs->dataout;
+
+	return readl_relaxed(reg) & *mask;
+}
+
 static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = readl_relaxed(base + reg);
@@ -968,6 +1015,26 @@ static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	return 0;
 }
 
+static int omap_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
+				  unsigned long *bits)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	void __iomem *reg = bank->base + bank->regs->direction;
+	unsigned long in = readl_relaxed(reg), l;
+
+	*bits = 0;
+
+	l = in & *mask;
+	if (l)
+		*bits |= omap_get_gpio_datain_multiple(bank, &l);
+
+	l = ~in & *mask;
+	if (l)
+		*bits |= omap_get_gpio_dataout_multiple(bank, &l);
+
+	return 0;
+}
+
 static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
 			      unsigned debounce)
 {
@@ -1012,6 +1079,17 @@ static void omap_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	raw_spin_unlock_irqrestore(&bank->lock, flags);
 }
 
+static void omap_gpio_set_multiple(struct gpio_chip *chip, unsigned long *mask,
+				   unsigned long *bits)
+{
+	struct gpio_bank *bank = gpiochip_get_data(chip);
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	bank->set_dataout_multiple(bank, mask, bits);
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+}
+
 /*---------------------------------------------------------------------*/
 
 static void omap_gpio_show_rev(struct gpio_bank *bank)
@@ -1073,9 +1151,11 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	bank->chip.get_direction = omap_gpio_get_direction;
 	bank->chip.direction_input = omap_gpio_input;
 	bank->chip.get = omap_gpio_get;
+	bank->chip.get_multiple = omap_gpio_get_multiple;
 	bank->chip.direction_output = omap_gpio_output;
 	bank->chip.set_config = omap_gpio_set_config;
 	bank->chip.set = omap_gpio_set;
+	bank->chip.set_multiple = omap_gpio_set_multiple;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1209,10 +1289,14 @@ static int omap_gpio_probe(struct platform_device *pdev)
 				pdata->get_context_loss_count;
 	}
 
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+	if (bank->regs->set_dataout && bank->regs->clr_dataout) {
 		bank->set_dataout = omap_set_gpio_dataout_reg;
-	else
+		bank->set_dataout_multiple = omap_set_gpio_dataout_reg_multiple;
+	} else {
 		bank->set_dataout = omap_set_gpio_dataout_mask;
+		bank->set_dataout_multiple =
+				omap_set_gpio_dataout_mask_multiple;
+	}
 
 	raw_spin_lock_init(&bank->lock);
 	raw_spin_lock_init(&bank->wa_lock);
-- 
2.16.4
