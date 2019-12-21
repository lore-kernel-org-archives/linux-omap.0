From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] drm/omap: gem: Fix tearing with BO_TILED
Date: Fri, 20 Dec 2019 16:57:11 -0800
Message-ID: <20191221005711.47314-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, "H . Nikolaus Schaller" <hns@goldelico.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On my droid4 I noticed bad constant tearing on the LCD with stellarium in
landscape mode with xorg-video-omap rotated with xrandr --rotate right.
Every second or so update gets squeezed down in size to only the top half
of the LCD panel.

This issue does not happen with xrandr --rotate normal, or when HDMI
display is also connected. Looks like xorg-video-omap switches to tiled
mode in the the rotated case.

Looking around what might affect BO_TILED, I noticed Matthijs had this
change in his earlier pyra tiler patches. The earlier patch "XXX omapdrm:
force tiled buffers to be pinned and page-aligned" has no commit log
though, so I'm not sure what other issues this might fix.

This is with the old pvr-omap4 driver, but presumably the same issue
exists in all cases.

Cc: H. Nikolaus Schaller <hns@goldelico.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---


Matthijs, do you have some more info to add to the description?


 drivers/gpu/drm/omapdrm/omap_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -789,7 +789,7 @@ int omap_gem_pin(struct drm_gem_object *obj, dma_addr_t *dma_addr)
 			if (omap_obj->flags & OMAP_BO_TILED_MASK) {
 				block = tiler_reserve_2d(fmt,
 						omap_obj->width,
-						omap_obj->height, 0);
+						omap_obj->height, PAGE_SIZE);
 			} else {
 				block = tiler_reserve_1d(obj->size);
 			}
-- 
2.24.1
