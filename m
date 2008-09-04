From: sakoman@gmail.com
Subject: [PATCH 1/5] ARM: OMAP2: Add support for the Gumstix Overo board
Date: Wed,  3 Sep 2008 22:01:56 -0700
Message-ID: <1220504520-6067-2-git-send-email-sakoman@gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from static-74-41-60-154.dsl1.pco.ca.frontiernet.net ([74.41.60.154]:54656
	"EHLO tera.sakoman.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYIDFCJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 01:02:09 -0400
In-Reply-To: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Steve Sakoman <steve@sakoman.com>

From: Steve Sakoman <steve@sakoman.com>

This patch adds support for basic features: onenand, uarts, i2c,
mmc, rtc, and usb
---
 arch/arm/mach-omap2/Kconfig       |    4 +
 arch/arm/mach-omap2/Makefile      |    4 +
 arch/arm/mach-omap2/board-overo.c |  234 +++++++++++++++++++++++++++++++++++++
 3 files changed, 242 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-overo.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 365b982..362edfa 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -123,6 +123,10 @@ config MACH_OMAP3_BEAGLE
 	bool "OMAP3 BEAGLE board"
 	depends on ARCH_OMAP3 && ARCH_OMAP34XX
 
+config MACH_OVERO
+	bool "Gumstix Overo board"
+	depends on ARCH_OMAP3 && ARCH_OMAP34XX
+
 config OMAP_TICK_GPTIMER
 	int "GPTIMER used for system tick timer"
 	depends on ARCH_OMAP2 || ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d89b7cb..1f6c704 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -75,6 +75,10 @@ obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
 					   board-n800-dsp.o \
 					   board-n800-camera.o
 obj-$(CONFIG_MACH_NOKIA_N810)		+= board-n810.o
+obj-$(CONFIG_MACH_OVERO)		+= board-overo.o \
+					   hsmmc.o \
+					   usb-musb.o \
+					   usb-ehci.o
 
 # TUSB 6010 chips
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
new file mode 100644
index 0000000..42c1661
--- /dev/null
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -0,0 +1,234 @@
+/*
+ * board-overo.c (Gumstix Overo)
+ *
+ * Initial code: Steve Sakoman <steve@sakoman.com>
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
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/onenand_regs.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+#include <asm/mach/map.h>
+
+#include <mach/board-overo.h>
+#include <mach/board.h>
+#include <mach/common.h>
+#include <mach/gpio.h>
+#include <mach/gpmc.h>
+#include <mach/hardware.h>
+#include <mach/hsmmc.h>
+#include <mach/onenand.h>
+#include <mach/usb-ehci.h>
+#include <mach/usb-musb.h>
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+#define NAND_BLOCK_SIZE SZ_128K
+
+#define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_BT_NRESET	164
+#define OVERO_GPIO_USBH_CPEN	168
+#define OVERO_GPIO_USBH_NRESET	183
+
+static struct mtd_partition overo_onenand_partitions[] = {
+	{
+		.name           = "xloader",
+		.offset         = 0,
+		.size           = 4 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 15 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "params",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 1 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "linux",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 40 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data overo_onenand_data = {
+	.parts = overo_onenand_partitions,
+	.nr_parts = ARRAY_SIZE(overo_onenand_partitions),
+	.dma_channel = -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device overo_onenand_device = {
+	.name = "omap2-onenand",
+	.id = -1,
+	.dev = {
+		.platform_data = &overo_onenand_data,
+	},
+};
+
+static void __init overo_flash_init(void)
+{
+	u8 cs = 0;
+	u8 onenandcs = GPMC_CS_NUM + 1;
+
+	while (cs < GPMC_CS_NUM) {
+		u32 ret = 0;
+		ret = gpmc_cs_read_reg(cs, GPMC_CS_CONFIG7);
+
+		if ((ret & 0x3F) == (ONENAND_MAP >> 24))
+			onenandcs = cs;
+		cs++;
+	}
+	if (onenandcs > GPMC_CS_NUM) {
+		printk(KERN_ERR "OneNAND: Unable to find configuration "
+				" in GPMC\n");
+		return;
+	}
+
+	if (onenandcs < GPMC_CS_NUM) {
+		overo_onenand_data.cs = onenandcs;
+		if (platform_device_register(&overo_onenand_device) < 0)
+			printk(KERN_ERR "Unable to register OneNAND device\n");
+	}
+}
+static struct omap_uart_config overo_uart_config __initdata = {
+	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
+};
+
+static int __init overo_i2c_init(void)
+{
+	omap_register_i2c_bus(1, 2600, NULL, 0);
+	/* i2c2 pins are used for gpio */
+	omap_register_i2c_bus(3, 400, NULL, 0);
+	return 0;
+}
+
+static void __init overo_init_irq(void)
+{
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap_init_irq();
+	omap_gpio_init();
+}
+
+static struct omap_mmc_config overo_mmc_config __initdata = {
+	.mmc[0] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
+	.mmc[1] = {
+		.enabled	= 1,
+		.wire4		= 1,
+	},
+};
+
+static struct platform_device overo_twl4030rtc_device = {
+	.name           = "twl4030_rtc",
+	.id             = -1,
+};
+
+static struct omap_board_config_kernel overo_config[] __initdata = {
+	{ OMAP_TAG_UART,	&overo_uart_config },
+	{ OMAP_TAG_MMC,		&overo_mmc_config },
+};
+
+static struct platform_device *overo_devices[] __initdata = {
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&overo_twl4030rtc_device,
+#endif
+};
+
+static void __init overo_init(void)
+{
+	overo_i2c_init();
+	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
+	omap_board_config = overo_config;
+	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap_serial_init();
+	hsmmc_init();
+	usb_musb_init();
+	usb_ehci_init();
+	overo_flash_init();
+
+	if ((gpio_request(OVERO_GPIO_W2W_NRESET,
+			  "OVERO_GPIO_W2W_NRESET") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_W2W_NRESET, 1) == 0)) {
+		gpio_export(OVERO_GPIO_W2W_NRESET, 0);
+		gpio_set_value(OVERO_GPIO_W2W_NRESET, 0);
+		udelay(10);
+		gpio_set_value(OVERO_GPIO_W2W_NRESET, 1);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_W2W_NRESET\n");
+	}
+
+	if ((gpio_request(OVERO_GPIO_BT_NRESET, "OVERO_GPIO_BT_NRESET") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_BT_NRESET, 1) == 0)) {
+		gpio_export(OVERO_GPIO_BT_NRESET, 0);
+		gpio_set_value(OVERO_GPIO_BT_NRESET, 0);
+		mdelay(6);
+		gpio_set_value(OVERO_GPIO_BT_NRESET, 1);
+	} else {
+		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_BT_NRESET\n");
+	}
+
+	if ((gpio_request(OVERO_GPIO_USBH_CPEN, "OVERO_GPIO_USBH_CPEN") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_USBH_CPEN, 1) == 0))
+		gpio_export(OVERO_GPIO_USBH_CPEN, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_USBH_CPEN\n");
+
+	if ((gpio_request(OVERO_GPIO_USBH_NRESET,
+			  "OVERO_GPIO_USBH_NRESET") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_USBH_NRESET, 1) == 0))
+		gpio_export(OVERO_GPIO_USBH_NRESET, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for OVERO_GPIO_USBH_NRESET\n");
+}
+
+static void __init overo_map_io(void)
+{
+	omap2_set_globals_343x();
+	omap2_map_common_io();
+}
+
+MACHINE_START(OVERO, "Gumstix Overo")
+	.phys_io	= 0x48000000,
+	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
+	.boot_params	= 0x80000100,
+	.map_io		= overo_map_io,
+	.init_irq	= overo_init_irq,
+	.init_machine	= overo_init,
+	.timer		= &omap_timer,
+MACHINE_END
-- 
1.5.4.5

