From: <mythripk@ti.com>
Subject: [PATCH 3/3] OMAPDSS: HDMI: Add option to enable HDMI in HPD mode
Date: Tue, 13 Dec 2011 18:54:58 +0530
Message-ID: <1323782698-24428-4-git-send-email-mythripk@ti.com>
References: <1323782698-24428-1-git-send-email-mythripk@ti.com>
 <1323782698-24428-2-git-send-email-mythripk@ti.com>
 <1323782698-24428-3-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49874 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753515Ab1LMNch (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 08:32:37 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pBDDWYHV030723
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 07:32:36 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pBDDWY6H012437
	for <linux-omap@vger.kernel.org>; Tue, 13 Dec 2011 19:02:34 +0530 (IST)
In-Reply-To: <1323782698-24428-3-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Add option in the panel to enable HDMI in HPD mode to enable the interrupt to
detect cable connect/disconnect, HDMI will be powered on only when the cable is
connected and powered down when cable is disconnected.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 drivers/video/omap2/dss/hdmi_panel.c |   54 ++++++++++++++++++++++++++++++++--
 include/video/omapdss.h              |    1 +
 2 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 533d5dc..0b8a8ac 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
@@ -61,7 +61,7 @@ static int hdmi_panel_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&hdmi.hdmi_lock);
 
-	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE) {
 		r = -EINVAL;
 		goto err;
 	}
@@ -222,11 +222,57 @@ err:
 	return r;
 }
 
+static void hdmi_hpd_disable(struct omap_dss_device *dssdev)
+{
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE ||
+		dssdev->state == OMAP_DSS_DISPLAY_HOTPLUG)
+		omapdss_hdmi_hpd_disable(dssdev);
+
+	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	mutex_unlock(&hdmi.hdmi_lock);
+}
+
+static int hdmi_hpd_enable(struct omap_dss_device *dssdev)
+{
+	int r = 0;
+	DSSDBG("ENTER hdmi_hpd_enable\n");
+
+	mutex_lock(&hdmi.hdmi_lock);
+
+	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
+		r = -EINVAL;
+		goto err;
+	}
+
+	r = omapdss_hdmi_hpd_enable(dssdev);
+
+	if (r < 0) {
+		DSSERR("failed to power on\n");
+		goto err;
+	} else if (r == 1) {
+		r = omapdss_hdmi_display_enable(dssdev);
+		if (r) {
+			DSSERR("failed to power on\n");
+			goto err;
+		}
+		dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
+	} else {
+		dssdev->state = OMAP_DSS_DISPLAY_HOTPLUG;
+	}
+
+err:	mutex_unlock(&hdmi.hdmi_lock);
+
+	return r;
+}
+
 static struct omap_dss_driver hdmi_driver = {
 	.probe		= hdmi_panel_probe,
 	.remove		= hdmi_panel_remove,
-	.enable		= hdmi_panel_enable,
-	.disable	= hdmi_panel_disable,
+	.enable		= hdmi_hpd_enable,
+	.disable	= hdmi_hpd_disable,
 	.suspend	= hdmi_panel_suspend,
 	.resume		= hdmi_panel_resume,
 	.get_timings	= hdmi_get_timings,
@@ -234,6 +280,8 @@ static struct omap_dss_driver hdmi_driver = {
 	.check_timings	= hdmi_check_timings,
 	.read_edid	= hdmi_read_edid,
 	.detect		= hdmi_detect,
+	.default_enable	= hdmi_panel_enable,
+	.default_disable = hdmi_panel_disable,
 	.driver			= {
 		.name   = "hdmi_panel",
 		.owner  = THIS_MODULE,
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 82e2c3e..5623a34 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -159,6 +159,7 @@ enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_DISABLED = 0,
 	OMAP_DSS_DISPLAY_ACTIVE,
 	OMAP_DSS_DISPLAY_SUSPENDED,
+	OMAP_DSS_DISPLAY_HOTPLUG,
 };
 
 /* XXX perhaps this should be removed */
-- 
1.7.5.4

