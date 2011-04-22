From: Charulatha V <charu@ti.com>
Subject: [RFC PATCH 05/18] OMAP: GPIO: cleanup datain,dataout,set dir funcs
Date: Fri, 22 Apr 2011 16:38:19 +0530
Message-ID: <1303470512-19671-6-git-send-email-charu@ti.com>
References: <1303470512-19671-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38698 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755139Ab1DVLE7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Apr 2011 07:04:59 -0400
In-Reply-To: <1303470512-19671-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

* Define gpio register offsets in SoC specific GPIO files and use
  these register offsets while doing register read/write
* Remove the usage of CONFIG_ARCH_* checks and cpu_is* checks from
  the below functions
	_set_gpio_direction
	_set_gpio_dataout
	_get_gpio_dataout
	_get_gpio_datain
* MPUIO is a common gpio bank->method for OMAP15xx, OMAP16xx and
  OMAP7xx SoCs. Each of these SoCs has one bank with MPUIO type.
  Hence handle MPUIO type GPIO banks in GPIO driver.

Note: After the complete driver is cleaned up, the register offset
macros defined in OMAP GPIO driver would be removed

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |   22 +++
 arch/arm/mach-omap1/gpio16xx.c         |   32 ++++
 arch/arm/mach-omap1/gpio7xx.c          |   21 +++
 arch/arm/mach-omap2/gpio.c             |   72 +++++++++
 arch/arm/plat-omap/gpio.c              |  261 ++++++++++----------------------
 arch/arm/plat-omap/include/plat/gpio.h |   39 +++++
 6 files changed, 265 insertions(+), 182 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 9d7a3fa..26c6c25 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -27,6 +27,16 @@
 #define OMAP1510_NON_MPUIO_GPIO_VALID	((OMAP1510_GPIO_BANK_CNT - 1) *\
 						OMAP1510_GPIO_WIDTH)
 
+static u16 reg_map[] = {
+	[DATAIN]		= 0x00,
+	[DATAOUT]		= 0x04,
+	[OE]			= 0x08,
+	[INT_CTRL]		= 0x0C,
+	[IRQENABLE1]		= 0x10,
+	[IRQSTATUS_REG0]	= 0x14,
+	[CTRL]			= 0x18,
+};
+
 /* gpio1 */
 static struct __initdata resource omap15xx_mpu_gpio_resources[] = {
 	{
@@ -86,6 +96,16 @@ static struct __initdata platform_device omap15xx_gpio = {
 	.resource = omap15xx_gpio_resources,
 };
 
+static inline u32 gpio_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg_map[reg]);
+}
+
+static inline void gpio_write(u32 val, void __iomem *base, int reg)
+{
+	__raw_writel(val, base + reg_map[reg]);
+}
+
 static int get_gpio_index(int gpio)
 {
 	return gpio & OMAP1510_GPIO_INDEX_MASK;
@@ -111,6 +131,8 @@ static int gpio_valid(int gpio)
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
+	.gpio_read = gpio_read,
+	.gpio_write = gpio_write,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index e6bb080..473c889 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -30,6 +30,26 @@
 #define OMAP1610_NON_MPUIO_GPIO_VALID	((OMAP1610_GPIO_BANK_CNT - 1) *\
 						OMAP1610_GPIO_WIDTH)
 
+static u16 reg_map[] = {
+	[REV]			= 0x00,
+	[SYS_CFG]		= 0x10,
+	[SYS_STATUS]		= 0x14,
+	[IRQSTATUS_REG0]	= 0x18,
+	[IRQENABLE1]		= 0x1C,
+	[WAKE_EN]		= 0x28,
+	[DATAIN]		= 0x2C,
+	[DATAOUT]		= 0x30,
+	[OE]			= 0x34,
+	[EDGE_CTRL1]		= 0x38,
+	[EDGE_CTRL2]		= 0x3C,
+	[CLEARIRQENA1]		= 0x9C,
+	[CLEARWKUENA]		= 0xA8,
+	[CLEARDATAOUT]		= 0xB0,
+	[SETIRQENA1]		= 0xDC,
+	[SETWKUENA]		= 0xE8,
+	[SETDATAOUT]		= 0xF0,
+};
+
 /* mpu gpio */
 static struct __initdata resource omap16xx_mpu_gpio_resources[] = {
 	{
@@ -184,6 +204,16 @@ static struct __initdata platform_device * omap16xx_gpio_dev[] = {
 	&omap16xx_gpio4,
 };
 
+static inline u32 gpio_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg_map[reg]);
+}
+
+static inline void gpio_write(u32 val, void __iomem *base, int reg)
+{
+	__raw_writel(val, base + reg_map[reg]);
+}
+
 static int get_gpio_index(int gpio)
 {
 	return gpio & OMAP1610_GPIO_INDEX_MASK;
@@ -209,6 +239,8 @@ static int gpio_valid(int gpio)
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
+	.gpio_read = gpio_read,
+	.gpio_write = gpio_write,
 };
 
 /*
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index bd6fc8e..a6c2397 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -34,6 +34,15 @@
 #define OMAP7XX_NON_MPUIO_GPIO_VALID	((OMAP7XX_GPIO_BANK_CNT - 1) *\
 						OMAP7XX_GPIO_WIDTH)
 
+static u16 reg_map[] = {
+	[DATAIN]		= 0x00,
+	[DATAOUT]		= 0x04,
+	[OE]			= 0x08,
+	[INT_CTRL]		= 0x0C,
+	[IRQENABLE1]		= 0x10,
+	[IRQSTATUS_REG0]	= 0x14,
+};
+
 /* mpu gpio */
 static struct __initdata resource omap7xx_mpu_gpio_resources[] = {
 	{
@@ -248,6 +257,16 @@ static struct __initdata platform_device * omap7xx_gpio_dev[] = {
 	&omap7xx_gpio6,
 };
 
+static inline u32 gpio_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg_map[reg]);
+}
+
+static inline void gpio_write(u32 val, void __iomem *base, int reg)
+{
+	__raw_writel(val, base + reg_map[reg]);
+}
+
 static int get_gpio_index(int gpio)
 {
 	return gpio & OMAP7XX_GPIO_INDEX_MASK;
@@ -273,6 +292,8 @@ static int gpio_valid(int gpio)
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
+	.gpio_read = gpio_read,
+	.gpio_write = gpio_write,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 08ee5f1..7764ebe 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -27,6 +27,64 @@
 #define OMAP2_GPIO_INDEX_MASK		0x1f
 
 int bank_width;
+static u16 *reg_map;
+static u16 omap2_gpio_reg_offsets[] = {
+	[REV]			= 0x00,
+	[IRQSTATUS_REG0]	= 0x18,
+	[IRQENABLE1]		= 0x1C,
+	[WAKE_EN]		= 0x20,
+	[IRQSTATUS_REG1]	= 0x28,
+	[IRQENABLE2]		= 0x2C,
+	[CTRL]			= 0x30,
+	[OE]			= 0x34,
+	[DATAIN]		= 0x38,
+	[DATAOUT]		= 0x3C,
+	[LEVELDETECT0]		= 0x40,
+	[LEVELDETECT1]		= 0x44,
+	[RISINGDETECT]		= 0x48,
+	[FALLINGDETECT]		= 0x4C,
+	[DEBOUNCE_EN]		= 0x50,
+	[DEBOUNCE_VAL]		= 0x54,
+	[CLEARIRQENA1]		= 0x60,
+	[SETIRQENA1]		= 0x64,
+	[CLEARWKUENA]		= 0x80,
+	[SETWKUENA]		= 0x84,
+	[CLEARDATAOUT]		= 0x90,
+	[SETDATAOUT]		= 0x94,
+};
+
+static u16 omap4_gpio_reg_offsets[] = {
+	[REV]			= 0x0000,
+	[IRQSTATUSRAW0]		= 0x0024,
+	[IRQSTATUSRAW1]		= 0x0028,
+	[IRQSTATUS_REG0]	= 0x002C,
+	[IRQSTATUS_REG1]	= 0x0030,
+	[IRQSTATUSSET0]		= 0x0034,
+	[IRQSTATUSSET1]		= 0x0038,
+	[IRQSTATUSCLR0]		= 0x003C,
+	[IRQSTATUSCLR1]		= 0x0040,
+	[IRQWAKEN0]		= 0x0044,
+	[IRQWAKEN1]		= 0x0048,
+	[IRQENABLE1]		= 0x011C,
+	[WAKE_EN]		= 0x0120,
+	[IRQENABLE2]		= 0x012C,
+	[CTRL]			= 0x0130,
+	[OE]			= 0x0134,
+	[DATAIN]		= 0x0138,
+	[DATAOUT]		= 0x013C,
+	[LEVELDETECT0]		= 0x0140,
+	[LEVELDETECT1]		= 0x0144,
+	[RISINGDETECT]		= 0x0148,
+	[FALLINGDETECT]		= 0x014C,
+	[DEBOUNCE_EN]		= 0x0150,
+	[DEBOUNCE_VAL]		= 0x0154,
+	[CLEARIRQENA1]		= 0x0160,
+	[SETIRQENA1]		= 0x0164,
+	[CLEARWKUENA]		= 0x0180,
+	[SETWKUENA]		= 0x0184,
+	[CLEARDATAOUT]		= 0x0190,
+	[SETDATAOUT]		= 0x0194,
+};
 
 static struct omap_device_pm_latency omap_gpio_latency[] = {
 	[0] = {
@@ -36,6 +94,16 @@ static struct omap_device_pm_latency omap_gpio_latency[] = {
 	},
 };
 
+static inline u32 gpio_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg_map[reg]);
+}
+
+static inline void gpio_write(u32 val, void __iomem *base, int reg)
+{
+	__raw_writel(val, base + reg_map[reg]);
+}
+
 static int get_gpio_index(int gpio)
 {
 	return gpio & OMAP2_GPIO_INDEX_MASK;
@@ -52,6 +120,8 @@ static int gpio_valid(int gpio)
 static struct omap_gpio_func gpio_fn = {
 	.get_index = get_gpio_index,
 	.gpio_valid = gpio_valid,
+	.gpio_read = gpio_read,
+	.gpio_write = gpio_write,
 };
 
 static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
@@ -89,9 +159,11 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 	case 0:
 	case 1:
 		pdata->bank_type = METHOD_GPIO_24XX;
+		reg_map = omap2_gpio_reg_offsets;
 		break;
 	case 2:
 		pdata->bank_type = METHOD_GPIO_44XX;
+		reg_map = omap4_gpio_reg_offsets;
 		break;
 	default:
 		WARN(1, "Invalid gpio bank_type\n");
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 0f1dbbf..701152b 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -200,213 +200,127 @@ static int check_gpio(int gpio)
 	return 0;
 }
 
+static inline u32 gpio_mpuio_read(void __iomem *base, int reg)
+{
+	return __raw_readl(base + reg);
+}
+
+static inline void gpio_mpuio_write(u32 val, void __iomem *base, int reg)
+{
+	__raw_writel(val, base + reg);
+}
+
 static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *base = bank->base;
+	u32 offset;
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
+	if (bank->method == METHOD_MPUIO) {
+		offset = OMAP_MPUIO_IO_CNTL / bank->stride;
+		l = gpio_mpuio_read(base, offset);
+	} else {
+		offset = OE;
+		l = gpio_fn.gpio_read(base, offset);
 	}
-	l = __raw_readl(reg);
+
 	if (is_input)
 		l |= 1 << gpio;
 	else
 		l &= ~(1 << gpio);
-	__raw_writel(l, reg);
+
+	if (bank->method == METHOD_MPUIO)
+		gpio_mpuio_write(l, base, offset);
+	else
+		gpio_fn.gpio_write(l, base, offset);
 }
 
 static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *base = bank->base;
+	u32 offset;
 	u32 l = 0;
 
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
-		reg += OMAP_MPUIO_OUTPUT / bank->stride;
-		l = __raw_readl(reg);
+		offset = OMAP_MPUIO_OUTPUT / bank->stride;
+		l = gpio_mpuio_read(base, offset);
+
 		if (enable)
 			l |= 1 << gpio;
 		else
 			l &= ~(1 << gpio);
+
+		gpio_mpuio_write(l, base, offset);
 		break;
-#endif
-#ifdef CONFIG_ARCH_OMAP15XX
+
 	case METHOD_GPIO_1510:
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
 	case METHOD_GPIO_7XX:
-		reg += OMAP7XX_GPIO_DATA_OUTPUT;
-		l = __raw_readl(reg);
+		l = gpio_fn.gpio_read(base, DATAOUT);
+
 		if (enable)
 			l |= 1 << gpio;
 		else
 			l &= ~(1 << gpio);
+
+		gpio_fn.gpio_write(l, base, DATAOUT);
 		break;
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
+
+	default:
 		if (enable)
-			reg += OMAP4_GPIO_SETDATAOUT;
+			offset = SETDATAOUT;
 		else
-			reg += OMAP4_GPIO_CLEARDATAOUT;
+			offset = CLEARDATAOUT;
+
 		l = 1 << gpio;
+		gpio_fn.gpio_write(l, base, offset);
 		break;
-#endif
-	default:
-		WARN_ON(1);
-		return;
 	}
-	__raw_writel(l, reg);
+
 }
 
 static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg;
+	void __iomem *base;
+	int ret = -EINVAL;
+	u32 offset;
 
 	if (check_gpio(gpio) < 0)
-		return -EINVAL;
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
+		return ret;
+
+	base = bank->base;
+
+	if (bank->method == METHOD_MPUIO) {
+		offset = OMAP_MPUIO_INPUT_LATCH / bank->stride;
+		ret = gpio_mpuio_read(base, offset);
+	} else {
+		offset = DATAIN;
+		ret = gpio_fn.gpio_read(base, offset);
 	}
-	return (__raw_readl(reg)
-			& (1 << gpio_fn.get_index(gpio))) != 0;
+
+	return (ret & (1 << gpio_fn.get_index(gpio))) != 0;
 }
 
 static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
 {
-	void __iomem *reg;
+	void __iomem *base;
+	int ret = -EINVAL;
+	u32 offset;
 
 	if (check_gpio(gpio) < 0)
-		return -EINVAL;
-	reg = bank->base;
+		return ret;
 
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
+	base = bank->base;
+
+	if (bank->method == METHOD_MPUIO) {
+		offset = OMAP_MPUIO_OUTPUT / bank->stride;
+		ret = gpio_mpuio_read(base, offset);
+	} else {
+		offset = DATAOUT;
+		ret = gpio_fn.gpio_read(base, offset);
 	}
 
-	return (__raw_readl(reg) & (1 << gpio_fn.get_index(gpio))) != 0;
+	return (ret & (1 << gpio_fn.get_index(gpio))) != 0;
 }
 
 #define MOD_REG_BIT(reg, bit_mask, set)	\
@@ -1374,32 +1288,13 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
 
 static int gpio_is_input(struct gpio_bank *bank, int mask)
 {
-	void __iomem *reg = bank->base;
+	void __iomem *base = bank->base;
 
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
-	return __raw_readl(reg) & mask;
+	if (bank->method == METHOD_MPUIO)
+		return gpio_mpuio_read(base, OMAP_MPUIO_IO_CNTL / bank->stride)
+				& mask;
+	else
+		return gpio_fn.gpio_read(base, OE) & mask;
 }
 
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
@@ -1643,6 +1538,8 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 		gpio_fn.get_index = pdata->gpio_fn->get_index;
 		gpio_fn.gpio_valid = pdata->gpio_fn->gpio_valid;
+		gpio_fn.gpio_read = pdata->gpio_fn->gpio_read;
+		gpio_fn.gpio_write = pdata->gpio_fn->gpio_write;
 	}
 
 	id = pdev->id;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 00586ad..745515a 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -66,6 +66,43 @@
 #define METHOD_GPIO_24XX	5
 #define METHOD_GPIO_44XX	6
 
+enum omap_gpio_reg_offsets {
+	/* Common Registers*/
+	DATAIN,		DATAOUT,
+	/* Direction Control register/ Output Enable register */
+	OE,
+	IRQSTATUS_REG0,
+	/* Interrupt Mask/ Enable register */
+	IRQENABLE1,
+	CTRL,
+
+	/* OMAP16xx & OMAP2PLUS specific */
+	REV,
+	WAKE_EN,
+	CLEARIRQENA1,	SETIRQENA1,
+	CLEARWKUENA,	SETWKUENA,
+	CLEARDATAOUT,	SETDATAOUT,
+
+	/* OMAP2PLUS specific */
+	IRQSTATUS_REG1,	IRQENABLE2,
+	LEVELDETECT0,	LEVELDETECT1,
+	RISINGDETECT,	FALLINGDETECT,
+	DEBOUNCE_EN,	DEBOUNCE_VAL,
+
+	/* OMAP4 specific */
+	IRQWAKEN0,	IRQWAKEN1,
+	IRQSTATUSSET0,	IRQSTATUSSET1,
+	IRQSTATUSCLR0,	IRQSTATUSCLR1,
+	IRQSTATUSRAW0,	IRQSTATUSRAW1,
+
+	/* OMAP15xx and OMAP7xx specific */
+	INT_CTRL,
+
+	/* OMAP16xx specific */
+	SYS_CFG,	SYS_STATUS,
+	EDGE_CTRL1,	EDGE_CTRL2,
+};
+
 struct omap_gpio_dev_attr {
 	int bank_width;		/* GPIO bank width */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
@@ -74,6 +111,8 @@ struct omap_gpio_dev_attr {
 struct omap_gpio_func {
 	int (*get_index)(int gpio);
 	int (*gpio_valid)(int gpio);
+	u32 (*gpio_read)(void __iomem *base, int reg);
+	void (*gpio_write)(u32 val, void __iomem *base, int reg);
 };
 
 struct omap_gpio_platform_data {
-- 
1.7.1

