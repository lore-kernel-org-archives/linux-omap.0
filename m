From: Charulatha V <charu@ti.com>
Subject: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Thu, 22 Apr 2010 21:25:20 +0530
Message-ID: <1271951720-21714-10-git-send-email-charu@ti.com>
References: <1271951720-21714-1-git-send-email-charu@ti.com>
 <1271951720-21714-2-git-send-email-charu@ti.com>
 <1271951720-21714-3-git-send-email-charu@ti.com>
 <1271951720-21714-4-git-send-email-charu@ti.com>
 <1271951720-21714-5-git-send-email-charu@ti.com>
 <1271951720-21714-6-git-send-email-charu@ti.com>
 <1271951720-21714-7-git-send-email-charu@ti.com>
 <1271951720-21714-8-git-send-email-charu@ti.com>
 <1271951720-21714-9-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755903Ab0DVPzE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 11:55:04 -0400
In-Reply-To: <1271951720-21714-9-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: rnayak@ti.com, paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com, Charulatha V <charu@ti.com>

This patch implements GPIO as a early platform device. Also it
implements OMAP2PLUS specific GPIO as HWMOD FW adapted driver.

Inorder to convert GPIO as platform device, modifications are
required in clockxxxx_data.c files so that device names can be
used to obtain clock instead of getting clocks by name/NULL ptr.

Currently early platform device register does not do device_pm_init.
Hence pm_runtime functions are not used to enable the GPIO device
since gpio is early platform device.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap1/Makefile           |    6 +
 arch/arm/mach-omap1/clock_data.c       |    2 +-
 arch/arm/mach-omap2/Makefile           |    2 +-
 arch/arm/mach-omap2/clock2420_data.c   |   10 +-
 arch/arm/mach-omap2/clock2430_data.c   |   14 +-
 arch/arm/mach-omap2/clock3xxx_data.c   |   24 +-
 arch/arm/mach-omap2/clock44xx_data.c   |   24 +-
 arch/arm/plat-omap/gpio.c              |  405 ++++++++++++--------------------
 arch/arm/plat-omap/include/plat/gpio.h |   21 ++
 9 files changed, 220 insertions(+), 288 deletions(-)

diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
index b6a537c..dabd2be 100644
--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -45,6 +45,12 @@ ifeq ($(CONFIG_ARCH_OMAP15XX),y)
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
index aa8558a..9bc2aa1 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -589,7 +589,7 @@ static struct omap_clk omap_clks[] = {
 	CLK(NULL,	"ck_sossi",	&sossi_ck,	CK_16XX),
 	CLK(NULL,	"arm_ck",	&arm_ck,	CK_16XX | CK_1510 | CK_310),
 	CLK(NULL,	"armper_ck",	&armper_ck.clk,	CK_16XX | CK_1510 | CK_310),
-	CLK(NULL,	"arm_gpio_ck",	&arm_gpio_ck,	CK_1510 | CK_310),
+	CLK("omap-gpio.0", "arm_gpio_ck", &arm_gpio_ck,	CK_1510 | CK_310),
 	CLK(NULL,	"armxor_ck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
 	CLK(NULL,	"armtim_ck",	&armtim_ck.clk,	CK_16XX | CK_1510 | CK_310),
 	CLK("omap_wdt",	"fck",		&armwdt_ck.clk,	CK_16XX | CK_1510 | CK_310),
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..6bb8042 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o
+obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer-gp.o gpio.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index d932b14..a693403 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1802,8 +1802,14 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
+	CLK("omap-gpio.0",	"ick",	&gpios_ick,	CK_242X),
+	CLK("omap-gpio.1",	"ick",	&gpios_ick,	CK_242X),
+	CLK("omap-gpio.2",	"ick",	&gpios_ick,	CK_242X),
+	CLK("omap-gpio.3",	"ick",	&gpios_ick,	CK_242X),
+	CLK("omap-gpio.0",	"fck",	&gpios_fck,	CK_242X),
+	CLK("omap-gpio.1",	"fck",	&gpios_fck,	CK_242X),
+	CLK("omap-gpio.2",	"fck",	&gpios_fck,	CK_242X),
+	CLK("omap-gpio.3",	"fck",	&gpios_fck,	CK_242X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_242X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 0438b6e..56bbcbc 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -1896,8 +1896,14 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
+	CLK("omap-gpio.0",	"ick",	&gpios_ick,	CK_243X),
+	CLK("omap-gpio.1",	"ick",	&gpios_ick,	CK_243X),
+	CLK("omap-gpio.2",	"ick",	&gpios_ick,	CK_243X),
+	CLK("omap-gpio.3",	"ick",	&gpios_ick,	CK_243X),
+	CLK("omap-gpio.0",	"fck",	&gpios_fck,	CK_243X),
+	CLK("omap-gpio.1",	"fck",	&gpios_fck,	CK_243X),
+	CLK("omap-gpio.2",	"fck",	&gpios_fck,	CK_243X),
+	CLK("omap-gpio.3",	"fck",	&gpios_fck,	CK_243X),
 	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
 	CLK("omap_wdt",	"fck",		&mpu_wdt_fck,	CK_243X),
 	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
@@ -1934,8 +1940,8 @@ static struct omap_clk omap2430_clks[] = {
 	CLK("mmci-omap-hs.0", "fck",	&mmchs1_fck,	CK_243X),
 	CLK("mmci-omap-hs.1", "ick",	&mmchs2_ick,	CK_243X),
 	CLK("mmci-omap-hs.1", "fck",	&mmchs2_fck,	CK_243X),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
-	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
+	CLK("omap-gpio.4",	"ick",	&gpio5_ick,	CK_243X),
+	CLK("omap-gpio.4",	"fck",	&gpio5_fck,	CK_243X),
 	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
 	CLK("mmci-omap-hs.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
 	CLK("mmci-omap-hs.1", "mmchsdb_fck", 	&mmchsdb2_fck,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..9efbaac 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3407,13 +3407,13 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
-	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
+	CLK("omap-gpio.0",	"dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
 	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
-	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
+	CLK("omap-gpio.0",	"ick",	&gpio1_ick,	CK_3XXX),
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
@@ -3429,18 +3429,18 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
 	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
 	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
-	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_3XXX),
+	CLK("omap-gpio.5",	"dbck",	&gpio6_dbck,	CK_3XXX),
+	CLK("omap-gpio.4",	"dbck",	&gpio5_dbck,	CK_3XXX),
+	CLK("omap-gpio.3",	"dbck",	&gpio4_dbck,	CK_3XXX),
+	CLK("omap-gpio.2",	"dbck",	&gpio3_dbck,	CK_3XXX),
+	CLK("omap-gpio.1",	"dbck",	&gpio2_dbck,	CK_3XXX),
 	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_3XXX),
 	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_3XXX),
-	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_3XXX),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_3XXX),
-	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_3XXX),
-	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_3XXX),
-	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
+	CLK("omap-gpio.5",	"ick",	&gpio6_ick,	CK_3XXX),
+	CLK("omap-gpio.4",	"ick",	&gpio5_ick,	CK_3XXX),
+	CLK("omap-gpio.3",	"ick",	&gpio4_ick,	CK_3XXX),
+	CLK("omap-gpio.2",	"ick",	&gpio3_ick,	CK_3XXX),
+	CLK("omap-gpio.1",	"ick",	&gpio2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
 	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 28b1079..1cfb323 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2566,12 +2566,12 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
 	CLK(NULL,	"per_sgx_fclk",			&per_sgx_fclk,	CK_443X),
 	CLK(NULL,	"gfx_fck",			&gfx_fck,	CK_443X),
-	CLK(NULL,	"gpio1_ick",			&gpio1_ick,	CK_443X),
-	CLK(NULL,	"gpio2_ick",			&gpio2_ick,	CK_443X),
-	CLK(NULL,	"gpio3_ick",			&gpio3_ick,	CK_443X),
-	CLK(NULL,	"gpio4_ick",			&gpio4_ick,	CK_443X),
-	CLK(NULL,	"gpio5_ick",			&gpio5_ick,	CK_443X),
-	CLK(NULL,	"gpio6_ick",			&gpio6_ick,	CK_443X),
+	CLK("omap-gpio.0",	"ick",			&gpio1_ick,	CK_443X),
+	CLK("omap-gpio.1",	"ick",			&gpio2_ick,	CK_443X),
+	CLK("omap-gpio.2",	"ick",			&gpio3_ick,	CK_443X),
+	CLK("omap-gpio.3",	"ick",			&gpio4_ick,	CK_443X),
+	CLK("omap-gpio.4",	"ick",			&gpio5_ick,	CK_443X),
+	CLK("omap-gpio.5",	"ick",			&gpio6_ick,	CK_443X),
 	CLK(NULL,	"gpmc_ick",			&gpmc_ick,	CK_443X),
 	CLK(NULL,	"gpt1_fck",			&gpt1_fck,	CK_443X),
 	CLK(NULL,	"gpt10_fck",			&gpt10_fck,	CK_443X),
@@ -2645,12 +2645,12 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
 	CLK(NULL,	"utmi_p1_gfclk_ck",		&utmi_p1_gfclk_ck,	CK_443X),
 	CLK(NULL,	"utmi_p2_gfclk_ck",		&utmi_p2_gfclk_ck,	CK_443X),
-	CLK(NULL,	"gpio1_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio2_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio3_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio4_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio5_dbck",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"gpio6_dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.0",	"dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.1",	"dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.2",	"dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.3",	"dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.4",	"dbck",			&dummy_ck,	CK_443X),
+	CLK("omap-gpio.5",	"dbck",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpmc_ck",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt1_ick",			&dummy_ck,	CK_443X),
 	CLK(NULL,	"gpt2_ick",			&dummy_ck,	CK_443X),
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c8f2c3c..f0fee4c 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -27,6 +27,7 @@
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <asm/mach/irq.h>
+#include <plat/clock.h>
 
 /*
  * OMAP1510 GPIO registers
@@ -147,102 +148,13 @@ struct gpio_bank {
 	struct gpio_chip chip;
 	struct clk *dbck;
 	u32 mod_usage;
+	u8  initialized;
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
 };
 
-#define METHOD_MPUIO		0
-#define METHOD_GPIO_1510	1
-#define METHOD_GPIO_1610	2
-#define METHOD_GPIO_7XX		3
-#define METHOD_GPIO_24XX	5
-#define METHOD_GPIO_44XX	6
-
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
 	u32 sysconfig;
 	u32 irqenable1;
@@ -262,26 +174,9 @@ struct omap3_gpio_regs {
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
-
-#endif
-
 static struct gpio_bank *gpio_bank;
 static int gpio_bank_count;
+static int gpio_bank_bits;
 
 static inline struct gpio_bank *get_gpio_bank(int gpio)
 {
@@ -1467,7 +1362,8 @@ static struct platform_device omap_mpuio_device = {
 
 static inline void mpuio_init(void)
 {
-	platform_set_drvdata(&omap_mpuio_device, &gpio_bank_1610[0]);
+	struct gpio_bank *bank = get_gpio_bank(OMAP_MPUIO(0));
+	platform_set_drvdata(&omap_mpuio_device, bank);
 
 	if (platform_driver_register(&omap_mpuio_driver) == 0)
 		(void) platform_device_register(&omap_mpuio_device);
@@ -1582,22 +1478,6 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 /*---------------------------------------------------------------------*/
 
 static int initialized;
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
 
 static void __init omap_gpio_show_rev(void)
 {
@@ -1621,6 +1501,34 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
+static int init_gpio_info(void)
+{
+	gpio_bank_bits = 32;
+
+	if (cpu_is_omap15xx()) {
+		gpio_bank_count = 2;
+		gpio_bank_bits = 16;
+	} else if (cpu_is_omap16xx()) {
+		gpio_bank_count = 5;
+		gpio_bank_bits = 16;
+	} else if (cpu_is_omap7xx())
+		gpio_bank_count = 7;
+	else if (cpu_is_omap242x())
+		gpio_bank_count = 4;
+	else if (cpu_is_omap243x())
+		gpio_bank_count = 5;
+	else if (cpu_is_omap34xx() || cpu_is_omap44xx())
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
+
+	gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
+				GFP_KERNEL);
+	if (!gpio_bank) {
+		pr_err("Memory allocation failed for gpio_bank\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 {
 	if (cpu_class_is_omap2()) {
@@ -1686,16 +1594,9 @@ static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
 
 static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 {
-	int j, gpio_bank_bits = 16;
+	int j;
 	static int gpio;
 
-	if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
-		gpio_bank_bits = 32; /* 7xx has 32-bit GPIOs */
-
-	if ((bank->method == METHOD_GPIO_24XX) ||
-			(bank->method == METHOD_GPIO_44XX))
-		gpio_bank_bits = 32;
-
 	bank->mod_usage = 0;
 	/* REVISIT eventually switch from OMAP-specific gpio structs
 	 * over to the generic ones
@@ -1737,140 +1638,103 @@ static void __init omap_gpio_chip_init(struct gpio_bank *bank)
 	set_irq_data(bank->irq, bank);
 }
 
-static int __init _omap_gpio_init(void)
+static inline void get_gpio_dbck(struct platform_device *pdev,
+				struct gpio_bank *bank)
 {
-	int i;
-	int gpio = 0;
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		bank->dbck = clk_get(&pdev->dev, "dbck");
+		if (IS_ERR(bank->dbck))
+			pr_err("GPIO: Could not get dbck\n");
+	}
+}
+
+static int __devinit omap_gpio_probe(struct platform_device *pdev)
+{
+	static int gpio_init_done;
+	struct omap_gpio_platform_data *pdata;
+	int id;
 	struct gpio_bank *bank;
-	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-	char clk_name[11];
+	struct resource *res;
 
-	initialized = 1;
+	if (!gpio_init_done)
+		init_gpio_info();
 
-#if defined(CONFIG_ARCH_OMAP1)
-	if (cpu_is_omap15xx()) {
-		gpio_ick = clk_get(NULL, "arm_gpio_ck");
-		if (IS_ERR(gpio_ick))
-			printk("Could not get arm_gpio_ck\n");
-		else
-			clk_enable(gpio_ick);
+	if (!pdev || !pdev->dev.platform_data) {
+		pr_err("GPIO device initialize without"
+					"platform data\n");
+		return -EINVAL;
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
+	pdata = pdev->dev.platform_data;
 
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
+	id = pdev->id;
+	if (id > gpio_bank_count) {
+		pr_err("Invalid GPIO device id (%d)\n", id);
+		return -EINVAL;
 	}
-#endif
 
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
-	}
-#endif
-#ifdef CONFIG_ARCH_OMAP3
-	if (cpu_is_omap34xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_34xx;
+	if (bank->initialized == 1) {
+		/*
+		 * Currently, for early platform_devices,
+		 * clk_get() using dev ptr does not seem to be working
+		 * Hence getting dbck during regular device probe
+		 */
+		get_gpio_dbck(pdev, bank);
+		return 0;
 	}
-#endif
-#ifdef CONFIG_ARCH_OMAP4
-	if (cpu_is_omap44xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_44xx;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!res)) {
+		pr_err("GPIO Bank %i Invalid IRQ resource\n", id);
+		return -ENODEV;
 	}
-#endif
-	for (i = 0; i < gpio_bank_count; i++) {
+	bank->irq = res->start;
+	bank->virtual_irq_start = pdata->virtual_irq_start;
+	bank->base = pdata->base;
+	bank->method = pdata->method;
 
-		bank = &gpio_bank[i];
-		spin_lock_init(&bank->lock);
+	spin_lock_init(&bank->lock);
 
+	if (cpu_class_is_omap2()) {
+		bank->device_enable = pdata->device_enable;
+		bank->device_idle = pdata->device_idle;
+		bank->device_shutdown = pdata->device_shutdown;
+		pdata->device_enable(pdev);
+	} else if (cpu_class_is_omap1()) {
 		/* Static mapping, never released */
-		bank->base = ioremap(bank->pbase, bank_size);
-		if (!bank->base) {
-			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
-			continue;
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (unlikely(!res)) {
+			pr_err("GPIO Bank %i Invalid mem resource\n", id);
+			return -ENODEV;
 		}
 
-		omap_gpio_mod_init(bank, i);
-		omap_gpio_chip_init(bank);
+		bank->base = ioremap(res->start, resource_size(res));
+		if (!bank->base) {
+			pr_err("Could not ioremap gpio bank%i\n", id);
+			return -ENOMEM;
+		}
 
-		if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-			sprintf(clk_name, "gpio%d_dbck", i + 1);
-			bank->dbck = clk_get(NULL, clk_name);
-			if (IS_ERR(bank->dbck))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
+		if (cpu_is_omap15xx() && (id == 0)) {
+			static struct clk *gpio_clk;
+			gpio_clk = clk_get(&pdev->dev, "arm_gpio_ck");
+			if (IS_ERR(gpio_clk))
+				pr_err("Could not get arm_gpio_ck\n");
+			else
+				clk_enable(gpio_clk);
 		}
 	}
 
-	omap_gpio_show_rev();
+	omap_gpio_mod_init(bank, id);
+	omap_gpio_chip_init(bank);
 
+	if (!gpio_init_done) {
+		omap_gpio_show_rev();
+		gpio_init_done = 1;
+	}
+
+	bank->initialized = 1;
 	return 0;
 }
 
@@ -2210,16 +2074,42 @@ void omap_gpio_restore_context(void)
 }
 #endif
 
-/*
- * This may get called early from board specific init
- * for boards that have interrupts routed via FPGA.
- */
+static struct platform_driver omap_gpio_driver = {
+	.probe		= omap_gpio_probe,
+	.driver		= {
+		.name	= "omap-gpio",
+	},
+};
+
+int __init omap_gpio_drv_reg(void)
+{
+	return platform_driver_register(&omap_gpio_driver);
+}
+
+early_platform_init("earlygpio", &omap_gpio_driver);
+
 int __init omap_gpio_init(void)
 {
-	if (!initialized)
-		return _omap_gpio_init();
-	else
+	int ret = 0;
+
+	if (initialized)
 		return 0;
+
+#ifdef CONFIG_ARCH_OMAP1
+	if (cpu_is_omap7xx())
+		ret = omap7xx_gpio_init();
+	if (cpu_is_omap15xx())
+		ret = omap15xx_gpio_init();
+	if (cpu_is_omap16xx())
+		ret = omap16xx_gpio_init();
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (cpu_class_is_omap2())
+		ret = omap2_gpio_init();
+#endif
+	initialized = 1;
+
+	return ret;
 }
 
 static int __init omap_gpio_sysinit(void)
@@ -2227,7 +2117,10 @@ static int __init omap_gpio_sysinit(void)
 	int ret = 0;
 
 	if (!initialized)
-		ret = _omap_gpio_init();
+		ret = omap_gpio_init();
+
+	if (!ret)
+		ret = omap_gpio_drv_reg();
 
 	mpuio_init();
 
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index a06acb6..7dca19a 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -28,6 +28,7 @@
 
 #include <linux/io.h>
 #include <mach/irqs.h>
+#include <linux/platform_device.h>
 
 #define OMAP1_MPUIO_BASE		0xfffb5000
 #define OMAP1_MPUIO_VBASE		OMAP1_MPUIO_BASE
@@ -137,6 +138,16 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+struct omap_gpio_platform_data {
+	void __iomem *base;
+	u16 irq;
+	u16 virtual_irq_start;
+	int method;
+	int (*device_enable)(struct platform_device *pdev);
+	int (*device_idle)(struct platform_device *pdev);
+	int (*device_shutdown) (struct platform_device *pdev);
+};
+
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
@@ -144,6 +155,16 @@ extern void omap_set_gpio_debounce(int gpio, int enable);
 extern void omap_set_gpio_debounce_time(int gpio, int enable);
 extern void omap_gpio_save_context(void);
 extern void omap_gpio_restore_context(void);
+
+#ifdef CONFIG_ARCH_OMAP1
+extern int omap7xx_gpio_init(void);
+extern int omap15xx_gpio_init(void);
+extern int omap16xx_gpio_init(void);
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+extern int omap2_gpio_init(void);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
-- 
1.6.3.3

