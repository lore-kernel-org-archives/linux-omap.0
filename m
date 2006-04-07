From: Brian Swetland <swetland@google.com>
Subject: patches for fsample/850
Date: Fri, 7 Apr 2006 15:06:58 -0700
Message-ID: <20060407220658.GA19801@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
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


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Attached is a set of patches to start support for the omap850
and specifically the f-sample development board from TI.

Features:

- machine ID 970 as registered with the arm machine registery:
  http://www.arm.linux.org.uk/developer/machines/?action=list&id=970
- initial support for the FPGA on fsample
- adjustment to the 'p2' lcd driver so that it correctly initializes
  the display on fsample (which involves using the FPGA interface)
- some adjustment to clock.h/clock.c to avoid disabling the baseband
  side of the world on 730/850 as a sideeffect of other clock changes


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="omap-fsample.patch"

--- linux-omap-2.6/arch/arm/mach-omap1/Kconfig	2006-04-05 10:33:21.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/Kconfig	2006-04-06 13:15:33.000000000 -0700
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
--- linux-omap-2.6/arch/arm/mach-omap1/Makefile	2006-04-05 10:33:21.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/Makefile	2006-04-06 13:15:34.000000000 -0700
@@ -17,6 +17,7 @@
 obj-$(CONFIG_MACH_OMAP_INNOVATOR)	+= board-innovator.o
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_PERSEUS2)	+= board-perseus2.o
+obj-$(CONFIG_MACH_OMAP_FSAMPLE)		+= board-fsample.o
 obj-$(CONFIG_MACH_OMAP_OSK)		+= board-osk.o
 obj-$(CONFIG_MACH_OMAP_H3)		+= board-h3.o
 obj-$(CONFIG_MACH_VOICEBLUE)		+= board-voiceblue.o
--- linux-omap-2.6/arch/arm/mach-omap1/clock.c	2006-02-27 12:14:41.000000000 -0800
+++ linux-omap-fsample/arch/arm/mach-omap1/clock.c	2006-03-01 14:25:18.000000000 -0800
@@ -761,7 +761,7 @@
 	       ck_dpll1.rate / 1000000, (ck_dpll1.rate / 100000) % 10,
 	       arm_ck.rate / 1000000, (arm_ck.rate / 100000) % 10);
 
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
+#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 	/* Select slicer output as OMAP input clock */
 	omap_writew(omap_readw(OMAP730_PCC_UPLD_CTRL) & ~0x1, OMAP730_PCC_UPLD_CTRL);
 #endif
--- linux-omap-2.6/arch/arm/mach-omap1/clock.h	2006-04-05 10:33:20.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/clock.h	2006-04-06 13:15:34.000000000 -0700
@@ -101,44 +101,50 @@
 /*-------------------------------------------------------------------------
  * Omap1 MPU rate table
  *-------------------------------------------------------------------------*/
+#if defined(CONFIG_ARCH_OMAP730)
+	#define CKCTL_RESERVED_1_MASK (0x2000)
+#else
+	#define CKCTL_RESERVED_1_MASK (0x0000)
+#endif
+
 static struct mpu_rate rate_table[] = {
 	/* MPU MHz, xtal MHz, dpll1 MHz, CKCTL, DPLL_CTL
 	 * NOTE: Comment order here is different from bits in CKCTL value:
 	 * armdiv, dspdiv, dspmmu, tcdiv, perdiv, lcddiv
 	 */
 #if defined(CONFIG_OMAP_ARM_216MHZ)
-	{ 216000000, 12000000, 216000000, 0x050d, 0x2910 }, /* 1/1/2/2/2/8 */
+	{ 216000000, 12000000, 216000000, CKCTL_RESERVED_1_MASK | 0x050d, 0x2910 }, /* 1/1/2/2/2/8 */
 #endif
 #if defined(CONFIG_OMAP_ARM_195MHZ)
-	{ 195000000, 13000000, 195000000, 0x050e, 0x2790 }, /* 1/1/2/2/4/8 */
+	{ 195000000, 13000000, 195000000, CKCTL_RESERVED_1_MASK | 0x050e, 0x2790 }, /* 1/1/2/2/4/8 */
 #endif
 #if defined(CONFIG_OMAP_ARM_192MHZ)
-	{ 192000000, 19200000, 192000000, 0x050f, 0x2510 }, /* 1/1/2/2/8/8 */
-	{ 192000000, 12000000, 192000000, 0x050f, 0x2810 }, /* 1/1/2/2/8/8 */
-	{  96000000, 12000000, 192000000, 0x055f, 0x2810 }, /* 2/2/2/2/8/8 */
-	{  48000000, 12000000, 192000000, 0x0baf, 0x2810 }, /* 4/4/4/8/8/8 */
-	{  24000000, 12000000, 192000000, 0x0fff, 0x2810 }, /* 8/8/8/8/8/8 */
+	{ 192000000, 19200000, 192000000, CKCTL_RESERVED_1_MASK | 0x050f, 0x2510 }, /* 1/1/2/2/8/8 */
+	{ 192000000, 12000000, 192000000, CKCTL_RESERVED_1_MASK | 0x050f, 0x2810 }, /* 1/1/2/2/8/8 */
+	{  96000000, 12000000, 192000000, CKCTL_RESERVED_1_MASK | 0x055f, 0x2810 }, /* 2/2/2/2/8/8 */
+	{  48000000, 12000000, 192000000, CKCTL_RESERVED_1_MASK | 0x0baf, 0x2810 }, /* 4/4/4/8/8/8 */
+	{  24000000, 12000000, 192000000, CKCTL_RESERVED_1_MASK | 0x0fff, 0x2810 }, /* 8/8/8/8/8/8 */
 #endif
 #if defined(CONFIG_OMAP_ARM_182MHZ)
-	{ 182000000, 13000000, 182000000, 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
+	{ 182000000, 13000000, 182000000, CKCTL_RESERVED_1_MASK | 0x050e, 0x2710 }, /* 1/1/2/2/4/8 */
 #endif
 #if defined(CONFIG_OMAP_ARM_168MHZ)
-	{ 168000000, 12000000, 168000000, 0x010f, 0x2710 }, /* 1/1/1/2/8/8 */
+	{ 168000000, 12000000, 168000000, CKCTL_RESERVED_1_MASK | 0x010f, 0x2710 }, /* 1/1/1/2/8/8 */
 #endif
 #if defined(CONFIG_OMAP_ARM_150MHZ)
-	{ 150000000, 12000000, 150000000, 0x010a, 0x2cb0 }, /* 1/1/1/2/4/4 */
+	{ 150000000, 12000000, 150000000, CKCTL_RESERVED_1_MASK | 0x010a, 0x2cb0 }, /* 1/1/1/2/4/4 */
 #endif
 #if defined(CONFIG_OMAP_ARM_120MHZ)
-	{ 120000000, 12000000, 120000000, 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
+	{ 120000000, 12000000, 120000000, CKCTL_RESERVED_1_MASK | 0x010a, 0x2510 }, /* 1/1/1/2/4/4 */
 #endif
 #if defined(CONFIG_OMAP_ARM_96MHZ)
-	{  96000000, 12000000,  96000000, 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
+	{  96000000, 12000000,  96000000, CKCTL_RESERVED_1_MASK | 0x0005, 0x2410 }, /* 1/1/1/1/2/2 */
 #endif
 #if defined(CONFIG_OMAP_ARM_60MHZ)
-	{  60000000, 12000000,  60000000, 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
+	{  60000000, 12000000,  60000000, CKCTL_RESERVED_1_MASK | 0x0005, 0x2290 }, /* 1/1/1/1/2/2 */
 #endif
 #if defined(CONFIG_OMAP_ARM_30MHZ)
-	{  30000000, 12000000,  60000000, 0x0555, 0x2290 }, /* 2/2/2/2/2/2 */
+	{  30000000, 12000000,  60000000, CKCTL_RESERVED_1_MASK | 0x0555, 0x2290 }, /* 2/2/2/2/2/2 */
 #endif
 	{ 0, 0, 0, 0, 0 },
 };
--- linux-omap-2.6/arch/arm/mach-omap1/pm.c	2006-04-05 10:33:20.000000000 -0700
+++ linux-omap-fsample/arch/arm/mach-omap1/pm.c	2006-04-06 13:15:34.000000000 -0700
@@ -326,8 +326,10 @@
 	/* stop DSP */
 	omap_writew(omap_readw(ARM_RSTCT1) & ~(1 << DSP_EN), ARM_RSTCT1);
 
+#if !defined(CONFIG_ARCH_OMAP730)
 	/* shut down dsp_ck */
 	omap_writew(omap_readw(ARM_CKCTL) & ~(1 << EN_DSPCK), ARM_CKCTL);
+#endif
 
 	/* temporarily enabling api_ck to access DSP registers */
 	omap_writew(omap_readw(ARM_IDLECT2) | 1 << EN_APICK, ARM_IDLECT2);
--- linux-omap-2.6/arch/arm/mach-omap1/time.c	2006-02-27 12:12:47.000000000 -0800
+++ linux-omap-fsample/arch/arm/mach-omap1/time.c	2006-03-01 14:25:38.000000000 -0800
@@ -94,7 +94,7 @@
  * will break. On P2, the timer count rate is 6.5 MHz after programming PTV
  * with 0. This divides the 13MHz input by 2, and is undocumented.
  */
-#ifdef CONFIG_MACH_OMAP_PERSEUS2
+#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
 /* REVISIT: This ifdef construct should be replaced by a query to clock
  * framework to see if timer base frequency is 12.0, 13.0 or 19.2 MHz.
  */
--- linux-omap-2.6/arch/arm/plat-omap/devices.c	2006-04-05 10:33:13.000000000 -0700
+++ linux-omap-fsample/arch/arm/plat-omap/devices.c	2006-04-06 13:15:37.000000000 -0700
@@ -105,7 +105,7 @@
 		omap_cfg_reg(E20_1610_KBR3);
 		omap_cfg_reg(E19_1610_KBR4);
 		omap_cfg_reg(N19_1610_KBR5);
-	} else if (machine_is_omap_perseus2()) {
+	} else if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
 		omap_cfg_reg(E2_730_KBR0);
 		omap_cfg_reg(J7_730_KBR1);
 		omap_cfg_reg(E1_730_KBR2);
--- linux-omap-2.6/arch/arm/tools/mach-types	2006-03-01 12:11:29.000000000 -0800
+++ linux-omap-fsample/arch/arm/tools/mach-types	2006-03-01 14:34:59.000000000 -0800
@@ -969,3 +969,5 @@
 fujitsu_wimaxsoc	MACH_FUJITSU_WIMAXSOC	FUJITSU_WIMAXSOC	956
 dualpcmodem		MACH_DUALPCMODEM	DUALPCMODEM		957
 gesbc9312		MACH_GESBC9312		GESBC9312		958
+omap_fsample		MACH_OMAP_FSAMPLE	OMAP_FSAMPLE		970
+
--- linux-omap-2.6/drivers/input/keyboard/omap-keypad.c	2006-04-05 10:29:47.000000000 -0700
+++ linux-omap-fsample/drivers/input/keyboard/omap-keypad.c	2006-04-06 13:16:47.000000000 -0700
@@ -376,7 +376,7 @@
 	input_register_device(omap_kp->input);
 
 	if (machine_is_omap_h2() || machine_is_omap_h3() ||
-	    machine_is_omap_perseus2()) {
+	    machine_is_omap_perseus2() || machine_is_omap_fsample()) {
 		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_GPIO_DEBOUNCING);
 	}
 	/* scan current status and enable interrupt */
--- linux-omap-2.6/drivers/spi/omap_uwire.c	2006-02-27 12:14:45.000000000 -0800
+++ linux-omap-fsample/drivers/spi/omap_uwire.c	2006-03-17 15:45:43.000000000 -0800
@@ -495,7 +495,7 @@
 		omap_cfg_reg(N14_1610_UWIRE_CS0);
 		omap_cfg_reg(N15_1610_UWIRE_CS1);
 	}
-	if (machine_is_omap_perseus2()) {
+	if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
 		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
 		int val = omap_readl(OMAP730_IO_CONF_9) & ~0x00EEE000;
 		omap_writel(val | 0x00AAA000, OMAP730_IO_CONF_9);
--- linux-omap-2.6/drivers/ssi/omap-uwire.c	2006-02-27 12:13:10.000000000 -0800
+++ linux-omap-fsample/drivers/ssi/omap-uwire.c	2006-03-17 15:45:43.000000000 -0800
@@ -212,7 +212,7 @@
 		omap_cfg_reg(N14_1610_UWIRE_CS0);
 		omap_cfg_reg(P15_1610_UWIRE_CS3);
 	}
-	if (machine_is_omap_perseus2()) {
+	if (machine_is_omap_perseus2() || machine_is_omap_fsample()) {
 		/* configure pins: MPU_UW_nSCS1, MPU_UW_SDO, MPU_UW_SCLK */
 		int val = omap_readl(OMAP730_IO_CONF_9) & ~0x00EEE000;
 		omap_writel(val | 0x00AAA000, OMAP730_IO_CONF_9);
--- linux-omap-2.6/drivers/video/omap/Makefile	2006-02-27 12:14:45.000000000 -0800
+++ linux-omap-fsample/drivers/video/omap/Makefile	2006-03-02 14:38:23.000000000 -0800
@@ -22,6 +22,7 @@
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 objs-y$(CONFIG_MACH_OMAP_PERSEUS2) += lcd_p2.o
+objs-y$(CONFIG_MACH_OMAP_FSAMPLE) += lcd_p2.o
 objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 
 objs-y$(CONFIG_FB_OMAP_LCD_LPH8923) += lcd_lph8923.o
--- linux-omap-2.6/drivers/video/omap/lcd_p2.c	2006-02-27 12:14:45.000000000 -0800
+++ linux-omap-fsample/drivers/video/omap/lcd_p2.c	2006-03-17 15:45:07.000000000 -0800
@@ -31,6 +31,8 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/omapfb.h>
 
+#include <asm/arch/hardware.h>
+
 /*
  * File: epson-md-tft.h
  *
@@ -173,11 +175,17 @@
 	DBGENTER(1);
 
 		/* thwack the reset line */
+#ifdef CONFIG_MACH_OMAP_FSAMPLE
+    fsample_cpld_clear(FSAMPLE_CPLD_BIT_LCD_RESET);
+	mdelay(5);
+    fsample_cpld_set(FSAMPLE_CPLD_BIT_LCD_RESET);
+#else
 	omap_set_gpio_direction(19, 0);
 	omap_set_gpio_dataout(19, 0);
 	mdelay(2);
 	omap_set_gpio_dataout(19, 1);
-
+#endif
+    
 		/* bits 31:28 -> 0  LCD_PXL_15 .. 12 */
 	value = omap_readl(OMAP730_IO_CONF_3) & 0x0FFFFFFF;
 	omap_writel(value, OMAP730_IO_CONF_3);
@@ -189,8 +197,6 @@
 	omap_writel(value, OMAP730_IO_CONF_4);
 
 	omap_uwire_configure_mode(0,16);
-
-	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISOFF, 9, 0,NULL,1);
 	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_SLPIN, 9, 0,NULL,1);
 	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISNOR, 9, 0,NULL,1);
 	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_GSSET, 9, 0,NULL,1);
@@ -265,9 +271,13 @@
 	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISON, 9, 0,NULL,1);
 
 	/* enable backlight */
+#ifdef CONFIG_MACH_OMAP_FSAMPLE
+    fsample_cpld_set(FSAMPLE_CPLD_BIT_BACKLIGHT);
+#else
 	omap_set_gpio_direction(134, 0);
 	omap_set_gpio_dataout(134, 1);
-
+#endif
+    
 	DBGLEAVE(1);
 	return 0;
 }
--- linux-omap-2.6/include/asm-arm/arch-omap/board-fsample.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-omap-fsample/include/asm-arm/arch-omap/board-fsample.h	2006-03-01 16:30:11.000000000 -0800
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
--- linux-omap-2.6/include/asm-arm/arch-omap/hardware.h	2006-02-27 12:13:17.000000000 -0800
+++ linux-omap-fsample/include/asm-arm/arch-omap/hardware.h	2006-03-02 14:41:50.000000000 -0800
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

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv--
