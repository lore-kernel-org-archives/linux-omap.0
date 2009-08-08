From: Kalle Valo <kalle.valo@iki.fi>
Subject: [PATCH v2 1/2] OMAP2: add board file for Nokia N800 and N810
Date: Sat, 08 Aug 2009 12:57:31 +0300
Message-ID: <20090808095731.4829.3823.stgit@tikku>
References: <20090808095404.4829.43749.stgit@tikku>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:48863 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933851AbZHHJ5w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Aug 2009 05:57:52 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id 7593CEC018
	for <linux-omap@vger.kernel.org>; Sat,  8 Aug 2009 12:57:51 +0300 (EEST)
Received: from [127.0.1.1] (YKMDCCXXIII.gprs.sl-laajakaista.fi [85.77.207.224])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id BBD7341BEA
	for <linux-omap@vger.kernel.org>; Sat,  8 Aug 2009 12:57:48 +0300 (EEST)
In-Reply-To: <20090808095404.4829.43749.stgit@tikku>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Add board file for Nokia N800 and N810 devices. Currently only serial ports,
onenand, spi and usb are configured, more to come later.

Tested on Nokia N800.

Signed-off-by: Kalle Valo <kalle.valo@iki.fi>
---

 arch/arm/mach-omap2/Kconfig      |    4 
 arch/arm/mach-omap2/Makefile     |    2 
 arch/arm/mach-omap2/board-n8x0.c |  307 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 312 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-n8x0.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bf54686..75b1c7e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -73,6 +73,10 @@ config MACH_OMAP_3430SDP
 	bool "OMAP 3430 SDP board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_NOKIA_N8X0
+	bool "Nokia N800/N810"
+	depends on ARCH_OMAP2420
+
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 757c84b..8850a24 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o \
 					   mmc-twl4030.o
 obj-$(CONFIG_MACH_OMAP_3430SDP)		+= board-3430sdp.o \
 					   mmc-twl4030.o
-
+obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-peripherals.o \
 					   mmc-twl4030.o
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
new file mode 100644
index 0000000..ed0a457
--- /dev/null
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -0,0 +1,307 @@
+/*
+ * linux/arch/arm/mach-omap2/board-n8x0.c
+ *
+ * Copyright (C) 2005-2009 Nokia Corporation
+ * Author: Juha Yrjola <juha.yrjola@nokia.com>
+ *
+ * Modified from mach-omap2/board-generic.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/stddef.h>
+#include <linux/spi/spi.h>
+#include <linux/usb/musb.h>
+
+#include <asm/mach/arch.h>
+#include <asm/mach-types.h>
+
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/gpio.h>
+#include <mach/io.h>
+#include <mach/irqs.h>
+#include <mach/mcspi.h>
+#include <mach/onenand.h>
+#include <mach/serial.h>
+
+#define TUSB_ASYNC_CS		1
+#define TUSB_SYNC_CS		4
+#define GPIO_TUSB_INT		58
+#define GPIO_TUSB_ENABLE	0
+
+#if defined(CONFIG_USB_MUSB_OTG)
+#define BOARD_MODE MUSB_OTG
+#elif defined(CONFIG_USB_MUSB_PERIPHERAL)
+#define BOARD_MODE MUSB_PERIPHERAL
+#else /* defined(CONFIG_USB_MUSB_HOST) */
+#define BOARD_MODE MUSB_HOST
+#endif
+
+/*
+ * Enable or disable power to TUSB6010. When enabling, turn on 3.3 V and
+ * 1.5 V voltage regulators of PM companion chip. Companion chip will then
+ * provide then PGOOD signal to TUSB6010 which will release it from reset.
+ */
+static int tusb_set_power(int state)
+{
+	int i, retval = 0;
+
+	if (state) {
+		gpio_set_value(GPIO_TUSB_ENABLE, 1);
+		msleep(1);
+
+		/* Wait until TUSB6010 pulls INT pin down */
+		i = 100;
+		while (i && gpio_get_value(GPIO_TUSB_INT)) {
+			msleep(1);
+			i--;
+		}
+
+		if (!i) {
+			printk(KERN_ERR "tusb: powerup failed\n");
+			retval = -ENODEV;
+		}
+	} else {
+		gpio_set_value(GPIO_TUSB_ENABLE, 0);
+		msleep(10);
+	}
+
+	return retval;
+}
+
+static int		osc_ck_on;
+
+static int tusb_set_clock(struct clk *osc_ck, int state)
+{
+	if (state) {
+		if (osc_ck_on > 0)
+			return -ENODEV;
+
+		clk_enable(osc_ck);
+		osc_ck_on = 1;
+	} else {
+		if (osc_ck_on == 0)
+			return -ENODEV;
+
+		clk_disable(osc_ck);
+		osc_ck_on = 0;
+	}
+
+	return 0;
+}
+
+static struct musb_hdrc_eps_bits musb_eps[] = {
+	{	"ep1_tx", 5,	},
+	{	"ep1_rx", 5,	},
+	{	"ep2_tx", 5,	},
+	{	"ep2_rx", 5,	},
+	{	"ep3_tx", 3,	},
+	{	"ep3_rx", 3,	},
+	{	"ep4_tx", 3,	},
+	{	"ep4_rx", 3,	},
+	{	"ep5_tx", 2,	},
+	{	"ep5_rx", 2,	},
+	{	"ep6_tx", 2,	},
+	{	"ep6_rx", 2,	},
+	{	"ep7_tx", 2,	},
+	{	"ep7_rx", 2,	},
+	{	"ep8_tx", 2,	},
+	{	"ep8_rx", 2,	},
+	{	"ep9_tx", 2,	},
+	{	"ep9_rx", 2,	},
+	{	"ep10_tx", 2,	},
+	{	"ep10_rx", 2,	},
+	{	"ep11_tx", 2,	},
+	{	"ep11_rx", 2,	},
+	{	"ep12_tx", 2,	},
+	{	"ep12_rx", 2,	},
+	{	"ep13_tx", 2,	},
+	{	"ep13_rx", 2,	},
+	{	"ep14_tx", 2,	},
+	{	"ep14_rx", 2,	},
+	{	"ep15_tx", 2,	},
+	{	"ep15_rx", 2,	},
+};
+
+static struct musb_hdrc_config musb_config = {
+	.multipoint	= 1,
+	.dyn_fifo	= 1,
+	.soft_con	= 1,
+	.dma		= 1,
+	.num_eps	= 16,
+	.dma_channels	= 7,
+	.ram_bits	= 12,
+	.eps_bits	= musb_eps,
+};
+
+static struct musb_hdrc_platform_data tusb_data = {
+	.mode		= BOARD_MODE,
+	.set_power	= tusb_set_power,
+	.set_clock	= tusb_set_clock,
+	.min_power	= 25,	/* x2 = 50 mA drawn from VBUS as peripheral */
+	.power		= 100,	/* Max 100 mA VBUS for host mode */
+	.clock		= "osc_ck",
+	.config		= &musb_config,
+};
+
+static void __init n8x0_usb_init(void)
+{
+	int ret = 0;
+	static char	announce[] __initdata = KERN_INFO "TUSB 6010\n";
+
+	/* PM companion chip power control pin */
+	ret = gpio_request(GPIO_TUSB_ENABLE, "TUSB6010 enable");
+	if (ret != 0) {
+		printk(KERN_ERR "Could not get TUSB power GPIO%i\n",
+		       GPIO_TUSB_ENABLE);
+		return;
+	}
+	gpio_direction_output(GPIO_TUSB_ENABLE, 0);
+
+	tusb_set_power(0);
+
+	ret = tusb6010_setup_interface(&tusb_data, TUSB6010_REFCLK_19, 2,
+					TUSB_ASYNC_CS, TUSB_SYNC_CS,
+					GPIO_TUSB_INT, 0x3f);
+	if (ret != 0)
+		goto err;
+
+	printk(announce);
+
+	return;
+
+err:
+	gpio_free(GPIO_TUSB_ENABLE);
+}
+
+static struct omap2_mcspi_device_config p54spi_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel = 1,
+};
+
+static struct spi_board_info n800_spi_board_info[] __initdata = {
+	{
+		.modalias	= "p54spi",
+		.bus_num	= 2,
+		.chip_select	= 0,
+		.max_speed_hz   = 48000000,
+		.controller_data = &p54spi_mcspi_config,
+	},
+};
+
+#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
+	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
+
+static struct mtd_partition onenand_partitions[] = {
+	{
+		.name           = "bootloader",
+		.offset         = 0,
+		.size           = 0x20000,
+		.mask_flags     = MTD_WRITEABLE,	/* Force read-only */
+	},
+	{
+		.name           = "config",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x60000,
+	},
+	{
+		.name           = "kernel",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x200000,
+	},
+	{
+		.name           = "initfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x400000,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data board_onenand_data = {
+	.cs		= 0,
+	.gpio_irq	= 26,
+	.parts		= onenand_partitions,
+	.nr_parts	= ARRAY_SIZE(onenand_partitions),
+	.flags		= ONENAND_SYNC_READ,
+};
+
+static void __init n8x0_onenand_init(void)
+{
+	gpmc_onenand_init(&board_onenand_data);
+}
+
+#else
+
+static void __init n8x0_onenand_init(void) {}
+
+#endif
+
+/* FIXME: n810 needs UART1 */
+static struct omap_uart_platform_data n8x0_uart_config __initdata = {
+	.enabled_uarts = (1 << 2),
+};
+
+static void __init n8x0_map_io(void)
+{
+	omap2_set_globals_242x();
+	omap2_map_common_io();
+}
+
+static void __init n8x0_init_irq(void)
+{
+	omap2_init_common_hw(NULL);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static void __init n8x0_init_machine(void)
+{
+	/* FIXME: add n810 spi devices */
+	spi_register_board_info(n800_spi_board_info,
+				ARRAY_SIZE(n800_spi_board_info));
+
+	omap_serial_init(&n8x0_uart_config);
+	n8x0_onenand_init();
+
+	n8x0_usb_init();
+}
+
+MACHINE_START(NOKIA_N800, "Nokia N800")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END
+
+MACHINE_START(NOKIA_N810, "Nokia N810")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END
+
+MACHINE_START(NOKIA_N810_WIMAX, "Nokia N810 WiMAX")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= n8x0_map_io,
+	.init_irq	= n8x0_init_irq,
+	.init_machine	= n8x0_init_machine,
+	.timer		= &omap_timer,
+MACHINE_END

