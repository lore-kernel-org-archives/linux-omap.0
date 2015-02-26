From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/21] drm/omap: fix encoder-crtc mapping
Date: Thu, 26 Feb 2015 15:20:09 +0200
Message-ID: <1424956829-22892-2-git-send-email-tomi.valkeinen@ti.com>
References: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38297 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932078AbbBZNVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Feb 2015 08:21:00 -0500
In-Reply-To: <1424956829-22892-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP DSS hardware supports changing the output port to which an overlay
manager's video stream goes. For example, DPI video stream can come from
any of the four overlay managers on OMAP5.

However, as it's difficult to manage the change in the driver, the
omapdss driver does not support that at the moment, and has a hardcoded
overlay manager per output.

omapdrm, on the other hand, uses the hardware features to find out which
overlay manager to use for an output, which causes problems. For
example, on OMAP5, omapdrm tries to use DIGIT overlay manager for DPI
output, instead of the LCD3 required by the omapdss driver.

This patch changes the omapdrm to use the omapdss driver's hardcoded
overlay managers, which fixes the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 8241ed9b353c..95e0356bf047 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -286,14 +286,13 @@ static int omap_modeset_init(struct drm_device *dev)
 		for (id = 0; id < priv->num_crtcs; id++) {
 			struct drm_crtc *crtc = priv->crtcs[id];
 			enum omap_channel crtc_channel;
-			enum omap_dss_output_id supported_outputs;
 
 			crtc_channel = omap_crtc_channel(crtc);
-			supported_outputs =
-				dss_feat_get_supported_outputs(crtc_channel);
 
-			if (supported_outputs & output->id)
+			if (output->dispc_channel == crtc_channel) {
 				encoder->possible_crtcs |= (1 << id);
+				break;
+			}
 		}
 
 		omap_dss_put_device(output);
-- 
2.3.0

