From: Jan Weitzel <j.weitzel@phytec.de>
Subject: [RFC 2/2] omap4: board-omap4pcm049: add Phytec phyCORE-OMAP4
Date: Tue, 19 Jul 2011 13:45:27 +0200
Message-ID: <1311075927-5562-3-git-send-email-j.weitzel@phytec.de>
References: <20110718084259.GY5783@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.phytec.co.uk ([217.6.246.34]:56309 "EHLO root.phytec.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab1GSLpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jul 2011 07:45:33 -0400
In-Reply-To: <20110718084259.GY5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Jan Weitzel <j.weitzel@phytec.de>

Adds support for the Phytec OMAP4430 board called phyCORE-OMAP4 PCM049.

Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-omap4pcm049.c      |  368 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 379 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4pcm049.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 6b88799..d5e4b60 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -333,6 +333,12 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_PCM049
+	bool "OMAP4 based phyCORE OMAP4"
+	depends on ARCH_OMAP4
+	default y
+	select OMAP_PACKAGE_CBS
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5d829d6..6cc4ccb 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -240,6 +240,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
 					   board-omap4panda-common.o \
 					   hsmmc.o \
 					   omap_phy_internal.o
+obj-$(CONFIG_MACH_MACH_PCM049)		+= board-pcm049.o \
+					   board-omap4panda-common.o \
+					   hsmmc.o \
+					   omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
 					   omap_phy_internal.o \
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
new file mode 100644
index 0000000..117334e
--- /dev/null
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -0,0 +1,368 @@
+/*
+ * Board support file for Phytec phyCORE-OMAP4 Board.
+ *
+ * Copyright (C) 2011 Phytec Messtechnik GmbH
+ *
+ * Author: Jan Weitzel <armlinux@phytec.de>
+ *
+ * Based on mach-omap2/board-omap4panda.c
+ *
+ * Author: David Anders <x0132446@ti.com>
+ *
+ * Author: Santosh Shilimkar <santosh.shilimkar@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/usb/otg.h>
+#include <linux/i2c/twl.h>
+#include <linux/i2c/at24.h>
+#include <linux/mfd/stmpe.h>
+#include <linux/leds-pca9532.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
+#include <linux/wl12xx.h>
+#include <linux/smsc911x.h>
+
+#include <mach/hardware.h>
+#include <mach/omap4-common.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <video/omapdss.h>
+
+#include <plat/board.h>
+#include <plat/common.h>
+#include <plat/usb.h>
+#include <plat/gpmc.h>
+#include <plat/gpmc-smsc911x.h>
+#include <plat/mmc.h>
+#include <video/omap-panel-generic-dpi.h>
+
+#include "hsmmc.h"
+#include "control.h"
+#include "mux.h"
+#include "common-board-devices.h"
+#include "board-omap4panda-common.h"
+
+#define OMAP4_PCM049_ETH_GPIO_IRQ	121
+#define OMAP4_PCM049_ETH_CS		5
+#define OMAP4_PCM049_STMPE811_GPIO_IRQ	117
+#define OMAP4_PCM049_LCD_ENABLE		118
+
+/* phyCORE OMAP4 */
+#if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
+static struct omap_smsc911x_platform_data __initdata board_smsc911x_data = {
+	.cs             = OMAP4_PCM049_ETH_CS,
+	.gpio_irq       = OMAP4_PCM049_ETH_GPIO_IRQ,
+	.gpio_reset     = -EINVAL,
+	.flags          = SMSC911X_USE_16BIT,
+};
+
+static inline void __init pcm049_init_smsc911x(void)
+{
+	omap_mux_init_gpio(OMAP4_PCM049_ETH_GPIO_IRQ, OMAP_PIN_INPUT);
+	gpmc_smsc911x_init(&board_smsc911x_data);
+}
+#else
+static inline void __init pcm049_init_smsc911x(void) { return; }
+#endif
+
+/* Fixed regulator for max1027 */
+static struct regulator_consumer_supply pcm049_vcc_3v3_consumer_supply[] = {
+	REGULATOR_SUPPLY("vcc", "4-0064"),
+};
+
+struct regulator_init_data pcm049_vcc_3v3_initdata = {
+	.consumer_supplies = pcm049_vcc_3v3_consumer_supply,
+	.num_consumer_supplies = ARRAY_SIZE(pcm049_vcc_3v3_consumer_supply),
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config pcm049_vcc_3v3_config = {
+	.supply_name		= "pcm049_vcc_3v3",
+	.microvolts		= 3300000,
+	.gpio			= -EINVAL,
+	.enabled_at_boot	= 1,
+	.init_data		= &pcm049_vcc_3v3_initdata,
+};
+
+static struct platform_device pcm049_vcc_3v3_device = {
+	.name	= "reg-fixed-voltage",
+	.id	= 0,
+	.dev	= {
+		.platform_data = &pcm049_vcc_3v3_config,
+	},
+};
+
+/* Display */
+static int pcm049_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	return gpio_set_value(OMAP4_PCM049_LCD_ENABLE, 1);
+}
+
+static void pcm049_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OMAP4_PCM049_LCD_ENABLE, 0);
+}
+
+/* Using generic display panel */
+static struct panel_generic_dpi_data omap4_dpi_panel = {
+	.name			= "pd050vl1",
+	.platform_enable	= pcm049_panel_enable_lcd,
+	.platform_disable	= pcm049_panel_disable_lcd,
+};
+
+struct omap_dss_device pcm049_dpi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dpi",
+	.driver_name		= "generic_dpi_panel",
+	.data			= &omap4_dpi_panel,
+	.phy.dpi.data_lines	= 24,
+	.channel		= OMAP_DSS_CHANNEL_LCD2,
+};
+
+static struct omap_dss_device  pcm049_dvi_device = {
+	.name = "dvi",
+	.driver_name = "hdmi_panel",
+	.type = OMAP_DISPLAY_TYPE_HDMI,
+	.clocks	= {
+		.dispc	= {
+			.dispc_fclk_src	= OMAP_DSS_CLK_SRC_FCK,
+		},
+		.hdmi	= {
+			.regn	= 15,
+			.regm2	= 1,
+		},
+	},
+	.channel = OMAP_DSS_CHANNEL_DIGIT,
+};
+
+static struct omap_dss_device *pcm049_dss_devices[] = {
+	&pcm049_dpi_device,
+	&pcm049_dvi_device,
+};
+
+static struct omap_dss_board_info pcm049_dss_data = {
+	.num_devices	= ARRAY_SIZE(pcm049_dss_devices),
+	.devices	= pcm049_dss_devices,
+	.default_device = &pcm049_dpi_device,
+};
+
+void pcm049_display_init(void)
+{
+	omap_mux_init_gpio(OMAP4_PCM049_LCD_ENABLE, OMAP_PIN_OUTPUT);
+
+	if ((gpio_request(OMAP4_PCM049_LCD_ENABLE, "DISP_ENA") == 0) &&
+		(gpio_direction_output(OMAP4_PCM049_LCD_ENABLE, 1) == 0)) {
+		gpio_export(OMAP4_PCM049_LCD_ENABLE, 0);
+		gpio_set_value(OMAP4_PCM049_LCD_ENABLE, 0);
+	} else
+		printk(KERN_ERR "could not obtain gpio for DISP_ENA");
+	omap4_common_hdmi_mux_init();
+	omap_display_init(&pcm049_dss_data);
+}
+
+static struct platform_device *pcm049_devices[] __initdata = {
+	&pcm049_vcc_3v3_device,
+};
+static struct at24_platform_data board_eeprom = {
+	.byte_len = 4096,
+	.page_size = 32,
+	.flags = AT24_FLAG_ADDR16,
+};
+
+static struct stmpe_gpio_platform_data pba_gpio_stm_data = {
+	.gpio_base = -1,
+	.norequest_mask = STMPE_GPIO_NOREQ_811_TOUCH,
+};
+
+static struct stmpe_ts_platform_data pba_ts_stm_pdata = {
+	.sample_time = 4,
+	.mod_12b = 1,
+	.ref_sel = 0,
+	.adc_freq = 1,
+	.ave_ctrl = 3,
+	.touch_det_delay = 3,
+	.settling = 3,
+	.fraction_z = 7,
+	.i_drive = 0,
+};
+
+static struct stmpe_platform_data pba_stm_pdata = {
+	.blocks = STMPE_BLOCK_GPIO | STMPE_BLOCK_TOUCHSCREEN,
+	.irq_base = TWL6030_IRQ_END,
+	.irq_trigger = IRQF_TRIGGER_RISING,
+	.irq_invert_polarity = true,
+	.gpio = &pba_gpio_stm_data,
+	.ts = &pba_ts_stm_pdata,
+};
+
+static struct pca9532_platform_data pba_pca9532 = {
+	.leds = {
+		{
+			.name = "board:red:free_use1",
+			.state = PCA9532_OFF,
+			.type = PCA9532_TYPE_LED,
+		}, {
+			.name = "board:yellow:free_use2",
+			.state = PCA9532_OFF,
+			.type = PCA9532_TYPE_LED,
+		}, {
+			.name = "board:yellow:free_use3",
+			.state = PCA9532_OFF,
+			.type = PCA9532_TYPE_LED,
+		}, {
+			.name = "board:green:free_use4",
+			.state = PCA9532_OFF,
+			.type = PCA9532_TYPE_LED,
+		},
+	},
+	.psc = { 1, 1 },
+	.pwm = { 1, 1 },
+};
+
+static struct i2c_board_info __initdata pcm049_i2c_1_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("at24", 0x57), /* E0=1, E1=1, E2=1 */
+		.platform_data = &board_eeprom,
+	},
+};
+
+static struct i2c_board_info __initdata pcm049_i2c_3_boardinfo[] = {
+};
+
+static struct i2c_board_info __initdata pcm049_i2c_4_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("stmpe811", 0x41),	/* Touch controller */
+		.irq = OMAP_GPIO_IRQ(OMAP4_PCM049_STMPE811_GPIO_IRQ),
+		.platform_data = &pba_stm_pdata,
+	}, {
+		I2C_BOARD_INFO("max1037", 0x64),	/* A/D converter */
+	}, {
+		I2C_BOARD_INFO("pca9533", 0x62),	/* Leds pca9533 */
+		.platform_data = &pba_pca9532,
+	}
+};
+
+
+static struct omap2_hsmmc_info pcm049_mmc[] = {
+	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_wp	= -EINVAL,
+		.gpio_cd	= -EINVAL,
+	}, {
+		.mmc		= 5,
+		.caps		= MMC_CAP_4_BIT_DATA,
+		.gpio_wp	= -EINVAL,
+		.gpio_cd	= 30,	/* wk30 */
+		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34, /* 3V3 */
+	}, {}	/* Terminator */
+};
+
+static struct gpio_led pcm049_gpio_leds[] = {
+	{
+		.name			= "modul:red:status1",
+		.default_trigger	= "heartbeat",
+		.gpio			= 152,
+	},
+	{
+		.name			= "modul:green:status2",
+		.default_trigger	= "mmc0",
+		.gpio			= 153,
+	},
+};
+
+#define	TWL_PHOENIX_DEV_ON	0x25
+
+static void pcm049_power_off(void)
+{
+	printk(KERN_INFO "Goodbye phyCORE OMAP4!\n");
+	twl_i2c_write_u8(TWL6030_MODULE_ID0, 0x7, TWL_PHOENIX_DEV_ON);
+}
+
+static struct omap_board_mux pcm049_mux[] = {
+#ifdef CONFIG_OMAP_MUX
+	OMAP4_MUX(SDMMC5_DAT0, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT1, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT2, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_DAT3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_CMD, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+	OMAP4_MUX(SDMMC5_CLK, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP),
+#endif
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+
+static struct panda_board_data pcm049_config = {
+	.hup_power_gpio = -EINVAL,
+	.hup_nreset_gpio = -EINVAL,
+	.gpio_led_info.leds = pcm049_gpio_leds,
+	.gpio_led_info.num_leds	= ARRAY_SIZE(pcm049_gpio_leds),
+	.mmc = pcm049_mmc,
+	.i2c_2_board_info = NULL,
+	.i2c_2_board_size = 0,
+	.i2c_2_board_speed = 0,
+	.i2c_3_board_info = panda_i2c_eeprom,
+	.i2c_3_board_size = ARRAY_SIZE(panda_i2c_eeprom),
+	/*
+	 * Bus 3 is attached to the DVI port where devices like the pico DLP
+	 * projector don't work reliably with 400kHz
+	 */
+	.i2c_3_board_speed = 400,
+	.i2c_4_board_info = pcm049_i2c_3_boardinfo,
+	.i2c_4_board_size = ARRAY_SIZE(pcm049_i2c_3_boardinfo),
+	.i2c_4_board_speed = 400,
+	.serial1 = NULL,
+	.serial2 = &serial2_data,
+	.serial3 = &serial3_data,
+	.serial4 = NULL,
+};
+
+
+static void __init pcm049_init(void)
+{
+	omap4_common_preinit();
+	omap_mux_write_array(partition, pcm049_mux);
+
+	if (omap_mux_init_gpio(OMAP4_PCM049_STMPE811_GPIO_IRQ, OMAP_PIN_INPUT))
+		printk(KERN_ERR "Failed to mux GPIO%d for STMPE811 IRQ\n",
+			OMAP4_PCM049_STMPE811_GPIO_IRQ);
+	else if (gpio_request(OMAP4_PCM049_STMPE811_GPIO_IRQ, "STMPE811 irq"))
+		printk(KERN_ERR "Failed to request GPIO%d for STMPE811 IRQ\n",
+			OMAP4_PCM049_STMPE811_GPIO_IRQ);
+	else
+		gpio_direction_input(OMAP4_PCM049_STMPE811_GPIO_IRQ);
+
+	omap4_common_init(&pcm049_config);
+
+	i2c_register_board_info(1, pcm049_i2c_1_boardinfo,
+			ARRAY_SIZE(pcm049_i2c_1_boardinfo));
+
+	pm_power_off = pcm049_power_off;
+	pcm049_init_smsc911x();
+	platform_add_devices(pcm049_devices, ARRAY_SIZE(pcm049_devices));
+	pcm049_display_init();
+}
+
+MACHINE_START(PCM049, "phyCORE OMAP4")
+	/* Maintainer: Jan Weitzel - Phytec Messtechnik GmbH */
+	.boot_params	= 0x80000100,
+	.reserve	= omap_reserve,
+	.map_io		= omap4_panda_map_io,
+	.init_early	= omap4_panda_init_early,
+	.init_irq	= gic_init_irq,
+	.init_machine	= pcm049_init,
+	.timer		= &omap4_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 2b71b17..cb4a6c2 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -166,6 +166,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		/* omap4 based boards using UART3 */
 		DEBUG_LL_OMAP4(3, omap_4430sdp);
 		DEBUG_LL_OMAP4(3, omap4_panda);
+		DEBUG_LL_OMAP4(3, pcm049);
 
 		/* zoom2/3 external uart */
 		DEBUG_LL_ZOOM(omap_zoom2);
-- 
1.7.0.4

