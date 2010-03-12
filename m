From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH v3 2/2] omap: rx-51: enable tsc2005
Date: Fri, 12 Mar 2010 18:54:34 +0200
Message-ID: <1268412874-18869-2-git-send-email-aaro.koskinen@nokia.com>
References: <1268412874-18869-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1268412874-18869-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-input-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: aaro.koskinen@nokia.com
List-Id: linux-omap@vger.kernel.org

Enable TSC2005 touchscreen driver on the RX-51 board.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/configs/rx51_defconfig              |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   57 ++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index b6eeebb..95b76ec 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -801,6 +801,7 @@ CONFIG_INPUT_TOUCHSCREEN=y
 # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
 # CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
 # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
+CONFIG_TOUCHSCREEN_TSC2005=m
 # CONFIG_TOUCHSCREEN_TSC2007 is not set
 CONFIG_INPUT_MISC=y
 # CONFIG_INPUT_ATI_REMOTE is not set
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index acafdbc..bdd7398 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -14,6 +14,7 @@
 #include <linux/input.h>
 #include <linux/input/matrix_keypad.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/tsc2005.h>
 #include <linux/spi/wl12xx.h>
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
@@ -42,18 +43,28 @@
 #define RX51_WL1251_POWER_GPIO		87
 #define RX51_WL1251_IRQ_GPIO		42
 
+#define RX51_TSC2005_RESET_GPIO		104
+#define RX51_TSC2005_IRQ_GPIO		100
+
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
+	RX51_SPI_TSC2005,
 };
 
 static struct wl12xx_platform_data wl1251_pdata;
+static struct tsc2005_platform_data tsc2005_pdata;
 
 static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.turbo_mode	= 0,
 	.single_channel	= 1,
 };
 
+static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
+	.turbo_mode     = 0,
+	.single_channel = 1,
+};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -64,6 +75,15 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.controller_data	= &wl1251_mcspi_config,
 		.platform_data		= &wl1251_pdata,
 	},
+	[RX51_SPI_TSC2005] = {
+		.modalias		= "tsc2005",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
+		.max_speed_hz		= 6000000,
+		.controller_data	= &tsc2005_mcspi_config,
+		.platform_data		= &tsc2005_pdata,
+	},
 };
 
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
@@ -665,6 +685,42 @@ static inline void board_onenand_init(void)
 
 #endif
 
+static struct tsc2005_platform_data tsc2005_pdata = {
+	.ts_pressure_max   = 2048,
+	.ts_pressure_fudge = 2,
+	.ts_x_max	   = 4096,
+	.ts_x_fudge	   = 4,
+	.ts_y_max	   = 4096,
+	.ts_y_fudge	   = 7,
+	.ts_x_plate_ohm	   = 280,
+	.esd_timeout_ms	   = 8000,
+};
+
+static void rx51_tsc2005_set_reset(bool enable)
+{
+	gpio_set_value(RX51_TSC2005_RESET_GPIO, enable);
+}
+
+static void __init rx51_init_tsc2005(void)
+{
+	int r;
+
+	r = gpio_request(RX51_TSC2005_IRQ_GPIO, "tsc2005 IRQ");
+	if (r >= 0)
+		gpio_direction_input(RX51_TSC2005_IRQ_GPIO);
+	else
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 IRQ");
+
+	r = gpio_request(RX51_TSC2005_RESET_GPIO, "tsc2005 reset");
+	if (r >= 0) {
+		gpio_direction_output(RX51_TSC2005_RESET_GPIO, 1);
+		tsc2005_pdata.set_reset = rx51_tsc2005_set_reset;
+	} else {
+		printk(KERN_ERR "unable to get %s GPIO\n", "tsc2005 reset");
+		tsc2005_pdata.esd_timeout_ms = 0;
+	}
+}
+
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
@@ -749,6 +805,7 @@ void __init rx51_peripherals_init(void)
 	board_smc91x_init();
 	rx51_add_gpio_keys();
 	rx51_init_wl1251();
+	rx51_init_tsc2005();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
 }
-- 
1.6.0.4

