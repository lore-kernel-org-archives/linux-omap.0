From: "Girish" <girishsg@ti.com>
Subject: [PATCH] twl4030-rtc support on 3430
Date: Mon, 10 Dec 2007 18:40:43 +0530
Message-ID: <01ee01c83b2e$1277e1c0$988818ac@ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,
This patch supports TWL4030 RTC on 3430 and adds periodic interrupts functionality through framework. Also, some code cleanup.

Regards,
Girish


---
 arch/arm/configs/omap_3430sdp_defconfig |    4 +-
 arch/arm/mach-omap2/board-3430sdp.c     |   62 ++++++++++++++++++++++++++++++++
 drivers/rtc/rtc-twl4030.c               |   46 +++++++++++++++++++++--
 3 files changed, 106 insertions(+), 6 deletions(-)

Index: linux-omap-dec10/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-dec10.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-12-10 11:20:37.000000000 +0530
+++ linux-omap-dec10/arch/arm/configs/omap_3430sdp_defconfig	2007-12-10 12:06:07.992689883 +0530
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
--- linux-omap-dec10.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-12-10 11:20:37.000000000 +0530
+++ linux-omap-dec10/arch/arm/mach-omap2/board-3430sdp.c	2007-12-10 12:06:07.992689883 +0530
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
Index: linux-omap-dec10/drivers/rtc/rtc-twl4030.c
===================================================================
--- linux-omap-dec10.orig/drivers/rtc/rtc-twl4030.c	2007-12-10 11:20:43.000000000 +0530
+++ linux-omap-dec10/drivers/rtc/rtc-twl4030.c	2007-12-10 12:06:07.992689883 +0530
@@ -353,6 +353,31 @@
 	return ret;
 }
 
+/*
+ * We will just handle setting the frequency and make use the framework for
+ * reading the periodic interupts.
+ *
+ * @freq: Current periodic IRQ freq:
+ * 		bit 0: every second
+ * 		bit 1: every minute
+ * 		bit 2: every hour
+ * 		bit 3: every day
+ */
+static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
+{
+	struct rtc_device *rtc = dev_get_drvdata(dev);
+
+	if (freq < 0 || freq > 3)
+		return -EINVAL;
+
+	rtc->irq_freq = freq;
+
+	/* set rtc irq freq to user defined value */
+	set_rtc_irq_bit(freq);
+
+	return 0;
+}
+
 #ifdef	CONFIG_RTC_INTF_DEV
 
 static int twl4030_rtc_ioctl(struct device *dev, unsigned int cmd,
@@ -364,12 +389,18 @@
 		return twl4030_rtc_alarm_irq_set_state(dev, 0);
 	case RTC_AIE_ON:
 		return twl4030_rtc_alarm_irq_set_state(dev, 1);
+
 	case RTC_UIE_OFF:
+		/* Fall Through */
+	case RTC_PIE_OFF:
 		/* Mask ints from RTC updates.  */
 		return twl4030_rtc_irq_set_state(dev, 0);
 	case RTC_UIE_ON:
+		/* Fall Through */
+	case RTC_PIE_ON:
 		/* Allow ints for RTC updates.  */
 		return twl4030_rtc_irq_set_state(dev, 1);
+
 	case RTC_EPOCH_READ:
 		return put_user(epoch, (unsigned long *)arg);
 	case RTC_EPOCH_SET:	
@@ -456,11 +487,12 @@
 }
 
 static struct rtc_class_ops twl4030_rtc_ops = {
-	.ioctl = twl4030_rtc_ioctl,
-	.read_time = twl4030_rtc_read_time,
-	.set_time = twl4030_rtc_set_time,
-	.read_alarm = twl4030_rtc_read_alarm,
-	.set_alarm = twl4030_rtc_set_alarm,
+	.ioctl		= twl4030_rtc_ioctl,
+	.read_time	= twl4030_rtc_read_time,
+	.set_time	= twl4030_rtc_set_time,
+	.read_alarm	= twl4030_rtc_read_alarm,
+	.set_alarm	= twl4030_rtc_set_alarm,
+	.irq_set_freq	= twl4030_rtc_irq_set_freq,
 };
 
 static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
@@ -486,6 +518,9 @@
 
 	}
 
+	/* Set the irq freq to every second */
+	rtc->irq_freq = 0;
+
 	platform_set_drvdata(pdev, rtc);
 
 	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
@@ -577,6 +612,7 @@
 		pdata->exit();
 
 	rtc_device_unregister(rtc);
+	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
