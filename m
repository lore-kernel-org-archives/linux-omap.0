From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 05/14] GPIO: OMAP: replace get_gpio_index() by using bank width
Date: Fri, 20 May 2011 17:14:48 +0200
Message-ID: <1305904497-26013-6-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55477 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:18 -0400
Received: by mail-ww0-f47.google.com with SMTP id 4so3828093wwk.28
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:17 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

The get_gpio_index() function, littered with cpu_is_* checks can be easily
replaced by using bitops based on the GPIO bank width.  Do so.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |   42 +++++++++++++++++-------------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 1b7896e..a7767a4 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -83,6 +83,9 @@ static struct gpio_bank *gpio_bank;
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
+#define GPIO_INDEX(bank, gpio) (gpio % bank->width)
+#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
+
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 	if (cpu_is_omap15xx()) {
@@ -108,17 +111,6 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
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
@@ -313,7 +305,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 	return (__raw_readl(reg)
-			& (1 << get_gpio_index(gpio))) != 0;
+			& (GPIO_BIT(bank, gpio))) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
@@ -359,7 +351,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	}
 
-	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -396,7 +388,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	else
 		debounce = (debounce / 0x1f) - 1;
 
-	l = 1 << get_gpio_index(gpio);
+	l = GPIO_BIT(bank, gpio);
 
 	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
@@ -648,7 +640,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
-	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
+	retval = _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -710,7 +702,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 {
-	_clear_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
+	_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
@@ -838,7 +830,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio), enable);
+	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio), enable);
 }
 
 /*
@@ -891,10 +883,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
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
@@ -907,7 +899,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
+	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
 
 	return retval;
 }
@@ -1086,7 +1078,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
+			gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
 
 			if (!(isr & 1))
 				continue;
@@ -1137,18 +1129,18 @@ static void gpio_mask_irq(struct irq_data *d)
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
@@ -1352,7 +1344,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	gpio = chip->base + offset;
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
-	mask = 1 << get_gpio_index(gpio);
+	mask = GPIO_BIT(bank, gpio);
 
 	if (gpio_is_input(bank, mask))
 		return _get_gpio_datain(bank, gpio);
-- 
1.7.3.4

