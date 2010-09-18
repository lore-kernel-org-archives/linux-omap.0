From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v6 10/13] OMAP: GPIO: Implement GPIO as a platform device
Date: Sat, 18 Sep 2010 19:45:50 +0530
Message-ID: <1284819353-8512-11-git-send-email-charu@ti.com>
References: <1284819353-8512-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56370 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755290Ab0IROQS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Sep 2010 10:16:18 -0400
In-Reply-To: <1284819353-8512-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, "Varadarajan, Charulatha" <charu@ti.com>

This patch implements GPIO as a platform device.

GPIO APIs are used in machine_init functions. Hence it is
required to complete GPIO probe before board_init. Therefore
GPIO device register and driver register are implemented as
postcore_initcalls.

Inorder to convert GPIO as platform device, modifications are
required in clockxxxx_data.c file for OMAP1 so that device names
can be used to obtain clock instead of getting clocks by
name/NULL ptr.

Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks, sysconfig settings instead of using
clock FW APIs.

Converting to runtime PM API is not done as a separate patch
because GPIO clock names are different for various OMAPs and
also different for some of the banks in the same CPU.
This would need usage of cpu_is checks and bank id checks
while using clock FW APIs in the gpio driver. Hence while making
GPIO a platform driver framework, PM runtime APIs are used directly.

omap_gpio_init() does nothing now and this function would be
removed in one of the next patches in this patch series as
it's usage is spread across most of the board files.

GPIO driver currently uses sysdev_class. One of the next patches
in this patch series makes GPIO driver to use dev_pm_ops instead
of sysdev_class.

TODO:
1. Cleanup the GPIO driver. Use function pointers and register
offest pointers instead of using hardcoded values
2. Remove all cpu_is_ checks and OMAP specific macros
3. Remove usage of gpio_bank array so that only
instance specific information is used in driver code
4. Rename 'method'/ avoid it's usage
5. Fix the non-wakeup gpios handling for OMAP2430, OMAP3 & OMAP4
6. Investigate why GPIO hwmods are not reset on init

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Reviewed-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    6 +
 arch/arm/mach-omap1/clock_data.c       |    4 +-
 arch/arm/mach-omap2/Makefile           |    3 +-
 arch/arm/plat-omap/gpio.c              |  428 ++++++++------------------------
 arch/arm/plat-omap/include/plat/gpio.h |    3 +
 5 files changed, 121 insertions(+), 323 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index 9a304d8..b014bb1 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -49,6 +49,12 @@ ifeq ($(CONFIG_ARCH_OMAP15XX),y)
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= fpga.o
 endif
 
+# GPIO
+obj-$(CONFIG_ARCH_OMAP730)		+= gpio7xx.o
+obj-$(CONFIG_ARCH_OMAP850)		+= gpio7xx.o
+obj-$(CONFIG_ARCH_OMAP15XX)		+= gpio15xx.o
+obj-$(CONFIG_ARCH_OMAP16XX)		+= gpio16xx.o
+
 # LEDs support
 led-$(CONFIG_MACH_OMAP_H2)		+= leds-h2p2-debug.o
 led-$(CONFIG_MACH_OMAP_H3)		+= leds-h2p2-debug.o
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index af54114..cbdcf9c 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -143,7 +143,7 @@ static struct arm_idlect1_clk armper_ck = {
  * activation.  [ GPIO code for 1510 ]
  */
 static struct clk arm_gpio_ck = {
-	.name		= "arm_gpio_ck",
+	.name		= "ick",
 	.ops		= &clkops_generic,
 	.parent		= &ck_dpll1,
 	.flags		= ENABLE_ON_INIT,
@@ -684,7 +684,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
 	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
+	CLK("omap-gpio.0", "ick", &arm_gpio_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index a88b75a..3520664 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,8 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o pm.o \
+		gpio.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index e34bc60..fa324bb 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -21,6 +21,8 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
@@ -34,7 +36,6 @@ static struct powerdomain *per_pwrdm;
 /*
  * OMAP1510 GPIO registers
  */
-#define OMAP1510_GPIO_BASE		0xfffce000
 #define OMAP1510_GPIO_DATA_INPUT	0x00
 #define OMAP1510_GPIO_DATA_OUTPUT	0x04
 #define OMAP1510_GPIO_DIR_CONTROL	0x08
@@ -48,10 +49,6 @@ static struct powerdomain *per_pwrdm;
 /*
  * OMAP1610 specific GPIO registers
  */
-#define OMAP1610_GPIO1_BASE		0xfffbe400
-#define OMAP1610_GPIO2_BASE		0xfffbec00
-#define OMAP1610_GPIO3_BASE		0xfffbb400
-#define OMAP1610_GPIO4_BASE		0xfffbbc00
 #define OMAP1610_GPIO_REVISION		0x0000
 #define OMAP1610_GPIO_SYSCONFIG		0x0010
 #define OMAP1610_GPIO_SYSSTATUS		0x0014
@@ -73,12 +70,6 @@ static struct powerdomain *per_pwrdm;
 /*
  * OMAP7XX specific GPIO registers
  */
-#define OMAP7XX_GPIO1_BASE		0xfffbc000
-#define OMAP7XX_GPIO2_BASE		0xfffbc800
-#define OMAP7XX_GPIO3_BASE		0xfffbd000
-#define OMAP7XX_GPIO4_BASE		0xfffbd800
-#define OMAP7XX_GPIO5_BASE		0xfffbe000
-#define OMAP7XX_GPIO6_BASE		0xfffbe800
 #define OMAP7XX_GPIO_DATA_INPUT		0x00
 #define OMAP7XX_GPIO_DATA_OUTPUT	0x04
 #define OMAP7XX_GPIO_DIR_CONTROL	0x08
@@ -86,25 +77,7 @@ static struct powerdomain *per_pwrdm;
 #define OMAP7XX_GPIO_INT_MASK		0x10
 #define OMAP7XX_GPIO_INT_STATUS		0x14
 
-#define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
-
-/*
- * omap24xx specific GPIO registers
- */
-#define OMAP242X_GPIO1_BASE		0x48018000
-#define OMAP242X_GPIO2_BASE		0x4801a000
-#define OMAP242X_GPIO3_BASE		0x4801c000
-#define OMAP242X_GPIO4_BASE		0x4801e000
-
-#define OMAP243X_GPIO1_BASE		0x4900C000
-#define OMAP243X_GPIO2_BASE		0x4900E000
-#define OMAP243X_GPIO3_BASE		0x49010000
-#define OMAP243X_GPIO4_BASE		0x49012000
-#define OMAP243X_GPIO5_BASE		0x480B6000
-
 #define OMAP24XX_GPIO_REVISION		0x0000
-#define OMAP24XX_GPIO_SYSCONFIG		0x0010
-#define OMAP24XX_GPIO_SYSSTATUS		0x0014
 #define OMAP24XX_GPIO_IRQSTATUS1	0x0018
 #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
 #define OMAP24XX_GPIO_IRQENABLE2	0x002c
@@ -128,7 +101,6 @@ static struct powerdomain *per_pwrdm;
 #define OMAP24XX_GPIO_SETDATAOUT	0x0094
 
 #define OMAP4_GPIO_REVISION		0x0000
-#define OMAP4_GPIO_SYSCONFIG		0x0010
 #define OMAP4_GPIO_EOI			0x0020
 #define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
 #define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
@@ -140,7 +112,6 @@ static struct powerdomain *per_pwrdm;
 #define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
 #define OMAP4_GPIO_IRQWAKEN0		0x0044
 #define OMAP4_GPIO_IRQWAKEN1		0x0048
-#define OMAP4_GPIO_SYSSTATUS		0x0114
 #define OMAP4_GPIO_IRQENABLE1		0x011c
 #define OMAP4_GPIO_WAKE_EN		0x0120
 #define OMAP4_GPIO_IRQSTATUS2		0x0128
@@ -161,26 +132,6 @@ static struct powerdomain *per_pwrdm;
 #define OMAP4_GPIO_SETWKUENA		0x0184
 #define OMAP4_GPIO_CLEARDATAOUT		0x0190
 #define OMAP4_GPIO_SETDATAOUT		0x0194
-/*
- * omap34xx specific GPIO registers
- */
-
-#define OMAP34XX_GPIO1_BASE		0x48310000
-#define OMAP34XX_GPIO2_BASE		0x49050000
-#define OMAP34XX_GPIO3_BASE		0x49052000
-#define OMAP34XX_GPIO4_BASE		0x49054000
-#define OMAP34XX_GPIO5_BASE		0x49056000
-#define OMAP34XX_GPIO6_BASE		0x49058000
-
-/*
- * OMAP44XX  specific GPIO registers
- */
-#define OMAP44XX_GPIO1_BASE             0x4a310000
-#define OMAP44XX_GPIO2_BASE             0x48055000
-#define OMAP44XX_GPIO3_BASE             0x48057000
-#define OMAP44XX_GPIO4_BASE             0x48059000
-#define OMAP44XX_GPIO5_BASE             0x4805B000
-#define OMAP44XX_GPIO6_BASE             0x4805D000
 
 struct gpio_bank {
 	unsigned long pbase;
@@ -205,100 +156,15 @@ struct gpio_bank {
 	struct clk *dbck;
 	u32 mod_usage;
 	u32 dbck_enable_mask;
+	struct device *dev;
+	bool dbck_flag;
 };
 
 static void omap3_gpio_restore_context(void);
 static void omap3_gpio_save_context(void);
 
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
 #ifdef CONFIG_ARCH_OMAP3
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
 struct omap3_gpio_regs {
-	u32 sysconfig;
 	u32 irqenable1;
 	u32 irqenable2;
 	u32 wake_en;
@@ -314,26 +180,16 @@ struct omap3_gpio_regs {
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
 #endif
 
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
+/*
+ * TODO: Cleanup gpio_bank usage as it is having information
+ * related to all instances of the device
+ */
+static struct gpio_bank *gpio_bank;
 
-#endif
+static int bank_width;
 
-static struct gpio_bank *gpio_bank;
-static int gpio_bank_count;
+/* TODO: Analyze removing gpio_bank_count usage from driver code */
+int gpio_bank_count;
 
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
@@ -638,6 +494,9 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	u32			val;
 	u32			l;
 
+	if (!bank->dbck_flag)
+		return;
+
 	if (debounce < 32)
 		debounce = 0x01;
 	else if (debounce > 7936)
@@ -647,7 +506,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = 1 << get_gpio_index(gpio);
 
-	if (cpu_is_omap44xx())
+	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCINGTIME;
 	else
 		reg += OMAP24XX_GPIO_DEBOUNCE_VAL;
@@ -655,7 +514,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	__raw_writel(debounce, reg);
 
 	reg = bank->base;
-	if (cpu_is_omap44xx())
+	if (bank->method == METHOD_GPIO_44XX)
 		reg += OMAP4_GPIO_DEBOUNCENABLE;
 	else
 		reg += OMAP24XX_GPIO_DEBOUNCE_EN;
@@ -664,12 +523,10 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	if (debounce) {
 		val |= l;
-		if (cpu_is_omap34xx() || cpu_is_omap44xx())
-			clk_enable(bank->dbck);
+		clk_enable(bank->dbck);
 	} else {
 		val &= ~l;
-		if (cpu_is_omap34xx() || cpu_is_omap44xx())
-			clk_disable(bank->dbck);
+		clk_disable(bank->dbck);
 	}
 	bank->dbck_enable_mask = val;
 
@@ -1536,7 +1393,8 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void mpuio_init(void)
 {
-	platform_set_drvdata(&omap_mpuio_device, &gpio_bank_1610[0]);
+	struct gpio_bank *bank = get_gpio_bank(OMAP_MPUIO(0));
+	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
 		(void) platform_device_register(&omap_mpuio_device);
@@ -1641,6 +1499,13 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 	unsigned long flags;
 
 	bank = container_of(chip, struct gpio_bank, chip);
+
+	if (!bank->dbck) {
+		bank->dbck = clk_get(bank->dev, "dbclk");
+		if (IS_ERR(bank->dbck))
+			dev_err(bank->dev, "Could not get gpio dbck\n");
+	}
+
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_debounce(bank, offset, debounce);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -1669,24 +1534,6 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 
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
 static void __init omap_gpio_show_rev(void)
 {
 	u32 rev;
@@ -1709,9 +1556,25 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
+static inline int init_gpio_info(struct platform_device *pdev)
+{
+	/* TODO: Analyze removing gpio_bank_count usage from driver code */
+	gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
+				GFP_KERNEL);
+	if (!gpio_bank) {
+		dev_err(&pdev->dev, "Memory alloc failed for gpio_bank\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+/* TODO: Cleanup cpu_is_* checks */
 static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 {
 	if (cpu_class_is_omap2()) {
+
+		per_pwrdm = pwrdm_lookup("per_pwrdm");
+
 		if (cpu_is_omap44xx()) {
 			__raw_writel(0xffffffff, bank->base +
 					OMAP4_GPIO_IRQSTATUSCLR0);
@@ -1770,16 +1633,9 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 
 static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 {
-	int j, bank_width = 16;
+	int j;
 	static int gpio;
 
-	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
-		bank_width = 32; /* 7xx has 32-bit GPIOs */
-
-	if ((bank->method == METHOD_GPIO_24XX) ||
-			(bank->method == METHOD_GPIO_44XX))
-		bank_width = 32;
-
 	bank->mod_usage = 0;
 	/* REVISIT eventually switch from OMAP-specific gpio structs
 	 * over to the generic ones
@@ -1822,141 +1678,68 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	set_irq_data(bank->irq, bank);
 }
 
-static int __init _omap_gpio_init(void)
+static int __devinit omap_gpio_probe(struct platform_device *pdev)
 {
-	int i;
+	static int gpio_init_done;
+	struct omap_gpio_platform_data *pdata;
+	int id;
 	struct gpio_bank *bank;
-	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-	char clk_name[11];
+	struct resource *res;
 
-	initialized = 1;
+	if (!pdev || !pdev->dev.platform_data)
+		return -EINVAL;
 
-#if defined(CONFIG_ARCH_OMAP1)
-	if (cpu_is_omap15xx()) {
-		gpio_ick = clk_get(NULL, "arm_gpio_ck");
-		if (IS_ERR(gpio_ick))
-			printk("Could not get arm_gpio_ck\n");
-		else
-			clk_enable(gpio_ick);
-	}
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
+	pdata = pdev->dev.platform_data;
 
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
+	if (!gpio_init_done) {
+		int ret;
 
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
+		ret = init_gpio_info(pdev);
+		if (ret)
+			return ret;
 	}
-#endif
 
-	if (cpu_class_is_omap2())
-		per_pwrdm = pwrdm_lookup("per_pwrdm");
+	id = pdev->id;
+	bank = &gpio_bank[id];
 
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
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!res)) {
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid IRQ resource\n", id);
+		return -ENODEV;
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap34xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_34xx;
+	bank->irq = res->start;
+	bank->virtual_irq_start = pdata->virtual_irq_start;
+	bank->method = pdata->bank_type;
+	bank->dev = &pdev->dev;
+	bank->dbck_flag = pdata->gpio_attr->dbck_flag;
+	bank_width = pdata->gpio_attr->bank_width;
+
+	spin_lock_init(&bank->lock);
+
+	/* Static mapping, never released */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		dev_err(&pdev->dev, "GPIO Bank %i Invalid mem resource\n", id);
+		return -ENODEV;
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (cpu_is_omap44xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_44xx;
+
+	bank->base = ioremap(res->start, resource_size(res));
+	if (!bank->base) {
+		dev_err(&pdev->dev, "Could not ioremap gpio bank%i\n", id);
+		return -ENOMEM;
 	}
-#endif
-	for (i = 0; i < gpio_bank_count; i++) {
 
-		bank = &gpio_bank[i];
-		spin_lock_init(&bank->lock);
+	pm_runtime_enable(bank->dev);
+	pm_runtime_get_sync(bank->dev);
 
-		/* Static mapping, never released */
-		bank->base = ioremap(bank->pbase, bank_size);
-		if (!bank->base) {
-			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
-			continue;
-		}
-
-		omap_gpio_mod_init(bank, i);
-		omap_gpio_chip_init(bank);
+	omap_gpio_mod_init(bank, id);
+	omap_gpio_chip_init(bank);
 
-		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-			sprintf(clk_name, "gpio%d_dbck", i + 1);
-			bank->dbck = clk_get(NULL, clk_name);
-			if (IS_ERR(bank->dbck))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-		}
+	if (!gpio_init_done) {
+		omap_gpio_show_rev();
+		gpio_init_done = 1;
 	}
 
-	omap_gpio_show_rev();
-
 	return 0;
 }
 
@@ -2270,8 +2053,6 @@ static void omap3_gpio_save_context(void)
 	/* saving banks from 2-6 only since GPIO1 is in WKUP */
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		gpio_context[i].sysconfig =
-			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
 		gpio_context[i].irqenable1 =
 			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		gpio_context[i].irqenable2 =
@@ -2302,8 +2083,6 @@ static void omap3_gpio_restore_context(void)
 
 	for (i = 1; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		__raw_writel(gpio_context[i].sysconfig,
-				bank->base + OMAP24XX_GPIO_SYSCONFIG);
 		__raw_writel(gpio_context[i].irqenable1,
 				bank->base + OMAP24XX_GPIO_IRQENABLE1);
 		__raw_writel(gpio_context[i].irqenable2,
@@ -2328,25 +2107,34 @@ static void omap3_gpio_restore_context(void)
 }
 #endif
 
+static struct platform_driver omap_gpio_driver = {
+	.probe		= omap_gpio_probe,
+	.driver		= {
+		.name	= "omap-gpio",
+	},
+};
+
 /*
- * This may get called early from board specific init
- * for boards that have interrupts routed via FPGA.
+ * gpio driver register needs to be done before
+ * machine_init functions access gpio APIs.
+ * Hence omap_gpio_drv_reg() is a postcore_initcall.
  */
+static int __init omap_gpio_drv_reg(void)
+{
+	return platform_driver_register(&omap_gpio_driver);
+}
+postcore_initcall(omap_gpio_drv_reg);
+
+/* TODO: Remove omap_gpio_init() and its usage from board files */
 int __init omap_gpio_init(void)
 {
-	if (!initialized)
-		return _omap_gpio_init();
-	else
-		return 0;
+	return 0;
 }
 
 static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	if (!initialized)
-		ret = _omap_gpio_init();
-
 	mpuio_init();
 
 #if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index c8a70d7..60370bd 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -93,6 +93,9 @@ struct omap_gpio_platform_data {
 	struct powerdomain *pwrdm;
 };
 
+/* TODO: Analyze removing gpio_bank_count usage from driver code */
+extern int gpio_bank_count;
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(void);
 extern void omap2_gpio_resume_after_idle(void);
-- 
1.7.0.4

