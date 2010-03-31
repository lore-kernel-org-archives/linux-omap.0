From: Charulatha V <charu@ti.com>
Subject: [PATCH 8/8] OMAP:GPIO:Common platform code for all OMAPs
Date: Wed, 31 Mar 2010 17:53:59 +0530
Message-ID: <1270038239-1090-9-git-send-email-charu@ti.com>
References: <1270038239-1090-1-git-send-email-charu@ti.com>
 <1270038239-1090-2-git-send-email-charu@ti.com>
 <1270038239-1090-3-git-send-email-charu@ti.com>
 <1270038239-1090-4-git-send-email-charu@ti.com>
 <1270038239-1090-5-git-send-email-charu@ti.com>
 <1270038239-1090-6-git-send-email-charu@ti.com>
 <1270038239-1090-7-git-send-email-charu@ti.com>
 <1270038239-1090-8-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53196 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757410Ab0CaMTd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Mar 2010 08:19:33 -0400
In-Reply-To: <1270038239-1090-8-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, Charulatha V <charu@ti.com>

This patch adds support for common GPIO code in plat-omap layer
to perform most common operations for all OMAPs. This is handled
by getting function pointers and register offsets from
architecture specific files in mach-omap layer.

The common APIs are handled by plat-omap/gpio.c file. Specific function,
eg., get_gpio_bank, set_gpio_triggering, etc., are handled differently
in different architectures. Hence they are handled in mach-omap layer.

This patch also adds support for passing platform_data for OMAP2PLUS.
For OMAP1, it still supports the old way of doing omap_gpio_init which
would be handled in mach-omap1 layer.

This patch is in prepartion for HWMOD FW adaptation for GPIO module.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    2 +-
 arch/arm/mach-omap2/Makefile           |    7 +-
 arch/arm/mach-omap2/io.c               |    2 +-
 arch/arm/plat-omap/gpio.c              | 1645 +++++++-------------------------
 arch/arm/plat-omap/include/plat/gpio.h |   25 +-
 5 files changed, 401 insertions(+), 1280 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..21629f2 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := io.o id.o sram.o irq.o mux.o flash.o serial.o devices.o
-obj-y += clock.o clock_data.o opp_data.o
+obj-y += clock.o clock_data.o opp_data.o gpio.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..53d1a2b 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o gpio.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
@@ -42,6 +42,11 @@ obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 # obj-$(CONFIG_ARCH_OMAP3)		+= sdrc3xxx.o
 
+# GPIO
+obj-$(CONFIG_ARCH_OMAP2)		+= gpio2xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= gpio3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= gpio44xx.o
+
 # Power Management
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e6e5834..2b9efda 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -340,5 +340,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 		_omap2_init_reprogram_sdrc();
 	}
 	gpmc_init();
-	omap_gpio_init();
+	omap_gpio_early_init();
 }
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 069dd66..2d4faa9 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -16,151 +16,14 @@
 
 #include <plat/gpio.h>
 
-#ifdef CONFIG_ARCH_OMAP16XX
-static struct gpio_bank gpio_bank_1610[5] = {
-	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
-		METHOD_MPUIO },
-	{ OMAP1610_GPIO1_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO2_BASE, NULL, INT_1610_GPIO_BANK2, IH_GPIO_BASE + 16,
-		METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO3_BASE, NULL, INT_1610_GPIO_BANK3, IH_GPIO_BASE + 32,
-		METHOD_GPIO_1610 },
-	{ OMAP1610_GPIO4_BASE, NULL, INT_1610_GPIO_BANK4, IH_GPIO_BASE + 48,
-		METHOD_GPIO_1610 },
-};
-#endif
-
-#ifdef CONFIG_ARCH_OMAP15XX
-static struct gpio_bank gpio_bank_1510[2] = {
-	{ OMAP1_MPUIO_VBASE, NULL, INT_MPUIO, IH_MPUIO_BASE,
-		METHOD_MPUIO },
-	{ OMAP1510_GPIO_BASE, NULL, INT_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_1510 }
-};
-#endif
-
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-static struct gpio_bank gpio_bank_7xx[7] = {
-	{ OMAP1_MPUIO_VBASE, NULL, INT_7XX_MPUIO, IH_MPUIO_BASE,
-		METHOD_MPUIO },
-	{ OMAP7XX_GPIO1_BASE, NULL, INT_7XX_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO2_BASE, NULL, INT_7XX_GPIO_BANK2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO3_BASE, NULL, INT_7XX_GPIO_BANK3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO4_BASE, NULL, INT_7XX_GPIO_BANK4,  IH_GPIO_BASE + 96,
-		METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO5_BASE, NULL, INT_7XX_GPIO_BANK5,  IH_GPIO_BASE + 128,
-		METHOD_GPIO_7XX },
-	{ OMAP7XX_GPIO6_BASE, NULL, INT_7XX_GPIO_BANK6,  IH_GPIO_BASE + 160,
-		METHOD_GPIO_7XX },
-};
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2
-
-static struct gpio_bank gpio_bank_242x[4] = {
-	{ OMAP242X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_24XX },
-	{ OMAP242X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,
-		METHOD_GPIO_24XX },
-};
-
-static struct gpio_bank gpio_bank_243x[5] = {
-	{ OMAP243X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96,
-		METHOD_GPIO_24XX },
-	{ OMAP243X_GPIO5_BASE, NULL, INT_24XX_GPIO_BANK5, IH_GPIO_BASE + 128,
-		METHOD_GPIO_24XX },
-};
-
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct gpio_bank gpio_bank_34xx[6] = {
-	{ OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BANK1, IH_GPIO_BASE,
-		METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO2_BASE, NULL, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO3_BASE, NULL, INT_34XX_GPIO_BANK3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO4_BASE, NULL, INT_34XX_GPIO_BANK4, IH_GPIO_BASE + 96,
-		METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO5_BASE, NULL, INT_34XX_GPIO_BANK5, IH_GPIO_BASE + 128,
-		METHOD_GPIO_24XX },
-	{ OMAP34XX_GPIO6_BASE, NULL, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160,
-		METHOD_GPIO_24XX },
-};
-
-static struct omap_gpio_reg_val gpio_context[OMAP34XX_NR_GPIOS];
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct gpio_bank gpio_bank_44xx[6] = {
-	{ OMAP44XX_GPIO1_BASE, NULL, OMAP44XX_IRQ_GPIO1, IH_GPIO_BASE,
-		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO2_BASE, NULL, OMAP44XX_IRQ_GPIO2, IH_GPIO_BASE + 32,
-		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO3_BASE, NULL, OMAP44XX_IRQ_GPIO3, IH_GPIO_BASE + 64,
-		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO4_BASE, NULL, OMAP44XX_IRQ_GPIO4, IH_GPIO_BASE + 96,
-		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO5_BASE, NULL, OMAP44XX_IRQ_GPIO5, IH_GPIO_BASE + 128,
-		METHOD_GPIO_44XX },
-	{ OMAP44XX_GPIO6_BASE, NULL, OMAP44XX_IRQ_GPIO6, IH_GPIO_BASE + 160,
-		METHOD_GPIO_44XX },
-};
-
-#endif
-
-static struct gpio_bank *gpio_bank;
-static int gpio_bank_count;
-
-static inline struct gpio_bank *get_gpio_bank(int gpio)
-{
-	if (cpu_is_omap15xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1];
-	}
-	if (cpu_is_omap16xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1 + (gpio >> 4)];
-	}
-	if (cpu_is_omap7xx()) {
-		if (OMAP_GPIO_IS_MPUIO(gpio))
-			return &gpio_bank[0];
-		return &gpio_bank[1 + (gpio >> 5)];
-	}
-	if (cpu_is_omap24xx())
-		return &gpio_bank[gpio >> 5];
-	if (cpu_is_omap34xx() || cpu_is_omap44xx())
-		return &gpio_bank[gpio >> 5];
-	BUG();
-	return NULL;
-}
+static struct	omap_gpio_info *arch_gpio;
+static struct	gpio_bank gpio_bank[7];
+static struct	omap_gpio_reg_val *gpio_context;
+static int	gpio_bank_count;
 
 static inline int get_gpio_index(int gpio)
 {
-	if (cpu_is_omap7xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap24xx())
-		return gpio & 0x1f;
-	if (cpu_is_omap34xx() || cpu_is_omap44xx())
-		return gpio & 0x1f;
-	return gpio & 0x0f;
+	return gpio & arch_gpio->index_mask;
 }
 
 static inline int gpio_valid(int gpio)
@@ -171,16 +34,7 @@ static inline int gpio_valid(int gpio)
 		if (gpio >= OMAP_MAX_GPIO_LINES + 16)
 			return -1;
 		return 0;
-	}
-	if (cpu_is_omap15xx() && gpio < 16)
-		return 0;
-	if ((cpu_is_omap16xx()) && gpio < 64)
-		return 0;
-	if (cpu_is_omap7xx() && gpio < 192)
-		return 0;
-	if (cpu_is_omap24xx() && gpio < 128)
-		return 0;
-	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && gpio < 192)
+	} else if (gpio < arch_gpio->no_of_gpio)
 		return 0;
 	return -1;
 }
@@ -200,41 +54,11 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 	void __iomem *reg = bank->base;
 	u32 l;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL;
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
+	if (bank->method == METHOD_MPUIO)
+		reg += arch_gpio->mpu_reg->mpu_io_ctrl;
+	else
+		reg += arch_gpio->reg_off->dir_ctrl;
+
 	l = __raw_readl(reg);
 	if (is_input)
 		l |= 1 << gpio;
@@ -248,67 +72,29 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 	void __iomem *reg = bank->base;
 	u32 l = 0;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT;
+	if (bank->method == METHOD_MPUIO) {
+		reg += arch_gpio->mpu_reg->mpu_data_out;
 		l = __raw_readl(reg);
 		if (enable)
 			l |= 1 << gpio;
 		else
 			l &= ~(1 << gpio);
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
+
+	} else if (arch_gpio->reg_off->data_out_set && enable) {
+		reg += arch_gpio->reg_off->data_out_set;
 		l = 1 << gpio;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DATA_OUTPUT;
+
+	} else if (arch_gpio->reg_off->data_out_clear && (!enable)) {
+		reg += arch_gpio->reg_off->data_out_clear;
+		l = 1 << gpio;
+
+	} else {
+		reg += arch_gpio->reg_off->data_out;
 		l = __raw_readl(reg);
 		if (enable)
 			l |= 1 << gpio;
 		else
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
 	}
 	__raw_writel(l, reg);
 }
@@ -320,40 +106,11 @@ static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 	if (check_gpio(gpio) < 0)
 		return -EINVAL;
 	reg = bank->base;
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_INPUT_LATCH;
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
+
+	if (bank->method == METHOD_MPUIO)
+		reg += arch_gpio->mpu_reg->mpu_data_in;
+	else
+		reg += arch_gpio->reg_off->data_in;
 	return (__raw_readl(reg)
 			& (1 << get_gpio_index(gpio))) != 0;
 }
@@ -366,48 +123,14 @@ static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 		return -EINVAL;
 	reg = bank->base;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT;
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
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
-		reg += OMAP24XX_GPIO_DATAOUT;
-		break;
-#endif
-	default:
-		return -EINVAL;
-	}
+	if (bank->method == METHOD_MPUIO)
+		reg += arch_gpio->mpu_reg->mpu_data_out;
+	else
+		reg += arch_gpio->reg_off->data_out;
 
 	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
 }
 
-#define MOD_REG_BIT(reg, bit_mask, set)	\
-do {	\
-	int l = __raw_readl(base + reg); \
-	if (set) l |= bit_mask; \
-	else l &= ~bit_mask; \
-	__raw_writel(l, base + reg); \
-} while(0)
-
 void omap_set_gpio_debounce(int gpio, int enable)
 {
 	struct gpio_bank *bank;
@@ -418,15 +141,9 @@ void omap_set_gpio_debounce(int gpio, int enable)
 	if (cpu_class_is_omap1())
 		return;
 
-	bank = get_gpio_bank(gpio);
+	bank = arch_gpio->get_gpio_bank(gpio, gpio_bank);
 	reg = bank->base;
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_is_omap44xx())
-		reg += OMAP4_GPIO_DEBOUNCENABLE;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
-#endif
+	reg += arch_gpio->reg_off->debounce_ena;
 
 	if (!(bank->mod_usage & l)) {
 		printk(KERN_ERR "GPIO %d not requested\n", gpio);
@@ -464,7 +181,7 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 	if (cpu_class_is_omap1())
 		return;
 
-	bank = get_gpio_bank(gpio);
+	bank = arch_gpio->get_gpio_bank(gpio, gpio_bank);
 	reg = bank->base;
 
 	if (!bank->mod_usage) {
@@ -472,203 +189,15 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
 		return;
 	}
 
+	reg += arch_gpio->reg_off->debounce_val;
 	enc_time &= 0xff;
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_is_omap44xx())
-		reg += OMAP4_GPIO_DEBOUNCINGTIME;
-	else
-		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
-#endif
-
 	__raw_writel(enc_time, reg);
 }
 EXPORT_SYMBOL(omap_set_gpio_debounce_time);
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
-						int trigger)
-{
-	void __iomem *base = bank->base;
-	u32 gpio_bit = 1 << gpio;
-	u32 val;
-
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
-			trigger & IRQ_TYPE_LEVEL_LOW);
-		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
-			trigger & IRQ_TYPE_LEVEL_HIGH);
-		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_RISING);
-		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
-			trigger & IRQ_TYPE_EDGE_FALLING);
-	}
-	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
-		if (cpu_is_omap44xx()) {
-			if (trigger != 0)
-				__raw_writel(1 << gpio, bank->base+
-						OMAP4_GPIO_IRQWAKEN0);
-			else {
-				val = __raw_readl(bank->base +
-							OMAP4_GPIO_IRQWAKEN0);
-				__raw_writel(val & (~(1 << gpio)), bank->base +
-							 OMAP4_GPIO_IRQWAKEN0);
-			}
-		} else {
-			if (trigger != 0)
-				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_SETWKUENA);
-			else
-				__raw_writel(1 << gpio, bank->base
-					+ OMAP24XX_GPIO_CLEARWKUENA);
-		}
-	} else {
-		if (trigger != 0)
-			bank->enabled_non_wakeup_gpios |= gpio_bit;
-		else
-			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
-	}
-
-	if (cpu_is_omap44xx()) {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP4_GPIO_LEVELDETECT1);
-	} else {
-		bank->level_mask =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0) |
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-	}
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP1
-/*
- * This only applies to chips that can't do both rising and falling edge
- * detection at once.  For all other chips, this function is a noop.
- */
-static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
-{
-	void __iomem *reg = bank->base;
-	u32 l = 0;
-
-	switch (bank->method) {
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE;
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
-		return;
-	}
-
-	l = __raw_readl(reg);
-	if ((l >> gpio) & 1)
-		l &= ~(1 << gpio);
-	else
-		l |= 1 << gpio;
-
-	__raw_writel(l, reg);
-}
-#endif
-
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
 {
-	void __iomem *reg = bank->base;
-	u32 l = 0;
-
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_INT_EDGE;
-		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
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
-		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
-			bank->toggle_mask |= 1 << gpio;
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 1 << gpio;
-		else if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l &= ~(1 << gpio);
-		else
-			goto bad;
-		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP16XX
-	case METHOD_GPIO_1610:
-		if (gpio & 0x08)
-			reg += OMAP1610_GPIO_EDGE_CTRL2;
-		else
-			reg += OMAP1610_GPIO_EDGE_CTRL1;
-		gpio &= 0x07;
-		l = __raw_readl(reg);
-		l &= ~(3 << (gpio << 1));
-		if (trigger & IRQ_TYPE_EDGE_RISING)
-			l |= 2 << (gpio << 1);
-		if (trigger & IRQ_TYPE_EDGE_FALLING)
-			l |= 1 << (gpio << 1);
-		if (trigger)
-			/* Enable wake-up during idle for dynamic tick */
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
-		else
-			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_CONTROL;
-		l = __raw_readl(reg);
-		if (trigger & IRQ_TYPE_EDGE_BOTH)
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
-		break;
-#endif
-	default:
-		goto bad;
-	}
-	__raw_writel(l, reg);
-	return 0;
-bad:
-	return -EINVAL;
+	return arch_gpio->set_gpio_triggering(bank, gpio, trigger);
 }
 
 static int gpio_irq_type(unsigned irq, unsigned type)
@@ -715,60 +244,26 @@ static void _clear_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 {
 	void __iomem *reg = bank->base;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
+	if (bank->method == METHOD_MPUIO)
 		/* MPUIO irqstatus is reset by reading the status register,
 		 * so do nothing here */
 		return;
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
+	else
+		reg += arch_gpio->reg_off->irq_status0;
 	__raw_writel(gpio_mask, reg);
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	/* Workaround for clearing DSP GPIO interrupts to allow retention */
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		reg = bank->base + OMAP24XX_GPIO_IRQSTATUS2;
-	else if (cpu_is_omap44xx())
-		reg = bank->base + OMAP4_GPIO_IRQSTATUS1;
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		__raw_writel(gpio_mask, reg);
-
-		/* Flush posted write for the irq status to
-		 * avoid spurious interrupts
+	if (arch_gpio->reg_off->irq_status1) {
+		/* Workaround for clearing DSP GPIO interrupts
+		 * to allow retention
 		 */
-		__raw_readl(reg);
+		reg = bank->base + arch_gpio->reg_off->irq_status1;
+		__raw_writel(gpio_mask, reg);
 	}
-#endif
+
+	/* Flush posted write for the irq status to avoid spurious
+	 * interrupts
+	 */
+	__raw_readl(reg);
 }
 
 static inline void _clear_gpio_irqstatus(struct gpio_bank *bank, int gpio)
@@ -783,49 +278,14 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 	u32 l;
 	u32 mask;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT;
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
+		reg += arch_gpio->mpu_reg->mpu_irq_mask;
+		mask = arch_gpio->mpu_reg->mpu_irq_mask_bits;
+		inv = arch_gpio->mpu_reg->mpu_irq_inv;
+	} else {
+		reg += arch_gpio->reg_off->irq_mask;
+		mask = arch_gpio->reg_off->irq_mask_bits;
+		inv = arch_gpio->reg_off->irq_inv;
 	}
 
 	l = __raw_readl(reg);
@@ -840,67 +300,29 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask, int enab
 	void __iomem *reg = bank->base;
 	u32 l;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_GPIO_MASKIT;
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
+	if (bank->method == METHOD_MPUIO) {
+		reg += arch_gpio->mpu_reg->mpu_irq_mask;
 		l = __raw_readl(reg);
 		if (enable)
 			l &= ~(gpio_mask);
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
+
+	} else if (arch_gpio->reg_off->irq_set && enable) {
+		reg += arch_gpio->reg_off->irq_set;
 		l = gpio_mask;
-		break;
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_INT_MASK;
+
+	} else if (arch_gpio->reg_off->irq_clear && (!enable)) {
+		reg += arch_gpio->reg_off->irq_clear;
+		l = gpio_mask;
+
+	} else {
+		reg += arch_gpio->reg_off->irq_mask;
 		l = __raw_readl(reg);
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
 	}
 	__raw_writel(l, reg);
 }
@@ -923,20 +345,20 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 	unsigned long uninitialized_var(flags);
 
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
+
 	case METHOD_MPUIO:
 	case METHOD_GPIO_1610:
-		spin_lock_irqsave(&bank->lock, flags);
-		if (enable)
-			bank->suspend_wakeup |= (1 << gpio);
-		else
-			bank->suspend_wakeup &= ~(1 << gpio);
-		spin_unlock_irqrestore(&bank->lock, flags);
+		if (cpu_is_omap16xx()) {
+			spin_lock_irqsave(&bank->lock, flags);
+			if (enable)
+				bank->suspend_wakeup |= (1 << gpio);
+			else
+				bank->suspend_wakeup &= ~(1 << gpio);
+			spin_unlock_irqrestore(&bank->lock, flags);
+		}
 		return 0;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
+
+	case METHOD_GPIO_OMAP2PLUS:
 		if (bank->non_wakeup_gpios & (1 << gpio)) {
 			printk(KERN_ERR "Unable to modify wakeup on "
 					"non-wakeup GPIO%d\n",
@@ -950,7 +372,7 @@ static int _set_gpio_wakeup(struct gpio_bank *bank, int gpio, int enable)
 			bank->suspend_wakeup &= ~(1 << gpio);
 		spin_unlock_irqrestore(&bank->lock, flags);
 		return 0;
-#endif
+
 	default:
 		printk(KERN_ERR "Can't enable GPIO wakeup for method %i\n",
 		       bank->method);
@@ -993,27 +415,25 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 	 */
 	_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
 
-#ifdef CONFIG_ARCH_OMAP15XX
 	if (bank->method == METHOD_GPIO_1510) {
 		void __iomem *reg;
 
 		/* Claim the pin for MPU */
-		reg = bank->base + OMAP1510_GPIO_PIN_CONTROL;
+		reg = bank->base + arch_gpio->reg_off->ctrl;
 		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (!cpu_class_is_omap1()) {
+
+	if (bank->method == METHOD_GPIO_OMAP2PLUS) {
 		if (!bank->mod_usage) {
 			u32 ctrl;
-			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			void __iomem *reg = bank->base;
+			ctrl = __raw_readl(reg + arch_gpio->reg_off->ctrl);
 			ctrl &= 0xFFFFFFFE;
 			/* Module is enabled, clocks are not gated */
-			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+			__raw_writel(ctrl, reg + arch_gpio->reg_off->ctrl);
 		}
 		bank->mod_usage |= 1 << offset;
 	}
-#endif
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	return 0;
@@ -1025,31 +445,24 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 	unsigned long flags;
 
 	spin_lock_irqsave(&bank->lock, flags);
-#ifdef CONFIG_ARCH_OMAP16XX
-	if (bank->method == METHOD_GPIO_1610) {
-		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-		__raw_writel(1 << offset, reg);
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if ((bank->method == METHOD_GPIO_24XX) ||
-			(bank->method == METHOD_GPIO_44XX)) {
+	if (arch_gpio->reg_off->wkup_clear) {
+		void __iomem *reg = bank->base;
+		reg += arch_gpio->reg_off->wkup_clear;
 		/* Disable wake-up during idle for dynamic tick */
-		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
 		__raw_writel(1 << offset, reg);
 	}
-	if (!cpu_class_is_omap1()) {
+
+	if (bank->method == METHOD_GPIO_OMAP2PLUS) {
 		bank->mod_usage &= ~(1 << offset);
 		if (!bank->mod_usage) {
 			u32 ctrl;
-			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			void __iomem *reg = bank->base;
+			ctrl = __raw_readl(reg + arch_gpio->reg_off->ctrl);
 			/* Module is disabled, clocks are gated */
 			ctrl |= 1;
-			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
+			__raw_writel(ctrl, reg + arch_gpio->reg_off->ctrl);
 		}
 	}
-#endif
 	_reset_gpio(bank, bank->chip.base + offset);
 	spin_unlock_irqrestore(&bank->lock, flags);
 }
@@ -1075,30 +488,11 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 	desc->chip->ack(irq);
 
 	bank = get_irq_data(irq);
-#ifdef CONFIG_ARCH_OMAP1
 	if (bank->method == METHOD_MPUIO)
-		isr_reg = bank->base + OMAP_MPUIO_GPIO_INT;
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
+		isr_reg = bank->base + arch_gpio->mpu_reg->mpu_isr;
+	else
+		isr_reg = bank->base + arch_gpio->reg_off->irq_status0;
+
 	while(1) {
 		u32 isr_saved, level_mask = 0;
 		u32 enabled;
@@ -1108,10 +502,8 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 
 		if (cpu_is_omap15xx() && (bank->method == METHOD_MPUIO))
 			isr &= 0x0000ffff;
-
-		if (cpu_class_is_omap2()) {
+		else if (cpu_class_is_omap2())
 			level_mask = bank->level_mask & enabled;
-		}
 
 		/* clear edge sensitive interrupts before handler(s) are
 		called so that we don't miss any interrupt occurred while
@@ -1139,7 +531,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			if (!(isr & 1))
 				continue;
 
-#ifdef CONFIG_ARCH_OMAP1
 			/*
 			 * Some chips can't respond to both rising and falling
 			 * at the same time.  If this irq was requested with
@@ -1147,9 +538,10 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
 			 * to respond to the IRQ for the opposite direction.
 			 * This will be indicated in the bank toggle_mask.
 			 */
-			if (bank->toggle_mask & (1 << gpio_index))
-				_toggle_gpio_edge_triggering(bank, gpio_index);
-#endif
+			if (cpu_class_is_omap1() &&
+				(bank->toggle_mask & (1 << gpio_index)))
+				arch_gpio->toggle_edge_triggering(bank,
+								gpio_index);
 
 			generic_handle_irq(gpio_irq);
 		}
@@ -1219,12 +611,7 @@ static struct irq_chip gpio_irq_chip = {
 	.set_wake	= gpio_wake_enable,
 };
 
-/*---------------------------------------------------------------------*/
-
-#ifdef CONFIG_ARCH_OMAP1
-
 /* MPUIO uses the always-on 32k clock */
-
 static void mpuio_ack_irq(unsigned int irq)
 {
 	/* The ISR is reset automatically, so do nothing here. */
@@ -1252,96 +639,8 @@ static struct irq_chip mpuio_irq_chip = {
 	.mask		= mpuio_mask_irq,
 	.unmask		= mpuio_unmask_irq,
 	.set_type	= gpio_irq_type,
-#ifdef CONFIG_ARCH_OMAP16XX
-	/* REVISIT: assuming only 16xx supports MPUIO wake events */
-	.set_wake	= gpio_wake_enable,
-#endif
-};
-
-
-#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
-
-
-#ifdef CONFIG_ARCH_OMAP16XX
-
-#include <linux/platform_device.h>
-
-static int omap_mpuio_suspend_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
-	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	bank->saved_wakeup = __raw_readl(mask_reg);
-	__raw_writel(0xffff & ~bank->suspend_wakeup, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
-static int omap_mpuio_resume_noirq(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_bank	*bank = platform_get_drvdata(pdev);
-	void __iomem		*mask_reg = bank->base + OMAP_MPUIO_GPIO_MASKIT;
-	unsigned long		flags;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	__raw_writel(bank->saved_wakeup, mask_reg);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	return 0;
-}
-
-static const struct dev_pm_ops omap_mpuio_dev_pm_ops = {
-	.suspend_noirq = omap_mpuio_suspend_noirq,
-	.resume_noirq = omap_mpuio_resume_noirq,
-};
-
-/* use platform_driver for this, now that there's no longer any
- * point to sys_device (other than not disturbing old code).
- */
-static struct platform_driver omap_mpuio_driver = {
-	.driver		= {
-		.name	= "mpuio",
-		.pm	= &omap_mpuio_dev_pm_ops,
-	},
-};
-
-static struct platform_device omap_mpuio_device = {
-	.name		= "mpuio",
-	.id		= -1,
-	.dev = {
-		.driver = &omap_mpuio_driver.driver,
-	}
-	/* could list the /proc/iomem resources */
 };
 
-static inline void mpuio_init(void)
-{
-	platform_set_drvdata(&omap_mpuio_device, &gpio_bank_1610[0]);
-
-	if (platform_driver_register(&omap_mpuio_driver) == 0)
-		(void) platform_device_register(&omap_mpuio_device);
-}
-
-#else
-static inline void mpuio_init(void) {}
-#endif	/* 16xx */
-
-#else
-
-extern struct irq_chip mpuio_irq_chip;
-
-#define bank_is_mpuio(bank)	0
-static inline void mpuio_init(void) {}
-
-#endif
-
-/*---------------------------------------------------------------------*/
-
 /* REVISIT these are stupid implementations!  replace by ones that
  * don't switch on METHOD_* and which mostly avoid spinlocks
  */
@@ -1362,28 +661,10 @@ static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
 	void __iomem *reg = bank->base;
 
-	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
-	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_IO_CNTL;
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
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	case METHOD_GPIO_24XX:
-	case METHOD_GPIO_44XX:
-		reg += OMAP24XX_GPIO_OE;
-		break;
-#endif
-	}
+	if (bank->method == METHOD_MPUIO)
+		reg += arch_gpio->mpu_reg->mpu_io_ctrl;
+	else
+		reg += arch_gpio->reg_off->dir_ctrl;
 	return __raw_readl(reg) & mask;
 }
 
@@ -1395,7 +676,7 @@ static int gpio_get(struct gpio_chip *chip, unsigned offset)
 	u32 mask;
 
 	gpio = chip->base + offset;
-	bank = get_gpio_bank(gpio);
+	bank = arch_gpio->get_gpio_bank(gpio, gpio_bank);
 	reg = bank->base;
 	mask = 1 << get_gpio_index(gpio);
 
@@ -1439,43 +720,11 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 
 /*---------------------------------------------------------------------*/
 
-static int initialized;
-#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2)
-static struct clk * gpio_ick;
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2)
-static struct clk * gpio_fck;
-#endif
-
-#if defined(CONFIG_ARCH_OMAP2430)
-static struct clk * gpio5_ick;
-static struct clk * gpio5_fck;
-#endif
-
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
-#endif
-
-static void __init omap_gpio_show_rev(void)
+static void __init omap_gpio_show_rev(void __iomem *base)
 {
 	u32 rev;
 
-#ifdef CONFIG_ARCH_OMAP1
-	if (cpu_is_omap16xx())
-		rev = __raw_readw(gpio_bank[1].base + OMAP1610_GPIO_REVISION);
-	else
-		return;
-#endif
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		rev = __raw_readl(gpio_bank[0].base + OMAP24XX_GPIO_REVISION);
-	else if (cpu_is_omap44xx())
-		rev = __raw_readl(gpio_bank[0].base + OMAP4_GPIO_REVISION);
-	else
-		return;
-#endif
-
+	rev = __raw_readw(base + arch_gpio->reg_off->rev_reg);
 	printk(KERN_INFO "OMAP GPIO hardware version %d.%d\n",
 		(rev >> 4) & 0x0f, rev & 0x0f);
 }
@@ -1485,255 +734,167 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
-static int __init _omap_gpio_init(void)
+void __init init_gpio_chip_irq(struct gpio_bank *bank)
 {
-	int i;
-	int gpio = 0;
-	struct gpio_bank *bank;
-	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-	char clk_name[11];
+	int j, gpio_count = arch_gpio->bank_bits;
+	static int gpio;
 
-	initialized = 1;
-
-#if defined(CONFIG_ARCH_OMAP1)
-	if (cpu_is_omap15xx()) {
-		gpio_ick = clk_get(NULL, "arm_gpio_ck");
-		if (IS_ERR(gpio_ick))
-			printk("Could not get arm_gpio_ck\n");
-		else
-			clk_enable(gpio_ick);
+	bank->mod_usage = 0;
+	/* REVISIT eventually switch from OMAP-specific gpio structs
+	 * over to the generic ones
+	 */
+	bank->chip.request = omap_gpio_request;
+	bank->chip.free = omap_gpio_free;
+	bank->chip.direction_input = gpio_input;
+	bank->chip.get = gpio_get;
+	bank->chip.direction_output = gpio_output;
+	bank->chip.set = gpio_set;
+	bank->chip.to_irq = gpio_2irq;
+	if (bank_is_mpuio(bank)) {
+		bank->chip.label = "mpuio";
+		bank->chip.base = OMAP_MPUIO(0);
+	} else {
+		bank->chip.label = "gpio";
+		bank->chip.base = gpio;
+		gpio += gpio_count;
 	}
-#endif
-#if defined(CONFIG_ARCH_OMAP2)
-	if (cpu_class_is_omap2()) {
-		gpio_ick = clk_get(NULL, "gpios_ick");
-		if (IS_ERR(gpio_ick))
-			printk("Could not get gpios_ick\n");
-		else
-			clk_enable(gpio_ick);
-		gpio_fck = clk_get(NULL, "gpios_fck");
-		if (IS_ERR(gpio_fck))
-			printk("Could not get gpios_fck\n");
-		else
-			clk_enable(gpio_fck);
+	bank->chip.ngpio = gpio_count;
 
-		/*
-		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
-		 */
-#if defined(CONFIG_ARCH_OMAP2430)
-		if (cpu_is_omap2430()) {
-			gpio5_ick = clk_get(NULL, "gpio5_ick");
-			if (IS_ERR(gpio5_ick))
-				printk("Could not get gpio5_ick\n");
-			else
-				clk_enable(gpio5_ick);
-			gpio5_fck = clk_get(NULL, "gpio5_fck");
-			if (IS_ERR(gpio5_fck))
-				printk("Could not get gpio5_fck\n");
-			else
-				clk_enable(gpio5_fck);
-		}
-#endif
-	}
-#endif
+	gpiochip_add(&bank->chip);
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
-			sprintf(clk_name, "gpio%d_ick", i + 1);
-			gpio_iclks[i] = clk_get(NULL, clk_name);
-			if (IS_ERR(gpio_iclks[i]))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-			else
-				clk_enable(gpio_iclks[i]);
-		}
+	for (j = bank->virtual_irq_start;
+	     j < bank->virtual_irq_start + gpio_count; j++) {
+		lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
+		set_irq_chip_data(j, bank);
+		if (bank_is_mpuio(bank)) {
+			/* REVISIT: assuming only 16xx supports
+			 * MPUIO wake events
+			 */
+			if (cpu_is_omap16xx())
+				mpuio_irq_chip.set_wake	= gpio_wake_enable;
+			set_irq_chip(j, &mpuio_irq_chip);
+		} else
+			set_irq_chip(j, &gpio_irq_chip);
+		set_irq_handler(j, handle_simple_irq);
+		set_irq_flags(j, IRQF_VALID);
 	}
-#endif
+	set_irq_chained_handler(bank->irq, gpio_irq_handler);
+	set_irq_data(bank->irq, bank);
+}
 
+static int __devexit omap_gpio_remove(struct platform_device *pdev)
+{
+	struct omap_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_bank *bank;
+	int id;
 
-#ifdef CONFIG_ARCH_OMAP15XX
-	if (cpu_is_omap15xx()) {
-		gpio_bank_count = 2;
-		gpio_bank = gpio_bank_1510;
-		bank_size = SZ_2K;
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP16XX)
-	if (cpu_is_omap16xx()) {
-		gpio_bank_count = 5;
-		gpio_bank = gpio_bank_1610;
-		bank_size = SZ_2K;
-	}
-#endif
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-	if (cpu_is_omap7xx()) {
-		gpio_bank_count = 7;
-		gpio_bank = gpio_bank_7xx;
-		bank_size = SZ_2K;
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP2
-	if (cpu_is_omap242x()) {
-		gpio_bank_count = 4;
-		gpio_bank = gpio_bank_242x;
-	}
-	if (cpu_is_omap243x()) {
-		gpio_bank_count = 5;
-		gpio_bank = gpio_bank_243x;
+	if (!pdev || !pdata)
+		return 0;
+
+	id = pdev->id;
+	if (id > gpio_bank_count)
+		return 0;
+
+	bank = &gpio_bank[id];
+	if (cpu_is_omap24xx()) {
+		clk_disable(bank->fck);
+		clk_put(bank->fck);
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap34xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_34xx;
+	clk_disable(bank->ick);
+	clk_put(bank->ick);
+
+	bank->ick = NULL;
+	bank->fck = NULL;
+	bank->initialized = 0;
+	iounmap(bank->base);
+
+	return 0;
+}
+
+static int __devinit omap_gpio_probe(struct platform_device *pdev)
+{
+	struct omap_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_bank *bank;
+	struct resource *res;
+	static int initialized;
+	int id;
+
+	if (cpu_class_is_omap1())
+		return -EINVAL;
+
+	if (!pdev || !pdata) {
+		pr_err("GPIO device initialize without"
+					"platform data\n");
+		return -EINVAL;
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (cpu_is_omap44xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_44xx;
+
+	id = pdev->id;
+	if (id > gpio_bank_count) {
+		pr_err("Invalid GPIO device id (%d)\n", id);
+		return -EINVAL;
 	}
-#endif
-	for (i = 0; i < gpio_bank_count; i++) {
-		int j, gpio_count = 16;
 
-		bank = &gpio_bank[i];
-		spin_lock_init(&bank->lock);
+	bank = &gpio_bank[id];
 
-		/* Static mapping, never released */
-		bank->base = ioremap(bank->pbase, bank_size);
-		if (!bank->base) {
-			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
-			continue;
-		}
+	if (bank->initialized == 1)
+		return 0;
 
-#ifdef CONFIG_ARCH_OMAP1
-		if (bank_is_mpuio(bank))
-			__raw_writew(0xffff, bank->base + OMAP_MPUIO_GPIO_MASKIT);
-		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
-			__raw_writew(0xffff, bank->base + OMAP1510_GPIO_INT_MASK);
-			__raw_writew(0x0000, bank->base + OMAP1510_GPIO_INT_STATUS);
-		}
-		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
-			__raw_writew(0x0000, bank->base + OMAP1610_GPIO_IRQENABLE1);
-			__raw_writew(0xffff, bank->base + OMAP1610_GPIO_IRQSTATUS1);
-			__raw_writew(0x0014, bank->base + OMAP1610_GPIO_SYSCONFIG);
-		}
-		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
-			__raw_writel(0xffffffff, bank->base + OMAP7XX_GPIO_INT_MASK);
-			__raw_writel(0x00000000, bank->base + OMAP7XX_GPIO_INT_STATUS);
+	bank->virtual_irq_start = pdata->virtual_irq_start;
+	bank->ick = clk_get(NULL, pdata->ick_name);
+	bank->method = pdata->method;
+	if (IS_ERR(bank->ick))
+		pr_err("Could not get %s\n", pdata->ick_name);
+	else
+		clk_enable(bank->ick);
 
-			gpio_count = 32; /* 7xx has 32-bit GPIOs */
-		}
-#endif
+	if (cpu_is_omap24xx()) {
+		bank->fck = clk_get(NULL, pdata->fck_name);
+		if (IS_ERR(bank->fck))
+			pr_err("Could not get %s\n", pdata->fck_name);
+		else
+			clk_enable(bank->fck);
+	}
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if ((bank->method == METHOD_GPIO_24XX) ||
-				(bank->method == METHOD_GPIO_44XX)) {
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-
-			if (cpu_is_omap44xx()) {
-				__raw_writel(0xffffffff, bank->base +
-						OMAP4_GPIO_IRQSTATUSCLR0);
-				__raw_writew(0x0015, bank->base +
-						OMAP4_GPIO_SYSCONFIG);
-				__raw_writel(0x00000000, bank->base +
-						 OMAP4_GPIO_DEBOUNCENABLE);
-				/*
-				 * Initialize interface clock ungated,
-				 * module enabled
-				 */
-				__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-			} else {
-				__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_IRQENABLE1);
-				__raw_writel(0xffffffff, bank->base +
-						OMAP24XX_GPIO_IRQSTATUS1);
-				__raw_writew(0x0015, bank->base +
-						OMAP24XX_GPIO_SYSCONFIG);
-				__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_DEBOUNCE_EN);
-
-				/*
-				 * Initialize interface clock ungated,
-				 * module enabled
-				 */
-				__raw_writel(0, bank->base +
-						OMAP24XX_GPIO_CTRL);
-			}
-			if (i < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios = non_wakeup_gpios[i];
-			gpio_count = 32;
-		}
-#endif
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		bank->dbck = clk_get(NULL, pdata->dbck_name);
+		if (IS_ERR(bank->dbck))
+			pr_err("Could not get %s\n", pdata->dbck_name);
+	}
 
-		bank->mod_usage = 0;
-		/* REVISIT eventually switch from OMAP-specific gpio structs
-		 * over to the generic ones
-		 */
-		bank->chip.request = omap_gpio_request;
-		bank->chip.free = omap_gpio_free;
-		bank->chip.direction_input = gpio_input;
-		bank->chip.get = gpio_get;
-		bank->chip.direction_output = gpio_output;
-		bank->chip.set = gpio_set;
-		bank->chip.to_irq = gpio_2irq;
-		if (bank_is_mpuio(bank)) {
-			bank->chip.label = "mpuio";
-#ifdef CONFIG_ARCH_OMAP16XX
-			bank->chip.dev = &omap_mpuio_device.dev;
-#endif
-			bank->chip.base = OMAP_MPUIO(0);
-		} else {
-			bank->chip.label = "gpio";
-			bank->chip.base = gpio;
-			gpio += gpio_count;
-		}
-		bank->chip.ngpio = gpio_count;
+	spin_lock_init(&bank->lock);
 
-		gpiochip_add(&bank->chip);
+	/* Static mapping, never released */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		pr_err("GPIO Bank %i Invalid mem resource\n", id);
+		return -ENODEV;
+	}
 
-		for (j = bank->virtual_irq_start;
-		     j < bank->virtual_irq_start + gpio_count; j++) {
-			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
-			set_irq_chip_data(j, bank);
-			if (bank_is_mpuio(bank))
-				set_irq_chip(j, &mpuio_irq_chip);
-			else
-				set_irq_chip(j, &gpio_irq_chip);
-			set_irq_handler(j, handle_simple_irq);
-			set_irq_flags(j, IRQF_VALID);
-		}
-		set_irq_chained_handler(bank->irq, gpio_irq_handler);
-		set_irq_data(bank->irq, bank);
-
-		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-			sprintf(clk_name, "gpio%d_dbck", i + 1);
-			bank->dbck = clk_get(NULL, clk_name);
-			if (IS_ERR(bank->dbck))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-		}
+	bank->base = ioremap(res->start, resource_size(res));
+	if (!bank->base) {
+		pr_err("Could not ioremap gpio bank%i\n", id);
+		return -ENOMEM;
 	}
 
-	/* Enable system clock for GPIO module.
-	 * The CAM_CLK_CTRL *is* really the right place. */
-	if (cpu_is_omap16xx())
-		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04, ULPD_CAM_CLK_CTRL);
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!res)) {
+		pr_err("GPIO Bank %i Invalid IRQ resource\n", id);
+		return -ENODEV;
+	}
 
-	/* Enable autoidle for the OCP interface */
-	if (cpu_is_omap24xx())
-		omap_writel(1 << 0, 0x48019010);
-	if (cpu_is_omap34xx())
-		omap_writel(1 << 0, 0x48306814);
+	arch_gpio->gpio_mod_init(bank, id);
+	bank->irq = res->start;
+	init_gpio_chip_irq(bank);
+	bank->initialized = 1;
 
-	omap_gpio_show_rev();
+	if (!initialized) {
+		omap_gpio_show_rev(gpio_bank[id].base);
+		initialized = 1;
+	}
 
 	return 0;
 }
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -1743,36 +904,18 @@ static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_status;
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		void __iomem *wake_status = bank->base;
+		void __iomem *wake_clear = bank->base;
+		void __iomem *wake_set = bank->base;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
-			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
+		if ((bank->method == METHOD_GPIO_OMAP2PLUS) ||
+				(bank->method == METHOD_GPIO_1610)) {
+			wake_status += arch_gpio->reg_off->wkup_enable;
+			wake_clear += arch_gpio->reg_off->wkup_clear;
+			wake_set += arch_gpio->reg_off->wkup_set;
+		} else
 			continue;
-		}
 
 		spin_lock_irqsave(&bank->lock, flags);
 		bank->saved_wakeup = __raw_readl(wake_status);
@@ -1793,32 +936,16 @@ static int omap_gpio_resume(struct sys_device *dev)
 
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		void __iomem *wake_clear;
-		void __iomem *wake_set;
+		void __iomem *wake_clear = bank->base;
+		void __iomem *wake_set = bank->base;
 		unsigned long flags;
 
-		switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP16XX
-		case METHOD_GPIO_1610:
-			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
-			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
-			break;
-#endif
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
-		case METHOD_GPIO_24XX:
-			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
-			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
-			break;
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-		case METHOD_GPIO_44XX:
-			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
-			break;
-#endif
-		default:
+		if ((bank->method == METHOD_GPIO_OMAP2PLUS) ||
+				(bank->method == METHOD_GPIO_1610)) {
+			wake_clear += arch_gpio->reg_off->wkup_clear;
+			wake_set += arch_gpio->reg_off->wkup_set;
+		} else
 			continue;
-		}
 
 		spin_lock_irqsave(&bank->lock, flags);
 		__raw_writel(0xffffffff, wake_clear);
@@ -1840,16 +967,15 @@ static struct sys_device omap_gpio_device = {
 	.cls		= &omap_gpio_sysclass,
 };
 
-#endif
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
 static int workaround_enabled;
 
 void omap2_gpio_prepare_for_retention(void)
 {
 	int i, c = 0;
 
+	if (cpu_class_is_omap1())
+		return;
+
 	/* Remove triggering for all non-wakeup GPIOs.  Otherwise spurious
 	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
 	for (i = 0; i < gpio_bank_count; i++) {
@@ -1859,41 +985,18 @@ void omap2_gpio_prepare_for_retention(void)
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-					OMAP24XX_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			bank->saved_datain = __raw_readl(bank->base +
-						OMAP4_GPIO_DATAIN);
-			l1 = __raw_readl(bank->base +
-						OMAP4_GPIO_FALLINGDETECT);
-			l2 = __raw_readl(bank->base +
-						OMAP4_GPIO_RISINGDETECT);
-		}
+		bank->saved_datain = __raw_readl(bank->base +
+						arch_gpio->reg_off->data_in);
+		l1 = __raw_readl(bank->base + arch_gpio->reg_off->fall_detect);
+		l2 = __raw_readl(bank->base + arch_gpio->reg_off->rise_detect);
 
 		bank->saved_fallingdetect = l1;
 		bank->saved_risingdetect = l2;
 		l1 &= ~bank->enabled_non_wakeup_gpios;
 		l2 &= ~bank->enabled_non_wakeup_gpios;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(l1, bank->base +
-					OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base +
-					OMAP24XX_GPIO_RISINGDETECT);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(l1, bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(l2, bank->base + OMAP4_GPIO_RISINGDETECT);
-		}
-
+		__raw_writel(l1, bank->base + arch_gpio->reg_off->fall_detect);
+		__raw_writel(l2, bank->base + arch_gpio->reg_off->rise_detect);
 		c++;
 	}
 	if (!c) {
@@ -1907,8 +1010,9 @@ void omap2_gpio_resume_after_retention(void)
 {
 	int i;
 
-	if (!workaround_enabled)
+	if (cpu_class_is_omap1() || (!workaround_enabled))
 		return;
+
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		u32 l, gen, gen0, gen1;
@@ -1916,21 +1020,11 @@ void omap2_gpio_resume_after_retention(void)
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
 
-		if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP24XX_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP24XX_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
-		}
-
-		if (cpu_is_omap44xx()) {
-			__raw_writel(bank->saved_fallingdetect,
-				 bank->base + OMAP4_GPIO_FALLINGDETECT);
-			__raw_writel(bank->saved_risingdetect,
-				 bank->base + OMAP4_GPIO_RISINGDETECT);
-			l = __raw_readl(bank->base + OMAP4_GPIO_DATAIN);
-		}
+		__raw_writel(bank->saved_fallingdetect,
+				 bank->base + arch_gpio->reg_off->fall_detect);
+		__raw_writel(bank->saved_risingdetect,
+				 bank->base + arch_gpio->reg_off->rise_detect);
+		l = __raw_readl(bank->base + arch_gpio->reg_off->data_in);
 
 		/* Check if any of the non-wakeup interrupt GPIOs have changed
 		 * state.  If so, generate an IRQ by software.  This is
@@ -1958,77 +1052,61 @@ void omap2_gpio_resume_after_retention(void)
 		if (gen) {
 			u32 old0, old1;
 
-			if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-				old0 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | gen, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-					OMAP24XX_GPIO_LEVELDETECT1);
-			}
-
-			if (cpu_is_omap44xx()) {
-				old0 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				old1 = __raw_readl(bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1 | l, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-				__raw_writel(old0, bank->base +
-						OMAP4_GPIO_LEVELDETECT0);
-				__raw_writel(old1, bank->base +
-						OMAP4_GPIO_LEVELDETECT1);
-			}
+			old0 = __raw_readl(bank->base +
+					arch_gpio->reg_off->leveldetect0);
+			old1 = __raw_readl(bank->base +
+					arch_gpio->reg_off->leveldetect1);
+			__raw_writel(old0 | gen, bank->base +
+					arch_gpio->reg_off->leveldetect0);
+			__raw_writel(old1 | gen, bank->base +
+					arch_gpio->reg_off->leveldetect1);
+			__raw_writel(old0, bank->base +
+					arch_gpio->reg_off->leveldetect0);
+			__raw_writel(old1, bank->base +
+					arch_gpio->reg_off->leveldetect1);
 		}
 	}
-
 }
 
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
 /* save the registers of bank 2-6 */
 void omap_gpio_save_context(void)
 {
 	int i;
 
+	if (!cpu_is_omap34xx())
+		return;
+
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
+		void __iomem *reg = bank->base;
+
 		gpio_context[i].sysconfig =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
+			__raw_readl(reg + arch_gpio->reg_off->syscfg);
 		gpio_context[i].irqenable1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
+			__raw_readl(reg + arch_gpio->reg_off->irq_mask);
 		gpio_context[i].irqenable2 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
+			__raw_readl(reg + arch_gpio->reg_off->irq_ena2);
 		gpio_context[i].wake_en =
-			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
+			__raw_readl(reg + arch_gpio->reg_off->wkup_enable);
 		gpio_context[i].ctrl =
-			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
+			__raw_readl(reg + arch_gpio->reg_off->ctrl);
 		gpio_context[i].oe =
-			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
+			__raw_readl(reg + arch_gpio->reg_off->dir_ctrl);
 		gpio_context[i].leveldetect0 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_readl(reg + arch_gpio->reg_off->leveldetect0);
 		gpio_context[i].leveldetect1 =
-			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_readl(reg + arch_gpio->reg_off->leveldetect1);
 		gpio_context[i].risingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
+			__raw_readl(reg + arch_gpio->reg_off->rise_detect);
 		gpio_context[i].fallingdetect =
-			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+			__raw_readl(reg + arch_gpio->reg_off->fall_detect);
 		gpio_context[i].dataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
+			__raw_readl(reg + arch_gpio->reg_off->data_out);
 		gpio_context[i].setwkuena =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
+			__raw_readl(reg + arch_gpio->reg_off->wkup_set);
 		gpio_context[i].setdataout =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
+			__raw_readl(reg + arch_gpio->reg_off->data_out_set);
 	}
 }
 
@@ -2037,75 +1115,95 @@ void omap_gpio_restore_context(void)
 {
 	int i;
 
+	if (!cpu_is_omap34xx())
+		return;
+
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
 		__raw_writel(gpio_context[i].sysconfig,
-				bank->base + OMAP24XX_GPIO_SYSCONFIG);
+				bank->base + arch_gpio->reg_off->syscfg);
 		__raw_writel(gpio_context[i].irqenable1,
-				bank->base + OMAP24XX_GPIO_IRQENABLE1);
+				bank->base + arch_gpio->reg_off->irq_mask);
 		__raw_writel(gpio_context[i].irqenable2,
-				bank->base + OMAP24XX_GPIO_IRQENABLE2);
+				bank->base + arch_gpio->reg_off->irq_ena2);
 		__raw_writel(gpio_context[i].wake_en,
-				bank->base + OMAP24XX_GPIO_WAKE_EN);
+				bank->base + arch_gpio->reg_off->wkup_enable);
 		__raw_writel(gpio_context[i].ctrl,
-				bank->base + OMAP24XX_GPIO_CTRL);
+				bank->base + arch_gpio->reg_off->ctrl);
 		__raw_writel(gpio_context[i].oe,
-				bank->base + OMAP24XX_GPIO_OE);
+				bank->base + arch_gpio->reg_off->dir_ctrl);
 		__raw_writel(gpio_context[i].leveldetect0,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
+				bank->base + arch_gpio->reg_off->leveldetect0);
 		__raw_writel(gpio_context[i].leveldetect1,
-				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+				bank->base + arch_gpio->reg_off->leveldetect1);
 		__raw_writel(gpio_context[i].risingdetect,
-				bank->base + OMAP24XX_GPIO_RISINGDETECT);
+				bank->base + arch_gpio->reg_off->rise_detect);
 		__raw_writel(gpio_context[i].fallingdetect,
-				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
+				bank->base + arch_gpio->reg_off->fall_detect);
 		__raw_writel(gpio_context[i].dataout,
-				bank->base + OMAP24XX_GPIO_DATAOUT);
+				bank->base + arch_gpio->reg_off->data_out);
 		__raw_writel(gpio_context[i].setwkuena,
-				bank->base + OMAP24XX_GPIO_SETWKUENA);
+				bank->base + arch_gpio->reg_off->wkup_set);
 		__raw_writel(gpio_context[i].setdataout,
-				bank->base + OMAP24XX_GPIO_SETDATAOUT);
+				bank->base + arch_gpio->reg_off->data_out_set);
 	}
 }
-#endif
 
-/*
- * This may get called early from board specific init
- * for boards that have interrupts routed via FPGA.
- */
-int __init omap_gpio_init(void)
+int __init gpio_init(struct omap_gpio_info *custom_gpio)
 {
-	if (!initialized)
-		return _omap_gpio_init();
-	else
-		return 0;
+	struct gpio_bank *bank;
+	int i;
+
+	if (!custom_gpio) {
+		printk(KERN_ERR "No custom gpio data registered\n");
+		BUG();
+	}
+	arch_gpio = custom_gpio;
+	gpio_bank_count = custom_gpio->bank_count;
+
+	/* For OMAP2PLUS, gpio_bank pointer is obtained during probe */
+	if (cpu_class_is_omap1()) {
+		for (i = 0; i < gpio_bank_count; i++) {
+			bank = &gpio_bank[i];
+			*bank = custom_gpio->gpio_bank[i];
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver omap_gpio_driver = {
+	.probe		= omap_gpio_probe,
+	.remove		= __devexit_p(omap_gpio_remove),
+	.driver		= {
+		.name	= "omap-gpio",
+	},
+};
+
+static int __init omap_gpio_driver_reg(void)
+{
+	return platform_driver_register(&omap_gpio_driver);
 }
 
 static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	if (!initialized)
-		ret = _omap_gpio_init();
-
-	mpuio_init();
+	if (cpu_class_is_omap2())
+		ret = omap_gpio_driver_reg();
 
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-	if (cpu_is_omap16xx() || cpu_class_is_omap2()) {
-		if (ret == 0) {
-			ret = sysdev_class_register(&omap_gpio_sysclass);
-			if (ret == 0)
-				ret = sysdev_register(&omap_gpio_device);
-		}
+	if (cpu_is_omap16xx() || cpu_class_is_omap2() || (ret == 0)) {
+		ret = sysdev_class_register(&omap_gpio_sysclass);
+		if (ret == 0)
+			ret = sysdev_register(&omap_gpio_device);
 	}
-#endif
 
 	return ret;
 }
 
+early_platform_init("earlygpio", &omap_gpio_driver);
 arch_initcall(omap_gpio_sysinit);
 
-
 #ifdef	CONFIG_DEBUG_FS
 
 #include <linux/debugfs.h>
@@ -2117,13 +1215,11 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 
 	for (i = 0, gpio = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank	*bank = gpio_bank + i;
-		unsigned		bankwidth = 16;
+		unsigned		bankwidth = arch_gpio->bank_bits;
 		u32			mask = 1;
 
 		if (bank_is_mpuio(bank))
 			gpio = OMAP_MPUIO(0);
-		else if (cpu_class_is_omap2() || cpu_is_omap7xx())
-			bankwidth = 32;
 
 		for (j = 0; j < bankwidth; j++, gpio++, mask <<= 1) {
 			unsigned	irq, value, is_in, irqstat;
@@ -2146,12 +1242,14 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 					is_in ? "in " : "out",
 					value ? "hi"  : "lo");
 
-/* FIXME for at least omap2, show pullup/pulldown state */
+			/* FIXME for at least omap2,
+			 * show pullup/pulldown state
+			 */
 
 			irqstat = irq_desc[irq].status;
-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
-			if (is_in && ((bank->suspend_wakeup & mask)
-					|| irqstat & IRQ_TYPE_SENSE_MASK)) {
+			if ((cpu_class_is_omap2() || cpu_is_omap16xx()) &&
+				(is_in && ((bank->suspend_wakeup & mask)
+					|| irqstat & IRQ_TYPE_SENSE_MASK))) {
 				char	*trigger = NULL;
 
 				switch (irqstat & IRQ_TYPE_SENSE_MASK) {
@@ -2179,7 +1277,6 @@ static int dbg_gpio_show(struct seq_file *s, void *unused)
 						(bank->suspend_wakeup & mask)
 							? " wakeup" : "");
 			}
-#endif
 			seq_printf(s, "\n");
 		}
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index d154897..98e0088 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -47,15 +47,25 @@
 #define METHOD_GPIO_1510	1
 #define METHOD_GPIO_1610	2
 #define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	4
-#define METHOD_GPIO_44XX	5
+#define METHOD_GPIO_OMAP2PLUS	4
 
+#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
 #define OMAP_GPIO_IRQ(nr)	(OMAP_GPIO_IS_MPUIO(nr) ? \
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+#define MOD_REG_BIT(reg, bit_mask, set)	\
+do {	\
+	int l = __raw_readl(base + reg); \
+	if (set) \
+		l |= bit_mask; \
+	else \
+		l &= ~bit_mask; \
+	__raw_writel(l, base + reg); \
+} while (0)
+
 struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
 	int method;
@@ -103,7 +113,9 @@ struct mpu_gpio_reg_off {
 };
 
 struct gpio_bank {
+#ifdef CONFIG_ARCH_OMAP1
 	unsigned long pbase;
+#endif
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
@@ -159,14 +171,21 @@ struct omap_gpio_info {
 	void	(*gpio_mod_init) (struct gpio_bank *bank, int i);
 };
 
+extern int gpio_init(struct omap_gpio_info *custom_gpio);
+#ifdef CONFIG_ARCH_OMAP1
+extern int omap_gpio_init(void); /* Call from board init only */
+extern void init_gpio_chip_irq(struct gpio_bank *bank);
+#endif
 
-extern int omap_gpio_init(void);	/* Call from board init only */
+#ifdef CONFIG_ARCH_OMAP2PLUS
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 extern void omap_gpio_save_context(void);
 extern void omap_gpio_restore_context(void);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.6.3.3

