From: Aaro Koskinen <Aaro.Koskinen@nokia.com>
Subject: [PATCH 2/2] twl4030-madc: Let the operation complete faster
Date: Fri, 20 Feb 2009 16:13:55 +0200
Message-ID: <1235139235-25838-2-git-send-email-Aaro.Koskinen@nokia.com>
References: <499EB9EB.4050008@nokia.com>
 <1235139235-25838-1-git-send-email-Aaro.Koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:19605 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbZBTOOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Feb 2009 09:14:48 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n1KEEKoi013135
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 08:14:45 -0600
Received: from localhost.localdomain (esdhcp043221.research.nokia.com [172.21.43.221])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n1KEDuh3008912
	for <linux-omap@vger.kernel.org>; Fri, 20 Feb 2009 16:13:57 +0200
In-Reply-To: <1235139235-25838-1-git-send-email-Aaro.Koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

No need to wait before the first read, as the operation is likely
completed already. For timeout 50 milliseconds is an overkill, poll the
register for the duration of 5 milliseconds at maximum.

Also, clear the active flag in case of timeout.

Signed-off-by: Aaro Koskinen <Aaro.Koskinen@nokia.com>
---
 drivers/i2c/chips/twl4030-madc.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-madc.c b/drivers/i2c/chips/twl4030-madc.c
index 8997381..d3e0a7f 100644
--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -246,24 +246,28 @@ static inline void twl4030_madc_start_conversion(struct twl4030_madc_data *madc,
 	}
 }
 
-static void twl4030_madc_wait_conversion_ready_ms(
+static int twl4030_madc_wait_conversion_ready(
 		struct twl4030_madc_data *madc,
-		u8 *time, u8 status_reg)
+		unsigned int timeout_ms, u8 status_reg)
 {
-	u8 reg = 0;
+	unsigned long timeout;
 
+	timeout = jiffies + msecs_to_jiffies(timeout_ms);
 	do {
-		msleep(1);
-		(*time)--;
+		u8 reg;
+
 		reg = twl4030_madc_read(madc, status_reg);
-	} while (((reg & TWL4030_MADC_BUSY) && !(reg & TWL4030_MADC_EOC_SW)) &&
-		  (*time != 0));
+		if (!(reg & TWL4030_MADC_BUSY) && (reg & TWL4030_MADC_EOC_SW))
+			return 0;
+	} while (!time_after(jiffies, timeout));
+
+	return -EAGAIN;
 }
 
 int twl4030_madc_conversion(struct twl4030_madc_request *req)
 {
 	const struct twl4030_madc_conversion_method *method;
-	u8 wait_time, ch_msb, ch_lsb;
+	u8 ch_msb, ch_lsb;
 	int ret;
 
 	if (unlikely(!req))
@@ -310,12 +314,10 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 	the_madc->requests[req->method].active = 1;
 
 	/* Wait until conversion is ready (ctrl register returns EOC) */
-	wait_time = 50;
-	twl4030_madc_wait_conversion_ready_ms(the_madc,
-			&wait_time, method->ctrl);
-	if (wait_time == 0) {
+	ret = twl4030_madc_wait_conversion_ready(the_madc, 5, method->ctrl);
+	if (ret) {
 		dev_dbg(the_madc->dev, "conversion timeout!\n");
-		ret = -EAGAIN;
+		the_madc->requests[req->method].active = 0;
 		goto out;
 	}
 
-- 
1.5.4.3

