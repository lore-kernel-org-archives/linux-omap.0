From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2 2/2] mcx: support for HTKW mcx board
Date: Thu, 15 Dec 2011 01:53:03 +0100
Message-ID: <1323910383-1184-3-git-send-email-yanok@emcraft.com>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:36777 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758433Ab1LOAxJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Dec 2011 19:53:09 -0500
In-Reply-To: <1323910383-1184-1-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: yanok@emcraft.com, sasha_d@emcraft.com

Support for the HTKW mcx board (TI AM3517 based) including serial,
Ethernet, I2C, USB host, HSMMC, DSS and RTC.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>

---
Requires updated mach-types file and previously posted AM35xx-EMAC
patch: http://article.gmane.org/gmane.linux.ports.arm.omap/66861

Changes from V1:
 - Kconfig option name fixed
 - Makefile entry sanitized
 - Unneeded headers removed
 - EMAC initialization moved to separate file/patch
 - Use gpio_{request,free}_{array,one} where possible
 - don't use platform data for touchscreen, we only need to pass
   irq number, do it via client.irq
 - check mcx_ts_init return value
 - Moved DEBUG_LL_OMAP3 entry to be in aplhabetical order
 - check return value of gpio_request for USB pwr pin
 - use pr_err instead of printk for error printing
 - added a fixed regulator for vdds_dsi
 - added SDcard card-detect pin

 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-mcx.c              |  495 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 503 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-mcx.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 09ea525..535f1a1 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -230,6 +230,12 @@ config MACH_OMAP_3430SDP
 	default y
 	select OMAP_PACKAGE_CBB
 
+config MACH_MCX
+	bool "HTKW mcx (AM3517 based) board"
+	depends on ARCH_OMAP3
+	select OMAP_PACKAGE_CBB
+	select REGULATOR_FIXED_VOLTAGE
+
 config MACH_NOKIA_N800
        bool
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index e88fcfa..4204c97 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -232,6 +232,7 @@ obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
 obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
+obj-$(CONFIG_MACH_MCX)			+= board-mcx.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-mcx.c b/arch/arm/mach-omap2/board-mcx.c
new file mode 100644
index 0000000..6375fa1
--- /dev/null
+++ b/arch/arm/mach-omap2/board-mcx.c
@@ -0,0 +1,495 @@
+/*
+ * Copyright (C) 2011 Ilya Yanok, Emcraft Systems
+ *
+ * Modified from mach-omap2/board-omap3beagle.c
+ *
+ * Initial code: Syed Mohammed Khasim
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/gpio.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mmc/host.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+#include <plat/common.h>
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+#include <plat/usb.h>
+
+#include "am35xx-emac.h"
+#include "mux.h"
+#include "control.h"
+#include "hsmmc.h"
+#include "common-board-devices.h"
+
+#define MCX_MDIO_FREQUENCY	(1000000)
+
+static struct mtd_partition mcx_nand_partitions[] = {
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
+#define LCD_PWR_ENn		131
+#define HDMI_TRCVR_PDn		133
+#define LCD_BKLIGHT_EN		55
+#define LCD_LVL_SFHT_BUF_ENn	43
+
+static int lcd_enabled;
+static int dvi_enabled;
+
+static int mcx_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		pr_err("cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(LCD_BKLIGHT_EN, 1);
+	lcd_enabled = 1;
+
+	return 0;
+}
+
+static void mcx_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(LCD_BKLIGHT_EN, 0);
+	lcd_enabled = 0;
+}
+
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "focaltech_etm070003dh6",
+	.platform_enable	= mcx_panel_enable_lcd,
+	.platform_disable	= mcx_panel_disable_lcd,
+};
+
+static struct omap_dss_device mcx_lcd_device = {
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
+static int mcx_panel_enable_tv(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void mcx_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+}
+
+static struct omap_dss_device mcx_tv_device = {
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.name			= "tv",
+	.driver_name		= "venc",
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+	.platform_enable	= mcx_panel_enable_tv,
+	.platform_disable	= mcx_panel_disable_tv,
+};
+
+/*
+ * DVI/HDMI Output
+ */
+
+static int mcx_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		pr_err("cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+	gpio_set_value(HDMI_TRCVR_PDn, 1);
+	return 0;
+}
+
+static void mcx_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	dvi_enabled = 0;
+	gpio_set_value(HDMI_TRCVR_PDn, 0);
+}
+
+static struct panel_generic_dpi_data dvi_panel = {
+	.platform_enable	= mcx_panel_enable_dvi,
+	.platform_disable	= mcx_panel_disable_dvi,
+};
+static struct omap_dss_device mcx_dvi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dvi",
+	.driver_name		= "dvi",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device *mcx_dss_devices[] = {
+	&mcx_lcd_device,
+	&mcx_tv_device,
+	&mcx_dvi_device,
+};
+
+static struct omap_dss_board_info mcx_dss_data = {
+	.num_devices	= ARRAY_SIZE(mcx_dss_devices),
+	.devices	= mcx_dss_devices,
+	.default_device	= &mcx_lcd_device,
+};
+
+/*
+ * use fake regulator for vdds_dsi as we can't find this pin inside
+ * AM3517 datasheet.
+ */
+static struct regulator_consumer_supply mcx_vdds_dsi_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
+};
+
+static struct regulator_init_data mcx_vdds_dsi = {
+	.constraints		= {
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL,
+		.always_on		= 1,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(mcx_vdds_dsi_supply),
+	.consumer_supplies	= mcx_vdds_dsi_supply,
+};
+
+static struct fixed_voltage_config mcx_display = {
+	.supply_name		= "display",
+	.microvolts		= 1800000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &mcx_vdds_dsi,
+};
+
+static struct platform_device mcx_display_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 0,
+	.dev = {
+		.platform_data	= &mcx_display,
+	},
+};
+
+static struct gpio mcx_dss_gpios[] __initdata = {
+	{ LCD_BKLIGHT_EN, GPIOF_OUT_INIT_LOW, "lcd backlight enable"	},
+	{ LCD_LVL_SFHT_BUF_ENn, GPIOF_OUT_INIT_LOW, "lcd lvl shifter"	},
+	{ LCD_PWR_ENn, GPIOF_OUT_INIT_LOW, "lcd power enable"		},
+	{ HDMI_TRCVR_PDn, GPIOF_OUT_INIT_LOW, "HDMI trcvr power"	},
+};
+
+static void __init mcx_display_init(void)
+{
+	int r;
+
+	r = gpio_request_array(mcx_dss_gpios, ARRAY_SIZE(mcx_dss_gpios));
+	if (r) {
+		pr_err("failed to get DSS control GPIOs\n");
+		return;
+	}
+
+	omap_mux_init_gpio(LCD_BKLIGHT_EN, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(LCD_LVL_SFHT_BUF_ENn, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(LCD_PWR_ENn, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(HDMI_TRCVR_PDn, OMAP_PIN_OUTPUT);
+
+	r = omap_display_init(&mcx_dss_data);
+	if (r) {
+		pr_err("Failed to register DSS device\n");
+		gpio_free_array(mcx_dss_gpios, ARRAY_SIZE(mcx_dss_gpios));
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
+static struct regulator_init_data mcx_regulator_data[] = {
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
+static struct i2c_board_info __initdata mcx_i2c1_devices[] = {
+	{
+		I2C_BOARD_INFO("ds1337", 0x68),
+	},
+	{
+		I2C_BOARD_INFO("tps65023", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.platform_data = &mcx_regulator_data[0],
+	},
+};
+
+#define TOUCH_INT_GPIO	170
+
+static int __init mcx_ts_init(void)
+{
+	struct i2c_board_info mcx_edt_ts[] = {
+		{
+			I2C_BOARD_INFO("edt_ts", 0x38),
+			.irq = gpio_to_irq(TOUCH_INT_GPIO),
+		},
+	};
+	int err;
+
+	err = gpio_request_one(TOUCH_INT_GPIO, GPIOF_IN, "TOUCH_INT");
+	if (err < 0) {
+		pr_err("failed to get TOUCH_INT gpio\n");
+		return -ENODEV;
+	}
+	omap_mux_init_gpio(TOUCH_INT_GPIO, OMAP_PIN_INPUT);
+
+	return i2c_register_board_info(3, mcx_edt_ts, 1);
+}
+
+static void __init mcx_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 400, mcx_i2c1_devices,
+			ARRAY_SIZE(mcx_i2c1_devices));
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	if (mcx_ts_init() < 0)
+		pr_err("failed to register touchscreen device\n");
+}
+
+#define USB_HOST_PWR_EN		132
+#define USB_PHY1_RESET		154
+#define USB_PHY2_RESET		152
+
+static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
+
+	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = USB_PHY1_RESET,
+	.reset_gpio_port[1]  = USB_PHY2_RESET,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+#define SD_CARD_CD		61
+#define SD_CARD_WP		65
+
+static struct omap2_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_cd        = SD_CARD_CD,
+		.gpio_wp        = SD_CARD_WP,
+		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
+					MMC_VDD_165_195,
+	},
+	{}      /* Terminator */
+};
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
+	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
+			OMAP_PULL_ENA | OMAP_PULL_UP),
+	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
+	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
+			OMAP_PULL_ENA | OMAP_PULL_UP),
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
+static struct platform_device *mcx_devices[] __initdata = {
+	&mcx_display_device,
+};
+
+static void __init mcx_init(void)
+{
+	int err;
+
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	mcx_i2c_init();
+	platform_add_devices(mcx_devices, ARRAY_SIZE(mcx_devices));
+	omap_serial_init();
+
+	mcx_display_init();
+
+	/* Configure EHCI ports */
+	err = gpio_request_one(USB_HOST_PWR_EN, GPIOF_OUT_INIT_HIGH,
+			"USB_HOST_PWR_EN");
+	if (err)
+		pr_warn("Failed to request USB host power enable GPIO\n");
+	omap_mux_init_gpio(USB_HOST_PWR_EN, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
+	omap_mux_init_gpio(USB_PHY2_RESET, OMAP_PIN_OUTPUT);
+	usbhs_init(&usbhs_bdata);
+	omap_nand_flash_init(NAND_BUSWIDTH_16, mcx_nand_partitions,
+			     ARRAY_SIZE(mcx_nand_partitions));
+	/* Ethernet */
+	am35xx_ethernet_init(MCX_MDIO_FREQUENCY, 1);
+
+	/* MMC init */
+	omap_mux_init_gpio(SD_CARD_WP, OMAP_PIN_INPUT);
+	omap_mux_init_gpio(SD_CARD_CD, OMAP_PIN_INPUT);
+	omap2_hsmmc_init(mmc);
+}
+
+static const char *mcx_dt_match[] __initdata = {
+	"htkw,mcx",
+	NULL
+};
+
+MACHINE_START(MCX, "htkw mcx")
+	/* Maintainer: Ilya Yanok */
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= am35xx_init_early,
+	.init_irq	= omap3_init_irq,
+	.init_machine	= mcx_init,
+	.timer		= &omap3_timer,
+	.dt_compat	= mcx_dt_match,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 2d45ea3..450962d 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -160,6 +160,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP3(3, encore);
 		DEBUG_LL_OMAP3(3, igep0020);
 		DEBUG_LL_OMAP3(3, igep0030);
+		DEBUG_LL_OMAP3(3, mcx);
 		DEBUG_LL_OMAP3(3, nokia_rm680);
 		DEBUG_LL_OMAP3(3, nokia_rx51);
 		DEBUG_LL_OMAP3(3, omap3517evm);
-- 
1.7.6.4

