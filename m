From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH 2/2] mt_ventoux: support for TeeJet Mt.Ventoux board
Date: Tue, 27 Dec 2011 00:08:32 +0100
Message-ID: <1324940912-18164-3-git-send-email-yanok@emcraft.com>
References: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:37207 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462Ab1LZXIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Dec 2011 18:08:42 -0500
In-Reply-To: <1324940912-18164-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

This patch adds support for TeeJet Mt.Ventoux board based on TAM3517
SOM. Supported devices:
 - Serial
 - Ethernet
 - NAND
 - USB host
 - LCD
 - Touchscreen
 - CAN controller
 - ADC128S converter

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
Requires updated machine-type file, recently posted AM35xx-EMAC patch
and "Disable PM init on AM35{05,17} patch.

 arch/arm/mach-omap2/Kconfig                   |    6 +
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-am3517_mt_ventoux.c |  708 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h  |    1 +
 4 files changed, 716 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-am3517_mt_ventoux.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index fd9b8c0..45f5dcb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -237,6 +237,12 @@ config MACH_MCX
 	select OMAP_PACKAGE_CBB
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_AM3517_MT_VENTOUX
+	bool "TeeJet MT_VENTOUX (TAM3517 based) board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CBB
+	select REGULATOR_FIXED_VOLTAGE
+
 config MACH_NOKIA_N800
        bool
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 9405dfc..cbc3a36 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -239,6 +239,7 @@ obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 obj-$(CONFIG_MACH_MCX)			+= board-mcx.o
+obj-$(CONFIG_MACH_AM3517_MT_VENTOUX)	+= board-am3517_mt_ventoux.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-am3517_mt_ventoux.c b/arch/arm/mach-omap2/board-am3517_mt_ventoux.c
new file mode 100644
index 0000000..d4501d9
--- /dev/null
+++ b/arch/arm/mach-omap2/board-am3517_mt_ventoux.c
@@ -0,0 +1,708 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
+ *
+ * Modified from mach-omap2/board-mcx.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/plat-ram.h>
+#include <linux/mmc/host.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/spi/ads7846.h>
+#include <linux/spi/spi.h>
+#include <linux/can/platform/ti_hecc.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <plat/common.h>
+#include <plat/mcspi.h>
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+#include <plat/usb.h>
+
+#include <mach/am35xx.h>
+
+#include "am35xx-emac.h"
+#include "mux.h"
+#include "control.h"
+#include "hsmmc.h"
+#include "common-board-devices.h"
+#include "common.h"
+
+/* FPGA */
+static struct platdata_mtd_ram mt_ventoux_fpga_data = {
+	.bankwidth = 2,
+};
+
+#define FPGA_BASE_ADDR		0x20000000
+static struct resource mt_ventoux_fpga_resource = {
+	.start = FPGA_BASE_ADDR,
+	.end   = FPGA_BASE_ADDR + SZ_128M - 1,
+	.flags = IORESOURCE_MEM,
+};
+
+static struct platform_device mt_ventoux_fpga_device = {
+	.name = "mtd-ram",
+	.id = 0,
+	.dev = {
+		.platform_data = &mt_ventoux_fpga_data,
+	},
+	.num_resources = 1,
+	.resource = &mt_ventoux_fpga_resource,
+};
+
+#define MCX_MDIO_FREQUENCY	(1000000)
+
+static struct mtd_partition mt_ventoux_nand_partitions[] = {
+	/* All the partition sizes are listed in terms of NAND block size */
+	{
+		.name		= "X-Loader",
+		.offset		= 0,
+		.size		= 4 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size		= 15 * NAND_BLOCK_SIZE,
+		.mask_flags	= MTD_WRITEABLE,	/* force read-only */
+	},
+	{
+		.name		= "U-Boot Env",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x260000 */
+		.size		= 1 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "Kernel",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size		= 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name		= "File System",
+		.offset		= MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.size		= MTDPART_SIZ_FULL,
+	},
+};
+
+#define PANEL_PWR_PIN		138
+#define LCD_PANEL_PON_PIN	139
+#define DVI_PON_PIN		24
+
+static int lcd_enabled;
+static int dvi_enabled;
+
+static int mt_ventoux_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		pr_err("cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(LCD_PANEL_PON_PIN, 1);
+	gpio_set_value(PANEL_PWR_PIN, 0);
+	lcd_enabled = 1;
+
+	return 0;
+}
+
+static void mt_ventoux_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(PANEL_PWR_PIN, 1);
+	gpio_set_value(LCD_PANEL_PON_PIN, 0);
+	lcd_enabled = 0;
+}
+
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "ortustech_com43h4m10xtc",
+	.platform_enable	= mt_ventoux_panel_enable_lcd,
+	.platform_disable	= mt_ventoux_panel_disable_lcd,
+};
+
+static struct omap_dss_device mt_ventoux_lcd_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+/*
+ * TV Output
+ */
+
+static int mt_ventoux_panel_enable_tv(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void mt_ventoux_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+}
+
+static struct omap_dss_device mt_ventoux_tv_device = {
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.name			= "tv",
+	.driver_name		= "venc",
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable	= mt_ventoux_panel_enable_tv,
+	.platform_disable	= mt_ventoux_panel_disable_tv,
+};
+
+/*
+ * DVI/HDMI Output
+ */
+
+static int mt_ventoux_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		pr_err("cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+	gpio_set_value(DVI_PON_PIN, 1);
+	return 0;
+}
+
+static void mt_ventoux_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	dvi_enabled = 0;
+	gpio_set_value(DVI_PON_PIN, 0);
+}
+
+static struct panel_generic_dpi_data dvi_panel = {
+	.platform_enable	= mt_ventoux_panel_enable_dvi,
+	.platform_disable	= mt_ventoux_panel_disable_dvi,
+};
+static struct omap_dss_device mt_ventoux_dvi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dvi",
+	.driver_name		= "dvi",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device *mt_ventoux_dss_devices[] = {
+	&mt_ventoux_lcd_device,
+	&mt_ventoux_tv_device,
+	&mt_ventoux_dvi_device,
+};
+
+static struct omap_dss_board_info mt_ventoux_dss_data = {
+	.num_devices	= ARRAY_SIZE(mt_ventoux_dss_devices),
+	.devices	= mt_ventoux_dss_devices,
+	.default_device	= &mt_ventoux_lcd_device,
+};
+
+/*
+ * use fake regulator for vdds_dsi as we can't find this pin inside
+ * AM3517 datasheet.
+ */
+static struct regulator_consumer_supply mt_ventoux_vdds_dsi_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
+};
+
+static struct regulator_init_data mt_ventoux_vdds_dsi = {
+	.constraints		= {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.always_on		= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(mt_ventoux_vdds_dsi_supply),
+	.consumer_supplies	= mt_ventoux_vdds_dsi_supply,
+};
+
+static struct fixed_voltage_config mt_ventoux_display = {
+	.supply_name		= "display",
+	.microvolts		= 1800000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &mt_ventoux_vdds_dsi,
+};
+
+static struct platform_device mt_ventoux_display_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mt_ventoux_display,
+	},
+};
+
+static struct gpio mt_ventoux_dss_gpios[] __initdata = {
+	{ PANEL_PWR_PIN, GPIOF_OUT_INIT_HIGH, "panel_pwr"		},
+	{ LCD_PANEL_PON_PIN, GPIOF_OUT_INIT_LOW, "lcd_power_pon"	},
+	{ DVI_PON_PIN, GPIOF_OUT_INIT_LOW, "dvi_pon"			},
+};
+
+static void __init mt_ventoux_display_init(void)
+{
+	int r;
+
+	omap_mux_init_gpio(PANEL_PWR_PIN, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(LCD_PANEL_PON_PIN, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(DVI_PON_PIN, OMAP_PIN_OUTPUT);
+
+	r = gpio_request_array(mt_ventoux_dss_gpios, ARRAY_SIZE(mt_ventoux_dss_gpios));
+	if (r) {
+		pr_err("failed to get DSS control GPIOs\n");
+		return;
+	}
+
+	r = omap_display_init(&mt_ventoux_dss_data);
+	if (r) {
+		pr_err("Failed to register DSS device\n");
+		gpio_free_array(mt_ventoux_dss_gpios, ARRAY_SIZE(mt_ventoux_dss_gpios));
+	}
+}
+
+/* TPS65023 specific initialization */
+/* VDCDC1 -> VDD_CORE */
+static struct regulator_consumer_supply am3517_vdcdc1_supplies[] = {
+	{
+		.supply = "vdd_core",
+	},
+};
+
+/* VDCDC2 -> VDDSHV */
+static struct regulator_consumer_supply am3517_vdcdc2_supplies[] = {
+	{
+		.supply = "vddshv",
+	},
+};
+
+/*
+ * VDCDC2 |-> VDDS
+ *	  |-> VDDS_SRAM_CORE_BG
+ *	  |-> VDDS_SRAM_MPU
+ */
+static struct regulator_consumer_supply am3517_vdcdc3_supplies[] = {
+	{
+		.supply = "vdds",
+	},
+	{
+		.supply = "vdds_sram_core_bg",
+	},
+	{
+		.supply = "vdds_sram_mpu",
+	},
+};
+
+/*
+ * LDO1 |-> VDDA1P8V_USBPHY
+ *	|-> VDDA_DAC
+ */
+static struct regulator_consumer_supply am3517_ldo1_supplies[] = {
+	{
+		.supply = "vdda1p8v_usbphy",
+	},
+	{
+		.supply = "vdda_dac",
+	},
+};
+
+/* LDO2 -> VDDA3P3V_USBPHY */
+static struct regulator_consumer_supply am3517_ldo2_supplies[] = {
+	{
+		.supply = "vdda3p3v_usbphy",
+	},
+};
+
+static struct regulator_init_data mt_ventoux_regulator_data[] = {
+	/* DCDC1 */
+	{
+		.constraints = {
+			.min_uV = 1200000,
+			.max_uV = 1200000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc1_supplies),
+		.consumer_supplies = am3517_vdcdc1_supplies,
+	},
+	/* DCDC2 */
+	{
+		.constraints = {
+			.min_uV = 3300000,
+			.max_uV = 3300000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc2_supplies),
+		.consumer_supplies = am3517_vdcdc2_supplies,
+	},
+	/* DCDC3 */
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 1800000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = true,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc3_supplies),
+		.consumer_supplies = am3517_vdcdc3_supplies,
+	},
+	/* LDO1 */
+	{
+		.constraints = {
+			.min_uV = 1800000,
+			.max_uV = 1800000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = false,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo1_supplies),
+		.consumer_supplies = am3517_ldo1_supplies,
+	},
+	/* LDO2 */
+	{
+		.constraints = {
+			.min_uV = 3300000,
+			.max_uV = 3300000,
+			.valid_modes_mask = REGULATOR_MODE_NORMAL,
+			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+			.always_on = false,
+			.apply_uV = false,
+		},
+		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo2_supplies),
+		.consumer_supplies = am3517_ldo2_supplies,
+	},
+};
+
+static struct i2c_board_info __initdata mt_ventoux_i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("tps65023", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &mt_ventoux_regulator_data[0],
+	},
+        {
+                I2C_BOARD_INFO("24c02", 0x50),
+        },
+};
+
+static struct i2c_board_info __initdata mt_ventoux_i2c2_devices[] = {
+        {
+                I2C_BOARD_INFO("24c02", 0x50),
+        },
+};
+
+static struct i2c_board_info __initdata mt_ventoux_i2c3_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1307", 0x68),
+	},
+};
+
+static void __init mt_ventoux_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 400, mt_ventoux_i2c1_devices,
+			ARRAY_SIZE(mt_ventoux_i2c1_devices));
+	omap_register_i2c_bus(2, 400, mt_ventoux_i2c2_devices,
+			ARRAY_SIZE(mt_ventoux_i2c2_devices));
+	omap_register_i2c_bus(3, 400, mt_ventoux_i2c3_devices,
+			ARRAY_SIZE(mt_ventoux_i2c3_devices));
+}
+
+#if defined(CONFIG_TOUCHSCREEN_ADS7846)
+/*
+ * use fake regulator for tsc2046 vcc
+ */
+static struct regulator_consumer_supply mt_ventoux_tsc2046_vcc_supply[] = {
+	REGULATOR_SUPPLY("vcc", "spi1.0"),
+};
+
+static struct regulator_init_data mt_ventoux_tsc2046_vcc = {
+	.constraints		= {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.always_on		= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(mt_ventoux_tsc2046_vcc_supply),
+	.consumer_supplies	= mt_ventoux_tsc2046_vcc_supply,
+};
+
+static struct fixed_voltage_config mt_ventoux_ts = {
+	.supply_name		= "touchscreen",
+	.microvolts		= 3300000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &mt_ventoux_tsc2046_vcc,
+};
+
+static struct platform_device mt_ventoux_ts_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data	= &mt_ventoux_ts,
+	},
+};
+
+static struct ads7846_platform_data tsc2046_config __initdata = {
+	.x_max			= 0x0fff,
+	.y_max			= 0x0fff,
+	.x_plate_ohms		= 180,
+	.pressure_max		= 255,
+	.debounce_max		= 30,
+	.debounce_tol		= 10,
+	.debounce_rep		= 1,
+	.keep_vref_on		= 1,
+	.settle_delay_usecs	= 100,
+};
+#endif
+
+#define USB_PHY1_RESET		25
+
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = USB_PHY1_RESET,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+#define SD_CARD_CD		126
+
+static struct omap2_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_cd        = SD_CARD_CD,
+		.gpio_wp        = -EINVAL,
+	},
+	{}      /* Terminator */
+};
+
+#ifdef CONFIG_SENSORS_ADCXX
+static struct omap2_mcspi_device_config adc128s_mcspi_config = {
+	.turbo_mode	= 0,
+};
+
+static struct spi_board_info adc128s_spi_board_info __initdata = {
+	.modalias		= "adcxx8s",
+	.bus_num		= 2,
+	.chip_select		= 1,
+	.max_speed_hz		= 1600000,
+	.controller_data	= &adc128s_mcspi_config,
+	.irq			= -EINVAL,
+};
+
+static inline void adc128s_init(void)
+{
+	spi_register_board_info(&adc128s_spi_board_info, 1);
+}
+#else
+static inline void adc128s_init(void)
+{
+}
+#endif
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(GPMC_NCS4, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLDOWN),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+/*
+ * Default mux settings except for uart3_cts_rctx pin which we want to
+ * use as touchscreen IRQ GPIO.
+ */
+static struct omap_device_pad uart1_pads[] __initdata = {
+	{
+		.name	= "uart1_cts.uart1_cts",
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_rts.uart1_rts",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_tx.uart1_tx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart1_rx.uart1_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad uart2_pads[] __initdata = {
+	{
+		.name	= "uart2_cts.uart2_cts",
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_rts.uart2_rts",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_tx.uart2_tx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart2_rx.uart2_rx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+	},
+};
+
+static struct omap_device_pad uart3_pads[] __initdata = {
+	{
+		.name	= "uart3_rts_sd.uart3_rts_sd",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_tx_irtx.uart3_tx_irtx",
+		.enable	= OMAP_PIN_OUTPUT | OMAP_MUX_MODE0,
+	},
+	{
+		.name	= "uart3_rx_irrx.uart3_rx_irrx",
+		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+		.enable	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+		.idle	= OMAP_PIN_INPUT | OMAP_MUX_MODE0,
+	},
+};
+
+static inline void mt_ventoux_serial_init(void)
+{
+	struct omap_board_data bdata;
+
+	bdata.flags = 0;
+
+	bdata.id = 0;
+	bdata.pads = uart1_pads;
+	bdata.pads_cnt = ARRAY_SIZE(uart1_pads);
+	omap_serial_init_port(&bdata, NULL);
+
+	bdata.id = 1;
+	bdata.pads = uart2_pads;
+	bdata.pads_cnt = ARRAY_SIZE(uart2_pads);
+	omap_serial_init_port(&bdata, NULL);
+
+	bdata.id = 2;
+	bdata.pads = uart3_pads;
+	bdata.pads_cnt = ARRAY_SIZE(uart3_pads);
+	omap_serial_init_port(&bdata, NULL);
+
+	bdata.id = 3;
+	bdata.pads = NULL;
+	bdata.pads_cnt = 0;
+	omap_serial_init_port(&bdata, NULL);
+}
+#else
+static inline void mt_ventoux_serial_init(void)
+{
+	omap_serial_init();
+}
+#endif
+
+static struct resource am3517_hecc_resources[] = {
+	{
+		.start	= AM35XX_IPSS_HECC_BASE,
+		.end	= AM35XX_IPSS_HECC_BASE + 0x3FFF,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_35XX_HECC0_IRQ,
+		.end	= INT_35XX_HECC0_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct ti_hecc_platform_data am3517_hecc_pdata = {
+	.scc_hecc_offset	= AM35XX_HECC_SCC_HECC_OFFSET,
+	.scc_ram_offset		= AM35XX_HECC_SCC_RAM_OFFSET,
+	.hecc_ram_offset	= AM35XX_HECC_RAM_OFFSET,
+	.mbx_offset		= AM35XX_HECC_MBOX_OFFSET,
+	.int_line		= AM35XX_HECC_INT_LINE,
+	.version		= AM35XX_HECC_VERSION,
+};
+
+static struct platform_device am3517_hecc_device = {
+	.name		= "ti_hecc",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(am3517_hecc_resources),
+	.resource	= am3517_hecc_resources,
+	.dev		= {
+		.platform_data = &am3517_hecc_pdata,
+	},
+};
+
+static struct platform_device *mt_ventoux_devices[] __initdata = {
+	&mt_ventoux_display_device,
+	&mt_ventoux_ts_device,
+	&mt_ventoux_fpga_device,
+	&am3517_hecc_device,
+};
+
+#define TS_IRQ_PIN	163
+
+static void __init mt_ventoux_init(void)
+{
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	mt_ventoux_i2c_init();
+	platform_add_devices(mt_ventoux_devices, ARRAY_SIZE(mt_ventoux_devices));
+	mt_ventoux_serial_init();
+	omap_sdrc_init(NULL, NULL);
+
+	mt_ventoux_display_init();
+
+	/* Configure EHCI ports */
+	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
+	usbhs_init(&usbhs_bdata);
+
+	/* NAND */
+	omap_nand_flash_init(NAND_BUSWIDTH_16, mt_ventoux_nand_partitions,
+			     ARRAY_SIZE(mt_ventoux_nand_partitions));
+
+	/* touchscreen */
+	omap_mux_init_gpio(TS_IRQ_PIN, OMAP_PIN_INPUT);
+	omap_ads7846_init(1, TS_IRQ_PIN, 310, &tsc2046_config);
+
+	/* Ethernet */
+	am35xx_ethernet_init(MCX_MDIO_FREQUENCY, 1);
+
+	/* MMC init */
+	omap_mux_init_gpio(SD_CARD_CD, OMAP_PIN_INPUT);
+	omap2_hsmmc_init(mmc);
+
+	/* ADC128S022 init */
+	adc128s_init();
+}
+
+static const char *mt_ventoux_dt_match[] __initdata = {
+	"teejet,mt_ventoux",
+	NULL
+};
+
+MACHINE_START(AM3517_MT_VENTOUX, "TeeJet MT_VENTOUX")
+	/* Maintainer: Ilya Yanok */
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= am35xx_init_early,
+	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= mt_ventoux_init,
+	.timer		= &omap3_timer,
+	.dt_compat	= mt_ventoux_dt_match,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 1141364..021cb0d 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -145,6 +145,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP2(3, nokia_n810_wimax);
 
 		/* omap3 based boards using UART1 */
+		DEBUG_LL_OMAP3(1, am3517_mt_ventoux);
 		DEBUG_LL_OMAP2(1, omap3evm);
 		DEBUG_LL_OMAP3(1, omap_3430sdp);
 		DEBUG_LL_OMAP3(1, omap_3630sdp);
-- 
1.7.6.4

