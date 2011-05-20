From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 09/14] GPIO: OMAP: conslidate enable/disable of GPIO IRQs, remove ifdefs
Date: Fri, 20 May 2011 17:14:52 +0200
Message-ID: <1305904497-26013-10-git-send-email-khilman@ti.com>
References: <1305904497-26013-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:48927 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933413Ab1ETPPf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 May 2011 11:15:35 -0400
Received: by mail-ww0-f46.google.com with SMTP id 28so4022951wwb.3
        for <linux-omap@vger.kernel.org>; Fri, 20 May 2011 08:15:32 -0700 (PDT)
In-Reply-To: <1305904497-26013-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-arm-kernel@lists.infradead.org

Cleanup GPIO IRQ enable/disable handling by removing SoC-specific

Also split enable/disable IRQ into separate functions for better
readability and also facilitate potentially moving to generic irq_chip
in the future.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    4 +
 arch/arm/mach-omap1/gpio16xx.c         |    5 +
 arch/arm/mach-omap1/gpio7xx.c          |    4 +
 arch/arm/mach-omap2/gpio.c             |    6 ++
 arch/arm/plat-omap/include/plat/gpio.h |    5 +
 drivers/gpio/gpio_omap.c               |  129 ++++++++------------------------
 6 files changed, 54 insertions(+), 99 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 487a087..9175624 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -39,6 +39,8 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
 	.irqstatus	= OMAP_MPUIO_GPIO_INT,
+	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
+	.irqenable_inv	= true,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
@@ -77,6 +79,8 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.datain		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
 	.irqstatus	= OMAP1510_GPIO_INT_STATUS,
+	.irqenable	= OMAP1510_GPIO_INT_MASK,
+	.irqenable_inv	= true,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 3e52b7f..a6d4a71 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -42,6 +42,8 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
 	.irqstatus	= OMAP_MPUIO_GPIO_INT,
+	.irqenable	= OMAP_MPUIO_GPIO_MASKIT,
+	.irqenable_inv	= true,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
@@ -82,6 +84,9 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.datain		= OMAP1610_GPIO_DATAIN,
 	.dataout	= OMAP1610_GPIO_DATAOUT,
 	.irqstatus	= OMAP1610_GPIO_IRQSTATUS1,
+	.irqenable	= OMAP1610_GPIO_IRQENABLE1,
+	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
+	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 35e8b31..12bcd9f 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -44,6 +44,8 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout	= OMAP_MPUIO_OUTPUT / 2,
 	.irqstatus	= OMAP_MPUIO_GPIO_INT / 2,
+	.irqenable	= OMAP_MPUIO_GPIO_MASKIT / 2,
+	.irqenable_inv	= true,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
@@ -82,6 +84,8 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 	.datain		= OMAP7XX_GPIO_DATA_INPUT,
 	.dataout	= OMAP7XX_GPIO_DATA_OUTPUT,
 	.irqstatus	= OMAP7XX_GPIO_INT_STATUS,
+	.irqenable	= OMAP7XX_GPIO_INT_MASK,
+	.irqenable_inv	= true,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 7c5e67d..cc26677 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -78,6 +78,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_dataout = OMAP24XX_GPIO_CLEARDATAOUT;
 		pdata->regs->irqstatus = OMAP24XX_GPIO_IRQSTATUS1;
 		pdata->regs->irqstatus2 = OMAP24XX_GPIO_IRQSTATUS2;
+		pdata->regs->irqenable = OMAP24XX_GPIO_IRQENABLE1;
+		pdata->regs->set_irqenable = OMAP24XX_GPIO_SETIRQENABLE1;
+		pdata->regs->clr_irqenable = OMAP24XX_GPIO_CLEARIRQENABLE1;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -88,6 +91,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->clr_dataout = OMAP4_GPIO_CLEARDATAOUT;
 		pdata->regs->irqstatus = OMAP4_GPIO_IRQSTATUS0;
 		pdata->regs->irqstatus2 = OMAP4_GPIO_IRQSTATUS1;
+		pdata->regs->irqenable = OMAP4_GPIO_IRQSTATUSSET0;
+		pdata->regs->set_irqenable = OMAP4_GPIO_IRQSTATUSSET0;
+		pdata->regs->clr_irqenable = OMAP4_GPIO_IRQSTATUSCLR0;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index aedd732..c7e3a56 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -182,6 +182,11 @@ struct omap_gpio_reg_offs {
 	u16 clr_dataout;
 	u16 irqstatus;
 	u16 irqstatus2;
+	u16 irqenable;
+	u16 set_irqenable;
+	u16 clr_irqenable;
+
+	bool irqenable_inv;
 };
 
 struct omap_gpio_platform_data {
diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
index 7b332cb..6bb3785 100644
--- a/drivers/gpio/gpio_omap.c
+++ b/drivers/gpio/gpio_omap.c
@@ -510,129 +510,60 @@ static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
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
+	reg += bank->regs->irqenable;
 	l = __raw_readl(reg);
-	if (inv)
+	if (bank->regs->irqenable_inv)
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
+	if (bank->regs->set_irqenable) {
+		reg += bank->regs->set_irqenable;
+		l = gpio_mask;
+	} else {
+		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
+		if (bank->regs->irqenable_inv)
+			l &= ~gpio_mask;
 		else
 			l |= gpio_mask;
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
+	if (bank->regs->clr_irqenable) {
+		reg += bank->regs->clr_irqenable;
 		l = gpio_mask;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
+	} else {
+		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
-		if (enable)
-			l &= ~(gpio_mask);
-		else
+		if (bank->regs->irqenable_inv)
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
 	}
+
 	__raw_writel(l, reg);
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
 {
-	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio), enable);
+	_enable_gpio_irqbank(bank, GPIO_BIT(bank, gpio));
 }
 
 /*
@@ -838,9 +769,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
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
-- 
1.7.3.4

