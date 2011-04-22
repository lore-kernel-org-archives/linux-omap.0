From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 10/18] OMAP: GPIO: cleanup set wakeup/suspend/resume funcs
Date: Fri, 22 Apr 2011 16:38:24 +0530
Message-ID: <1303470512-19671-11-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38680 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab1DVLEq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:46 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Avoid the usage of cpu_is* checks and CONFIG_ARCH_OMAP* checks
from _set_gpio_wakeup and gpio suspend/resume functions.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/gpio.c |  109 ++++++++++++++-------------------------------
 1 files changed, 33 insertions(+), 76 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 5fe6dbf..df2414d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -30,6 +30,7 @@
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
 
+#define OMAP_GPIO_WAKE_SET_CLR_ALL	0xffffffff
 #define	MPUIO_GPIO_IRQENA_MASK	0xffff
 /*
  * OMAP1510 GPIO registers
@@ -140,10 +141,8 @@ struct gpio_bank {
 	u16 irq;
 	u16 virtual_irq_start;
 	int method;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
-#endif
 	u32 non_wakeup_gpios;
 	u32 enabled_non_wakeup_gpios;
 
@@ -630,18 +629,6 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long uninitialized_var(flags);
 
 	switch (bank->method) {
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
 	case METHOD_GPIO_24XX:
 	case METHOD_GPIO_44XX:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
@@ -650,6 +637,8 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 					(bank - gpio_bank) * 32 + gpio);
 			return -EINVAL;
 		}
+	case METHOD_MPUIO:
+	case METHOD_GPIO_1610:
 		spin_lock_irqsave(&bank->lock, flags);
 		if (enable)
 			bank->suspend_wakeup |= (1 << gpio);
@@ -657,7 +646,6 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 			bank->suspend_wakeup &= ~(1 << gpio);
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
-#endif
 	default:
 		printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
 		       bank->method);
@@ -1347,51 +1335,35 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
-
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		u32 wake_status;
+		u32 wake_clear;
+		u32 wake_set;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
+		if ((bank->method <= METHOD_GPIO_1510) ||
+				(bank->method == METHOD_GPIO_7XX)) {
 			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
-			continue;
+		} else if (bank->method == METHOD_GPIO_44XX) {
+			wake_status = IRQWAKEN0;
+			wake_clear = IRQWAKEN0;
+			wake_set = IRQWAKEN0;
+		} else {
+			wake_status = WAKE_EN;
+			wake_clear = CLEARWKUENA;
+			wake_set = SETWKUENA;
 		}
 
 		spin_lock_irqsave(&bank->lock, flags);
-		bank->saved_wakeup = __raw_readl(wake_status);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->suspend_wakeup, wake_set);
+		bank->saved_wakeup = gpio_fn.gpio_read(bank->base, wake_status);
+		gpio_fn.gpio_write(OMAP_GPIO_WAKE_SET_CLR_ALL, bank->base,
+					wake_clear);
+		gpio_fn.gpio_write(bank->suspend_wakeup, bank->base, wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
@@ -1402,41 +1374,27 @@ static int omap_gpio_resume(struct sys_device *dev)
 {
 	int i;
 
-	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
-		return 0;
-
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		u32 wake_clear;
+		u32 wake_set;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
+		if ((bank->method <= METHOD_GPIO_1510) ||
+				(bank->method == METHOD_GPIO_7XX)) {
 			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
-			continue;
+		} else if (bank->method == METHOD_GPIO_44XX) {
+			wake_clear = IRQWAKEN0;
+			wake_set = IRQWAKEN0;
+		} else {
+			wake_clear = CLEARWKUENA;
+			wake_set = SETWKUENA;
 		}
 
 		spin_lock_irqsave(&bank->lock, flags);
-		__raw_writel(0xffffffff, wake_clear);
-		__raw_writel(bank->saved_wakeup, wake_set);
+		gpio_fn.gpio_write(OMAP_GPIO_WAKE_SET_CLR_ALL, bank->base,
+					wake_clear);
+		gpio_fn.gpio_write(bank->saved_wakeup, bank->base, wake_set);
 		spin_unlock_irqrestore(&bank->lock, flags);
 	}
 
@@ -1454,7 +1412,6 @@ static struct sys_device omap_gpio_device = {
 	.cls		= &omap_gpio_sysclass,
 };
 
-#endif
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
 
-- 
1.7.1

