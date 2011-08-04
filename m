From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v5 16/22] gpio/omap: remove bank->method & METHOD_* macros
Date: Thu, 4 Aug 2011 16:34:47 +0530
Message-ID: <1312455893-14922-17-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387Ab1HDLFV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Aug 2011 07:05:21 -0400
In-Reply-To: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>

From: Charulatha V <charu@ti.com>

The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
need to be handled separately. Identify the same using a flag and remove all
METHOD_* macros.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap1/gpio15xx.c         |    3 +--
 arch/arm/mach-omap1/gpio16xx.c         |    6 +-----
 arch/arm/mach-omap1/gpio7xx.c          |    8 +-------
 arch/arm/mach-omap2/gpio.c             |    2 --
 arch/arm/plat-omap/include/plat/gpio.h |    8 +-------
 drivers/gpio/gpio-omap.c               |   19 ++++++-------------
 6 files changed, 10 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
index 950e467..634903e 100644
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
index 61b1998..227e0e8 100644
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -52,7 +52,7 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_type		= METHOD_MPUIO,
+	.is_mpuio		= true,
 	.bank_width		= 16,
 	.bank_stride		= 1,
 	.regs                   = &omap16xx_mpuio_regs,
@@ -99,7 +99,6 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
 	.virtual_irq_start	= IH_GPIO_BASE,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -129,7 +128,6 @@ static struct __initdata resource omap16xx_gpio2_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 16,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -159,7 +157,6 @@ static struct __initdata resource omap16xx_gpio3_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 32,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
@@ -189,7 +186,6 @@ static struct __initdata resource omap16xx_gpio4_resources[] = {
 
 static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
 	.virtual_irq_start	= IH_GPIO_BASE + 48,
-	.bank_type		= METHOD_GPIO_1610,
 	.bank_width		= 16,
 	.regs                   = &omap16xx_gpio_regs,
 };
diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index cb083c5..8d25052 100644
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
index 0ee9a55..3bbed93 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -93,7 +93,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		/* fall through */
 
 	case 1:
-		pdata->bank_type = METHOD_GPIO_24XX;
 		pdata->regs->revision = OMAP24XX_GPIO_REVISION;
 		pdata->regs->direction = OMAP24XX_GPIO_OE;
 		pdata->regs->datain = OMAP24XX_GPIO_DATAIN;
@@ -116,7 +115,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
 		pdata->regs->fallingdetect = OMAP24XX_GPIO_FALLINGDETECT;
 		break;
 	case 2:
-		pdata->bank_type = METHOD_GPIO_44XX;
 		pdata->regs->revision = OMAP4_GPIO_REVISION;
 		pdata->regs->direction = OMAP4_GPIO_OE;
 		pdata->regs->datain = OMAP4_GPIO_DATAIN;
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 3a05c58..acb5e2c 100644
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
@@ -210,6 +203,7 @@ struct omap_gpio_platform_data {
 	int bank_stride;	/* Only needed for omap1 MPUIO */
 	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
 	bool loses_context;	/* whether the bank would ever lose context */
+	bool is_mpuio;		/* whether the bank is of type MPUIO */
 	u32 non_wakeup_gpios;
 
 	struct omap_gpio_reg_offs *regs;
diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ba20e42..0545d8f 100644
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
 	int stride;
@@ -690,8 +690,6 @@ static struct irq_chip gpio_irq_chip = {
 
 /*---------------------------------------------------------------------*/
 
-#define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
-
 static int omap_mpuio_suspend_noirq(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -755,10 +753,6 @@ static inline void mpuio_init(struct gpio_bank *bank)
 
 /*---------------------------------------------------------------------*/
 
-/* REVISIT these are stupid implementations!  replace by ones that
- * don't switch on METHOD_* and which mostly avoid spinlocks
- */
-
 static int gpio_input(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank;
@@ -879,7 +873,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 	if (bank->width == 16)
 		l = 0xffff;
 
-	if (bank_is_mpuio(bank)) {
+	if (bank->is_mpuio) {
 		__raw_writel(l, bank->base + bank->regs->irqenable);
 		return;
 	}
@@ -920,7 +914,6 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	int j;
 	static int gpio;
 
-	bank->mod_usage = 0;
 	/*
 	 * REVISIT eventually switch from OMAP-specific gpio structs
 	 * over to the generic ones
@@ -933,7 +926,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 	bank->chip.set_debounce = gpio_debounce;
 	bank->chip.set = gpio_set;
 	bank->chip.to_irq = gpio_2irq;
-	if (bank_is_mpuio(bank)) {
+	if (bank->is_mpuio) {
 		bank->chip.label = "mpuio";
 		if (bank->regs->wkup_status)
 			bank->chip.dev = &omap_mpuio_device.dev;
@@ -951,7 +944,7 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
 		     j < bank->virtual_irq_start + bank->width; j++) {
 		irq_set_lockdep_class(j, &gpio_lock_class);
 		irq_set_chip_data(j, bank);
-		if (bank_is_mpuio(bank)) {
+		if (bank->is_mpuio) {
 			omap_mpuio_alloc_gc(bank, j, bank->width);
 		} else {
 			irq_set_chip(j, &gpio_irq_chip);
@@ -995,11 +988,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 
 	pdata = pdev->dev.platform_data;
 	bank->virtual_irq_start = pdata->virtual_irq_start;
-	bank->method = pdata->bank_type;
 	bank->dev = &pdev->dev;
 	bank->dbck_flag = pdata->dbck_flag;
 	bank->stride = pdata->bank_stride;
 	bank->width = pdata->bank_width;
+	bank->is_mpuio = pdata->is_mpuio;
 	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
 	bank->loses_context = pdata->loses_context;
 	bank->get_context_loss_count = pdata->get_context_loss_count;
@@ -1032,7 +1025,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
 	pm_runtime_enable(bank->dev);
 	pm_runtime_get_sync(bank->dev);
 
-	if (bank_is_mpuio(bank)) {
+	if (bank->is_mpuio) {
 		if (bank->regs->wkup_status)
 			mpuio_init(bank);
 	}
-- 
1.7.0.4

