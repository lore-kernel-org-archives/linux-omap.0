From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/7] drivers: usb: musb: tusb6010: use resource_size
Date: Thu, 21 Jan 2010 15:33:56 +0200
Message-ID: <1264080838-9452-6-git-send-email-felipe.balbi@nokia.com>
References: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18680 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711Ab0AUNfH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 08:35:07 -0500
In-Reply-To: <1264080838-9452-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

Trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/tusb6010.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 88b587c..ab776a8 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -1118,7 +1118,7 @@ int __init musb_platform_init(struct musb *musb)
 	}
 	musb->sync = mem->start;
 
-	sync = ioremap(mem->start, mem->end - mem->start + 1);
+	sync = ioremap(mem->start, resource_size(mem));
 	if (!sync) {
 		pr_debug("ioremap for sync failed\n");
 		ret = -ENOMEM;
-- 
1.6.6.rc0

