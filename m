From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 23/26] omapfb: Create new header file for omapfb DSS implementation
Date: Mon, 30 May 2016 14:42:55 +0300
Message-ID: <20160530114258.30879-24-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

A new video/omapfb_dss.h file is created which is currently only includes
the video/omapdss.h file.
The new header file is needed to complete the separation of omapdrm and
omapfb implementation of DSS.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../video/fbdev/omap2/omapfb/displays/connector-analog-tv.c    |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c      |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c     |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c     |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c     |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c  |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c          |  2 +-
 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c       |  2 +-
 .../fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c     |  2 +-
 .../video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  2 +-
 .../fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c      |  2 +-
 .../video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c   |  2 +-
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  2 +-
 .../video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/apply.c                   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c                    |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c            |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c                   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c             |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c           |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/display.c                 |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dpi.c                     |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c                     |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c                  |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss.c                     |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss_features.c            |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h                    |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c                   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c                   |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c             |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c                |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c                |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c                 |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c           |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/manager.c                 |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/output.c                  |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c           |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/overlay.c                 |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/pll.c                     |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c                    |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/sdi.c                     |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/venc.c                    |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c               |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c                |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c                 |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c                |  2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb.h                      |  2 +-
 .../hns/hns_dsaf_xgmac.h => include/video/omapfb_dss.h         | 10 +++++-----
 48 files changed, 52 insertions(+), 52 deletions(-)
 copy drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h => include/video/omapfb_dss.h (64%)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
index d963b4a9cfc0..9d78411a3bf7 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
@@ -14,7 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omap-panel-data.h>
 
 struct panel_drv_data {
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
index f2abbec7602a..06e1db34541e 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
@@ -16,7 +16,7 @@
 
 #include <drm/drm_edid.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 static const struct omap_video_timings dvic_default_timings = {
 	.x_res		= 640,
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
index 231b8588a59f..58d5803ede67 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
@@ -17,7 +17,7 @@
 
 #include <drm/drm_edid.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 static const struct omap_video_timings hdmic_default_timings = {
 	.x_res		= 640,
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
index 8c246c213e06..a9a67167cc3d 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
@@ -20,7 +20,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
index 778e3b384c2f..8c0953d069b7 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
@@ -15,7 +15,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
index 677e2545fcbe..a71db8d89814 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omap-panel-data.h>
 
 struct panel_drv_data {
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
index e780fd4f8b46..ace3d818afe5 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omap-panel-data.h>
 #include <video/of_display_timing.h>
 
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
index a4eac6962b76..b58012b82b6f 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
@@ -25,7 +25,7 @@
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/mipi_display.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
index 6d5207c7b22c..f14691ce8d02 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
@@ -16,7 +16,7 @@
 #include <linux/mutex.h>
 #include <linux/gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 static struct omap_video_timings lb035q02_timings = {
 	.x_res = 320,
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
index 3852cea3c947..a2cbadd3eca3 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
@@ -18,7 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 struct panel_drv_data {
 	struct omap_dss_device	dssdev;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
index a1e590155a26..a8be18a87fa0 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/regulator/consumer.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index 31efcca801bd..468560a6daae 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -33,7 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omap-panel-data.h>
 
 #define MIPID_CMD_READ_DISP_ID		0x04
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index f4dc023868ae..b529a8c2b652 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -28,7 +28,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index f49e60da5bd3..51e628b85f4a 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -19,7 +19,7 @@
 #include <linux/slab.h>
 #include <linux/of_gpio.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #define TPO_R02_MODE(x)		((x) & 7)
 #define TPO_R02_MODE_800x480	7
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/apply.c b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
index 663ccc3bf4e5..2481f4871f66 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/apply.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/apply.c
@@ -23,7 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index b9de21d3ff09..29de4827589d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -35,7 +35,7 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
index 6607db37a5e4..3691bde4ce0a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
@@ -26,7 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/seq_file.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index 5491e304f4fe..7a75dfda9845 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -41,7 +41,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
index 038c15b04215..59c9a5c47ca9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
@@ -18,7 +18,7 @@
  */
 
 #include <linux/kernel.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dispc.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
index 75b5286029ee..b3fdbfd0b82d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
@@ -25,7 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/sysfs.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include "dss.h"
 
 static ssize_t display_name_show(struct omap_dss_device *dssdev, char *buf)
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/display.c b/drivers/video/fbdev/omap2/omapfb/dss/display.c
index ef5b9027985d..dd5468695c43 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/display.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/display.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include "dss.h"
 #include "dss_features.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dpi.c b/drivers/video/fbdev/omap2/omapfb/dss/dpi.c
index 7953e6a52346..da09806b940c 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dpi.c
@@ -34,7 +34,7 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index d63e59807707..9e4800a4e3d1 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -42,7 +42,7 @@
 #include <linux/of_platform.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/mipi_display.h>
 
 #include "dss.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
index bf407b6ba15c..d356a252ab4a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
@@ -18,7 +18,7 @@
 #include <linux/of.h>
 #include <linux/seq_file.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 0078c4d1fc31..47d7f69ad9ad 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -41,7 +41,7 @@
 #include <linux/suspend.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
index c886a2927f73..8fc843b56b26 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
@@ -23,7 +23,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h b/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
index c32a21a26054..f6de87e078b0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
@@ -23,7 +23,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/hdmi.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <sound/omap-hdmi-audio.h>
 
 #include "dss.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
index 2e71aec838b1..926a6f20dbb2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
@@ -33,7 +33,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <sound/omap-hdmi-audio.h>
 
 #include "hdmi4_core.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
index aade6d99662a..0ee829a165c3 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
@@ -38,7 +38,7 @@
 #include <linux/gpio.h>
 #include <linux/regulator/consumer.h>
 #include <linux/component.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <sound/omap-hdmi-audio.h>
 
 #include "hdmi5_core.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
index 1b8fcc6c4ba1..189a5ad125a3 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
@@ -4,7 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/err.h>
 #include <linux/of.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "hdmi.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
index 1f5d19c119ce..9a13c35fd6d8 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "hdmi.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
index 06e23a7c432c..eac3665aba6c 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "hdmi.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
index 7c544bc56fb5..705373e4cf38 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
@@ -14,7 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "hdmi.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
index a7414fb12830..9e2a67fdf4d2 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/manager.c b/drivers/video/fbdev/omap2/omapfb/dss/manager.c
index 08a67f4f6a20..986e3cfaa1d9 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/manager.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/manager.c
@@ -28,7 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/jiffies.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/output.c b/drivers/video/fbdev/omap2/omapfb/dss/output.c
index 16072159bd24..bed9a978269d 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/output.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/output.c
@@ -21,7 +21,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
index 4cc5ddebfb34..f1f6c0aea752 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
@@ -26,7 +26,7 @@
 #include <linux/kobject.h>
 #include <linux/platform_device.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/overlay.c b/drivers/video/fbdev/omap2/omapfb/dss/overlay.c
index 2f7cee985cdd..d6c5d75d2ef8 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/overlay.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/overlay.c
@@ -30,7 +30,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/pll.c b/drivers/video/fbdev/omap2/omapfb/dss/pll.c
index f974ddcd3b6e..0564c5606cd0 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/pll.c
@@ -22,7 +22,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c b/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
index aea6a1d0fb20..562b0c4ae0c6 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
@@ -38,7 +38,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include "dss.h"
 
 struct rfbi_reg { u16 idx; };
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/sdi.c b/drivers/video/fbdev/omap2/omapfb/dss/sdi.c
index d747cc6b59e1..c4be732a4714 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/sdi.c
@@ -29,7 +29,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include "dss.h"
 
 static struct {
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/venc.c b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
index 26e0ee30adf8..392464da12e4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/venc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/venc.c
@@ -37,7 +37,7 @@
 #include <linux/of.h>
 #include <linux/component.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c b/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
index b1ec59e42940..a890540f2037 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #include "dss.h"
 #include "dss_features.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
index 9ddfdd63b84c..ef69273074ba 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -30,7 +30,7 @@
 #include <linux/export.h>
 #include <linux/sizes.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omapvrfb.h>
 
 #include "omapfb.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index d3af01c94a58..2fb90cb6803f 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -30,7 +30,7 @@
 #include <linux/platform_device.h>
 #include <linux/omapfb.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omapvrfb.h>
 
 #include "omapfb.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 18fa9e1d0033..8087a009c54f 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -29,7 +29,7 @@
 #include <linux/mm.h>
 #include <linux/omapfb.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 #include <video/omapvrfb.h>
 
 #include "omapfb.h"
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb.h b/drivers/video/fbdev/omap2/omapfb/omapfb.h
index 623cd872a367..bcb9ff4a607d 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb.h
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb.h
@@ -31,7 +31,7 @@
 #include <linux/dma-attrs.h>
 #include <linux/dma-mapping.h>
 
-#include <video/omapdss.h>
+#include <video/omapfb_dss.h>
 
 #ifdef DEBUG
 extern bool omapfb_debug;
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h b/include/video/omapfb_dss.h
similarity index 64%
copy from drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h
copy to include/video/omapfb_dss.h
index 139f7297c7b4..4f9ad9d4c2fb 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_xgmac.h
+++ b/include/video/omapfb_dss.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2014-2015 Hisilicon Limited.
+ * Copyright (C) 2016 Texas Instruments, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -7,9 +7,9 @@
  * (at your option) any later version.
  */
 
-#ifndef _HNS_XGMAC_H
-#define _HNS_XGMAC_H
+#ifndef __OMAPFB_DSS_H
+#define __OMAPFB_DSS_H
 
-#define ETH_XGMAC_DUMP_NUM		(214)
+#include <video/omapdss.h>
 
-#endif
+#endif /* __OMAPFB_DSS_H */
-- 
2.8.3
