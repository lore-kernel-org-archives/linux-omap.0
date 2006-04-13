From: Brian Swetland <swetland@google.com>
Subject: fsample support patch (core omap only)
Date: Thu, 13 Apr 2006 10:06:11 -0700
Message-ID: <20060413170611.GA5510@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
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


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Here's a revised version of my original patch, using cpu_is_*()
and only including the core omap files.

Device patches to follow.

Brian

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omap-fsample.patch"

--- linux-omap-2.6/arch/arm/mach-omap1/Kconfig	2006-04-05 14:38:05.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/Kconfig	2006-04-06 18:23:30.000000000 -0700
@@ -63,6 +63,13 @@
 	  Support for TI OMAP 730 Perseus2 board. Say Y here if you have such
 	  a board.
 
+config MACH_OMAP_FSAMPLE
+	bool "TI F-Sample"
+	depends on ARCH_OMAP1 && ARCH_OMAP730
+    	help
+	  Support for TI OMAP 850 F-Sample board. Say Y here if you have such
+	  a board.
+
 config MACH_VOICEBLUE
 	bool "Voiceblue"
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
--- linux-omap-2.6/arch/arm/mach-omap1/Makefile	2006-04-05 14:38:05.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/Makefile	2006-04-06 18:23:30.000000000 -0700
@@ -17,6 +17,7 @@
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
+obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
 obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
--- linux-omap-2.6/arch/arm/mach-omap1/board-fsample.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-omap-fsample/arch/arm/mach-omap1/board-fsample.c	2006-04-06 18:23:30.000000000 -0700
@@ -0,0 +1,319 @@
+/*
+ * linux/arch/arm/mach-omap1/board-fsample.c
+ *
+ * Modified from board-perseus2.c
+ *
+ * Original OMAP730 support by Jean Pihet <j-pihet@ti.com>
+ * Updated for 2.6 by Kevin Hilman <kjh@hilman.org>
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
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/input.h>
+
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <asm/mach/flash.h>
+#include <asm/mach/map.h>
+
+#include <asm/arch/tc.h>
+#include <asm/arch/gpio.h>
+#include <asm/arch/mux.h>
+#include <asm/arch/fpga.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/common.h>
+#include <asm/arch/board.h>
+#include <asm/arch/board-fsample.h>
+
+static int fsample_keymap[] = {
+	KEY(0,0,KEY_UP),
+	KEY(0,1,KEY_RIGHT),
+	KEY(0,2,KEY_LEFT),
+	KEY(0,3,KEY_DOWN),
+	KEY(0,4,KEY_CENTER),
+	KEY(0,5,KEY_0_5),
+	KEY(1,0,KEY_SOFT2),
+	KEY(1,1,KEY_SEND),
+	KEY(1,2,KEY_END),
+	KEY(1,3,KEY_VOLUMEDOWN),
+	KEY(1,4,KEY_VOLUMEUP),
+	KEY(1,5,KEY_RECORD),
+	KEY(2,0,KEY_SOFT1),
+	KEY(2,1,KEY_3),
+	KEY(2,2,KEY_6),
+	KEY(2,3,KEY_9),
+	KEY(2,4,KEY_SHARP),
+	KEY(2,5,KEY_2_5),
+	KEY(3,0,KEY_BACK),
+	KEY(3,1,KEY_2),
+	KEY(3,2,KEY_5),
+	KEY(3,3,KEY_8),
+	KEY(3,4,KEY_0),
+	KEY(3,5,KEY_HEADSETHOOK),
+	KEY(4,0,KEY_HOME),
+	KEY(4,1,KEY_1),
+	KEY(4,2,KEY_4),
+	KEY(4,3,KEY_7),
+	KEY(4,4,KEY_STAR),
+	KEY(4,5,KEY_POWER),
+	0
+};
+
+static struct resource smc91x_resources[] = {
+	[0] = {
+		.start	= H2P2_DBG_FPGA_ETHR_START,	/* Physical */
+		.end	= H2P2_DBG_FPGA_ETHR_START + 0xf,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= INT_730_MPU_EXT_NIRQ,
+		.end	= 0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct mtd_partition nor_partitions[] = {
+	/* bootloader (U-Boot, etc) in first sector */
+	{
+	      .name		= "bootloader",
+	      .offset		= 0,
+	      .size		= SZ_128K,
+	      .mask_flags	= MTD_WRITEABLE, /* force read-only */
+	},
+	/* bootloader params in the next sector */
+	{
+	      .name		= "params",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= SZ_128K,
+	      .mask_flags	= 0,
+	},
+	/* kernel */
+	{
+	      .name		= "kernel",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= SZ_2M,
+	      .mask_flags	= 0
+	},
+	/* rest of flash is a file system */
+	{
+	      .name		= "rootfs",
+	      .offset		= MTDPART_OFS_APPEND,
+	      .size		= MTDPART_SIZ_FULL,
+	      .mask_flags	= 0
+	},
+};
+
+static struct flash_platform_data nor_data = {
+	.map_name	= "cfi_probe",
+	.width		= 2,
+	.parts		= nor_partitions,
+	.nr_parts	= ARRAY_SIZE(nor_partitions),
+};
+
+static struct resource nor_resource = {
+	.start		= OMAP_CS0_PHYS,
+	.end		= OMAP_CS0_PHYS + SZ_32M - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device nor_device = {
+	.name		= "omapflash",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &nor_data,
+	},
+	.num_resources	= 1,
+	.resource	= &nor_resource,
+};
+
+static struct nand_platform_data nand_data = {
+	.options	= NAND_SAMSUNG_LP_OPTIONS,
+};
+
+static struct resource nand_resource = {
+	.start		= OMAP_CS3_PHYS,
+	.end		= OMAP_CS3_PHYS + SZ_4K - 1,
+	.flags		= IORESOURCE_MEM,
+};
+
+static struct platform_device nand_device = {
+	.name		= "omapnand",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &nand_data,
+	},
+	.num_resources	= 1,
+	.resource	= &nand_resource,
+};
+
+static struct platform_device smc91x_device = {
+	.name		= "smc91x",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(smc91x_resources),
+	.resource	= smc91x_resources,
+};
+
+static struct resource kp_resources[] = {
+	[0] = {
+		.start	= INT_730_MPUIO_KEYPAD,
+		.end	= INT_730_MPUIO_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = fsample_keymap,
+};
+
+static struct platform_device kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(kp_resources),
+	.resource	= kp_resources,
+};
+
+static struct platform_device lcd_device = {
+	.name		= "lcd_p2",
+	.id		= -1,
+};
+
+static struct platform_device *devices[] __initdata = {
+	&nor_device,
+	&nand_device,
+	&smc91x_device,
+	&kp_device,
+	&lcd_device,
+};
+
+#define P2_NAND_RB_GPIO_PIN	62
+
+static int nand_dev_ready(struct nand_platform_data *data)
+{
+	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+}
+
+static struct omap_uart_config fsample_uart_config __initdata = {
+	.enabled_uarts = ((1 << 0) | (1 << 1)),
+};
+
+static struct omap_lcd_config fsample_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
+static struct omap_board_config_kernel fsample_config[] = {
+	{ OMAP_TAG_UART,	&fsample_uart_config },
+	{ OMAP_TAG_LCD,		&fsample_lcd_config },
+};
+
+static void __init omap_fsample_init(void)
+{
+	if (!(omap_request_gpio(P2_NAND_RB_GPIO_PIN)))
+		nand_data.dev_ready = nand_dev_ready;
+
+	omap_cfg_reg(L3_1610_FLASH_CS2B_OE);
+	omap_cfg_reg(M8_1610_FLASH_CS2B_WE);
+
+	platform_add_devices(devices, ARRAY_SIZE(devices));
+
+	omap_board_config = fsample_config;
+	omap_board_config_size = ARRAY_SIZE(fsample_config);
+	omap_serial_init();
+}
+
+static void __init fsample_init_smc91x(void)
+{
+	fpga_write(1, H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+	fpga_write(fpga_read(H2P2_DBG_FPGA_LAN_RESET) & ~1,
+		   H2P2_DBG_FPGA_LAN_RESET);
+	mdelay(50);
+}
+
+void omap_fsample_init_irq(void)
+{
+	omap1_init_common_hw();
+	omap_init_irq();
+	omap_gpio_init();
+	fsample_init_smc91x();
+}
+
+/* Only FPGA needs to be mapped here. All others are done with ioremap */
+static struct map_desc omap_fsample_io_desc[] __initdata = {
+	{
+		.virtual	= H2P2_DBG_FPGA_BASE,
+		.pfn		= __phys_to_pfn(H2P2_DBG_FPGA_START),
+		.length		= H2P2_DBG_FPGA_SIZE,
+		.type		= MT_DEVICE
+	},
+	{
+		.virtual	= FSAMPLE_CPLD_BASE,
+		.pfn		= __phys_to_pfn(FSAMPLE_CPLD_START),
+		.length		= FSAMPLE_CPLD_SIZE,
+		.type		= MT_DEVICE
+	}
+};
+
+static void __init omap_fsample_map_io(void)
+{
+	omap1_map_common_io();
+	iotable_init(omap_fsample_io_desc,
+		     ARRAY_SIZE(omap_fsample_io_desc));
+
+	/* Early, board-dependent init */
+
+	/*
+	 * Hold GSM Reset until needed
+	 */
+	omap_writew(omap_readw(OMAP730_DSP_M_CTL) & ~1, OMAP730_DSP_M_CTL);
+
+	/*
+	 * UARTs -> done automagically by 8250 driver
+	 */
+
+	/*
+	 * CSx timings, GPIO Mux ... setup
+	 */
+
+	/* Flash: CS0 timings setup */
+	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_0);
+	omap_writel(0x00000088, OMAP730_FLASH_ACFG_0);
+
+	/*
+	 * Ethernet support through the debug board
+	 * CS1 timings setup
+	 */
+	omap_writel(0x0000fff3, OMAP730_FLASH_CFG_1);
+	omap_writel(0x00000000, OMAP730_FLASH_ACFG_1);
+
+	/*
+	 * Configure MPU_EXT_NIRQ IO in IO_CONF9 register,
+	 * It is used as the Ethernet controller interrupt
+	 */
+	omap_writel(omap_readl(OMAP730_IO_CONF_9) & 0x1FFFFFFF, OMAP730_IO_CONF_9);
+}
+
+MACHINE_START(OMAP_FSAMPLE, "OMAP730 F-Sample")
+/* Maintainer: Brian Swetland <swetland@google.com> */
+	.phys_io	= 0xfff00000,
+	.io_pg_offst	= ((0xfef00000) >> 18) & 0xfffc,
+	.boot_params	= 0x10000100,
+	.map_io		= omap_fsample_map_io,
+	.init_irq	= omap_fsample_init_irq,
+	.init_machine	= omap_fsample_init,
+	.timer		= &omap_timer,
+MACHINE_END
--- linux-omap-2.6/arch/arm/mach-omap1/clock.c	2006-02-27 12:11:59.000000000 -0800
+++ linux-omap-fsample/arch/arm/mach-omap1/clock.c	2006-04-12 13:48:17.000000000 -0700
@@ -1,3 +1,4 @@
+//kernel/linux-omap-fsample/arch/arm/mach-omap1/clock.c#2 - edit change 3808 (text)
 /*
  *  linux/arch/arm/mach-omap1/clock.c
  *
@@ -20,6 +21,7 @@
 
 #include <asm/io.h>
 
+#include <asm/arch/cpu.h>
 #include <asm/arch/usb.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
@@ -270,8 +272,12 @@
 	/*
 	 * In most cases we should not need to reprogram DPLL.
 	 * Reprogramming the DPLL is tricky, it must be done from SRAM.
+	 * (on 730, bit 13 must always be 1)
 	 */
-	omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
+	if (cpu_is_omap730())
+		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val | 0x2000);
+	else
+		omap_sram_reprogram_clock(ptr->dpllctl_val, ptr->ckctl_val);
 
 	ck_dpll1.rate = ptr->pll_rate;
 	propagate_rate(&ck_dpll1);
@@ -748,7 +754,7 @@
 		printk(KERN_ERR "System frequencies not set. Check your config.\n");
 		/* Guess sane values (60MHz) */
 		omap_writew(0x2290, DPLL_CTL);
-		omap_writew(0x1005, ARM_CKCTL);
+		omap_writew(cpu_is_omap730() ? 0x3005 : 0x1005, ARM_CKCTL);
 		ck_dpll1.rate = 60000000;
 		propagate_rate(&ck_dpll1);
 	}
@@ -761,13 +767,17 @@
 	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
 	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
 
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
+#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 	/* Select slicer output as OMAP input clock */
 	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
 #endif
 
 	/* Turn off DSP and ARM_TIMXO. Make sure ARM_INTHCK is not divided */
-	omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
+	/* (on 730, bit 13 must not be cleared) */
+	if (cpu_is_omap730())
+		omap_writew(omap_readw(ARM_CKCTL) & 0x2fff, ARM_CKCTL);
+	else
+		omap_writew(omap_readw(ARM_CKCTL) & 0x0fff, ARM_CKCTL);
 
 	/* Put DSP/MPUI into reset until needed */
 	omap_writew(0, ARM_RSTCT1);
--- linux-omap-2.6/arch/arm/mach-omap1/pm.c	2006-04-05 14:38:05.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/pm.c	2006-04-12 13:49:16.000000000 -0700
@@ -1,3 +1,4 @@
+//kernel/linux-omap-fsample/arch/arm/mach-omap1/pm.c#3 - integrate change 4545 (text)
 /*
  * linux/arch/arm/mach-omap1/pm.c
  *
@@ -50,6 +51,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach-types.h>
 
+#include <asm/arch/cpu.h>
 #include <asm/arch/irqs.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
@@ -326,8 +328,9 @@
 	/* stop DSP */
 	omap_writew(omap_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);
 
-	/* shut down dsp_ck */
-	omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
+		/* shut down dsp_ck */
+	if (!cpu_is_omap730())
+		omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
 
 	/* temporarily enabling api_ck to access DSP registers */
 	omap_writew(omap_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
--- linux-omap-2.6/arch/arm/mach-omap1/time.c	2005-12-18 05:50:34.000000000 -0800
+++ linux-omap-fsample/arch/arm/mach-omap1/time.c	2006-03-16 12:38:12.000000000 -0800
@@ -94,7 +94,7 @@
  * will break. On P2, the timer count rate is 6.5 MHz after programming PTV
  * with 0. This divides the 13MHz input by 2, and is undocumented.
  */
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
+#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 /* REVISIT: This ifdef construct should be replaced by a query to clock
  * framework to see if timer base frequency is 12.0, 13.0 or 19.2 MHz.
  */
--- linux-omap-2.6/arch/arm/plat-omap/devices.c	2006-04-05 14:38:05.000000000 -0700
+++ linux-omap-fsample/arch/arm/plat-omap/devices.c	2006-04-06 18:23:30.000000000 -0700
@@ -105,7 +105,7 @@
 		omap_cfg_reg(E20_1610_KBR3);
 		omap_cfg_reg(E19_1610_KBR4);
 		omap_cfg_reg(N19_1610_KBR5);
-	} else if (machine_is_omap_perseus2()) {
+	} else if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
 		omap_cfg_reg(E2_730_KBR0);
 		omap_cfg_reg(J7_730_KBR1);
 		omap_cfg_reg(E1_730_KBR2);
--- linux-omap-2.6/include/asm-arm/arch-omap/board-fsample.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-omap-fsample/include/asm-arm/arch-omap/board-fsample.h	2006-03-16 12:38:12.000000000 -0800
@@ -0,0 +1,51 @@
+/*
+ * linux/include/asm-arm/arch-omap/board-fsample.h
+ *
+ * Board-specific goodies for TI F-Sample.
+ *
+ * Copyright (C) 2006 Google, Inc.
+ * Author: Brian Swetland <swetland@google.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_ARCH_OMAP_FSAMPLE_H
+#define __ASM_ARCH_OMAP_FSAMPLE_H
+
+/* fsample is pretty close to p2-sample */
+#include <asm/arch/board-perseus2.h>
+
+#define fsample_cpld_read(reg) __raw_readb(reg)
+#define fsample_cpld_write(val, reg) __raw_writeb(val, reg)
+
+#define FSAMPLE_CPLD_BASE    0xE8100000
+#define FSAMPLE_CPLD_SIZE    SZ_4K
+#define FSAMPLE_CPLD_START   0x05080000
+
+#define FSAMPLE_CPLD_REG_A   (FSAMPLE_CPLD_BASE + 0x00)
+#define FSAMPLE_CPLD_SWITCH  (FSAMPLE_CPLD_BASE + 0x02)
+#define FSAMPLE_CPLD_UART    (FSAMPLE_CPLD_BASE + 0x02)
+#define FSAMPLE_CPLD_REG_B   (FSAMPLE_CPLD_BASE + 0x04)
+#define FSAMPLE_CPLD_VERSION (FSAMPLE_CPLD_BASE + 0x06)
+#define FSAMPLE_CPLD_SET_CLR (FSAMPLE_CPLD_BASE + 0x06)
+
+#define FSAMPLE_CPLD_BIT_BT_RESET         0
+#define FSAMPLE_CPLD_BIT_LCD_RESET        1
+#define FSAMPLE_CPLD_BIT_CAM_PWDN         2
+#define FSAMPLE_CPLD_BIT_CHARGER_ENABLE   3
+#define FSAMPLE_CPLD_BIT_SD_MMC_EN        4
+#define FSAMPLE_CPLD_BIT_aGPS_PWREN       5
+#define FSAMPLE_CPLD_BIT_BACKLIGHT        6
+#define FSAMPLE_CPLD_BIT_aGPS_EN_RESET    7
+#define FSAMPLE_CPLD_BIT_aGPS_SLEEPx_N    8
+#define FSAMPLE_CPLD_BIT_OTG_RESET        9
+
+#define fsample_cpld_set(bit) \
+    fsample_cpld_write((((bit) & 15) << 4) | 0x0f, FSAMPLE_CPLD_SET_CLR)
+
+#define fsample_cpld_clear(bit) \
+    fsample_cpld_write(0xf0 | ((bit) & 15), FSAMPLE_CPLD_SET_CLR)
+
+#endif
--- linux-omap-2.6/include/asm-arm/arch-omap/hardware.h	2006-02-02 19:18:37.000000000 -0800
+++ linux-omap-fsample/include/asm-arm/arch-omap/hardware.h	2006-03-16 12:38:12.000000000 -0800
@@ -298,6 +298,10 @@
 #include "board-perseus2.h"
 #endif
 
+#ifdef CONFIG_MACH_OMAP_FSAMPLE
+#include "board-fsample.h"
+#endif
+
 #ifdef CONFIG_MACH_OMAP_H3
 #include "board-h3.h"
 #endif
--- linux-omap-2.6/arch/arm/tools/mach-types	2006-03-01 12:49:22.000000000 -0800
+++ linux-omap-fsample/arch/arm/tools/mach-types	2006-03-16 12:38:12.000000000 -0800
@@ -969,3 +969,5 @@
 fujitsu_wimaxsoc	MACH_FUJITSU_WIMAXSOC	FUJITSU_WIMAXSOC	956
 dualpcmodem		MACH_DUALPCMODEM	DUALPCMODEM		957
 gesbc9312		MACH_GESBC9312		GESBC9312		958
+omap_fsample		MACH_OMAP_FSAMPLE	OMAP_FSAMPLE		970
+

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--2fHTh5uZTiUOsy+g--
