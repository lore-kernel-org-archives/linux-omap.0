From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [RFC 01/21] ARM: OMAP: Clean-up OMAP GPIO request/free functions
Date: Wed, 29 Oct 2008 13:36:09 +0200
Message-ID: <1225280189-6559-2-git-send-email-jarkko.nikula@nokia.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59792 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYJ2LhG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 07:37:06 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9TBac0O016561
	for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 13:37:03 +0200
In-Reply-To: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

- Rename and declare static OMAP specific GPIO request/free functions
- Register them into gpiolib as chip-specific hooks
- Add omap_request_gpio/omap_free_gpio wrappers for existing code not
  converted yet to use gpiolib

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/gpio.c              |   41 +++++++++++---------------------
 arch/arm/plat-omap/include/mach/gpio.h |   12 +++++++-
 2 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e9954a4..1e2204e 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -885,26 +885,21 @@ static int gpio_wake_enable(unsigned int irq, unsigned int enable)
 	return retval;
 }
 
-int omap_request_gpio(int gpio)
+static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
-	int status;
 
-	if (check_gpio(gpio) < 0)
+	bank = container_of(chip, struct gpio_bank, chip);
+	if (check_gpio(bank->chip.base + offset) < 0)
 		return -EINVAL;
 
-	status = gpio_request(gpio, NULL);
-	if (status < 0)
-		return status;
-
-	bank = get_gpio_bank(gpio);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
 	 */
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510) {
@@ -912,7 +907,7 @@ int omap_request_gpio(int gpio)
 
 		/* Claim the pin for MPU */
 		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
-		__raw_writel(__raw_readl(reg) | (1 << get_gpio_index(gpio)), reg);
+		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -920,39 +915,32 @@ int omap_request_gpio(int gpio)
 	return 0;
 }
 
-void omap_free_gpio(int gpio)
+static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
 	unsigned long flags;
 
-	if (check_gpio(gpio) < 0)
+	bank = container_of(chip, struct gpio_bank, chip);
+	if (check_gpio(bank->chip.base + offset) < 0)
 		return;
-	bank = get_gpio_bank(gpio);
+
 	spin_lock_irqsave(&bank->lock, flags);
-	if (unlikely(!gpiochip_is_requested(&bank->chip,
-				get_gpio_index(gpio)))) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		printk(KERN_ERR "omap-gpio: GPIO %d wasn't reserved!\n", gpio);
-		dump_stack();
-		return;
-	}
 #ifdef CONFIG_ARCH_OMAP16XX
 	if (bank->method == METHOD_GPIO_1610) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-		__raw_writel(1 << get_gpio_index(gpio), reg);
+		__raw_writel(1 << offset, reg);
 	}
 #endif
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 	if (bank->method == METHOD_GPIO_24XX) {
 		/* Disable wake-up during idle for dynamic tick */
 		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-		__raw_writel(1 << get_gpio_index(gpio), reg);
+		__raw_writel(1 << offset, reg);
 	}
 #endif
-	_reset_gpio(bank, gpio);
+	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
-	gpio_free(gpio);
 }
 
 /*
@@ -1457,6 +1445,8 @@ static int __init _omap_gpio_init(void)
 		/* REVISIT eventually switch from OMAP-specific gpio structs
 		 * over to the generic ones
 		 */
+		bank->chip.request = omap_gpio_request;
+		bank->chip.free = omap_gpio_free;
 		bank->chip.direction_input = gpio_input;
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
@@ -1725,9 +1715,6 @@ static int __init omap_gpio_sysinit(void)
 	return ret;
 }
 
-EXPORT_SYMBOL(omap_request_gpio);
-EXPORT_SYMBOL(omap_free_gpio);
-
 arch_initcall(omap_gpio_sysinit);
 
 
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index 552ad0c..04e68e8 100644
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -71,8 +71,6 @@
 				 IH_GPIO_BASE + (nr))
 
 extern int omap_gpio_init(void);	/* Call from board init only */
-extern int omap_request_gpio(int gpio);
-extern void omap_free_gpio(int gpio);
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
@@ -89,6 +87,16 @@ extern void omap_set_gpio_debounce_time(int gpio, int enable);
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
+static inline int omap_request_gpio(int gpio)
+{
+	return gpio_request(gpio, "FIXME");
+}
+
+static inline void omap_free_gpio(int gpio)
+{
+	gpio_free(gpio);
+}
+
 static inline int gpio_get_value(unsigned gpio)
 {
 	return __gpio_get_value(gpio);
-- 
1.5.6.5

