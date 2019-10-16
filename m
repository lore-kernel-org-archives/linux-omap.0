From: Adam Ford <aford173@gmail.com>
Subject: [PATCH V5 1/3] drm/panel: simple: Add Logic PD Type 28 display support
Date: Wed, 16 Oct 2019 08:51:45 -0500
Message-ID: <20191016135147.7743-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Previously, there was an omap panel-dpi driver that would
read generic timings from the device tree and set the display
timing accordingly.  This driver was removed so the screen
no longer functions.  This patch modifies the panel-simple
file to setup the timings to the same values previously used.

Fixes: 8bf4b1621178 ("drm/omap: Remove panel-dpi driver")

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
V5:  No Change
V4:  No Change
V3:  No Change
V2:  No Change

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5d487686d25c..72f69709f349 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2061,6 +2061,40 @@ static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
 };
 
+static const struct drm_display_mode logicpd_type_28_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 3,
+	.hsync_end = 480 + 3 + 42,
+	.htotal = 480 + 3 + 42 + 2,
+
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 11,
+	.vtotal = 272 + 2 + 11 + 3,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc logicpd_type_28 = {
+	.modes = &logicpd_type_28_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 105,
+		.height = 67,
+	},
+	.delay = {
+		.prepare = 200,
+		.enable = 200,
+		.unprepare = 200,
+		.disable = 200,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_DRIVE_NEGEDGE,
+};
+
 static const struct panel_desc mitsubishi_aa070mc01 = {
 	.modes = &mitsubishi_aa070mc01_mode,
 	.num_modes = 1,
@@ -3287,6 +3321,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
+	}, {
+		.compatible = "logicpd,type28",
+		.data = &logicpd_type_28,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.17.1
