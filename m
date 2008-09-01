From: sakoman@gmail.com
Subject: [PATCH 1/4] ARM: OMAP2: Add support for the Gumstix
	Overo board
Date: Mon,  1 Sep 2008 14:57:56 -0700
Message-ID: <1220306279-27977-2-git-send-email-sakoman@gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
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

This patch adds support for basic features: onenand, uarts, i2c,
mmc, rtc, lcd and usb

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/Kconfig                   |    4 +
 arch/arm/mach-omap2/Makefile                  |    4 +
 arch/arm/mach-omap2/board-overo.c             |  236 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/board-overo.h |   22 +++
 arch/arm/plat-omap/include/mach/hardware.h    |    4 +
 drivers/video/omap/Kconfig                    |   21 +++
 drivers/video/omap/Makefile                   |    1 +
 drivers/video/omap/lcd_overo.c                |  189 ++++++++++++++++++++
 8 files changed, 481 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-overo.c
 create mode 100644 arch/arm/plat-omap/include/mach/board-overo.h
 create mode 100644 drivers/video/omap/lcd_overo.c

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
index 0000000..85f5db2
--- /dev/null
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -0,0 +1,236 @@
+/*
+ * board-overo.c (Gumstix Overo)
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
+#define W2W_NRESET	16
+#define BT_NRESET	164
+#define USBH_CPEN	168
+#define USBH_NRESET	183
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
+		.size           =  15 * NAND_BLOCK_SIZE,
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
+		.name           = "jffs2",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = MTDPART_SIZ_FULL,
+	},
+};
+
+static struct omap_onenand_platform_data overo_onenand_data = {
+	.parts = overo_onenand_partitions,
+	.nr_parts = ARRAY_SIZE(overo_onenand_partitions),
+	.dma_channel	= -1,	/* disable DMA in OMAP OneNAND driver */
+};
+
+static struct platform_device overo_onenand_device = {
+	.name		= "omap2-onenand",
+	.id		= -1,
+	.dev = {
+		.platform_data = &overo_onenand_data,
+	},
+};
+
+void __init overo_flash_init(void)
+{
+	u8		cs = 0;
+	u8		onenandcs = GPMC_CS_NUM + 1;
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
+				" in GPMC\n ");
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
+static struct platform_device overo_lcd_device = {
+	.name		= "overo_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config overo_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel overo_config[] __initdata = {
+	{ OMAP_TAG_UART,	&overo_uart_config },
+	{ OMAP_TAG_MMC,		&overo_mmc_config },
+	{ OMAP_TAG_LCD,		&overo_lcd_config },
+};
+
+static struct platform_device *overo_devices[] __initdata = {
+	&overo_lcd_device,
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&overo_twl4030rtc_device,
+#endif
+};
+
+static void __init overo_init(void)
+{
+
+	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
+	omap_board_config = overo_config;
+	omap_board_config_size = ARRAY_SIZE(overo_config);
+	omap_serial_init();
+	hsmmc_init();
+	usb_musb_init();
+	usb_ehci_init();
+	overo_flash_init();
+
+	if ((gpio_request(W2W_NRESET, "W2W_NRESET") == 0) &&
+	    (gpio_direction_output(W2W_NRESET, 1) == 0)) {
+		gpio_export(W2W_NRESET, 0);
+		gpio_direction_output(W2W_NRESET, 0);
+		udelay(10);
+		gpio_direction_output(W2W_NRESET, 1);
+	} else
+		printk(KERN_ERR "could not obtain gpio for W2W_NRESET\n");
+
+	if ((gpio_request(BT_NRESET, "BT_NRESET") == 0) &&
+	    (gpio_direction_output(BT_NRESET, 1) == 0)) {
+		gpio_export(BT_NRESET, 0);
+		gpio_direction_output(BT_NRESET, 0);
+		mdelay(6);
+		gpio_direction_output(BT_NRESET, 1);
+	} else
+		printk(KERN_ERR "could not obtain gpio for BT_NRESET\n");
+
+	if ((gpio_request(USBH_CPEN, "USBH_CPEN") == 0) &&
+	    (gpio_direction_output(USBH_CPEN, 1) == 0))
+		gpio_export(USBH_CPEN, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for USBH_CPEN\n");
+
+	if ((gpio_request(USBH_NRESET, "USBH_NRESET") == 0) &&
+	    (gpio_direction_output(USBH_NRESET, 1) == 0))
+		gpio_export(USBH_NRESET, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for USBH_NRESET\n");
+}
+
+arch_initcall(overo_i2c_init);
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
index 0000000..0fc14e4
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/board-overo.h
@@ -0,0 +1,22 @@
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
+#define ONENAND_MAP		0x20000000
+
+#endif /* ____ASM_ARCH_OVERO_H */
+
diff --git a/arch/arm/plat-omap/include/mach/hardware.h b/arch/arm/plat-omap/include/mach/hardware.h
index 438de80..f859c00 100644
--- a/arch/arm/plat-omap/include/mach/hardware.h
+++ b/arch/arm/plat-omap/include/mach/hardware.h
@@ -374,6 +374,10 @@
 #include "board-sx1.h"
 #endif
 
+#ifdef CONFIG_MACH_OVERO
+#include "board-overo.h"
+#endif
+
 #endif /* !__ASSEMBLER__ */
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index bdeb8fb..5ebd591 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -7,6 +7,27 @@ config FB_OMAP
 	help
           Frame buffer driver for OMAP based boards.
 
+choice
+	depends on FB_OMAP && MACH_OVERO
+	prompt "Screen resolution"
+	default FB_OMAP_079M3R
+	help
+	  Selected desired screen resolution
+
+config FB_OMAP_031M3R
+	boolean "640 x 480 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_048M3R
+	boolean "800 x 600 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_079M3R
+	boolean "1024 x 768 @ 60 Hz Reduced blanking"
+
+config FB_OMAP_092M9R
+	boolean "1280 x 720 @ 60 Hz Reduced blanking"
+
+endchoice
+
 config FB_OMAP_LCDC_EXTERNAL
 	bool "External LCD controller support"
 	depends on FB_OMAP
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index f9b5cd4..291c46e 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -35,6 +35,7 @@ objs-y$(CONFIG_MACH_OMAP2EVM) += lcd_omap2evm.o
 objs-y$(CONFIG_MACH_OMAP3EVM) += lcd_omap3evm.o
 objs-y$(CONFIG_MACH_OMAP3_BEAGLE) += lcd_omap3beagle.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
+objs-y$(CONFIG_MACH_OVERO) += lcd_overo.o
 
 omapfb-objs := $(objs-yy)
 
diff --git a/drivers/video/omap/lcd_overo.c b/drivers/video/omap/lcd_overo.c
new file mode 100644
index 0000000..831936d
--- /dev/null
+++ b/drivers/video/omap/lcd_overo.c
@@ -0,0 +1,189 @@
+/*
+ * LCD panel support for the Gumstix Overo
+ *
+ * Author: Steve Sakoman <steve@sakoman.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/i2c/twl4030.h>
+
+#include <mach/gpio.h>
+#include <mach/mux.h>
+#include <mach/omapfb.h>
+#include <asm/mach-types.h>
+
+#define LCD_ENABLE       144
+
+static int overo_panel_init(struct lcd_panel *panel,
+				struct omapfb_device *fbdev)
+{
+	if ((gpio_request(LCD_ENABLE, "LCD_ENABLE") == 0) &&
+	    (gpio_direction_output(LCD_ENABLE, 1) == 0))
+		gpio_export(LCD_ENABLE, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for LCD_ENABLE\n");
+
+	return 0;
+}
+
+static void overo_panel_cleanup(struct lcd_panel *panel)
+{
+}
+
+static int overo_panel_enable(struct lcd_panel *panel)
+{
+	gpio_direction_output(LCD_ENABLE, 1);
+	return 0;
+}
+
+static void overo_panel_disable(struct lcd_panel *panel)
+{
+	gpio_direction_output(LCD_ENABLE, 0);
+}
+
+static unsigned long overo_panel_get_caps(struct lcd_panel *panel)
+{
+	return 0;
+}
+
+struct lcd_panel overo_panel = {
+	.name		= "overo",
+	.config		= OMAP_LCDC_PANEL_TFT,
+	.bpp		= 16,
+	.data_lines	= 24,
+
+#if defined CONFIG_FB_OMAP_031M3R
+
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#elif defined CONFIG_FB_OMAP_048M3R
+
+	/* 800 x 600 @ 60 Hz  Reduced blanking VESA CVT 0.48M3-R */
+	.x_res		= 800,
+	.y_res		= 600,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 11,
+	.pixel_clock	= 35500,
+
+#elif defined CONFIG_FB_OMAP_079M3R
+
+	/* 1024 x 768 @ 60 Hz  Reduced blanking VESA CVT 0.79M3-R */
+	.x_res		= 1024,
+	.y_res		= 768,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 15,
+	.pixel_clock	= 56000,
+
+#elif defined CONFIG_FB_OMAP_092M9R
+
+	/* 1280 x 720 @ 60 Hz  Reduced blanking VESA CVT 0.92M9-R */
+	.x_res		= 1280,
+	.y_res		= 720,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 5,
+	.vbp		= 13,
+	.pixel_clock	= 64000,
+
+#else
+
+	/* use 640 x 480 if no config option */
+	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
+	.x_res		= 640,
+	.y_res		= 480,
+	.hfp		= 48,
+	.hsw		= 32,
+	.hbp		= 80,
+	.vfp		= 3,
+	.vsw		= 4,
+	.vbp		= 7,
+	.pixel_clock	= 23500,
+
+#endif
+
+	.init		= overo_panel_init,
+	.cleanup	= overo_panel_cleanup,
+	.enable		= overo_panel_enable,
+	.disable	= overo_panel_disable,
+	.get_caps	= overo_panel_get_caps,
+};
+
+static int overo_panel_probe(struct platform_device *pdev)
+{
+	omapfb_register_panel(&overo_panel);
+	return 0;
+}
+
+static int overo_panel_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static int overo_panel_suspend(struct platform_device *pdev,
+				   pm_message_t mesg)
+{
+	return 0;
+}
+
+static int overo_panel_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+struct platform_driver overo_panel_driver = {
+	.probe		= overo_panel_probe,
+	.remove		= overo_panel_remove,
+	.suspend	= overo_panel_suspend,
+	.resume		= overo_panel_resume,
+	.driver		= {
+		.name	= "overo_lcd",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init overo_panel_drv_init(void)
+{
+	return platform_driver_register(&overo_panel_driver);
+}
+
+static void __exit overo_panel_drv_exit(void)
+{
+	platform_driver_unregister(&overo_panel_driver);
+}
+
+module_init(overo_panel_drv_init);
+module_exit(overo_panel_drv_exit);
-- 
1.5.4.5
