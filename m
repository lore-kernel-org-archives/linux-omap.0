From: felipe.balbi@nokia.com
Subject: [RFC PATCH 17/37] cbus: retu: don't assing ret inside the if ()
Date: Wed,  7 Apr 2010 19:04:08 +0300
Message-ID: <1270656268-7034-18-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58491 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932857Ab0DGQFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:21 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58eo004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:18 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

better coding style.

Change:
	if ((ret = driver_register(&retu_driver)))
into:
	ret = driver_register(&retu_driver);
	if (ret)

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index ae2e691..8382694 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -354,7 +354,8 @@ static int __devinit retu_probe(struct device *dev)
 		return -ENODEV;
 	}
 
-	if ((ret = gpio_request(retu_irq_pin, "RETU irq")) < 0) {
+	ret = gpio_request(retu_irq_pin, "RETU irq");
+	if (ret < 0) {
 		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
@@ -453,13 +454,16 @@ static int __init retu_init(void)
 
 	init_completion(&device_release);
 
-	if ((ret = driver_register(&retu_driver)) < 0)
+	ret = driver_register(&retu_driver);
+	if (ret < 0)
 		return ret;
 
-	if ((ret = platform_device_register(&retu_device)) < 0) {
+	ret = platform_device_register(&retu_device);
+	if (ret < 0) {
 		driver_unregister(&retu_driver);
 		return ret;
 	}
+
 	return 0;
 }
 
-- 
1.7.0.rc0.33.g7c3932

