From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2] OMAP: DSS2: Fix error path in omap_dsi_update()
Date: Wed, 14 Jul 2010 17:41:50 +0530
Message-ID: <1279109510-12992-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57901 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab0GNMMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Jul 2010 08:12:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

In the case of an error on calling dsi_update_screen_l4(), a
successful framedone callback is still sent to panel-taal. An
error should be returned to taal_update() instead.

Signed-off-by: Archit Taneja <archit@ti.com>
---
v2: This fixes a compilation warning seen after
builing with v1.

v1:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31715.html

 drivers/video/omap2/dss/dsi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index a6e0f64..b3fa3a7
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2920,7 +2920,12 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 
 		dsi_update_screen_dispc(dssdev, x, y, w, h);
 	} else {
-		dsi_update_screen_l4(dssdev, x, y, w, h);
+		int r;
+
+		r = dsi_update_screen_l4(dssdev, x, y, w, h);
+		if (r)
+			return r;
+
 		dsi_perf_show("L4");
 		callback(0, data);
 	}
-- 
1.5.4.7

