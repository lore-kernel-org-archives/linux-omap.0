From: Archit Taneja <archit@ti.com>
Subject: [PATCH 27/33] OMAPDSS: n8x0 panel: handle gpio data in panel driver
Date: Wed, 13 Feb 2013 19:52:19 +0530
Message-ID: <1360765345-19312-28-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab3BMOYg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:36 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The n8x0 panel driver leaves gpio configurations to the platform_enable and
disable calls in the platform's board file. These should happen in the panel
driver itself.

A platform data struct called panel_n8x0_data already exists to hold gpio
numbers and other platform data. However, the gpio requests are expected to be
done in the board file and not the panel driver.

Request all the gpios in the panel driver so that the board files which use
the the panel don't need to do it. This will help in removing the need for the
panel drivers to have platform related callbacks.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/displays/panel-n8x0.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/video/omap2/displays/panel-n8x0.c b/drivers/video/omap2/displays/panel-n8x0.c
index 9c55c91..c146a3d 100644
--- a/drivers/video/omap2/displays/panel-n8x0.c
+++ b/drivers/video/omap2/displays/panel-n8x0.c
@@ -426,6 +426,7 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 {
 	struct panel_n8x0_data *bdata = get_board_data(dssdev);
 	struct panel_drv_data *ddata;
+	int r;
 
 	dev_dbg(&dssdev->dev, "probe\n");
 
@@ -444,6 +445,20 @@ static int n8x0_panel_probe(struct omap_dss_device *dssdev)
 	dssdev->ctrl.rfbi_timings = n8x0_panel_timings;
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 
+	if (gpio_is_valid(bdata->panel_reset)) {
+		r = devm_gpio_request_one(&dssdev->dev, bdata->panel_reset,
+				GPIOF_OUT_INIT_LOW, "PANEL RESET");
+		if (r)
+			return r;
+	}
+
+	if (gpio_is_valid(bdata->ctrl_pwrdown)) {
+		r = devm_gpio_request_one(&dssdev->dev, bdata->ctrl_pwrdown,
+				GPIOF_OUT_INIT_LOW, "PANEL PWRDOWN");
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

