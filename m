From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: [PATCH v3 1/3] gpio/omap: replace open coded read-modify-write with _gpio_rmw function.
Date: Tue, 14 May 2013 22:54:25 +0200
Message-ID: <1368564867-11142-1-git-send-email-andreas.fenkart@streamunlimited.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:55023 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757791Ab3ENUyf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 May 2013 16:54:35 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Lobhc-1U0IfT3tFq-00gUou for
 <linux-omap@vger.kernel.org>; Tue, 14 May 2013 22:54:33 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: santosh.shilimkar@ti.com
Cc: khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org, jon-hunter@ti.com, Andreas Fenkart <andreas.fenkart@streamunlimited.com>

By also making it return the modified value, we save the readl
needed to update the context.

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 drivers/gpio/gpio-omap.c |  162 ++++++++++++++--------------------------------
 1 file changed, 50 insertions(+), 112 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 159f5c5..082919e 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -87,6 +87,19 @@ struct gpio_bank {
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 #define GPIO_MOD_CTRL_BIT	BIT(0)
 
+static inline u32 _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
+{
+	u32 l = __raw_readl(base + reg);
+
+	if (set)
+		l |= mask;
+	else
+		l &= ~mask;
+
+	__raw_writel(l, base + reg);
+	return l;
+}
+
 static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
 	return gpio_irq - bank->irq_base + bank->chip.base;
@@ -94,20 +107,10 @@ static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
-	void __iomem *reg = bank->base;
-	u32 l;
-
-	reg += bank->regs->direction;
-	l = __raw_readl(reg);
-	if (is_input)
-		l |= 1 << gpio;
-	else
-		l &= ~(1 << gpio);
-	__raw_writel(l, reg);
-	bank->context.oe = l;
+	bank->context.oe = _gpio_rmw(bank->base, bank->regs->direction, 1 <<
+				     gpio, is_input);
 }
 
-
 /* set data out value using dedicate set/clear register */
 static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 {
@@ -128,17 +131,8 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 /* set data out value using mask register */
 static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
 {
-	void __iomem *reg = bank->base + bank->regs->dataout;
-	u32 gpio_bit = GPIO_BIT(bank, gpio);
-	u32 l;
-
-	l = __raw_readl(reg);
-	if (enable)
-		l |= gpio_bit;
-	else
-		l &= ~gpio_bit;
-	__raw_writel(l, reg);
-	bank->context.dataout = l;
+	bank->context.dataout = _gpio_rmw(bank->base, bank->regs->dataout,
+					  GPIO_BIT(bank, gpio), enable);
 }
 
 static int _get_gpio_datain(struct gpio_bank *bank, int offset)
@@ -155,18 +149,6 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
 	return (__raw_readl(reg) & (1 << offset)) != 0;
 }
 
-static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
-{
-	int l = __raw_readl(base + reg);
-
-	if (set)
-		l |= mask;
-	else
-		l &= ~mask;
-
-	__raw_writel(l, base + reg);
-}
-
 static inline void _gpio_dbck_enable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
@@ -291,28 +273,24 @@ static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
 
-	_gpio_rmw(base, bank->regs->leveldetect0, gpio_bit,
-		  trigger & IRQ_TYPE_LEVEL_LOW);
-	_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
-		  trigger & IRQ_TYPE_LEVEL_HIGH);
-	_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
-		  trigger & IRQ_TYPE_EDGE_RISING);
-	_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
-		  trigger & IRQ_TYPE_EDGE_FALLING);
 
 	bank->context.leveldetect0 =
-			__raw_readl(bank->base + bank->regs->leveldetect0);
+		_gpio_rmw(base, bank->regs->leveldetect0,
+			  gpio_bit, trigger & IRQ_TYPE_LEVEL_LOW);
 	bank->context.leveldetect1 =
-			__raw_readl(bank->base + bank->regs->leveldetect1);
+		_gpio_rmw(base, bank->regs->leveldetect1,
+			  gpio_bit, trigger & IRQ_TYPE_LEVEL_HIGH);
 	bank->context.risingdetect =
-			__raw_readl(bank->base + bank->regs->risingdetect);
+		_gpio_rmw(base, bank->regs->risingdetect,
+			  gpio_bit, trigger & IRQ_TYPE_EDGE_RISING);
 	bank->context.fallingdetect =
-			__raw_readl(bank->base + bank->regs->fallingdetect);
+		_gpio_rmw(base, bank->regs->fallingdetect,
+			  gpio_bit, trigger & IRQ_TYPE_EDGE_FALLING);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
 		bank->context.wake_en =
-			__raw_readl(bank->base + bank->regs->wkup_en);
+			_gpio_rmw(base, bank->regs->wkup_en, gpio_bit,
+				  trigger != 0);
 	}
 
 	/* This part needs to be executed always for OMAP{34xx, 44xx} */
@@ -406,9 +384,9 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
 			l |= 1 << (gpio << 1);
 
 		/* Enable wake-up during idle for dynamic tick */
-		_gpio_rmw(base, bank->regs->wkup_en, 1 << gpio, trigger);
 		bank->context.wake_en =
-			__raw_readl(bank->base + bank->regs->wkup_en);
+			_gpio_rmw(base, bank->regs->wkup_en, 1 << gpio,
+				  trigger);
 		__raw_writel(l, reg);
 	}
 	return 0;
@@ -450,19 +428,16 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *base = bank->base;
 
-	reg += bank->regs->irqstatus;
-	__raw_writel(gpio_mask, reg);
+	__raw_writel(gpio_mask, base + bank->regs->irqstatus);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (bank->regs->irqstatus2) {
-		reg = bank->base + bank->regs->irqstatus2;
-		__raw_writel(gpio_mask, reg);
-	}
+	if (bank->regs->irqstatus2)
+		__raw_writel(gpio_mask, base + bank->regs->irqstatus2);
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
-	__raw_readl(reg);
+	__raw_readl(base + bank->regs->irqstatus);
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -486,46 +461,26 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 
 static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
-	void __iomem *reg = bank->base;
-	u32 l;
-
 	if (bank->regs->set_irqenable) {
-		reg += bank->regs->set_irqenable;
-		l = gpio_mask;
 		bank->context.irqenable1 |= gpio_mask;
+		__raw_writel(gpio_mask, bank->base + bank->regs->set_irqenable);
 	} else {
-		reg += bank->regs->irqenable;
-		l = __raw_readl(reg);
-		if (bank->regs->irqenable_inv)
-			l &= ~gpio_mask;
-		else
-			l |= gpio_mask;
-		bank->context.irqenable1 = l;
+		bank->context.irqenable1 =
+			_gpio_rmw(bank->base, bank->regs->irqenable, gpio_mask,
+				  bank->regs->irqenable_inv ? false : true);
 	}
-
-	__raw_writel(l, reg);
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
-	void __iomem *reg = bank->base;
-	u32 l;
-
 	if (bank->regs->clr_irqenable) {
-		reg += bank->regs->clr_irqenable;
-		l = gpio_mask;
 		bank->context.irqenable1 &= ~gpio_mask;
+		__raw_writel(gpio_mask, bank->base + bank->regs->clr_irqenable);
 	} else {
-		reg += bank->regs->irqenable;
-		l = __raw_readl(reg);
-		if (bank->regs->irqenable_inv)
-			l |= gpio_mask;
-		else
-			l &= ~gpio_mask;
-		bank->context.irqenable1 = l;
+		bank->context.irqenable1 =
+			_gpio_rmw(bank->base, bank->regs->irqenable, gpio_mask,
+				  bank->regs->irqenable_inv ?: false);
 	}
-
-	__raw_writel(l, reg);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
@@ -556,12 +511,8 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	}
 
 	spin_lock_irqsave(&bank->lock, flags);
-	if (enable)
-		bank->context.wake_en |= gpio_bit;
-	else
-		bank->context.wake_en &= ~gpio_bit;
-
-	__raw_writel(bank->context.wake_en, bank->base + bank->regs->wkup_en);
+	bank->context.wake_en = _gpio_rmw(bank->base, bank->regs->wkup_en,
+					  gpio_bit, enable);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -604,21 +555,14 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
 	if (bank->regs->pinctrl) {
-		void __iomem *reg = bank->base + bank->regs->pinctrl;
-
 		/* Claim the pin for MPU */
-		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
+		_gpio_rmw(bank->base, bank->regs->pinctrl, 1 << offset, 1);
 	}
 
 	if (bank->regs->ctrl && !bank->mod_usage) {
-		void __iomem *reg = bank->base + bank->regs->ctrl;
-		u32 ctrl;
-
-		ctrl = __raw_readl(reg);
 		/* Module is enabled, clocks are not gated */
-		ctrl &= ~GPIO_MOD_CTRL_BIT;
-		__raw_writel(ctrl, reg);
-		bank->context.ctrl = ctrl;
+		bank->context.ctrl = _gpio_rmw(bank->base, bank->regs->ctrl,
+					       GPIO_MOD_CTRL_BIT, 0);
 	}
 
 	bank->mod_usage |= 1 << offset;
@@ -638,22 +582,16 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	if (bank->regs->wkup_en) {
 		/* Disable wake-up during idle for dynamic tick */
-		_gpio_rmw(base, bank->regs->wkup_en, 1 << offset, 0);
 		bank->context.wake_en =
-			__raw_readl(bank->base + bank->regs->wkup_en);
+			_gpio_rmw(base, bank->regs->wkup_en, 1 << offset, 0);
 	}
 
 	bank->mod_usage &= ~(1 << offset);
 
 	if (bank->regs->ctrl && !bank->mod_usage) {
-		void __iomem *reg = bank->base + bank->regs->ctrl;
-		u32 ctrl;
-
-		ctrl = __raw_readl(reg);
 		/* Module is disabled, clocks are gated */
-		ctrl |= GPIO_MOD_CTRL_BIT;
-		__raw_writel(ctrl, reg);
-		bank->context.ctrl = ctrl;
+		bank->context.ctrl = _gpio_rmw(base, bank->regs->ctrl,
+					       GPIO_MOD_CTRL_BIT, 1);
 	}
 
 	_reset_gpio(bank, bank->chip.base + offset);
-- 
1.7.10.4

