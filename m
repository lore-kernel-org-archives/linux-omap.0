From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 04/23] drm: omapdrm: add DSI mapping
Date: Tue,  8 Mar 2016 17:39:36 +0100
Message-ID: <1457455195-1938-5-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This sets proper connector type for DSI connected panels.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index dfafdb602ad2..a3ff35f5f6cd 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -215,6 +215,8 @@ static int get_connector_type(struct omap_dss_device *dssdev)
 		return DRM_MODE_CONNECTOR_HDMIA;
 	case OMAP_DISPLAY_TYPE_DVI:
 		return DRM_MODE_CONNECTOR_DVID;
+	case OMAP_DISPLAY_TYPE_DSI:
+		return DRM_MODE_CONNECTOR_DSI;
 	default:
 		return DRM_MODE_CONNECTOR_Unknown;
 	}
-- 
2.7.0
