From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 8/9] OMAPDSS: DISPC: Remove omap_dss_device pointer usage from dispc_mgr_pclk_rate()
Date: Wed, 9 May 2012 15:40:55 +0530
Message-ID: <1336558256-26140-9-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39794 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab2EIKMO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 06:12:14 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The pixel clock rate for the TV manager is calculated by checking the device
type connected to the manager, and then requesting the VENC/HDMI interface for
the pixel clock rate.

Remove the use of omap_dss_device pointer from here by checking which interface
generates the pixel clock by reading the DSS_CTRL.VENC_HDMI_SWITCH bit.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6eec084..cd0a397 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2643,13 +2643,14 @@ unsigned long dispc_mgr_pclk_rate(enum omap_channel channel)
 
 		return r / pcd;
 	} else {
-		struct omap_dss_device *dssdev =
-			dispc_mgr_get_device(channel);
+		enum dss_hdmi_venc_clk_source_select source;
 
-		switch (dssdev->type) {
-		case OMAP_DISPLAY_TYPE_VENC:
+		source = dss_get_hdmi_venc_clk_source();
+
+		switch (source) {
+		case DSS_VENC_TV_CLK:
 			return venc_get_pixel_clock();
-		case OMAP_DISPLAY_TYPE_HDMI:
+		case DSS_HDMI_M_PCLK:
 			return hdmi_get_pixel_clock();
 		default:
 			BUG();
-- 
1.7.5.4

