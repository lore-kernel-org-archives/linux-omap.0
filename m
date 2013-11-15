From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] ARM: OMAP2+: Remove legacy booting support for n8x0
Date: Thu, 14 Nov 2013 16:09:54 -0800
Message-ID: <1384474198-20756-8-git-send-email-tony@atomide.com>
References: <1384474198-20756-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42299 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580Ab3KOAKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 19:10:08 -0500
In-Reply-To: <1384474198-20756-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Now we can boot n8x with the appended device tree with:

$ ARCH=arm CROSS_COMPILE=/usr/bin/arm-linux-gnueabi- make omap2420-n800.dtb
$ cat arch/arm/boot/zImage arch/arm/boot/dts/omap2420-n800.dtb > /tmp/zImage

Note that you need at least the following enabled:

CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
CONFIG_PINCTRL=y
CONFIG_PINCTRL_SINGLE=y

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-n8x0.c | 158 ---------------------------------------
 arch/arm/mach-omap2/msdi.c       |  69 -----------------
 2 files changed, 227 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index da0d494..5e04bdc8 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -21,7 +21,6 @@
 #include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/usb/musb.h>
-#include <linux/platform_data/i2c-cbus-gpio.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/mtd-onenand-omap2.h>
 #include <linux/mfd/menelaus.h>
@@ -33,7 +32,6 @@
 #include "common.h"
 #include "mmc.h"
 #include "soc.h"
-#include "mux.h"
 #include "gpmc-onenand.h"
 
 #define TUSB6010_ASYNC_CS	1
@@ -61,58 +59,12 @@ static void board_check_revision(void)
 			board_caps = NOKIA_N810;
 		else if (of_machine_is_compatible("nokia,n810-wimax"))
 			board_caps = NOKIA_N810_WIMAX;
-	} else {
-		if (machine_is_nokia_n800())
-			board_caps = NOKIA_N800;
-		else if (machine_is_nokia_n810())
-			board_caps = NOKIA_N810;
-		else if (machine_is_nokia_n810_wimax())
-			board_caps = NOKIA_N810_WIMAX;
 	}
 
 	if (!board_caps)
 		pr_err("Unknown board\n");
 }
 
-#if defined(CONFIG_I2C_CBUS_GPIO) || defined(CONFIG_I2C_CBUS_GPIO_MODULE)
-static struct i2c_cbus_platform_data n8x0_cbus_data = {
-	.clk_gpio = 66,
-	.dat_gpio = 65,
-	.sel_gpio = 64,
-};
-
-static struct platform_device n8x0_cbus_device = {
-	.name	= "i2c-cbus-gpio",
-	.id	= 3,
-	.dev	= {
-		.platform_data = &n8x0_cbus_data,
-	},
-};
-
-static struct i2c_board_info n8x0_i2c_board_info_3[] __initdata = {
-	{
-		I2C_BOARD_INFO("retu-mfd", 0x01),
-	},
-};
-
-static void __init n8x0_cbus_init(void)
-{
-	const int retu_irq_gpio = 108;
-
-	if (gpio_request_one(retu_irq_gpio, GPIOF_IN, "Retu IRQ"))
-		return;
-	irq_set_irq_type(gpio_to_irq(retu_irq_gpio), IRQ_TYPE_EDGE_RISING);
-	n8x0_i2c_board_info_3[0].irq = gpio_to_irq(retu_irq_gpio);
-	i2c_register_board_info(3, n8x0_i2c_board_info_3,
-				ARRAY_SIZE(n8x0_i2c_board_info_3));
-	platform_device_register(&n8x0_cbus_device);
-}
-#else /* CONFIG_I2C_CBUS_GPIO */
-static void __init n8x0_cbus_init(void)
-{
-}
-#endif /* CONFIG_I2C_CBUS_GPIO */
-
 #if defined(CONFIG_USB_MUSB_TUSB6010) || defined(CONFIG_USB_MUSB_TUSB6010_MODULE)
 /*
  * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
@@ -598,8 +550,6 @@ static void __init n8x0_mmc_init(void)
 
 	mmc1_data.nr_slots = 2;
 	mmc_data[0] = &mmc1_data;
-	if (!of_have_populated_dt())
-		omap242x_init_mmc(mmc_data);
 }
 #else
 
@@ -684,54 +634,6 @@ static struct i2c_board_info n810_i2c_board_info_2[] __initdata = {
 	},
 };
 
-#ifdef CONFIG_OMAP_MUX
-static struct omap_board_mux board_mux[] __initdata = {
-	/* I2S codec port pins for McBSP block */
-	OMAP2420_MUX(EAC_AC_SCLK, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
-	OMAP2420_MUX(EAC_AC_FS, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
-	OMAP2420_MUX(EAC_AC_DIN, OMAP_MUX_MODE1 | OMAP_PIN_INPUT),
-	OMAP2420_MUX(EAC_AC_DOUT, OMAP_MUX_MODE1 | OMAP_PIN_OUTPUT),
-	{ .reg_offset = OMAP_MUX_TERMINATOR },
-};
-
-static struct omap_device_pad serial2_pads[] __initdata = {
-	{
-		.name	= "uart3_rx_irrx.uart3_rx_irrx",
-		.flags	= OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
-		.enable	= OMAP_MUX_MODE0,
-		.idle	= OMAP_MUX_MODE3	/* Mux as GPIO for idle */
-	},
-};
-
-static inline void board_serial_init(void)
-{
-	struct omap_board_data bdata;
-
-	bdata.flags = 0;
-	bdata.pads = NULL;
-	bdata.pads_cnt = 0;
-
-	bdata.id = 0;
-	omap_serial_init_port(&bdata, NULL);
-
-	bdata.id = 1;
-	omap_serial_init_port(&bdata, NULL);
-
-	bdata.id = 2;
-	bdata.pads = serial2_pads;
-	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
-	omap_serial_init_port(&bdata, NULL);
-}
-
-#else
-
-static inline void board_serial_init(void)
-{
-	omap_serial_init();
-}
-
-#endif
-
 static int __init n8x0_late_initcall(void)
 {
 	if (!board_caps)
@@ -740,8 +642,6 @@ static int __init n8x0_late_initcall(void)
 	gpmc_onenand_init(board_onenand_data);
 	n8x0_mmc_init();
 	n8x0_usb_init();
-	if (!of_have_populated_dt())
-		n8x0_cbus_init();
 
 	return 0;
 }
@@ -764,61 +664,3 @@ void * __init n8x0_legacy_init(void)
 
 	return &mmc1_data;
 }
-
-static void __init n8x0_init_machine(void)
-{
-	board_check_revision();
-	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
-	/* FIXME: add n810 spi devices */
-	spi_register_board_info(n800_spi_board_info,
-				ARRAY_SIZE(n800_spi_board_info));
-	omap_register_i2c_bus(1, 400, n8x0_i2c_board_info_1,
-			      ARRAY_SIZE(n8x0_i2c_board_info_1));
-	omap_register_i2c_bus(2, 400, NULL, 0);
-	if (board_is_n810())
-		i2c_register_board_info(2, n810_i2c_board_info_2,
-					ARRAY_SIZE(n810_i2c_board_info_2));
-	if (!of_have_populated_dt()) {
-		board_serial_init();
-		omap_sdrc_init(NULL, NULL);
-	}
-}
-
-MACHINE_START(NOKIA_N800, "Nokia N800")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap242x_map_io,
-	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
-	.init_machine	= n8x0_init_machine,
-	.init_late	= omap2420_init_late,
-	.init_time	= omap2_sync32k_timer_init,
-	.restart	= omap2xxx_restart,
-MACHINE_END
-
-MACHINE_START(NOKIA_N810, "Nokia N810")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap242x_map_io,
-	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
-	.init_machine	= n8x0_init_machine,
-	.init_late	= omap2420_init_late,
-	.init_time	= omap2_sync32k_timer_init,
-	.restart	= omap2xxx_restart,
-MACHINE_END
-
-MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
-	.atag_offset	= 0x100,
-	.reserve	= omap_reserve,
-	.map_io		= omap242x_map_io,
-	.init_early	= omap2420_init_early,
-	.init_irq	= omap2_init_irq,
-	.handle_irq	= omap2_intc_handle_irq,
-	.init_machine	= n8x0_init_machine,
-	.init_late	= omap2420_init_late,
-	.init_time	= omap2_sync32k_timer_init,
-	.restart	= omap2xxx_restart,
-MACHINE_END
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
index c52d8b4..828e0db 100644
--- a/arch/arm/mach-omap2/msdi.c
+++ b/arch/arm/mach-omap2/msdi.c
@@ -88,72 +88,3 @@ int omap_msdi_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
-
-#if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-
-static inline void omap242x_mmc_mux(struct omap_mmc_platform_data
-				    *mmc_controller)
-{
-	if ((mmc_controller->slots[0].switch_pin > 0) && \
-		(mmc_controller->slots[0].switch_pin < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
-					OMAP_PIN_INPUT_PULLUP);
-	if ((mmc_controller->slots[0].gpio_wp > 0) && \
-		(mmc_controller->slots[0].gpio_wp < OMAP_MAX_GPIO_LINES))
-		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
-					OMAP_PIN_INPUT_PULLUP);
-
-	omap_mux_init_signal("sdmmc_cmd", 0);
-	omap_mux_init_signal("sdmmc_clki", 0);
-	omap_mux_init_signal("sdmmc_clko", 0);
-	omap_mux_init_signal("sdmmc_dat0", 0);
-	omap_mux_init_signal("sdmmc_dat_dir0", 0);
-	omap_mux_init_signal("sdmmc_cmd_dir", 0);
-	if (mmc_controller->slots[0].caps & MMC_CAP_4_BIT_DATA) {
-		omap_mux_init_signal("sdmmc_dat1", 0);
-		omap_mux_init_signal("sdmmc_dat2", 0);
-		omap_mux_init_signal("sdmmc_dat3", 0);
-		omap_mux_init_signal("sdmmc_dat_dir1", 0);
-		omap_mux_init_signal("sdmmc_dat_dir2", 0);
-		omap_mux_init_signal("sdmmc_dat_dir3", 0);
-	}
-
-	/*
-	 * Use internal loop-back in MMC/SDIO Module Input Clock
-	 * selection
-	 */
-	if (mmc_controller->slots[0].internal_clock) {
-		u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-		v |= (1 << 24);
-		omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
-	}
-}
-
-void __init omap242x_init_mmc(struct omap_mmc_platform_data **mmc_data)
-{
-	struct platform_device *pdev;
-	struct omap_hwmod *oh;
-	int id = 0;
-	char *oh_name = "msdi1";
-	char *dev_name = "mmci-omap";
-
-	if (!mmc_data[0]) {
-		pr_err("%s fails: Incomplete platform data\n", __func__);
-		return;
-	}
-
-	omap242x_mmc_mux(mmc_data[0]);
-
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh) {
-		pr_err("Could not look up %s\n", oh_name);
-		return;
-	}
-	pdev = omap_device_build(dev_name, id, oh, mmc_data[0],
-				 sizeof(struct omap_mmc_platform_data));
-	if (IS_ERR(pdev))
-		WARN(1, "Can'd build omap_device for %s:%s.\n",
-					dev_name, oh->name);
-}
-
-#endif
-- 
1.8.1.1

