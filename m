From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 09/15] OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
Date: Fri, 22 Apr 2011 16:02:01 -0700
Message-ID: <1303513327-14532-10-git-send-email-khilman@ti.com>
References: <1303513327-14532-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:50096 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755175Ab1DVXAT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 19:00:19 -0400
Received: by mail-pw0-f54.google.com with SMTP id 8so636887pwj.13
        for <linux-omap@vger.kernel.org>; Fri, 22 Apr 2011 16:00:18 -0700 (PDT)
In-Reply-To: <1303513327-14532-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: charu@ti.com

Cleanup IRQ status handling by by passing IRQ status register offsets
via platform data.

Cleans up clearing of GPIO IRQ status and GPIO ISR handler.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 +
 arch/arm/mach-omap1/gpio16xx.c         |    2 +
 arch/arm/mach-omap1/gpio7xx.c          |    2 +
 arch/arm/mach-omap2/gpio.c             |    4 ++
 arch/arm/plat-omap/gpio.c              |   66 ++-----------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 +
 6 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index a622d56..487a087 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -38,6 +38,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
+	.irqstatus	= OMAP_MPUIO_GPIO_INT,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
@@ -75,6 +76,7 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 	.direction	= OMAP1510_GPIO_DIR_CONTROL,
 	.datain		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout	= OMAP1510_GPIO_DATA_OUTPUT,
+	.irqstatus	= OMAP1510_GPIO_INT_STATUS,
 };
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 4ff6ff3..3e52b7f 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -41,6 +41,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 	.direction	= OMAP_MPUIO_IO_CNTL,
 	.datain		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout	= OMAP_MPUIO_OUTPUT,
+	.irqstatus	= OMAP_MPUIO_GPIO_INT,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
@@ -80,6 +81,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 	.clr_dataout	= OMAP1610_GPIO_CLEAR_DATAOUT,
 	.datain		= OMAP1610_GPIO_DATAIN,
 	.dataout	= OMAP1610_GPIO_DATAOUT,
+	.irqstatus	= OMAP1610_GPIO_IRQSTATUS1,
 };
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index efe4dcc..35e8b31 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -43,6 +43,7 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 	.direction	= OMAP_MPUIO_IO_CNTL / 2,
 	.datain		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout	= OMAP_MPUIO_OUTPUT / 2,
+	.irqstatus	= OMAP_MPUIO_GPIO_INT / 2,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
@@ -80,6 +81,7 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 	.direction	= OMAP7XX_GPIO_DIR_CONTROL,
 	.datain		= OMAP7XX_GPIO_DATA_INPUT,
 	.dataout	= OMAP7XX_GPIO_DATA_OUTPUT,
+	.irqstatus	= OMAP7XX_GPIO_INT_STATUS,
 };
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 357e069..7c5e67d 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -76,6 +76,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->dataout = OMAP24XX_GPIO_DATAOUT;
 		pdata->regs->set_dataout = OMAP24XX_GPIO_SETDATAOUT;
 		pdata->regs->clr_dataout = OMAP24XX_GPIO_CLEARDATAOUT;
+		pdata->regs->irqstatus = OMAP24XX_GPIO_IRQSTATUS1;
+		pdata->regs->irqstatus2 = OMAP24XX_GPIO_IRQSTATUS2;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -84,6 +86,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->dataout = OMAP4_GPIO_DATAOUT;
 		pdata->regs->set_dataout = OMAP4_GPIO_SETDATAOUT;
 		pdata->regs->clr_dataout = OMAP4_GPIO_CLEARDATAOUT;
+		pdata->regs->irqstatus = OMAP4_GPIO_IRQSTATUS0;
+		pdata->regs->irqstatus2 = OMAP4_GPIO_IRQSTATUS1;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index cb7f366..4f875cf 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -491,46 +491,14 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 
-	switch (bank->method) {
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
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	case METHOD_GPIO_24XX:
-		reg += OMAP24XX_GPIO_IRQSTATUS1;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	case METHOD_GPIO_44XX:
-		reg += OMAP4_GPIO_IRQSTATUS0;
-		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
-	}
+	reg += bank->regs->irqstatus;
 	__raw_writel(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-	else if (cpu_is_omap44xx())
-		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
+	if (bank->regs->irqstatus2) {
+		reg = bank->base + bank->regs->irqstatus2;
 		__raw_writel(gpio_mask, reg);
+	}
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
@@ -850,31 +818,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	bank = irq_get_handler_data(irq);
-#ifdef CONFIG_ARCH_OMAP1
-	if (bank->method == METHOD_MPUIO)
-		isr_reg = bank->base +
-				OMAP_MPUIO_GPIO_INT / bank->stride;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (bank->method == METHOD_GPIO_1510)
-		isr_reg = bank->base + OMAP1510_GPIO_INT_STATUS;
-#endif
-#if defined(CONFIG_ARCH_OMAP16XX)
-	if (bank->method == METHOD_GPIO_1610)
-		isr_reg = bank->base + OMAP1610_GPIO_IRQSTATUS1;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	if (bank->method == METHOD_GPIO_7XX)
-		isr_reg = bank->base + OMAP7XX_GPIO_INT_STATUS;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-	if (bank->method == METHOD_GPIO_24XX)
-		isr_reg = bank->base + OMAP24XX_GPIO_IRQSTATUS1;
-#endif
-#if defined(CONFIG_ARCH_OMAP4)
-	if (bank->method == METHOD_GPIO_44XX)
-		isr_reg = bank->base + OMAP4_GPIO_IRQSTATUS0;
-#endif
+	isr_reg = bank->base + bank->regs->irqstatus;
 
 	if (WARN_ON(!isr_reg))
 		goto exit;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 268bccd..aedd732 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -180,6 +180,8 @@ struct omap_gpio_reg_offs {
 	u16 dataout;
 	u16 set_dataout;
 	u16 clr_dataout;
+	u16 irqstatus;
+	u16 irqstatus2;
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.4

