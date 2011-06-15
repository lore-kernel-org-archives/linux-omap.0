From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 11/18] GPIO: OMAP: Clean set_gpio_triggering function
Date: Wed, 15 Jun 2011 09:53:19 +0530
Message-ID: <1308111806-29152-2-git-send-email-tarun.kanti@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46180 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334Ab1FOEWv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 00:22:51 -0400
In-Reply-To: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Charulatha V <charu@ti.com>

Getting rid of ifdefs within the function by adding register offset intctrl
and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 +
 arch/arm/mach-omap1/gpio16xx.c         |    3 +
 arch/arm/mach-omap1/gpio7xx.c          |    2 +
 arch/arm/mach-omap2/gpio.c             |    4 +
 arch/arm/plat-omap/include/plat/gpio.h |    3 +
 drivers/gpio/gpio-omap.c               |  124 +++++++++-----------------------
 6 files changed, 47 insertions(+), 91 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index e8a3bd9..fd2fe8f 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -42,6 +42,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 	.irqstatus	= OMAP_MPUIO_GPIO_INT,
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
 	.irqenable_inv	= true,
+	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
@@ -83,6 +84,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.irqstatus	= OMAP1510_GPIO_INT_STATUS,
 	.irqenable	= OMAP1510_GPIO_INT_MASK,
 	.irqenable_inv	= true,
+	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index d1da7c8..4677ea5 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -45,6 +45,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 	.irqstatus	= OMAP_MPUIO_GPIO_INT,
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
 	.irqenable_inv	= true,
+	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
@@ -93,6 +94,8 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
 	.wkup_clear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
 	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
+	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
+	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index f5d5572..6e439ff 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -47,6 +47,7 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 	.irqstatus	= OMAP_MPUIO_GPIO_INT / 2,
 	.irqenable	= OMAP_MPUIO_GPIO_MASKIT / 2,
 	.irqenable_inv	= true,
+	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE / 2,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
@@ -88,6 +89,7 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 	.irqstatus	= OMAP7XX_GPIO_INT_STATUS,
 	.irqenable	= OMAP7XX_GPIO_INT_MASK,
 	.irqenable_inv	= true,
+	.irqctrl	= OMAP7XX_GPIO_INT_CONTROL,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 0a8f637..3c96855 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -83,6 +83,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		return -ENOMEM;
 	}
 
+	pdata->regs->irqctrl = USHRT_MAX;
+	pdata->regs->edgectrl1 = USHRT_MAX;
+	pdata->regs->edgectrl2 = USHRT_MAX;
+
 	switch (oh->class->rev) {
 	case 0:
 		if (id == 1)
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 32b862a..c0a92ea 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -197,6 +197,9 @@ struct omap_gpio_reg_offs {
 	u16 leveldetect1;
 	u16 risingdetect;
 	u16 fallingdetect;
+	u16 irqctrl;
+	u16 edgectrl1;
+	u16 edgectrl2;
 
 	bool irqenable_inv;
 };
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1551017..7609ce4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -196,35 +196,24 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	__raw_writel(val, reg);
 }
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
+static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
 						int trigger)
 {
 	void __iomem *base = bank->base;
 	u32 gpio_bit = 1 << gpio;
 
-	if (cpu_is_omap44xx()) {
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
-	} else {
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
+	MOD_REG_BIT(bank->regs->leveldetect0, gpio_bit,
 			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
+	MOD_REG_BIT(bank->regs->leveldetect1, gpio_bit,
 			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
+	MOD_REG_BIT(bank->regs->risingdetect, gpio_bit,
 			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
+	MOD_REG_BIT(bank->regs->fallingdetect, gpio_bit,
 			trigger & IRQ_TYPE_EDGE_FALLING);
-	}
+
 	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
 		if (cpu_is_omap44xx()) {
-			MOD_REG_BIT(OMAP4_GPIO_IRQWAKEN0, gpio_bit,
+			MOD_REG_BIT(bank->regs->wkup_status, gpio_bit,
 				trigger != 0);
 		} else {
 			/*
@@ -233,10 +222,10 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 			 */
 			if (trigger & IRQ_TYPE_EDGE_BOTH)
 				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_SETWKUENA);
+					+ bank->regs->wkup_set);
 			else
 				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_CLEARWKUENA);
+					+ bank->regs->wkup_clear);
 		}
 	}
 	/* This part needs to be executed always for OMAP34xx */
@@ -257,7 +246,6 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
 		__raw_readl(bank->base + bank->regs->leveldetect0) |
 		__raw_readl(bank->base + bank->regs->leveldetect1);
 }
-#endif
 
 #ifdef CONFIG_ARCH_OMAP1
 /*
@@ -269,23 +257,10 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 	void __iomem *reg = bank->base;
 	u32 l = 0;
 
-	switch (bank->method) {
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
-		break;
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_CONTROL;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_CONTROL;
-		break;
-#endif
-	default:
+	if (!bank->regs->irqctrl)
 		return;
-	}
+
+	reg += bank->regs->irqctrl;
 
 	l = __raw_readl(reg);
 	if ((l >> gpio) & 1)
@@ -302,24 +277,11 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	void __iomem *reg = bank->base;
 	u32 l = 0;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
-		l = __raw_readl(reg);
-		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
-			bank->toggle_mask |= 1 << gpio;
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	case METHOD_GPIO_1510:
-		reg += OMAP1510_GPIO_INT_CONTROL;
+	if (bank->regs->leveldetect0 && bank->regs->wkup_status) {
+		set_gpio_trigger(bank, gpio, trigger);
+	} else if (bank->regs->irqctrl) {
+		reg += bank->regs->irqctrl;
+
 		l = __raw_readl(reg);
 		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
 			bank->toggle_mask |= 1 << gpio;
@@ -328,15 +290,16 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 		else if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l &= ~(1 << gpio);
 		else
-			goto bad;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
+			return -EINVAL;
+
+		__raw_writel(l, reg);
+
+	} else if (bank->regs->edgectrl1) {
 		if (gpio & 0x08)
-			reg += OMAP1610_GPIO_EDGE_CTRL2;
+			reg += bank->regs->edgectrl2;
 		else
-			reg += OMAP1610_GPIO_EDGE_CTRL1;
+			reg += bank->regs->edgectrl1;
+
 		gpio &= 0x07;
 		l = __raw_readl(reg);
 		l &= ~(3 << (gpio << 1));
@@ -344,40 +307,19 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			l |= 2 << (gpio << 1);
 		if (trigger & IRQ_TYPE_EDGE_FALLING)
 			l |= 1 << (gpio << 1);
+
 		if (trigger)
 			/* Enable wake-up during idle for dynamic tick */
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
+			__raw_writel(1 << gpio, bank->base
+						+ bank->regs->wkup_set);
 		else
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
-		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
-			bank->toggle_mask |= 1 << gpio;
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
-		set_24xx_gpio_triggering(bank, gpio, trigger);
-		return 0;
-#endif
-	default:
-		goto bad;
+			__raw_writel(1 << gpio, bank->base
+						+ bank->regs->wkup_clear);
+
+		__raw_writel(l, reg);
 	}
-	__raw_writel(l, reg);
+
 	return 0;
-bad:
-	return -EINVAL;
 }
 
 static int gpio_irq_type(struct irq_data *d, unsigned type)
-- 
1.6.0.4

