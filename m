From: Daniel Toussaint <daniel@dmhome.net>
Subject: [PATCH 1/3] Initial support for Technexion Thunderboard : boardsupport
Date: Sun, 13 Dec 2009 14:33:16 +0100
Message-ID: <4B24ED1C.4020206@dmhome.net>
Reply-To: daniel@dmhome.net
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040609060509030809020900"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64276 "HELO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751215AbZLMNdU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Dec 2009 08:33:20 -0500
Received: by ewy19 with SMTP id 19so2526682ewy.21
        for <linux-omap@vger.kernel.org>; Sun, 13 Dec 2009 05:33:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040609060509030809020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dear All,

Patches reformatted for mainline.

Daniel Toussaint


--------------040609060509030809020900
Content-Type: text/x-patch;
 name="omap3thunder_mainline_boardsupport.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap3thunder_mainline_boardsupport.diff"

Signed-off-by: Daniel Toussaint <daniel.toussaint@technexion.com>
diff -Nur linux-2.6.32-pristine/arch/arm/mach-omap2/board-omap3thunder.c linux-2.6.32-patched/arch/arm/mach-omap2/board-omap3thunder.c
--- linux-2.6.32-pristine/arch/arm/mach-omap2/board-omap3thunder.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.32-patched/arch/arm/mach-omap2/board-omap3thunder.c	2009-12-11 13:09:42.000000000 +0100
@@ -0,0 +1,455 @@
+/*
+ * Copyright (C) 2009 Technexion
+ * Modified from mach-omap2/board-omap3beagleboard.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/gpio_keys.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+
+#include <linux/regulator/machine.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <mach/board.h>
+#include <mach/usb.h>
+#include <linux/usb/otg.h>
+#include <mach/common.h>
+#include <mach/gpmc.h>
+#include <mach/nand.h>
+
+#include "mmc-twl4030.h"
+
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+#include <mach/mcspi.h>
+#include <mach/mmc.h>
+
+#define OMAP3_THUNDER_TS_GPIO	136
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+#define NAND_BLOCK_SIZE	SZ_128K
+
+#define THUNDER_DVI_PANEL_EN_GPIO 199
+#define THUNDER_LCD_PANEL_ENVDD 138
+#define THUNDER_LCD_PON 139
+
+static struct mtd_partition omap3thunder_nand_partitions[] = {
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
+static struct omap_nand_platform_data omap3thunder_nand_data = {
+	.options	= NAND_BUSWIDTH_16,
+	.parts		= omap3thunder_nand_partitions,
+	.nr_parts	= ARRAY_SIZE(omap3thunder_nand_partitions),
+	.dma_channel	= -1,		/* disable DMA in OMAP NAND driver */
+	.nand_setup	= NULL,
+	.dev_ready	= NULL,
+};
+
+static struct resource omap3thunder_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device omap3thunder_nand_device = {
+	.name		= "omap2-nand",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &omap3thunder_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &omap3thunder_nand_resource,
+};
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+static struct omap_uart_config omap3_thunder_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static struct twl4030_usb_data thunder_usb_data = {
+	.usb_mode	= T2_USB_MODE_ULPI,
+};
+
+static struct twl4030_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 8,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= 29,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{}	/* Terminator */
+};
+
+static struct regulator_consumer_supply thunder_vmmc1_supply = {
+	.supply		= "vmmc",
+};
+
+static struct regulator_consumer_supply thunder_vmmc2_supply = {
+	.supply		= "vmmc",
+};
+
+static struct regulator_consumer_supply thunder_vsim_supply = {
+	.supply			= "vmmc_aux",
+};
+
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "thunderboard::usr0",
+		.default_trigger        = "heartbeat",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	},
+};
+
+static int thunder_twl_gpio_setup(struct device *dev,
+		unsigned gpio, unsigned ngpio)
+{
+	mmc[0].gpio_cd = gpio + 0;
+	twl4030_mmc_init(mmc);
+
+	/* link regulators to MMC adapters */
+	thunder_vmmc1_supply.dev = mmc[0].dev;
+	thunder_vmmc2_supply.dev = mmc[1].dev;
+	thunder_vsim_supply.dev = mmc[0].dev;
+
+	/* the LED marked LED 2 (LEDA) */
+	gpio_leds[0].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	/* gpio + 7 == DVI Enable */
+	gpio_request(gpio + 7, "EN_DVI");
+	gpio_direction_output(gpio + 7,	0);
+	return 0;
+}
+
+static struct twl4030_gpio_platform_data thunder_gpio_data = {
+	.gpio_base	= OMAP_MAX_GPIO_LINES,
+	.irq_base	= TWL4030_GPIO_IRQ_BASE,
+	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= false,
+	.pullups	= BIT(1),
+	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+				| BIT(15) | BIT(16) | BIT(17),
+	.setup		= thunder_twl_gpio_setup,
+};
+
+
+/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card == max 220 mA) */
+static struct regulator_init_data thunder_vmmc1 = {
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
+	.consumer_supplies	= &thunder_vmmc1_supply,
+};
+
+
+static struct regulator_init_data thunder_vmmc2 = {
+	.constraints = {
+		.min_uV			= 1850000,
+		.max_uV			= 3150000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &thunder_vmmc2_supply,
+};
+
+/* VSIM for MMC1 pins DAT4..DAT7 (2 mA, plus card == max 50 mA) */
+static struct regulator_init_data thunder_vsim = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 3000000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_VOLTAGE
+					| REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &thunder_vsim_supply,
+};
+
+static struct twl4030_platform_data thunder_twldata = {
+	.irq_base	= TWL4030_IRQ_BASE,
+	.irq_end	= TWL4030_IRQ_END,
+
+	/* platform_data for children goes here */
+	.usb		= &thunder_usb_data,
+	.gpio		= &thunder_gpio_data,
+	.vmmc1		= &thunder_vmmc1,
+	.vmmc2          = &thunder_vmmc2,
+	.vsim		= &thunder_vsim,
+};
+
+static struct i2c_board_info __initdata thunder_i2c_boardinfo[] = {
+	{
+		I2C_BOARD_INFO("twl4030", 0x48),
+		.flags = I2C_CLIENT_WAKE,
+		.irq = INT_34XX_SYS_NIRQ,
+		.platform_data = &thunder_twldata,
+	},
+};
+
+static int __init omap3_thunder_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, thunder_i2c_boardinfo,
+				ARRAY_SIZE(thunder_i2c_boardinfo));
+	omap_register_i2c_bus(2, 100, NULL, 0);
+	omap_register_i2c_bus(3, 100, NULL, 0);
+	return 0;
+}
+
+static void __init omap3_thunder_init_irq(void)
+{
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
+static struct gpio_keys_button gpio_buttons[] = {
+	{
+		.code			= BTN_EXTRA,
+		.gpio			= 7,
+		.desc			= "user",
+		.wakeup			= 1,
+	},
+};
+
+static struct gpio_keys_platform_data gpio_key_info = {
+	.buttons	= gpio_buttons,
+	.nbuttons	= ARRAY_SIZE(gpio_buttons),
+};
+
+static struct platform_device keys_gpio = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_key_info,
+	},
+};
+
+static void ads7846_dev_init(void)
+{
+	if (gpio_request(OMAP3_THUNDER_TS_GPIO, "ADS7846 pendown") < 0)
+		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
+
+	gpio_direction_input(OMAP3_THUNDER_TS_GPIO);
+
+	omap_set_gpio_debounce(OMAP3_THUNDER_TS_GPIO, 1);
+	omap_set_gpio_debounce_time(OMAP3_THUNDER_TS_GPIO, 0xa);
+}
+
+static int ads7846_get_pendown_state(void)
+{
+	return !gpio_get_value(OMAP3_THUNDER_TS_GPIO);
+}
+
+struct ads7846_platform_data ads7846_config = {
+	.x_max                  = 0x0fff,
+	.y_max                  = 0x0fff,
+	.x_plate_ohms           = 180,
+	.pressure_max           = 255,
+	.debounce_max           = 10,
+	.debounce_tol           = 3,
+	.debounce_rep           = 1,
+	.get_pendown_state	= ads7846_get_pendown_state,
+	.keep_vref_on		= 1,
+	.settle_delay_usecs     = 150,
+};
+
+
+static struct omap2_mcspi_device_config ads7846_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,  /* 0: slave, 1: master */
+};
+
+
+struct spi_board_info omap3thunder_spi_board_touch[] = {
+	 {
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OMAP3_THUNDER_TS_GPIO),
+		.platform_data		= &ads7846_config,
+	},
+};
+
+
+/* G-sensor on SPI bus 4 */
+static struct spi_board_info omap3thunder_spi_board_info[] = {
+	{
+		.modalias = "spidev",
+		.max_speed_hz   = 1500000,
+		.bus_num        = 4,
+		.chip_select    = 0,
+		.mode = SPI_MODE_0,
+	},
+};
+
+static struct omap_board_config_kernel omap3_thunder_config[] __initdata = {
+};
+
+static struct platform_device *omap3_thunder_devices[] __initdata = {
+	&leds_gpio,
+	&keys_gpio,
+};
+
+static void __init omap3thunder_flash_init(void)
+{
+	u8 cs = 0;
+	u8 nandcs = GPMC_CS_NUM + 1;
+
+	u32 gpmc_base_add = OMAP34XX_GPMC_VIRT;
+
+	/* find out the chip-select on which NAND exists */
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG1);
+
+		if ((ret & 0xC00) == 0x800) {
+			printk(KERN_INFO "Found NAND on CS%d\n", cs);
+			if (nandcs > GPMC_CS_NUM)
+				nandcs = cs;
+		}
+		cs++;
+	}
+
+	if (nandcs > GPMC_CS_NUM) {
+		printk(KERN_INFO "NAND: Unable to find configuration "
+				 "in GPMC\n ");
+		return;
+	}
+
+	if (nandcs < GPMC_CS_NUM) {
+		omap3thunder_nand_data.cs = nandcs;
+		omap3thunder_nand_data.gpmc_cs_baseaddr = (void *)
+			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+		omap3thunder_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+		if (platform_device_register(&omap3thunder_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
+	}
+}
+
+static void __init omap3_thunder_init(void)
+{
+	omap3_thunder_i2c_init();
+
+	/* Turn on Wireless LAN */
+	gpio_request(157, "WIFI ENABLE");
+	gpio_direction_output(157, 0);
+
+	platform_add_devices(omap3_thunder_devices,
+			ARRAY_SIZE(omap3_thunder_devices));
+	omap_board_config = omap3_thunder_config;
+	omap_board_config_size = ARRAY_SIZE(omap3_thunder_config);
+	omap_serial_init();
+
+	usb_musb_init();
+	omap3thunder_flash_init();
+
+	ads7846_dev_init();
+	spi_register_board_info(omap3thunder_spi_board_touch,
+			ARRAY_SIZE(omap3thunder_spi_board_touch));
+	spi_register_board_info(omap3thunder_spi_board_info,
+			ARRAY_SIZE(omap3thunder_spi_board_info));
+
+}
+
+static void __init omap3_thunder_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OMAP3_THUNDER, "OMAP3 Thunder Board")
+	/* Maintainer: Daniel Toussaint daniel.toussaint@technexion.com */
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= omap3_thunder_map_io,
+	.init_irq	= omap3_thunder_init_irq,
+	.init_machine	= omap3_thunder_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff -Nur linux-2.6.32-pristine/arch/arm/mach-omap2/Kconfig linux-2.6.32-patched/arch/arm/mach-omap2/Kconfig
--- linux-2.6.32-pristine/arch/arm/mach-omap2/Kconfig	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32-patched/arch/arm/mach-omap2/Kconfig	2009-12-11 12:47:22.000000000 +0100
@@ -100,3 +100,7 @@
 config MACH_OMAP_4430SDP
 	bool "OMAP 4430 SDP board"
 	depends on ARCH_OMAP4
+
+config MACH_OMAP3_THUNDER
+       bool "Thunder OMAP3530 board"
+       depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff -Nur linux-2.6.32-pristine/arch/arm/mach-omap2/Makefile linux-2.6.32-patched/arch/arm/mach-omap2/Makefile
--- linux-2.6.32-pristine/arch/arm/mach-omap2/Makefile	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6.32-patched/arch/arm/mach-omap2/Makefile	2009-12-11 12:46:05.000000000 +0100
@@ -77,6 +77,9 @@

 obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o

+obj-$(CONFIG_MACH_OMAP3_THUNDER)         += board-omap3thunder.o \
+	                                           mmc-twl4030.o
+
 # Platform specific device init code
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o


--------------040609060509030809020900--
