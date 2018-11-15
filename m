From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4 3/6] drm/omap: don't check dispc timings for DSI
Date: Fri, 16 Nov 2018 00:06:42 +0100
Message-ID: <20181115230645.15748-4-sebastian.reichel@collabora.com>
References: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115230645.15748-1-sebastian.reichel@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
List-Id: linux-omap@vger.kernel.org

While all display types only forward their VM to the DISPC, this
is not true for DSI. DSI calculates the VM for DISPC based on its
own, but its not identical. Actually the DSI VM is not even a valid
DISPC VM making this check fail. Let's restore the old behaviour
and avoid checking the DISPC VM for DSI here.

Fixes: 7c27fa57ef31 ("drm/omap: Call dispc timings check operation directly")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/gpu/drm/omapdrm/omap_connector.c | 8 +++++---
 drivers/gpu/drm/omapdrm/omap_encoder.c   | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_connector.c b/drivers/gpu/drm/omapdrm/omap_connector.c
index b81302c4bf9e..5c776d6211e1 100644
--- a/drivers/gpu/drm/omapdrm/omap_connector.c
+++ b/drivers/gpu/drm/omapdrm/omap_connector.c
@@ -280,9 +280,11 @@ static int omap_connector_mode_valid(struct drm_connector *connector,
 	drm_display_mode_to_videomode(mode, &vm);
 	mode->vrefresh = drm_mode_vrefresh(mode);
 
-	r = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
-	if (r)
-		goto done;
+	if (omap_connector->display->type != OMAP_DISPLAY_TYPE_DSI) {
+		r = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
+		if (r)
+			goto done;
+	}
 
 	for (dssdev = omap_connector->output; dssdev; dssdev = dssdev->next) {
 		if (!dssdev->ops->check_timings)
diff --git a/drivers/gpu/drm/omapdrm/omap_encoder.c b/drivers/gpu/drm/omapdrm/omap_encoder.c
index 452e625f6ce3..32bbe3a80e7d 100644
--- a/drivers/gpu/drm/omapdrm/omap_encoder.c
+++ b/drivers/gpu/drm/omapdrm/omap_encoder.c
@@ -170,9 +170,11 @@ static int omap_encoder_atomic_check(struct drm_encoder *encoder,
 
 	drm_display_mode_to_videomode(&crtc_state->mode, &vm);
 
-	ret = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
-	if (ret)
-		goto done;
+	if (omap_encoder->display->type != OMAP_DISPLAY_TYPE_DSI) {
+		ret = priv->dispc_ops->mgr_check_timings(priv->dispc, channel, &vm);
+		if (ret)
+			goto done;
+	}
 
 	for (dssdev = omap_encoder->output; dssdev; dssdev = dssdev->next) {
 		if (!dssdev->ops->check_timings)
-- 
2.19.1
