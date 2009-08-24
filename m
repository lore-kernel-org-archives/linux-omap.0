From: charu@ti.com
Subject: [PATCH v2 2/4] RTC MSECURE: msecure initialization
Date: Mon, 24 Aug 2009 20:37:14 +0530
Message-ID: <1251126434-27191-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43341 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZHXPHX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 11:07:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

rtc-twlcore.c does initialisation of the msecure gpio pin.
Board files indicate msecure gpio line through twl4030 platform data.
twl4030-core.c passes this information to RTC driver.
Board files does msecure gpio mux configuration.

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/rtc/rtc-twl4030.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index 9c8c70c..be72253 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -29,7 +29,7 @@
 #include <linux/interrupt.h>
 
 #include <linux/i2c/twl4030.h>
-
+#include <linux/gpio.h>
 
 /*
  * RTC block register offsets (use TWL_MODULE_RTC)
@@ -86,6 +86,37 @@
 /*----------------------------------------------------------------------*/
 
 /*
+ * msecure line initialisation for TWL4030 RTC registers write access
+ */
+static int msecure_init(struct twl4030_rtc_platform_data *pdata)
+{
+	int ret = 0;
+	if (pdata == NULL)
+		goto out;
+
+	ret = gpio_request(pdata->msecure_gpio, "msecure");
+	if (ret) {
+		pr_err("twl4030_rtc: can't reserve msecure GPIO:%d !\n"
+			"RTC functionality will not be available\n",
+			pdata->msecure_gpio);
+		goto out;
+	}
+	/*
+	 * TWL4030 will be in secure mode if msecure line from OMAP is low.
+	 * Make msecure line high in order to change the TWL4030 RTC time
+	 * and calender registers.
+	 */
+	ret = gpio_direction_output(pdata->msecure_gpio, 1);
+	if (ret)
+		pr_err("twl4030_rtc: can't set msecure GPIO direction:%d !\n"
+			"RTC functionality will not be available\n",
+			pdata->msecure_gpio);
+
+out:
+	return ret;
+}
+
+/*
  * Supports 1 byte read from TWL4030 RTC register.
  */
 static int twl4030_rtc_read_u8(u8 *data, u8 reg)
@@ -390,6 +421,7 @@ static struct rtc_class_ops twl4030_rtc_ops = {
 static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 {
 	struct rtc_device *rtc;
+	struct twl4030_rtc_platform_data *pdata = pdev->dev.platform_data;
 	int ret = 0;
 	int irq = platform_get_irq(pdev, 0);
 	u8 rd_reg;
@@ -397,6 +429,10 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	if (irq <= 0)
 		return -EINVAL;
 
+	ret = msecure_init(pdata);
+	if (ret)
+		goto out0;
+
 	rtc = rtc_device_register(pdev->name,
 				  &pdev->dev, &twl4030_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc)) {
-- 
1.6.0.4

