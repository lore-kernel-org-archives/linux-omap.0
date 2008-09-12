From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [RFC] OMAP3: GPIO: Enable debounce clock only when debounce is enabled
Date: Fri, 12 Sep 2008 13:51:38 +0300
Message-ID: <1221216698-22327-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58660 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbYILKuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 06:50:35 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8CAoDVD023997
	for <linux-omap@vger.kernel.org>; Fri, 12 Sep 2008 13:50:32 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch changes gpio "driver" to enable debounce clock for
gpio-bank only when debounce is enabled for some gpio in that bank.

This patch obsoletes "PM: Dynamic GPIO clock handling" patch. Nasty
side effect is that gpios in per domain aren't capable to generate
wake-up if per domain is in sleep state. Anyway keeping dbcks enabled
all the time isn't either good way to workaround this problem. For
this we need to use iopad wake-up. Currently enabling iopad wakeup
mechanism for gpio pads is left for bootloader or kernel (depending
which one does the configuration)

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   26 +++++++++++++++++---------
 1 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0e74103..da164d8 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -152,6 +152,9 @@ struct gpio_bank {
 	u32 level_mask;
 	spinlock_t lock;
 	struct gpio_chip chip;
+#if defined(CONFIG_ARCH_OMAP3)
+	struct clk *dbck
+#endif
 };
 
 #define METHOD_MPUIO		0
@@ -500,11 +503,16 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
 	val = __raw_readl(reg);
 
-	if (enable)
+	if (enable && !(val & l))
 		val |= l;
-	else
+	else if (!enable && val & l)
 		val &= ~l;
+	else
+		return;
 
+#if defined(CONFIG_ARCH_OMAP3)
+	enable ? clk_enable(bank->dbck) : clk_disable(bank->dbck);
+#endif
 	__raw_writel(val, reg);
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce);
@@ -1315,7 +1323,6 @@ static struct clk * gpio5_fck;
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3)
-static struct clk *gpio_fclks[OMAP34XX_NR_GPIOS];
 static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
 #endif
 
@@ -1386,12 +1393,6 @@ static int __init _omap_gpio_init(void)
 				printk(KERN_ERR "Could not get %s\n", clk_name);
 			else
 				clk_enable(gpio_iclks[i]);
-			sprintf(clk_name, "gpio%d_fck", i + 1);
-			gpio_fclks[i] = clk_get(NULL, clk_name);
-			if (IS_ERR(gpio_fclks[i]))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-			else
-				clk_enable(gpio_fclks[i]);
 		}
 	}
 #endif
@@ -1531,6 +1532,13 @@ static int __init _omap_gpio_init(void)
 		}
 		set_irq_chained_handler(bank->irq, gpio_irq_handler);
 		set_irq_data(bank->irq, bank);
+
+#if defined(CONFIG_ARCH_OMAP3)
+		sprintf(clk_name, "gpio%d_fck", i + 1);
+		bank->dbck = clk_get(NULL, clk_name);
+		if (IS_ERR(bank->dbck))
+			printk(KERN_ERR "Could not get %s\n", clk_name);
+#endif
 	}
 
 	/* Enable system clock for GPIO module.
-- 
1.5.5

