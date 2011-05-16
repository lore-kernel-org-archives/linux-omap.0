From: Archit Taneja <archit@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: DSI: Get line buffer size from DSI_GNQ register
Date: Mon, 16 May 2011 15:17:09 +0530
Message-ID: <1305539229-28560-5-git-send-email-archit@ti.com>
References: <1305539229-28560-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39549 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754171Ab1EPJmb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 May 2011 05:42:31 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gVNw002925
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:31 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4G9gUDd024677
	for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 04:42:30 -0500 (CDT)
In-Reply-To: <1305539229-28560-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The line buffer sizes vary across DSI modules, create a function
dsi_get_line_buf_size() using DSI_GNQ register to get the size of
line buffer used for the DISPC video port data.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   36 ++++++++++++++++++++++++++++++++----
 1 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 784677d..345757c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2036,6 +2036,37 @@ static inline int dsi_get_num_data_lanes_dssdev(struct omap_dss_device *dssdev)
 	return num_data_lanes;
 }
 
+static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
+{
+	int val;
+
+	/* line buffer on OMAP3 is 1024 x 24bits */
+	/* XXX: for some reason using full buffer size causes
+	 * considerable TX slowdown with update sizes that fill the
+	 * whole buffer */
+	if (!dss_has_feature(FEAT_DSI_GNQ))
+		return 1023 * 3;
+
+	val = REG_GET(dsidev, DSI_GNQ, 14, 12); /* VP1_LINE_BUFFER_SIZE */
+
+	switch (val) {
+	case 1:
+		return 512 * 3;		/* 512x24 bits */
+	case 2:
+		return 682 * 3;		/* 682x24 bits */
+	case 3:
+		return 853 * 3;		/* 853x24 bits */
+	case 4:
+		return 1024 * 3;	/* 1024x24 bits */
+	case 5:
+		return 1194 * 3;	/* 1194x24 bits */
+	case 6:
+		return 1365 * 3;	/* 1365x24 bits */
+	default:
+		BUG();
+	}
+}
+
 static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -3771,10 +3802,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	u32 l;
 	int r;
 	const unsigned channel = dsi->update_channel;
-	/* line buffer is 1024 x 24bits */
-	/* XXX: for some reason using full buffer size causes considerable TX
-	 * slowdown with update sizes that fill the whole buffer */
-	const unsigned line_buf_size = 1023 * 3;
+	const unsigned line_buf_size = dsi_get_line_buf_size(dsidev);
 
 	DSSDBG("dsi_update_screen_dispc(%d,%d %dx%d)\n",
 			x, y, w, h);
-- 
1.7.1

