From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC/PATCH 4/4] arm: omap: remove the unused omap_gpio_set_debounce methods
Date: Wed, 31 Mar 2010 15:27:15 +0300
Message-ID: <1270038435-28106-5-git-send-email-felipe.balbi@nokia.com>
References: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31690 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932791Ab0CaM2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Mar 2010 08:28:11 -0400
In-Reply-To: <1270038435-28106-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

nobody uses that anymore, so remove and expect drivers
to use the gpiolib implementation.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   73 ---------------------------------------------
 1 files changed, 0 insertions(+), 73 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index f9cd64c..5945be6 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -644,79 +644,6 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio, int value)
 	__raw_writel(val, reg);
 }
 
-void omap_set_gpio_debounce(int gpio, int enable)
-{
-	struct gpio_bank *bank;
-	void __iomem *reg;
-	unsigned long flags;
-	u32 val, l = 1 << get_gpio_index(gpio);
-
-	if (cpu_class_is_omap1())
-		return;
-
-	bank = get_gpio_bank(gpio);
-	reg = bank->base;
-
-	if (cpu_is_omap44xx())
-		reg += OMAP4_GPIO_DEBOUNCENABLE;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
-
-	if (!(bank->mod_usage & l)) {
-		printk(KERN_ERR "GPIO %d not requested\n", gpio);
-		return;
-	}
-
-	spin_lock_irqsave(&bank->lock, flags);
-	val = __raw_readl(reg);
-
-	if (enable && !(val & l))
-		val |= l;
-	else if (!enable && (val & l))
-		val &= ~l;
-	else
-		goto done;
-
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		if (enable)
-			clk_enable(bank->dbck);
-		else
-			clk_disable(bank->dbck);
-	}
-
-	__raw_writel(val, reg);
-done:
-	spin_unlock_irqrestore(&bank->lock, flags);
-}
-EXPORT_SYMBOL(omap_set_gpio_debounce);
-
-void omap_set_gpio_debounce_time(int gpio, int enc_time)
-{
-	struct gpio_bank *bank;
-	void __iomem *reg;
-
-	if (cpu_class_is_omap1())
-		return;
-
-	bank = get_gpio_bank(gpio);
-	reg = bank->base;
-
-	if (!bank->mod_usage) {
-		printk(KERN_ERR "GPIO not requested\n");
-		return;
-	}
-
-	enc_time &= 0xff;
-
-	if (cpu_is_omap44xx())
-		reg += OMAP4_GPIO_DEBOUNCINGTIME;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
-
-	__raw_writel(enc_time, reg);
-}
-EXPORT_SYMBOL(omap_set_gpio_debounce_time);
-
 #ifdef CONFIG_ARCH_OMAP2PLUS
 static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 						int trigger)
-- 
1.7.0.rc0.33.g7c3932

