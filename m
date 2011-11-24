From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/13] OMAPDSS: DSI: Parse lane config
Date: Thu, 24 Nov 2011 15:29:33 +0200
Message-ID: <1322141381-5395-6-git-send-email-tomi.valkeinen@ti.com>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:46654 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755542Ab1KXNaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Nov 2011 08:30:07 -0500
In-Reply-To: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Parse the lane configuration from the device data into internal lane
config format. This will be used in the following patches to clean up
the lane handling.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   83 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6a110b2..aea110c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -203,6 +203,21 @@ struct dsi_reg { u16 idx; };
 typedef void (*omap_dsi_isr_t) (void *arg, u32 mask);
 
 #define DSI_MAX_NR_ISRS                2
+#define DSI_MAX_NR_LANES	5
+
+enum dsi_lane_function {
+	DSI_LANE_UNUSED	= 0,
+	DSI_LANE_CLK,
+	DSI_LANE_DATA1,
+	DSI_LANE_DATA2,
+	DSI_LANE_DATA3,
+	DSI_LANE_DATA4,
+};
+
+struct dsi_lane_config {
+	enum dsi_lane_function function;
+	u8 polarity;
+};
 
 struct dsi_isr_data {
 	omap_dsi_isr_t	isr;
@@ -329,6 +344,9 @@ struct dsi_data {
 
 	unsigned num_lanes_supported;
 
+	struct dsi_lane_config lanes[DSI_MAX_NR_LANES];
+	unsigned num_lanes_used;
+
 	unsigned scp_clk_refcount;
 };
 
@@ -2077,6 +2095,65 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 	}
 }
 
+static int dsi_parse_lane_config(struct omap_dss_device *dssdev)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	u8 lanes[DSI_MAX_NR_LANES];
+	u8 polarities[DSI_MAX_NR_LANES];
+	int num_lanes, i;
+
+	static const enum dsi_lane_function functions[] = {
+		DSI_LANE_CLK,
+		DSI_LANE_DATA1,
+		DSI_LANE_DATA2,
+		DSI_LANE_DATA3,
+		DSI_LANE_DATA4,
+	};
+
+	lanes[0] = dssdev->phy.dsi.clk_lane;
+	lanes[1] = dssdev->phy.dsi.data1_lane;
+	lanes[2] = dssdev->phy.dsi.data2_lane;
+	lanes[3] = dssdev->phy.dsi.data3_lane;
+	lanes[4] = dssdev->phy.dsi.data4_lane;
+	polarities[0] = dssdev->phy.dsi.clk_pol;
+	polarities[1] = dssdev->phy.dsi.data1_pol;
+	polarities[2] = dssdev->phy.dsi.data2_pol;
+	polarities[3] = dssdev->phy.dsi.data3_pol;
+	polarities[4] = dssdev->phy.dsi.data4_pol;
+
+	num_lanes = 0;
+
+	for (i = 0; i < dsi->num_lanes_supported; ++i)
+		dsi->lanes[i].function = DSI_LANE_UNUSED;
+
+	for (i = 0; i < dsi->num_lanes_supported; ++i) {
+		int num;
+
+		if (lanes[i] == DSI_LANE_UNUSED)
+			break;
+
+		num = lanes[i] - 1;
+
+		if (num >= dsi->num_lanes_supported)
+			return -EINVAL;
+
+		if (dsi->lanes[num].function != DSI_LANE_UNUSED)
+			return -EINVAL;
+
+		dsi->lanes[num].function = functions[i];
+		dsi->lanes[num].polarity = polarities[i];
+		num_lanes++;
+	}
+
+	if (num_lanes < 2 || num_lanes > dsi->num_lanes_supported)
+		return -EINVAL;
+
+	dsi->num_lanes_used = num_lanes;
+
+	return 0;
+}
+
 static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4328,6 +4405,12 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	int dsi_module = dsi_get_dsidev_id(dsidev);
 	int r;
 
+	r = dsi_parse_lane_config(dssdev);
+	if (r) {
+		DSSERR("illegal lane config");
+		goto err0;
+	}
+
 	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
-- 
1.7.4.1

