From: akpm@linux-foundation.org
Subject: [patch 10/14] drivers/rtc/rtc-twl.c: use static register while reading time
Date: Thu, 12 Apr 2012 12:49:15 -0700
Message-ID: <20120412194915.57741A0776@akpm.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qa0-f74.google.com ([209.85.216.74]:52742 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755144Ab2DLTtQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Apr 2012 15:49:16 -0400
Received: by qabg24 with SMTP id g24so311852qab.1
        for <linux-omap@vger.kernel.org>; Thu, 12 Apr 2012 12:49:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, x0155534@ti.com, a.zummo@towertech.it, b-cousson@ti.com, gg@slimlogic.co.uk, linux-omap@vger.kernel.org, nm@ti.com, oleksandr.dmytryshyn@ti.com, x0174904@ti.com

From: Konstantin Shlyakhovoy <x0155534@ti.com>
Subject: drivers/rtc/rtc-twl.c: use static register while reading time

RTC stores time and date in several registers.  Due to the fact that these
registers can't be read instantaneously, there is a chance that reading
from counting registers gives an error of one minute, one hour, one day,
etc.

To address this issue, the RTC has hardware support to copy the RTC
counting registers to static shadowed registers.  The current
implementation does not use this feature, and in a stress test, we can
reproduce this error at a rate of around two times per 300000 readings.

Fix the implementation to ensure that the right snapshot of time is
captured.

Signed-off-by: Konstantin Shlyakhovoy <x0155534@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>
Acked-by: Mykola Oleksiienko <x0174904@ti.com>
Acked-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
Acked-by: Graeme Gregory <gg@slimlogic.co.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/rtc-twl.c |   43 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff -puN drivers/rtc/rtc-twl.c~drivers-rtc-rtc-twlc-use-static-register-while-reading-time drivers/rtc/rtc-twl.c
--- a/drivers/rtc/rtc-twl.c~drivers-rtc-rtc-twlc-use-static-register-while-reading-time
+++ a/drivers/rtc/rtc-twl.c
@@ -112,6 +112,7 @@ static const u8 twl6030_rtc_reg_map[] = 
 #define BIT_RTC_CTRL_REG_TEST_MODE_M             0x10
 #define BIT_RTC_CTRL_REG_SET_32_COUNTER_M        0x20
 #define BIT_RTC_CTRL_REG_GET_TIME_M              0x40
+#define BIT_RTC_CTRL_REG_RTC_V_OPT               0x80
 
 /* RTC_STATUS_REG bitfields */
 #define BIT_RTC_STATUS_REG_RUN_M                 0x02
@@ -235,25 +236,57 @@ static int twl_rtc_read_time(struct devi
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
_
