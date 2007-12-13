From: "Girish" <girishsg@ti.com>
Subject: [Resending: PATCH 1/2] driver:twl4030-rtc specific
Date: Thu, 13 Dec 2007 17:46:27 +0530
Message-ID: <009a01c83d81$fc8e0320$988818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

---
 drivers/rtc/rtc-twl4030.c |   41 ++++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 5 deletions(-)

Index: linux-omap-dec10/drivers/rtc/rtc-twl4030.c
===================================================================
--- linux-omap-dec10.orig/drivers/rtc/rtc-twl4030.c	2007-12-13 12:08:18.000000000 +0530
+++ linux-omap-dec10/drivers/rtc/rtc-twl4030.c	2007-12-13 16:24:41.428526658 +0530
@@ -353,6 +353,26 @@
 	return ret;
 }
 
+/*
+ * We will just handle setting the frequency and make use the framework for
+ * reading the periodic interupts.
+ * @freq: Current periodic IRQ freq
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
@@ -364,12 +384,18 @@
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
@@ -456,11 +482,12 @@
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
@@ -486,6 +513,9 @@
 
 	}
 
+	/* Set the irq freq to every second */
+	rtc->irq_freq = 0;
+
 	platform_set_drvdata(pdev, rtc);
 
 	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
@@ -577,6 +607,7 @@
 		pdata->exit();
 
 	rtc_device_unregister(rtc);
+	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
