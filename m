From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 06/23] I2C: TWL4030: checkpatch.pl fixes to rtc-twl4030.c
Date: Fri, 11 Apr 2008 11:28:19 +0300
Message-ID: <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40277 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbYDKIaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:08 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TkAw030754
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 03:32:25 -0500
In-Reply-To: <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/rtc/rtc-twl4030.c |   77 +++++++++++++++++++++++---------------------
 1 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index ca026b1..ef0e175 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -1,14 +1,14 @@
 /*
  * drivers/rtc/rtc-twl4030.c
- * 
+ *
  * TWL4030 Real Time Clock interface
- * 
+ *
  * Copyright (C) 2007 MontaVista Software, Inc
  * Author: Alexandre Rusev <source@mvista.com>
  *
  * Based on original TI driver twl4030-rtc.c
  *   Copyright (C) 2006 Texas Instruments, Inc.
- * 
+ *
  * Based on rtc-omap.c
  *   Copyright (C) 2003 MontaVista Software, Inc.
  *   Author: George G. Davis <gdavis@mvista.com> or <source@mvista.com>
@@ -19,7 +19,7 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
- * 
+ *
  */
 
 #include <linux/kernel.h>
@@ -36,12 +36,12 @@
 #include <linux/device.h>
 #include <linux/i2c/twl4030.h>
 #include <linux/i2c/twl4030-rtc.h>
+#include <linux/io.h>
+#include <linux/irq.h>
 
-#include <asm/io.h>
 #include <asm/mach/time.h>
 #include <asm/system.h>
 #include <asm/hardware.h>
-#include <asm/irq.h>
 
 #define ALL_TIME_REGS		6
 
@@ -51,10 +51,10 @@
  */
 static int epoch = 1900;	/* year corresponding to 0x00   */
 
-/* 
- * Supports 1 byte read from TWL4030 RTC register. 
+/*
+ * Supports 1 byte read from TWL4030 RTC register.
  */
-static int twl4030_rtc_read_u8(u8 * data, u8 reg)
+static int twl4030_rtc_read_u8(u8 *data, u8 reg)
 {
 	int ret;
 
@@ -66,7 +66,7 @@ static int twl4030_rtc_read_u8(u8 * data, u8 reg)
 	return ret;
 }
 
-/* 
+/*
  * Supports 1 byte write to TWL4030 RTC registers.
  */
 static int twl4030_rtc_write_u8(u8 data, u8 reg)
@@ -75,13 +75,13 @@ static int twl4030_rtc_write_u8(u8 data, u8 reg)
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_RTC, data, reg);
 	if (ret < 0) {
-		printk(KERN_WARNING "twl4030_rtc: Could not write TWL4030" 
+		printk(KERN_WARNING "twl4030_rtc: Could not write TWL4030"
 		       "register %X - returned %d[%x]\n", reg, ret, ret);
 	}
 	return ret;
 }
 
-/* 
+/*
  * Enables timer or alarm interrupts.
  */
 static int set_rtc_irq_bit(unsigned char bit)
@@ -101,7 +101,7 @@ set_irq_out:
 }
 
 #ifdef CONFIG_PM
-/* 
+/*
  * Read timer or alarm interrupts register.
  */
 static int get_rtc_irq_bit(unsigned char *val)
@@ -112,7 +112,7 @@ static int get_rtc_irq_bit(unsigned char *val)
 	return ret;
 }
 #endif
-/* 
+/*
  * Disables timer or alarm interrupts.
  */
 static int mask_rtc_irq_bit(unsigned char bit)
@@ -123,7 +123,7 @@ static int mask_rtc_irq_bit(unsigned char bit)
 	ret = twl4030_rtc_read_u8(&val, REG_RTC_INTERRUPTS_REG);
 	if (ret < 0)
 		goto mask_irq_out;
-	
+
 	val &= ~bit;
 	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
 
@@ -136,15 +136,15 @@ static int twl4030_rtc_alarm_irq_set_state(struct device *dev, int enabled)
 	int ret;
 
 	/* Allow ints for RTC ALARM updates.  */
-	if (enabled) 
+	if (enabled)
 		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
-	else 
+	else
 		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 
 	return ret;
 }
 
-/* 
+/*
  * Gets current TWL4030 RTC time and date parameters.
  */
 static int get_rtc_time(struct rtc_time *rtc_tm)
@@ -155,7 +155,7 @@ static int get_rtc_time(struct rtc_time *rtc_tm)
 
 	ret = twl4030_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
 	if (ret < 0)
-    		return ret;
+		return ret;
 
 	save_control |= BIT_RTC_CTRL_REG_GET_TIME_M;
 
@@ -182,7 +182,8 @@ static int get_rtc_time(struct rtc_time *rtc_tm)
 	 * Account for differences between how the RTC uses the values
 	 * and how they are defined in a struct rtc_time;
 	 */
-	if ((rtc_tm->tm_year += (epoch - 1900)) <= 69)
+	rtc_tm->tm_year += (epoch - 1900);
+	if (rtc_tm->tm_year <= 69)
 		rtc_tm->tm_year += 100;
 
 	rtc_tm->tm_mon--;
@@ -218,7 +219,7 @@ static int twl4030_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	/* update all the alarm registers in one shot */
 	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, rtc_data,
-			        REG_SECONDS_REG, ALL_TIME_REGS);
+			REG_SECONDS_REG, ALL_TIME_REGS);
 	if (ret < 0) {
 		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
 		goto out;
@@ -232,7 +233,7 @@ out:
 	return ret;
 }
 
-/* 
+/*
  * Gets current TWL4030 RTC alarm time.
  */
 static int get_rtc_alm_time(struct rtc_time *alm_tm)
@@ -258,7 +259,8 @@ static int get_rtc_alm_time(struct rtc_time *alm_tm)
 	 * Account for differences between how the RTC uses the values
 	 * and how they are defined in a struct rtc_time;
 	 */
-	if ((alm_tm->tm_year += (epoch - 1900)) <= 69)
+	alm_tm->tm_year += (epoch - 1900);
+	if (alm_tm->tm_year <= 69)
 		alm_tm->tm_year += 100;
 
 	alm_tm->tm_mon--;
@@ -276,7 +278,7 @@ static int twl4030_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return ret;
 }
 
-/* 
+/*
  * Gets current TWL4030 RTC alarm time.
  */
 static int twl4030_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
@@ -317,11 +319,11 @@ static int twl4030_rtc_irq_set_state(struct device *dev, int enabled)
 	int ret;
 
 	/* Allow ints for RTC updates.  */
-	if (enabled) 
+	if (enabled)
 		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
-	else 
+	else
 		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
-	
+
 	return ret;
 }
 
@@ -342,7 +344,7 @@ static int twl4030_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 	/* update all the alarm registers in one shot */
 	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, alarm_data,
-			        REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
+			REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
 	if (ret) {
 		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
 		goto out;
@@ -398,7 +400,7 @@ static int twl4030_rtc_ioctl(struct device *dev, unsigned int cmd,
 
 	case RTC_EPOCH_READ:
 		return put_user(epoch, (unsigned long *)arg);
-	case RTC_EPOCH_SET:	
+	case RTC_EPOCH_SET:
 		/*
 		 * There were no RTC clocks before 1900.
 		 */
@@ -425,7 +427,7 @@ static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
 	int ret = IRQ_NONE;
 	int res;
 	u8 rd_reg;
-	
+
 	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
@@ -445,12 +447,13 @@ static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
 	if (res)
 		goto out;
 	/*
-	 * Workaround for strange behaviour with T2. Need to write into ISR 
+	 * Workaround for strange behaviour with T2. Need to write into ISR
 	 * register one more time to clear the interrupt. Otherwise, the same
 	 * RTC event generates 2 interrupts in a row.
 	 * (no errata document available)
 	 */
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, PWR_RTC_INT_CLR, REG_PWR_ISR1);
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
+			PWR_RTC_INT_CLR, REG_PWR_ISR1);
 	if (res)
 		goto out;
 
@@ -477,7 +480,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	struct rtc_device *rtc;
 	int ret = 0;
 	u8 rd_reg;
-	
+
 	if (pdata != NULL && pdata->init != NULL) {
 		ret = pdata->init();
 		if (ret < 0)
@@ -520,7 +523,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
 		goto out1;
-	} 
+	}
 
 	/* Check RTC module status, Enable if it is off */
 	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_CTRL_REG);
@@ -550,7 +553,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 		goto out2;
 
 	/* Rising edge detection enabled, needed for RTC alarm */
-	rd_reg |= 0x80;		
+	rd_reg |= 0x80;
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_EDR1);
 	if (ret < 0)
 		goto out2;
@@ -584,7 +587,7 @@ static int __devexit twl4030_rtc_remove(struct platform_device *pdev)
 
 	free_irq(TWL4030_MODIRQ_PWR, rtc);
 
-	if (pdata != NULL && pdata->exit != NULL) 
+	if (pdata != NULL && pdata->exit != NULL)
 		pdata->exit();
 
 	rtc_device_unregister(rtc);
@@ -600,7 +603,7 @@ static void twl4030_rtc_shutdown(struct platform_device *pdev)
 
 #ifdef CONFIG_PM
 
-static unsigned char irqstat = 0;
+static unsigned char irqstat;
 
 static int twl4030_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-- 
1.5.5.23.g2a5fe

