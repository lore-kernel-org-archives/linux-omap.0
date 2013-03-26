From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 1/8] drm/omap: Don't return from modeset_init if a panel doesn't satisfy omapdrm requirements
Date: Tue, 26 Mar 2013 19:15:18 +0530
Message-ID: <1364305525-28496-2-git-send-email-archit@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com>
 <1364305525-28496-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35657 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934350Ab3CZNq0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Mar 2013 09:46:26 -0400
In-Reply-To: <1364305525-28496-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, robdclark@gmail.com, andy.gross@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Archit Taneja <archit@ti.com>

modeset_init iterates through all the registered omapdss devices and has some
initial checks to see if the panel has a driver and the required driver ops for
it to be usable by omapdrm.

The function bails out from modeset_init if a panel doesn't meet the
requirements, and stops the registration of the future panels and encoders which
come after it, that isn't the correct thing to do, we should go through the rest
of the panels. Replace the 'return's with 'continue's.

Reviewed-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/gpu/drm/omapdrm/omap_drv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 079c54c..77b7225 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -121,7 +121,7 @@ static int omap_modeset_init(struct drm_device *dev)
 		if (!dssdev->driver) {
 			dev_warn(dev->dev, "%s has no driver.. skipping it\n",
 					dssdev->name);
-			return 0;
+			continue;
 		}
 
 		if (!(dssdev->driver->get_timings ||
@@ -129,7 +129,7 @@ static int omap_modeset_init(struct drm_device *dev)
 			dev_warn(dev->dev, "%s driver does not support "
 				"get_timings or read_edid.. skipping it!\n",
 				dssdev->name);
-			return 0;
+			continue;
 		}
 
 		encoder = omap_encoder_init(dev, dssdev);
-- 
1.7.10.4

