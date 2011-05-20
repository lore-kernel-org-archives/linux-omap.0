From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 11/14] GPIO: OMAP: remove useless gpio_valid() & check_gpio() checks
Date: Fri, 20 May 2011 17:14:54 +0200
Message-ID: <1305904497-26013-12-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52957 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:41 -0400
Received: by mail-wy0-f176.google.com with SMTP id 40so3243056wyb.7
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:40 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

These functions are useless.  They are only called in a few places,
and where they are called, the GPIO has already been converted from an
IRQ or masked, so these functions will never fail.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |   45 ---------------------------------------------
 1 files changed, 0 insertions(+), 45 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index d84cc95..8f4ae55 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -90,40 +90,6 @@ int gpio_bank_count;
 #define GPIO_INDEX(bank, gpio) (gpio % bank->width)
 #define GPIO_BIT(bank, gpio) (1 << GPIO_INDEX(bank, gpio))
 
-static inline int gpio_valid(int gpio)
-{
-	if (gpio < 0)
-		return -1;
-	if (cpu_class_is_omap1() && OMAP_GPIO_IS_MPUIO(gpio)) {
-		if (gpio >= OMAP_MAX_GPIO_LINES + 16)
-			return -1;
-		return 0;
-	}
-	if (cpu_is_omap15xx() && gpio < 16)
-		return 0;
-	if ((cpu_is_omap16xx()) && gpio < 64)
-		return 0;
-	if (cpu_is_omap7xx() && gpio < 192)
-		return 0;
-	if (cpu_is_omap2420() && gpio < 128)
-		return 0;
-	if (cpu_is_omap2430() && gpio < 160)
-		return 0;
-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 192)
-		return 0;
-	return -1;
-}
-
-static int check_gpio(int gpio)
-{
-	if (unlikely(gpio_valid(gpio) < 0)) {
-		printk(KERN_ERR "omap-gpio: invalid GPIO %d\n", gpio);
-		dump_stack();
-		return -1;
-	}
-	return 0;
-}
-
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
 	void __iomem *reg = bank->base;
@@ -172,9 +138,6 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 {
 	void __iomem *reg = bank->base + bank->regs->datain;
 
-	if (check_gpio(gpio) < 0)
-		return -EINVAL;
-
 	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
@@ -182,9 +145,6 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 {
 	void __iomem *reg = bank->base + bank->regs->dataout;
 
-	if (check_gpio(gpio) < 0)
-		return -EINVAL;
-
 	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
@@ -461,9 +421,6 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 	else
 		gpio = d->irq - IH_GPIO_BASE;
 
-	if (check_gpio(gpio) < 0)
-		return -EINVAL;
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -629,8 +586,6 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	struct gpio_bank *bank;
 	int retval;
 
-	if (check_gpio(gpio) < 0)
-		return -ENODEV;
 	bank = irq_data_get_irq_chip_data(d);
 	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
 
-- 
1.7.3.4

