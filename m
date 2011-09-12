From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 08/15] OMAP: DSS2: HDMI: remove error prints in check_timings
Date: Mon, 12 Sep 2011 12:13:31 +0300
Message-ID: <1315818818-18733-9-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:47762 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754425Ab1ILJON (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:13 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mythri P K <mythripk@ti.com>

check_timings() is supposed to be used to verify if timings are ok or
not. Currently the HDMI driver prints error messages if the timings are
not ok. This is not right, as it is no error to give invalid timings to
check_timings().

Remove the error prints.

Cc: Mythri P K <mythripk@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c       |    1 -
 drivers/video/omap2/dss/hdmi_panel.c |    6 +-----
 2 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index bf85cba..fb85ce5 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -406,7 +406,6 @@ int omapdss_hdmi_display_check_timing(struct omap_dss_device *dssdev,
 
 	cm = hdmi_get_code(timings);
 	if (cm.code == -1) {
-		DSSERR("Invalid timing entered\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/video/omap2/dss/hdmi_panel.c b/drivers/video/omap2/dss/hdmi_panel.c
index 79a3a5a..71aa813 100644
--- a/drivers/video/omap2/dss/hdmi_panel.c
+++ b/drivers/video/omap2/dss/hdmi_panel.c
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

