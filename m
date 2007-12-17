From: "Girish" <girishsg@ti.com>
Subject: [Resending PATCH 2/2]  arch:omap2:rtc board specific code
Date: Mon, 17 Dec 2007 11:23:02 +0530
Message-ID: <020401c84071$15dff4e0$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch adds rtc-twl4030 board specific code for 3430.

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c     |   62 ++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

Index: linux-omap-dec10/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-dec10.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-12-13 12:12:20.704010830 +0530
+++ linux-omap-dec10/arch/arm/configs/omap_3430sdp_defconfig	2007-12-13 12:13:09.478435605 +0530
@@ -698,7 +698,9 @@
 #
 CONFIG_MMC_OMAP=y
 CONFIG_RTC_LIB=y
-# CONFIG_RTC_CLASS is not set
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_TWL4030=y
+CONFIG_RTC_INTF_DEV=y
 
 #
 # DMA Engine support
Index: linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-dec10.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-12-13 12:12:20.704010830 +0530
+++ linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp.c	2007-12-13 12:13:09.478435605 +0530
@@ -40,9 +40,11 @@
 #include <asm/arch/keypad.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
+#include <asm/arch/twl4030-rtc.h>
 
 #include <asm/io.h>
 #include <asm/delay.h>
+#include "control.h"
 
 #define	SDP3430_FLASH_CS	0
 #define	SDP3430_SMC91X_CS	3
@@ -104,6 +106,8 @@
 	.resource	= &sdp3430_flash_resource,
 };
 
+#define TWL4030_MSECURE_GPIO    22
+
 static struct resource sdp3430_smc91x_resources[] = {
 	[0] = {
 		.start	= OMAP34XX_ETHR_START,
@@ -174,6 +178,60 @@
 	},
 };
 
+#ifdef CONFIG_RTC_DRV_TWL4030
+static int twl4030_rtc_init(void)
+{
+	int ret = 0;
+
+	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
+	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
+		u32 msecure_pad_config_reg = omap2_ctrl_base + 0xA3C;
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
+		tmp &= 0xF8;    /* To enable mux mode 03/04 = GPIO_RTC */
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
+	.name           = "twl4030_rtc",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &sdp3430_twl4030rtc_data,
+	},
+};
+#endif
+
 /**
  * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
  *
@@ -258,6 +316,10 @@
 	&sdp3430_smc91x_device,
 	&sdp3430_flash_device,
 	&sdp3430_kp_device,
+#ifdef CONFIG_RTC_DRV_TWL4030
+	&sdp3430_twl4030rtc_device,
+#endif
+
 };
 
 static inline void __init sdp3430_init_smc91x(void)
