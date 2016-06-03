From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 24/27] drm/omap: Do not include video/omapdss.h directly in drivers
Date: Fri, 3 Jun 2016 14:03:26 +0300
Message-ID: <20160603110329.9953-25-peter.ujfalusi@ti.com>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

All drivers to include the omapdrm/dss/omapdss.h header file. This header
includes the <video/omapdss.h>

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c      | 3 ++-
 drivers/gpu/drm/omapdrm/displays/connector-dvi.c            | 4 ++--
 drivers/gpu/drm/omapdrm/displays/connector-hdmi.c           | 4 ++--
 drivers/gpu/drm/omapdrm/displays/encoder-opa362.c           | 2 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c           | 2 +-
 drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c        | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-dpi.c                | 3 ++-
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c             | 3 ++-
 drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c     | 2 +-
 drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c  | 3 ++-
 drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c     | 3 ++-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c     | 3 ++-
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c     | 2 +-
 drivers/gpu/drm/omapdrm/dss/core.c                          | 3 +--
 drivers/gpu/drm/omapdrm/dss/dispc.c                         | 3 +--
 drivers/gpu/drm/omapdrm/dss/dispc_coefs.c                   | 2 +-
 drivers/gpu/drm/omapdrm/dss/display.c                       | 2 +-
 drivers/gpu/drm/omapdrm/dss/dpi.c                           | 3 +--
 drivers/gpu/drm/omapdrm/dss/dsi.c                           | 2 +-
 drivers/gpu/drm/omapdrm/dss/dss-of.c                        | 3 +--
 drivers/gpu/drm/omapdrm/dss/dss.c                           | 3 +--
 drivers/gpu/drm/omapdrm/dss/dss_features.c                  | 3 +--
 drivers/gpu/drm/omapdrm/dss/hdmi.h                          | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c                         | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c                         | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_common.c                   | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c                      | 2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c                      | 3 +--
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c                       | 2 +-
 drivers/gpu/drm/omapdrm/dss/output.c                        | 3 +--
 drivers/gpu/drm/omapdrm/dss/pll.c                           | 3 +--
 drivers/gpu/drm/omapdrm/dss/rfbi.c                          | 2 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                           | 2 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                          | 3 +--
 drivers/gpu/drm/omapdrm/dss/video-pll.c                     | 3 +--
 drivers/gpu/drm/omapdrm/omap_drv.h                          | 1 -
 37 files changed, 44 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c b/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
index d963b4a9cfc0..3485d1ecd655 100644
--- a/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
+++ b/drivers/gpu/drm/omapdrm/displays/connector-analog-tv.c
@@ -14,9 +14,10 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
+#include "../dss/omapdss.h"
+
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
diff --git a/drivers/gpu/drm/omapdrm/displays/connector-dvi.c b/drivers/gpu/drm/omapdrm/displays/connector-dvi.c
index 747f26a55e43..75f7827525cf 100644
--- a/drivers/gpu/drm/omapdrm/displays/connector-dvi.c
+++ b/drivers/gpu/drm/omapdrm/displays/connector-dvi.c
@@ -15,10 +15,10 @@
 #include <linux/slab.h>
 
 #include <drm/drm_edid.h>
-
-#include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
+#include "../dss/omapdss.h"
+
 static const struct omap_video_timings dvic_default_timings = {
 	.x_res		= 640,
 	.y_res		= 480,
diff --git a/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c b/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
index 225fd8d6ab31..6bac35494819 100644
--- a/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
+++ b/drivers/gpu/drm/omapdrm/displays/connector-hdmi.c
@@ -16,10 +16,10 @@
 #include <linux/of_gpio.h>
 
 #include <drm/drm_edid.h>
-
-#include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
+#include "../dss/omapdss.h"
+
 static const struct omap_video_timings hdmic_default_timings = {
 	.x_res		= 640,
 	.y_res		= 480,
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
index 8c246c213e06..a36c36d3328e 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-opa362.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
index 6b7d4fc3ac12..027e2365f9e0 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
index f4f23f5cfe3e..46855c8f5cbf 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dpi.c b/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
index e780fd4f8b46..3baccf732d96 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dpi.c
@@ -16,10 +16,11 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 #include <video/of_display_timing.h>
 
+#include "../dss/omapdss.h"
+
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
 	struct omap_dss_device *in;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 6dcb75f6f0c5..bb20881dd1af 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -25,9 +25,10 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
 #include <video/mipi_display.h>
 
+#include "../dss/omapdss.h"
+
 /* DSI Virtual channel. Hardcoded for now. */
 #define TCH 0
 
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
index 1bd682864217..3f4477fc1dbc 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
@@ -16,7 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/gpio.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 static struct omap_video_timings lb035q02_timings = {
 	.x_res = 320,
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c b/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
index 780cb263a318..6872b6adf095 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-nec-nl8048hl11.c
@@ -18,7 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device	dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
index 529a017602e4..22b1d140c30e 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-sharp-ls037v7dw01.c
@@ -17,7 +17,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
-#include <video/omapdss.h>
+
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
index 31efcca801bd..f85cbb3a1add 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-sony-acx565akm.c
@@ -33,9 +33,10 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
 #include <video/omap-panel-data.h>
 
+#include "../dss/omapdss.h"
+
 #define MIPID_CMD_READ_DISP_ID		0x04
 #define MIPID_CMD_READ_RED		0x06
 #define MIPID_CMD_READ_GREEN		0x07
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index bd8d85041926..e859b3f893f7 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -28,7 +28,8 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
-#include <video/omapdss.h>
+
+#include "../dss/omapdss.h"
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
index 03e2beb7b4f0..bcbab4972bbc 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td043mtea1.c
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include "../dss/omapdss.h"
 
 #define TPO_R02_MODE(x)		((x) & 7)
 #define TPO_R02_MODE_800x480	7
diff --git a/drivers/gpu/drm/omapdrm/dss/core.c b/drivers/gpu/drm/omapdrm/dss/core.c
index 9cf22b30023f..6a3ebfcd7223 100644
--- a/drivers/gpu/drm/omapdrm/dss/core.c
+++ b/drivers/gpu/drm/omapdrm/dss/core.c
@@ -35,8 +35,7 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index f83608b69e68..1fc15b8c769c 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -41,8 +41,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 #include "dispc.h"
diff --git a/drivers/gpu/drm/omapdrm/dss/dispc_coefs.c b/drivers/gpu/drm/omapdrm/dss/dispc_coefs.c
index 038c15b04215..34fad2376f8d 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc_coefs.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc_coefs.c
@@ -18,8 +18,8 @@
  */
 
 #include <linux/kernel.h>
-#include <video/omapdss.h>
 
+#include "omapdss.h"
 #include "dispc.h"
 
 static const struct dispc_coef coef3_M8[8] = {
diff --git a/drivers/gpu/drm/omapdrm/dss/display.c b/drivers/gpu/drm/omapdrm/dss/display.c
index 9f3dd09b0a6c..8dcdd7cf9937 100644
--- a/drivers/gpu/drm/omapdrm/dss/display.c
+++ b/drivers/gpu/drm/omapdrm/dss/display.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dpi.c b/drivers/gpu/drm/omapdrm/dss/dpi.c
index 97ea60257884..56068d4fb121 100644
--- a/drivers/gpu/drm/omapdrm/dss/dpi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dpi.c
@@ -34,8 +34,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 8730646a0cbb..d56ad7cc6b88 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -42,9 +42,9 @@
 #include <linux/of_platform.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
 #include <video/mipi_display.h>
 
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dss-of.c b/drivers/gpu/drm/omapdrm/dss/dss-of.c
index bf407b6ba15c..dfd4e9621e3b 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss-of.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss-of.c
@@ -18,8 +18,7 @@
 #include <linux/of.h>
 #include <linux/seq_file.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 
 struct device_node *
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index f95ff319e68e..68942ba3ec44 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -41,8 +41,7 @@
 #include <linux/suspend.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dss_features.c b/drivers/gpu/drm/omapdrm/dss/dss_features.c
index c886a2927f73..602ce1af5288 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss_features.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss_features.c
@@ -23,8 +23,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi.h b/drivers/gpu/drm/omapdrm/dss/hdmi.h
index c32a21a26054..2f926f39d197 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi.h
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi.h
@@ -23,9 +23,9 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/hdmi.h>
-#include <video/omapdss.h>
 #include <sound/omap-hdmi-audio.h>
 
+#include "omapdss.h"
 #include "dss.h"
 
 /* HDMI Wrapper */
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index f892ae157ff3..8de111ea1dbc 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -33,9 +33,9 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
-#include <video/omapdss.h>
 #include <sound/omap-hdmi-audio.h>
 
+#include "omapdss.h"
 #include "hdmi4_core.h"
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index a43f7b10e113..15145163be13 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -38,9 +38,9 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
-#include <video/omapdss.h>
 #include <sound/omap-hdmi-audio.h>
 
+#include "omapdss.h"
 #include "hdmi5_core.h"
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
index 1b8fcc6c4ba1..4dfb67fe5f6d 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_common.c
@@ -4,8 +4,8 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <video/omapdss.h>
 
+#include "omapdss.h"
 #include "hdmi.h"
 
 int hdmi_parse_lanes_of(struct platform_device *pdev, struct device_node *ep,
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
index 1f5d19c119ce..3991b8fb9140 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
@@ -13,8 +13,8 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <video/omapdss.h>
 
+#include "omapdss.h"
 #include "dss.h"
 #include "hdmi.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index 06e23a7c432c..ad624b3d09f3 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -17,8 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "hdmi.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
index 13442b9052d1..48779155e4d0 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
@@ -14,8 +14,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <video/omapdss.h>
 
+#include "omapdss.h"
 #include "dss.h"
 #include "hdmi.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 829232ad8c81..24f859488201 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -21,8 +21,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 
 static LIST_HEAD(output_list);
diff --git a/drivers/gpu/drm/omapdrm/dss/pll.c b/drivers/gpu/drm/omapdrm/dss/pll.c
index f974ddcd3b6e..0ffee5c49d14 100644
--- a/drivers/gpu/drm/omapdrm/dss/pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/pll.c
@@ -22,8 +22,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 
 #define PLL_CONTROL			0x0000
diff --git a/drivers/gpu/drm/omapdrm/dss/rfbi.c b/drivers/gpu/drm/omapdrm/dss/rfbi.c
index 3796576dfadf..cd53566d75eb 100644
--- a/drivers/gpu/drm/omapdrm/dss/rfbi.c
+++ b/drivers/gpu/drm/omapdrm/dss/rfbi.c
@@ -38,7 +38,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include "omapdss.h"
 #include "dss.h"
 
 struct rfbi_reg { u16 idx; };
diff --git a/drivers/gpu/drm/omapdrm/dss/sdi.c b/drivers/gpu/drm/omapdrm/dss/sdi.c
index cd6d3bfb041d..0a96c321ce62 100644
--- a/drivers/gpu/drm/omapdrm/dss/sdi.c
+++ b/drivers/gpu/drm/omapdrm/dss/sdi.c
@@ -29,7 +29,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include "omapdss.h"
 #include "dss.h"
 
 static struct {
diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index 08a2cc778ba9..6eedf2118708 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -37,8 +37,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/dss/video-pll.c b/drivers/gpu/drm/omapdrm/dss/video-pll.c
index b1ec59e42940..180b55bbab8a 100644
--- a/drivers/gpu/drm/omapdrm/dss/video-pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/video-pll.c
@@ -17,8 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 
-#include <video/omapdss.h>
-
+#include "omapdss.h"
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.h b/drivers/gpu/drm/omapdrm/omap_drv.h
index 3f823c368912..38786886d30e 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.h
+++ b/drivers/gpu/drm/omapdrm/omap_drv.h
@@ -24,7 +24,6 @@
 #include <linux/platform_data/omap_drm.h>
 #include <linux/types.h>
 #include <linux/wait.h>
-#include <video/omapdss.h>
 
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
-- 
2.8.3
