From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 20/23] OMAPDSS: MANAGER: Update display sysfs store
Date: Thu, 30 Aug 2012 17:10:42 +0530
Message-ID: <1346326845-16583-21-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34309 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab2H3Lna (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:43:30 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The display sysfs attribute's store function needs to be changed with the
introduction of outputs.

Providing a manager to the display isn't enough to create a link now, the
manager needs and output to connect to. A manager's display store file only
has the information of the manager and the desired display, it is not aware
of which output should the manager connect to.

Because of this, a new constraint needs to be set up when setting a display via
this sysfs file. The constraint is that the desired display should already be
connected to an output before calling this sysfs function.

This might break some existing user space stuff which uses sysfs directly. But
in most cases dss_recheck_connections will connect displays to floating outputs.
DSS sysfs files are being planned to be remove anyway, so it's not much of a
harm.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/manager.c |   25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index fd39f66..d808ce2 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -74,18 +74,33 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (dssdev)
 		DSSDBG("display %s found\n", dssdev->name);
 
-	if (mgr->get_device(mgr)) {
-		r = mgr->unset_device(mgr);
+	if (mgr->output) {
+		if (mgr->output->device) {
+			r = mgr->output->unset_device(mgr->output);
+			if (r) {
+				goto put_device;
+				DSSERR("failed to unset device from output\n");
+			}
+		}
+
+		r = mgr->unset_output(mgr);
 		if (r) {
-			DSSERR("failed to unset display\n");
+			DSSERR("failed to unset current output\n");
 			goto put_device;
 		}
 	}
 
 	if (dssdev) {
-		r = mgr->set_device(mgr, dssdev);
+		struct omap_dss_output *out = dssdev->output;
+
+		if (!out) {
+			DSSERR("no output connected to device\n");
+			goto put_device;
+		}
+
+		r = mgr->set_output(mgr, out);
 		if (r) {
-			DSSERR("failed to set manager\n");
+			DSSERR("failed to set manager output\n");
 			goto put_device;
 		}
 
-- 
1.7.9.5

