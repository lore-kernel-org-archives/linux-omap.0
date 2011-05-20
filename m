From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 12/14] GPIO: OMAP: cleanup _set_gpio_wakeup(), remove ifdefs
Date: Fri, 20 May 2011 17:14:55 +0200
Message-ID: <1305904497-26013-13-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:36093 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:47 -0400
Received: by mail-wy0-f174.google.com with SMTP id 21so4119290wya.33
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:43 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Make _set_gpio_wakeup() generic by removing ifdefs.  Code for the
various SoCs/bank-methods was already the same, except for the
non-wakeup GPIO checking.  But that flag is set on a per-SoC basis, so
can be used for all SoCs.

While here, use dev_err() and remove GPIO bank calculation assumption
based on subtracting bank pointers.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/gpio/gpio_omap.c |   50 ++++++++++++++-------------------------------
 1 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 8f4ae55..b5e2e94 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -533,42 +533,24 @@ static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int ena
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
+		dev_err(bank->dev, 
+			"Unable to modify wakeup on non-wakeup GPIO%d\n", gpio);
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
@@ -587,7 +569,7 @@ static int gpio_wake_enable(struct irq_data *d, unsigned int enable)
 	int retval;
 
 	bank = irq_data_get_irq_chip_data(d);
-	retval = _set_gpio_wakeup(bank, GPIO_INDEX(bank, gpio), enable);
+	retval = _set_gpio_wakeup(bank, gpio, enable);
 
 	return retval;
 }
-- 
1.7.3.4

