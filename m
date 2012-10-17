From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/9] OMAPDSS: DSI: fix dsi_get_dsidev_from_id()
Date: Wed, 17 Oct 2012 14:20:27 +0300
Message-ID: <1350472835-28727-2-git-send-email-tomi.valkeinen@ti.com>
References: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46647 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294Ab2JQLUm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Oct 2012 07:20:42 -0400
In-Reply-To: <1350472835-28727-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

If dsi_get_dsidev_from_id() is called with a DSI module id that does not
exist on the board, the function will crash as omap_dss_get_output()
will return NULL.

This happens on omap3 boards when dumping DSI clocks, as the dumping
code will try to get the dsidev for DSI modules 0 and 1, but omap3 only
has DSI module 0.

Also clean up the id -> output mapping, so that if the function is
called with invalid module ID it will return NULL.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d64ac38..bee9284 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -365,11 +365,20 @@ struct platform_device *dsi_get_dsidev_from_id(int module)
 	struct omap_dss_output *out;
 	enum omap_dss_output_id	id;
 
-	id = module == 0 ? OMAP_DSS_OUTPUT_DSI1 : OMAP_DSS_OUTPUT_DSI2;
+	switch (module) {
+	case 0:
+		id = OMAP_DSS_OUTPUT_DSI1;
+		break;
+	case 1:
+		id = OMAP_DSS_OUTPUT_DSI2;
+		break;
+	default:
+		return NULL;
+	}
 
 	out = omap_dss_get_output(id);
 
-	return out->pdev;
+	return out ? out->pdev : NULL;
 }
 
 static inline void dsi_write_reg(struct platform_device *dsidev,
-- 
1.7.9.5

