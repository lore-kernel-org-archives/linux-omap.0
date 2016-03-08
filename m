From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 22/23] drm: omapdrm: panel-dsi-cm: ratelimit debug output in update path
Date: Tue,  8 Mar 2016 17:39:54 +0100
Message-ID: <1457455195-1938-23-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Generating debug messages during display update results
in lot's of messages, if the display shows the console.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
index ca7fba59c760..196fe8d18ff4 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-dsi-cm.c
@@ -931,7 +931,7 @@ static int dsicm_update(struct omap_dss_device *dssdev,
 	struct omap_dss_device *in = ddata->in;
 	int r;
 
-	dev_dbg(&ddata->pdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
+	dev_dbg_ratelimited(&ddata->pdev->dev, "update %d, %d, %d x %d\n", x, y, w, h);
 
 	mutex_lock(&ddata->lock);
 	in->ops.dsi->bus_lock(in);
@@ -978,14 +978,14 @@ static int dsicm_sync(struct omap_dss_device *dssdev)
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
-	dev_dbg(&ddata->pdev->dev, "sync\n");
+	dev_dbg_ratelimited(&ddata->pdev->dev, "sync\n");
 
 	mutex_lock(&ddata->lock);
 	in->ops.dsi->bus_lock(in);
 	in->ops.dsi->bus_unlock(in);
 	mutex_unlock(&ddata->lock);
 
-	dev_dbg(&ddata->pdev->dev, "sync done\n");
+	dev_dbg_ratelimited(&ddata->pdev->dev, "sync done\n");
 
 	return 0;
 }
-- 
2.7.0
