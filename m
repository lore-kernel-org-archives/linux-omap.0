From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc5-omap1] rtc-twl4030 cleanup
Date: Thu, 4 Sep 2008 10:24:17 -0700
Message-ID: <200809041024.18572.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:47468 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751447AbYIDRYX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 13:24:23 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Some rtc-twl4030 cleanup, which among other things adds up to
using about 10% less object code:

 - Remove:
    * broken/unfixable "periodic" IRQ support (2^N Hz)
    * duplicated constants in the header file
    * pointless stuff:
       + support for settable epoch
       + memset() calls
       + indirection when reading time and alarm
       + indirection when enabling irqs
    * needless ifdeffery for reading irq enable register
 - IRQ updates:
    * group irq enable/disable utilities together
    * cache irq enable register
    * now disable any old alarm irq before setting alarm
 - Comment updates
    * fix up my copyright attribution (old omap1 code)
    * more correctly describe the rtc mask/set ops
    * have a single place describe the register vs tm_* differences
 - Other:
    * don't support "current" dates in the 20th century
    * switch over to bcd2bin()/bin2bcd()
    * prefer dev_err() and better messages to printk(KERN_ERR...)
    * correct some KERN_WARNING messages (should have been pr_err)
    * whitespace bugs
    * misc

The bugs fixed here are removing "periodic" IRQ support, and
some of the messaging.  Update IRQs still misbehave (two per
second, not one!), and the alarm isn't wake-enabled.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/rtc/rtc-twl4030.c       |  328 +++++++++++---------------------------
 include/linux/i2c/twl4030-rtc.h |   58 ------
 2 files changed, 103 insertions(+), 283 deletions(-)

--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -1,7 +1,5 @@
 /*
- * drivers/rtc/rtc-twl4030.c
- *
- * TWL4030 Real Time Clock interface
+ * rtc-twl4030.c -- TWL4030 Real Time Clock interface
  *
  * Copyright (C) 2007 MontaVista Software, Inc
  * Author: Alexandre Rusev <source@mvista.com>
@@ -12,14 +10,12 @@
  * Based on rtc-omap.c
  *   Copyright (C) 2003 MontaVista Software, Inc.
  *   Author: George G. Davis <gdavis@mvista.com> or <source@mvista.com>
- *
  *   Copyright (C) 2006 David Brownell
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
@@ -46,12 +42,6 @@
 #define ALL_TIME_REGS		6
 
 /*
- * If this driver ever becomes modularised, it will be really nice
- * to make the epoch retain its value across module reload...
- */
-static int epoch = 1900;	/* year corresponding to 0x00   */
-
-/*
  * Supports 1 byte read from TWL4030 RTC register.
  */
 static int twl4030_rtc_read_u8(u8 *data, u8 reg)
@@ -59,10 +49,9 @@ static int twl4030_rtc_read_u8(u8 *data,
 	int ret;
 
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_RTC, data, reg);
-	if (ret < 0) {
-		printk(KERN_WARNING "twl4030_rtc: Could not read TWL4030"
-		       "register %X - returned %d[%x]\n", reg, ret, ret);
-	}
+	if (ret < 0)
+		pr_err("twl4030_rtc: Could not read TWL4030"
+		       "register %X - error %d\n", reg, ret);
 	return ret;
 }
 
@@ -74,68 +63,54 @@ static int twl4030_rtc_write_u8(u8 data,
 	int ret;
 
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_RTC, data, reg);
-	if (ret < 0) {
-		printk(KERN_WARNING "twl4030_rtc: Could not write TWL4030"
-		       "register %X - returned %d[%x]\n", reg, ret, ret);
-	}
+	if (ret < 0)
+		pr_err("twl4030_rtc: Could not write TWL4030"
+		       "register %X - error %d\n", reg, ret);
 	return ret;
 }
 
 /*
- * Enables timer or alarm interrupts.
+ * Cache the value for timer/alarm interrupts register; this is
+ * only changed by callers holding rtc ops lock (or resume).
+ */
+static unsigned char rtc_irq_bits;
+
+/*
+ * Enable timer and/or alarm interrupts.
  */
 static int set_rtc_irq_bit(unsigned char bit)
 {
 	unsigned char val;
 	int ret;
 
-	ret = twl4030_rtc_read_u8(&val, REG_RTC_INTERRUPTS_REG);
-	if (ret < 0)
-		goto set_irq_out;
-
-	val |= bit;
+	val = rtc_irq_bits | bit;
 	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+	if (ret == 0)
+		rtc_irq_bits = val;
 
-set_irq_out:
 	return ret;
 }
 
-#ifdef CONFIG_PM
 /*
- * Read timer or alarm interrupts register.
- */
-static int get_rtc_irq_bit(unsigned char *val)
-{
-	int ret;
-
-	ret = twl4030_rtc_read_u8(val, REG_RTC_INTERRUPTS_REG);
-	return ret;
-}
-#endif
-/*
- * Disables timer or alarm interrupts.
+ * Disable timer and/or alarm interrupts.
  */
 static int mask_rtc_irq_bit(unsigned char bit)
 {
 	unsigned char val;
 	int ret;
 
-	ret = twl4030_rtc_read_u8(&val, REG_RTC_INTERRUPTS_REG);
-	if (ret < 0)
-		goto mask_irq_out;
-
-	val &= ~bit;
+	val = rtc_irq_bits & ~bit;
 	ret = twl4030_rtc_write_u8(val, REG_RTC_INTERRUPTS_REG);
+	if (ret == 0)
+		rtc_irq_bits = val;
 
-mask_irq_out:
 	return ret;
 }
 
-static int twl4030_rtc_alarm_irq_set_state(struct device *dev, int enabled)
+static inline int twl4030_rtc_alarm_irq_set_state(int enabled)
 {
 	int ret;
 
-	/* Allow ints for RTC ALARM updates.  */
 	if (enabled)
 		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 	else
@@ -144,10 +119,28 @@ static int twl4030_rtc_alarm_irq_set_sta
 	return ret;
 }
 
+static inline int twl4030_rtc_irq_set_state(int enabled)
+{
+	int ret;
+
+	if (enabled)
+		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+	else
+		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
+
+	return ret;
+}
+
 /*
  * Gets current TWL4030 RTC time and date parameters.
+ *
+ * The RTC's time/alarm representation is not what gmtime(3) requires
+ * Linux to use:
+ *
+ *  - Months are 1..12 vs Linux 0-11
+ *  - Years are 0..99 vs Linux 1900..N (we assume 21st century)
  */
-static int get_rtc_time(struct rtc_time *rtc_tm)
+static int twl4030_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned char rtc_data[ALL_TIME_REGS + 1];
 	int ret;
@@ -167,26 +160,16 @@ static int get_rtc_time(struct rtc_time 
 			       REG_SECONDS_REG, ALL_TIME_REGS);
 
 	if (ret < 0) {
-		printk(KERN_ERR "twl4030_rtc: twl4030_i2c_read error.\n");
+		dev_err(dev, "rtc_read_time error %d\n", ret);
 		return ret;
 	}
 
-	rtc_tm->tm_sec = BCD2BIN(rtc_data[0]);
-	rtc_tm->tm_min = BCD2BIN(rtc_data[1]);
-	rtc_tm->tm_hour = BCD2BIN(rtc_data[2]);
-	rtc_tm->tm_mday = BCD2BIN(rtc_data[3]);
-	rtc_tm->tm_mon = BCD2BIN(rtc_data[4]);
-	rtc_tm->tm_year = BCD2BIN(rtc_data[5]);
-
-	/*
-	 * Account for differences between how the RTC uses the values
-	 * and how they are defined in a struct rtc_time;
-	 */
-	rtc_tm->tm_year += (epoch - 1900);
-	if (rtc_tm->tm_year <= 69)
-		rtc_tm->tm_year += 100;
-
-	rtc_tm->tm_mon--;
+	tm->tm_sec = bcd2bin(rtc_data[0]);
+	tm->tm_min = bcd2bin(rtc_data[1]);
+	tm->tm_hour = bcd2bin(rtc_data[2]);
+	tm->tm_mday = bcd2bin(rtc_data[3]);
+	tm->tm_mon = bcd2bin(rtc_data[4]) - 1;
+	tm->tm_year = bcd2bin(rtc_data[5]) + 100;
 
 	return ret;
 }
@@ -197,15 +180,12 @@ static int twl4030_rtc_set_time(struct d
 	unsigned char rtc_data[ALL_TIME_REGS + 1];
 	int ret;
 
-	/* Month range is 01..12 */
-	tm->tm_mon++;
-
-	rtc_data[1] = BIN2BCD(tm->tm_sec);
-	rtc_data[2] = BIN2BCD(tm->tm_min);
-	rtc_data[3] = BIN2BCD(tm->tm_hour);
-	rtc_data[4] = BIN2BCD(tm->tm_mday);
-	rtc_data[5] = BIN2BCD(tm->tm_mon);
-	rtc_data[6] = BIN2BCD(tm->tm_year);
+	rtc_data[1] = bin2bcd(tm->tm_sec);
+	rtc_data[2] = bin2bcd(tm->tm_min);
+	rtc_data[3] = bin2bcd(tm->tm_hour);
+	rtc_data[4] = bin2bcd(tm->tm_mday);
+	rtc_data[5] = bin2bcd(tm->tm_mon + 1);
+	rtc_data[6] = bin2bcd(tm->tm_year - 100);
 
 	/* Stop RTC while updating the TC registers */
 	ret = twl4030_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
@@ -217,11 +197,11 @@ static int twl4030_rtc_set_time(struct d
 	if (ret < 0)
 		goto out;
 
-	/* update all the alarm registers in one shot */
+	/* update all the time registers in one shot */
 	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, rtc_data,
 			REG_SECONDS_REG, ALL_TIME_REGS);
 	if (ret < 0) {
-		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
+		dev_err(dev, "rtc_set_time error %d\n", ret);
 		goto out;
 	}
 
@@ -236,7 +216,7 @@ out:
 /*
  * Gets current TWL4030 RTC alarm time.
  */
-static int get_rtc_alm_time(struct rtc_time *alm_tm)
+static int twl4030_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
 {
 	unsigned char rtc_data[ALL_TIME_REGS + 1];
 	int ret;
@@ -244,85 +224,21 @@ static int get_rtc_alm_time(struct rtc_t
 	ret = twl4030_i2c_read(TWL4030_MODULE_RTC, rtc_data,
 			       REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
 	if (ret < 0) {
-		printk(KERN_ERR "twl4030_rtc: twl4030_i2c_read error.\n");
+		dev_err(dev, "rtc_read_alarm error %d\n", ret);
 		return ret;
 	}
 
-	alm_tm->tm_sec = BCD2BIN(rtc_data[0]);
-	alm_tm->tm_min = BCD2BIN(rtc_data[1]);
-	alm_tm->tm_hour = BCD2BIN(rtc_data[2]);
-	alm_tm->tm_mday = BCD2BIN(rtc_data[3]);
-	alm_tm->tm_mon = BCD2BIN(rtc_data[4]);
-	alm_tm->tm_year = BCD2BIN(rtc_data[5]);
-
-	/*
-	 * Account for differences between how the RTC uses the values
-	 * and how they are defined in a struct rtc_time;
-	 */
-	alm_tm->tm_year += (epoch - 1900);
-	if (alm_tm->tm_year <= 69)
-		alm_tm->tm_year += 100;
-
-	alm_tm->tm_mon--;
-
-	return ret;
-}
-
-static int twl4030_rtc_read_time(struct device *dev, struct rtc_time *tm)
-{
-	int ret;
-
-	memset(tm, 0, sizeof(struct rtc_time));
-	ret = get_rtc_time(tm);
-
-	return ret;
-}
-
-/*
- * Gets current TWL4030 RTC alarm time.
- */
-static int twl4030_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
-{
-	int ret;
-	u8 rtc_interrupts_reg = 0;
-
-	/*
-	 * This returns a struct rtc_time. Reading >= 0xc0
-	 * means "don't care" or "match all". Only the tm_hour,
-	 * tm_min, and tm_sec values are filled in.
-	 */
-	memset(&alm->time, 0, sizeof(struct rtc_time));
-	ret = get_rtc_alm_time(&alm->time);
-
-	if (ret)
-		goto out;
-
-	/* Check alarm enabled flag state */
-	ret =
-	    ret | twl4030_i2c_read_u8(TWL4030_MODULE_RTC, &rtc_interrupts_reg,
-				      REG_RTC_INTERRUPTS_REG);
-
-	if (ret)
-		goto out;
+	/* some of these fields may be wildcard/"match all" */
+	alm->time.tm_sec = bcd2bin(rtc_data[0]);
+	alm->time.tm_min = bcd2bin(rtc_data[1]);
+	alm->time.tm_hour = bcd2bin(rtc_data[2]);
+	alm->time.tm_mday = bcd2bin(rtc_data[3]);
+	alm->time.tm_mon = bcd2bin(rtc_data[4]) - 1;
+	alm->time.tm_year = bcd2bin(rtc_data[5]) + 100;
 
-	if ((rtc_interrupts_reg & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M) != 0)
+	/* report cached alarm enable state */
+	if (rtc_irq_bits & BIT_RTC_INTERRUPTS_REG_IT_ALARM_M)
 		alm->enabled = 1;
-	else
-		alm->enabled = 0;
-
-out:
-	return ret;
-}
-
-static int twl4030_rtc_irq_set_state(struct device *dev, int enabled)
-{
-	int ret;
-
-	/* Allow ints for RTC updates.  */
-	if (enabled)
-		ret = set_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
-	else
-		ret = mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 
 	return ret;
 }
@@ -332,86 +248,46 @@ static int twl4030_rtc_set_alarm(struct 
 	unsigned char alarm_data[ALL_TIME_REGS + 1];
 	int ret;
 
-	/* Month range is 01..12 */
-	alm->time.tm_mon++;
+	ret = twl4030_rtc_alarm_irq_set_state(0);
+	if (ret)
+		goto out;
 
-	alarm_data[1] = BIN2BCD(alm->time.tm_sec);
-	alarm_data[2] = BIN2BCD(alm->time.tm_min);
-	alarm_data[3] = BIN2BCD(alm->time.tm_hour);
-	alarm_data[4] = BIN2BCD(alm->time.tm_mday);
-	alarm_data[5] = BIN2BCD(alm->time.tm_mon);
-	alarm_data[6] = BIN2BCD(alm->time.tm_year);
+	alarm_data[1] = bin2bcd(alm->time.tm_sec);
+	alarm_data[2] = bin2bcd(alm->time.tm_min);
+	alarm_data[3] = bin2bcd(alm->time.tm_hour);
+	alarm_data[4] = bin2bcd(alm->time.tm_mday);
+	alarm_data[5] = bin2bcd(alm->time.tm_mon + 1);
+	alarm_data[6] = bin2bcd(alm->time.tm_year - 100);
 
 	/* update all the alarm registers in one shot */
 	ret = twl4030_i2c_write(TWL4030_MODULE_RTC, alarm_data,
 			REG_ALARM_SECONDS_REG, ALL_TIME_REGS);
 	if (ret) {
-		printk(KERN_ERR "twl4030: twl4030_i2c_write error.\n");
+		dev_err(dev, "rtc_set_alarm error %d\n", ret);
 		goto out;
 	}
 
-	ret = twl4030_rtc_alarm_irq_set_state(dev, alm->enabled);
+	if (alm->enabled)
+		ret = twl4030_rtc_alarm_irq_set_state(1);
 out:
 	return ret;
 }
 
-/*
- * We will just handle setting the frequency and make use the framework for
- * reading the periodic interupts.
- * @freq: Current periodic IRQ freq
- */
-static int twl4030_rtc_irq_set_freq(struct device *dev, int freq)
-{
-	struct rtc_device *rtc = dev_get_drvdata(dev);
-
-	if (freq < 0 || freq > 3)
-		return -EINVAL;
-
-	rtc->irq_freq = freq;
-
-	/* set rtc irq freq to user defined value */
-	set_rtc_irq_bit(freq);
-
-	return 0;
-}
-
 #ifdef	CONFIG_RTC_INTF_DEV
 
 static int twl4030_rtc_ioctl(struct device *dev, unsigned int cmd,
 			     unsigned long arg)
 {
-
 	switch (cmd) {
 	case RTC_AIE_OFF:
-		return twl4030_rtc_alarm_irq_set_state(dev, 0);
+		return twl4030_rtc_alarm_irq_set_state(0);
 	case RTC_AIE_ON:
-		return twl4030_rtc_alarm_irq_set_state(dev, 1);
-
+		return twl4030_rtc_alarm_irq_set_state(1);
 	case RTC_UIE_OFF:
-		/* Fall Through */
-	case RTC_PIE_OFF:
-		/* Mask ints from RTC updates.	*/
-		return twl4030_rtc_irq_set_state(dev, 0);
+		return twl4030_rtc_irq_set_state(0);
 	case RTC_UIE_ON:
-		/* Fall Through */
-	case RTC_PIE_ON:
-		/* Allow ints for RTC updates.	*/
-		return twl4030_rtc_irq_set_state(dev, 1);
-
-	case RTC_EPOCH_READ:
-		return put_user(epoch, (unsigned long *)arg);
-	case RTC_EPOCH_SET:
-		/*
-		 * There were no RTC clocks before 1900.
-		 */
-		if (arg < 1900)
-			return -EINVAL;
-
-		if (!capable(CAP_SYS_TIME))
-			return -EACCES;
+		return twl4030_rtc_irq_set_state(1);
 
-		epoch = arg;
-		return 0;
 	default:
 		return -ENOIOCTLCMD;
 	}
@@ -465,7 +341,6 @@ static struct rtc_class_ops twl4030_rtc_
 	.set_time	= twl4030_rtc_set_time,
 	.read_alarm	= twl4030_rtc_read_alarm,
 	.set_alarm	= twl4030_rtc_set_alarm,
-	.irq_set_freq	= twl4030_rtc_irq_set_freq,
 };
 
 static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
@@ -491,9 +366,6 @@ static int __devinit twl4030_rtc_probe(s
 
 	}
 
-	/* Set the irq freq to every second */
-	rtc->irq_freq = 0;
-
 	platform_set_drvdata(pdev, rtc);
 
 	ret = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
@@ -552,6 +424,11 @@ static int __devinit twl4030_rtc_probe(s
 	if (ret < 0)
 		goto out2;
 
+	/* init cached IRQ enable bits */
+	ret = twl4030_rtc_read_u8(&rtc_irq_bits, REG_RTC_INTERRUPTS_REG);
+	if (ret < 0)
+		goto out2;
+
 	return ret;
 
 
@@ -591,8 +468,8 @@ static int __devexit twl4030_rtc_remove(
 
 static void twl4030_rtc_shutdown(struct platform_device *pdev)
 {
-	twl4030_rtc_alarm_irq_set_state(&pdev->dev, 0);
-	twl4030_rtc_irq_set_state(&pdev->dev, 0);
+	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
+			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 }
 
 #ifdef CONFIG_PM
@@ -601,8 +478,9 @@ static unsigned char irqstat;
 
 static int twl4030_rtc_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	get_rtc_irq_bit(&irqstat);
+	irqstat = rtc_irq_bits;
 
+	/* REVISIT alarm may need to wake us from sleep */
 	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M |
 			 BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 	return 0;
@@ -613,19 +491,21 @@ static int twl4030_rtc_resume(struct pla
 	set_rtc_irq_bit(irqstat);
 	return 0;
 }
+
 #else
 #define twl4030_rtc_suspend NULL
 #define twl4030_rtc_resume  NULL
 #endif
 
 MODULE_ALIAS("platform:twl4030_rtc");
+
 static struct platform_driver twl4030rtc_driver = {
-	.probe 		= twl4030_rtc_probe,
-	.remove 	= __devexit_p(twl4030_rtc_remove),
-	.shutdown 	= twl4030_rtc_shutdown,
-	.suspend 	= twl4030_rtc_suspend,
-	.resume 	= twl4030_rtc_resume,
-	.driver 	= {
+	.probe		= twl4030_rtc_probe,
+	.remove		= __devexit_p(twl4030_rtc_remove),
+	.shutdown	= twl4030_rtc_shutdown,
+	.suspend	= twl4030_rtc_suspend,
+	.resume		= twl4030_rtc_resume,
+	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "twl4030_rtc",
 	},
@@ -635,15 +515,13 @@ static int __init twl4030_rtc_init(void)
 {
 	return platform_driver_register(&twl4030rtc_driver);
 }
+module_init(twl4030_rtc_init);
 
 static void __exit twl4030_rtc_exit(void)
 {
 	platform_driver_unregister(&twl4030rtc_driver);
 }
+module_exit(twl4030_rtc_exit);
 
-MODULE_ALIAS("platform:twl4030_rtc");
 MODULE_AUTHOR("Texas Instruments, MontaVista Software");
-MODULE_LICENSE("GPL");;
-
-module_init(twl4030_rtc_init);
-module_exit(twl4030_rtc_exit);
+MODULE_LICENSE("GPL");
--- a/include/linux/i2c/twl4030-rtc.h
+++ b/include/linux/i2c/twl4030-rtc.h
@@ -164,64 +164,6 @@
 #define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
 #define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
 
-/* ALARM_DAYS_REG Fields */
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1            (0x004)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY1_M          (0x00000030)
-/* ALARM_MONTHS_REG Fields */
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0        (0x000)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH0_M      (0x0000000F)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1        (0x004)
-#define BIT_ALARM_MONTHS_REG_ALARM_MONTH1_M      (0x00000010)
-/* ALARM_YEARS_REG Fields */
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0          (0x000)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR0_M        (0x0000000F)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1          (0x004)
-#define BIT_ALARM_YEARS_REG_ALARM_YEAR1_M        (0x000000F0)
-/* RTC_CTRL_REG Fields */
-#define BIT_RTC_CTRL_REG_STOP_RTC                (0x000)
-#define BIT_RTC_CTRL_REG_STOP_RTC_M              (0x00000001)
-#define BIT_RTC_CTRL_REG_ROUND_30S               (0x001)
-#define BIT_RTC_CTRL_REG_ROUND_30S_M             (0x00000002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP               (0x002)
-#define BIT_RTC_CTRL_REG_AUTO_COMP_M             (0x00000004)
-#define BIT_RTC_CTRL_REG_MODE_12_24              (0x003)
-#define BIT_RTC_CTRL_REG_MODE_12_24_M            (0x00000008)
-#define BIT_RTC_CTRL_REG_TEST_MODE               (0x004)
-#define BIT_RTC_CTRL_REG_TEST_MODE_M             (0x00000010)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER          (0x005)
-#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        (0x00000020)
-#define BIT_RTC_CTRL_REG_GET_TIME                (0x006)
-#define BIT_RTC_CTRL_REG_GET_TIME_M              (0x00000040)
-/* RTC_STATUS_REG Fields */
-#define BIT_RTC_STATUS_REG_RUN                   (0x001)
-#define BIT_RTC_STATUS_REG_RUN_M                 (0x00000002)
-#define BIT_RTC_STATUS_REG_1S_EVENT              (0x002)
-#define BIT_RTC_STATUS_REG_1S_EVENT_M            (0x00000004)
-#define BIT_RTC_STATUS_REG_1M_EVENT              (0x003)
-#define BIT_RTC_STATUS_REG_1M_EVENT_M            (0x00000008)
-#define BIT_RTC_STATUS_REG_1H_EVENT              (0x004)
-#define BIT_RTC_STATUS_REG_1H_EVENT_M            (0x00000010)
-#define BIT_RTC_STATUS_REG_1D_EVENT              (0x005)
-#define BIT_RTC_STATUS_REG_1D_EVENT_M            (0x00000020)
-#define BIT_RTC_STATUS_REG_ALARM                 (0x006)
-#define BIT_RTC_STATUS_REG_ALARM_M               (0x00000040)
-#define BIT_RTC_STATUS_REG_POWER_UP              (0x007)
-#define BIT_RTC_STATUS_REG_POWER_UP_M            (0x00000080)
-/* RTC_INTERRUPTS_REG Fields */
-#define BIT_RTC_INTERRUPTS_REG_EVERY             (0x000)
-#define BIT_RTC_INTERRUPTS_REG_EVERY_M           (0x00000003)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER          (0x002)
-#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        (0x00000004)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM          (0x003)
-#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        (0x00000008)
-/* RTC_COMP_LSB_REG Fields */
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB        (0x000)
-#define BIT_RTC_COMP_LSB_REG_RTC_COMP_LSB_M      (0x000000FF)
-/* RTC_COMP_MSB_REG Fields */
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB        (0x000)
-#define BIT_RTC_COMP_MSB_REG_RTC_COMP_MSB_M      (0x000000FF)
-
-
 struct twl4030rtc_platform_data {
 	int (*init)(void);
 	void (*exit)(void);
