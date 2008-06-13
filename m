From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/4] usb: musb: add MODULE_ALIAS for udev module loading
Date: Fri, 13 Jun 2008 13:04:01 +0300
Message-ID: <1213351443-3336-3-git-send-email-felipe.balbi@nokia.com>
References: <1213351443-3336-1-git-send-email-felipe.balbi@nokia.com>
 <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36006 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756471AbYFMKFl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Jun 2008 06:05:41 -0400
In-Reply-To: <1213351443-3336-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Felipe Balbi <felipe.balbi@nokia.com>

platform drivers should add MODULE_ALIAS for allowing
udev module loading.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 5b92f21..75c3013 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -134,11 +134,13 @@ MODULE_PARM_DESC(debug, "initial debug message level");
 
 #define DRIVER_INFO DRIVER_DESC ", v" MUSB_VERSION
 
-const char musb_driver_name[] = "musb_hdrc";
+#define MUSB_DRIVER_NAME "musb_hdrc"
+const char musb_driver_name[] = MUSB_DRIVER_NAME;
 
 MODULE_DESCRIPTION(DRIVER_INFO);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" MUSB_DRIVER_NAME);
 
 
 /*-------------------------------------------------------------------------*/
-- 
1.5.6.rc1

