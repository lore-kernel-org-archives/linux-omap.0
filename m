From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4 4/6] drm/omap: fix incorrect union usage
Date: Fri, 16 Nov 2018 00:06:43 +0100
Message-ID: <20181115230645.15748-5-sebastian.reichel@collabora.com>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

The DSI encoder sets dssdev->ops->dsi.set_config, which is stored at the
same offset as dssdev->ops->hdmi.set_hdmi_mode. The code in omap_encoder
only checks if dssdev->ops->hdmi.set_hdmi_mode is NULL. Due to the way
union works, it won't be NULL if dsi.set_config is set. This means
dsi_set_config will be called with config=hdmi_mode=false=NULL parameter
resulting in a NULL dereference. Also the dereference happens while
console is locked, so kernel hangs without any debug output (can be
avoided by fbmem's lockless_register_fb=1 parameter).

This fixes the issue by exiting early if the output type definitely
has no hdmi_set operations.

Fixes: 83910ad3f51fb ("drm/omap: Move most omap_dss_driver operations to omap_dss_device_ops")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_encoder.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 32bbe3a80e7d..ba0099f0644c 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -122,6 +122,14 @@ static void omap_encoder_mode_set(struct drm_encoder *encoder,
 
 	dssdev = omap_encoder->output;
 
+	/* The following operations access dssdev->ops->hdmi, which is a union
+	 * also used by DSI. This ensures, that the field does not have data
+	 * for DSI (or any other future output type).
+	 */
+	if (dssdev->output_type != OMAP_DISPLAY_TYPE_HDMI &&
+	    dssdev->output_type != OMAP_DISPLAY_TYPE_DVI)
+		return;
+
 	if (dssdev->ops->hdmi.set_hdmi_mode)
 		dssdev->ops->hdmi.set_hdmi_mode(dssdev, hdmi_mode);
 
-- 
2.19.1
