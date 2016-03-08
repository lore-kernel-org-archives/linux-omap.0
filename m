From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 09/23] drm: omapdrm: dss: method to get stallmode from lcd config
Date: Tue,  8 Mar 2016 17:39:41 +0100
Message-ID: <1457455195-1938-10-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Introduce a new dss method for reading the stallmode
status from the private lcd config structure.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/dss/output.c | 6 ++++++
 include/video/omapdss.h              | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index 16072159bd24..b82e45938c9e 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -234,6 +234,12 @@ void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 }
 EXPORT_SYMBOL(dss_mgr_set_lcd_config);
 
+bool dss_lcd_mgr_config_get_stallmode(const struct dss_lcd_mgr_config *config)
+{
+	return config->stallmode;
+}
+EXPORT_SYMBOL(dss_lcd_mgr_config_get_stallmode);
+
 int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	return dss_mgr_ops->enable(mgr);
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 295b41e20d8e..9bde65b79220 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -975,6 +975,7 @@ int dss_mgr_register_framedone_handler(struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data);
 void dss_mgr_unregister_framedone_handler(struct omap_overlay_manager *mgr,
 		void (*handler)(void *), void *data);
+bool dss_lcd_mgr_config_get_stallmode(const struct dss_lcd_mgr_config *config);
 
 static inline bool omapdss_device_is_connected(struct omap_dss_device *dssdev)
 {
-- 
2.7.0
