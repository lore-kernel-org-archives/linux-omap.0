From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/25] OMAPDSS: DSI: implement generic DSI pin config
Date: Thu,  3 May 2012 16:57:59 +0300
Message-ID: <1336053481-25433-24-git-send-email-tomi.valkeinen@ti.com>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37143 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756393Ab2ECN67 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 09:58:59 -0400
Received: by lbbgk8 with SMTP id gk8so1375370lbb.12
        for <linux-omap@vger.kernel.org>; Thu, 03 May 2012 06:58:56 -0700 (PDT)
In-Reply-To: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

In preparation for device tree, this patch changes how the DSI pins are
configured. The current configuration method is only doable with board
files and the configuration data is OMAP specific.

This patch moves the configuration data to the panel's platform data,
and the data can easily be given via DT in the future. The configuration
data format is also changed to a generic one which should be suitable
for all platforms.

The new format is an array of pin numbers, where the array items start
from clock + and -, then data1 + and -, and so on. For example:

{
	0,	// pin num for clock lane +
	1,	// pin num for clock lane -
	2,	// pin num for data1 lane +
	3,	// pin num for data1 lane -
	...
}

The pin numbers are translated by the DSI driver and used to configure
the hardware appropriately.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c       |   21 ++---
 drivers/video/omap2/displays/panel-taal.c |    7 ++
 drivers/video/omap2/dss/dsi.c             |  133 +++++++++++++++--------------
 include/video/omap-panel-nokia-dsi.h      |    3 +
 include/video/omapdss.h                   |   28 +++---
 5 files changed, 103 insertions(+), 89 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 6cbb16f..b4ad706 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -666,6 +666,10 @@ static struct nokia_dsi_panel_data dsi1_panel = {
 		.use_ext_te	= false,
 		.ext_te_gpio	= 101,
 		.esd_interval	= 0,
+		.pin_config = {
+			.num_pins	= 6,
+			.pins		= { 0, 1, 2, 3, 4, 5 },
+		},
 };
 
 static struct omap_dss_device sdp4430_lcd_device = {
@@ -674,13 +678,6 @@ static struct omap_dss_device sdp4430_lcd_device = {
 	.type			= OMAP_DISPLAY_TYPE_DSI,
 	.data			= &dsi1_panel,
 	.phy.dsi		= {
-		.clk_lane	= 1,
-		.clk_pol	= 0,
-		.data1_lane	= 2,
-		.data1_pol	= 0,
-		.data2_lane	= 3,
-		.data2_pol	= 0,
-
 		.module		= 0,
 	},
 
@@ -715,6 +712,10 @@ static struct nokia_dsi_panel_data dsi2_panel = {
 		.use_ext_te	= false,
 		.ext_te_gpio	= 103,
 		.esd_interval	= 0,
+		.pin_config = {
+			.num_pins	= 6,
+			.pins		= { 0, 1, 2, 3, 4, 5 },
+		},
 };
 
 static struct omap_dss_device sdp4430_lcd2_device = {
@@ -723,12 +724,6 @@ static struct omap_dss_device sdp4430_lcd2_device = {
 	.type			= OMAP_DISPLAY_TYPE_DSI,
 	.data			= &dsi2_panel,
 	.phy.dsi		= {
-		.clk_lane	= 1,
-		.clk_pol	= 0,
-		.data1_lane	= 2,
-		.data1_pol	= 0,
-		.data2_lane	= 3,
-		.data2_pol	= 0,
 
 		.module		= 1,
 	},
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index be9992f..2ce9992 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1051,9 +1051,16 @@ static void __exit taal_remove(struct omap_dss_device *dssdev)
 static int taal_power_on(struct omap_dss_device *dssdev)
 {
 	struct taal_data *td = dev_get_drvdata(&dssdev->dev);
+	struct nokia_dsi_panel_data *panel_data = get_panel_data(dssdev);
 	u8 id1, id2, id3;
 	int r;
 
+	r = omapdss_dsi_configure_pins(dssdev, &panel_data->pin_config);
+	if (r) {
+		dev_err(&dssdev->dev, "failed to configure DSI pins\n");
+		goto err0;
+	};
+
 	r = omapdss_dsi_display_enable(dssdev);
 	if (r) {
 		dev_err(&dssdev->dev, "failed to enable DSI\n");
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 49b83a4..6cc92a8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2011,65 +2011,6 @@ static unsigned dsi_get_line_buf_size(struct platform_device *dsidev)
 	}
 }
 
-static int dsi_parse_lane_config(struct omap_dss_device *dssdev)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	u8 lanes[DSI_MAX_NR_LANES];
-	u8 polarities[DSI_MAX_NR_LANES];
-	int num_lanes, i;
-
-	static const enum dsi_lane_function functions[] = {
-		DSI_LANE_CLK,
-		DSI_LANE_DATA1,
-		DSI_LANE_DATA2,
-		DSI_LANE_DATA3,
-		DSI_LANE_DATA4,
-	};
-
-	lanes[0] = dssdev->phy.dsi.clk_lane;
-	lanes[1] = dssdev->phy.dsi.data1_lane;
-	lanes[2] = dssdev->phy.dsi.data2_lane;
-	lanes[3] = dssdev->phy.dsi.data3_lane;
-	lanes[4] = dssdev->phy.dsi.data4_lane;
-	polarities[0] = dssdev->phy.dsi.clk_pol;
-	polarities[1] = dssdev->phy.dsi.data1_pol;
-	polarities[2] = dssdev->phy.dsi.data2_pol;
-	polarities[3] = dssdev->phy.dsi.data3_pol;
-	polarities[4] = dssdev->phy.dsi.data4_pol;
-
-	num_lanes = 0;
-
-	for (i = 0; i < dsi->num_lanes_supported; ++i)
-		dsi->lanes[i].function = DSI_LANE_UNUSED;
-
-	for (i = 0; i < dsi->num_lanes_supported; ++i) {
-		int num;
-
-		if (lanes[i] == DSI_LANE_UNUSED)
-			break;
-
-		num = lanes[i] - 1;
-
-		if (num >= dsi->num_lanes_supported)
-			return -EINVAL;
-
-		if (dsi->lanes[num].function != DSI_LANE_UNUSED)
-			return -EINVAL;
-
-		dsi->lanes[num].function = functions[i];
-		dsi->lanes[num].polarity = polarities[i];
-		num_lanes++;
-	}
-
-	if (num_lanes < 2 || num_lanes > dsi->num_lanes_supported)
-		return -EINVAL;
-
-	dsi->num_lanes_used = num_lanes;
-
-	return 0;
-}
-
 static int dsi_set_lane_config(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -3909,6 +3850,74 @@ static void dsi_proto_timings(struct omap_dss_device *dssdev)
 	}
 }
 
+int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
+		const struct omap_dsi_pin_config *pin_cfg)
+{
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	int num_pins;
+	const int *pins;
+	struct dsi_lane_config lanes[DSI_MAX_NR_LANES];
+	int num_lanes;
+	int i;
+
+	static const enum dsi_lane_function functions[] = {
+		DSI_LANE_CLK,
+		DSI_LANE_DATA1,
+		DSI_LANE_DATA2,
+		DSI_LANE_DATA3,
+		DSI_LANE_DATA4,
+	};
+
+	num_pins = pin_cfg->num_pins;
+	pins = pin_cfg->pins;
+
+	if (num_pins < 4 || num_pins > dsi->num_lanes_supported * 2
+			|| num_pins % 2 != 0)
+		return -EINVAL;
+
+	for (i = 0; i < DSI_MAX_NR_LANES; ++i)
+		lanes[i].function = DSI_LANE_UNUSED;
+
+	num_lanes = 0;
+
+	for (i = 0; i < num_pins; i += 2) {
+		u8 lane, pol;
+		int dx, dy;
+
+		dx = pins[i];
+		dy = pins[i + 1];
+
+		if (dx < 0 || dx >= dsi->num_lanes_supported * 2)
+			return -EINVAL;
+
+		if (dy < 0 || dy >= dsi->num_lanes_supported * 2)
+			return -EINVAL;
+
+		if (dx & 1) {
+			if (dy != dx - 1)
+				return -EINVAL;
+			pol = 1;
+		} else {
+			if (dy != dx + 1)
+				return -EINVAL;
+			pol = 0;
+		}
+
+		lane = dx / 2;
+
+		lanes[lane].function = functions[i / 2];
+		lanes[lane].polarity = pol;
+		num_lanes++;
+	}
+
+	memcpy(dsi->lanes, lanes, sizeof(dsi->lanes));
+	dsi->num_lanes_used = num_lanes;
+
+	return 0;
+}
+EXPORT_SYMBOL(omapdss_dsi_configure_pins);
+
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
@@ -4271,12 +4280,6 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	int dsi_module = dsi_get_dsidev_id(dsidev);
 	int r;
 
-	r = dsi_parse_lane_config(dssdev);
-	if (r) {
-		DSSERR("illegal lane config");
-		goto err0;
-	}
-
 	r = dsi_pll_init(dsidev, true, true);
 	if (r)
 		goto err0;
diff --git a/include/video/omap-panel-nokia-dsi.h b/include/video/omap-panel-nokia-dsi.h
index 7dc71f9..04219a2 100644
--- a/include/video/omap-panel-nokia-dsi.h
+++ b/include/video/omap-panel-nokia-dsi.h
@@ -11,6 +11,7 @@ struct omap_dss_device;
  * @esd_interval: interval of ESD checks, 0 = disabled (ms)
  * @ulps_timeout: time to wait before entering ULPS, 0 = disabled (ms)
  * @use_dsi_backlight: true if panel uses DSI command to control backlight
+ * @pin_config: DSI pin configuration
  */
 struct nokia_dsi_panel_data {
 	const char *name;
@@ -24,6 +25,8 @@ struct nokia_dsi_panel_data {
 	unsigned ulps_timeout;
 
 	bool use_dsi_backlight;
+
+	struct omap_dsi_pin_config pin_config;
 };
 
 #endif /* __OMAP_NOKIA_DSI_PANEL_H */
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 49e7073..1217df4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -464,6 +464,21 @@ struct omap_overlay_manager {
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
 };
 
+/* 22 pins means 1 clk lane and 10 data lanes */
+#define OMAP_DSS_MAX_DSI_PINS 22
+
+struct omap_dsi_pin_config {
+	int num_pins;
+	/*
+	 * pin numbers in the following order:
+	 * clk+, clk-
+	 * data1+, data1-
+	 * data2+, data2-
+	 * ...
+	 */
+	int pins[OMAP_DSS_MAX_DSI_PINS];
+};
+
 struct omap_dss_device {
 	struct device dev;
 
@@ -486,17 +501,6 @@ struct omap_dss_device {
 		} sdi;
 
 		struct {
-			u8 clk_lane;
-			u8 clk_pol;
-			u8 data1_lane;
-			u8 data1_pol;
-			u8 data2_lane;
-			u8 data2_pol;
-			u8 data3_lane;
-			u8 data3_pol;
-			u8 data4_lane;
-			u8 data4_pol;
-
 			int module;
 
 			bool ext_te;
@@ -685,6 +689,8 @@ int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel);
 int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id);
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel);
+int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
+		const struct omap_dsi_pin_config *pin_cfg);
 
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev);
 void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
-- 
1.7.9.5

