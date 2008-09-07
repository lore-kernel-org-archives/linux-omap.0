From: sakoman@gmail.com
Subject: [PATCH 1/5] ARM: OMAP2: Add support for the Gumstix
	Overo board (rev 3)
Date: Sat,  6 Sep 2008 23:41:40 -0700
Message-ID: <1220769704-16705-2-git-send-email-sakoman@gmail.com>
References: <1220769704-16705-1-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220769704-16705-1-git-send-email-sakoman@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

From: Steve Sakoman <steve@sakoman.com>

This patch adds support for basic features: nand, uarts, i2c,
mmc, rtc, and usb

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/Kconfig                   |    4 +
 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/board-overo.c             |  249 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/board-overo.h |   25 +++
 4 files changed, 282 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-overo.c
 create mode 100644 arch/arm/plat-omap/include/mach/board-overo.h

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
index c667821..e18da0c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -76,6 +76,10 @@ obj-$(CONFIG_MACH_NOKIA_N800)		+= board-n800.o board-n800-flash.o \
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
index 0000000..5510049
--- /dev/null
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -0,0 +1,249 @@
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
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
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
+#include <mach/nand.h>
+#include <mach/usb-ehci.h>
+#include <mach/usb-musb.h>
+
+#include "sdram-micron-mt46h32m32lf-6.h"
+
+#define NAND_BLOCK_SIZE SZ_128K
+#define GPMC_CS0_BASE  0x60
+#define GPMC_CS_SIZE   0x30
+
+static struct mtd_partition overo_nand_partitions[] = {
+	{
+		.name           = "xloader",
+		.offset         = 0,			/* Offset = 0x00000 */
+		.size           = 4 * NAND_BLOCK_SIZE,
+		.mask_flags     = MTD_WRITEABLE
+	},
+	{
+		.name           = "uboot",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x80000 */
+		.size           = 14 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "uboot environment",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x240000 */
+		.size           = 2 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "linux",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x280000 */
+		.size           = 32 * NAND_BLOCK_SIZE,
+	},
+	{
+		.name           = "rootfs",
+		.offset         = MTDPART_OFS_APPEND,	/* Offset = 0x680000 */
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_nand_platform_data overo_nand_data = {
+	.parts = overo_nand_partitions,
+	.nr_parts = ARRAY_SIZE(overo_nand_partitions),
+	.dma_channel = -1,	/* disable DMA in OMAP NAND driver */
+};
+
+static struct resource overo_nand_resource = {
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device overo_nand_device = {
+	.name		= "omap2-nand",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &overo_nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &overo_nand_resource,
+};
+
+
+static void __init overo_flash_init(void)
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
+		overo_nand_data.cs = nandcs;
+		overo_nand_data.gpmc_cs_baseaddr = (void *)
+			(gpmc_base_add + GPMC_CS0_BASE + nandcs * GPMC_CS_SIZE);
+		overo_nand_data.gpmc_baseaddr = (void *) (gpmc_base_add);
+
+		printk(KERN_INFO "Registering NAND on CS%d\n", nandcs);
+		if (platform_device_register(&overo_nand_device) < 0)
+			printk(KERN_ERR "Unable to register NAND device\n");
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
diff --git a/arch/arm/plat-omap/include/mach/board-overo.h b/arch/arm/plat-omap/include/mach/board-overo.h
new file mode 100644
index 0000000..b70f22a
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/board-overo.h
@@ -0,0 +1,25 @@
+/*
+ * board-overo.h (Gumstix Overo)
+ *
+ * Initial code: Steve Sakoman <steve@sakoman.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ASM_ARCH_OVERO_H
+#define __ASM_ARCH_OVERO_H
+
+#define OVERO_GPIO_W2W_NRESET	16
+#define OVERO_GPIO_BT_NRESET	164
+#define OVERO_GPIO_USBH_CPEN	168
+#define OVERO_GPIO_USBH_NRESET	183
+
+#endif /* ____ASM_ARCH_OVERO_H */
+
-- 
1.5.4.5
