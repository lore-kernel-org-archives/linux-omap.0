From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 07/18] OMAP: GPIO: cleanup set/get IRQ, clr irqstatus funcs
Date: Fri, 22 Apr 2011 16:38:21 +0530
Message-ID: <1303470512-19671-8-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755188Ab1DVLFG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:05:06 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Remove the usage of CONFIG_ARCH* checks in the following
functions of the GPIO driver and move SoC specific code
to SoC specific files.
	_enable_gpio_irqbank
	_get_gpio_irqbank_mask
	_clear_gpio_irqbank

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   21 ++++
 arch/arm/mach-omap1/gpio16xx.c         |   16 +++
 arch/arm/mach-omap1/gpio7xx.c          |   20 ++++
 arch/arm/mach-omap2/gpio.c             |   26 +++++
 arch/arm/plat-omap/gpio.c              |  187 ++++++--------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 +
 6 files changed, 116 insertions(+), 156 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 3c64e69..7a7a123 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -27,6 +27,7 @@
 #define OMAP1510_GPIO_BANK_CNT		2
 #define OMAP1510_NON_MPUIO_GPIO_VALID	((OMAP1510_GPIO_BANK_CNT - 1) *\
 						OMAP1510_GPIO_WIDTH)
+#define OMAP1510_GPIO_IRQENA_MASK	0xffff
 
 static u16 reg_map[] = {
 	[DATAIN]		= 0x00,
@@ -144,12 +145,32 @@ static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
 	return 0;
 }
 
+static u32 gpio_is_irqena(void __iomem *base)
+{
+	return (~gpio_read(base, IRQENABLE1))
+				& OMAP1510_GPIO_IRQENA_MASK;
+}
+
+static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
+{
+	u32 l = gpio_read(base, IRQENABLE1);
+
+	if (enable)
+		l &= ~(gpio_mask);
+	else
+		l |= gpio_mask;
+
+	gpio_write(l, base, IRQENABLE1);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
 	.gpio_set_trigger = gpio_set_trigger,
+	.gpio_is_irqena = gpio_is_irqena,
+	.gpio_enable_irq = gpio_enable_irq,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 6b4afa2..f05e0c7 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -30,6 +30,7 @@
 #define OMAP1610_GPIO_BANK_CNT		5
 #define OMAP1610_NON_MPUIO_GPIO_VALID	((OMAP1610_GPIO_BANK_CNT - 1) *\
 						OMAP1610_GPIO_WIDTH)
+#define OMAP1610_GPIO_IRQENA_MASK	0xffff
 
 #define	OMAP1610_GPIO_USE_EDGE_CTRL2_REG	0x08
 #define	OMAP1610_GPIO_SET_FALLING_EDGE		0x01
@@ -272,12 +273,27 @@ static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
 	return 0;
 }
 
+static u32 gpio_is_irqena(void __iomem *base)
+{
+	return gpio_read(base, IRQENABLE1) & OMAP1610_GPIO_IRQENA_MASK;
+}
+
+static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
+{
+	if (enable)
+		gpio_write(gpio_mask, base, SETIRQENA1);
+	else
+		gpio_write(gpio_mask, base, CLEARIRQENA1);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
 	.gpio_set_trigger = gpio_set_trigger,
+	.gpio_is_irqena = gpio_is_irqena,
+	.gpio_enable_irq = gpio_enable_irq,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 599067d..1103efc 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -34,6 +34,7 @@
 #define OMAP7XX_GPIO_BANK_CNT		7
 #define OMAP7XX_NON_MPUIO_GPIO_VALID	((OMAP7XX_GPIO_BANK_CNT - 1) *\
 						OMAP7XX_GPIO_WIDTH)
+#define OMAP7XX_GPIO_IRQENA_MASK	0xffffffff
 
 static u16 reg_map[] = {
 	[DATAIN]		= 0x00,
@@ -307,12 +308,31 @@ static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
 	return 0;
 }
 
+static u32 gpio_is_irqena(void __iomem *base)
+{
+	return (~gpio_read(base, IRQENABLE1)) & OMAP7XX_GPIO_IRQENA_MASK;
+}
+
+static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
+{
+	u32 l = gpio_read(base, IRQENABLE1);
+
+	if (enable)
+		l &= ~(gpio_mask);
+	else
+		l |= gpio_mask;
+
+	gpio_write(l, base, IRQENABLE1);
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
 	.gpio_set_trigger = gpio_set_trigger,
+	.gpio_is_irqena = gpio_is_irqena,
+	.gpio_enable_irq = gpio_enable_irq,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index ff3ea7b..25fe8a4 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -26,6 +26,7 @@
 #include <plat/omap_device.h>
 
 #define OMAP2_GPIO_INDEX_MASK		0x1f
+#define OMAP2_GPIO_IRQENA_MASK		0xffffffff
 
 int bank_width;
 static u16 *reg_map;
@@ -147,12 +148,37 @@ static int gpio_set_trigger(void __iomem *base, int gpio, int trigger)
 	return 0;
 }
 
+static u32 gpio_is_irqena(void __iomem *base)
+{
+	if (cpu_is_omap44xx())
+		return gpio_read(base, IRQSTATUSSET0) & OMAP2_GPIO_IRQENA_MASK;
+	else
+		return gpio_read(base, IRQENABLE1) & OMAP2_GPIO_IRQENA_MASK;
+}
+
+static void gpio_enable_irq(void __iomem *base, int gpio_mask, int enable)
+{
+	if (cpu_is_omap44xx()) {
+		if (enable)
+			return gpio_write(gpio_mask, base, IRQSTATUSSET0);
+		else
+			return gpio_write(gpio_mask, base, IRQSTATUSCLR0);
+	} else {
+		if (enable)
+			return gpio_write(gpio_mask, base, SETIRQENA1);
+		else
+			return gpio_write(gpio_mask, base, CLEARIRQENA1);
+	}
+}
+
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
 	.gpio_read = gpio_read,
 	.gpio_write = gpio_write,
 	.gpio_set_trigger = gpio_set_trigger,
+	.gpio_is_irqena = gpio_is_irqena,
+	.gpio_enable_irq = gpio_enable_irq,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 938cc4d..115916d 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -30,6 +30,7 @@
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
 
+#define	MPUIO_GPIO_IRQENA_MASK	0xffff
 /*
  * OMAP1510 GPIO registers
  */
@@ -551,58 +552,31 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
-	void __iomem *reg = bank->base;
-
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		/* MPUIO irqstatus is reset by reading the status register,
 		 * so do nothing here */
-		return;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_STATUS;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_IRQSTATUS1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_STATUS;
 		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+
 	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_IRQSTATUS1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
 	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_IRQSTATUS0;
-		break;
-#endif
+		/* WA for clearing DSP GPIO interrupts to allow retention */
+		gpio_fn.gpio_write(gpio_mask, bank->base, IRQSTATUS_REG1);
+		/*
+		 * Flush posted write for the irq status
+		 * to avoid spurious interrupts
+		 */
+		gpio_fn.gpio_read(bank->base, IRQSTATUS_REG1);
 	default:
-		WARN_ON(1);
-		return;
-	}
-	__raw_writel(gpio_mask, reg);
-
-	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-	else if (cpu_is_omap44xx())
-		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		__raw_writel(gpio_mask, reg);
-
-	/* Flush posted write for the irq status to avoid spurious interrupts */
-	__raw_readl(reg);
+		gpio_fn.gpio_write(gpio_mask, bank->base, IRQSTATUS_REG0);
+		/*
+		 * Flush posted write for the irq status
+		 * to avoid spurious interrupts
+		 */
+		gpio_fn.gpio_read(bank->base, IRQSTATUS_REG0);
+		break;
 	}
+	return;
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -612,131 +586,30 @@ static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
-	void __iomem *reg = bank->base;
-	int inv = 0;
-	u32 l;
-	u32 mask;
-
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
-		mask = 0xffff;
-		inv = 1;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_MASK;
-		mask = 0xffff;
-		inv = 1;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_IRQENABLE1;
-		mask = 0xffff;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
-		mask = 0xffffffff;
-		inv = 1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_IRQENABLE1;
-		mask = 0xffffffff;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_IRQSTATUSSET0;
-		mask = 0xffffffff;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return 0;
+	if (bank->method == METHOD_MPUIO) {
+		u32 offset = OMAP_MPUIO_GPIO_MASKIT / bank->stride;
+		return (~gpio_mpuio_read(bank->base, offset))
+						& MPUIO_GPIO_IRQENA_MASK;
 	}
 
-	l = __raw_readl(reg);
-	if (inv)
-		l = ~l;
-	l &= mask;
-	return l;
+	return gpio_fn.gpio_is_irqena(bank->base);
 }
 
 static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)
 {
-	void __iomem *reg = bank->base;
-	u32 l;
+	if (bank->method == METHOD_MPUIO) {
+		u32 offset = OMAP_MPUIO_GPIO_MASKIT / bank->stride;
+		u32 l = gpio_mpuio_read(bank->base, offset);
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
-		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
-		else
-			l |= gpio_mask;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_MASK;
-		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
-		else
-			l |= gpio_mask;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		if (enable)
-			reg += OMAP1610_GPIO_SET_IRQENABLE1;
-		else
-			reg += OMAP1610_GPIO_CLEAR_IRQENABLE1;
-		l = gpio_mask;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
-		l = __raw_readl(reg);
 		if (enable)
 			l &= ~(gpio_mask);
 		else
 			l |= gpio_mask;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		if (enable)
-			reg += OMAP24XX_GPIO_SETIRQENABLE1;
-		else
-			reg += OMAP24XX_GPIO_CLEARIRQENABLE1;
-		l = gpio_mask;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_44XX:
-		if (enable)
-			reg += OMAP4_GPIO_IRQSTATUSSET0;
-		else
-			reg += OMAP4_GPIO_IRQSTATUSCLR0;
-		l = gpio_mask;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
+
+		gpio_mpuio_write(l, bank->base, offset);
+	} else {
+		gpio_fn.gpio_enable_irq(bank->base, gpio_mask, enable);
 	}
-	__raw_writel(l, reg);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
@@ -1468,6 +1341,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_fn.gpio_read = pdata->gpio_fn->gpio_read;
 		gpio_fn.gpio_write = pdata->gpio_fn->gpio_write;
 		gpio_fn.gpio_set_trigger = pdata->gpio_fn->gpio_set_trigger;
+		gpio_fn.gpio_is_irqena = pdata->gpio_fn->gpio_is_irqena;
+		gpio_fn.gpio_enable_irq = pdata->gpio_fn->gpio_enable_irq;
 	}
 
 	id = pdev->id;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index b7c10bd..c21f2e9 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -114,6 +114,8 @@ struct omap_gpio_func {
 	u32 (*gpio_read)(void __iomem *base, int reg);
 	void (*gpio_write)(u32 val, void __iomem *base, int reg);
 	int (*gpio_set_trigger)(void __iomem *base, int gpio, int trigger);
+	u32 (*gpio_is_irqena)(void __iomem *base);
+	void (*gpio_enable_irq)(void __iomem *base, int gpio_mask, int enable);
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.1

