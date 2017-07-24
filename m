From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCHv1 01/14] drm/omap: remove unused function defines
Date: Mon, 24 Jul 2017 19:32:58 +0200
Message-ID: <20170724173311.27170-2-sebastian.reichel@collabora.co.uk>
References: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724173311.27170-1-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sebastian.reichel@collabora.co.uk>
List-Id: linux-omap@vger.kernel.org

Remove driver (un)register API defines. They do not even exist
anymore.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 drivers/gpu/drm/omapdrm/dss/omapdss.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 85953a0bc7c2..4e619ff360ae 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -575,9 +575,6 @@ struct omap_dss_driver {
 enum omapdss_version omapdss_get_version(void);
 bool omapdss_is_initialized(void);
 
-int omap_dss_register_driver(struct omap_dss_driver *);
-void omap_dss_unregister_driver(struct omap_dss_driver *);
-
 int omapdss_register_display(struct omap_dss_device *dssdev);
 void omapdss_unregister_display(struct omap_dss_device *dssdev);
 
-- 
2.13.2
