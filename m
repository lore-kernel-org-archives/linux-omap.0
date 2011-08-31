From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/12] OMAP: DSS2: HDMI: remove error prints in check_timings
Date: Wed, 31 Aug 2011 16:23:19 +0300
Message-ID: <1314797003-17638-9-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59138 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755773Ab1HaNXu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:50 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

check_timings() is supposed to be used to verify if timings are ok or
not. Currently the HDMI driver prints error messages if the timings are
not ok. This is not right, as it is no error to give invalid timings to
check_timings().

Remove the error prints.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c             |    1 -
 drivers/video/omap2/dss/hdmi_omap4_panel.c |    6 +-----
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 34e05ee..55edbd2 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1105,7 +1105,6 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 
 	cm = hdmi_get_code(timings);
 	if (cm.code == -1) {
-		DSSERR("Invalid timing entered\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/video/omap2/dss/hdmi_omap4_panel.c b/drivers/video/omap2/dss/hdmi_omap4_panel.c
index 5e314e8..ffea8d3 100644
--- a/drivers/video/omap2/dss/hdmi_omap4_panel.c
+++ b/drivers/video/omap2/dss/hdmi_omap4_panel.c
@@ -170,11 +170,7 @@ static int hdmi_check_timings(struct omap_dss_device *dssdev,
 	mutex_lock(&hdmi.hdmi_lock);
 
 	r = omapdss_hdmi_display_check_timing(dssdev, timings);
-	if (r) {
-		DSSERR("Timing cannot be applied\n");
-		goto err;
-	}
-err:
+
 	mutex_unlock(&hdmi.hdmi_lock);
 	return r;
 }
-- 
1.7.4.1

