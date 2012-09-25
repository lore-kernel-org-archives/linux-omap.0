From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 11/18] OMAPDSS: DISPC: Downscale chroma if plane is writeback
Date: Tue, 25 Sep 2012 11:49:46 +0530
Message-ID: <1348553993-8083-12-git-send-email-archit@ti.com>
References: <1347538505-25359-1-git-send-email-archit@ti.com>
 <1348553993-8083-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60576 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab2IYGU3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Sep 2012 02:20:29 -0400
In-Reply-To: <1348553993-8083-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

When converting YUYV444 content to YUV422 or NV12 formats through writeback
pipeline, the scaler needs to downscale the chroma plane. Ensure that chroma
is downscaled when the pipeline is writeback.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 04fdd33..4f36e83 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -1460,7 +1460,7 @@ static void dispc_ovl_set_scaling_uv(enum omap_plane plane,
 {
 	int scale_x = out_width != orig_width;
 	int scale_y = out_height != orig_height;
-	bool chroma_upscale = true;
+	bool chroma_upscale = plane != OMAP_DSS_WB ? true : false;
 
 	if (!dss_has_feature(FEAT_HANDLE_UV_SEPARATE))
 		return;
-- 
1.7.9.5

