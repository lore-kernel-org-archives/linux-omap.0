From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 8/8] arm: omap: add minimal support for RM-680
Date: Thu,  9 Dec 2010 18:39:24 +0200
Message-ID: <1291912764-12823-9-git-send-email-aaro.koskinen@nokia.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:32522 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753844Ab0LIQit (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 11:38:49 -0500
In-Reply-To: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add minimal support for Nokia RM-680 board.

Tested with omap2plus_defconfig.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig                  |    6 +
 arch/arm/mach-omap2/Makefile                 |    3 +
 arch/arm/mach-omap2/board-rm680.c            |  187 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 197 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rm680.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index b67b1a9..9c317d6 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -221,6 +221,12 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
 
+config MACH_NOKIA_RM680
+	bool "Nokia RM-680 board"
+	depends on ARCH_OMAP3
+	default y
+	select OMAP_PACKAGE_CBB
+
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3a71d19..25bc945 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -140,6 +140,9 @@ obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   hsmmc.o \
 					   board-flash.o
 obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
+obj-$(CONFIG_MACH_NOKIA_RM680)		+= board-rm680.o \
+					   sdram-nokia.o \
+					   hsmmc.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   sdram-nokia.o \
 					   board-rx51-peripherals.o \
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
new file mode 100644
index 0000000..2966314
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -0,0 +1,187 @@
+/*
+ * Board support file for Nokia RM-680.
+ *
+ * Copyright (C) 2010 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/io.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/i2c/twl.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/consumer.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <plat/i2c.h>
+#include <plat/mmc.h>
+#include <plat/usb.h>
+#include <plat/gpmc.h>
+#include <plat/common.h>
+#include <plat/onenand.h>
+
+#include "mux.h"
+#include "hsmmc.h"
+#include "sdram-nokia.h"
+
+static struct regulator_consumer_supply rm680_vemmc_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1"),
+};
+
+/* Fixed regulator for internal eMMC */
+static struct regulator_init_data rm680_vemmc = {
+	.constraints =	{
+		.name			= "rm680_vemmc",
+		.min_uV			= 2900000,
+		.max_uV			= 2900000,
+		.apply_uV		= 1,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS
+					| REGULATOR_CHANGE_MODE,
+	},
+	.num_consumer_supplies		= ARRAY_SIZE(rm680_vemmc_consumers),
+	.consumer_supplies		= rm680_vemmc_consumers,
+};
+
+static struct fixed_voltage_config rm680_vemmc_config = {
+	.supply_name		= "VEMMC",
+	.microvolts		= 2900000,
+	.gpio			= 157,
+	.startup_delay		= 150,
+	.enable_high		= 1,
+	.init_data		= &rm680_vemmc,
+};
+
+static struct platform_device rm680_vemmc_device = {
+	.name			= "reg-fixed-voltage",
+	.dev			= {
+		.platform_data	= &rm680_vemmc_config,
+	},
+};
+
+static struct platform_device *rm680_peripherals_devices[] __initdata = {
+	&rm680_vemmc_device,
+};
+
+/* TWL */
+static struct twl4030_gpio_platform_data rm680_gpio_data = {
+	.gpio_base		= OMAP_MAX_GPIO_LINES,
+	.irq_base		= TWL4030_GPIO_IRQ_BASE,
+	.irq_end		= TWL4030_GPIO_IRQ_END,
+	.pullups		= BIT(0),
+	.pulldowns		= BIT(1) | BIT(2) | BIT(8) | BIT(15),
+};
+
+static struct twl4030_usb_data rm680_usb_data = {
+	.usb_mode		= T2_USB_MODE_ULPI,
+};
+
+static struct twl4030_platform_data rm680_twl_data = {
+	.irq_base		= TWL4030_IRQ_BASE,
+	.irq_end		= TWL4030_IRQ_END,
+	.gpio			= &rm680_gpio_data,
+	.usb			= &rm680_usb_data,
+	/* add rest of the children here */
+};
+
+static struct i2c_board_info __initdata rm680_twl_i2c_board_info[] = {
+	{
+		I2C_BOARD_INFO("twl5031", 0x48),
+		.flags		= I2C_CLIENT_WAKE,
+		.irq		= INT_34XX_SYS_NIRQ,
+		.platform_data	= &rm680_twl_data,
+	},
+};
+
+static void __init rm680_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2900, rm680_twl_i2c_board_info,
+				ARRAY_SIZE(rm680_twl_i2c_board_info));
+	omap_register_i2c_bus(2, 400, NULL, 0);
+	omap_register_i2c_bus(3, 400, NULL, 0);
+}
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+static struct omap_onenand_platform_data board_onenand_data[] = {
+	{
+		.gpio_irq	= 65,
+		.flags		= ONENAND_SYNC_READWRITE,
+	}
+};
+#endif
+
+/* eMMC */
+static struct omap2_hsmmc_info mmc[] __initdata = {
+	{
+		.name		= "internal",
+		.mmc		= 2,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+	},
+	{ /* Terminator */ }
+};
+
+static void __init rm680_peripherals_init(void)
+{
+	platform_add_devices(rm680_peripherals_devices,
+				ARRAY_SIZE(rm680_peripherals_devices));
+	rm680_i2c_init();
+	gpmc_onenand_init(board_onenand_data);
+	omap2_hsmmc_init(mmc);
+}
+
+static void __init rm680_init_irq(void)
+{
+	struct omap_sdrc_params *sdrc_params;
+
+	sdrc_params = nokia_get_sdram_timings();
+	omap2_init_common_hw(sdrc_params, sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+#ifdef CONFIG_OMAP_MUX
+static struct omap_board_mux board_mux[] __initdata = {
+	{ .reg_offset = OMAP_MUX_TERMINATOR },
+};
+#endif
+
+static struct omap_musb_board_data rm680_musb_data = {
+	.interface_type	= MUSB_INTERFACE_ULPI,
+	.mode		= MUSB_PERIPHERAL,
+	.power		= 100,
+};
+
+static void __init rm680_init(void)
+{
+	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
+	omap_serial_init();
+	usb_musb_init(&rm680_musb_data);
+	rm680_peripherals_init();
+}
+
+static void __init rm680_map_io(void)
+{
+	omap2_set_globals_3xxx();
+	omap34xx_map_common_io();
+}
+
+MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
+	.boot_params	= 0x80000100,
+	.map_io		= rm680_map_io,
+	.reserve	= omap_reserve,
+	.init_irq	= rm680_init_irq,
+	.init_machine	= rm680_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 229fbf2..7bbc074 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -148,6 +148,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP3(3, craneboard);
 		DEBUG_LL_OMAP3(3, igep0020);
 		DEBUG_LL_OMAP3(3, igep0030);
+		DEBUG_LL_OMAP3(3, nokia_rm680);
 		DEBUG_LL_OMAP3(3, nokia_rx51);
 		DEBUG_LL_OMAP3(3, omap3517evm);
 		DEBUG_LL_OMAP3(3, omap3_beagle);
-- 
1.5.6.5

