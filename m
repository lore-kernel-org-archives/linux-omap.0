From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP: GPIO: Fix incorrect gpio_get logic for output GPIOs
Date: Thu,  2 Jul 2009 14:59:09 +0300
Message-ID: <1246535949-12749-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61877 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbZGBMAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jul 2009 08:00:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: juha.yrjola@nokia.com

gpio_get() should return DATAIN register value when the GPIO
is configured as input wheras it should return DATAOUT register
value when the GPIO is configured as output.
Now /sys/kernel/debug/gpio shows proper values for output GPIOs

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/plat-omap/gpio.c |   68 ++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 16d5a3a..d78a187 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -555,14 +555,12 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	__raw_writel(l, reg);
 }
 
-static int __omap_get_gpio_datain(int gpio)
+static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 {
-	struct gpio_bank *bank;
 	void __iomem *reg;
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
-	bank = get_gpio_bank(gpio);
 	reg = bank->base;
 	switch (bank->method) {
 #ifdef CONFIG_ARCH_OMAP1
@@ -603,6 +601,53 @@ static int __omap_get_gpio_datain(int gpio)
 			& (1 << get_gpio_index(gpio))) != 0;
 }
 
+static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
+{
+	void __iomem *reg;
+
+	if (check_gpio(gpio) < 0)
+		return -EINVAL;
+	reg = bank->base;
+
+	switch (bank->method) {
+#ifdef CONFIG_ARCH_OMAP1
+	case METHOD_MPUIO:
+		reg += OMAP_MPUIO_OUTPUT;
+		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP15XX
+	case METHOD_GPIO_1510:
+		reg += OMAP1510_GPIO_DATA_OUTPUT;
+		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP16XX
+	case METHOD_GPIO_1610:
+		reg += OMAP1610_GPIO_DATAOUT;
+		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP730
+	case METHOD_GPIO_730:
+		reg += OMAP730_GPIO_DATA_OUTPUT;
+		break;
+#endif
+#ifdef CONFIG_ARCH_OMAP850
+	case METHOD_GPIO_850:
+		reg += OMAP850_GPIO_DATA_OUTPUT;
+		break;
+#endif
+#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
+		defined(CONFIG_ARCH_OMAP4)
+	case METHOD_GPIO_24XX:
+		reg += OMAP24XX_GPIO_DATAOUT;
+		break;
+#endif
+	default:
+		return -EINVAL;
+	}
+
+	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
+}
+
 #define MOD_REG_BIT(reg, bit_mask, set)	\
 do {	\
 	int l = __raw_readl(base + reg); \
@@ -1438,9 +1483,24 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int gpio_is_input(struct gpio_bank *bank, int mask);
+
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return __omap_get_gpio_datain(chip->base + offset);
+	struct gpio_bank *bank;
+	void __iomem *reg;
+	int gpio;
+	u32 mask;
+
+	gpio = chip->base + offset;
+	bank = get_gpio_bank(gpio);
+	reg = bank->base;
+	mask = 1 << get_gpio_index(gpio);
+
+	if (gpio_is_input(bank, mask))
+		return _get_gpio_datain(bank, gpio);
+	else
+		return _get_gpio_dataout(bank, gpio);
 }
 
 static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
-- 
1.6.0.4

