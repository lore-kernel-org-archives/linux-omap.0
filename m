From: Joe Perches <joe@perches.com>
Subject: [PATCH 16/18] video: fbdev: omap: Move inline before return type
Date: Wed,  5 Jul 2017 13:02:25 -0700
Message-ID: <bc5927726abc70d7c066df7ab4cb7cfce4a7b577.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1499284835.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Make the code like the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/omap/lcdc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/omap/lcdc.c b/drivers/video/fbdev/omap/lcdc.c
index e3d9b9ea5498..938cba0d24ae 100644
--- a/drivers/video/fbdev/omap/lcdc.c
+++ b/drivers/video/fbdev/omap/lcdc.c
@@ -79,12 +79,12 @@ static struct omap_lcd_controller {
 	unsigned long		vram_size;
 } lcdc;
 
-static void inline enable_irqs(int mask)
+static inline void enable_irqs(int mask)
 {
 	lcdc.irq_mask |= mask;
 }
 
-static void inline disable_irqs(int mask)
+static inline void disable_irqs(int mask)
 {
 	lcdc.irq_mask &= ~mask;
 }
@@ -466,7 +466,7 @@ static void calc_ck_div(int is_tft, int pck, int *pck_div)
 	}
 }
 
-static void inline setup_regs(void)
+static inline void setup_regs(void)
 {
 	u32 l;
 	struct lcd_panel *panel = lcdc.fbdev->panel;
-- 
2.10.0.rc2.1.g053435c
