From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 15/27] drm/omap: displays: Do not include video/omap-panel-data.h if not needed
Date: Fri, 3 Jun 2016 14:03:17 +0300
Message-ID: <20160603110329.9953-16-peter.ujfalusi@ti.com>
References: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160603110329.9953-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Some panel/encoder/connector driver includes omap-panel-data.h but they
do not need it. Remove the inclusion of video/omap-panel-data.h from these
drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c           | 1 -
 drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c        | 1 -
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c             | 1 -
 drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
index 2fd5602880a7..6b7d4fc3ac12 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tfp410.c
@@ -16,7 +16,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
index 916a89978387..f4f23f5cfe3e 100644
--- a/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
+++ b/drivers/gpu/drm/omapdrm/displays/encoder-tpd12s015.c
@@ -17,7 +17,6 @@
 #include <linux/gpio/consumer.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 struct panel_drv_data {
 	struct omap_dss_device dssdev;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index 36485c2137ce..6dcb75f6f0c5 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -26,7 +26,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 #include <video/mipi_display.h>
 
 /* DSI Virtual channel. Hardcoded for now. */
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
index 458f77bc473d..1bd682864217 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-lgphilips-lb035q02.c
@@ -17,7 +17,6 @@
 #include <linux/gpio.h>
 
 #include <video/omapdss.h>
-#include <video/omap-panel-data.h>
 
 static struct omap_video_timings lb035q02_timings = {
 	.x_res = 320,
-- 
2.8.3
