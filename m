From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/11] ARM: OMAP: make legacy gpio request/free calls
	superfluous
Date: Fri, 28 Nov 2008 17:10:43 -0800
Message-ID: <20081129011043.12337.2751.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58305 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465AbYK2BKm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:42 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@nokia.com>

From: Jarkko Nikula <jarkko.nikula@nokia.com>

Clean up OMAP GPIO request/free functions

 - Rename and declare static OMAP specific GPIO request/free functions
 - Register them into gpiolib as chip-specific hooks
 - Add omap_request_gpio/omap_free_gpio wrappers for existing code not
   converted yet to use gpiolib

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
[ dbrownell@users.sourceforge.net: remove needless check_gpio() calls ]
Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c              |   43 ++++++++------------------------
 arch/arm/plat-omap/include/mach/gpio.h |   12 +++++++--
 2 files changed, 21 insertions(+), 34 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index a6dbef4..e8aae2a 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -886,26 +886,17 @@ static int gpio_wake_enable(unsigned int irq, unsigned int enable)
 	return retval;
 }
 
-int omap_request_gpio(int gpio)
+static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_bank *bank;
+	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
-	int status;
-
-	if (check_gpio(gpio) < 0)
-		return -EINVAL;
-
-	status = gpio_request(gpio, NULL);
-	if (status < 0)
-		return status;
 
-	bank = get_gpio_bank(gpio);
 	spin_lock_irqsave(&bank->lock, flags);
 
 	/* Set trigger to none. You need to enable the desired trigger with
 	 * request_irq() or set_irq_type().
 	 */
-	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
+	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
 #ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510) {
@@ -913,7 +904,7 @@ int omap_request_gpio(int gpio)
 
 		/* Claim the pin for MPU */
 		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
-		__raw_writel(__raw_readl(reg) | (1 << get_gpio_index(gpio)), reg);
+		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
 #endif
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -921,39 +912,28 @@ int omap_request_gpio(int gpio)
 	return 0;
 }
 
-void omap_free_gpio(int gpio)
+static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
-	struct gpio_bank *bank;
+	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
 	unsigned long flags;
 
-	if (check_gpio(gpio) < 0)
-		return;
-	bank = get_gpio_bank(gpio);
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
@@ -1458,6 +1438,8 @@ static int __init _omap_gpio_init(void)
 		/* REVISIT eventually switch from OMAP-specific gpio structs
 		 * over to the generic ones
 		 */
+		bank->chip.request = omap_gpio_request;
+		bank->chip.free = omap_gpio_free;
 		bank->chip.direction_input = gpio_input;
 		bank->chip.get = gpio_get;
 		bank->chip.direction_output = gpio_output;
@@ -1726,9 +1708,6 @@ static int __init omap_gpio_sysinit(void)
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

