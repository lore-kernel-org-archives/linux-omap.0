From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 2/7] remove <linux/i2c/twl4030-rtc.h>
Date: Fri, 3 Oct 2008 08:59:32 -0700
Message-ID: <200810030859.33052.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32618 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752875AbYJCQbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:36 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Remove <linux/i2c/twl4030-rtc.h> by moving all the relevant contents
into the driver itself, and removing the rest.  Stuff removed included
many useless bitmasks, and remnants of the platform data hook.

Add markers inside the rtc driver to split sections apart:  first
data structure declarations, then the RTC driver, then platform bus
glue for it all.

There's still an issue with the twl4030-pwrirq.h registers ... this
driver has no business touching them!  This patch at least switches
away from having private versions of those register definitions, and
removes some unnecessary accesses to them.

No functional changes, just shrinkage.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/rtc/rtc-twl4030.c          |  105 +++++++++++++++------
 include/linux/i2c/twl4030-pwrirq.h |    8 +
 include/linux/i2c/twl4030-rtc.h    |  172 -----------------------------------
 3 files changed, 79 insertions(+), 206 deletions(-)

--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -28,11 +28,63 @@
 #include <linux/interrupt.h>
 
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-rtc.h>
+#include <linux/i2c/twl4030-pwrirq.h>
+
+
+/*
+ * RTC block register offsets (use TWL_MODULE_RTC)
+ */
+#define REG_SECONDS_REG                          0x00
+#define REG_MINUTES_REG                          0x01
+#define REG_HOURS_REG                            0x02
+#define REG_DAYS_REG                             0x03
+#define REG_MONTHS_REG                           0x04
+#define REG_YEARS_REG                            0x05
+#define REG_WEEKS_REG                            0x06
 
+#define REG_ALARM_SECONDS_REG                    0x07
+#define REG_ALARM_MINUTES_REG                    0x08
+#define REG_ALARM_HOURS_REG                      0x09
+#define REG_ALARM_DAYS_REG                       0x0A
+#define REG_ALARM_MONTHS_REG                     0x0B
+#define REG_ALARM_YEARS_REG                      0x0C
+
+#define REG_RTC_CTRL_REG                         0x0D
+#define REG_RTC_STATUS_REG                       0x0E
+#define REG_RTC_INTERRUPTS_REG                   0x0F
+
+#define REG_RTC_COMP_LSB_REG                     0x10
+#define REG_RTC_COMP_MSB_REG                     0x11
 
+/* RTC_CTRL_REG bitfields */
+#define BIT_RTC_CTRL_REG_STOP_RTC_M              0x01
+#define BIT_RTC_CTRL_REG_ROUND_30S_M             0x02
+#define BIT_RTC_CTRL_REG_AUTO_COMP_M             0x04
+#define BIT_RTC_CTRL_REG_MODE_12_24_M            0x08
+#define BIT_RTC_CTRL_REG_TEST_MODE_M             0x10
+#define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        0x20
+#define BIT_RTC_CTRL_REG_GET_TIME_M              0x40
+
+/* RTC_STATUS_REG bitfields */
+#define BIT_RTC_STATUS_REG_RUN_M                 0x02
+#define BIT_RTC_STATUS_REG_1S_EVENT_M            0x04
+#define BIT_RTC_STATUS_REG_1M_EVENT_M            0x08
+#define BIT_RTC_STATUS_REG_1H_EVENT_M            0x10
+#define BIT_RTC_STATUS_REG_1D_EVENT_M            0x20
+#define BIT_RTC_STATUS_REG_ALARM_M               0x40
+#define BIT_RTC_STATUS_REG_POWER_UP_M            0x80
+
+/* RTC_INTERRUPTS_REG bitfields */
+#define BIT_RTC_INTERRUPTS_REG_EVERY_M           0x03
+#define BIT_RTC_INTERRUPTS_REG_IT_TIMER_M        0x04
+#define BIT_RTC_INTERRUPTS_REG_IT_ALARM_M        0x08
+
+
+/* REG_SECONDS_REG through REG_YEARS_REG is how many registers? */
 #define ALL_TIME_REGS		6
 
+/*----------------------------------------------------------------------*/
+
 /*
  * Supports 1 byte read from TWL4030 RTC register.
  */
@@ -315,12 +367,19 @@ static irqreturn_t twl4030_rtc_interrupt
 	if (res)
 		goto out;
 
-	/* Clear on Read enabled. RTC_IT bit of REG_PWR_ISR1 needs
-	 * 2 reads to clear the interrupt. One read is done in
+	/* Clear on Read enabled. RTC_IT bit of TWL4030_INT_PWR_ISR1
+	 * needs 2 reads to clear the interrupt. One read is done in
 	 * do_twl4030_pwrirq(). Doing the second read, to clear
 	 * the bit.
+	 *
+	 * FIXME the reason PWR_ISR1 needs an extra read is that
+	 * RTC_IF retriggered until we cleared REG_ALARM_M above.
+	 * But re-reading like this is a bad hack; by doing so we
+	 * risk wrongly clearing status for some other IRQ (losing
+	 * the interrupt).  Be smarter about handling RTC_UF ...
 	 */
-	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
+	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+			&rd_reg, TWL4030_INT_PWR_ISR1);
 	if (res)
 		goto out;
 
@@ -340,9 +399,10 @@ static struct rtc_class_ops twl4030_rtc_
 	.set_alarm	= twl4030_rtc_set_alarm,
 };
 
+/*----------------------------------------------------------------------*/
+
 static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 {
-	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
 	struct rtc_device *rtc;
 	int ret = 0;
 	int irq = platform_get_irq(pdev, 0);
@@ -351,12 +411,6 @@ static int __devinit twl4030_rtc_probe(s
 	if (irq < 0)
 		return irq;
 
-	if (pdata != NULL && pdata->init != NULL) {
-		ret = pdata->init();
-		if (ret < 0)
-			goto out;
-	}
-
 	rtc = rtc_device_register(pdev->name,
 				  &pdev->dev, &twl4030_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
@@ -405,23 +459,19 @@ static int __devinit twl4030_rtc_probe(s
 			goto out2;
 	}
 
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_IMR1);
-	if (ret < 0)
-		goto out2;
-
-	rd_reg &= PWR_RTC_IT_UNMASK;
-	/* MASK PWR - we will need this */
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_IMR1);
-	if (ret < 0)
-		goto out2;
+	/* FIXME stop touching MODULE_INT registers; there's already
+	 * driver code responsible for them.
+	 */
 
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_EDR1);
+	/* use rising edge detection for RTC alarm */
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_INT,
+			&rd_reg, TWL4030_INT_PWR_EDR1);
 	if (ret < 0)
 		goto out2;
 
-	/* Rising edge detection enabled, needed for RTC alarm */
-	rd_reg |= 0x80;
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT, rd_reg, REG_PWR_EDR1);
+	rd_reg |= BIT(3);
+	ret = twl4030_i2c_write_u8(TWL4030_MODULE_INT,
+			rd_reg, TWL4030_INT_PWR_EDR1);
 	if (ret < 0)
 		goto out2;
 
@@ -438,9 +488,6 @@ out2:
 out1:
 	rtc_device_unregister(rtc);
 out0:
-	if (pdata != NULL && pdata->exit != NULL)
-		pdata->exit();
-out:
 	return ret;
 }
 
@@ -451,7 +498,6 @@ out:
 static int __devexit twl4030_rtc_remove(struct platform_device *pdev)
 {
 	/* leave rtc running, but disable irqs */
-	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
 	int irq = platform_get_irq(pdev, 0);
 
@@ -460,9 +506,6 @@ static int __devexit twl4030_rtc_remove(
 
 	free_irq(irq, rtc);
 
-	if (pdata != NULL && pdata->exit != NULL)
-		pdata->exit();
-
 	rtc_device_unregister(rtc);
 	platform_set_drvdata(pdev, NULL);
 	return 0;
--- a/include/linux/i2c/twl4030-pwrirq.h
+++ b/include/linux/i2c/twl4030-pwrirq.h
@@ -1,5 +1,5 @@
 /*
- * twl4030-gpio.h - header for TWL4030 GPIO module
+ * twl4030-pwrirq.h - header for TWL4030 power interrupts
  *
  * Copyright (C) 2008 Texas Instruments, Inc.
  * Copyright (C) 2008 Nokia Corporation
@@ -24,14 +24,16 @@
 #define __TWL4030_PWRIRQ_H_
 
 /*
- * INT Module Register definitions
- * (not all registers are defined below)
+ * Power Interrupt block register offsets (use TWL4030_MODULE_INT)
  */
 
 #define TWL4030_INT_PWR_ISR1		0x0
 #define TWL4030_INT_PWR_IMR1		0x1
 #define TWL4030_INT_PWR_ISR2		0x2
 #define TWL4030_INT_PWR_IMR2		0x3
+#define TWL4030_INT_PWR_SIR		0x4	/* test register */
+#define TWL4030_INT_PWR_EDR1		0x5
+#define TWL4030_INT_PWR_EDR2		0x6
 #define TWL4030_INT_PWR_SIH_CTRL	0x7
 
 #endif /* End of __TWL4030_PWRIRQ_H */
--- a/include/linux/i2c/twl4030-rtc.h
+++ /dev/null
@@ -1,172 +0,0 @@
-/*
- * include/asm-arm/arch-omap/twl4030-rtc.h
- *
- * Copyright (C) 2006 Texas Instruments, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __TWL4030_RTC_H__
-#define __TWL4030_RTC_H__
-
-#define REG_SECONDS_REG                          (0x0)
-#define REG_MINUTES_REG                          (0x1)
-#define REG_HOURS_REG                            (0x2)
-#define REG_DAYS_REG                             (0x3)
-#define REG_MONTHS_REG                           (0x4)
-#define REG_YEARS_REG                            (0x5)
-#define REG_WEEKS_REG                            (0x6)
-#define REG_ALARM_SECONDS_REG                    (0x7)
-#define REG_ALARM_MINUTES_REG                    (0x8)
-#define REG_ALARM_HOURS_REG                      (0x9)
-#define REG_ALARM_DAYS_REG                       (0xA)
-#define REG_ALARM_MONTHS_REG                     (0xB)
-#define REG_ALARM_YEARS_REG                      (0xC)
-#define REG_RTC_CTRL_REG                         (0xD)
-#define REG_RTC_STATUS_REG                       (0xE)
-#define REG_RTC_INTERRUPTS_REG                   (0xF)
-#define REG_RTC_COMP_LSB_REG                     (0x10)
-#define REG_RTC_COMP_MSB_REG                     (0x11)
-
-/* REVISIT: these TWL4030 power registers are only used
- * by rtc-twl4030 driver, move to an appropriate header
- * if other drivers need the registers
- */
-/* Power registers */
-#define REG_PWR_ISR1		0x00
-#define REG_PWR_IMR1		0x01
-#define REG_PWR_EDR1		0x05
-
-#define PWR_RTC_IT_UNMASK	 ~(0x08)
-#define PWR_RTC_INT_CLR          0x08
-
-/**** BitField Definitions */
-/* SECONDS_REG Fields */
-#define BIT_SECONDS_REG_SEC0                     (0x000)
-#define BIT_SECONDS_REG_SEC0_M                   (0x0000000F)
-#define BIT_SECONDS_REG_SEC1                     (0x004)
-#define BIT_SECONDS_REG_SEC1_M                   (0x00000070)
-/* MINUTES_REG Fields */
-#define BIT_MINUTES_REG_MIN0                     (0x000)
-#define BIT_MINUTES_REG_MIN0_M                   (0x0000000F)
-#define BIT_MINUTES_REG_MIN1                     (0x004)
-#define BIT_MINUTES_REG_MIN1_M                   (0x00000070)
-/* HOURS_REG Fields */
-#define BIT_HOURS_REG_HOUR0                      (0x000)
-#define BIT_HOURS_REG_HOUR0_M                    (0x0000000F)
-#define BIT_HOURS_REG_HOUR1                      (0x004)
-#define BIT_HOURS_REG_HOUR1_M                    (0x00000030)
-#define BIT_HOURS_REG_PM_NAM                     (0x007)
-#define BIT_HOURS_REG_PM_NAM_M                   (0x00000080)
-/* DAYS_REG Fields */
-#define BIT_DAYS_REG_DAY0                        (0x000)
-#define BIT_DAYS_REG_DAY0_M                      (0x0000000F)
-#define BIT_DAYS_REG_DAY1                        (0x004)
-#define BIT_DAYS_REG_DAY1_M                      (0x00000030)
-/* MONTHS_REG Fields */
-#define BIT_MONTHS_REG_MONTH0                    (0x000)
-#define BIT_MONTHS_REG_MONTH0_M                  (0x0000000F)
-#define BIT_MONTHS_REG_MONTH1                    (0x004)
-#define BIT_MONTHS_REG_MONTH1_M                  (0x00000010)
-/* YEARS_REG Fields */
-#define BIT_YEARS_REG_YEAR0                      (0x000)
-#define BIT_YEARS_REG_YEAR0_M                    (0x0000000F)
-#define BIT_YEARS_REG_YEAR1                      (0x004)
-#define BIT_YEARS_REG_YEAR1_M                    (0x000000F0)
-/* WEEKS_REG Fields */
-#define BIT_WEEKS_REG_WEEK                       (0x000)
-#define BIT_WEEKS_REG_WEEK_M                     (0x00000007)
-/* ALARM_SECONDS_REG Fields */
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC0         (0x000)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC0_M       (0x0000000F)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC1         (0x004)
-#define BIT_ALARM_SECONDS_REG_ALARM_SEC1_M       (0x00000070)
-/* ALARM_MINUTES_REG Fields */
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN0         (0x000)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN0_M       (0x0000000F)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN1         (0x004)
-#define BIT_ALARM_MINUTES_REG_ALARM_MIN1_M       (0x00000070)
-/* ALARM_HOURS_REG Fields */
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR0          (0x000)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR0_M        (0x0000000F)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR1          (0x004)
-#define BIT_ALARM_HOURS_REG_ALARM_HOUR1_M        (0x00000030)
-#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM         (0x007)
-#define BIT_ALARM_HOURS_REG_ALARM_PM_NAM_M       (0x00000080)
-/* ALARM_DAYS_REG Fields */
-#define BIT_ALARM_DAYS_REG_ALARM_DAY0            (0x000)
-#define BIT_ALARM_DAYS_REG_ALARM_DAY0_M          (0x0000000F)
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
-
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
-struct twl4030rtc_platform_data {
-	int (*init)(void);
-	void (*exit)(void);
-};
-
-#endif				/* End of __TWL4030_RTC_H__ */
