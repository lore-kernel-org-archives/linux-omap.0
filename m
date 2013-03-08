From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/20] OMAPDSS: add pdata->default_display_name
Date: Fri, 8 Mar 2013 13:51:52 +0200
Message-ID: <1362743515-10152-18-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516Ab3CHLw3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:29 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We can currently set the default display (i.e. the initial display) in
the omapdss platform data by using a pointer to the default
omap_dss_device. Internally omapdss uses the device's name to resolve
the default display.

As it's difficult to get the omap_dss_device pointer in the future,
after we've changed the omapdss device model, this patch adds a new way
to define the default display, by using the name of the display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |    2 ++
 include/video/omapdss.h        |    1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index f8779d4..a9bab9f 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -238,6 +238,8 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	if (def_disp_name)
 		core.default_display_name = def_disp_name;
+	else if (pdata->default_display_name)
+		core.default_display_name = pdata->default_display_name;
 	else if (pdata->default_device)
 		core.default_display_name = pdata->default_device->name;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cd028c8..9057e21 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -334,6 +334,7 @@ struct omap_dss_board_info {
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
+	const char *default_display_name;
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
 	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
-- 
1.7.10.4

