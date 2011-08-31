From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/12] OMAP: DSS2: HDMI: make set_timing saner
Date: Wed, 31 Aug 2011 16:23:14 +0300
Message-ID: <1314797003-17638-4-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59363 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755757Ab1HaNXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:44 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Currently the set_timings code for hdmi is quite strange. The display is
disabled in hdmi_omap4_panel.c before setting timings, and enabled in
hdmi.c after setting the timings. Furthermore, the timings were not
permanent, and disabling and enabling the display would lose them.

This patch makes the set_timings handling a bit better.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c             |   13 +++++++++++--
 drivers/video/omap2/dss/hdmi_omap4_panel.c |    7 +------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index d08096b..8f8ae0e 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1226,11 +1226,20 @@ void omapdss_hdmi_display_set_timing(struct omap_dss_device *dssdev)
 	struct hdmi_cm cm;
 
 	hdmi.custom_set = 1;
+
 	cm = hdmi_get_code(&dssdev->panel.timings);
 	hdmi.code = cm.code;
 	hdmi.mode = cm.mode;
-	omapdss_hdmi_display_enable(dssdev);
-	hdmi.custom_set = 0;
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
+		int r;
+
+		hdmi_power_off(dssdev);
+
+		r = hdmi_power_on(dssdev);
+		if (r)
+			DSSERR("failed to power on device\n");
+	}
 }
 
 int omapdss_hdmi_display_enable(struct omap_dss_device *dssdev)
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
index 7d4f2bd..25d5fb2 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
@@ -161,12 +161,7 @@ static void hdmi_set_timings(struct omap_dss_device *dssdev,
 	mutex_lock(&hdmi.hdmi_lock);
 
 	dssdev->panel.timings = *timings;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
-		/* turn the hdmi off and on to get new timings to use */
-		omapdss_hdmi_display_disable(dssdev);
-		omapdss_hdmi_display_set_timing(dssdev);
-	}
+	omapdss_hdmi_display_set_timing(dssdev);
 
 	mutex_unlock(&hdmi.hdmi_lock);
 }
-- 
1.7.4.1

