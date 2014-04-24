From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH 02/13] video: omap2dss: fix LPAE warnings
Date: Thu, 24 Apr 2014 13:28:18 +0100
Message-ID: <1398342509-10243-3-git-send-email-peter.griffin@linaro.org>
References: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398342509-10243-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linaro-kernel@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>, Peter Griffin <peter.griffin@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

If LPAE is enabled, dma_addr_t is 64 bit, so we have to
change a few type for everything in this driver to match
again.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org
---
 drivers/video/fbdev/omap2/dss/dispc.c |    6 +++---
 include/video/omapdss.h               |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index f18397c..4fe1431 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -2577,9 +2577,9 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 
 	channel = dispc_ovl_get_channel_out(plane);
 
-	DSSDBG("dispc_ovl_setup %d, pa %x, pa_uv %x, sw %d, %d,%d, %dx%d -> "
-		"%dx%d, cmode %x, rot %d, mir %d, chan %d repl %d\n",
-		plane, oi->paddr, oi->p_uv_addr, oi->screen_width, oi->pos_x,
+	DSSDBG("dispc_ovl_setup %d, pa %pad, pa_uv %pad, sw %d, %d,%d, %dx%d ->"
+		" %dx%d, cmode %x, rot %d, mir %d, chan %d repl %d\n",
+		plane, &oi->paddr, &oi->p_uv_addr, oi->screen_width, oi->pos_x,
 		oi->pos_y, oi->width, oi->height, oi->out_width, oi->out_height,
 		oi->color_mode, oi->rotation, oi->mirror, channel, replication);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6adb445..ded61a9 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -388,8 +388,8 @@ struct omap_dss_cpr_coefs {
 };
 
 struct omap_overlay_info {
-	u32 paddr;
-	u32 p_uv_addr;  /* for NV12 format */
+	dma_addr_t paddr;
+	dma_addr_t p_uv_addr;  /* for NV12 format */
 	u16 screen_width;
 	u16 width;
 	u16 height;
-- 
1.7.9.5
