From: Archit Taneja <archit@ti.com>
Subject: [PATCH 19/23] OMAPDSS/OMAPFB: Change dssdev->manager references
Date: Tue, 21 Aug 2012 11:28:26 +0530
Message-ID: <1345528711-27801-20-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753302Ab2HUGBb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:01:31 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

To retrieve the manager pointer via a device, we need to now access it via the
output to which the device is connected. Make this change in the places where
such a reference is made.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/display.c         |   11 +++++++++--
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 5bd957e..07fd1c7 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -349,8 +349,15 @@ void dss_uninit_device(struct platform_device *pdev,
 	while ((attr = display_sysfs_attrs[i++]) != NULL)
 		device_remove_file(&dssdev->dev, attr);
 
-	if (dssdev->manager)
-		dssdev->manager->unset_device(dssdev->manager);
+	if (dssdev->output) {
+		if (dssdev->output->manager) {
+			struct omap_overlay_manager *mgr =
+					dssdev->output->manager;
+
+			mgr->unset_output(mgr);
+		}
+		dssdev->output->unset_device(dssdev->output);
+	}
 }
 
 static int dss_suspend_device(struct device *dev, void *data)
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index c6cf372..25c0097 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -786,12 +786,12 @@ int omapfb_ioctl(struct fb_info *fbi, unsigned int cmd, unsigned long arg)
 
 	case OMAPFB_WAITFORVSYNC:
 		DBG("ioctl WAITFORVSYNC\n");
-		if (!display) {
+		if (!display && !display->output && !display->output->manager) {
 			r = -EINVAL;
 			break;
 		}
 
-		r = display->manager->wait_for_vsync(display->manager);
+		r = display->output->manager->wait_for_vsync(display->output->manager);
 		break;
 
 	case OMAPFB_WAITFORGO:
-- 
1.7.9.5

