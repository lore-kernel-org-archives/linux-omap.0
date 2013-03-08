From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/20] OMAPFB: use output->recommended_channel
Date: Fri, 8 Mar 2013 13:51:48 +0200
Message-ID: <1362743515-10152-14-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33514 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933492Ab3CHLwY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:24 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use output's recommended_channel instead of dssdev->channel in OMAPFB
driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index ca585ef..24f159e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2388,7 +2388,7 @@ static int omapfb_init_connections(struct omapfb2_device *fbdev,
 		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
 		struct omap_dss_output *out = dssdev->output;
 
-		mgr = omap_dss_get_overlay_manager(dssdev->channel);
+		mgr = omap_dss_get_overlay_manager(out->recommended_channel);
 
 		if (!mgr || !out)
 			continue;
-- 
1.7.10.4

