From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 07/14] drm/omap: add support for physical size hints from display drivers
Date: Mon, 24 Jul 2017 19:33:04 +0200
Message-ID: <20170724173311.27170-8-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

While physical size information is automatically parsed for EDID
based displays, we need to provide it manually for displays providing
one fixed mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h    | 2 ++
 drivers/gpu/drm/omapdrm/omap_connector.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 4e619ff360ae..530365e9c48d 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -560,6 +560,8 @@ struct omap_dss_driver {
 			    struct videomode *vm);
 	void (*get_timings)(struct omap_dss_device *dssdev,
 			    struct videomode *vm);
+	void (*get_size)(struct omap_dss_device *dssdev,
+			 unsigned int *width, unsigned int *height);
 
 	int (*set_wss)(struct omap_dss_device *dssdev, u32 wss);
 	u32 (*get_wss)(struct omap_dss_device *dssdev);
diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index 5e941305ab1b..b2678105aaf2 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -136,6 +136,12 @@ static int omap_connector_get_modes(struct drm_connector *connector)
 		drm_mode_set_name(mode);
 		drm_mode_probed_add(connector, mode);
 
+		if (dssdrv->get_size) {
+			dssdrv->get_size(dssdev,
+					 &connector->display_info.width_mm,
+					 &connector->display_info.height_mm);
+		}
+
 		n = 1;
 	}
 
-- 
2.13.2
