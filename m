From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v2 15/18] GPIO: OMAP: Remove bank->method & METHOD_* macros
Date: Wed, 15 Jun 2011 09:53:23 +0530
Message-ID: <1308111806-29152-6-git-send-email-tarun.kanti@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42084 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab1FOEW5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Jun 2011 00:22:57 -0400
In-Reply-To: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com

From: Charulatha V <charu@ti.com>

The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
need to be handled separately. Identify the same using a flag and remove all
METHOD_* macros.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    3 +--
 arch/arm/mach-omap1/gpio16xx.c         |    6 +-----
 arch/arm/mach-omap1/gpio7xx.c          |    8 +-------
 arch/arm/mach-omap2/gpio.c             |    2 --
 arch/arm/plat-omap/include/plat/gpio.h |    9 +--------
 drivers/gpio/gpio-omap.c               |   18 ++++++------------
 6 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 020725f..c51593c 100644
--- a/arch/arm/mach-omap1/gpio15xx.c
+++ b/arch/arm/mach-omap1/gpio15xx.c
@@ -47,7 +47,7 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
+	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
 	.regs			= &omap15xx_mpuio_regs,
@@ -90,7 +90,6 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_1510,
 	.bank_width		= 16,
 	.regs                   = &omap15xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
index efd9275..6b90fad 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -50,7 +50,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
+	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
 	.suspend_support	= true,
@@ -101,7 +101,6 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.suspend_support	= true,
 	.regs                   = &omap16xx_gpio_regs,
@@ -132,7 +131,6 @@ static struct __initdata resource omap16xx_gpio2_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.suspend_support	= true,
 	.regs                   = &omap16xx_gpio_regs,
@@ -163,7 +161,6 @@ static struct __initdata resource omap16xx_gpio3_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.suspend_support	= true,
 	.regs                   = &omap16xx_gpio_regs,
@@ -194,7 +191,6 @@ static struct __initdata resource omap16xx_gpio4_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.suspend_support	= true,
 	.regs                   = &omap16xx_gpio_regs,
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 6e439ff..91a7691 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -52,8 +52,8 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
 	.bank_width		= 32,
+	.is_mpuio		= true,
 	.bank_stride		= 2,
 	.regs                   = &omap7xx_mpuio_regs,
 };
@@ -94,7 +94,6 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -124,7 +123,6 @@ static struct __initdata resource omap7xx_gpio2_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -154,7 +152,6 @@ static struct __initdata resource omap7xx_gpio3_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 64,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -184,7 +181,6 @@ static struct __initdata resource omap7xx_gpio4_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 96,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -214,7 +210,6 @@ static struct __initdata resource omap7xx_gpio5_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio5_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 128,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
@@ -244,7 +239,6 @@ static struct __initdata resource omap7xx_gpio6_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_gpio6_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 160,
-	.bank_type		= METHOD_GPIO_7XX,
 	.bank_width		= 32,
 	.regs			= &omap7xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 3c96855..a6ecd00 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -98,7 +98,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		/* fall through */
 
 	case 1:
-		pdata->bank_type = METHOD_GPIO_24XX;
 		pdata->regs->revision = OMAP24XX_GPIO_REVISION;
 		pdata->regs->direction = OMAP24XX_GPIO_OE;
 		pdata->regs->datain = OMAP24XX_GPIO_DATAIN;
@@ -123,7 +122,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->fallingdetect = OMAP24XX_GPIO_FALLINGDETECT;
 		break;
 	case 2:
-		pdata->bank_type = METHOD_GPIO_44XX;
 		pdata->regs->revision = OMAP4_GPIO_REVISION;
 		pdata->regs->direction = OMAP4_GPIO_OE;
 		pdata->regs->datain = OMAP4_GPIO_DATAIN;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 8f85700..804a55f 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -162,13 +162,6 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
-#define METHOD_MPUIO		0
-#define METHOD_GPIO_1510	1
-#define METHOD_GPIO_1610	2
-#define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	5
-#define METHOD_GPIO_44XX	6
-
 struct omap_gpio_dev_attr {
 	int bank_width;		/* GPIO bank width */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
@@ -209,12 +202,12 @@ struct omap_gpio_reg_offs {
 
 struct omap_gpio_platform_data {
 	u16 virtual_irq_start;
-	int bank_type;
 	int bank_width;		/* GPIO bank width */
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool suspend_support;	/* Bank supports suspend/resume operations or not */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 	bool loses_context;	/* whether the bank would ever lose context */
+	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
 	struct omap_gpio_reg_offs *regs;
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 01b568f..36532de 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -49,7 +49,6 @@ struct gpio_bank {
 	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
-	int method;
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
 	u32 non_wakeup_gpios;
@@ -66,6 +65,7 @@ struct gpio_bank {
 	u32 mod_usage;
 	u32 dbck_enable_mask;
 	struct device *dev;
+	bool is_mpuio;
 	bool dbck_flag;
 	bool loses_context;
 	bool suspend_support;
@@ -706,8 +706,6 @@ static struct irq_chip gpio_irq_chip = {
 };
 
 /*---------------------------------------------------------------------*/
-#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
-
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -771,10 +769,6 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
-/* REVISIT these are stupid implementations!  replace by ones that
- * don't switch on METHOD_* and which mostly avoid spinlocks
- */
-
 static int gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
@@ -893,7 +887,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		u32 clr_all = 0;		/* clear all the bits */
 		u32 set_all = 0xFFFFFFFF;	/* set all the bits */
 
-		if (bank_is_mpuio(bank)) {
+		if (bank->is_mpuio) {
 			__raw_writel(set_all, bank->base +
 						bank->regs->irqenable);
 
@@ -940,7 +934,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		u16 clr_all = 0;	/* clear all the bits */
 		u16 set_all = 0xFFFF;	/* set all the bits */
 
-		if (bank_is_mpuio(bank)) {
+		if (bank->is_mpuio) {
 			__raw_writew(set_all, bank->base +
 						bank->regs->irqenable);
 
@@ -1028,7 +1022,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
 	bank->chip.to_irq = gpio_2irq;
-	if (bank_is_mpuio(bank)) {
+	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->suspend_support)
 			bank->chip.dev = &omap_mpuio_device.dev;
@@ -1046,7 +1040,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank_is_mpuio(bank)) {
+		if (bank->is_mpuio) {
 			omap_mpuio_alloc_gc(bank, j, bank->width);
 		} else {
 			irq_set_chip(j, &gpio_irq_chip);
@@ -1090,11 +1084,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 	bank->virtual_irq_start = pdata->virtual_irq_start;
-	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
+	bank->is_mpuio = pdata->is_mpuio;
 	bank->suspend_support = pdata->suspend_support;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank->loses_context = pdata->loses_context;
-- 
1.6.0.4

