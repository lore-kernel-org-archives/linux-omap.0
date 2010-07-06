From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Tue,  6 Jul 2010 10:03:48 +0530
Message-ID: <1278390828-11692-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43898 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751165Ab0GFEd4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Jul 2010 00:33:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the case of an error on calling dsi_update_screen_l4(), a
successful framedone callback is still sent to panel-taal. An
error should be returned to taal_update() instead.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6e0f64..7570a53
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2901,6 +2901,7 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		void (*callback)(int, void *), void *data)
 {
 	dsi.update_channel = channel;
+	int r;
 
 	/* OMAP DSS cannot send updates of odd widths.
 	 * omap_dsi_prepare_update() makes the widths even, but add a BUG_ON
@@ -2920,7 +2921,10 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 
 		dsi_update_screen_dispc(dssdev, x, y, w, h);
 	} else {
-		dsi_update_screen_l4(dssdev, x, y, w, h);
+		r = dsi_update_screen_l4(dssdev, x, y, w, h);
+		if (r)
+			return r;
+
 		dsi_perf_show("L4");
 		callback(0, data);
 	}
-- 
1.5.4.7

