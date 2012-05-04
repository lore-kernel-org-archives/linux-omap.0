From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH v2 13/14] OMAPDSS: HDMI: Panel: Simplify the name of the HDMI mutex
Date: Thu, 3 May 2012 20:44:07 -0500
Message-ID: <1336095848-6923-14-git-send-email-ricardo.neri@ti.com>
References: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52867 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757111Ab2EDBod (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 21:44:33 -0400
In-Reply-To: <1336095848-6923-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, mythripk@ti.com
Cc: s-chereau@ti.com, x0055901@ti.com, vaibhav.bedia@ti.com, s-guiriec@ti.com, lrg@ti.com, peter.ujfalusi@ti.com, agraf@suse.de, research@ottomaneng.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Ricardo Neri <ricardo.neri@ti.com>

As the hdmi_lock mutex is inside the hdmi struct, rename to simply
"lock". This is only a change in the name. There are not changes
in functionality.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 drivers/video/omap2/dss/hdmi_panel.c |   41 +++++++++++++++++----------------
 1 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 533d5dc..5e215d6 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -30,7 +30,8 @@
 #include "dss.h"
 
 static struct {
-	struct mutex hdmi_lock;
+	/* This protects the panel ops, mainly when accessing the HDMI IP. */
+	struct mutex lock;
 } hdmi;
 
 
@@ -59,7 +60,7 @@ static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 	int r = 0;
 	DSSDBG("ENTER hdmi_panel_enable\n");
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
 		r = -EINVAL;
@@ -75,28 +76,28 @@ static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 err:
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 
 	return r;
 }
 
 static void hdmi_panel_disable(struct omap_dss_device *dssdev)
 {
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		omapdss_hdmi_display_disable(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
 
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 }
 
 static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
 		r = -EINVAL;
@@ -108,7 +109,7 @@ static int hdmi_panel_suspend(struct omap_dss_device *dssdev)
 	omapdss_hdmi_display_disable(dssdev);
 
 err:
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 
 	return r;
 }
@@ -117,7 +118,7 @@ static int hdmi_panel_resume(struct omap_dss_device *dssdev)
 {
 	int r = 0;
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_SUSPENDED) {
 		r = -EINVAL;
@@ -133,7 +134,7 @@ static int hdmi_panel_resume(struct omap_dss_device *dssdev)
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 err:
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 
 	return r;
 }
@@ -141,11 +142,11 @@ err:
 static void hdmi_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	*timings = dssdev->panel.timings;
 
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 }
 
 static void hdmi_set_timings(struct omap_dss_device *dssdev,
@@ -153,12 +154,12 @@ static void hdmi_set_timings(struct omap_dss_device *dssdev,
 {
 	DSSDBG("hdmi_set_timings\n");
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	dssdev->panel.timings = *timings;
 	omapdss_hdmi_display_set_timing(dssdev);
 
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 }
 
 static int hdmi_check_timings(struct omap_dss_device *dssdev,
@@ -168,11 +169,11 @@ static int hdmi_check_timings(struct omap_dss_device *dssdev,
 
 	DSSDBG("hdmi_check_timings\n");
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	r = omapdss_hdmi_display_check_timing(dssdev, timings);
 
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 	return r;
 }
 
@@ -180,7 +181,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 {
 	int r;
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
 		r = omapdss_hdmi_display_enable(dssdev);
@@ -194,7 +195,7 @@ static int hdmi_read_edid(struct omap_dss_device *dssdev, u8 *buf, int len)
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
 		omapdss_hdmi_display_disable(dssdev);
 err:
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 
 	return r;
 }
@@ -203,7 +204,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 {
 	int r;
 
-	mutex_lock(&hdmi.hdmi_lock);
+	mutex_lock(&hdmi.lock);
 
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE) {
 		r = omapdss_hdmi_display_enable(dssdev);
@@ -217,7 +218,7 @@ static bool hdmi_detect(struct omap_dss_device *dssdev)
 			dssdev->state == OMAP_DSS_DISPLAY_SUSPENDED)
 		omapdss_hdmi_display_disable(dssdev);
 err:
-	mutex_unlock(&hdmi.hdmi_lock);
+	mutex_unlock(&hdmi.lock);
 
 	return r;
 }
@@ -242,7 +243,7 @@ static struct omap_dss_driver hdmi_driver = {
 
 int hdmi_panel_init(void)
 {
-	mutex_init(&hdmi.hdmi_lock);
+	mutex_init(&hdmi.lock);
 
 	omap_dss_register_driver(&hdmi_driver);
 
-- 
1.7.5.4

