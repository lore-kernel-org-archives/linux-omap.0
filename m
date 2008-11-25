From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: [PATCH] omapfb: Fix argument of blank operation.
Date: Tue, 25 Nov 2008 21:24:12 +0200
Message-ID: <1227641052-6510-1-git-send-email-felipe.contreras@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38905 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbYKYTYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 14:24:39 -0500
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAPJOUqr003705
	for <linux-omap@vger.kernel.org>; Tue, 25 Nov 2008 13:24:37 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Contreras <felipe.contreras@nokia.com>

The blank operation should receive FB_BLANK_POWERDOWN, not
VESA_POWERDOWN.

Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
---
 drivers/video/omap/omapfb_main.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap/omapfb_main.c b/drivers/video/omap/omapfb_main.c
index 3bb4247..c8db8b2 100644
--- a/drivers/video/omap/omapfb_main.c
+++ b/drivers/video/omap/omapfb_main.c
@@ -348,7 +348,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 
 	omapfb_rqueue_lock(fbdev);
 	switch (blank) {
-	case VESA_NO_BLANKING:
+	case FB_BLANK_UNBLANK:
 		if (fbdev->state == OMAPFB_SUSPENDED) {
 			if (fbdev->ctrl->resume)
 				fbdev->ctrl->resume();
@@ -359,7 +359,7 @@ static int omapfb_blank(int blank, struct fb_info *fbi)
 				do_update = 1;
 		}
 		break;
-	case VESA_POWERDOWN:
+	case FB_BLANK_POWERDOWN:
 		if (fbdev->state == OMAPFB_ACTIVE) {
 			fbdev->panel->disable(fbdev->panel);
 			if (fbdev->ctrl->suspend)
@@ -1842,7 +1842,7 @@ static int omapfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	if (fbdev != NULL)
-		omapfb_blank(VESA_POWERDOWN, fbdev->fb_info[0]);
+		omapfb_blank(FB_BLANK_POWERDOWN, fbdev->fb_info[0]);
 	return 0;
 }
 
@@ -1852,7 +1852,7 @@ static int omapfb_resume(struct platform_device *pdev)
 	struct omapfb_device *fbdev = platform_get_drvdata(pdev);
 
 	if (fbdev != NULL)
-		omapfb_blank(VESA_NO_BLANKING, fbdev->fb_info[0]);
+		omapfb_blank(FB_BLANK_UNBLANK, fbdev->fb_info[0]);
 	return 0;
 }
 
-- 
1.6.0.4

