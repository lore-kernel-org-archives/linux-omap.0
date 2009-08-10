From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] OMAP: GPIO: Fix incorrect gpio_get logic for
	output GPIOs, v3
Date: Mon, 10 Aug 2009 16:01:06 +0300
Message-ID: <20090810130105.GE1938@atomide.com>
References: <20090805141051.1964.74687.stgit@localhost> <20090805141302.1964.67952.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Y5rl02BVI9TCfPar"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51166 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZHJNBP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 09:01:15 -0400
Content-Disposition: inline
In-Reply-To: <20090805141302.1964.67952.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Roger Quadros <ext-roger.quadros@nokia.com>


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here's an update from Roger for this one that builds without
CONFIG_DEBUG_FS.

Tony

--Y5rl02BVI9TCfPar
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="gpio-data-v3.patch"

>From b37c45b8c27c049dc44673e40fd63820fd9a9d91 Mon Sep 17 00:00:00 2001
From: Roger Quadros <ext-roger.quadros@nokia.com>
Date: Wed, 5 Aug 2009 16:53:24 +0300
Subject: [PATCH] OMAP: GPIO: Fix incorrect gpio_get logic for output GPIOs

gpio_get() should return DATAIN register value when the GPIO
is configured as input whereas it should return DATAOUT register
value when the GPIO is configured as output.
Now /sys/kernel/debug/gpio shows proper values for output GPIOs

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 26b387c..9c16ca8 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -476,14 +476,12 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
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
@@ -524,6 +522,53 @@ static int __omap_get_gpio_datain(int gpio)
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
@@ -1350,9 +1395,49 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 	return 0;
 }
 
+static int gpio_is_input(struct gpio_bank *bank, int mask)
+{
+	void __iomem *reg = bank->base;
+
+	switch (bank->method) {
+	case METHOD_MPUIO:
+		reg += OMAP_MPUIO_IO_CNTL;
+		break;
+	case METHOD_GPIO_1510:
+		reg += OMAP1510_GPIO_DIR_CONTROL;
+		break;
+	case METHOD_GPIO_1610:
+		reg += OMAP1610_GPIO_DIRECTION;
+		break;
+	case METHOD_GPIO_730:
+		reg += OMAP730_GPIO_DIR_CONTROL;
+		break;
+	case METHOD_GPIO_850:
+		reg += OMAP850_GPIO_DIR_CONTROL;
+		break;
+	case METHOD_GPIO_24XX:
+		reg += OMAP24XX_GPIO_OE;
+		break;
+	}
+	return __raw_readl(reg) & mask;
+}
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
@@ -1886,34 +1971,6 @@ arch_initcall(omap_gpio_sysinit);
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 
-static int gpio_is_input(struct gpio_bank *bank, int mask)
-{
-	void __iomem *reg = bank->base;
-
-	switch (bank->method) {
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL;
-		break;
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DIR_CONTROL;
-		break;
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_DIRECTION;
-		break;
-	case METHOD_GPIO_730:
-		reg += OMAP730_GPIO_DIR_CONTROL;
-		break;
-	case METHOD_GPIO_850:
-		reg += OMAP850_GPIO_DIR_CONTROL;
-		break;
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_OE;
-		break;
-	}
-	return __raw_readl(reg) & mask;
-}
-
-
 static int dbg_gpio_show(struct seq_file *s, void *unused)
 {
 	unsigned	i, j, gpio;

--Y5rl02BVI9TCfPar--
