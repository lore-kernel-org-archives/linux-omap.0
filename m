From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/13] OMAPDSS: DSI: remove dsi_get_num_lanes_used
Date: Thu, 24 Nov 2011 15:29:38 +0200
Message-ID: <1322141381-5395-11-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:60100 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756083Ab1KXNaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:16 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There's no longer need for the dsi_get_num_lanes_used function, so it
can be removed. The lane check in dsi_init_display() can be removed as
the validity of the config will be verified when parsing it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   27 ++-------------------------
 1 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index dee9525..2b375c6 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2034,23 +2034,6 @@ static int dsi_cio_power(struct platform_device *dsidev,
 	return 0;
 }
 
-/* Number of lanes used by the dss device */
-static inline int dsi_get_num_lanes_used(struct omap_dss_device *dssdev)
-{
-	int num_data_lanes = 0;
-
-	if (dssdev->phy.dsi.data1_lane != 0)
-		num_data_lanes++;
-	if (dssdev->phy.dsi.data2_lane != 0)
-		num_data_lanes++;
-	if (dssdev->phy.dsi.data3_lane != 0)
-		num_data_lanes++;
-	if (dssdev->phy.dsi.data4_lane != 0)
-		num_data_lanes++;
-
-	return num_data_lanes + 1;
-}
-
 static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 {
 	int val;
@@ -3863,6 +3846,7 @@ static int dsi_proto_config(struct omap_dss_device *dssdev)
 static void dsi_proto_timings(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned tlpx, tclk_zero, tclk_prepare, tclk_trail;
 	unsigned tclk_pre, tclk_post;
 	unsigned ths_prepare, ths_prepare_ths_zero, ths_zero;
@@ -3870,7 +3854,7 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	unsigned ddr_clk_pre, ddr_clk_post;
 	unsigned enter_hs_mode_lat, exit_hs_mode_lat;
 	unsigned ths_eot;
-	int ndl = dsi_get_num_lanes_used(dssdev) - 1;
+	int ndl = dsi->num_lanes_used - 1;
 	u32 r;
 
 	r = dsi_read_reg(dsidev, DSI_DSIPHY_CFG0);
@@ -4554,7 +4538,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	int dsi_module = dsi_get_dsidev_id(dsidev);
 
 	DSSDBG("DSI init\n");
 
@@ -4576,12 +4559,6 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
-	if (dsi_get_num_lanes_used(dssdev) > dsi->num_lanes_supported) {
-		DSSERR("DSI%d can't support more than %d lanes\n",
-			dsi_module + 1, dsi->num_lanes_supported);
-		return -EINVAL;
-	}
-
 	return 0;
 }
 
-- 
1.7.4.1

