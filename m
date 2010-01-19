From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 02/16] USB: musb: move two printk to dev_err
Date: Tue, 19 Jan 2010 15:14:01 +0200
Message-ID: <1263906855-28341-3-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27320 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab0ASNO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:58 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

trivial cleanup, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 1927fa9..91c31f2 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1696,7 +1696,7 @@ musb_vbus_store(struct device *dev, struct device_attribute *attr,
 	unsigned long	val;
 
 	if (sscanf(buf, "%lu", &val) < 1) {
-		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
+		dev_err(dev, "Invalid VBUS timeout ms value\n");
 		return -EINVAL;
 	}
 
@@ -1746,7 +1746,7 @@ musb_srp_store(struct device *dev, struct device_attribute *attr,
 
 	if (sscanf(buf, "%hu", &srp) != 1
 			|| (srp != 1)) {
-		printk(KERN_ERR "SRP: Value must be 1\n");
+		dev_err(dev, "SRP: Value must be 1\n");
 		return -EINVAL;
 	}
 
-- 
1.6.6.rc0

