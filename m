From: "Girish" <girishsg@ti.com>
Subject: [Resending PATCH 2/2] ARM: OMAP2: RTC board specific code: rebased
Date: Wed, 12 Mar 2008 16:18:11 +0530
Message-ID: <000301c8842e$920fa500$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52967 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751558AbYCLKsX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2008 06:48:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

This patch adds rtc-twl4030 board specific code for 3430.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   16 +++++++-
 arch/arm/mach-omap2/board-3430sdp.c     |   61 ++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

Index: linux-omap-git-20080128/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git-20080128.orig/arch/arm/configs/omap_3430sdp_defconfig	2008-01-26 04:27:28.000000000 +0530
+++ linux-omap-git-20080128/arch/arm/configs/omap_3430sdp_defconfig	2008-03-12 15:06:14.034349437 +0530
@@ -697,8 +697,22 @@
 # MMC/SD Host Controller Drivers
 #
 CONFIG_MMC_OMAP_HS=y
+
+#
+# RTC interface
+#
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+
+#
+# I2C RTC driver
+#
+CONFIG_RTC_DRV_TWL4030=y
 
 #
 # DMA Engine support
Index: linux-omap-git-20080128/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-git-20080128.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-01-26 04:27:28.000000000 +0530
+++ linux-omap-git-20080128/arch/arm/mach-omap2/board-3430sdp.c	2008-03-12 14:50:03.504899960 +0530
@@ -37,9 +37,11 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
+#include <asm/arch/twl4030-rtc.h>
 
 #include <asm/io.h>
 #include <asm/delay.h>
+#include <asm/arch/control.h>
 
 #define	SDP3430_SMC91X_CS	3
 
@@ -47,6 +49,8 @@
 #define ENABLE_VAUX3_DEV_GRP	0x20
 
 
+#define TWL4030_MSECURE_GPIO	22
+
 static struct resource sdp3430_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP34XX_ETHR_START,
@@ -117,6 +121,60 @@
 	},
 };
 
+#ifdef CONFIG_RTC_DRV_TWL4030
+static int twl4030_rtc_init(void)
+{
+	int ret = 0;
+
+	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
+	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
+		int mux_mask = 0x04;
+		u16 tmp;
+
+		ret = omap_request_gpio(TWL4030_MSECURE_GPIO);
+		if (ret < 0) {
+			printk(KERN_ERR "twl4030_rtc_init: can't"
+				"reserve GPIO:%d !\n", TWL4030_MSECURE_GPIO);
+			goto out;
+		}
+		/*
+		 * TWL4030 will be in secure mode if msecure line from OMAP
+		 * is low. Make msecure line high in order to change the
+		 * TWL4030 RTC time and calender registers.
+		 */
+		omap_set_gpio_direction(TWL4030_MSECURE_GPIO, 0);
+
+		tmp = omap_readw(msecure_pad_config_reg);
+		tmp &= 0xF8;	/* To enable mux mode 03/04 = GPIO_RTC */
+		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
+		omap_writew(tmp, msecure_pad_config_reg);
+
+		omap_set_gpio_dataout(TWL4030_MSECURE_GPIO, 1);
+	}
+out:
+	return ret;
+}
+
+static void twl4030_rtc_exit(void)
+{
+	omap_free_gpio(TWL4030_MSECURE_GPIO);
+}
+
+static struct twl4030rtc_platform_data sdp3430_twl4030rtc_data = {
+	.init = &twl4030_rtc_init,
+	.exit = &twl4030_rtc_exit,
+};
+
+static struct platform_device sdp3430_twl4030rtc_device = {
+	.name		= "twl4030_rtc",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &sdp3430_twl4030rtc_data,
+	},
+};
+#endif
+
 /**
  * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
  *
@@ -207,6 +265,9 @@
 	&sdp3430_smc91x_device,
 	&sdp3430_kp_device,
 	&sdp3430_lcd_device,
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&sdp3430_twl4030rtc_device,
+#endif
 };
 
 static inline void __init sdp3430_init_smc91x(void)

