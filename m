From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/2] OMAP: GPIO: consolidate direction, input, output, remove #ifdefs
Date: Wed, 20 Apr 2011 17:13:51 -0700
Message-ID: <1303344831-7889-3-git-send-email-khilman@ti.com>
References: <1303344831-7889-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:44563 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752097Ab1DUAME (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Apr 2011 20:12:04 -0400
Received: by mail-pz0-f47.google.com with SMTP id 35so734310pzk.20
        for <linux-omap@vger.kernel.org>; Wed, 20 Apr 2011 17:12:03 -0700 (PDT)
In-Reply-To: <1303344831-7889-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, charu@ti.com

Add register offset fields to GPIO platform_data for registers that
control direction, input and output data.  Using these register
offsets in the common driver allows removal of #ifdefs and greatly
improves readability.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    7 +
 arch/arm/mach-omap1/gpio16xx.c         |   15 ++
 arch/arm/mach-omap1/gpio7xx.c          |   15 ++
 arch/arm/mach-omap2/gpio.c             |   10 ++
 arch/arm/plat-omap/gpio.c              |  225 +++++---------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    8 +
 6 files changed, 87 insertions(+), 193 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 04c4b04..706015b 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -39,6 +39,10 @@ static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
 	.bank_stride		= 1,
+	.direction_reg		= OMAP_MPUIO_IO_CNTL,
+	.set_dataout_reg	= OMAP_MPUIO_OUTPUT,
+	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
+	.dataout_reg		= OMAP_MPUIO_OUTPUT,
 };
 
 static struct __initdata platform_device omap15xx_mpu_gpio = {
@@ -68,6 +72,9 @@ static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_1510,
 	.bank_width		= 16,
+	.direction_reg		= OMAP1510_GPIO_DIR_CONTROL,
+	.datain_reg		= OMAP1510_GPIO_DATA_INPUT,
+	.dataout_reg		= OMAP1510_GPIO_DATA_OUTPUT,
 };
 
 static struct __initdata platform_device omap15xx_gpio = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 5dd0d4c..9573b5e 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -42,6 +42,10 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
 	.bank_stride		= 1,
+	.direction_reg		= OMAP_MPUIO_IO_CNTL,
+	.set_dataout_reg	= OMAP_MPUIO_OUTPUT,
+	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
+	.dataout_reg		= OMAP_MPUIO_OUTPUT,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
@@ -67,10 +71,18 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 	},
 };
 
+#define OMAP16XX_GPIO_REG_OFFSETS \
+	.direction_reg		= OMAP1610_GPIO_DIRECTION, \
+	.set_dataout_reg	= OMAP1610_GPIO_SET_DATAOUT, \
+	.clr_dataout_reg	= OMAP1610_GPIO_CLEAR_DATAOUT, \
+	.datain_reg		= OMAP1610_GPIO_DATAIN, \
+	.dataout_reg		= OMAP1610_GPIO_DATAOUT
+
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	OMAP16XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap16xx_gpio1 = {
@@ -100,6 +112,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	OMAP16XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap16xx_gpio2 = {
@@ -129,6 +142,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	OMAP16XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap16xx_gpio3 = {
@@ -158,6 +172,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	OMAP16XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap16xx_gpio4 = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 1204c8b..79b0af8 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -44,6 +44,10 @@ static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 32,
 	.bank_stride		= 2,
+	.direction_reg		= OMAP_MPUIO_IO_CNTL / 2, \
+	.set_dataout_reg	= OMAP_MPUIO_OUTPUT / 2, \
+	.datain_reg		= OMAP_MPUIO_INPUT_LATCH / 2, \
+	.dataout_reg		= OMAP_MPUIO_OUTPUT / 2
 };
 
 static struct __initdata platform_device omap7xx_mpu_gpio = {
@@ -69,10 +73,16 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 	},
 };
 
+#define OMAP7XX_GPIO_REG_OFFSETS \
+	.direction_reg		= OMAP7XX_GPIO_DIR_CONTROL, \
+	.datain_reg             = OMAP7XX_GPIO_DATA_INPUT, \
+	.dataout_reg            = OMAP7XX_GPIO_DATA_OUTPUT
+
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio1 = {
@@ -102,6 +112,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio2 = {
@@ -131,6 +142,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 64,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio3 = {
@@ -160,6 +172,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 96,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio4 = {
@@ -189,6 +202,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 128,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio5 = {
@@ -218,6 +232,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 160,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	OMAP7XX_GPIO_REG_OFFSETS,
 };
 
 static struct __initdata platform_device omap7xx_gpio6 = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9529842..92855d7 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -65,9 +65,19 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	case 0:
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
+		pdata->direction_reg = OMAP24XX_GPIO_OE;
+		pdata->set_dataout_reg = OMAP24XX_GPIO_SETDATAOUT;
+		pdata->clr_dataout_reg = OMAP24XX_GPIO_CLEARDATAOUT;
+		pdata->datain_reg = OMAP24XX_GPIO_DATAIN;
+		pdata->dataout_reg = OMAP24XX_GPIO_DATAOUT;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
+		pdata->direction_reg = OMAP4_GPIO_OE;
+		pdata->set_dataout_reg = OMAP4_GPIO_SETDATAOUT;
+		pdata->clr_dataout_reg = OMAP4_GPIO_CLEARDATAOUT;
+		pdata->datain_reg = OMAP4_GPIO_DATAIN;
+		pdata->dataout_reg = OMAP4_GPIO_DATAOUT;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index ff70538..dd2927b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -56,6 +56,13 @@ struct gpio_bank {
 	struct device *dev;
 	bool dbck_flag;
 	int stride;
+
+	/* SoC-specific register offsets */
+	u16 direction_reg;
+	u16 set_dataout_reg;
+	u16 clr_dataout_reg;
+	u16 datain_reg;
+	u16 dataout_reg;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -161,41 +168,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	void __iomem *reg = bank->base;
 	u32 l;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL / bank->stride;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DIR_CONTROL;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_DIRECTION;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DIR_CONTROL;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_OE;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_OE;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
-	}
+	reg += bank->direction_reg;
 	l = __raw_readl(reg);
 	if (is_input)
 		l |= 1 << gpio;
@@ -209,113 +182,34 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	void __iomem *reg = bank->base;
 	u32 l = 0;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT / bank->stride;
-		l = __raw_readl(reg);
-		if (enable)
-			l |= 1 << gpio;
-		else
-			l &= ~(1 << gpio);
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DATA_OUTPUT;
-		l = __raw_readl(reg);
-		if (enable)
-			l |= 1 << gpio;
-		else
-			l &= ~(1 << gpio);
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		if (enable)
-			reg += OMAP1610_GPIO_SET_DATAOUT;
-		else
-			reg += OMAP1610_GPIO_CLEAR_DATAOUT;
-		l = 1 << gpio;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DATA_OUTPUT;
-		l = __raw_readl(reg);
-		if (enable)
-			l |= 1 << gpio;
-		else
+	if (enable) {
+		if (bank->set_dataout_reg) {
+			reg += bank->set_dataout_reg;
+		} else {
+			reg += bank->dataout_reg;
+			l = __raw_readl(reg);
+		}
+		l |= 1 << gpio;
+	} else {
+		if (bank->clr_dataout_reg) {
+			reg += bank->clr_dataout_reg;
+			l = 1 << gpio;
+		} else {
+			reg += bank->dataout_reg;
+			l = __raw_readl(reg);
 			l &= ~(1 << gpio);
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		if (enable)
-			reg += OMAP24XX_GPIO_SETDATAOUT;
-		else
-			reg += OMAP24XX_GPIO_CLEARDATAOUT;
-		l = 1 << gpio;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_44XX:
-		if (enable)
-			reg += OMAP4_GPIO_SETDATAOUT;
-		else
-			reg += OMAP4_GPIO_CLEARDATAOUT;
-		l = 1 << gpio;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
+		}
 	}
+
 	__raw_writel(l, reg);
 }
 
 static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg;
-
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
-	reg = bank->base;
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_INPUT_LATCH / bank->stride;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DATA_INPUT;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_DATAIN;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DATA_INPUT;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_DATAIN;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_DATAIN;
-		break;
-#endif
-	default:
-		return -EINVAL;
-	}
-	return (__raw_readl(reg)
+
+	return (__raw_readl(bank->base + bank->datain_reg)
 			& (1 << get_gpio_index(gpio))) != 0;
 }
 
@@ -325,42 +219,8 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
-	reg = bank->base;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT / bank->stride;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DATA_OUTPUT;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_DATAOUT;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DATA_OUTPUT;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_DATAOUT;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_DATAOUT;
-		break;
-#endif
-	default:
-		return -EINVAL;
-	}
+	reg = bank->base + bank->dataout_reg;
 
 	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
 }
@@ -1330,31 +1190,8 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *reg = bank->base + bank->direction_reg;
 
-	switch (bank->method) {
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL / bank->stride;
-		break;
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_DIR_CONTROL;
-		break;
-	case METHOD_GPIO_1610:
-		reg += OMAP1610_GPIO_DIRECTION;
-		break;
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DIR_CONTROL;
-		break;
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_OE;
-		break;
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_OE;
-		break;
-	default:
-		WARN_ONCE(1, "gpio_is_input: incorrect OMAP GPIO method");
-		return -EINVAL;
-	}
 	return __raw_readl(reg) & mask;
 }
 
@@ -1612,7 +1449,9 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank_width = pdata->bank_width;
-
+	if (pdata->direction_reg)
+		bank->direction_reg = pdata->direction_reg;
+	else
 	spin_lock_init(&bank->lock);
 
 	/* Static mapping, never released */
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index ec97e00..de80f7e 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -180,6 +180,14 @@ struct omap_gpio_platform_data {
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+
+	/* SoC-specific register offsets (required) */
+	u16 direction_reg;
+	u16 datain_reg;
+	u16 dataout_reg;
+	/* SoC-specific register offsets (optional) */
+	u16 set_dataout_reg;
+	u16 clr_dataout_reg;
 };
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
-- 
1.7.4

