From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 8/8] OMAPDSS: fix use of dssdev->caps
Date: Thu, 23 Aug 2012 16:45:14 +0300
Message-ID: <1345729514-2441-9-git-send-email-tomi.valkeinen@ti.com>
References: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:37145 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933966Ab2HWNpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 09:45:52 -0400
Received: by lahl5 with SMTP id l5so956005lah.1
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 06:45:50 -0700 (PDT)
In-Reply-To: <1345729514-2441-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Recent commit dca2b1522ccab28d03fb79f6e70e70ea78033d52 (OMAPDSS: DSI:
Maintain copy of operation mode in driver data) broke DSI for video mode
displays. The commit changed the way dssdev->caps are initialized, and
the result was that every DSI display is initialized with manual-update
and tear-elim caps.

The code that sets dssdev->caps is not very good, even when fixed.
omapdss driver shouldn't be writing dssdev->caps at all.

This patch fixes the problem with video mode displays by moving the
initialization of dssdev->caps to the panel driver. The same change is
done for RFBI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |    1 +
 drivers/video/omap2/displays/panel-taal.c |    2 ++
 drivers/video/omap2/dss/dsi.c             |    5 -----
 drivers/video/omap2/dss/rfbi.c            |    1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 17ae85e..3fc5ad0 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -489,6 +489,7 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 	dssdev->panel.timings.y_res = 480;
 	dssdev->ctrl.pixel_size = 16;
 	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
+	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = 127;
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index ddda96a..7b2d7bb 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -884,6 +884,8 @@ static int taal_probe(struct omap_dss_device *dssdev)
 
 	dssdev->panel.timings = panel_config->timings;
 	dssdev->panel.dsi_pix_fmt = OMAP_DSS_DSI_FMT_RGB888;
+	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
+		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
 	td = kzalloc(sizeof(*td), GFP_KERNEL);
 	if (!td) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 340c832..254666f 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4866,11 +4866,6 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("DSI init\n");
 
-	if (dsi->mode == OMAP_DSS_DSI_CMD_MODE) {
-		dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
-			OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
-	}
-
 	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5a9c0e9..2e520d3 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -939,7 +939,6 @@ EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 {
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
-	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	return 0;
 }
 
-- 
1.7.9.5

