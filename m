From: Rob Clark <rob.clark@linaro.org>
Subject: [PATCH 1/3] staging: drm/omap: avoid multiple planes having same
	z-order
Date: Sun, 11 Mar 2012 21:11:20 -0500
Message-ID: <1331518282-6870-1-git-send-email-rob.clark@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
Errors-To: dri-devel-bounces+sf-dri-devel=m.gmane.org@lists.freedesktop.org
To: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Rob Clark <rob@ti.com>, patches@linaro.org
List-Id: linux-omap@vger.kernel.org

From: Rob Clark <rob@ti.com>

Multiple video pipes on same output with same z-order is an undefined
behavior.  Set a unique z-order value based on overlay number/id.

Signed-off-by: Rob Clark <rob@ti.com>
---
 drivers/staging/omapdrm/omap_plane.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 55ddc58..9b3bfa0 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -439,7 +439,7 @@ struct drm_plane *omap_plane_init(struct drm_device *dev,
 	if (priv)
 		omap_plane->info.zorder = 0;
 	else
-		omap_plane->info.zorder = 1;
+		omap_plane->info.zorder = ovl->id;
 
 	update_manager(plane);
 
-- 
1.7.5.4
