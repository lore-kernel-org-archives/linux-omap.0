From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] ARM: OMAP3: Initialize more devices for LDP
Date: Fri, 22 May 2009 15:45:41 -0700
Message-ID: <20090522224541.31586.68943.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56672 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbZEVWpk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:45:40 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Based on an earlier patches by Stanley.Miao <stanley.miao@windriver.com>
and Nishant Kamat <nskamat@ti.com>.

Note that at the ads7846 support still needs support for vaux_control
for the touchscreen to work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-ldp.c          |  204 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/keypad.h |    4 +
 2 files changed, 207 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 59ac8ed..d8bc0a7 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -16,11 +16,13 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/regulator/machine.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/io.h>
 #include <linux/smsc911x.h>
@@ -39,6 +41,7 @@
 #include <asm/delay.h>
 #include <mach/control.h>
 #include <mach/usb.h>
+#include <mach/keypad.h>
 
 #include "mmc-twl4030.h"
 
@@ -77,6 +80,165 @@ static struct platform_device ldp_smsc911x_device = {
 	},
 };
 
+static int ldp_twl4030_keymap[] = {
+	KEY(0, 0, KEY_1),
+	KEY(1, 0, KEY_2),
+	KEY(2, 0, KEY_3),
+	KEY(0, 1, KEY_4),
+	KEY(1, 1, KEY_5),
+	KEY(2, 1, KEY_6),
+	KEY(3, 1, KEY_F5),
+	KEY(0, 2, KEY_7),
+	KEY(1, 2, KEY_8),
+	KEY(2, 2, KEY_9),
+	KEY(3, 2, KEY_F6),
+	KEY(0, 3, KEY_F7),
+	KEY(1, 3, KEY_0),
+	KEY(2, 3, KEY_F8),
+	PERSISTENT_KEY(4, 5),
+	KEY(4, 4, KEY_VOLUMEUP),
+	KEY(5, 5, KEY_VOLUMEDOWN),
+	0
+};
+
+static struct twl4030_keypad_data ldp_kp_twl4030_data = {
+	.rows		= 6,
+	.cols		= 6,
+	.keymap		= ldp_twl4030_keymap,
+	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
+	.rep		= 1,
+};
+
+static struct gpio_keys_button ldp_gpio_keys_buttons[] = {
+	[0] = {
+		.code			= KEY_ENTER,
+		.gpio			= 101,
+		.desc			= "enter sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[1] = {
+		.code			= KEY_F1,
+		.gpio			= 102,
+		.desc			= "func 1",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[2] = {
+		.code			= KEY_F2,
+		.gpio			= 103,
+		.desc			= "func 2",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[3] = {
+		.code			= KEY_F3,
+		.gpio			= 104,
+		.desc			= "func 3",
+		.active_low		= 1,
+		.debounce_interval 	= 30,
+	},
+	[4] = {
+		.code			= KEY_F4,
+		.gpio			= 105,
+		.desc			= "func 4",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[5] = {
+		.code			= KEY_LEFT,
+		.gpio			= 106,
+		.desc			= "left sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[6] = {
+		.code			= KEY_RIGHT,
+		.gpio			= 107,
+		.desc			= "right sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[7] = {
+		.code			= KEY_UP,
+		.gpio			= 108,
+		.desc			= "up sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+	[8] = {
+		.code			= KEY_DOWN,
+		.gpio			= 109,
+		.desc			= "down sw",
+		.active_low		= 1,
+		.debounce_interval	= 30,
+	},
+};
+
+static struct gpio_keys_platform_data ldp_gpio_keys = {
+	.buttons		= ldp_gpio_keys_buttons,
+	.nbuttons		= ARRAY_SIZE(ldp_gpio_keys_buttons),
+	.rep			= 1,
+};
+
+static struct platform_device ldp_gpio_keys_device = {
+	.name		= "gpio-keys",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &ldp_gpio_keys,
+	},
+};
+
+static int ts_gpio;
+
+/**
+ * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
+ *
+ * @return - void. If request gpio fails then Flag KERN_ERR.
+ */
+static void ads7846_dev_init(void)
+{
+	if (gpio_request(ts_gpio, "ads7846 irq") < 0) {
+		printk(KERN_ERR "can't get ads746 pen down GPIO\n");
+		return;
+	}
+
+	gpio_direction_input(ts_gpio);
+	omap_set_gpio_debounce(ts_gpio, 1);
+	omap_set_gpio_debounce_time(ts_gpio, 0xa);
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !gpio_get_value(ts_gpio);
+}
+
+static struct ads7846_platform_data tsc2046_config __initdata = {
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+};
+
+static struct omap2_mcspi_device_config tsc2046_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,	/* 0: slave, 1: master */
+};
+
+static struct spi_board_info ldp_spi_board_info[] __initdata = {
+	[0] = {
+		/*
+		 * TSC2046 operates at a max freqency of 2MHz, so
+		 * operate slightly below at 1.5MHz
+		 */
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &tsc2046_mcspi_config,
+		.irq			= 0,
+		.platform_data		= &tsc2046_config,
+	},
+};
+
 static inline void __init ldp_init_smsc911x(void)
 {
 	int eth_cs;
@@ -132,18 +294,49 @@ static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
+static struct twl4030_usb_data ldp_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 };
 
+static struct twl4030_madc_platform_data ldp_madc_data = {
+	.irq_line	= 1,
+};
+
+static struct regulator_consumer_supply ldp_vmmc1_supply = {
+	.supply			= "vmmc",
+};
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data ldp_vmmc1 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &ldp_vmmc1_supply,
+};
+
 static struct twl4030_platform_data ldp_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
 
 	/* platform_data for children goes here */
+	.madc		= &ldp_madc_data,
+	.usb		= &ldp_usb_data,
+	.vmmc1		= &ldp_vmmc1,
 	.gpio		= &ldp_gpio_data,
+	.keypad		= &ldp_kp_twl4030_data,
 };
 
 static struct i2c_board_info __initdata ldp_i2c_boardinfo[] = {
@@ -177,6 +370,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_smsc911x_device,
 	&ldp_lcd_device,
+	&ldp_gpio_keys_device,
 };
 
 static void __init omap_ldp_init(void)
@@ -185,9 +379,17 @@ static void __init omap_ldp_init(void)
 	platform_add_devices(ldp_devices, ARRAY_SIZE(ldp_devices));
 	omap_board_config = ldp_config;
 	omap_board_config_size = ARRAY_SIZE(ldp_config);
+	ts_gpio = 54;
+	ldp_spi_board_info[0].irq = gpio_to_irq(ts_gpio);
+	spi_register_board_info(ldp_spi_board_info,
+				ARRAY_SIZE(ldp_spi_board_info));
+	ads7846_dev_init();
 	omap_serial_init();
-	twl4030_mmc_init(mmc);
 	usb_musb_init();
+
+	twl4030_mmc_init(mmc);
+	/* link regulators to MMC adapters */
+	ldp_vmmc1_supply.dev = mmc[0].dev;
 }
 
 static void __init omap_ldp_map_io(void)
diff --git a/arch/arm/plat-omap/include/mach/keypad.h b/arch/arm/plat-omap/include/mach/keypad.h
index 232923a..45ea3ae 100644
--- a/arch/arm/plat-omap/include/mach/keypad.h
+++ b/arch/arm/plat-omap/include/mach/keypad.h
@@ -33,7 +33,11 @@ struct omap_kp_platform_data {
 #define GROUP_3		(3 << 16)
 #define GROUP_MASK	GROUP_3
 
+#define KEY_PERSISTENT		0x00800000
+#define KEYNUM_MASK		0x00EFFFFF
 #define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
+#define PERSISTENT_KEY(col, row) (((col) << 28) | ((row) << 24) | \
+						KEY_PERSISTENT)
 
 #endif
 

