From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 18/18] OMAP: GPIO: Remove usage of bank method
Date: Fri, 22 Apr 2011 16:38:32 +0530
Message-ID: <1303470512-19671-19-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60463 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab1DVLE5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Apr 2011 07:04:57 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

Remove usage of bank->method to identify CPU specific OMAP GPIO bank.
Instead identify specific features using flags and accordingly manage.
bank->type MPUIO is common for all OMAP1 SoCs. Use bank->stride to
identify the MPUIO type bank

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    2 -
 arch/arm/mach-omap1/gpio16xx.c         |   24 ++--
 arch/arm/mach-omap1/gpio7xx.c          |    7 -
 arch/arm/mach-omap2/gpio.c             |   11 ++-
 arch/arm/plat-omap/gpio.c              |  228 +++++++++++++------------------
 arch/arm/plat-omap/include/plat/gpio.h |   46 ++++++-
 6 files changed, 155 insertions(+), 163 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index f8303e6..aa08ebf 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -54,7 +54,6 @@ static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
 	.bank_width		= OMAP1510_GPIO_WIDTH,
 	.bank_stride		= 1,
 };
@@ -84,7 +83,6 @@ static struct __initdata resource omap15xx_gpio_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_1510,
 	.bank_width		= OMAP1510_GPIO_WIDTH,
 };
 
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index 37820ba..5f116f6 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -38,6 +38,13 @@
 #define	OMAP1610_GPIO_BOTH_EDGE_SET		0x03
 #define	OMAP1610_GPIO_EDGE_MASK			0x07
 
+#define OMAP16XX_SPECIFIC_SUPPORT\
+	.bank_width		= 16,\
+	.suspend_resume_support	= true,\
+	.features = BIT(OMAP_GPIO_REV_SHOW_FLAG) |\
+			BIT(OMAP_GPIO_DATAOUT_SET_CLR_REGS_FLAG) |\
+			BIT(OMAP_GPIO_DUAL_EDGE_TRIG_FLAG)\
+
 static u16 reg_map[] = {
 	[REV]			= 0x00,
 	[SYS_CFG]		= 0x10,
@@ -73,7 +80,6 @@ static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
 	.bank_width		= OMAP1610_GPIO_WIDTH,
 	.bank_stride		= 1,
 	.suspend_resume_support	= true,
@@ -104,9 +110,7 @@ static struct __initdata resource omap16xx_gpio1_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_1610,
-	.bank_width		= OMAP1610_GPIO_WIDTH,
-	.suspend_resume_support	= true,
+	OMAP16XX_SPECIFIC_SUPPORT,
 };
 
 static struct __initdata platform_device omap16xx_gpio1 = {
@@ -134,9 +138,7 @@ static struct __initdata resource omap16xx_gpio2_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
-	.bank_type		= METHOD_GPIO_1610,
-	.bank_width		= OMAP1610_GPIO_WIDTH,
-	.suspend_resume_support	= true,
+	OMAP16XX_SPECIFIC_SUPPORT,
 };
 
 static struct __initdata platform_device omap16xx_gpio2 = {
@@ -164,9 +166,7 @@ static struct __initdata resource omap16xx_gpio3_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
-	.bank_type		= METHOD_GPIO_1610,
-	.bank_width		= OMAP1610_GPIO_WIDTH,
-	.suspend_resume_support	= true,
+	OMAP16XX_SPECIFIC_SUPPORT,
 };
 
 static struct __initdata platform_device omap16xx_gpio3 = {
@@ -194,9 +194,7 @@ static struct __initdata resource omap16xx_gpio4_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
-	.bank_type		= METHOD_GPIO_1610,
-	.bank_width		= OMAP1610_GPIO_WIDTH,
-	.suspend_resume_support	= true,
+	OMAP16XX_SPECIFIC_SUPPORT,
 };
 
 static struct __initdata platform_device omap16xx_gpio4 = {
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 792156c..28d5917 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -60,7 +60,6 @@ static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 	.bank_stride		= 2,
 };
@@ -90,7 +89,6 @@ static struct __initdata resource omap7xx_gpio1_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
@@ -119,7 +117,6 @@ static struct __initdata resource omap7xx_gpio2_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
@@ -148,7 +145,6 @@ static struct __initdata resource omap7xx_gpio3_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 64,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
@@ -177,7 +173,6 @@ static struct __initdata resource omap7xx_gpio4_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 96,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
@@ -206,7 +201,6 @@ static struct __initdata resource omap7xx_gpio5_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 128,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
@@ -235,7 +229,6 @@ static struct __initdata resource omap7xx_gpio6_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 160,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= OMAP7XX_GPIO_WIDTH,
 };
 
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index f5615a7..7542c56 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -486,6 +486,12 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * i;
 	pdata->gpio_fn = &gpio_fn;
 	pdata->suspend_resume_support = true;
+	pdata->features = BIT(OMAP_GPIO_LEVEL_TRIGGER_FLAG) |
+				BIT(OMAP_GPIO_CLK_GATING_FLAG) |
+				BIT(OMAP_GPIO_REV_SHOW_FLAG) |
+				BIT(OMAP_GPIO_DATAOUT_SET_CLR_REGS_FLAG) |
+				BIT(OMAP_GPIO_DUAL_EDGE_TRIG_FLAG) |
+				BIT(OMAP_GPIO_WA_CLR_DSP_INT_FLAG);
 
 	switch (oh->class->rev) {
 	case 0:
@@ -493,13 +499,14 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 			pdata->non_wakeup_gpios = 0xe203ffc0;
 		else if (i == 1)
 			pdata->non_wakeup_gpios = 0x08700040;
+
+		pdata->features |= BIT(OMAP_GPIO_HANDLE_IRQ_LOSS_LOW_PWR_FLAG);
 		/* FALL THROUGH */
 	case 1:
-		pdata->bank_type = METHOD_GPIO_24XX;
 		reg_map = omap2_gpio_reg_offsets;
 		break;
 	case 2:
-		pdata->bank_type = METHOD_GPIO_44XX;
+		pdata->features |= BIT(OMAP_GPIO_IRQ_WK_ENA_REG_FLAG);
 		reg_map = omap4_gpio_reg_offsets;
 		break;
 	default:
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 7ae9f6f..d52d427 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -42,7 +42,6 @@ struct gpio_bank {
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
-	int method;
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
@@ -57,6 +56,7 @@ struct gpio_bank {
 	bool dbck_flag;
 	int stride;
 	bool suspend_resume_support;
+	u32 features_flag;
 };
 
 static struct omap_gpio_func gpio_fn;
@@ -89,7 +89,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	u32 offset;
 	u32 l;
 
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		offset = OMAP_MPUIO_IO_CNTL / bank->stride;
 		l = gpio_mpuio_read(base, offset);
 	} else {
@@ -102,7 +102,7 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	else
 		l &= ~(1 << gpio);
 
-	if (bank->method == METHOD_MPUIO)
+	if (bank->stride)
 		gpio_mpuio_write(l, base, offset);
 	else
 		gpio_fn.gpio_write(l, base, offset);
@@ -114,8 +114,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	u32 offset;
 	u32 l = 0;
 
-	switch (bank->method) {
-	case METHOD_MPUIO:
+	if (bank->stride) {
 		offset = OMAP_MPUIO_OUTPUT / bank->stride;
 		l = gpio_mpuio_read(base, offset);
 
@@ -125,10 +124,10 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 
 		gpio_mpuio_write(l, base, offset);
-		break;
+		return;
+	}
 
-	case METHOD_GPIO_1510:
-	case METHOD_GPIO_7XX:
+	if (!(bank->features_flag & BIT(OMAP_GPIO_DATAOUT_SET_CLR_REGS_FLAG))) {
 		l = gpio_fn.gpio_read(base, DATAOUT);
 
 		if (enable)
@@ -137,9 +136,7 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 			l &= ~(1 << gpio);
 
 		gpio_fn.gpio_write(l, base, DATAOUT);
-		break;
-
-	default:
+	} else {
 		if (enable)
 			offset = SETDATAOUT;
 		else
@@ -147,7 +144,6 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 
 		l = 1 << gpio;
 		gpio_fn.gpio_write(l, base, offset);
-		break;
 	}
 
 }
@@ -163,7 +159,7 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 
 	base = bank->base;
 
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		offset = OMAP_MPUIO_INPUT_LATCH / bank->stride;
 		ret = gpio_mpuio_read(base, offset);
 	} else {
@@ -185,7 +181,7 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 
 	base = bank->base;
 
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		offset = OMAP_MPUIO_OUTPUT / bank->stride;
 		ret = gpio_mpuio_read(base, offset);
 	} else {
@@ -226,8 +222,7 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 	u32 l = 0;
 	u32 offset;
 
-	switch (bank->method) {
-	case METHOD_MPUIO:
+	if (bank->stride) {
 		offset = OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
 		l = gpio_mpuio_read(base, offset);
 
@@ -237,10 +232,8 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 			l |= 1 << gpio;
 
 		gpio_mpuio_write(l, base, offset);
-		return;
-
-	case METHOD_GPIO_1510:
-	case METHOD_GPIO_7XX:
+	} else if (!(bank->features_flag &
+			BIT(OMAP_GPIO_DUAL_EDGE_TRIG_FLAG))) {
 		l = gpio_fn.gpio_read(base, INT_CTRL);
 
 		if ((l >> gpio) & 1)
@@ -249,10 +242,6 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
 			l |= 1 << gpio;
 
 		gpio_fn.gpio_write(l, base, INT_CTRL);
-		return;
-
-	default:
-		return;
 	}
 }
 
@@ -263,8 +252,7 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 	u32 l = 0;
 	u32 offset;
 
-	switch (bank->method) {
-	case METHOD_MPUIO:
+	if (bank->stride) {
 		offset = OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
 		l = gpio_mpuio_read(base, offset);
 		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
@@ -277,24 +265,32 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 			return -EINVAL;
 
 		gpio_mpuio_write(l, base, offset);
-		break;
 
-	case METHOD_GPIO_1510:
-	case METHOD_GPIO_7XX:
-		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
-			bank->toggle_mask |= 1 << gpio;
+		return ret;
+	}
 
-		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
-		break;
+	if ((!(bank->features_flag & BIT(OMAP_GPIO_DUAL_EDGE_TRIG_FLAG)))
+		&& ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH))
+		bank->toggle_mask |= 1 << gpio;
 
-	case METHOD_GPIO_1610:
-		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
-		break;
+	ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
 
-	case METHOD_GPIO_44XX:
-		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
+	if (!bank->suspend_resume_support)
+		return ret;
 
-		if (likely(!(bank->non_wakeup_gpios & (1 << gpio)))) {
+	if (likely(!(bank->non_wakeup_gpios & (1 << gpio)))) {
+		/*
+		 * GPIO wakeup request can only be generated on edge
+		 * transitions
+		 */
+		if (!(bank->features_flag &
+				BIT(OMAP_GPIO_IRQ_WK_ENA_REG_FLAG))) {
+			if (trigger & IRQ_TYPE_EDGE_BOTH)
+				gpio_fn.gpio_write(1 << gpio, base, SETWKUENA);
+			else
+				gpio_fn.gpio_write(1 << gpio, base,
+								CLEARWKUENA);
+		} else {
 			if (trigger != 0)
 				gpio_fn.gpio_write(1 << gpio, base, IRQWAKEN0);
 			else {
@@ -304,47 +300,23 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 				gpio_fn.gpio_write(val & (~(1 << gpio)), base,
 						IRQWAKEN0);
 			}
-
-			bank->level_mask = gpio_fn.gpio_read(base,
-							LEVELDETECT0);
-			bank->level_mask |= gpio_fn.gpio_read(base,
-							LEVELDETECT1);
 		}
-		break;
-
-	case METHOD_GPIO_24XX:
-		ret = gpio_fn.gpio_set_trigger(base, gpio, trigger);
-
-		if (likely(!(bank->non_wakeup_gpios & (1 << gpio)))) {
-			/*
-			 * GPIO wakeup request can only be generated on edge
-			 * transitions
-			 */
-			if (trigger & IRQ_TYPE_EDGE_BOTH)
-				gpio_fn.gpio_write(1 << gpio, base, SETWKUENA);
-			else
-				gpio_fn.gpio_write(1 << gpio, base,
-							CLEARWKUENA);
-			/*
-			 * Log the edge gpio and manually trigger the IRQ
-			 * after resume if the input level changes
-			 * to avoid irq lost during PER RET/OFF mode
-			 * Applies for omap2 non-wakeup gpio and all omap3 gpios
-			 */
+		/*
+		 * Log the edge gpio and manually trigger the IRQ
+		 * after resume if the input level changes
+		 * to avoid irq lost during PER RET/OFF mode
+		 * Applies for omap2 non-wakeup gpio and all omap3 gpios
+		 */
+		if (bank->features_flag &
+				BIT(OMAP_GPIO_HANDLE_IRQ_LOSS_LOW_PWR_FLAG)) {
 			if (trigger & IRQ_TYPE_EDGE_BOTH)
 				bank->enabled_non_wakeup_gpios |= (1 << gpio);
 			else
 				bank->enabled_non_wakeup_gpios &= ~(1 << gpio);
-
-			bank->level_mask = gpio_fn.gpio_read(base,
-							LEVELDETECT0);
-			bank->level_mask |= gpio_fn.gpio_read(base,
-							LEVELDETECT1);
 		}
-		break;
-	default:
-		ret = -EINVAL;
-		break;
+
+		bank->level_mask = gpio_fn.gpio_read(base, LEVELDETECT0);
+		bank->level_mask |= gpio_fn.gpio_read(base, LEVELDETECT1);
 	}
 
 	return ret;
@@ -359,7 +331,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 	bank = irq_data_get_irq_chip_data(d);
 
-	if ((bank->method == METHOD_MPUIO) && d->irq > IH_MPUIO_BASE)
+	if (bank->stride && d->irq > IH_MPUIO_BASE)
 		gpio = OMAP_MPUIO(d->irq - IH_MPUIO_BASE);
 	else
 		gpio = d->irq - IH_GPIO_BASE;
@@ -371,7 +343,7 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 		return -EINVAL;
 
 	/* OMAP1 allows only only edge triggering */
-	if ((bank->method < METHOD_GPIO_24XX)
+	if ((!(bank->features_flag & BIT(OMAP_GPIO_LEVEL_TRIGGER_FLAG)))
 			&& (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
@@ -389,14 +361,12 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
 
 static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
-	switch (bank->method) {
-	case METHOD_MPUIO:
+	if (bank->stride)
 		/* MPUIO irqstatus is reset by reading the status register,
 		 * so do nothing here */
-		break;
+		return;
 
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
+	if (bank->features_flag & BIT(OMAP_GPIO_WA_CLR_DSP_INT_FLAG)) {
 		/* WA for clearing DSP GPIO interrupts to allow retention */
 		gpio_fn.gpio_write(gpio_mask, bank->base, IRQSTATUS_REG1);
 		/*
@@ -404,16 +374,14 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 		 * to avoid spurious interrupts
 		 */
 		gpio_fn.gpio_read(bank->base, IRQSTATUS_REG1);
-	default:
-		gpio_fn.gpio_write(gpio_mask, bank->base, IRQSTATUS_REG0);
-		/*
-		 * Flush posted write for the irq status
-		 * to avoid spurious interrupts
-		 */
-		gpio_fn.gpio_read(bank->base, IRQSTATUS_REG0);
-		break;
 	}
-	return;
+
+	gpio_fn.gpio_write(gpio_mask, bank->base, IRQSTATUS_REG0);
+	/*
+	 * Flush posted write for the irq status
+	 * to avoid spurious interrupts
+	 */
+	gpio_fn.gpio_read(bank->base, IRQSTATUS_REG0);
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -423,7 +391,7 @@ static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
 
 static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 {
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		u32 offset = OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 		return (~gpio_mpuio_read(bank->base, offset))
 						& MPUIO_GPIO_IRQENA_MASK;
@@ -434,7 +402,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 
 static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enable)
 {
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		u32 offset = OMAP_MPUIO_GPIO_MASKIT / bank->stride;
 		u32 l = gpio_mpuio_read(bank->base, offset);
 
@@ -466,29 +434,27 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 {
 	unsigned long uninitialized_var(flags);
 
-	switch (bank->method) {
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
+	if (bank->suspend_resume_support) {
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			dev_err(bank->dev, "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
-					bank->id * 32 + gpio);
+					bank->id * bank_width + gpio);
 			return -EINVAL;
 		}
-	case METHOD_MPUIO:
-	case METHOD_GPIO_1610:
+
 		spin_lock_irqsave(&bank->lock, flags);
 		if (enable)
 			bank->suspend_wakeup |= (1 << gpio);
 		else
 			bank->suspend_wakeup &= ~(1 << gpio);
 		spin_unlock_irqrestore(&bank->lock, flags);
-		return 0;
-	default:
-		dev_err(bank->dev, "Can't enable GPIO wakeup for method %i\n",
-		       bank->method);
+	} else {
+		dev_err(bank->dev, "Can't enable GPIO%d wakeup\n",
+					bank->id);
 		return -EINVAL;
 	}
+
+	return 0;
 }
 
 static void _reset_gpio(struct gpio_bank *bank, int gpio)
@@ -526,13 +492,13 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
-	if (bank->method == METHOD_GPIO_1510) {
+	if (bank->features_flag & BIT(OMAP_GPIO_CLAIM_PIN_FOR_MPU_FLAG)) {
 		/* Claim the pin for MPU */
 		u32 ctrl = gpio_fn.gpio_read(bank->base, CTRL);
 		gpio_fn.gpio_write(ctrl | (1 << offset), bank->base, CTRL);
 	}
 
-	if (bank->method >= METHOD_GPIO_24XX) {
+	if (bank->features_flag & BIT(OMAP_GPIO_CLK_GATING_FLAG)) {
 		if (!bank->mod_usage) {
 			u32 ctrl = gpio_fn.gpio_read(bank->base, CTRL);
 			/* Module is enabled, clocks are not gated */
@@ -552,17 +518,17 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 
 	spin_lock_irqsave(&bank->lock, flags);
 
-	if ((bank->method == METHOD_GPIO_1610) ||
-			(bank->method == METHOD_GPIO_24XX)) {
-		/* Disable wake-up during idle for dynamic tick */
-		gpio_fn.gpio_write(1 << offset, bank->base, CLEARWKUENA);
-	} else if (bank->method == METHOD_GPIO_44XX) {
-		/* Disable wake-up during idle for dynamic tick */
-		gpio_fn.gpio_write(1 << offset, bank->base, IRQWAKEN0);
+	if (bank->suspend_resume_support) {
+		if (!(bank->features_flag & BIT(OMAP_GPIO_IRQ_WK_ENA_REG_FLAG)))
+			/* Disable wake-up during idle for dynamic tick */
+			gpio_fn.gpio_write(1 << offset, bank->base,
+							CLEARWKUENA);
+		else
+			/* Disable wake-up during idle for dynamic tick */
+			gpio_fn.gpio_write(1 << offset, bank->base, IRQWAKEN0);
 	}
 
-
-	if (bank->method >= METHOD_GPIO_24XX) {
+	if (bank->features_flag & BIT(OMAP_GPIO_CLK_GATING_FLAG)) {
 		bank->mod_usage &= ~(1 << offset);
 
 		if (!bank->mod_usage) {
@@ -602,7 +568,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
 
-		if (bank->method == METHOD_MPUIO)
+		if (bank->stride)
 			isr_val = gpio_mpuio_read(bank->base,
 					OMAP_MPUIO_GPIO_INT / bank->stride);
 		else
@@ -613,10 +579,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 		isr_saved = isr;
 
 		/* Common for all MPUIO banks */
-		if (bank->method == METHOD_MPUIO)
+		if (bank->stride)
 			isr &= 0x0000ffff;
 
-		if (bank->method >= METHOD_GPIO_24XX)
+		if (bank->features_flag & BIT(OMAP_GPIO_LEVEL_TRIGGER_FLAG))
 			level_mask = bank->level_mask & enabled;
 
 		/*
@@ -819,7 +785,7 @@ static inline void mpuio_init(struct gpio_bank *bank)
 {
 	static int mpuio_init_done;
 
-	if (mpuio_init_done || (bank->method != METHOD_MPUIO))
+	if (mpuio_init_done || (!bank->stride))
 		return;
 
 	platform_set_drvdata(&omap_mpuio_device, bank);
@@ -852,7 +818,7 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
 	void __iomem *base = bank->base;
 
-	if (bank->method == METHOD_MPUIO)
+	if (bank->stride)
 		return gpio_mpuio_read(base, OMAP_MPUIO_IO_CNTL / bank->stride)
 				& mask;
 	else
@@ -930,9 +896,7 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
 {
 	u32 rev;
 
-	if ((bank->method == METHOD_GPIO_24XX) ||
-			(bank->method == METHOD_GPIO_44XX) ||
-			(bank->method == METHOD_GPIO_1610))
+	if (bank->features_flag & BIT(OMAP_GPIO_REV_SHOW_FLAG))
 		rev = gpio_fn.gpio_read(bank->base, REV);
 	else
 		return;
@@ -964,7 +928,7 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
 	bank->chip.to_irq = gpio_2irq;
-	if (bank->method == METHOD_MPUIO) {
+	if (bank->stride) {
 		bank->chip.label = "mpuio";
 		if (bank->suspend_resume_support)
 			bank->chip.dev = &omap_mpuio_device.dev;
@@ -982,7 +946,7 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank_width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank->method == METHOD_MPUIO) {
+		if (bank->stride) {
 			if (bank->suspend_resume_support)
 				/*
 				 * REVISIT: assuming only 16xx supports
@@ -1028,11 +992,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	bank->virtual_irq_start = pdata->virtual_irq_start;
 
 	bank->id = pdev->id;
-	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->suspend_resume_support = pdata->suspend_resume_support;
+	bank->features_flag = pdata->features;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank_width = pdata->bank_width;
 
@@ -1072,7 +1036,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	if (bank->method == METHOD_MPUIO)
+	if (bank->stride)
 		__raw_writew(0xffff, bank->base +
 			OMAP_MPUIO_GPIO_MASKIT / bank->stride);
 	else
@@ -1099,7 +1063,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 		gpio_init_done = 1;
 	}
 
-	if ((bank->method != METHOD_MPUIO) && (!show_rev)) {
+	if (!show_rev) {
 		omap_gpio_show_rev(bank);
 		show_rev = 1;
 	}
@@ -1117,10 +1081,10 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 		u32 wake_set;
 		unsigned long flags;
 
-		if ((bank->method <= METHOD_GPIO_1510) ||
-				(bank->method == METHOD_GPIO_7XX)) {
+		if (!bank->suspend_resume_support)
 			break;
-		} else if (bank->method == METHOD_GPIO_44XX) {
+
+		if (bank->features_flag & BIT(OMAP_GPIO_IRQ_WK_ENA_REG_FLAG)) {
 			wake_status = IRQWAKEN0;
 			wake_clear = IRQWAKEN0;
 			wake_set = IRQWAKEN0;
@@ -1150,10 +1114,10 @@ static int omap_gpio_resume(struct sys_device *dev)
 		u32 wake_set;
 		unsigned long flags;
 
-		if ((bank->method <= METHOD_GPIO_1510) ||
-				(bank->method == METHOD_GPIO_7XX)) {
+		if (!bank->suspend_resume_support)
 			break;
-		} else if (bank->method == METHOD_GPIO_44XX) {
+
+		if (bank->features_flag & BIT(OMAP_GPIO_IRQ_WK_ENA_REG_FLAG)) {
 			wake_clear = IRQWAKEN0;
 			wake_set = IRQWAKEN0;
 		} else {
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 87fee8d..af1c636 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -59,12 +59,44 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
-#define METHOD_MPUIO		0
-#define METHOD_GPIO_1510	1
-#define METHOD_GPIO_1610	2
-#define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	5
-#define METHOD_GPIO_44XX	6
+/* OMAP GPIO feature support flags */
+enum omap_gpio_features {
+	/* programmable clk gating at module level. True for OMAP2PLUS */
+	OMAP_GPIO_CLK_GATING_FLAG,
+	/* Revision register is available. True for OMAP16xx and OMAP2PLUS */
+	OMAP_GPIO_REV_SHOW_FLAG,
+	/* Separate IRQ Wakeup Enable Register. True for OMAP4 */
+	OMAP_GPIO_IRQ_WK_ENA_REG_FLAG,
+	/*
+	 * Dataout register is separate for setting and clearing dataout line.
+	 * True for OMAP16XX and OMAP2PLUS.
+	 */
+	OMAP_GPIO_DATAOUT_SET_CLR_REGS_FLAG,
+	/*
+	 * Workaround required for clearing DSP GPIO interrupts to allow
+	 * retention. True for OMAP4
+	 */
+	OMAP_GPIO_WA_CLR_DSP_INT_FLAG,
+	/* OMAP15XX requires claiming GPIO pin for MPU before accessing it */
+	OMAP_GPIO_CLAIM_PIN_FOR_MPU_FLAG,
+	/*
+	 * Log the edge gpio and manually trigger the IRQ after resume if the
+	 * input level changes to avoid irq lost during PER RET/OFF mode. True
+	 * for omap2 non-wakeup gpio and all omap3 gpios
+	 * TODO: Check if this is applicable for OMAP4 as well
+	 */
+	OMAP_GPIO_HANDLE_IRQ_LOSS_LOW_PWR_FLAG,
+	/*
+	 * Level triggering supported. True only for OMAP2PLUS.
+	 * OMAP1 allows only only edge triggering.
+	 */
+	OMAP_GPIO_LEVEL_TRIGGER_FLAG,
+	/*
+	 * Can do both rising and falling edge detection at once.
+	 * True for OMAP16XX and OMAP2PLUS.
+	 */
+	OMAP_GPIO_DUAL_EDGE_TRIG_FLAG,
+};
 
 enum omap_gpio_reg_offsets {
 	/* Common Registers*/
@@ -130,12 +162,12 @@ struct omap_gpio_func {
 struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
 	struct omap_gpio_func *gpio_fn;
-	int bank_type;
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 	bool suspend_resume_support; /* True for OMAP16XX, OMAP2PLUS */
 	u32 non_wakeup_gpios;
+	u32 features;		/* see enum omap_gpio_features */
 };
 
 extern void omap2_gpio_prepare_for_idle(int off_mode);
-- 
1.7.1

