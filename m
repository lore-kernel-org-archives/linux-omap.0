From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/26] OMAPDSS: if dssdev->name==NULL, use alias
Date: Wed, 4 Dec 2013 14:28:33 +0200
Message-ID: <1386160133-24026-7-git-send-email-tomi.valkeinen@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52580 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3LDMaI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Dec 2013 07:30:08 -0500
In-Reply-To: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

To avoid the need for a "nickname" property for each display, change
the display registration so that the display's alias (i.e. "display0"
etc) will be used for the dssdev->name if the display driver didn't
provide a name.

This means that when booting with board files, we will have more
descriptive names for displays, like "lcd1", "hdmi". With DT we'll only
have "display0", etc. But as there are no "nicknames" for things like
serials ports either, I hope we will do fine with this approach.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 669a81fdf58e..a946cf7ed00f 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -137,6 +137,9 @@ int omapdss_register_display(struct omap_dss_device *dssdev)
 	snprintf(dssdev->alias, sizeof(dssdev->alias),
 			"display%d", disp_num_counter++);
 
+	if (dssdev->name == NULL)
+		dssdev->name = dssdev->alias;
+
 	if (drv && drv->get_resolution == NULL)
 		drv->get_resolution = omapdss_default_get_resolution;
 	if (drv && drv->get_recommended_bpp == NULL)
-- 
1.8.3.2

