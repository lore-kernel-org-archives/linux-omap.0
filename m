From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 09/29] OMAPDSS: APPLY: Allow manager set/unset_device ops to set/unset writeback
Date: Tue, 27 Dec 2011 18:06:52 +0530
Message-ID: <1324989432-3625-10-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35279 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0Miz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:55 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Allow dss_mgr_set_device/unset_device to set/unset either display or writeback
based on the dssdev argument passed to the function. Check if the device is a
writeback device by seeing if the wbdev pointer is populated for it or not.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 4624f86..aee0420 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1300,7 +1300,11 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 	}
 
 	dssdev->manager = mgr;
-	mgr->output->device = dssdev;
+
+	if (dssdev->wbdev)
+		mgr->output->writeback = dssdev;
+	else
+		mgr->output->device = dssdev;
 
 	mutex_unlock(&apply_lock);
 
@@ -1318,7 +1322,8 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
 
 	mutex_lock(&apply_lock);
 
-	curr_dssdev = mgr->output->device;
+	curr_dssdev = dssdev->wbdev ? mgr->get_writeback(mgr) :
+			mgr->get_display(mgr);
 
 	if (!curr_dssdev) {
 		DSSERR("failed to unset device, device not set.\n");
@@ -1336,7 +1341,11 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
 	}
 
 	curr_dssdev->manager = NULL;
-	mgr->output->device = NULL;
+
+	if (dssdev->wbdev)
+		mgr->output->writeback = NULL;
+	else
+		mgr->output->device = NULL;
 
 	mutex_unlock(&apply_lock);
 
-- 
1.7.4.1

