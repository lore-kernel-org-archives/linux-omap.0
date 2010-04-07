From: felipe.balbi@nokia.com
Subject: [RFC PATCH 29/37] cbus: retu-rtc: convert to platform_driver
Date: Wed,  7 Apr 2010 19:04:20 +0300
Message-ID: <1270656268-7034-30-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58501 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932728Ab0DGQFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:25 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58ew004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:23 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

still needs work, but it's now using platform_driver
structure.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index 40a42f1..2947c80 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -355,8 +355,9 @@ static int retu_rtc_init_irq(void)
 }
 
 
-static int __devinit retu_rtc_probe(struct device *dev)
+static int __devinit retu_rtc_probe(struct platform_device *pdev)
 {
+	struct device		*dev = &pdev->dev;
 	int r;
 
 	r = retu_get_status();
@@ -402,8 +403,10 @@ err_unregister_time:
 	return r;
 }
 
-static int __devexit retu_rtc_remove(struct device *dev)
+static int __devexit retu_rtc_remove(struct platform_device *pdev)
 {
+	struct device		*dev = &pdev->dev;
+
 	retu_disable_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCS);
 	retu_free_irq(RETU_INT_RTCA);
@@ -412,14 +415,16 @@ static int __devexit retu_rtc_remove(struct device *dev)
 	device_remove_file(dev, &dev_attr_alarm);
 	device_remove_file(dev, &dev_attr_reset);
 	device_remove_file(dev, &dev_attr_time);
+
 	return 0;
 }
 
-static struct device_driver retu_rtc_driver = {
-	.name		= "retu-rtc",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_rtc_driver = {
 	.probe		= retu_rtc_probe,
 	.remove		= __devexit_p(retu_rtc_remove),
+	.driver		= {
+		.name	= "retu-rtc",
+	},
 };
 
 /* This function provides syncronization with the RTCS interrupt handler */
@@ -434,12 +439,12 @@ static void retu_rtc_barrier(void)
 
 static int __init retu_rtc_init(void)
 {
-	return driver_register(&retu_rtc_driver);
+	return platform_driver_register(&retu_rtc_driver);
 }
 
 static void __exit retu_rtc_exit(void)
 {
-	driver_unregister(&retu_rtc_driver);
+	platform_driver_unregister(&retu_rtc_driver);
 }
 
 module_init(retu_rtc_init);
-- 
1.7.0.rc0.33.g7c3932

