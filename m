From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/32] OMAPDSS: add pdata->default_display_name
Date: Thu, 30 May 2013 12:34:22 +0300
Message-ID: <1369906493-27538-2-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968002Ab3E3JfX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:23 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We can currently set the default display (i.e. the initial display) in
the omapdss platform data by using a pointer to the default
omap_dss_device. Internally omapdss uses the device's name to resolve
the default display.

As it's difficult to get the omap_dss_device pointer in the future,
after we've changed the omapdss device model, this patch adds a new way
to define the default display, by using the name of the display.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Reviewed-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/core.c | 2 ++
 include/video/omapdss.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 60cc6fe..502ec1b 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -235,6 +235,8 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	if (def_disp_name)
 		core.default_display_name = def_disp_name;
+	else if (pdata->default_display_name)
+		core.default_display_name = pdata->default_display_name;
 	else if (pdata->default_device)
 		core.default_display_name = pdata->default_device->name;
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 62ca9a7..d5f1fff 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -365,6 +365,7 @@ struct omap_dss_board_info {
 	int num_devices;
 	struct omap_dss_device **devices;
 	struct omap_dss_device *default_device;
+	const char *default_display_name;
 	int (*dsi_enable_pads)(int dsi_id, unsigned lane_mask);
 	void (*dsi_disable_pads)(int dsi_id, unsigned lane_mask);
 	int (*set_min_bus_tput)(struct device *dev, unsigned long r);
-- 
1.8.1.2

