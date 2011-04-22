From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 05/15] OMAP: GPIO: replace get_gpio_index() by using bank width
Date: Fri, 22 Apr 2011 16:01:57 -0700
Message-ID: <1303513327-14532-6-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43306 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754333Ab1DVXAL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:11 -0400
Received: by pvh1 with SMTP id 1so644398pvh.31
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:10 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

The get_gpio_index() function, littered with cpu_is_* checks can be easily
replaced by using bitops based on the GPIO bank width.  Do so.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   42 +++++++++++++++++-------------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6e51a20..98f1304 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -188,6 +188,9 @@ static struct gpio_bank *gpio_bank;
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
+#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
+#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
+
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 	if (cpu_is_omap15xx()) {
@@ -213,17 +216,6 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
 	return NULL;
 }
 
-static inline int get_gpio_index(int gpio)
-{
-	if (cpu_is_omap7xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap24xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap34xx() || cpu_is_omap44xx())
-		return gpio & 0x1f;
-	return gpio & 0x0f;
-}
-
 static inline int gpio_valid(int gpio)
 {
 	if (gpio < 0)
@@ -418,7 +410,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 	return (__raw_readl(reg)
-			& (1 << get_gpio_index(gpio))) != 0;
+			& (GPIO_BIT(bank, gpio))) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
@@ -464,7 +456,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 
-	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -501,7 +493,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	else
 		debounce = (debounce / 0x1f) - 1;
 
-	l = 1 << get_gpio_index(gpio);
+	l = GPIO_BIT(bank, gpio);
 
 	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
@@ -753,7 +745,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
-	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
+	retval = _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -815,7 +807,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 {
-	_clear_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
+	_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
@@ -943,7 +935,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio), enable);
+	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio), enable);
 }
 
 /*
@@ -996,10 +988,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
 static void _reset_gpio(struct gpio_bank *bank, int gpio)
 {
-	_set_gpio_direction(bank, get_gpio_index(gpio), 1);
+	_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
 	_set_gpio_irqenable(bank, gpio, 0);
 	_clear_gpio_irqstatus(bank, gpio);
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 }
 
 /* Use disable_irq_wake() and enable_irq_wake() functions from drivers */
@@ -1012,7 +1004,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
+	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
 
 	return retval;
 }
@@ -1191,7 +1183,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
+			gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
 
 			if (!(isr & 1))
 				continue;
@@ -1242,18 +1234,18 @@ static void gpio_mask_irq(struct irq_data *d)
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
 
 	_set_gpio_irqenable(bank, gpio, 0);
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
 }
 
 static void gpio_unmask_irq(struct irq_data *d)
 {
 	unsigned int gpio = d->irq - IH_GPIO_BASE;
 	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
-	unsigned int irq_mask = 1 << get_gpio_index(gpio);
+	unsigned int irq_mask = GPIO_BIT(bank, gpio);
 	u32 trigger = irqd_get_trigger_type(d);
 
 	if (trigger)
-		_set_gpio_triggering(bank, get_gpio_index(gpio), trigger);
+		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
 
 	/* For level-triggered GPIOs, the clearing must be done after
 	 * the HW source is cleared, thus after the handler has run */
@@ -1457,7 +1449,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	gpio = chip->base + offset;
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
-	mask = 1 << get_gpio_index(gpio);
+	mask = GPIO_BIT(bank, gpio);
 
 	if (gpio_is_input(bank, mask))
 		return _get_gpio_datain(bank, gpio);
-- 
1.7.4

