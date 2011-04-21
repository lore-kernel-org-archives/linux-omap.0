From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 7/9] OMAP: GPIO: consolidate IRQ status handling, remove #ifdefs
Date: Thu, 21 Apr 2011 13:35:25 -0700
Message-ID: <1303418127-4310-8-git-send-email-khilman@ti.com>
References: <1303418127-4310-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46103 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754379Ab1DUUdp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Apr 2011 16:33:45 -0400
Received: by pzk26 with SMTP id 26so45429pzk.10
        for <linux-omap@vger.kernel.org>; Thu, 21 Apr 2011 13:33:44 -0700 (PDT)
In-Reply-To: <1303418127-4310-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: charu@ti.com

Cleanup IRQ status handling by by passing IRQ status register offsets
via platform data.

Cleans up clearing of GPIO IRQ status and GPIO ISR handler.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 +
 arch/arm/mach-omap1/gpio16xx.c         |    4 +-
 arch/arm/mach-omap1/gpio7xx.c          |    4 +-
 arch/arm/mach-omap2/gpio.c             |    4 ++
 arch/arm/plat-omap/gpio.c              |   70 ++++---------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    2 +
 6 files changed, 23 insertions(+), 63 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 706015b..16e5890 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -43,6 +43,7 @@ static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.set_dataout_reg	= OMAP_MPUIO_OUTPUT,
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT,
+	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT,
 };
 
 static struct __initdata platform_device omap15xx_mpu_gpio = {
@@ -75,6 +76,7 @@ static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.direction_reg		= OMAP1510_GPIO_DIR_CONTROL,
 	.datain_reg		= OMAP1510_GPIO_DATA_INPUT,
 	.dataout_reg		= OMAP1510_GPIO_DATA_OUTPUT,
+	.irqstatus_reg          = OMAP1510_GPIO_INT_STATUS,
 };
 
 static struct __initdata platform_device omap15xx_gpio = {
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 9573b5e..700687c 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -46,6 +46,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.set_dataout_reg	= OMAP_MPUIO_OUTPUT,
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT,
+	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT,
 };
 
 static struct __initdata platform_device omap16xx_mpu_gpio = {
@@ -76,7 +77,8 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 	.set_dataout_reg	= OMAP1610_GPIO_SET_DATAOUT, \
 	.clr_dataout_reg	= OMAP1610_GPIO_CLEAR_DATAOUT, \
 	.datain_reg		= OMAP1610_GPIO_DATAIN, \
-	.dataout_reg		= OMAP1610_GPIO_DATAOUT
+	.dataout_reg		= OMAP1610_GPIO_DATAOUT, \
+        .irqstatus_reg          = OMAP1610_GPIO_IRQSTATUS1
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 59c6e3dbf..61c1580 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -48,6 +48,7 @@ static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.set_dataout_reg	= OMAP_MPUIO_OUTPUT / 2,
 	.datain_reg		= OMAP_MPUIO_INPUT_LATCH / 2,
 	.dataout_reg		= OMAP_MPUIO_OUTPUT / 2,
+	.irqstatus_reg		= OMAP_MPUIO_GPIO_INT / 2,
 };
 
 static struct __initdata platform_device omap7xx_mpu_gpio = {
@@ -76,7 +77,8 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 #define OMAP7XX_GPIO_REG_OFFSETS \
 	.direction_reg		= OMAP7XX_GPIO_DIR_CONTROL, \
 	.datain_reg             = OMAP7XX_GPIO_DATA_INPUT, \
-	.dataout_reg            = OMAP7XX_GPIO_DATA_OUTPUT
+	.dataout_reg            = OMAP7XX_GPIO_DATA_OUTPUT, \
+        .irqstatus_reg          = OMAP7XX_GPIO_INT_STATUS
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index cc63188..712b858 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -70,6 +70,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->dataout_reg = OMAP24XX_GPIO_DATAOUT;
 		pdata->set_dataout_reg = OMAP24XX_GPIO_SETDATAOUT;
 		pdata->clr_dataout_reg = OMAP24XX_GPIO_CLEARDATAOUT;
+		pdata->irqstatus_reg = OMAP24XX_GPIO_IRQSTATUS1;
+		pdata->irqstatus2_reg = OMAP24XX_GPIO_IRQSTATUS2;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
@@ -78,6 +80,8 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->dataout_reg = OMAP4_GPIO_DATAOUT;
 		pdata->set_dataout_reg = OMAP4_GPIO_SETDATAOUT;
 		pdata->clr_dataout_reg = OMAP4_GPIO_CLEARDATAOUT;
+		pdata->irqstatus_reg = OMAP4_GPIO_IRQSTATUS0;
+		pdata->irqstatus2_reg = OMAP4_GPIO_IRQSTATUS1;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 8f94488..b431eb1 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -62,6 +62,8 @@ struct gpio_bank {
 	u16 direction_reg;
 	u16 datain_reg;
 	u16 dataout_reg;
+	u16 irqstatus_reg;
+	u16 irqstatus2_reg;
 
 	/* SoC-specific register offsets (optional) */
 	u16 set_dataout_reg;
@@ -527,46 +529,14 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
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
+	reg += bank->irqstatus_reg;
 	__raw_writel(gpio_mask, reg);
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-	else if (cpu_is_omap44xx())
-		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
+	if (bank->irqstatus2_reg) {
+		reg = bank->base + bank->irqstatus2_reg;
 		__raw_writel(gpio_mask, reg);
+	}
 
 	/* Flush posted write for the irq status to avoid spurious interrupts */
 	__raw_readl(reg);
@@ -886,31 +856,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
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
+	isr_reg = bank->base + bank->irqstatus_reg;
 
 	if (WARN_ON(!isr_reg))
 		goto exit;
@@ -1442,6 +1388,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->dataout_reg = pdata->dataout_reg;
 	bank->set_dataout_reg = pdata->dataout_reg;
 	bank->set_dataout_reg = pdata->dataout_reg;
+	bank->irqstatus_reg = pdata->irqstatus_reg;
+	bank->irqstatus2_reg = pdata->irqstatus2_reg;
 
 	spin_lock_init(&bank->lock);
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index bbf9a5f..6113183 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -185,6 +185,8 @@ struct omap_gpio_platform_data {
 	u16 direction_reg;
 	u16 datain_reg;
 	u16 dataout_reg;
+	u16 irqstatus_reg;
+	u16 irqstatus2_reg;
 
 	/* SoC-specific register offsets (optional) */
 	u16 set_dataout_reg;
-- 
1.7.4

