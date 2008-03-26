From: =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>
Subject: [PATCH] OMAPFB: Check in suspend/resume if framebuffer device is initialized.
Date: Wed, 26 Mar 2008 13:58:09 +0200
Message-ID: <1206532689-11902-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30614 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797AbYCZL67 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Mar 2008 07:58:59 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m2QBwIsX027073
	for <linux-omap@vger.kernel.org>; Wed, 26 Mar 2008 13:58:56 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Check wether fbdev is NULL in suspend / resume functions. Fbdev is
NULL, if there is no lcd or it is not enabled in configuration.
---
 drivers/video/omap/omapfb_main.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index f66b81a..139c84c 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -1839,8 +1839,8 @@ static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
-	omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
-
+	if (fbdev != NULL)
+		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
 	return 0;
 }
 
@@ -1849,7 +1849,8 @@ static int omapfb_resume(struct platform_device *pdev)
 {
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
-	omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
+	if (fbdev != NULL)
+		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
 	return 0;
 }
 
-- 
1.5.3.5

