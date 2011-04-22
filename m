From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 13/15] OMAP: GPIO: cleanup _set_gpio_wakeup(), remove ifdefs
Date: Fri, 22 Apr 2011 16:02:05 -0700
Message-ID: <1303513327-14532-14-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47063 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755509Ab1DVXA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:29 -0400
Received: by pve37 with SMTP id 37so627944pve.21
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:28 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Make _set_gpio_wakeup() generic by removing ifdefs.  Code for the
various SoCs/bank-methods was already the same, except for the
non-wakeup GPIO checking.  But that flag is set on a per-SoC basis, so
can be used for all SoCs.

While here, use pr_err() and remove GPIO bank calculation assumption
based on subtracting bank pointers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/gpio.c |   49 +++++++++++++-------------------------------
 1 files changed, 15 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index a025b7a..82afed8 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -535,42 +535,23 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
  */
 static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
-	unsigned long uninitialized_var(flags);
+	u32 gpio_bit = GPIO_BIT(bank, gpio);
+	unsigned long flags;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_MPUIO:
-	case METHOD_GPIO_1610:
-		spin_lock_irqsave(&bank->lock, flags);
-		if (enable)
-			bank->suspend_wakeup |= (1 << gpio);
-		else
-			bank->suspend_wakeup &= ~(1 << gpio);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
-		if (bank->non_wakeup_gpios & (1 << gpio)) {
-			printk(KERN_ERR "Unable to modify wakeup on "
-					"non-wakeup GPIO%d\n",
-			       (bank - gpio_bank) * bank->width + gpio);
-			return -EINVAL;
-		}
-		spin_lock_irqsave(&bank->lock, flags);
-		if (enable)
-			bank->suspend_wakeup |= (1 << gpio);
-		else
-			bank->suspend_wakeup &= ~(1 << gpio);
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-#endif
-	default:
-		printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
-		       bank->method);
+	if (bank->non_wakeup_gpios & gpio_bit) {
+		pr_err("Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
 		return -EINVAL;
 	}
+
+	spin_lock_irqsave(&bank->lock, flags);
+	if (enable)
+		bank->suspend_wakeup |= gpio_bit;
+	else
+		bank->suspend_wakeup &= ~gpio_bit;
+
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
 }
 
 static void _reset_gpio(struct gpio_bank *bank, int gpio)
@@ -589,7 +570,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	int retval;
 
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
+	retval = _set_gpio_wakeup(bank, gpio, enable);
 
 	return retval;
 }
-- 
1.7.4

