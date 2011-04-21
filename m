From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 8/9] OMAP: GPIO: conslidate enable/disable of GPIO IRQs, remove ifdefs
Date: Thu, 21 Apr 2011 13:35:26 -0700
Message-ID: <1303418127-4310-9-git-send-email-khilman@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:55127 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754394Ab1DUUdq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:46 -0400
Received: by mail-px0-f170.google.com with SMTP id 19so54131pxi.1
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:46 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com

Cleanup GPIO IRQ enable/disable handling by removing SoC-specific

Also split enable/disable IRQ into separate functions for better
readability and also facilitate potentially moving to generic irq_chip
in the future.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    4 +
 arch/arm/mach-omap1/gpio16xx.c         |    7 ++-
 arch/arm/mach-omap1/gpio7xx.c          |    6 +-
 arch/arm/mach-omap2/gpio.c             |    6 ++
 arch/arm/plat-omap/gpio.c              |  140 +++++++++----------------------
 arch/arm/plat-omap/include/plat/gpio.h |    6 ++
 6 files changed, 68 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 16e5890..64a5d53 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -44,6 +44,8 @@ static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT,
 	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT,
+	.irqenable_reg		= OMAP_MPUIO_GPIO_MASKIT,
+	.irqenable_inv		= true,
 };
 
 static struct __initdata platform_device omap15xx_mpu_gpio = {
@@ -77,6 +79,8 @@ static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.datain_reg		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout_reg		= OMAP1510_GPIO_DATA_OUTPUT,
 	.irqstatus_reg          = OMAP1510_GPIO_INT_STATUS,
+	.irqenable_reg		= OMAP1510_GPIO_INT_MASK,
+	.irqenable_inv		= true,
 };
 
 static struct __initdata platform_device omap15xx_gpio = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 700687c..864ddd1 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -47,6 +47,8 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT,
 	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT,
+	.irqenable_reg		= OMAP_MPUIO_GPIO_MASKIT,
+	.irqenable_inv		= true,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
@@ -78,7 +80,10 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 	.clr_dataout_reg	= OMAP1610_GPIO_CLEAR_DATAOUT, \
 	.datain_reg		= OMAP1610_GPIO_DATAIN, \
 	.dataout_reg		= OMAP1610_GPIO_DATAOUT, \
-        .irqstatus_reg          = OMAP1610_GPIO_IRQSTATUS1
+	.irqstatus_reg          = OMAP1610_GPIO_IRQSTATUS1, \
+	.irqenable_reg          = OMAP1610_GPIO_IRQENABLE1, \
+	.set_irqenable_reg      = OMAP1610_GPIO_SET_IRQENABLE1, \
+	.clr_irqenable_reg      = OMAP1610_GPIO_CLEAR_IRQENABLE1
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 61c1580..cff4ab8 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -49,6 +49,8 @@ static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT / 2,
 	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT / 2,
+	.irqenable_reg		= OMAP_MPUIO_GPIO_MASKIT / 2,
+	.irqenable_inv		= true,
 };
 
 static struct __initdata platform_device omap7xx_mpu_gpio = {
@@ -78,7 +80,9 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 	.direction_reg		= OMAP7XX_GPIO_DIR_CONTROL, \
 	.datain_reg             = OMAP7XX_GPIO_DATA_INPUT, \
 	.dataout_reg            = OMAP7XX_GPIO_DATA_OUTPUT, \
-        .irqstatus_reg          = OMAP7XX_GPIO_INT_STATUS
+	.irqstatus_reg          = OMAP7XX_GPIO_INT_STATUS, \
+	.irqenable_reg          = OMAP7XX_GPIO_INT_MASK, \
+	.irqenable_inv          = true
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 712b858..538ed92 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -72,6 +72,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->clr_dataout_reg = OMAP24XX_GPIO_CLEARDATAOUT;
 		pdata->irqstatus_reg = OMAP24XX_GPIO_IRQSTATUS1;
 		pdata->irqstatus2_reg = OMAP24XX_GPIO_IRQSTATUS2;
+		pdata->irqenable_reg = OMAP24XX_GPIO_IRQENABLE1;
+		pdata->set_irqenable_reg = OMAP24XX_GPIO_SETIRQENABLE1;
+		pdata->clr_irqenable_reg = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -82,6 +85,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->clr_dataout_reg = OMAP4_GPIO_CLEARDATAOUT;
 		pdata->irqstatus_reg = OMAP4_GPIO_IRQSTATUS0;
 		pdata->irqstatus2_reg = OMAP4_GPIO_IRQSTATUS1;
+		pdata->irqenable_reg = OMAP4_GPIO_IRQSTATUSSET0;
+		pdata->set_irqenable_reg = OMAP4_GPIO_IRQSTATUSSET0;
+		pdata->clr_irqenable_reg = OMAP4_GPIO_IRQSTATUSCLR0;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index b431eb1..8d80bf0 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -64,10 +64,16 @@ struct gpio_bank {
 	u16 dataout_reg;
 	u16 irqstatus_reg;
 	u16 irqstatus2_reg;
+	u16 irqenable_reg;
 
 	/* SoC-specific register offsets (optional) */
 	u16 set_dataout_reg;
 	u16 clr_dataout_reg;
+	u16 set_irqenable_reg;
+	u16 clr_irqenable_reg;
+
+	/* SoC-specific register options */
+	bool irqenable_inv;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -550,129 +556,61 @@ static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
 	void __iomem *reg = bank->base;
-	int inv = 0;
 	u32 l;
 	u32 mask = (1 << bank->width) - 1;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
-		inv = 1;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_MASK;
-		inv = 1;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_IRQENABLE1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
-		inv = 1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_IRQENABLE1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_IRQSTATUSSET0;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return 0;
-	}
-
+	reg += bank->irqenable_reg;
 	l = __raw_readl(reg);
-	if (inv)
+	if (bank->irqenable_inv)
 		l = ~l;
 	l &= mask;
 	return l;
 }
 
-static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)
+static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 	u32 l;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT / bank->stride;
+	if (bank->set_irqenable_reg) {
+		reg += bank->set_irqenable_reg;
+		l = gpio_mask;
+	} else {
+		reg += bank->irqenable_reg;
 		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
+		if (bank->irqenable_inv)
+			l &= ~gpio_mask;
 		else
 			l |= gpio_mask;
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
+	}
+
+	__raw_writel(l, reg);
+}
+
+static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
+{
+	void __iomem *reg = bank->base;
+	u32 l;
+
+	if (bank->clr_irqenable_reg) {
+		reg += bank->clr_irqenable_reg;
 		l = gpio_mask;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
+	} else {
+		reg += bank->irqenable_reg;
 		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
-		else
+		if (bank->irqenable_inv)
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
 		else
-			reg += OMAP4_GPIO_IRQSTATUSCLR0;
-		l = gpio_mask;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
+			l &= ~gpio_mask;
+		
 	}
+
 	__raw_writel(l, reg);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio), enable);
+	_enable_gpio_irqbank(bank, 1 << get_gpio_index(gpio));
 }
 
 /*
@@ -878,9 +816,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while
 		executing them */
-		_enable_gpio_irqbank(bank, isr_saved & ~level_mask, 0);
+		_disable_gpio_irqbank(bank, isr_saved & ~level_mask);
 		_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
-		_enable_gpio_irqbank(bank, isr_saved & ~level_mask, 1);
+		_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
 
 		/* if there is only edge sensitive GPIO pin interrupts
 		configured, we could unmask GPIO bank interrupt immediately */
@@ -1390,6 +1328,10 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->set_dataout_reg = pdata->dataout_reg;
 	bank->irqstatus_reg = pdata->irqstatus_reg;
 	bank->irqstatus2_reg = pdata->irqstatus2_reg;
+	bank->irqenable_reg = pdata->irqenable_reg;
+	bank->irqenable_inv = pdata->irqenable_inv;
+	bank->set_irqenable_reg = pdata->set_irqenable_reg;
+	bank->clr_irqenable_reg = pdata->clr_irqenable_reg;
 
 	spin_lock_init(&bank->lock);
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 6113183..184a853 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -187,10 +187,16 @@ struct omap_gpio_platform_data {
 	u16 dataout_reg;
 	u16 irqstatus_reg;
 	u16 irqstatus2_reg;
+	u16 irqenable_reg;
 
 	/* SoC-specific register offsets (optional) */
 	u16 set_dataout_reg;
 	u16 clr_dataout_reg;
+	u16 set_irqenable_reg;
+	u16 clr_irqenable_reg;
+
+	/* SoC-specific register options */
+	bool irqenable_inv;
 };
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
-- 
1.7.4

