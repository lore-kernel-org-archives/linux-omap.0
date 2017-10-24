From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] video: fbdev: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 08:20:26 -0700
Message-ID: <20171024152026.GA104655@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, David Lechner <david@lechnology.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <seanpaul@chromium.org>, Jean Delvare <jdelvare@suse.de>, Hans de Goede <hdegoede@redhat.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. One tracking pointer was added, and
one initialization was cleaned up.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: David Lechner <david@lechnology.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jean Delvare <jdelvare@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/video/fbdev/aty/radeon_base.c      |  8 +++-----
 drivers/video/fbdev/core/fbcon.c           | 10 +++++-----
 drivers/video/fbdev/core/fbcon.h           |  1 +
 drivers/video/fbdev/omap/hwa742.c          |  6 ++----
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c |  6 ++----
 drivers/video/fbdev/pxa3xx-gcu.c           | 12 ++++--------
 6 files changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 8ad1643e7d1c..4d77daeecf99 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1454,9 +1454,9 @@ static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_reg
 /*
  * Timer function for delayed LVDS panel power up/down
  */
-static void radeon_lvds_timer_func(unsigned long data)
+static void radeon_lvds_timer_func(struct timer_list *t)
 {
-	struct radeonfb_info *rinfo = (struct radeonfb_info *)data;
+	struct radeonfb_info *rinfo = from_timer(rinfo, t, lvds_timer);
 
 	radeon_engine_idle();
 
@@ -2291,9 +2291,7 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->pdev = pdev;
 	
 	spin_lock_init(&rinfo->reg_lock);
-	init_timer(&rinfo->lvds_timer);
-	rinfo->lvds_timer.function = radeon_lvds_timer_func;
-	rinfo->lvds_timer.data = (unsigned long)rinfo;
+	timer_setup(&rinfo->lvds_timer, radeon_lvds_timer_func, 0);
 
 	c1 = ent->device >> 8;
 	c2 = ent->device & 0xff;
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 04612f938bab..3b4a96379128 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -395,10 +395,10 @@ static void fb_flashcursor(struct work_struct *work)
 	console_unlock();
 }
 
-static void cursor_timer_handler(unsigned long dev_addr)
+static void cursor_timer_handler(struct timer_list *t)
 {
-	struct fb_info *info = (struct fb_info *) dev_addr;
-	struct fbcon_ops *ops = info->fbcon_par;
+	struct fbcon_ops *ops = from_timer(ops, t, cursor_timer);
+	struct fb_info *info = ops->info;
 
 	queue_work(system_power_efficient_wq, &info->queue);
 	mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
@@ -414,8 +414,7 @@ static void fbcon_add_cursor_timer(struct fb_info *info)
 		if (!info->queue.func)
 			INIT_WORK(&info->queue, fb_flashcursor);
 
-		setup_timer(&ops->cursor_timer, cursor_timer_handler,
-			    (unsigned long) info);
+		timer_setup(&ops->cursor_timer, cursor_timer_handler, 0);
 		mod_timer(&ops->cursor_timer, jiffies + ops->cur_blink_jiffies);
 		ops->flags |= FBCON_FLAGS_CURSOR_TIMER;
 	}
@@ -714,6 +713,7 @@ static int con2fb_acquire_newinfo(struct vc_data *vc, struct fb_info *info,
 
 	if (!err) {
 		ops->cur_blink_jiffies = HZ / 5;
+		ops->info = info;
 		info->fbcon_par = ops;
 
 		if (vc)
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 18f3ac144237..9f7744fbc962 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -69,6 +69,7 @@ struct fbcon_ops {
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_cursor cursor_state;
 	struct display *p;
+	struct fb_info *info;
         int    currcon;	                /* Current VC. */
 	int    cur_blink_jiffies;
 	int    cursor_flash;
diff --git a/drivers/video/fbdev/omap/hwa742.c b/drivers/video/fbdev/omap/hwa742.c
index a4ee65b8f918..6199d4806193 100644
--- a/drivers/video/fbdev/omap/hwa742.c
+++ b/drivers/video/fbdev/omap/hwa742.c
@@ -474,7 +474,7 @@ static void auto_update_complete(void *data)
 			  jiffies + HWA742_AUTO_UPDATE_TIME);
 }
 
-static void hwa742_update_window_auto(unsigned long arg)
+static void hwa742_update_window_auto(struct timer_list *unused)
 {
 	LIST_HEAD(req_list);
 	struct hwa742_request *last;
@@ -1002,9 +1002,7 @@ static int hwa742_init(struct omapfb_device *fbdev, int ext_mode,
 	hwa742.auto_update_window.height = fbdev->panel->y_res;
 	hwa742.auto_update_window.format = 0;
 
-	init_timer(&hwa742.auto_update_timer);
-	hwa742.auto_update_timer.function = hwa742_update_window_auto;
-	hwa742.auto_update_timer.data = 0;
+	timer_setup(&hwa742.auto_update_timer, hwa742_update_window_auto, 0);
 
 	hwa742.prev_color_mode = -1;
 	hwa742.prev_flags = 0;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
index 30d49f3800b3..8e1d60d48dbb 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
@@ -3988,7 +3988,7 @@ static void dsi_update_screen_dispc(struct platform_device *dsidev)
 }
 
 #ifdef DSI_CATCH_MISSING_TE
-static void dsi_te_timeout(unsigned long arg)
+static void dsi_te_timeout(struct timer_list *unused)
 {
 	DSSERR("TE not received for 250ms!\n");
 }
@@ -5298,9 +5298,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 			     dsi_framedone_timeout_work_callback);
 
 #ifdef DSI_CATCH_MISSING_TE
-	init_timer(&dsi->te_timer);
-	dsi->te_timer.function = dsi_te_timeout;
-	dsi->te_timer.data = 0;
+	timer_setup(&dsi->te_timer, dsi_te_timeout, 0);
 #endif
 
 	res = platform_get_resource_byname(dsidev, IORESOURCE_MEM, "proto");
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 933619da1a94..e88447eac32c 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -513,16 +513,10 @@ pxa3xx_gcu_mmap(struct file *file, struct vm_area_struct *vma)
 #ifdef PXA3XX_GCU_DEBUG_TIMER
 static struct timer_list pxa3xx_gcu_debug_timer;
 
-static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
+static void pxa3xx_gcu_debug_timedout(struct timer_list *unused)
 {
-	struct pxa3xx_gcu_priv *priv = (struct pxa3xx_gcu_priv *) ptr;
-
 	QERROR("Timer DUMP");
 
-	/* init the timer structure */
-	init_timer(&pxa3xx_gcu_debug_timer);
-	pxa3xx_gcu_debug_timer.function = pxa3xx_gcu_debug_timedout;
-	pxa3xx_gcu_debug_timer.data = ptr;
 	pxa3xx_gcu_debug_timer.expires = jiffies + 5*HZ; /* one second */
 
 	add_timer(&pxa3xx_gcu_debug_timer);
@@ -530,7 +524,9 @@ static void pxa3xx_gcu_debug_timedout(unsigned long ptr)
 
 static void pxa3xx_gcu_init_debug_timer(void)
 {
-	pxa3xx_gcu_debug_timedout((unsigned long) &pxa3xx_gcu_debug_timer);
+	/* init the timer structure */
+	timer_setup(&pxa3xx_gcu_debug_timer, pxa3xx_gcu_debug_timedout, 0);
+	pxa3xx_gcu_debug_timedout(NULL);
 }
 #else
 static inline void pxa3xx_gcu_init_debug_timer(void) {}
-- 
2.7.4


-- 
Kees Cook
Pixel Security
