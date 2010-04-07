From: felipe.balbi@nokia.com
Subject: [RFC PATCH 28/37] cbus: retu-rtc: remove platform_device code
Date: Wed,  7 Apr 2010 19:04:19 +0300
Message-ID: <1270656268-7034-29-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58500 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932875Ab0DGQFY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:24 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58eu004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:22 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

that comes from retu.c now.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-rtc.c |   33 +--------------------------------
 1 files changed, 1 insertions(+), 32 deletions(-)

diff --git a/drivers/cbus/retu-rtc.c b/drivers/cbus/retu-rtc.c
index f34780b..40a42f1 100644
--- a/drivers/cbus/retu-rtc.c
+++ b/drivers/cbus/retu-rtc.c
@@ -49,16 +49,10 @@ static struct mutex retu_rtc_mutex;
 static u16 retu_rtc_alarm_expired;
 static u16 retu_rtc_reset_occurred;
 
-static DECLARE_COMPLETION(retu_rtc_exited);
 static DECLARE_COMPLETION(retu_rtc_sync);
 
 static void retu_rtc_barrier(void);
 
-static void retu_rtc_device_release(struct device *dev)
-{
-	complete(&retu_rtc_exited);
-}
-
 static ssize_t retu_rtc_time_show(struct device *dev, struct device_attribute *attr,
 				  char *buf)
 {
@@ -428,14 +422,6 @@ static struct device_driver retu_rtc_driver = {
 	.remove		= __devexit_p(retu_rtc_remove),
 };
 
-static struct platform_device retu_rtc_device = {
-	.name		= "retu-rtc",
-	.id		= -1,
-	.dev		= {
-		.release	= retu_rtc_device_release,
-	},
-};
-
 /* This function provides syncronization with the RTCS interrupt handler */
 static void retu_rtc_barrier(void)
 {
@@ -448,29 +434,12 @@ static void retu_rtc_barrier(void)
 
 static int __init retu_rtc_init(void)
 {
-	int ret;
-
-	init_completion(&retu_rtc_exited);
-
-	if ((ret = driver_register(&retu_rtc_driver)) != 0)
-		return ret;
-
-	if ((ret = platform_device_register(&retu_rtc_device)) != 0)
-		goto err_unregister_driver;
-
-	return 0;
-
-err_unregister_driver:
-	driver_unregister(&retu_rtc_driver);
-	return ret;
+	return driver_register(&retu_rtc_driver);
 }
 
 static void __exit retu_rtc_exit(void)
 {
-	platform_device_unregister(&retu_rtc_device);
 	driver_unregister(&retu_rtc_driver);
-
-	wait_for_completion(&retu_rtc_exited);
 }
 
 module_init(retu_rtc_init);
-- 
1.7.0.rc0.33.g7c3932

