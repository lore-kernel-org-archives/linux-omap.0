From: Archit Taneja <archit@ti.com>
Subject: [PATCH 14/21] OMAPDSS: DISPC: Downscale chroma if plane is writeback
Date: Thu, 13 Sep 2012 17:44:58 +0530
Message-ID: <1347538505-25359-15-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39509 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757923Ab2IMMPp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Sep 2012 08:15:45 -0400
In-Reply-To: <1347538505-25359-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When converting YUYV444 content to YUV422 or NV12 formats through writeback
pipeline, the scalar needs to downscale the chroma plane. Ensure that chroma
is downscaled when the pipeline is writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 1d5dddf..f3bf93d 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1465,7 +1465,7 @@ static void dispc_plane_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
-	bool chroma_upscale = true;
+	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
-- 
1.7.9.5

