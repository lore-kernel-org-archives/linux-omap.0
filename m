From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 1/2] extcon: of: Remove unnecessary function call by using the
 name of device_node
Date: Tue, 18 Mar 2014 21:04:39 +0900
Message-ID: <1395144280-23240-2-git-send-email-cw00.choi@samsung.com>
References: <1395144280-23240-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:37569 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbaCRMEp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Mar 2014 08:04:45 -0400
In-reply-to: <1395144280-23240-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: gregkh@linuxfoundation.org, balbi@ti.com, myungjoo.ham@samsung.com
Cc: kishon@ti.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patch remove unnecessary function call in of_extcon_get_extcon_dev()
by using the name of device_node structure.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/extcon/of_extcon.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/extcon/of_extcon.c b/drivers/extcon/of_extcon.c
index 72173ec..0a29f82 100644
--- a/drivers/extcon/of_extcon.c
+++ b/drivers/extcon/of_extcon.c
@@ -32,7 +32,6 @@ struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
 {
 	struct device_node *node;
 	struct extcon_dev *edev;
-	struct platform_device *extcon_parent_dev;
 
 	if (!dev->of_node) {
 		dev_dbg(dev, "device does not have a device node entry\n");
@@ -46,16 +45,9 @@ struct extcon_dev *of_extcon_get_extcon_dev(struct device *dev, int index)
 		return ERR_PTR(-ENODEV);
 	}
 
-	extcon_parent_dev = of_find_device_by_node(node);
-	if (!extcon_parent_dev) {
-		dev_dbg(dev, "unable to find device by node\n");
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
-	edev = extcon_get_extcon_dev(dev_name(&extcon_parent_dev->dev));
+	edev = extcon_get_extcon_dev(node->name);
 	if (!edev) {
-		dev_dbg(dev, "unable to get extcon device : %s\n",
-				dev_name(&extcon_parent_dev->dev));
+		dev_dbg(dev, "unable to get extcon device : %s\n", node->name);
 		return ERR_PTR(-ENODEV);
 	}
 
-- 
1.8.0

