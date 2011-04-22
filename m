From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH 03/18] OMAP: GPIO: Move gpio_get_index() to mach-omap
Date: Fri, 22 Apr 2011 07:59:42 -0700
Message-ID: <87wrimz601.fsf@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
	<1303470512-19671-4-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38913 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753275Ab1DVO7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 10:59:46 -0400
Received: by mail-pv0-f173.google.com with SMTP id 3so452097pvg.18
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 07:59:45 -0700 (PDT)
In-Reply-To: <1303470512-19671-4-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Fri, 22 Apr 2011 16:38:17 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, paul@pwsan.com

Charulatha V <charu@ti.com> writes:

> gpio_get_index() uses cpu_is* checks. Move this function from
> plat-omap/gpio.c to SoC specific GPIO files in mach-omap*/ and
> use pdata to pass the function pointer.
>
> Signed-off-by: Charulatha V <charu@ti.com>

This one isn't really needed.  The index should be calculated by using
the bank width.

Below is a patch doing the same thing but using bitops and avoiding the
need for pdata function pointers.

Kevin


>From 070938fc5f3d001a6c669bca4eac8114aafbe0b2 Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 22 Apr 2011 07:59:07 -0700
Subject: [PATCH] OMAP: GPIO: replace get_gpio_index() by using bank width

The get_gpio_index() function, littered with cpu_is_* checks can be easily
replaced by using bitops based on the GPIO bank width.  Do so.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   42 +++++++++++++++++-------------------------
 1 files changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 57530c0..3211477 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -102,6 +102,9 @@ static struct gpio_bank *gpio_bank;
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
 int gpio_bank_count;
 
+#define GPIO_INDEX(bank, gpio) (gpio % (bank->width - 1))
+#define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
+
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
 	if (cpu_is_omap15xx()) {
@@ -127,17 +130,6 @@ static inline struct gpio_bank *get_gpio_bank(int gpio)
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
@@ -219,7 +211,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 
 	return (__raw_readl(bank->base + bank->datain_reg)
-			& (1 << get_gpio_index(gpio))) != 0;
+		& GPIO_BIT(bank, gpio)) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
@@ -231,7 +223,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 
 	reg = bank->base + bank->dataout_reg;
 
-	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -268,7 +260,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	else
 		debounce = (debounce / 0x1f) - 1;
 
-	l = 1 << get_gpio_index(gpio);
+	l = GPIO_BIT(bank, gpio);
 
 	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
@@ -520,7 +512,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	bank = irq_data_get_irq_chip_data(d);
 	spin_lock_irqsave(&bank->lock, flags);
-	retval = _set_gpio_triggering(bank, get_gpio_index(gpio), type);
+	retval = _set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), type);
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -550,7 +542,7 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 {
-	_clear_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
+	_clear_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
@@ -610,7 +602,7 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
+	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 /*
@@ -663,10 +655,10 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 
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
@@ -679,7 +671,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	if (check_gpio(gpio) < 0)
 		return -ENODEV;
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, get_gpio_index(gpio), enable);
+	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
 
 	return retval;
 }
@@ -834,7 +826,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		gpio_irq = bank->virtual_irq_start;
 		for (; isr != 0; isr >>= 1, gpio_irq++) {
-			gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
+			gpio_index = GPIO_INDEX(bank, irq_to_gpio(gpio_irq));
 
 			if (!(isr & 1))
 				continue;
@@ -885,18 +877,18 @@ static void gpio_mask_irq(struct irq_data *d)
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
@@ -1038,7 +1030,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	gpio = chip->base + offset;
 	bank = get_gpio_bank(gpio);
 	reg = bank->base;
-	mask = 1 << get_gpio_index(gpio);
+	mask = GPIO_BIT(bank, gpio);
 
 	if (gpio_is_input(bank, mask))
 		return _get_gpio_datain(bank, gpio);
-- 
1.7.4

