From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path
Date: Fri, 28 Aug 2009 15:58:21 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A5EF29FB@dlee06.ent.ti.com>
References: <1250850219-25545-1-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-2-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-3-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-4-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-5-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-6-git-send-email-felipe.balbi@nokia.com>
 <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53065 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751134AbZH1U61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 16:58:27 -0400
In-Reply-To: <1250850219-25545-7-git-send-email-felipe.balbi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Ameya Palande <ameya.palande@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Acked-by: Fernando Guzman Lugo <x0095840@ti.com>


-----Original Message-----
From: Felipe Balbi [mailto:felipe.balbi@nokia.com] 
Sent: Friday, August 21, 2009 5:24 AM
To: Hiroshi DOYU
Cc: Ameya Palande; Guzman Lugo, Fernando; Linux OMAP Mailing List; Felipe Balbi
Subject: [DSPBRIGDE PATCH 6/6] dsp: bridge: beautify erro path

... and get rid of a possible memory leak.

in case of error while adding the chardev, probe()
would not kfree() bridge_device.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/dsp/bridge/rmgr/drv_interface.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
index 559d14a..c37c5a0 100755
--- a/drivers/dsp/bridge/rmgr/drv_interface.c
+++ b/drivers/dsp/bridge/rmgr/drv_interface.c
@@ -324,7 +324,7 @@ static int __init bridge_init(void)
 	if (result < 0) {
 		GT_1trace(driverTrace, GT_7CLASS, "bridge_init: "
 				"Can't get Major %d \n", driver_major);
-		return result;
+		goto err1;
 	}
 
 	driver_major = MAJOR(dev);
@@ -332,19 +332,17 @@ static int __init bridge_init(void)
 	bridge_device = kmalloc(sizeof(struct bridge_dev), GFP_KERNEL);
 	if (!bridge_device) {
 		result = -ENOMEM;
-		unregister_chrdev_region(dev, 1);
-		return result;
+		goto err2;
 	}
 	cdev_init(&bridge_device->cdev, &bridge_fops);
 	bridge_device->cdev.owner = THIS_MODULE;
 	bridge_device->cdev.ops = &bridge_fops;
 
 	status = cdev_add(&bridge_device->cdev, dev, 1);
-
 	if (status) {
 		GT_0trace(driverTrace, GT_7CLASS,
 				"Failed to add the bridge device \n");
-		return status;
+		goto err3;
 	}
 
 	/* udev support */
@@ -474,7 +472,17 @@ static int __init bridge_init(void)
 	DBC_Assert(status == 0);
 	DBC_Assert(DSP_SUCCEEDED(initStatus));
 	GT_0trace(driverTrace, GT_ENTER, " <- driver_init\n");
-	return status;
+
+	return 0;
+
+err3:
+	kfree(bridge_device);
+
+err2:
+	unregister_chrdev_region(dev, 1);
+
+err1:
+	return result;
 }
 
 /*  This function is invoked during unlinking of the bridge module from the
-- 
1.6.3.3.385.g60647


