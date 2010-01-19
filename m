From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH/USB 01/16] USB: musb: use resource_size()
Date: Tue, 19 Jan 2010 15:14:00 +0200
Message-ID: <1263906855-28341-2-git-send-email-felipe.balbi@nokia.com>
References: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27316 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab0ASNO6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 08:14:58 -0500
In-Reply-To: <1263906855-28341-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com

it makes ioremap() usage looks cleaner.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/musb/musb_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5eb9318..1927fa9 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2134,7 +2134,7 @@ static int __init musb_probe(struct platform_device *pdev)
 	if (!iomem || irq == 0)
 		return -ENODEV;
 
-	base = ioremap(iomem->start, iomem->end - iomem->start + 1);
+	base = ioremap(iomem->start, resource_size(iomem));
 	if (!base) {
 		dev_err(dev, "ioremap failed\n");
 		return -ENOMEM;
-- 
1.6.6.rc0

