From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH 1/4] omap: consolidate touch screen initialization among different boards
Date: Mon, 25 Apr 2011 01:09:05 +0300
Message-ID: <1738251a50b70224f124d4a54c157cc5e3c6db77.1303682352.git.mike@compulab.co.il>
References: <cover.1303682352.git.mike@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:43908
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757876Ab1DXWCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 24 Apr 2011 18:02:20 -0400
In-Reply-To: <cover.1303682352.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

Add common-board-devices.c that will contain the code for peripheral
devices initializatoin shared between multiple boards.
Start small with touchscreen initialization.

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/mach-omap2/Makefile               |    2 +
 arch/arm/mach-omap2/board-3430sdp.c        |   65 ++-------------------
 arch/arm/mach-omap2/board-cm-t35.c         |   58 +------------------
 arch/arm/mach-omap2/board-devkit8000.c     |   56 +------------------
 arch/arm/mach-omap2/board-ldp.c            |   57 +------------------
 arch/arm/mach-omap2/board-omap3evm.c       |   51 +----------------
 arch/arm/mach-omap2/board-omap3pandora.c   |   49 +---------------
 arch/arm/mach-omap2/board-omap3stalker.c   |   49 +---------------
 arch/arm/mach-omap2/board-omap3touchbook.c |   36 +-----------
 arch/arm/mach-omap2/board-overo.c          |   46 +--------------
 arch/arm/mach-omap2/common-board-devices.c |   85 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/common-board-devices.h |   18 ++++++
 12 files changed, 128 insertions(+), 444 deletions(-)
 create mode 100644 arch/arm/mach-omap2/common-board-devices.c
 create mode 100644 arch/arm/mach-omap2/common-board-devices.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 512b152..43c5c22 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -270,3 +270,5 @@ obj-$(CONFIG_ARCH_OMAP4)		+= hwspinlock.o
 
 disp-$(CONFIG_OMAP2_DSS)		:= display.o
 obj-y					+= $(disp-m) $(disp-y)
+
+obj-y					+= common-board-devices.o
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 9afd087..3726465 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -19,7 +19,6 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/io.h>
@@ -48,6 +47,7 @@
 #include "hsmmc.h"
 #include "pm.h"
 #include "control.h"
+#include "common-board-devices.h"
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -123,58 +123,6 @@ static struct twl4030_keypad_data sdp3430_kp_data = {
 	.rep		= 1,
 };
 
-static int ts_gpio;	/* Needed for ads7846_get_pendown_state */
-
-/**
- * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
- *
- * @return - void. If request gpio fails then Flag KERN_ERR.
- */
-static void ads7846_dev_init(void)
-{
-	if (gpio_request(ts_gpio, "ADS7846 pendown") < 0) {
-		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
-		return;
-	}
-
-	gpio_direction_input(ts_gpio);
-	gpio_set_debounce(ts_gpio, 310);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(ts_gpio);
-}
-
-static struct ads7846_platform_data tsc2046_config __initdata = {
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-	.wakeup				= true,
-};
-
-
-static struct omap2_mcspi_device_config tsc2046_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info sdp3430_spi_board_info[] __initdata = {
-	[0] = {
-		/*
-		 * TSC2046 operates at a max freqency of 2MHz, so
-		 * operate slightly below at 1.5MHz
-		 */
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &tsc2046_mcspi_config,
-		.irq			= 0,
-		.platform_data		= &tsc2046_config,
-	},
-};
-
-
 #define SDP3430_LCD_PANEL_BACKLIGHT_GPIO	8
 #define SDP3430_LCD_PANEL_ENABLE_GPIO		5
 
@@ -880,6 +828,8 @@ static struct omap_musb_board_data musb_board_data = {
 
 static void __init omap_3430sdp_init(void)
 {
+	int gpio_pendown;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_board_config = sdp3430_config;
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
@@ -887,13 +837,10 @@ static void __init omap_3430sdp_init(void)
 	omap3430_i2c_init();
 	omap_display_init(&sdp3430_dss_data);
 	if (omap_rev() > OMAP3430_REV_ES1_0)
-		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV2;
+		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
-		ts_gpio = SDP3430_TS_GPIO_IRQ_SDPV1;
-	sdp3430_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
-	spi_register_board_info(sdp3430_spi_board_info,
-				ARRAY_SIZE(sdp3430_spi_board_info));
-	ads7846_dev_init();
+		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV1;
+	omap_ads7846_init(1, gpio_pendown, 310, NULL);
 	board_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index b5772c1..9e5b8be 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -54,6 +54,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define CM_T35_GPIO_PENDOWN	57
 
@@ -175,61 +176,6 @@ static void __init cm_t35_init_nand(void)
 static inline void cm_t35_init_nand(void) {}
 #endif
 
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
-	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-#include <linux/spi/ads7846.h>
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(CM_T35_GPIO_PENDOWN);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-};
-
-static struct spi_board_info cm_t35_spi_board_info[] __initdata = {
-	{
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(CM_T35_GPIO_PENDOWN),
-		.platform_data		= &ads7846_config,
-	},
-};
-
-static void __init cm_t35_init_ads7846(void)
-{
-	if ((gpio_request(CM_T35_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
-	    (gpio_direction_input(CM_T35_GPIO_PENDOWN) == 0)) {
-		gpio_export(CM_T35_GPIO_PENDOWN, 0);
-	} else {
-		pr_err("CM-T35: could not obtain gpio for ADS7846_PENDOWN\n");
-		return;
-	}
-
-	spi_register_board_info(cm_t35_spi_board_info,
-				ARRAY_SIZE(cm_t35_spi_board_info));
-}
-#else
-static inline void cm_t35_init_ads7846(void) {}
-#endif
-
 #define CM_T35_LCD_EN_GPIO 157
 #define CM_T35_LCD_BL_GPIO 58
 #define CM_T35_DVI_EN_GPIO 54
@@ -732,7 +678,7 @@ static void __init cm_t35_init(void)
 	omap_serial_init();
 	cm_t35_init_i2c();
 	cm_t35_init_nand();
-	cm_t35_init_ads7846();
+	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
 	cm_t35_init_ethernet();
 	cm_t35_init_led();
 	cm_t35_init_display();
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 65f9fde..9f8338d 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -51,7 +51,6 @@
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/dm9000.h>
 #include <linux/interrupt.h>
 
@@ -60,6 +59,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "timer-gp.h"
+#include "common-board-devices.h"
 
 #define NAND_BLOCK_SIZE		SZ_128K
 
@@ -463,56 +463,6 @@ static void __init devkit8000_init_irq(void)
 #endif
 }
 
-static void __init devkit8000_ads7846_init(void)
-{
-	int gpio = OMAP3_DEVKIT_TS_GPIO;
-	int ret;
-
-	ret = gpio_request(gpio, "ads7846_pen_down");
-	if (ret < 0) {
-		printk(KERN_ERR "Failed to request GPIO %d for "
-				"ads7846 pen down IRQ\n", gpio);
-		return;
-	}
-
-	gpio_direction_input(gpio);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(OMAP3_DEVKIT_TS_GPIO);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max                  = 0x0fff,
-	.y_max                  = 0x0fff,
-	.x_plate_ohms           = 180,
-	.pressure_max           = 255,
-	.debounce_max           = 10,
-	.debounce_tol           = 5,
-	.debounce_rep           = 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-	.settle_delay_usecs     = 150,
-};
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info devkit8000_spi_board_info[] __initdata = {
-	{
-		.modalias		= "ads7846",
-		.bus_num		= 2,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OMAP3_DEVKIT_TS_GPIO),
-		.platform_data		= &ads7846_config,
-	}
-};
-
 #define OMAP_DM9000_BASE	0x2c000000
 
 static struct resource omap_dm9000_resources[] = {
@@ -795,10 +745,8 @@ static void __init devkit8000_init(void)
 			ARRAY_SIZE(devkit8000_devices));
 
 	omap_display_init(&devkit8000_dss_data);
-	spi_register_board_info(devkit8000_spi_board_info,
-	ARRAY_SIZE(devkit8000_spi_board_info));
 
-	devkit8000_ads7846_init();
+	omap_ads7846_init(2, OMAP3_DEVKIT_TS_GPIO, 0, NULL);
 
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index ea9f049..155b423 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -22,7 +22,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/io.h>
@@ -49,6 +48,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "control.h"
+#include "common-board-devices.h"
 
 #define LDP_SMSC911X_CS		1
 #define LDP_SMSC911X_GPIO	152
@@ -168,55 +168,6 @@ static struct platform_device ldp_gpio_keys_device = {
 	},
 };
 
-static int ts_gpio;
-
-/**
- * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
- *
- * @return - void. If request gpio fails then Flag KERN_ERR.
- */
-static void ads7846_dev_init(void)
-{
-	if (gpio_request(ts_gpio, "ads7846 irq") < 0) {
-		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
-		return;
-	}
-
-	gpio_direction_input(ts_gpio);
-	gpio_set_debounce(ts_gpio, 310);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(ts_gpio);
-}
-
-static struct ads7846_platform_data tsc2046_config __initdata = {
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-};
-
-static struct omap2_mcspi_device_config tsc2046_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info ldp_spi_board_info[] __initdata = {
-	[0] = {
-		/*
-		 * TSC2046 operates at a max freqency of 2MHz, so
-		 * operate slightly below at 1.5MHz
-		 */
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &tsc2046_mcspi_config,
-		.irq			= 0,
-		.platform_data		= &tsc2046_config,
-	},
-};
-
 static struct omap_smsc911x_platform_data smsc911x_cfg = {
 	.cs             = LDP_SMSC911X_CS,
 	.gpio_irq       = LDP_SMSC911X_GPIO,
@@ -399,11 +350,7 @@ static void __init omap_ldp_init(void)
 	ldp_init_smsc911x();
 	omap_i2c_init();
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
-	ts_gpio = 54;
-	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
-	spi_register_board_info(ldp_spi_board_info,
-				ARRAY_SIZE(ldp_spi_board_info));
-	ads7846_dev_init();
+	omap_ads7846_init(1, 54, 310, NULL);
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_nand_init(ldp_nand_partitions,
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 3fc85c6..376ea87 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -50,6 +50,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define OMAP3_EVM_TS_GPIO	175
 #define OMAP3_EVM_EHCI_VBUS	22
@@ -630,51 +631,6 @@ static int __init omap3_evm_i2c_init(void)
 	return 0;
 }
 
-static void ads7846_dev_init(void)
-{
-	if (gpio_request(OMAP3_EVM_TS_GPIO, "ADS7846 pendown") < 0)
-		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
-
-	gpio_direction_input(OMAP3_EVM_TS_GPIO);
-	gpio_set_debounce(OMAP3_EVM_TS_GPIO, 310);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-	.settle_delay_usecs	= 150,
-	.wakeup				= true,
-};
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info omap3evm_spi_board_info[] = {
-	[0] = {
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OMAP3_EVM_TS_GPIO),
-		.platform_data		= &ads7846_config,
-	},
-};
-
 static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
 };
 
@@ -792,9 +748,6 @@ static void __init omap3_evm_init(void)
 
 	omap_display_init(&omap3_evm_dss_data);
 
-	spi_register_board_info(omap3evm_spi_board_info,
-				ARRAY_SIZE(omap3evm_spi_board_info));
-
 	omap_serial_init();
 
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
@@ -827,7 +780,7 @@ static void __init omap3_evm_init(void)
 	}
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	ads7846_dev_init();
+	omap_ads7846_init(1, OMAP3_EVM_TS_GPIO, 310, NULL);
 	omap3evm_init_smsc911x();
 	omap3_evm_display_init();
 
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 07dba88..517701a 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/regulator/machine.h>
 #include <linux/i2c/twl.h>
 #include <linux/wl12xx.h>
@@ -52,6 +51,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define PANDORA_WIFI_IRQ_GPIO		21
 #define PANDORA_WIFI_NRESET_GPIO	23
@@ -570,53 +570,8 @@ static int __init omap3pandora_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3pandora_ads7846_init(void)
-{
-	int gpio = OMAP3_PANDORA_TS_GPIO;
-	int ret;
-
-	ret = gpio_request(gpio, "ads7846_pen_down");
-	if (ret < 0) {
-		printk(KERN_ERR "Failed to request GPIO %d for "
-				"ads7846 pen down IRQ\n", gpio);
-		return;
-	}
-
-	gpio_direction_input(gpio);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(OMAP3_PANDORA_TS_GPIO);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-};
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
 static struct spi_board_info omap3pandora_spi_board_info[] __initdata = {
 	{
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OMAP3_PANDORA_TS_GPIO),
-		.platform_data		= &ads7846_config,
-	}, {
 		.modalias		= "tpo_td043mtea1_panel_spi",
 		.bus_num		= 1,
 		.chip_select		= 1,
@@ -705,7 +660,7 @@ static void __init omap3pandora_init(void)
 	omap_serial_init();
 	spi_register_board_info(omap3pandora_spi_board_info,
 			ARRAY_SIZE(omap3pandora_spi_board_info));
-	omap3pandora_ads7846_init();
+	omap_ads7846_init(1, OMAP3_PANDORA_TS_GPIO, 0, NULL);
 	usbhs_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 	gpmc_nand_init(&pandora_nand_data);
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 848016c..671ceb0 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -45,7 +45,6 @@
 #include <plat/mcspi.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
-#include <linux/spi/ads7846.h>
 #include <linux/interrupt.h>
 #include <linux/smsc911x.h>
 #include <linux/i2c/at24.h>
@@ -54,6 +53,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "timer-gp.h"
+#include "common-board-devices.h"
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 #include <plat/gpmc-smsc911x.h>
@@ -498,49 +498,6 @@ static int __init omap3_stalker_i2c_init(void)
 }
 
 #define OMAP3_STALKER_TS_GPIO	175
-static void ads7846_dev_init(void)
-{
-	if (gpio_request(OMAP3_STALKER_TS_GPIO, "ADS7846 pendown") < 0)
-		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
-
-	gpio_direction_input(OMAP3_STALKER_TS_GPIO);
-	gpio_set_debounce(OMAP3_STALKER_TS_GPIO, 310);
-}
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(OMAP3_STALKER_TS_GPIO);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-	.settle_delay_usecs	= 150,
-};
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode		= 0,
-	.single_channel		= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info omap3stalker_spi_board_info[] = {
-	[0] = {
-	       .modalias	= "ads7846",
-	       .bus_num		= 1,
-	       .chip_select	= 0,
-	       .max_speed_hz	= 1500000,
-	       .controller_data	= &ads7846_mcspi_config,
-	       .irq		= OMAP_GPIO_IRQ(OMAP3_STALKER_TS_GPIO),
-	       .platform_data	= &ads7846_config,
-	},
-};
 
 static struct omap_board_config_kernel omap3_stalker_config[] __initdata = {
 };
@@ -602,13 +559,11 @@ static void __init omap3_stalker_init(void)
 			     ARRAY_SIZE(omap3_stalker_devices));
 
 	omap_display_init(&omap3_stalker_dss_data);
-	spi_register_board_info(omap3stalker_spi_board_info,
-				ARRAY_SIZE(omap3stalker_spi_board_info));
 
 	omap_serial_init();
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
-	ads7846_dev_init();
+	omap_ads7846_init(1, OMAP3_STALKER_TS_GPIO, 310, NULL);
 
 	omap_mux_init_gpio(21, OMAP_PIN_OUTPUT);
 	omap_mux_init_gpio(18, OMAP_PIN_INPUT_PULLUP);
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index 127cb17..15f9d7d 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -52,6 +52,7 @@
 #include "mux.h"
 #include "hsmmc.h"
 #include "timer-gp.h"
+#include "common-board-devices.h"
 
 #include <asm/setup.h>
 
@@ -301,19 +302,7 @@ static int __init omap3_touchbook_i2c_init(void)
 	return 0;
 }
 
-static void __init omap3_ads7846_init(void)
-{
-	if (gpio_request(OMAP3_TS_GPIO, "ads7846_pen_down")) {
-		printk(KERN_ERR "Failed to request GPIO %d for "
-				"ads7846 pen down IRQ\n", OMAP3_TS_GPIO);
-		return;
-	}
-
-	gpio_direction_input(OMAP3_TS_GPIO);
-	gpio_set_debounce(OMAP3_TS_GPIO, 310);
-}
-
-static struct ads7846_platform_data ads7846_config = {
+static struct ads7846_platform_data ads7846_pdata = {
 	.x_min			= 100,
 	.y_min			= 265,
 	.x_max			= 3950,
@@ -327,23 +316,6 @@ static struct ads7846_platform_data ads7846_config = {
 	.keep_vref_on		= 1,
 };
 
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static struct spi_board_info omap3_ads7846_spi_board_info[] __initdata = {
-	{
-		.modalias		= "ads7846",
-		.bus_num		= 4,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OMAP3_TS_GPIO),
-		.platform_data		= &ads7846_config,
-	}
-};
-
 static struct gpio_led gpio_leds[] = {
 	{
 		.name			= "touchbook::usr0",
@@ -526,9 +498,7 @@ static void __init omap3_touchbook_init(void)
 	gpio_direction_output(176, true);
 
 	/* Touchscreen and accelerometer */
-	spi_register_board_info(omap3_ads7846_spi_board_info,
-				ARRAY_SIZE(omap3_ads7846_spi_board_info));
-	omap3_ads7846_init();
+	omap_ads7846_init(4, OMAP3_TS_GPIO, 310, &ads7846_pdata);
 	usb_musb_init(&musb_board_data);
 	usbhs_init(&usbhs_bdata);
 	omap3touchbook_flash_init();
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4016166..abe4f14 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -56,6 +56,7 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "hsmmc.h"
+#include "common-board-devices.h"
 
 #define OVERO_GPIO_BT_XGATE	15
 #define OVERO_GPIO_W2W_NRESET	16
@@ -74,30 +75,6 @@
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
-#include <linux/spi/ads7846.h>
-
-static struct omap2_mcspi_device_config ads7846_mcspi_config = {
-	.turbo_mode	= 0,
-	.single_channel	= 1,	/* 0: slave, 1: master */
-};
-
-static int ads7846_get_pendown_state(void)
-{
-	return !gpio_get_value(OVERO_GPIO_PENDOWN);
-}
-
-static struct ads7846_platform_data ads7846_config = {
-	.x_max			= 0x0fff,
-	.y_max			= 0x0fff,
-	.x_plate_ohms		= 180,
-	.pressure_max		= 255,
-	.debounce_max		= 10,
-	.debounce_tol		= 3,
-	.debounce_rep		= 1,
-	.get_pendown_state	= ads7846_get_pendown_state,
-	.keep_vref_on		= 1,
-};
-
 /* fixed regulator for ads7846 */
 static struct regulator_consumer_supply ads7846_supply =
 	REGULATOR_SUPPLY("vcc", "spi1.0");
@@ -128,14 +105,7 @@ static struct platform_device vads7846_device = {
 
 static void __init overo_ads7846_init(void)
 {
-	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
-	    (gpio_direction_input(OVERO_GPIO_PENDOWN) == 0)) {
-		gpio_export(OVERO_GPIO_PENDOWN, 0);
-	} else {
-		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
-		return;
-	}
-
+	omap_ads7846_init(1, OVERO_GPIO_PENDOWN, 0, NULL);
 	platform_device_register(&vads7846_device);
 }
 
@@ -587,18 +557,6 @@ static int __init overo_i2c_init(void)
 }
 
 static struct spi_board_info overo_spi_board_info[] __initdata = {
-#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
-	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
-	{
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
-		.platform_data		= &ads7846_config,
-	},
-#endif
 #if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
 	{
diff --git a/arch/arm/mach-omap2/common-board-devices.c b/arch/arm/mach-omap2/common-board-devices.c
new file mode 100644
index 0000000..fad41ec
--- /dev/null
+++ b/arch/arm/mach-omap2/common-board-devices.c
@@ -0,0 +1,85 @@
+/*
+ * common-board-devices.c
+ *
+ * Copyright (C) 2011 CompuLab, Ltd.
+ * Author: Mike Rapoport <mike@compulab.co.il>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+#include <plat/mcspi.h>
+
+#include "common-board-devices.h"
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+static struct ads7846_platform_data ads7846_config = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 10,
+	.debounce_tol		= 3,
+	.debounce_rep		= 1,
+	.gpio_pendown		= -EINVAL,
+	.keep_vref_on		= 1,
+};
+
+static struct spi_board_info ads7846_spi_board_info __initdata = {
+	.modalias		= "ads7846",
+	.bus_num		= -EINVAL,
+	.chip_select		= 0,
+	.max_speed_hz		= 1500000,
+	.controller_data	= &ads7846_mcspi_config,
+	.irq			= -EINVAL,
+	.platform_data		= &ads7846_config,
+};
+
+void __init omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
+			      struct ads7846_platform_data *board_pdata)
+{
+	struct spi_board_info *spi_bi = &ads7846_spi_board_info;
+	int err;
+
+	err = gpio_request(gpio_pendown, "TS PenDown");
+	if (err) {
+		pr_err("Could not obtain gpio for TS PenDown: %d\n", err);
+		return;
+	}
+
+	gpio_direction_input(gpio_pendown);
+	gpio_export(gpio_pendown, 0);
+
+	if (gpio_debounce)
+		gpio_set_debounce(gpio_pendown, gpio_debounce);
+
+	ads7846_config.gpio_pendown = gpio_pendown;
+
+	spi_bi->bus_num	= bus_num;
+	spi_bi->irq	= OMAP_GPIO_IRQ(gpio_pendown);
+
+	if (board_pdata)
+		spi_bi->platform_data = board_pdata;
+
+	spi_register_board_info(&ads7846_spi_board_info, 1);
+}
diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
new file mode 100644
index 0000000..75f9248d
--- /dev/null
+++ b/arch/arm/mach-omap2/common-board-devices.h
@@ -0,0 +1,18 @@
+#ifndef __OMAP_COMMON_BOARD_DEVICES__
+#define __OMAP_COMMON_BOARD_DEVICES__
+
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+struct ads7846_platform_data;
+
+void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
+		       struct ads7846_platform_data *board_pdata);
+#else
+static inline void omap_ads7846_init(int bus_num,
+				     int gpio_pendown, int gpio_debounce,
+				     struct ads7846_platform_data *board_data)
+{
+}
+#endif
+
+#endif /* __OMAP_COMMON_BOARD_DEVICES__ */
-- 
1.7.3.1

