From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 07/14] GPIO: OMAP: consolidate direction, input, output, remove #ifdefs
Date: Fri, 20 May 2011 17:14:50 +0200
Message-ID: <1305904497-26013-8-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:42587 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:25 -0400
Received: by mail-ww0-f42.google.com with SMTP id 4so585082wwk.1
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:24 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Add register offset fields to GPIO platform_data for registers.

This patch adds registers that control direction, input and output
data.  Using these register offsets in the common driver allows
removal of #ifdefs and greatly improves readability.

Also create dedicated data out functions: one for banks with dedicated
set/clear registers, and another for banks with a single mask
register.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   14 ++
 arch/arm/mach-omap1/gpio16xx.c         |   19 +++
 arch/arm/mach-omap1/gpio7xx.c          |   19 +++
 arch/arm/mach-omap2/gpio.c             |   16 ++
 arch/arm/plat-omap/include/plat/gpio.h |   10 ++
 drivers/gpio/gpio_omap.c               |  243 ++++++--------------------------
 6 files changed, 121 insertions(+), 200 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 04c4b04..a622d56 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -34,11 +34,18 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
+	.direction	= OMAP_MPUIO_IO_CNTL,
+	.datain		= OMAP_MPUIO_INPUT_LATCH,
+	.dataout	= OMAP_MPUIO_OUTPUT,
+};
+
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
 	.bank_stride		= 1,
+	.regs			= &omap15xx_mpuio_regs,
 };
 
 static struct __initdata platform_device omap15xx_mpu_gpio = {
@@ -64,10 +71,17 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
+	.direction	= OMAP1510_GPIO_DIR_CONTROL,
+	.datain		= OMAP1510_GPIO_DATA_INPUT,
+	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
+};
+
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_1510,
 	.bank_width		= 16,
+	.regs                   = &omap15xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap15xx_gpio = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 5dd0d4c..4ff6ff3 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -37,11 +37,18 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
+	.direction	= OMAP_MPUIO_IO_CNTL,
+	.datain		= OMAP_MPUIO_INPUT_LATCH,
+	.dataout	= OMAP_MPUIO_OUTPUT,
+};
+
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 16,
 	.bank_stride		= 1,
+	.regs                   = &omap16xx_mpuio_regs,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
@@ -67,10 +74,19 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
+	.direction	= OMAP1610_GPIO_DIRECTION,
+	.set_dataout	= OMAP1610_GPIO_SET_DATAOUT,
+	.clr_dataout	= OMAP1610_GPIO_CLEAR_DATAOUT,
+	.datain		= OMAP1610_GPIO_DATAIN,
+	.dataout	= OMAP1610_GPIO_DATAOUT,
+};
+
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	.regs                   = &omap16xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap16xx_gpio1 = {
@@ -100,6 +116,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	.regs                   = &omap16xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap16xx_gpio2 = {
@@ -129,6 +146,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	.regs                   = &omap16xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap16xx_gpio3 = {
@@ -158,6 +176,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
 	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
+	.regs                   = &omap16xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap16xx_gpio4 = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 1204c8b..efe4dcc 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -39,11 +39,18 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
+	.direction	= OMAP_MPUIO_IO_CNTL / 2,
+	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
+	.dataout	= OMAP_MPUIO_OUTPUT / 2,
+};
+
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
 	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 32,
 	.bank_stride		= 2,
+	.regs                   = &omap7xx_mpuio_regs,
 };
 
 static struct __initdata platform_device omap7xx_mpu_gpio = {
@@ -69,10 +76,17 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 	},
 };
 
+static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
+	.direction	= OMAP7XX_GPIO_DIR_CONTROL,
+	.datain		= OMAP7XX_GPIO_DATA_INPUT,
+	.dataout	= OMAP7XX_GPIO_DATA_OUTPUT,
+};
+
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio1 = {
@@ -102,6 +116,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio2 = {
@@ -131,6 +146,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 64,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio3 = {
@@ -160,6 +176,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 96,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio4 = {
@@ -189,6 +206,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 128,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio5 = {
@@ -218,6 +236,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 160,
 	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
+	.regs			= &omap7xx_gpio_regs,
 };
 
 static struct __initdata platform_device omap7xx_gpio6 = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 9529842..357e069 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -61,13 +61,29 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->dbck_flag = dev_attr->dbck_flag;
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
 
+	pdata->regs = kzalloc(sizeof(struct omap_gpio_reg_offs), GFP_KERNEL);
+	if (!pdata) {
+		pr_err("gpio%d: Memory allocation failed\n", id);
+		return -ENOMEM;
+	}
+
 	switch (oh->class->rev) {
 	case 0:
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
+		pdata->regs->direction = OMAP24XX_GPIO_OE;
+		pdata->regs->datain = OMAP24XX_GPIO_DATAIN;
+		pdata->regs->dataout = OMAP24XX_GPIO_DATAOUT;
+		pdata->regs->set_dataout = OMAP24XX_GPIO_SETDATAOUT;
+		pdata->regs->clr_dataout = OMAP24XX_GPIO_CLEARDATAOUT;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
+		pdata->regs->direction = OMAP4_GPIO_OE;
+		pdata->regs->datain = OMAP4_GPIO_DATAIN;
+		pdata->regs->dataout = OMAP4_GPIO_DATAOUT;
+		pdata->regs->set_dataout = OMAP4_GPIO_SETDATAOUT;
+		pdata->regs->clr_dataout = OMAP4_GPIO_CLEARDATAOUT;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index ec97e00..268bccd 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -174,12 +174,22 @@ struct omap_gpio_dev_attr {
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 };
 
+struct omap_gpio_reg_offs {
+	u16 direction;
+	u16 datain;
+	u16 dataout;
+	u16 set_dataout;
+	u16 clr_dataout;
+};
+
 struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
 	int bank_type;
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
+
+	struct omap_gpio_reg_offs *regs;
 };
 
 /* TODO: Analyze removing gpio_bank_count usage from driver code */
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 0fdfb84..b9a3985 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -55,6 +55,10 @@ struct gpio_bank {
 	bool dbck_flag;
 	int stride;
 	u32 width;
+
+	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
+
+	struct omap_gpio_reg_offs *regs;
 };
 
 #ifdef CONFIG_ARCH_OMAP3
@@ -125,41 +129,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
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
+	reg += bank->regs->direction;
 	l = __raw_readl(reg);
 	if (is_input)
 		l |= 1 << gpio;
@@ -168,163 +138,52 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	__raw_writel(l, reg);
 }
 
-static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
+
+/* set data out value using dedicate set/clear register */
+static void _set_gpio_dataout_reg(struct gpio_bank *bank, int gpio, int enable)
 {
 	void __iomem *reg = bank->base;
-	u32 l = 0;
+	u32 l = GPIO_BIT(bank, gpio);
 
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
-			l &= ~(1 << gpio);
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
-	}
+	if (enable)
+		reg += bank->regs->set_dataout;
+	else
+		reg += bank->regs->clr_dataout;
+
+	__raw_writel(l, reg);
+}
+
+/* set data out value using mask register */
+static void _set_gpio_dataout_mask(struct gpio_bank *bank, int gpio, int enable)
+{
+	void __iomem *reg = bank->base + bank->regs->dataout;
+	u32 gpio_bit = GPIO_BIT(bank, gpio);
+	u32 l;
+
+	l = __raw_readl(reg);
+	if (enable)
+		l |= gpio_bit;
+	else
+		l &= ~gpio_bit;
 	__raw_writel(l, reg);
 }
 
 static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg;
+	void __iomem *reg = bank->base + bank->regs->datain;
 
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
-			& (GPIO_BIT(bank, gpio))) != 0;
+
+	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg;
+	void __iomem *reg = bank->base + bank->regs->dataout;
 
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
-	reg = bank->base;
-
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
 
 	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
 }
@@ -1281,31 +1140,8 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *reg = bank->base + bank->regs->direction;
 
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
 
@@ -1334,7 +1170,7 @@ static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
 
 	bank = container_of(chip, struct gpio_bank, chip);
 	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_dataout(bank, offset, value);
+	bank->set_dataout(bank, offset, value);
 	_set_gpio_direction(bank, offset, 0);
 	spin_unlock_irqrestore(&bank->lock, flags);
 	return 0;
@@ -1368,7 +1204,7 @@ static void gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 
 	bank = container_of(chip, struct gpio_bank, chip);
 	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_dataout(bank, offset, value);
+	bank->set_dataout(bank, offset, value);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
@@ -1564,6 +1400,13 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
 
+	bank->regs = pdata->regs;
+
+	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+		bank->set_dataout = _set_gpio_dataout_reg;
+	else
+		bank->set_dataout = _set_gpio_dataout_mask;
+
 	spin_lock_init(&bank->lock);
 
 	/* Static mapping, never released */
-- 
1.7.3.4

