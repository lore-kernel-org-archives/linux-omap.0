From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 08/23] OMAPDRM: Remove manager->device references
Date: Thu, 30 Aug 2012 17:10:30 +0530
Message-ID: <1346326845-16583-9-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
 <1346326845-16583-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34259 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab2H3Lmv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Aug 2012 07:42:51 -0400
In-Reply-To: <1346326845-16583-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

With the introduction of output entities, managers will now connect to outputs.
Use the helper op for managers named get_device. This will abstract away the
information on how to get the device from an overlay manager.

Using the helper function will reduce the number of pointer dereferences a user
of OMAPDSS needs to do and reduce risk of a NULL dereference.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/staging/omapdrm/omap_drv.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_drv.c b/drivers/staging/omapdrm/omap_drv.c
index 4beab94..64a354a 100644
--- a/drivers/staging/omapdrm/omap_drv.c
+++ b/drivers/staging/omapdrm/omap_drv.c
@@ -106,7 +106,8 @@ static void dump_video_chains(void)
 	for (i = 0; i < omap_dss_get_num_overlays(); i++) {
 		struct omap_overlay *ovl = omap_dss_get_overlay(i);
 		struct omap_overlay_manager *mgr = ovl->manager;
-		struct omap_dss_device *dssdev = mgr ? mgr->device : NULL;
+		struct omap_dss_device *dssdev = mgr ?
+					mgr->get_device(mgr) : NULL;
 		if (dssdev) {
 			DBG("%d: %s -> %s -> %s", i, ovl->name, mgr->name,
 						dssdev->name);
@@ -185,7 +186,7 @@ static int create_connector(struct drm_device *dev,
 	for (j = 0; j < priv->num_encoders; j++) {
 		struct omap_overlay_manager *mgr =
 			omap_encoder_get_manager(priv->encoders[j]);
-		if (mgr->device == dssdev) {
+		if (mgr->get_device(mgr) == dssdev) {
 			drm_mode_connector_attach_encoder(connector,
 					priv->encoders[j]);
 		}
-- 
1.7.9.5

