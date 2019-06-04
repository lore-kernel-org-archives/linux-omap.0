From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/2] drm/panel: simple: Add Sharp LQ070Y3DG3B panel support
Date: Tue,  4 Jun 2019 14:53:33 +0200
Message-ID: <9eb82ea247a8c3ab5198976d45c599375815c4c1.1559652814.git.hns@goldelico.com>
References: <cover.1559652814.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1559652814.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, tomi.valkeinen@ti.com, marek.belisko@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

The change adds support for the Sharp LQ070Y3DG3B 7.0" TFT LCD panel.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 569be4efd8d1..5b27829c5a78 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2204,6 +2204,33 @@ static const struct panel_desc samsung_ltn140at29_301 = {
 	},
 };
 
+static const struct drm_display_mode sharp_lq070y3dg3b_mode = {
+	.clock = 33260,
+	.hdisplay = 800,
+	.hsync_start = 800 + 64,
+	.hsync_end = 800 + 64 + 128,
+	.htotal = 800 + 64 + 128 + 64,
+	.vdisplay = 480,
+	.vsync_start = 480 + 8,
+	.vsync_end = 480 + 8 + 2,
+	.vtotal = 480 + 8 + 2 + 35,
+	.vrefresh = 60,
+	.flags = DISPLAY_FLAGS_PIXDATA_POSEDGE,
+};
+
+static const struct panel_desc sharp_lq070y3dg3b = {
+	.modes = &sharp_lq070y3dg3b_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,	/* 152.4mm */
+		.height = 91,	/* 91.4mm */
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE,
+};
+
 static const struct drm_display_mode sharp_lq035q7db03_mode = {
 	.clock = 5500,
 	.hdisplay = 240,
@@ -2786,6 +2813,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "sharp,lq035q7db03",
 		.data = &sharp_lq035q7db03,
+	}, {
+		.compatible = "sharp,lq070y3dg3b",
+		.data = &sharp_lq070y3dg3b,
 	}, {
 		.compatible = "sharp,lq101k1ly04",
 		.data = &sharp_lq101k1ly04,
-- 
2.19.1
