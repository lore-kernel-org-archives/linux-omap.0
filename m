From: Marek =?iso-8859-2?q?Va=B9ut?= <marek.vasut@gmail.com>
Subject: [PATCH 1/3] Palm Tungsten|T support
Date: Sun, 29 Oct 2006 00:55:45 +0200
Message-ID: <200610290055.45962.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_x/9QFVN936GtAC4"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--Boundary-00=_x/9QFVN936GtAC4
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
this patch adds board file and necessary includes for Palm Tungsten|T.

Short description of device:
PalmTT is omap1510 @=A0144MHz based device with 16megs of ram, 8meg flash f=
rom=20
amd, 320x320x16bpp lcd, touchscreen based on ads7846, bcm2033 bluetooth,=20
irda, aic23 as soundchip and weird mmc connected over mcbsp.

Signed-off-by: Marek Va=B9ut <marek.vasut@gmail.com>

--Boundary-00=_x/9QFVN936GtAC4
Content-Type: text/x-diff; charset="iso-8859-1"; name="palmtt-board.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="palmtt-board.patch"

diff -Naur linux-omap-dev/arch/arm/mach-omap1/board-palmtt.c linux-omap/arch/arm/mach-omap1/board-palmtt.c
--- linux-omap-dev/arch/arm/mach-omap1/board-palmtt.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap/arch/arm/mach-omap1/board-palmtt.c	2006-10-28 21:29:19.000000000 +0200
@@ -0,0 +1,363 @@
+/*
+ * linux/arch/arm/mach-omap1/board-palmtt.c
+ *
+ * Modified from board-palmtt2.c
+ *
+ * Modified and amended for Palm Tungsten|T
+ * by Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/notifier.h>
+#include <linux/clk.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/map.h>
+#include <asm/mach/flash.h>
+
+#include <asm/arch/mcbsp.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/usb.h>
+#include <asm/arch/dma.h>
+#include <asm/arch/tc.h>
+#include <asm/arch/board.h>
+#include <asm/arch/irda.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/common.h>
+#include <asm/arch/omap-alsa.h>
+
+#include <linux/input.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
+
+static int palmtt_keymap[] = {
+	KEY(0, 0, KEY_ESC),
+	KEY(0, 1, KEY_SPACE),
+	KEY(0, 2, KEY_LEFTCTRL),
+	KEY(0, 3, KEY_TAB),
+	KEY(0, 4, KEY_ENTER),
+	KEY(1, 0, KEY_LEFT),
+	KEY(1, 1, KEY_DOWN),
+	KEY(1, 2, KEY_UP),
+	KEY(1, 3, KEY_RIGHT),
+	KEY(2, 0, KEY_SLEEP),
+	KEY(2, 4, KEY_Y),
+	0
+};
+
+static struct mtd_partition palmtt_partitions[] = {
+	{
+	      .name		= "write8k",
+	      .offset		= 0,
+	      .size		= SZ_8K,
+	      .mask_flags	= 0,
+	},
+	{
+	      .name		= "PalmOS-BootLoader(ro)",
+	      .offset		= SZ_8K,
+	      .size		= 7*SZ_8K,
+	      .mask_flags	= MTD_WRITEABLE,
+	},
+	{
+	      .name		= "u-boot",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= 8*SZ_8K,
+	      .mask_flags	= 0,
+	},
+	{
+	      .name		= "PalmOS-FS(ro)",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= 7*SZ_1M + 4*SZ_64K - 16*SZ_8K,
+	      .mask_flags	= MTD_WRITEABLE,
+	},
+	{
+	      .name		= "u-boot(rez)",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= SZ_128K,
+	      .mask_flags	= 0
+	},
+	{
+	      .name		= "empty",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= MTDPART_SIZ_FULL,
+	      .mask_flags	= 0
+	}
+};
+
+static struct flash_platform_data palmtt_flash_data = {
+	.map_name	= "cfi_probe",
+	.width		= 2,
+	.parts		= palmtt_partitions,
+	.nr_parts	= ARRAY_SIZE(palmtt_partitions),
+};
+
+static struct resource palmtt_flash_resource = {
+	.start		= OMAP_CS0_PHYS,
+	.end		= OMAP_CS0_PHYS + SZ_8M - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device palmtt_flash_device = {
+	.name		= "omapflash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &palmtt_flash_data,
+	},
+	.num_resources	= 1,
+	.resource	= &palmtt_flash_resource,
+};
+
+#define DEFAULT_BITPERSAMPLE 16
+
+static struct omap_mcbsp_reg_cfg mcbsp_regs = { 
+	.spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
+	.spcr1 = RINTM(3) | RRST,
+	.rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
+	    RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
+	.rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
+	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
+	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
+	.xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
+	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
+	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
+	/*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp: master */
+	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
+};
+
+static struct omap_alsa_codec_config alsa_config = {
+	.name			= "PalmTT AIC23",
+	.mcbsp_regs_alsa	= &mcbsp_regs,
+	.codec_configure_dev	= NULL, // aic23_configure,
+	.codec_set_samplerate	= NULL, // aic23_set_samplerate,
+	.codec_clock_setup	= NULL, // aic23_clock_setup,
+	.codec_clock_on		= NULL, // aic23_clock_on,
+	.codec_clock_off	= NULL, // aic23_clock_off,
+	.get_default_samplerate	= NULL, // aic23_get_default_samplerate,	
+};
+
+static struct platform_device palmtt_mcbsp1_device = {
+	.name	= "omap_alsa_mcbsp",
+ 	.id	= 1,
+	.dev = {
+		.platform_data	= &alsa_config,
+	},
+};
+
+static struct resource palmtt_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data palmtt_kp_data = {
+	.rows	= 6,
+	.cols	= 3,
+	.keymap = palmtt_keymap,
+};
+
+static struct platform_device palmtt_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &palmtt_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(palmtt_kp_resources),
+	.resource	= palmtt_kp_resources,
+};
+
+static struct platform_device palmtt_lcd_device = {
+	.name		= "lcd_palmtt",
+	.id		= -1,
+};
+static struct omap_irda_config palmtt_irda_config = {
+        .transceiver_cap        = IR_SIRMODE,
+        .rx_channel             = OMAP_DMA_UART3_RX,
+        .tx_channel             = OMAP_DMA_UART3_TX,
+        .dest_start             = UART3_THR,
+        .src_start              = UART3_RHR,
+        .tx_trigger             = 0,
+        .rx_trigger             = 0,
+};
+							
+static struct resource palmtt_irda_resources[] = {
+        [0]     = {
+            .start  = INT_UART3,
+            .end    = INT_UART3,
+            .flags  = IORESOURCE_IRQ,
+        },
+};
+														
+static struct platform_device palmtt_irda_device = {
+        .name           = "omapirda",
+        .id             = -1,
+        .dev            = {
+                .platform_data  = &palmtt_irda_config,
+        },
+        .num_resources  = ARRAY_SIZE(palmtt_irda_resources),
+        .resource       = palmtt_irda_resources,
+};
+																							
+static struct platform_device palmtt_spi_device = {
+        .name           = "spi_palmtt",
+        .id             = -1,
+};
+
+static struct omap_backlight_config palmtt_backlight_config = {
+        .default_intensity      = 0xa0,
+	};
+	
+static struct platform_device palmtt_backlight_device = {
+        .name           = "omap-bl",
+        .id             = -1,
+        .dev            = {
+                .platform_data  = &palmtt_backlight_config,
+        },
+};
+							
+		
+static struct platform_device *palmtt_devices[] __initdata = {
+	&palmtt_flash_device,
+	&palmtt_mcbsp1_device,
+	&palmtt_kp_device,
+	&palmtt_lcd_device,
+	&palmtt_irda_device,
+	&palmtt_spi_device,
+	&palmtt_backlight_device,
+};
+static int palmtt_get_pendown_state(void)
+{
+    return !omap_get_gpio_datain(6);
+}
+	
+static const struct ads7846_platform_data palmtt_ts_info = {
+    .model                      = 7846,
+    .vref_delay_usecs           = 100,  /* internal, no capacitor */
+    .x_plate_ohms               = 419,
+    .y_plate_ohms               = 486,
+    .get_pendown_state          = palmtt_get_pendown_state,
+};
+			    
+static struct spi_board_info __initdata palmtt_boardinfo[] = { {
+    /* MicroWire (bus 2) CS0 has an ads7846e */
+    .modalias                   = "ads7846",
+    .platform_data              = &palmtt_ts_info,
+    .irq                        = OMAP_GPIO_IRQ(6),
+    .max_speed_hz               = 120000 /* max sample rate at 3V */
+                                  * 26 /* command + data + overhead */,
+    .bus_num                    = 2,
+    .chip_select                = 0,
+} };
+											    
+//static int __initdata palmtt_serial_ports[OMAP_MAX_NR_PORTS] = {1, 1, 1};
+
+static void __init omap_palmtt_init_irq(void)
+{
+	omap1_init_common_hw();
+	omap_init_irq();
+}
+
+static struct omap_usb_config palmtt_usb_config __initdata = {
+	.register_dev	= 1,
+	.hmc_mode	= 0,
+	.pins[0]	= 2,
+};
+
+static struct omap_lcd_config palmtt_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_uart_config palmtt_uart_config __initdata = {
+        .enabled_uarts = (1 << 0) | (1 << 1) | (0 << 2),
+};
+	
+static struct omap_board_config_kernel palmtt_config[] = {
+	{ OMAP_TAG_USB,		&palmtt_usb_config  },
+	{ OMAP_TAG_LCD,		&palmtt_lcd_config  },
+        { OMAP_TAG_UART,	&palmtt_uart_config },
+};
+/*should be fixed soon*/
+/*static irqreturn_t
+palmtt_powercable(int irq, void *dev_id, struct pt_regs *regs)
+{
+        if (omap_get_gpio_datain(PALMTT_USBDETECT_GPIO)) {
+            printk(KERN_INFO "PM: USB cable connected (charging)\n");
+            set_irq_type(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), IRQT_FALLING);
+        } else {
+            printk(KERN_INFO "PM: USB cable disconnected\n");
+            set_irq_type(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), IRQT_RISING);
+        }
+        return IRQ_HANDLED;
+}*/
+												
+static void __init omap_mpu_wdt_mode(int mode) {
+        if (mode)
+            omap_writew(0x8000, OMAP_WDT_TIMER_MODE);
+        else {
+            omap_writew(0x00f5, OMAP_WDT_TIMER_MODE);
+            omap_writew(0x00a0, OMAP_WDT_TIMER_MODE);
+        }
+}
+/*needs to be fixed, this will be simple*/
+/*static void __init palmtt_gpio_setup(int early)
+{
+    if (early) {
+	omap_set_gpio_dataout(1,1);
+        omap_set_gpio_direction(1,0);
+    } else {
+        if (omap_request_gpio(PALMTT_USBDETECT_GPIO)) {
+            printk(KERN_ERR "Could not reserve cable signal GPIO!\n");
+            return;
+        }
+        omap_set_gpio_direction(PALMTT_USBDETECT_GPIO, 1);
+        if (request_irq(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), palmtt_powercable,
+            SA_SAMPLE_RANDOM, "palmtt-cable", 0))
+            printk(KERN_ERR "IRQ request for power cable failed!\n");
+        palmtt_powercable(OMAP_GPIO_IRQ(PALMTT_USBDETECT_GPIO), 0, 0);
+    }
+}*/
+																												    
+static void __init omap_palmtt_init(void)
+{
+//	palmtt_gpio_setup(1);
+        omap_mpu_wdt_mode(0);
+	
+	omap_board_config = palmtt_config;
+        omap_board_config_size = ARRAY_SIZE(palmtt_config);
+		
+	platform_add_devices(palmtt_devices, ARRAY_SIZE(palmtt_devices));
+		    
+        spi_register_board_info(palmtt_boardinfo,ARRAY_SIZE(palmtt_boardinfo));
+	omap_serial_init();
+//        palmtt_gpio_setup(0);
+}
+				
+static void __init omap_palmtt_map_io(void)
+{
+	omap1_map_common_io();
+}
+
+MACHINE_START(OMAP_PALMTT, "PalmTT")
+	.phys_io	= 0xfff00000,
+	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params	= 0x10000100,
+	.map_io		= omap_palmtt_map_io,
+	.init_irq	= omap_palmtt_init_irq,
+	.init_machine	= omap_palmtt_init,
+	.timer		= &omap_timer,
+MACHINE_END
diff -Naur linux-omap-dev/arch/arm/mach-omap1/Kconfig linux-omap/arch/arm/mach-omap1/Kconfig
--- linux-omap-dev/arch/arm/mach-omap1/Kconfig	2006-10-28 01:36:48.000000000 +0200
+++ linux-omap/arch/arm/mach-omap1/Kconfig	2006-10-28 21:31:23.000000000 +0200
@@ -98,6 +98,15 @@
          http://hackndev.com/palm/z71 for more informations.
          Say Y here if you have such a PDA, say N otherwise.
 
+config MACH_OMAP_PALMTT
+	bool "Palm Tungsten|T"
+	depends on ARCH_OMAP1 && ARCH_OMAP15XX
+	help
+	  Support for the Palm Tungsten|T PDA. To boot the kernel, you'll
+	  need a PalmOS compatible bootloader (Garux); check out
+	  http://www.hackndev.com/palm/tt/ for more information.
+	  Say Y here if you have this PDA model, say N otherwise.
+
 config MACH_NOKIA770
 	bool "Nokia 770"
 	depends on ARCH_OMAP1 && ARCH_OMAP16XX
diff -Naur linux-omap-dev/arch/arm/mach-omap1/Makefile linux-omap/arch/arm/mach-omap1/Makefile
--- linux-omap-dev/arch/arm/mach-omap1/Makefile	2006-10-28 01:36:48.000000000 +0200
+++ linux-omap/arch/arm/mach-omap1/Makefile	2006-10-28 21:31:58.000000000 +0200
@@ -26,6 +26,7 @@
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
 obj-$(CONFIG_MACH_OMAP_PALMTE)		+= board-palmte.o
 obj-$(CONFIG_MACH_OMAP_PALMZ71)		+= board-palmz71.o
+obj-$(CONFIG_MACH_OMAP_PALMTT)		+= board-palmtt.o
 obj-$(CONFIG_MACH_NOKIA770)		+= board-nokia770.o
 obj-$(CONFIG_MACH_AMS_DELTA)		+= board-ams-delta.o
 
diff -Naur linux-omap-dev/include/asm-arm/arch-omap/board-palmtt.h linux-omap/include/asm-arm/arch-omap/board-palmtt.h
--- linux-omap-dev/include/asm-arm/arch-omap/board-palmtt.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-omap/include/asm-arm/arch-omap/board-palmtt.h	2006-10-28 21:29:19.000000000 +0200
@@ -0,0 +1,22 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-palmte.h
+ *
+ * Hardware definitions for the Palm Tungsten|T device.
+ *
+ * Maintainters :	Marek Vasut <marek.vasut@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __OMAP_BOARD_PALMTT_H
+#define __OMAP_BOARD_PALMTT_H
+
+#define PALMTT_USBDETECT_GPIO	0
+#define PALMTT_CABLE_GPIO	1
+#define PALMTT_PINTDAV_GPIO	6
+#define PALMTT_MMC_WP_GPIO	8
+#define PALMTT_HDQ_GPIO 	11
+
+#endif	/* __OMAP_BOARD_PALMTT_H */
diff -Naur linux-omap-dev/include/asm-arm/arch-omap/hardware.h linux-omap/include/asm-arm/arch-omap/hardware.h
--- linux-omap-dev/include/asm-arm/arch-omap/hardware.h	2006-10-28 01:39:47.000000000 +0200
+++ linux-omap/include/asm-arm/arch-omap/hardware.h	2006-10-28 21:29:19.000000000 +0200
@@ -338,6 +338,10 @@
 #include "board-palmz71.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP_PALMTT
+#include "board-palmtt.h"
+#endif
+
 #endif /* !__ASSEMBLER__ */
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */

--Boundary-00=_x/9QFVN936GtAC4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Boundary-00=_x/9QFVN936GtAC4--
