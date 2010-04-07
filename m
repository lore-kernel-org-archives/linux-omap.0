From: felipe.balbi@nokia.com
Subject: [RFC PATCH 22/37] cbus: tahvo: don't assign ret inside if ()
Date: Wed,  7 Apr 2010 19:04:13 +0300
Message-ID: <1270656268-7034-23-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58470 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621Ab0DGQFP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:15 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G4kcG004699
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:12 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

change codying style, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index e14108f..fc25a89 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -340,7 +340,8 @@ static int __devinit tahvo_probe(struct device *dev)
 		return -ENODEV;
 	}
 
-	if ((ret = gpio_request(tahvo_irq_pin, "TAHVO irq")) < 0) {
+	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
+	if (ret) {
 		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
@@ -424,10 +425,12 @@ static int __init tahvo_init(void)
 
 	init_completion(&device_release);
 
-	if ((ret = driver_register(&tahvo_driver)) < 0)
+	ret = driver_register(&tahvo_driver);
+	if (ret)
 		return ret;
 
-	if ((ret = platform_device_register(&tahvo_device)) < 0) {
+	ret = platform_device_register(&tahvo_device);
+	if (ret) {
 		driver_unregister(&tahvo_driver);
 		return ret;
 	}
-- 
1.7.0.rc0.33.g7c3932

