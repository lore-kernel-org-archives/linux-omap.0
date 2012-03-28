From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] RTC: twl6030: correct usage of static register while reading time
Date: Wed, 28 Mar 2012 16:34:01 -0500
Message-ID: <1332970441-3495-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42974 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932249Ab2C1Vcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 17:32:33 -0400
Received: by obhx4 with SMTP id x4so3373156obh.16
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 14:32:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: Nishanth Menon <nm@ti.com>, Konstantin Shlyakhovoy <x0155534@ti.com>, Alessandro Zummo <a.zummo@towertech.it>, Benoit Cousson <b-cousson@ti.com>, linux-omap <linux-omap@vger.kernel.org>

From: Konstantin Shlyakhovoy <x0155534@ti.com>

RTC stores time and date in several registers. Due to the fact that
these registers can't be read instantaneously, there is a chance
that reading from counting registers gives an error of one minute,
one hour, one day, etc.

To address this issue, the RTC has hardware support to copy the
RTC counting registers to static shadowed registers.
The current implementation does not use this feature, and in a
stress test,  we can reproduce this error at a rate of around
two times per 300000 readings.

Fix the implementation to ensure that the right snapshot of time
is captured.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>
Acked-by: Mykola Oleksiienko <x0174904@ti.com>
Acked-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Acked-by: Graeme Gregory <gg@slimlogic.co.uk>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Konstantin Shlyakhovoy <x0155534@ti.com>
---
 drivers/rtc/rtc-twl.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 4c2c6df..258abea 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -112,6 +112,7 @@ static const u8 twl6030_rtc_reg_map[] = {
 #define BIT_RTC_CTRL_REG_TEST_MODE_M             0x10
 #define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        0x20
 #define BIT_RTC_CTRL_REG_GET_TIME_M              0x40
+#define BIT_RTC_CTRL_REG_RTC_V_OPT               0x80
 
 /* RTC_STATUS_REG bitfields */
 #define BIT_RTC_STATUS_REG_RUN_M                 0x02
@@ -235,25 +236,57 @@ static int twl_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	unsigned char rtc_data[ALL_TIME_REGS + 1];
 	int ret;
 	u8 save_control;
+	u8 rtc_control;
 
 	ret = twl_rtc_read_u8(&save_control, REG_RTC_CTRL_REG);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "%s: reading CTRL_REG, error %d\n", __func__, ret);
 		return ret;
+	}
+	/* for twl6030/32 make sure BIT_RTC_CTRL_REG_GET_TIME_M is clear */
+	if (twl_class_is_6030()) {
+		if (save_control & BIT_RTC_CTRL_REG_GET_TIME_M) {
+			save_control &= ~BIT_RTC_CTRL_REG_GET_TIME_M;
+			ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+			if (ret < 0) {
+				dev_err(dev, "%s clr GET_TIME, error %d\n",
+					__func__, ret);
+				return ret;
+			}
+		}
+	}
 
-	save_control |= BIT_RTC_CTRL_REG_GET_TIME_M;
+	/* Copy RTC counting registers to static registers or latches */
+	rtc_control = save_control | BIT_RTC_CTRL_REG_GET_TIME_M;
 
-	ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
-	if (ret < 0)
+	/* for twl6030/32 enable read access to static shadowed registers */
+	if (twl_class_is_6030())
+		rtc_control |= BIT_RTC_CTRL_REG_RTC_V_OPT;
+
+	ret = twl_rtc_write_u8(rtc_control, REG_RTC_CTRL_REG);
+	if (ret < 0) {
+		dev_err(dev, "%s: writing CTRL_REG, error %d\n", __func__, ret);
 		return ret;
+	}
 
 	ret = twl_i2c_read(TWL_MODULE_RTC, rtc_data,
 			(rtc_reg_map[REG_SECONDS_REG]), ALL_TIME_REGS);
 
 	if (ret < 0) {
-		dev_err(dev, "rtc_read_time error %d\n", ret);
+		dev_err(dev, "%s: reading data, error %d\n", __func__, ret);
 		return ret;
 	}
 
+	/* for twl6030 restore original state of rtc control register */
+	if (twl_class_is_6030()) {
+		ret = twl_rtc_write_u8(save_control, REG_RTC_CTRL_REG);
+		if (ret < 0) {
+			dev_err(dev, "%s: restore CTRL_REG, error %d\n",
+				__func__, ret);
+			return ret;
+		}
+	}
+
 	tm->tm_sec = bcd2bin(rtc_data[0]);
 	tm->tm_min = bcd2bin(rtc_data[1]);
 	tm->tm_hour = bcd2bin(rtc_data[2]);
-- 
1.7.5.4

