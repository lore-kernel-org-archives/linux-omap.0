From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 06/23] drm: omapdrm: wait for pending operations before updating plane
Date: Tue,  8 Mar 2016 17:39:38 +0100
Message-ID: <1457455195-1938-7-git-send-email-sre@kernel.org>
References: <1457455195-1938-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457455195-1938-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Updating the plane may interrupt ongoing display
updates, so wait for any pending operations.

Signed-off-By: Sebastian Reichel <sre@kernel.org>
---
 drivers/gpu/drm/omapdrm/omap_drv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index a3ff35f5f6cd..e142a4245766 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -95,6 +95,10 @@ static void omap_atomic_complete(struct omap_atomic_state_commit *commit)
 	/* Apply the atomic update. */
 	dispc_runtime_get();
 
+	dev_dbg(dev->dev, "omap_atomic_complete");
+
+	omap_atomic_wait_for_completion(dev, old_state);
+
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 	drm_atomic_helper_commit_planes(dev, old_state, false);
 	drm_atomic_helper_commit_modeset_enables(dev, old_state);
-- 
2.7.0
