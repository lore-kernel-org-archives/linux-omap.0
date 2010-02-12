From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH 3/4 RFC]OMAP:Convert GPIO into a early driver
Date: Fri, 12 Feb 2010 19:07:30 +0530
Message-ID: <1265981851-11970-4-git-send-email-charu@ti.com>
References: <1265981851-11970-1-git-send-email-charu@ti.com>
 <1265981851-11970-2-git-send-email-charu@ti.com>
 <1265981851-11970-3-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756175Ab0BLNiu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Feb 2010 08:38:50 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1CDckvm022033
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 12 Feb 2010 07:38:49 -0600
In-Reply-To: <1265981851-11970-3-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

This patch converts GPIO module into a platform driver by
making each GPIO Bank a device. This is done by providing
clock, interrupt and base address details through platform data.

This patch also initializes GPIO driver as a earlydriver. This is
so that GPIO devices are initialized very early on during bootup.

In board files, omap_init_irq is moved before omap2_init_common_hw
so that omap_init_irq is completed before early drivers uses irqs.

The device structures introduced in this patch would be later removed
when GPIO driver gets adapted to HWmod framework

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-3630sdp.c        |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c        |    3 +-
 arch/arm/mach-omap2/board-am3517evm.c      |    4 +-
 arch/arm/mach-omap2/board-apollon.c        |    3 +-
 arch/arm/mach-omap2/board-ldp.c            |    3 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    3 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    3 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    3 +-
 arch/arm/mach-omap2/board-omap3touchbook.c |    3 +-
 arch/arm/mach-omap2/board-overo.c          |    3 +-
 arch/arm/mach-omap2/board-rx51.c           |    3 +-
 arch/arm/mach-omap2/board-zoom2.c          |    3 +-
 arch/arm/mach-omap2/board-zoom3.c          |    3 +-
 arch/arm/mach-omap2/gpio.c                 | 1230 +++++++++++++++++++++-------
 arch/arm/mach-omap2/io.c                   |    2 +
 arch/arm/plat-omap/include/plat/gpio.h     |  130 +++-
 18 files changed, 1085 insertions(+), 323 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 3f45d4b..ad05cde 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -146,9 +146,8 @@ static void __init omap_2430sdp_init_irq(void)
 {
 	omap_board_config = sdp2430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 }
 
 static struct twl4030_gpio_platform_data sdp2430_gpio_data = {
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index b4ffcff..820b34c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -344,10 +344,9 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
 	omap3_pm_init_vc(&omap3_setuptime_table);
+	omap_init_irq();
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static int sdp3430_batt_table[] = {
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 0b6dd04..fdc2762 100755
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -79,11 +79,10 @@ static void __init omap_sdp_init_irq(void)
 {
 	omap_board_config = sdp_config;
 	omap_board_config_size = ARRAY_SIZE(sdp_config);
+	omap_init_irq();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
                              NULL, NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index cc4c00d..ace6be7 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -69,12 +69,11 @@ static void __init omap_4430sdp_init_irq(void)
 {
 	omap_board_config = sdp4430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp4430_config);
+	gic_init_irq();
 	omap2_init_common_hw(NULL, NULL);
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(1);
 #endif
-	gic_init_irq();
-	omap_gpio_init();
 }
 
 
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 3966846..be8e750 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -45,10 +45,8 @@ static void __init am3517_evm_init_irq(void)
 {
 	omap_board_config = am3517_evm_config;
 	omap_board_config_size = ARRAY_SIZE(am3517_evm_config);
-
-	omap2_init_common_hw(NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL);
 }
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index d8934fe..75027d7 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -277,9 +277,8 @@ static void __init omap_apollon_init_irq(void)
 {
 	omap_board_config = apollon_config;
 	omap_board_config_size = ARRAY_SIZE(apollon_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	apollon_init_smc91x();
 }
 
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 5dadf33..157f058 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -290,9 +290,8 @@ static void __init omap_ldp_init_irq(void)
 {
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
-	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	omap_init_irq();
-	omap_gpio_init();
+	omap2_init_common_hw(NULL, NULL, NULL, NULL, NULL);
 	ldp_init_smsc911x();
 }
 
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index dd5c1ff..681895b 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -361,14 +361,13 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_board_config = omap3_beagle_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_beagle_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
-	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 56ca602..9a3b468 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -404,10 +404,9 @@ static void __init omap3_evm_init_irq(void)
 {
 	omap_board_config = omap3_evm_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_evm_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, omap3_mpu_rate_table,
 	                     omap3_dsp_rate_table, omap3_l3_rate_table);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index dbd92af..13849b8 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -480,11 +480,10 @@ static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 
 static void __init omap3pandora_init_irq(void)
 {
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params,
 			     NULL, NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 8252ba4..c60cea3 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -439,13 +439,12 @@ static void __init omap3_touchbook_init_irq(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = omap3_touchbook_config;
 	omap_board_config_size = ARRAY_SIZE(omap3_touchbook_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params);
-	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
 	omap2_gp_clockevent_set_gptimer(12);
 #endif
-	omap_gpio_init();
 }
 
 static struct platform_device *omap3_touchbook_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 667fd38..688ad20 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -384,10 +384,9 @@ static void __init overo_init_irq(void)
 {
 	omap_board_config = overo_config;
 	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 			     mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 static struct platform_device *overo_devices[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 78d4305..b52e31e 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -106,12 +106,11 @@ static void __init rx51_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
 	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
+	omap_init_irq();
 	omap2_init_common_hw(sdrc_params, sdrc_params,
 			     omap3_mpu_rate_table,
 			     omap3_dsp_rate_table,
 			     omap3_l3_rate_table);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 extern void __init rx51_peripherals_init(void);
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index a2cdfdd..a62d8c5 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -29,11 +29,10 @@
 
 static void __init omap_zoom2_init_irq(void)
 {
+	omap_init_irq();
 	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
 				 mt46h32m32lf6_sdrc_params, omap3_mpu_rate_table,
 				 omap3_dsp_rate_table, omap3_l3_rate_table);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 /* REVISIT: These audio entries can be removed once MFD code is merged */
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 687305b..0997da8 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -38,11 +38,10 @@ static void __init omap_zoom_init_irq(void)
 {
 	omap_board_config = zoom_config;
 	omap_board_config_size = ARRAY_SIZE(zoom_config);
+	omap_init_irq();
 	omap2_init_common_hw(h8mbx00u0mer0em_sdrc_params,
 			     h8mbx00u0mer0em_sdrc_params,
 			     NULL, NULL, NULL);
-	omap_init_irq();
-	omap_gpio_init();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
index 3b6617f..65b8edb 100644
--- a/arch/arm/mach-omap2/gpio.c
+++ b/arch/arm/mach-omap2/gpio.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/platform_device.h>
 
 #include <mach/hardware.h>
 #include <plat/control.h>
@@ -32,118 +33,688 @@
 #include <plat/mux.h>
 
 /*
- * omap24xx specific GPIO registers
+ * OMAP242X GPIO1 interface data
  */
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
-#define OMAP24XX_GPIO_REVISION		0x0000
-#define OMAP24XX_GPIO_SYSCONFIG		0x0010
-#define OMAP24XX_GPIO_SYSSTATUS		0x0014
-#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
-#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
-#define OMAP24XX_GPIO_IRQENABLE2	0x002c
-#define OMAP24XX_GPIO_IRQENABLE1	0x001c
-#define OMAP24XX_GPIO_WAKE_EN		0x0020
-#define OMAP24XX_GPIO_CTRL		0x0030
-#define OMAP24XX_GPIO_OE		0x0034
-#define OMAP24XX_GPIO_DATAIN		0x0038
-#define OMAP24XX_GPIO_DATAOUT		0x003c
-#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
-#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
-#define OMAP24XX_GPIO_RISINGDETECT	0x0048
-#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
-#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
-#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
-#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
-#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
-#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
-#define OMAP24XX_GPIO_SETWKUENA		0x0084
-#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
-#define OMAP24XX_GPIO_SETDATAOUT	0x0094
-
-#define OMAP4_GPIO_REVISION		0x0000
-#define OMAP4_GPIO_SYSCONFIG		0x0010
-#define OMAP4_GPIO_EOI			0x0020
-#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
-#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
-#define OMAP4_GPIO_IRQSTATUS0		0x002c
-#define OMAP4_GPIO_IRQSTATUS1		0x0030
-#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
-#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
-#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
-#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
-#define OMAP4_GPIO_IRQWAKEN0		0x0044
-#define OMAP4_GPIO_IRQWAKEN1		0x0048
-#define OMAP4_GPIO_SYSSTATUS		0x0104
-#define OMAP4_GPIO_CTRL			0x0130
-#define OMAP4_GPIO_OE			0x0134
-#define OMAP4_GPIO_DATAIN		0x0138
-#define OMAP4_GPIO_DATAOUT		0x013c
-#define OMAP4_GPIO_LEVELDETECT0		0x0140
-#define OMAP4_GPIO_LEVELDETECT1		0x0144
-#define OMAP4_GPIO_RISINGDETECT		0x0148
-#define OMAP4_GPIO_FALLINGDETECT	0x014c
-#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
-#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
-#define OMAP4_GPIO_CLEARDATAOUT		0x0190
-#define OMAP4_GPIO_SETDATAOUT		0x0194
+static struct __initdata resource omap242x_gpio1_resources[] = {
+	{
+		.start	= OMAP242X_GPIO1_BASE,
+		.end	= OMAP242X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio1_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE,
+};
+
+static struct __initdata platform_device omap242x_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap242x_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio1_resources),
+	.resource = omap242x_gpio1_resources,
+};
+
+/*
+ * OMAP242X GPIO2 interface data
+ */
+static struct __initdata resource omap242x_gpio2_resources[] = {
+	{
+		.start	= OMAP242X_GPIO2_BASE,
+		.end	= OMAP242X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio2_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+};
+
+static struct __initdata platform_device omap242x_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap242x_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio2_resources),
+	.resource = omap242x_gpio2_resources,
+};
+
+/*
+ * OMAP242X GPIO3 interface data
+ */
+static struct __initdata resource omap242x_gpio3_resources[] = {
+	{
+		.start	= OMAP242X_GPIO3_BASE,
+		.end	= OMAP242X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio3_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+};
+
+static struct __initdata platform_device omap242x_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap242x_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio3_resources),
+	.resource = omap242x_gpio3_resources,
+};
+
+/*
+ * OMAP242X GPIO4 interface data
+ */
+static struct __initdata resource omap242x_gpio4_resources[] = {
+	{
+		.start	= OMAP242X_GPIO4_BASE,
+		.end	= OMAP242X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap242x_gpio4_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+};
+
+static struct __initdata platform_device omap242x_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap242x_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap242x_gpio4_resources),
+	.resource = omap242x_gpio4_resources,
+};
+
+/*
+ * OMAP243X GPIO1 interface data
+ */
+static struct __initdata resource omap243x_gpio1_resources[] = {
+	{
+		.start	= OMAP243X_GPIO1_BASE,
+		.end	= OMAP243X_GPIO1_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio1_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE,
+};
+
+static struct __initdata platform_device omap243x_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap243x_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio1_resources),
+	.resource = omap243x_gpio1_resources,
+};
+
+/*
+ * OMAP243X GPIO2 interface data
+ */
+static struct __initdata resource omap243x_gpio2_resources[] = {
+	{
+		.start	= OMAP243X_GPIO2_BASE,
+		.end	= OMAP243X_GPIO2_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio2_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+};
+
+static struct __initdata platform_device omap243x_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap243x_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio2_resources),
+	.resource = omap243x_gpio2_resources,
+};
+
+/*
+ * OMAP243X GPIO3 interface data
+ */
+static struct __initdata resource omap243x_gpio3_resources[] = {
+	{
+		.start	= OMAP243X_GPIO3_BASE,
+		.end	= OMAP243X_GPIO3_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio3_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+};
+
+static struct __initdata platform_device omap243x_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap243x_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio3_resources),
+	.resource = omap243x_gpio3_resources,
+};
+
+/*
+ * OMAP243X GPIO4 interface data
+ */
+static struct __initdata resource omap243x_gpio4_resources[] = {
+	{
+		.start	= OMAP243X_GPIO4_BASE,
+		.end	= OMAP243X_GPIO4_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap243x_gpio4_config = {
+	.ick_name = "gpios_ick",
+	.fck_name = "gpios_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+};
+
+static struct __initdata platform_device omap243x_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap243x_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio4_resources),
+	.resource = omap243x_gpio4_resources,
+};
+
 /*
- * omap34xx specific GPIO registers
+ * OMAP243X GPIO5 interface data
  */
+static struct __initdata resource omap243x_gpio5_resources[] = {
+	{
+		.start	= OMAP243X_GPIO5_BASE,
+		.end	= OMAP243X_GPIO5_BASE + OMAP2_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_24XX_GPIO_BANK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
 
-#define OMAP34XX_GPIO1_BASE		0x48310000
-#define OMAP34XX_GPIO2_BASE		0x49050000
-#define OMAP34XX_GPIO3_BASE		0x49052000
-#define OMAP34XX_GPIO4_BASE		0x49054000
-#define OMAP34XX_GPIO5_BASE		0x49056000
-#define OMAP34XX_GPIO6_BASE		0x49058000
+static struct __initdata omap_gpio_platform_data omap243x_gpio5_config = {
+	.ick_name = "gpio5_ick",
+	.fck_name = "gpio5_fck",
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+};
+
+static struct __initdata platform_device omap243x_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap243x_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap243x_gpio5_resources),
+	.resource = omap243x_gpio5_resources,
+};
 
 /*
- * OMAP44XX  specific GPIO registers
+ * OMAP3 GPIO1 interface data
  */
-#define OMAP44XX_GPIO1_BASE             0x4a310000
-#define OMAP44XX_GPIO2_BASE             0x48055000
-#define OMAP44XX_GPIO3_BASE             0x48057000
-#define OMAP44XX_GPIO4_BASE             0x48059000
-#define OMAP44XX_GPIO5_BASE             0x4805B000
-#define OMAP44XX_GPIO6_BASE             0x4805D000
+static struct __initdata resource omap3_gpio1_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO1_BASE,
+		.end	= OMAP34XX_GPIO1_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio1_config = {
+	.ick_name = "gpio1_ick",
+	.dbck_name = "gpio1_dbck",
+	.virtual_irq_start = IH_GPIO_BASE,
+};
+
+static struct __initdata platform_device omap3_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap3_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio1_resources),
+	.resource = omap3_gpio1_resources,
+};
+
+/*
+ * OMAP3 GPIO2 interface data
+ */
+static struct __initdata resource omap3_gpio2_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO2_BASE,
+		.end	= OMAP34XX_GPIO2_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio2_config = {
+	.ick_name = "gpio2_ick",
+	.dbck_name = "gpio2_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+};
+
+static struct __initdata platform_device omap3_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap3_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio2_resources),
+	.resource = omap3_gpio2_resources,
+};
+
+/*
+ * OMAP3 GPIO3 interface data
+ */
+static struct __initdata resource omap3_gpio3_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO3_BASE,
+		.end	= OMAP34XX_GPIO3_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio3_config = {
+	.ick_name = "gpio3_ick",
+	.dbck_name = "gpio3_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+};
+
+static struct __initdata platform_device omap3_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap3_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio3_resources),
+	.resource = omap3_gpio3_resources,
+};
+
+/*
+ * OMAP3 GPIO4 interface data
+ */
+static struct __initdata resource omap3_gpio4_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO4_BASE,
+		.end	= OMAP34XX_GPIO4_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio4_config = {
+	.ick_name = "gpio4_ick",
+	.dbck_name = "gpio4_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+};
+
+static struct __initdata platform_device omap3_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap3_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio4_resources),
+	.resource = omap3_gpio4_resources,
+};
+
+/*
+ * OMAP3 GPIO5 interface data
+ */
+static struct __initdata resource omap3_gpio5_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO5_BASE,
+		.end	= OMAP34XX_GPIO5_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio5_config = {
+	.ick_name = "gpio5_ick",
+	.dbck_name = "gpio5_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+};
+
+static struct __initdata platform_device omap3_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap3_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio5_resources),
+	.resource = omap3_gpio5_resources,
+};
+
+/*
+ * OMAP3 GPIO6 interface data
+ */
+static struct __initdata resource omap3_gpio6_resources[] = {
+	{
+		.start	= OMAP34XX_GPIO6_BASE,
+		.end	= OMAP34XX_GPIO6_BASE + OMAP3_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_34XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap3_gpio6_config = {
+	.ick_name = "gpio6_ick",
+	.dbck_name = "gpio6_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 160,
+};
+
+static struct __initdata platform_device omap3_gpio6 = {
+	.name           = "omap-gpio",
+	.id             = 5,
+	.dev            = {
+		.platform_data = &omap3_gpio6_config,
+	},
+	.num_resources = ARRAY_SIZE(omap3_gpio6_resources),
+	.resource = omap3_gpio6_resources,
+};
+
+/*
+ * OMAP44XX GPIO1 interface data
+ */
+static struct __initdata resource omap4_gpio1_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO1_BASE,
+		.end	= OMAP44XX_GPIO1_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio1_config = {
+	.ick_name = "gpio1_ick",
+	.dbck_name = "gpio1_dbck",
+	.virtual_irq_start = IH_GPIO_BASE,
+};
+
+static struct __initdata platform_device omap4_gpio1 = {
+	.name           = "omap-gpio",
+	.id             = 0,
+	.dev            = {
+		.platform_data = &omap4_gpio1_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio1_resources),
+	.resource = omap4_gpio1_resources,
+};
+
+/*
+ * OMAP44XX GPIO2 interface data
+ */
+static struct __initdata resource omap4_gpio2_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO2_BASE,
+		.end	= OMAP44XX_GPIO2_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio2_config = {
+	.ick_name = "gpio2_ick",
+	.dbck_name = "gpio2_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 32,
+};
+
+static struct __initdata platform_device omap4_gpio2 = {
+	.name           = "omap-gpio",
+	.id             = 1,
+	.dev            = {
+		.platform_data = &omap4_gpio2_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio2_resources),
+	.resource = omap4_gpio2_resources,
+};
+
+/*
+ * OMAP44XX GPIO3 interface data
+ */
+static struct __initdata resource omap4_gpio3_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO3_BASE,
+		.end	= OMAP44XX_GPIO3_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK3,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio3_config = {
+	.ick_name = "gpio3_ick",
+	.dbck_name = "gpio3_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 64,
+};
+
+static struct __initdata platform_device omap4_gpio3 = {
+	.name           = "omap-gpio",
+	.id             = 2,
+	.dev            = {
+		.platform_data = &omap4_gpio3_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio3_resources),
+	.resource = omap4_gpio3_resources,
+};
+
+/*
+ * OMAP44XX GPIO4 interface data
+ */
+static struct __initdata resource omap4_gpio4_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO4_BASE,
+		.end	= OMAP44XX_GPIO4_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK4,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio4_config = {
+	.ick_name = "gpio4_ick",
+	.dbck_name = "gpio4_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 96,
+};
+
+static struct __initdata platform_device omap4_gpio4 = {
+	.name           = "omap-gpio",
+	.id             = 3,
+	.dev            = {
+		.platform_data = &omap4_gpio4_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio4_resources),
+	.resource = omap4_gpio4_resources,
+};
+
+/*
+ * OMAP44XX GPIO5 interface data
+  */
+static struct __initdata resource omap4_gpio5_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO5_BASE,
+		.end	= OMAP44XX_GPIO5_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK5,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct __initdata omap_gpio_platform_data omap4_gpio5_config = {
+	.ick_name = "gpio5_ick",
+	.dbck_name = "gpio5_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 128,
+};
+
+static struct __initdata platform_device omap4_gpio5 = {
+	.name           = "omap-gpio",
+	.id             = 4,
+	.dev            = {
+		.platform_data = &omap4_gpio5_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio5_resources),
+	.resource = omap4_gpio5_resources,
+};
 
-static struct __init gpio_bank gpio_bank_242x[4] = {
-	{ OMAP242X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE },
-	{ OMAP242X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32 },
-	{ OMAP242X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64 },
-	{ OMAP242X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96 },
+/*
+ * OMAP44XX GPIO6 interface data
+  */
+static struct __initdata resource omap4_gpio6_resources[] = {
+	{
+		.start	= OMAP44XX_GPIO6_BASE,
+		.end	= OMAP44XX_GPIO6_BASE + OMAP4_GPIO_AS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_44XX_GPIO_BANK6,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct __init gpio_bank gpio_bank_243x[5] = {
-	{ OMAP243X_GPIO1_BASE, NULL, INT_24XX_GPIO_BANK1, IH_GPIO_BASE },
-	{ OMAP243X_GPIO2_BASE, NULL, INT_24XX_GPIO_BANK2, IH_GPIO_BASE + 32 },
-	{ OMAP243X_GPIO3_BASE, NULL, INT_24XX_GPIO_BANK3, IH_GPIO_BASE + 64 },
-	{ OMAP243X_GPIO4_BASE, NULL, INT_24XX_GPIO_BANK4, IH_GPIO_BASE + 96 },
-	{ OMAP243X_GPIO5_BASE, NULL, INT_24XX_GPIO_BANK5, IH_GPIO_BASE + 128 },
+static struct __initdata omap_gpio_platform_data omap4_gpio6_config = {
+	.ick_name = "gpio6_ick",
+	.dbck_name = "gpio6_dbck",
+	.virtual_irq_start = IH_GPIO_BASE + 160,
 };
 
-static struct __init gpio_bank gpio_bank_34xx[6] = {
-	{ OMAP34XX_GPIO1_BASE, NULL, INT_34XX_GPIO_BANK1, IH_GPIO_BASE },
-	{ OMAP34XX_GPIO2_BASE, NULL, INT_34XX_GPIO_BANK2, IH_GPIO_BASE + 32 },
-	{ OMAP34XX_GPIO3_BASE, NULL, INT_34XX_GPIO_BANK3, IH_GPIO_BASE + 64 },
-	{ OMAP34XX_GPIO4_BASE, NULL, INT_34XX_GPIO_BANK4, IH_GPIO_BASE + 96 },
-	{ OMAP34XX_GPIO5_BASE, NULL, INT_34XX_GPIO_BANK5, IH_GPIO_BASE + 128 },
-	{ OMAP34XX_GPIO6_BASE, NULL, INT_34XX_GPIO_BANK6, IH_GPIO_BASE + 160 },
+static struct __initdata platform_device omap4_gpio6 = {
+	.name           = "omap-gpio",
+	.id             = 5,
+	.dev            = {
+		.platform_data = &omap4_gpio6_config,
+	},
+	.num_resources = ARRAY_SIZE(omap4_gpio6_resources),
+	.resource = omap4_gpio6_resources,
 };
 
-#define OMAP34XX_PAD_SAFE_MODE 0x7
-#define OMAP34XX_PAD_IN_PU_GPIO 0x11c
-#define OMAP34XX_PAD_IN_PD_GPIO 0x10c
+static struct __initdata platform_device * omap242x_gpio_early_dev[] = {
+	&omap242x_gpio1,
+	&omap242x_gpio2,
+	&omap242x_gpio3,
+	&omap242x_gpio4
+};
+
+static struct __initdata platform_device * omap243x_gpio_early_dev[] = {
+	&omap243x_gpio1,
+	&omap243x_gpio2,
+	&omap243x_gpio3,
+	&omap243x_gpio4,
+	&omap243x_gpio5
+};
+
+static struct __initdata platform_device * omap3_gpio_early_dev[] = {
+	&omap3_gpio1,
+	&omap3_gpio2,
+	&omap3_gpio3,
+	&omap3_gpio4,
+	&omap3_gpio5,
+	&omap3_gpio6
+};
+
+static struct __initdata platform_device * omap4_gpio_early_dev[] = {
+	&omap4_gpio1,
+	&omap4_gpio2,
+	&omap4_gpio3,
+	&omap4_gpio4,
+	&omap4_gpio5,
+	&omap4_gpio6
+};
 
 struct omap3_gpio_regs {
 	u32 sysconfig;
@@ -159,7 +730,9 @@ struct omap3_gpio_regs {
 	u32 dataout;
 };
 
+#ifdef CONFIG_ARCH_OMAP3
 static struct omap3_gpio_regs gpio_context[OMAP34XX_NR_GPIOS];
+#endif
 
 /* GPIO -> PAD init configuration struct */
 struct gpio_pad_range {
@@ -214,19 +787,11 @@ struct gpio_pad {
 
 #define OMAP34XX_GPIO_AMT	(32 * OMAP34XX_NR_GPIOS)
 
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct gpio_pad *gpio_pads;
+#endif
 static u16 gpio_pad_map[OMAP34XX_GPIO_AMT];
-
-static struct __init gpio_bank gpio_bank_44xx[6] = {
-	{ OMAP44XX_GPIO1_BASE, NULL, INT_44XX_GPIO_BANK1, IH_GPIO_BASE },
-	{ OMAP44XX_GPIO2_BASE, NULL, INT_44XX_GPIO_BANK2, IH_GPIO_BASE + 32 },
-	{ OMAP44XX_GPIO3_BASE, NULL, INT_44XX_GPIO_BANK3, IH_GPIO_BASE + 64 },
-	{ OMAP44XX_GPIO4_BASE, NULL, INT_44XX_GPIO_BANK4, IH_GPIO_BASE + 96 },
-	{ OMAP44XX_GPIO5_BASE, NULL, INT_44XX_GPIO_BANK5, IH_GPIO_BASE + 128 },
-	{ OMAP44XX_GPIO6_BASE, NULL, INT_44XX_GPIO_BANK6, IH_GPIO_BASE + 160 },
-};
-
-static struct gpio_bank *gpio_bank;
+static struct gpio_bank gpio_bank[OMAP_MAX_NR_GPIOS];
 static int gpio_bank_count;
 
 static inline struct gpio_bank *get_gpio_bank(int gpio)
@@ -590,7 +1155,7 @@ static u32 _get_gpio_irqbank_mask(struct gpio_bank *bank)
 		reg += OMAP4_GPIO_IRQSTATUSSET0;
 	else {
 		BUG();
-		return;
+		return -EINVAL;
 	}
 
 	mask = 0xffffffff;
@@ -935,13 +1500,6 @@ static int gpio_2irq(struct gpio_chip *chip, unsigned offset)
 	return bank->virtual_irq_start + offset;
 }
 
-static int initialized;
-static struct clk *gpio_ick;
-static struct clk *gpio_fck;
-static struct clk *gpio5_ick;
-static struct clk *gpio5_fck;
-static struct clk *gpio_iclks[OMAP34XX_NR_GPIOS];
-
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 /*
  * Following pad init code in addition to the context / restore hooks are
@@ -1020,163 +1578,6 @@ static void __init omap_gpio_show_rev(void)
  */
 static struct lock_class_key gpio_lock_class;
 
-static int __init _omap_gpio_init(void)
-{
-	int i;
-	int gpio = 0;
-	struct gpio_bank *bank;
-	int bank_size = SZ_8K;	/* Module 4KB + L4 4KB */
-	char clk_name[11];
-
-	initialized = 1;
-
-	if (cpu_is_omap24xx()) {
-		gpio_ick = clk_get(NULL, "gpios_ick");
-		if (IS_ERR(gpio_ick))
-			printk(KERN_ERR "Could not get gpios_ick\n");
-		else
-			clk_enable(gpio_ick);
-		gpio_fck = clk_get(NULL, "gpios_fck");
-		if (IS_ERR(gpio_fck))
-			printk(KERN_ERR "Could not get gpios_fck\n");
-		else
-			clk_enable(gpio_fck);
-
-		/*
-		 * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
-		 */
-		if (cpu_is_omap2430()) {
-			gpio5_ick = clk_get(NULL, "gpio5_ick");
-			if (IS_ERR(gpio5_ick))
-				printk(KERN_ERR "Could not get gpio5_ick\n");
-			else
-				clk_enable(gpio5_ick);
-			gpio5_fck = clk_get(NULL, "gpio5_fck");
-			if (IS_ERR(gpio5_fck))
-				printk(KERN_ERR "Could not get gpio5_fck\n");
-			else
-				clk_enable(gpio5_fck);
-		}
-	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
-		for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
-			sprintf(clk_name, "gpio%d_ick", i + 1);
-			gpio_iclks[i] = clk_get(NULL, clk_name);
-			if (IS_ERR(gpio_iclks[i]))
-				printk(KERN_ERR "Could not get %s\n", clk_name);
-			else
-				clk_enable(gpio_iclks[i]);
-		}
-	} else {
-		BUG();
-		return;
-	}
-
-	if (cpu_is_omap242x()) {
-		gpio_bank_count = 4;
-		gpio_bank = gpio_bank_242x;
-	} else if (cpu_is_omap243x()) {
-		gpio_bank_count = 5;
-		gpio_bank = gpio_bank_243x;
-	} else if (cpu_is_omap34xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_34xx;
-	} else if (cpu_is_omap44xx()) {
-		gpio_bank_count = OMAP34XX_NR_GPIOS;
-		gpio_bank = gpio_bank_44xx;
-	}
-
-	for (i = 0; i < gpio_bank_count; i++) {
-		int j, gpio_count = 16;
-
-		bank = &gpio_bank[i];
-		spin_lock_init(&bank->lock);
-
-		/* Static mapping, never released */
-		bank->base = ioremap(bank->pbase, bank_size);
-		if (!bank->base) {
-			printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
-			continue;
-		}
-		if (cpu_is_omap44xx()) {
-			__raw_writel(0xffffffff, bank->base +
-						OMAP4_GPIO_IRQSTATUSCLR0);
-			__raw_writew(0x0015, bank->base +
-						OMAP4_GPIO_SYSCONFIG);
-			__raw_writel(0x00000000, bank->base +
-						 OMAP4_GPIO_DEBOUNCENABLE);
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
-		} else {
-			__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_IRQENABLE1);
-			__raw_writel(0xffffffff, bank->base +
-						OMAP24XX_GPIO_IRQSTATUS1);
-			__raw_writew(0x0015, bank->base +
-						OMAP24XX_GPIO_SYSCONFIG);
-			__raw_writel(0x00000000, bank->base +
-						OMAP24XX_GPIO_DEBOUNCE_EN);
-
-			/* Initialize interface clk ungated, module enabled */
-			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
-		}
-		{
-			static const u32 non_wakeup_gpios[] = {
-				0xe203ffc0, 0x08700040
-			};
-			if (cpu_is_omap24xx() &&
-					i < ARRAY_SIZE(non_wakeup_gpios))
-				bank->non_wakeup_gpios = non_wakeup_gpios[i];
-		}
-		gpio_count = 32;
-
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
-		bank->chip.label = "gpio";
-		bank->chip.base = gpio;
-		gpio += gpio_count;
-		bank->chip.ngpio = gpio_count;
-
-		gpiochip_add(&bank->chip);
-
-		for (j = bank->virtual_irq_start;
-		     j < bank->virtual_irq_start + gpio_count; j++) {
-			lockdep_set_class(&irq_desc[j].lock, &gpio_lock_class);
-			set_irq_chip_data(j, bank);
-			set_irq_chip(j, &gpio_irq_chip);
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
-	}
-
-	/* Enable autoidle for the OCP interface */
-	if (cpu_is_omap24xx())
-		omap_writel(1 << 0, 0x48019010);
-	if (cpu_is_omap34xx())
-		omap_writel(1 << 0, 0x48306814);
-
-	omap_gpio_show_rev();
-
-	return 0;
-}
-
 static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
 {
 	int i;
@@ -1278,7 +1679,7 @@ void omap2_gpio_prepare_for_idle(int power_state)
 	int min = 0;
 
 	if (!cpu_class_is_omap2())
-		return 0;
+		return;
 
 	if (cpu_is_omap34xx())
 		min = 1;
@@ -1336,7 +1737,7 @@ void omap2_gpio_resume_after_idle(void)
 	int min = 0;
 
 	if (!cpu_class_is_omap2())
-		return 0;
+		return;
 
 	if (cpu_is_omap34xx())
 		min = 1;
@@ -1563,26 +1964,273 @@ void omap3_gpio_restore_pad_context(int restore_oe)
 }
 #endif
 
+static int __devexit omap_gpio_remove(struct platform_device *pdev)
+{
+	struct omap_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_bank *bank;
+	int id;
+
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
+	}
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
+	static int show_rev_once;
+	struct omap_gpio_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_bank *bank;
+	struct resource *res;
+	int id, i;
+
+	if (!pdev || !pdata) {
+		printk(KERN_ERR "GPIO device initialize without"
+					"platform data\n");
+		return -EINVAL;
+	}
+
+	if (cpu_is_omap242x())
+		gpio_bank_count = OMAP242X_NR_GPIOS;
+	else if (cpu_is_omap243x())
+		gpio_bank_count = OMAP243X_NR_GPIOS;
+	else if (cpu_is_omap34xx())
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
+	else if (cpu_is_omap44xx())
+		gpio_bank_count = OMAP44XX_NR_GPIOS;
+
+	id = pdev->id;
+	if (id > gpio_bank_count) {
+		printk(KERN_ERR "Invalid GPIO device id (%d)\n", id);
+		return -EINVAL;
+	}
+
+	bank = &gpio_bank[id];
+
+	if (bank->initialized == 1)
+		return 0;
+
+	bank->virtual_irq_start = pdata->virtual_irq_start;
+
+	bank->ick = clk_get(NULL, pdata->ick_name);
+	if (IS_ERR(bank->ick))
+		printk(KERN_ERR "Could not get %s\n", pdata->ick_name);
+	else
+		clk_enable(bank->ick);
+
+	if (cpu_is_omap24xx()) {
+		bank->fck = clk_get(NULL, pdata->fck_name);
+		if (IS_ERR(bank->fck))
+			printk(KERN_ERR "Could not get %s\n", pdata->fck_name);
+		else
+			clk_enable(bank->fck);
+	}
+
+	spin_lock_init(&bank->lock);
+
+	/* Static mapping, never released */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (unlikely(!res)) {
+		printk(KERN_ERR "GPIO Bank %i Invalid mem resource\n", id);
+		return -ENODEV;
+	}
+
+	bank->base = ioremap(res->start, resource_size(res));
+	if (!bank->base) {
+		printk(KERN_ERR "Could not ioremap gpio bank%i\n", id);
+		return -ENOMEM;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (unlikely(!res)) {
+		printk(KERN_ERR "GPIO Bank %i Invalid irq resource\n", id);
+		return -ENODEV;
+	}
+
+	if (cpu_is_omap44xx()) {
+		__raw_writel(0xffffffff, bank->base +
+					OMAP4_GPIO_IRQSTATUSCLR0);
+		__raw_writew(0x0015, bank->base +
+					OMAP4_GPIO_SYSCONFIG);
+		__raw_writel(0x00000000, bank->base +
+					 OMAP4_GPIO_DEBOUNCENABLE);
+		/* Initialize interface clk ungated, module enabled */
+		__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
+	} else {
+		__raw_writel(0x00000000, bank->base +
+					OMAP24XX_GPIO_IRQENABLE1);
+		__raw_writel(0xffffffff, bank->base +
+					OMAP24XX_GPIO_IRQSTATUS1);
+		__raw_writew(0x0015, bank->base +
+					OMAP24XX_GPIO_SYSCONFIG);
+		__raw_writel(0x00000000, bank->base +
+					OMAP24XX_GPIO_DEBOUNCE_EN);
+
+		/* Initialize interface clk ungated, module enabled */
+		__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
+	}
+	{
+		static const u32 non_wakeup_gpios[] = {
+			0xe203ffc0, 0x08700040
+		};
+		if (cpu_is_omap24xx() &&
+				id < ARRAY_SIZE(non_wakeup_gpios))
+			bank->non_wakeup_gpios = non_wakeup_gpios[id];
+	}
+
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
+	bank->chip.label = "gpio";
+	bank->chip.base = id * 32;
+	bank->chip.ngpio = 32;
+
+	gpiochip_add(&bank->chip);
+
+	for (i = bank->virtual_irq_start; i < bank->virtual_irq_start + 32;
+			i++) {
+		lockdep_set_class(&irq_desc[i].lock, &gpio_lock_class);
+		set_irq_chip_data(i, bank);
+		set_irq_chip(i, &gpio_irq_chip);
+		set_irq_handler(i, handle_simple_irq);
+		set_irq_flags(i, IRQF_VALID);
+	}
+	set_irq_chained_handler(res->start, gpio_irq_handler);
+	set_irq_data(res->start, bank);
+
+	if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
+		bank->dbck = clk_get(NULL, pdata->dbck_name);
+		if (IS_ERR(bank->dbck))
+			printk(KERN_ERR "Could not get %s\n", pdata->dbck_name);
+	}
+
+	/* Enable autoidle for the OCP interface */
+	if (cpu_is_omap24xx())
+		omap_writel(1 << 0, 0x48019010);
+	if (cpu_is_omap34xx())
+		omap_writel(1 << 0, 0x48306814);
+
+	bank->initialized = 1;
+
+	if (!show_rev_once) {
+		omap_gpio_show_rev();
+		show_rev_once = 1;
+	}
+
+	return 0;
+}
+
+void __init omap_gpio_early_init(void)
+{
+	struct platform_device **pdev;
+
+	if (cpu_is_omap242x()) {
+		pdev = omap242x_gpio_early_dev;
+		gpio_bank_count = OMAP242X_NR_GPIOS;
+	} else if (cpu_is_omap243x()) {
+		pdev = omap243x_gpio_early_dev;
+		gpio_bank_count = OMAP243X_NR_GPIOS;
+	} else if (cpu_is_omap34xx()) {
+		pdev = omap3_gpio_early_dev;
+		gpio_bank_count = OMAP34XX_NR_GPIOS;
+	} else if (cpu_is_omap44xx()) {
+		pdev = omap4_gpio_early_dev;
+		gpio_bank_count = OMAP44XX_NR_GPIOS;
+	}
+
+	early_platform_add_devices(pdev, gpio_bank_count);
+	early_platform_driver_register_all("earlygpio");
+	early_platform_driver_probe("earlygpio", gpio_bank_count, 0);
+}
+
+int __init omap_init_gpio(void)
+{
+	if (cpu_is_omap242x()) {
+		platform_device_add(&omap242x_gpio1);
+		platform_device_add(&omap242x_gpio2);
+		platform_device_add(&omap242x_gpio3);
+		platform_device_add(&omap242x_gpio4);
+		platform_device_register(&omap242x_gpio1);
+		platform_device_register(&omap242x_gpio2);
+		platform_device_register(&omap242x_gpio3);
+		platform_device_register(&omap242x_gpio4);
+	} else if (cpu_is_omap243x()) {
+		platform_device_add(&omap243x_gpio1);
+		platform_device_add(&omap243x_gpio2);
+		platform_device_add(&omap243x_gpio3);
+		platform_device_add(&omap243x_gpio4);
+		platform_device_add(&omap243x_gpio5);
+		platform_device_register(&omap243x_gpio1);
+		platform_device_register(&omap243x_gpio2);
+		platform_device_register(&omap243x_gpio3);
+		platform_device_register(&omap243x_gpio4);
+		platform_device_register(&omap243x_gpio5);
+	} else if (cpu_is_omap34xx()) {
+		platform_device_register(&omap3_gpio1);
+		platform_device_register(&omap3_gpio2);
+		platform_device_register(&omap3_gpio3);
+		platform_device_register(&omap3_gpio4);
+		platform_device_register(&omap3_gpio5);
+		platform_device_register(&omap3_gpio6);
+	} else if (cpu_is_omap44xx()) {
+		platform_device_add(&omap4_gpio1);
+		platform_device_add(&omap4_gpio2);
+		platform_device_add(&omap4_gpio3);
+		platform_device_add(&omap4_gpio4);
+		platform_device_add(&omap4_gpio5);
+		platform_device_add(&omap4_gpio6);
+	}
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
 /*
  * This may get called early from board specific init
  * for boards that have interrupts routed via FPGA.
  */
 int __init omap_gpio_init(void)
 {
-	if (!initialized)
-		return _omap_gpio_init();
-	else
-		return 0;
+	return platform_driver_register(&omap_gpio_driver);
 }
 
 static int __init omap_gpio_sysinit(void)
 {
 	int ret = 0;
 
-	if (!initialized)
-		ret = _omap_gpio_init();
-
-	if (cpu_class_is_omap2() && (ret == 0)) {
+	ret = omap_gpio_init();
+	if (ret == 0) {
 		ret = sysdev_class_register(&omap_gpio_sysclass);
 		if (ret == 0)
 			ret = sysdev_register(&omap_gpio_device);
@@ -1591,4 +2239,16 @@ static int __init omap_gpio_sysinit(void)
 	return ret;
 }
 
-arch_initcall(omap_gpio_sysinit);
+static void __exit omap_gpio_exit(void)
+{
+	platform_driver_unregister(&omap_gpio_driver);
+}
+early_platform_init("earlygpio", &omap_gpio_driver);
+arch_initcall(omap_init_gpio);
+module_init(omap_gpio_sysinit);
+module_exit(omap_gpio_exit);
+
+MODULE_DESCRIPTION("OMAP GPIO DRIVER");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index c93b42a..854660e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -34,6 +34,7 @@
 #include <plat/gpmc.h>
 #include <plat/serial.h>
 #include <plat/vram.h>
+#include <plat/gpio.h>
 
 #include "clock2xxx.h"
 #include "clock34xx.h"
@@ -360,4 +361,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
 	_omap2_init_reprogram_sdrc();
 #endif
 	gpmc_init();
+	omap_gpio_early_init();
 }
diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index ab0f282..1470e8e 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -63,7 +63,11 @@
 #define OMAP_MPUIO_LATCH		0x34
 #endif
 
+#define OMAP242X_NR_GPIOS		4
+#define OMAP243X_NR_GPIOS		5
 #define OMAP34XX_NR_GPIOS		6
+#define OMAP44XX_NR_GPIOS		6
+#define OMAP_MAX_NR_GPIOS		OMAP44XX_NR_GPIOS
 
 #define OMAP_MPUIO(nr)		(OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr)	((nr) >= OMAP_MAX_GPIO_LINES)
@@ -72,6 +76,103 @@
 				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
 				 IH_GPIO_BASE + (nr))
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
+			defined(CONFIG_ARCH_OMAP4)
+/*
+ * omap24xx specific GPIO registers
+ */
+#define OMAP242X_GPIO1_BASE		(L4_24XX_BASE + 0x18000)
+#define OMAP242X_GPIO2_BASE		(L4_24XX_BASE + 0x1a000)
+#define OMAP242X_GPIO3_BASE		(L4_24XX_BASE + 0x1c000)
+#define OMAP242X_GPIO4_BASE		(L4_24XX_BASE + 0x1e000)
+
+#define OMAP243X_GPIO1_BASE		(L4_WK_243X_BASE + 0x0c000)
+#define OMAP243X_GPIO2_BASE		(L4_WK_243X_BASE + 0x0e000)
+#define OMAP243X_GPIO3_BASE		(L4_WK_243X_BASE + 0x10000)
+#define OMAP243X_GPIO4_BASE		(L4_WK_243X_BASE + 0x12000)
+#define OMAP243X_GPIO5_BASE		(L4_24XX_BASE + 0xb6000)
+
+#define OMAP2_GPIO_AS_LEN		4096
+
+#define OMAP24XX_GPIO_REVISION		0x0000
+#define OMAP24XX_GPIO_SYSCONFIG		0x0010
+#define OMAP24XX_GPIO_SYSSTATUS		0x0014
+#define OMAP24XX_GPIO_IRQSTATUS1	0x0018
+#define OMAP24XX_GPIO_IRQSTATUS2	0x0028
+#define OMAP24XX_GPIO_IRQENABLE2	0x002c
+#define OMAP24XX_GPIO_IRQENABLE1	0x001c
+#define OMAP24XX_GPIO_WAKE_EN		0x0020
+#define OMAP24XX_GPIO_CTRL		0x0030
+#define OMAP24XX_GPIO_OE		0x0034
+#define OMAP24XX_GPIO_DATAIN		0x0038
+#define OMAP24XX_GPIO_DATAOUT		0x003c
+#define OMAP24XX_GPIO_LEVELDETECT0	0x0040
+#define OMAP24XX_GPIO_LEVELDETECT1	0x0044
+#define OMAP24XX_GPIO_RISINGDETECT	0x0048
+#define OMAP24XX_GPIO_FALLINGDETECT	0x004c
+#define OMAP24XX_GPIO_DEBOUNCE_EN	0x0050
+#define OMAP24XX_GPIO_DEBOUNCE_VAL	0x0054
+#define OMAP24XX_GPIO_CLEARIRQENABLE1	0x0060
+#define OMAP24XX_GPIO_SETIRQENABLE1	0x0064
+#define OMAP24XX_GPIO_CLEARWKUENA	0x0080
+#define OMAP24XX_GPIO_SETWKUENA		0x0084
+#define OMAP24XX_GPIO_CLEARDATAOUT	0x0090
+#define OMAP24XX_GPIO_SETDATAOUT	0x0094
+
+/*
+ * omap34xx specific GPIO registers
+ */
+#define OMAP34XX_GPIO1_BASE	(L4_WK_34XX_BASE + 0x10000)
+#define OMAP34XX_GPIO2_BASE	(L4_PER_34XX_BASE + 0x50000)
+#define OMAP34XX_GPIO3_BASE	(L4_PER_34XX_BASE + 0x52000)
+#define OMAP34XX_GPIO4_BASE	(L4_PER_34XX_BASE + 0x54000)
+#define OMAP34XX_GPIO5_BASE	(L4_PER_34XX_BASE + 0x56000)
+#define OMAP34XX_GPIO6_BASE	(L4_PER_34XX_BASE + 0x58000)
+
+#define OMAP3_GPIO_AS_LEN		4096
+#define OMAP34XX_PAD_SAFE_MODE 		0x7
+#define OMAP34XX_PAD_IN_PU_GPIO 	0x11c
+#define OMAP34XX_PAD_IN_PD_GPIO 	0x10c
+
+/*
+ * OMAP44XX  specific GPIO registers
+ */
+#define OMAP44XX_GPIO1_BASE	(L4_WK_44XX_BASE + 0x10000)
+#define OMAP44XX_GPIO2_BASE	(L4_PER_44XX_BASE + 0x55000)
+#define OMAP44XX_GPIO3_BASE	(L4_PER_44XX_BASE + 0x57000)
+#define OMAP44XX_GPIO4_BASE	(L4_PER_44XX_BASE + 0x59000)
+#define OMAP44XX_GPIO5_BASE	(L4_PER_44XX_BASE + 0x5b000)
+#define OMAP44XX_GPIO6_BASE	(L4_PER_44XX_BASE + 0x5d000)
+
+#define OMAP4_GPIO_AS_LEN		4096
+#define OMAP4_GPIO_REVISION		0x0000
+#define OMAP4_GPIO_SYSCONFIG		0x0010
+#define OMAP4_GPIO_EOI			0x0020
+#define OMAP4_GPIO_IRQSTATUSRAW0	0x0024
+#define OMAP4_GPIO_IRQSTATUSRAW1	0x0028
+#define OMAP4_GPIO_IRQSTATUS0		0x002c
+#define OMAP4_GPIO_IRQSTATUS1		0x0030
+#define OMAP4_GPIO_IRQSTATUSSET0	0x0034
+#define OMAP4_GPIO_IRQSTATUSSET1	0x0038
+#define OMAP4_GPIO_IRQSTATUSCLR0	0x003c
+#define OMAP4_GPIO_IRQSTATUSCLR1	0x0040
+#define OMAP4_GPIO_IRQWAKEN0		0x0044
+#define OMAP4_GPIO_IRQWAKEN1		0x0048
+#define OMAP4_GPIO_SYSSTATUS		0x0104
+#define OMAP4_GPIO_CTRL			0x0130
+#define OMAP4_GPIO_OE			0x0134
+#define OMAP4_GPIO_DATAIN		0x0138
+#define OMAP4_GPIO_DATAOUT		0x013c
+#define OMAP4_GPIO_LEVELDETECT0		0x0140
+#define OMAP4_GPIO_LEVELDETECT1		0x0144
+#define OMAP4_GPIO_RISINGDETECT		0x0148
+#define OMAP4_GPIO_FALLINGDETECT	0x014c
+#define OMAP4_GPIO_DEBOUNCENABLE	0x0150
+#define OMAP4_GPIO_DEBOUNCINGTIME	0x0154
+#define OMAP4_GPIO_CLEARDATAOUT		0x0190
+#define OMAP4_GPIO_SETDATAOUT		0x0194
+
+extern void omap_gpio_early_init(void);
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern void omap2_gpio_prepare_for_idle(int power_state);
 extern void omap2_gpio_resume_after_idle(void);
@@ -80,6 +181,7 @@ extern void omap_set_gpio_debounce_time(int gpio, int enable);
 extern void omap_gpio_save_context(void);
 extern void omap_gpio_restore_context(void);
 extern void omap3_gpio_restore_pad_context(int restore_oe);
+#endif
 /*-------------------------------------------------------------------------*/
 
 /* Wrappers for "new style" GPIO calls, using the new infrastructure
@@ -91,17 +193,30 @@ extern void omap3_gpio_restore_pad_context(int restore_oe);
 #include <linux/errno.h>
 #include <asm-generic/gpio.h>
 
-struct gpio_bank {
+struct omap_gpio_platform_data {
 	unsigned long pbase;
-	void __iomem *base;
 	u16 irq;
 	u16 virtual_irq_start;
+	char ick_name[11];
+	char fck_name[11];
+	char dbck_name[11];
+};
+
+struct gpio_bank {
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX) || \
 		defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+	unsigned long pbase;
+	void __iomem *base;
+	u16 irq;
+	u16 virtual_irq_start;
 	int method;
 #endif
 	u32 suspend_wakeup;
 	u32 saved_wakeup;
+	u32 level_mask;
+	u32 toggle_mask;
+	spinlock_t lock; /* for locking in GPIO operations */
+	struct gpio_chip chip;
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
 			defined(CONFIG_ARCH_OMAP4)
 	u32 non_wakeup_gpios;
@@ -110,13 +225,14 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 	u32 mod_usage;
-#endif
-	u32 level_mask;
-	u32 toggle_mask;
-	spinlock_t lock; /* for locking in GPIO operations */
-	struct gpio_chip chip;
+	struct clk *ick;
+	struct clk *fck;
+	u8 initialized;
 	struct clk *dbck;
 	u32 dbck_enable_mask;
+	void __iomem *base;
+	u16 virtual_irq_start;
+#endif
 };
 
 static inline int gpio_get_value(unsigned gpio)
-- 
1.6.3.3

