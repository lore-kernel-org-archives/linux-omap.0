From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 3/3] gpio: omap: Add an omap prefix to all functions
Date: Fri, 27 Jun 2014 22:17:37 +0200
Message-ID: <1403900258-20717-4-git-send-email-jmartinez@softcrates.net>
References: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:61889 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752851AbaF0USE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jun 2014 16:18:04 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so3396057wiv.14
        for <linux-omap@vger.kernel.org>; Fri, 27 Jun 2014 13:18:02 -0700 (PDT)
In-Reply-To: <1403900258-20717-1-git-send-email-jmartinez@softcrates.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Javier Martinez Canillas <jmartinez@softcrates.net>

The GPIO OMAP driver didn't have a consistent naming scheme for
all its functions. Some of them had an omap prefix while others
didn't. There are many advantages on having a separate namespace
for driver functions so let's add an "omap" prefix to all of them.

Signed-off-by: Javier Martinez Canillas <jmartinez@softcrates.net>
---
 drivers/gpio/gpio-omap.c | 268 ++++++++++++++++++++++++-----------------------
 1 file changed, 137 insertions(+), 131 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ef461e7..1749321 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -88,18 +88,19 @@ struct gpio_bank {
 #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
 #define LINE_USED(line, offset) (line & (BIT(offset)))
 
-static int irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
+static int omap_irq_to_gpio(struct gpio_bank *bank, unsigned int gpio_irq)
 {
 	return bank->chip.base + gpio_irq;
 }
 
-static inline struct gpio_bank *_irq_data_get_bank(struct irq_data *d)
+static inline struct gpio_bank *omap_irq_data_get_bank(struct irq_data *d)
 {
 	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
 	return container_of(chip, struct gpio_bank, chip);
 }
 
-static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
+static void omap_set_gpio_direction(struct gpio_bank *bank, int gpio,
+				    int is_input)
 {
 	void __iomem *reg = bank->base;
 	u32 l;
@@ -116,7 +117,8 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 
 
 /* set data out value using dedicate set/clear register */
-static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
+static void omap_set_gpio_dataout_reg(struct gpio_bank *bank, int gpio,
+				      int enable)
 {
 	void __iomem *reg = bank->base;
 	u32 l = GPIO_BIT(bank, gpio);
@@ -133,7 +135,8 @@ static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 }
 
 /* set data out value using mask register */
-static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
+static void omap_set_gpio_dataout_mask(struct gpio_bank *bank, int gpio,
+				       int enable)
 {
 	void __iomem *reg = bank->base + bank->regs->dataout;
 	u32 gpio_bit = GPIO_BIT(bank, gpio);
@@ -148,21 +151,21 @@ static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
 	bank->context.dataout = l;
 }
 
-static int _get_gpio_datain(struct gpio_bank *bank, int offset)
+static int omap_get_gpio_datain(struct gpio_bank *bank, int offset)
 {
 	void __iomem *reg = bank->base + bank->regs->datain;
 
 	return (readl_relaxed(reg) & (BIT(offset))) != 0;
 }
 
-static int _get_gpio_dataout(struct gpio_bank *bank, int offset)
+static int omap_get_gpio_dataout(struct gpio_bank *bank, int offset)
 {
 	void __iomem *reg = bank->base + bank->regs->dataout;
 
 	return (readl_relaxed(reg) & (BIT(offset))) != 0;
 }
 
-static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
+static inline void omap_gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 {
 	int l = readl_relaxed(base + reg);
 
@@ -174,7 +177,7 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 	writel_relaxed(l, base + reg);
 }
 
-static inline void _gpio_dbck_enable(struct gpio_bank *bank)
+static inline void omap_gpio_dbck_enable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
 		clk_prepare_enable(bank->dbck);
@@ -185,7 +188,7 @@ static inline void _gpio_dbck_enable(struct gpio_bank *bank)
 	}
 }
 
-static inline void _gpio_dbck_disable(struct gpio_bank *bank)
+static inline void omap_gpio_dbck_disable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && bank->dbck_enabled) {
 		/*
@@ -201,7 +204,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
 }
 
 /**
- * _set_gpio_debounce - low level gpio debounce time
+ * omap2_set_gpio_debounce - low level gpio debounce time
  * @bank: the gpio bank we're acting upon
  * @gpio: the gpio number on this @gpio
  * @debounce: debounce time to use
@@ -209,8 +212,8 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
  * OMAP's debounce time is in 31us steps so we need
  * to convert and round up to the closest unit.
  */
-static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
-		unsigned debounce)
+static void omap2_set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
+				    unsigned debounce)
 {
 	void __iomem		*reg;
 	u32			val;
@@ -251,7 +254,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	 * used within _gpio_dbck_enable() is still not initialized at
 	 * that point. Therefore we have to enable dbck here.
 	 */
-	_gpio_dbck_enable(bank);
+	omap_gpio_dbck_enable(bank);
 	if (bank->dbck_enable_mask) {
 		bank->context.debounce = debounce;
 		bank->context.debounce_en = val;
@@ -259,7 +262,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 }
 
 /**
- * _clear_gpio_debounce - clear debounce settings for a gpio
+ * omap_clear_gpio_debounce - clear debounce settings for a gpio
  * @bank: the gpio bank we're acting upon
  * @gpio: the gpio number on this @gpio
  *
@@ -268,7 +271,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
  * time too. The debounce clock will also be disabled when calling this function
  * if this is the only gpio in the bank using debounce.
  */
-static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
+static void omap_clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
 {
 	u32 gpio_bit = GPIO_BIT(bank, gpio);
 
@@ -292,20 +295,20 @@ static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
 	}
 }
 
-static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
+static inline void omap_set_gpio_trigger(struct gpio_bank *bank, int gpio,
 						unsigned trigger)
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = BIT(gpio);
 
-	_gpio_rmw(base, bank->regs->leveldetect0, gpio_bit,
-		  trigger & IRQ_TYPE_LEVEL_LOW);
-	_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
-		  trigger & IRQ_TYPE_LEVEL_HIGH);
-	_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
-		  trigger & IRQ_TYPE_EDGE_RISING);
-	_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
-		  trigger & IRQ_TYPE_EDGE_FALLING);
+	omap_gpio_rmw(base, bank->regs->leveldetect0, gpio_bit,
+		      trigger & IRQ_TYPE_LEVEL_LOW);
+	omap_gpio_rmw(base, bank->regs->leveldetect1, gpio_bit,
+		      trigger & IRQ_TYPE_LEVEL_HIGH);
+	omap_gpio_rmw(base, bank->regs->risingdetect, gpio_bit,
+		      trigger & IRQ_TYPE_EDGE_RISING);
+	omap_gpio_rmw(base, bank->regs->fallingdetect, gpio_bit,
+		      trigger & IRQ_TYPE_EDGE_FALLING);
 
 	bank->context.leveldetect0 =
 			readl_relaxed(bank->base + bank->regs->leveldetect0);
@@ -317,7 +320,7 @@ static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
 			readl_relaxed(bank->base + bank->regs->fallingdetect);
 
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
+		omap_gpio_rmw(base, bank->regs->wkup_en, gpio_bit, trigger != 0);
 		bank->context.wake_en =
 			readl_relaxed(bank->base + bank->regs->wkup_en);
 	}
@@ -353,7 +356,7 @@ exit:
  * This only applies to chips that can't do both rising and falling edge
  * detection at once.  For all other chips, this function is a noop.
  */
-static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
+static void omap_toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 {
 	void __iomem *reg = bank->base;
 	u32 l = 0;
@@ -372,18 +375,18 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 	writel_relaxed(l, reg);
 }
 #else
-static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
+static void omap_toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio) {}
 #endif
 
-static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
-							unsigned trigger)
+static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
+				    unsigned trigger)
 {
 	void __iomem *reg = bank->base;
 	void __iomem *base = bank->base;
 	u32 l = 0;
 
 	if (bank->regs->leveldetect0 && bank->regs->wkup_en) {
-		set_gpio_trigger(bank, gpio, trigger);
+		omap_set_gpio_trigger(bank, gpio, trigger);
 	} else if (bank->regs->irqctrl) {
 		reg += bank->regs->irqctrl;
 
@@ -413,7 +416,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
 			l |= BIT(gpio << 1);
 
 		/* Enable wake-up during idle for dynamic tick */
-		_gpio_rmw(base, bank->regs->wkup_en, BIT(gpio), trigger);
+		omap_gpio_rmw(base, bank->regs->wkup_en, BIT(gpio), trigger);
 		bank->context.wake_en =
 			readl_relaxed(bank->base + bank->regs->wkup_en);
 		writel_relaxed(l, reg);
@@ -421,7 +424,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
 	return 0;
 }
 
-static void _enable_gpio_module(struct gpio_bank *bank, unsigned offset)
+static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
 {
 	if (bank->regs->pinctrl) {
 		void __iomem *reg = bank->base + bank->regs->pinctrl;
@@ -442,7 +445,7 @@ static void _enable_gpio_module(struct gpio_bank *bank, unsigned offset)
 	}
 }
 
-static void _disable_gpio_module(struct gpio_bank *bank, unsigned offset)
+static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 {
 	void __iomem *base = bank->base;
 
@@ -450,7 +453,7 @@ static void _disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 	    !LINE_USED(bank->mod_usage, offset) &&
 	    !LINE_USED(bank->irq_usage, offset)) {
 		/* Disable wake-up during idle for dynamic tick */
-		_gpio_rmw(base, bank->regs->wkup_en, BIT(offset), 0);
+		omap_gpio_rmw(base, bank->regs->wkup_en, BIT(offset), 0);
 		bank->context.wake_en =
 			readl_relaxed(bank->base + bank->regs->wkup_en);
 	}
@@ -467,16 +470,16 @@ static void _disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 	}
 }
 
-static int gpio_is_input(struct gpio_bank *bank, int mask)
+static int omap_gpio_is_input(struct gpio_bank *bank, int mask)
 {
 	void __iomem *reg = bank->base + bank->regs->direction;
 
 	return readl_relaxed(reg) & mask;
 }
 
-static int gpio_irq_type(struct irq_data *d, unsigned type)
+static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
 	unsigned gpio = 0;
 	int retval;
 	unsigned long flags;
@@ -491,7 +494,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 #endif
 
 	if (!gpio)
-		gpio = irq_to_gpio(bank, d->hwirq);
+		gpio = omap_irq_to_gpio(bank, d->hwirq);
 
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
@@ -502,11 +505,11 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	offset = GPIO_INDEX(bank, gpio);
-	retval = _set_gpio_triggering(bank, offset, type);
+	retval = omap_set_gpio_triggering(bank, offset, type);
 	if (!LINE_USED(bank->mod_usage, offset)) {
-		_enable_gpio_module(bank, offset);
-		_set_gpio_direction(bank, offset, 1);
-	} else if (!gpio_is_input(bank, BIT(offset))) {
+		omap_enable_gpio_module(bank, offset);
+		omap_set_gpio_direction(bank, offset, 1);
+	} else if (!omap_gpio_is_input(bank, BIT(offset))) {
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return -EINVAL;
 	}
@@ -522,7 +525,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	return retval;
 }
 
-static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
+static void omap_clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 
@@ -539,12 +542,12 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	readl_relaxed(reg);
 }
 
-static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
+static inline void omap_clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 {
-	_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+	omap_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
-static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
+static u32 omap_get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
 	void __iomem *reg = bank->base;
 	u32 l;
@@ -558,7 +561,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 	return l;
 }
 
-static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
+static void omap_enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 	u32 l;
@@ -580,7 +583,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	writel_relaxed(l, reg);
 }
 
-static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
+static void omap_disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 	u32 l;
@@ -602,12 +605,13 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	writel_relaxed(l, reg);
 }
 
-static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
+static inline void omap_set_gpio_irqenable(struct gpio_bank *bank, int gpio,
+					   int enable)
 {
 	if (enable)
-		_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		omap_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 	else
-		_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
+		omap_disable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 /*
@@ -618,7 +622,7 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  * enabled. When system is suspended, only selected GPIO interrupts need
  * to have wake-up enabled.
  */
-static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
+static int omap_set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
 	u32 gpio_bit = GPIO_BIT(bank, gpio);
 	unsigned long flags;
@@ -641,22 +645,22 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	return 0;
 }
 
-static void _reset_gpio(struct gpio_bank *bank, int gpio)
+static void omap_reset_gpio(struct gpio_bank *bank, int gpio)
 {
-	_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
-	_set_gpio_irqenable(bank, gpio, 0);
-	_clear_gpio_irqstatus(bank, gpio);
-	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
-	_clear_gpio_debounce(bank, gpio);
+	omap_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
+	omap_set_gpio_irqenable(bank, gpio, 0);
+	omap_clear_gpio_irqstatus(bank, gpio);
+	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	omap_clear_gpio_debounce(bank, gpio);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
-static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
+static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 
-	return _set_gpio_wakeup(bank, gpio, enable);
+	return omap_set_gpio_wakeup(bank, gpio, enable);
 }
 
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
@@ -677,8 +681,8 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 * not already been requested.
 	 */
 	if (!LINE_USED(bank->irq_usage, offset)) {
-		_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-		_enable_gpio_module(bank, offset);
+		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+		omap_enable_gpio_module(bank, offset);
 	}
 	bank->mod_usage |= BIT(offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -693,8 +697,8 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->mod_usage &= ~(BIT(offset));
-	_disable_gpio_module(bank, offset);
-	_reset_gpio(bank, bank->chip.base + offset);
+	omap_disable_gpio_module(bank, offset);
+	omap_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
@@ -714,7 +718,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
  * line's interrupt handler has been run, we may miss some nested
  * interrupts.
  */
-static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void omap_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	void __iomem *isr_reg = NULL;
 	u32 isr;
@@ -737,7 +741,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
-		enabled = _get_gpio_irqbank_mask(bank);
+		enabled = omap_get_gpio_irqbank_mask(bank);
 		isr_saved = isr = readl_relaxed(isr_reg) & enabled;
 
 		if (bank->level_mask)
@@ -746,9 +750,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while
 		executing them */
-		_disable_gpio_irqbank(bank, isr_saved & ~level_mask);
-		_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
-		_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
+		omap_disable_gpio_irqbank(bank, isr_saved & ~level_mask);
+		omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
+		omap_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
 
 		/* if there is only edge sensitive GPIO pin interrupts
 		configured, we could unmask GPIO bank interrupt immediately */
@@ -772,7 +776,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * This will be indicated in the bank toggle_mask.
 			 */
 			if (bank->toggle_mask & (BIT(bit)))
-				_toggle_gpio_edge_triggering(bank, bit);
+				omap_toggle_gpio_edge_triggering(bank, bit);
 
 			generic_handle_irq(irq_find_mapping(bank->chip.irqdomain,
 							    bit));
@@ -788,18 +792,18 @@ exit:
 	pm_runtime_put(bank->dev);
 }
 
-static void gpio_irq_shutdown(struct irq_data *d)
+static void omap_gpio_irq_shutdown(struct irq_data *d)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 	unsigned offset = GPIO_INDEX(bank, gpio);
 
 	spin_lock_irqsave(&bank->lock, flags);
 	gpio_unlock_as_irq(&bank->chip, offset);
 	bank->irq_usage &= ~(BIT(offset));
-	_disable_gpio_module(bank, offset);
-	_reset_gpio(bank, gpio);
+	omap_disable_gpio_module(bank, offset);
+	omap_reset_gpio(bank, gpio);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	/*
@@ -810,57 +814,57 @@ static void gpio_irq_shutdown(struct irq_data *d)
 		pm_runtime_put(bank->dev);
 }
 
-static void gpio_ack_irq(struct irq_data *d)
+static void omap_gpio_ack_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 
-	_clear_gpio_irqstatus(bank, gpio);
+	omap_clear_gpio_irqstatus(bank, gpio);
 }
 
-static void gpio_mask_irq(struct irq_data *d)
+static void omap_gpio_mask_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_irqenable(bank, gpio, 0);
-	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
+	omap_set_gpio_irqenable(bank, gpio, 0);
+	omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static void gpio_unmask_irq(struct irq_data *d)
+static void omap_gpio_unmask_irq(struct irq_data *d)
 {
-	struct gpio_bank *bank = _irq_data_get_bank(d);
-	unsigned int gpio = irq_to_gpio(bank, d->hwirq);
+	struct gpio_bank *bank = omap_irq_data_get_bank(d);
+	unsigned int gpio = omap_irq_to_gpio(bank, d->hwirq);
 	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
 	if (trigger)
-		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
+		omap_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
 	if (bank->level_mask & irq_mask) {
-		_set_gpio_irqenable(bank, gpio, 0);
-		_clear_gpio_irqstatus(bank, gpio);
+		omap_set_gpio_irqenable(bank, gpio, 0);
+		omap_clear_gpio_irqstatus(bank, gpio);
 	}
 
-	_set_gpio_irqenable(bank, gpio, 1);
+	omap_set_gpio_irqenable(bank, gpio, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
 static struct irq_chip gpio_irq_chip = {
 	.name		= "GPIO",
-	.irq_shutdown	= gpio_irq_shutdown,
-	.irq_ack	= gpio_ack_irq,
-	.irq_mask	= gpio_mask_irq,
-	.irq_unmask	= gpio_unmask_irq,
-	.irq_set_type	= gpio_irq_type,
-	.irq_set_wake	= gpio_wake_enable,
+	.irq_shutdown	= omap_gpio_irq_shutdown,
+	.irq_ack	= omap_gpio_ack_irq,
+	.irq_mask	= omap_gpio_mask_irq,
+	.irq_unmask	= omap_gpio_unmask_irq,
+	.irq_set_type	= omap_gpio_irq_type,
+	.irq_set_wake	= omap_gpio_wake_enable,
 };
 
 /*---------------------------------------------------------------------*/
@@ -917,7 +921,7 @@ static struct platform_device omap_mpuio_device = {
 	/* could list the /proc/iomem resources */
 };
 
-static inline void mpuio_init(struct gpio_bank *bank)
+static inline void omap_mpuio_init(struct gpio_bank *bank)
 {
 	platform_set_drvdata(&omap_mpuio_device, bank);
 
@@ -927,7 +931,7 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
-static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+static int omap_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
@@ -942,19 +946,19 @@ static int gpio_get_direction(struct gpio_chip *chip, unsigned offset)
 	return dir;
 }
 
-static int gpio_input(struct gpio_chip *chip, unsigned offset)
+static int omap_gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
 	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_direction(bank, offset, 1);
+	omap_set_gpio_direction(bank, offset, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
-static int gpio_get(struct gpio_chip *chip, unsigned offset)
+static int omap_gpio_get(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
 	u32 mask;
@@ -962,13 +966,13 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	bank = container_of(chip, struct gpio_bank, chip);
 	mask = (BIT(offset));
 
-	if (gpio_is_input(bank, mask))
-		return _get_gpio_datain(bank, offset);
+	if (omap_gpio_is_input(bank, mask))
+		return omap_get_gpio_datain(bank, offset);
 	else
-		return _get_gpio_dataout(bank, offset);
+		return omap_get_gpio_dataout(bank, offset);
 }
 
-static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
+static int omap_gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
@@ -976,13 +980,13 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 	bank = container_of(chip, struct gpio_bank, chip);
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->set_dataout(bank, offset, value);
-	_set_gpio_direction(bank, offset, 0);
+	omap_set_gpio_direction(bank, offset, 0);
 	spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
 }
 
-static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
-		unsigned debounce)
+static int omap_gpio_debounce(struct gpio_chip *chip, unsigned offset,
+			      unsigned debounce)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
@@ -990,13 +994,13 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 	bank = container_of(chip, struct gpio_bank, chip);
 
 	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_debounce(bank, offset, debounce);
+	omap2_set_gpio_debounce(bank, offset, debounce);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
 }
 
-static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+static void omap_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
@@ -1037,8 +1041,10 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		return;
 	}
 
-	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqenable_inv);
-	_gpio_rmw(base, bank->regs->irqstatus, l, !bank->regs->irqenable_inv);
+	omap_gpio_rmw(base, bank->regs->irqenable, l,
+		      bank->regs->irqenable_inv);
+	omap_gpio_rmw(base, bank->regs->irqstatus, l,
+		      !bank->regs->irqenable_inv);
 	if (bank->regs->debounce_en)
 		writel_relaxed(0, base + bank->regs->debounce_en);
 
@@ -1072,10 +1078,10 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
 	/* NOTE: No ack required, reading IRQ status clears it. */
 	ct->chip.irq_mask = irq_gc_mask_set_bit;
 	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
-	ct->chip.irq_set_type = gpio_irq_type;
+	ct->chip.irq_set_type = omap_gpio_irq_type;
 
 	if (bank->regs->wkup_en)
-		ct->chip.irq_set_wake = gpio_wake_enable;
+		ct->chip.irq_set_wake = omap_gpio_wake_enable;
 
 	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
@@ -1095,12 +1101,12 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 	 */
 	bank->chip.request = omap_gpio_request;
 	bank->chip.free = omap_gpio_free;
-	bank->chip.get_direction = gpio_get_direction;
-	bank->chip.direction_input = gpio_input;
-	bank->chip.get = gpio_get;
-	bank->chip.direction_output = gpio_output;
-	bank->chip.set_debounce = gpio_debounce;
-	bank->chip.set = gpio_set;
+	bank->chip.get_direction = omap_gpio_get_direction;
+	bank->chip.direction_input = omap_gpio_input;
+	bank->chip.get = omap_gpio_get;
+	bank->chip.direction_output = omap_gpio_output;
+	bank->chip.set_debounce = omap_gpio_debounce;
+	bank->chip.set = omap_gpio_set;
 	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_en)
@@ -1132,7 +1138,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 #endif
 
 	ret = gpiochip_irqchip_add(&bank->chip, &gpio_irq_chip,
-				   irq_base, gpio_irq_handler,
+				   irq_base, omap_gpio_irq_handler,
 				   IRQ_TYPE_NONE);
 
 	if (ret) {
@@ -1142,7 +1148,7 @@ static int omap_gpio_chip_init(struct gpio_bank *bank)
 	}
 
 	gpiochip_set_chained_irqchip(&bank->chip, &gpio_irq_chip,
-				     bank->irq, gpio_irq_handler);
+				     bank->irq, omap_gpio_irq_handler);
 
 	for (j = 0; j < bank->width; j++) {
 		int irq = irq_find_mapping(bank->chip.irqdomain, j);
@@ -1210,9 +1216,9 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	}
 
 	if (bank->regs->set_dataout && bank->regs->clr_dataout)
-		bank->set_dataout = _set_gpio_dataout_reg;
+		bank->set_dataout = omap_set_gpio_dataout_reg;
 	else
-		bank->set_dataout = _set_gpio_dataout_mask;
+		bank->set_dataout = omap_set_gpio_dataout_mask;
 
 	spin_lock_init(&bank->lock);
 
@@ -1231,7 +1237,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(bank->dev);
 
 	if (bank->is_mpuio)
-		mpuio_init(bank);
+		omap_mpuio_init(bank);
 
 	omap_gpio_mod_init(bank);
 
@@ -1313,7 +1319,7 @@ update_gpio_context_count:
 		bank->context_loss_count =
 				bank->get_context_loss_count(bank->dev);
 
-	_gpio_dbck_disable(bank);
+	omap_gpio_dbck_disable(bank);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1344,7 +1350,7 @@ static int omap_gpio_runtime_resume(struct device *dev)
 				bank->get_context_loss_count(bank->dev);
 	}
 
-	_gpio_dbck_enable(bank);
+	omap_gpio_dbck_enable(bank);
 
 	/*
 	 * In ->runtime_suspend(), level-triggered, wakeup-enabled
-- 
2.0.0.rc2

