From: Dimitar Dimitrov <dinuxbg@gmail.com>
Subject: [RFC PATCH] OMAPDSS: DISPC: Fix IRQ unregister race
Date: Sun,  2 Sep 2012 22:12:03 +0300
Message-ID: <1346613123-24053-1-git-send-email-dinuxbg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:56574 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab2IBTKy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 Sep 2012 15:10:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Dimitar Dimitrov <dinuxbg@gmail.com>

Very rare kernel crashes are reported on a custom OMAP4 board. Kernel
panics due to corrupted completion structure while executing
dispc_irq_wait_handler(). Excerpt from kernel log:

  Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP
  Unable to handle kernel paging request at virtual address 00400130
  ...
  PC is at 0xebf205bc
  LR is at __wake_up_common+0x54/0x94
  ...
  (__wake_up_common+0x0/0x94)
  (complete+0x0/0x60)
  (dispc_irq_wait_handler.36902+0x0/0x14)
  (omap_dispc_irq_handler+0x0/0x354)
  (handle_irq_event_percpu+0x0/0x188)
  (handle_irq_event+0x0/0x64)
  (handle_fasteoi_irq+0x0/0x10c)
  (generic_handle_irq+0x0/0x48)
  (asm_do_IRQ+0x0/0xc0)

DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
unregister_isr() and DISPC IRQ might be running in parallel on different
CPUs. So there is a chance that a callback is executed even though it
has been unregistered. As omap_dispc_wait_for_irq_timeout() declares a
completion on stack, the dispc_irq_wait_handler() callback might try to
access a completion structure that is invalid. This leads to crashes and
hangs.

Solution is to divide unregister calls into two sets:
  1. Non-strict unregistering of callbacks. Callbacks could safely be
     executed after unregistering them. This is the case with unregister
     calls from the IRQ handler itself.
  2. Strict (synchronized) unregistering. Callbacks are not allowed
     after unregistering. This is the case with completion waiting.

The above solution should satisfy one of the original intentions of the
driver: callbacks should be able to unregister themselves.

Signed-off-by: Dimitar Dimitrov <dinuxbg@gmail.com>
---

WARNING: This bug is quite old. The patch has been tested on v3.0. No testing
has been done after rebasing to v3.6. Hence the RFC tag. Hopefully someone
will beat me in testing with latest linux-omap/master.

 drivers/media/video/omap/omap_vout.c |    4 +--
 drivers/staging/omapdrm/omap_plane.c |    2 +-
 drivers/video/omap2/dss/apply.c      |    2 +-
 drivers/video/omap2/dss/dispc.c      |   47 +++++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dsi.c        |    4 +--
 drivers/video/omap2/dss/rfbi.c       |    2 +-
 include/video/omapdss.h              |    3 ++-
 7 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index 88cf9d9..d06896e 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -976,7 +976,7 @@ static int omap_vout_release(struct file *file)
 
 		mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_EVEN |
 			DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_VSYNC2;
-		omap_dispc_unregister_isr(omap_vout_isr, vout, mask);
+		omap_dispc_unregister_isr_sync(omap_vout_isr, vout, mask);
 		vout->streaming = 0;
 
 		videobuf_streamoff(q);
@@ -1722,7 +1722,7 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 	mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD
 		| DISPC_IRQ_VSYNC2;
 
-	omap_dispc_unregister_isr(omap_vout_isr, vout, mask);
+	omap_dispc_unregister_isr_sync(omap_vout_isr, vout, mask);
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
diff --git a/drivers/staging/omapdrm/omap_plane.c b/drivers/staging/omapdrm/omap_plane.c
index 7997be7..8d8aa5b 100644
--- a/drivers/staging/omapdrm/omap_plane.c
+++ b/drivers/staging/omapdrm/omap_plane.c
@@ -82,7 +82,7 @@ static void dispc_isr(void *arg, uint32_t mask)
 	struct omap_plane *omap_plane = to_omap_plane(plane);
 	struct omap_drm_private *priv = plane->dev->dev_private;
 
-	omap_dispc_unregister_isr(dispc_isr, plane,
+	omap_dispc_unregister_isr_nosync(dispc_isr, plane,
 			id2irq[omap_plane->ovl->id]);
 
 	queue_work(priv->wq, &omap_plane->work);
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 0fefc68..9386834 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -847,7 +847,7 @@ static void dss_unregister_vsync_isr(void)
 	for (i = 0; i < num_mgrs; ++i)
 		mask |= dispc_mgr_get_framedone_irq(i);
 
-	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
+	r = omap_dispc_unregister_isr_nosync(dss_apply_irq_handler, NULL, mask);
 	WARN_ON(r);
 
 	dss_data.irq_enabled = false;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5b289c5..23d5881 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2351,7 +2351,7 @@ static void dispc_mgr_enable_lcd_out(enum omap_channel channel, bool enable)
 					msecs_to_jiffies(100)))
 			DSSERR("timeout waiting for FRAME DONE\n");
 
-		r = omap_dispc_unregister_isr(dispc_disable_isr,
+		r = omap_dispc_unregister_isr_sync(dispc_disable_isr,
 				&frame_done_completion, irq);
 
 		if (r)
@@ -2420,8 +2420,8 @@ static void dispc_mgr_enable_digit_out(bool enable)
 					enable ? "start" : "stop");
 	}
 
-	r = omap_dispc_unregister_isr(dispc_disable_isr, &frame_done_completion,
-			irq_mask);
+	r = omap_dispc_unregister_isr_sync(dispc_disable_isr,
+			&frame_done_completion, irq_mask);
 	if (r)
 		DSSERR("failed to unregister %x isr\n", irq_mask);
 
@@ -3319,7 +3319,8 @@ err:
 }
 EXPORT_SYMBOL(omap_dispc_register_isr);
 
-int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+/* WARNING: callback might be executed even after this function returns! */
+int omap_dispc_unregister_isr_nosync(omap_dispc_isr_t isr, void *arg, u32 mask)
 {
 	int i;
 	unsigned long flags;
@@ -3351,7 +3352,37 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 
 	return ret;
 }
-EXPORT_SYMBOL(omap_dispc_unregister_isr);
+EXPORT_SYMBOL(omap_dispc_unregister_isr_nosync);
+
+/*
+ * Ensure that callback <isr> will NOT be executed after this function
+ * returns. Must be called from sleepable context, though!
+ */
+int omap_dispc_unregister_isr_sync(omap_dispc_isr_t isr, void *arg, u32 mask)
+{
+	int ret;
+
+	ret = omap_dispc_unregister_isr_nosync(isr, arg, mask);
+
+	/* Task context is not really needed. But if we're called from atomic
+	 * context, it is probably from DISPC IRQ, where we will deadlock.
+	 * So use might_sleep() to catch potential deadlocks.
+	 */
+	might_sleep();
+
+#if defined(CONFIG_SMP)
+	/* DISPC IRQ executes callbacks with dispc.irq_lock released. Hence
+	 * unregister_isr() and DISPC IRQ might be running in parallel on
+	 * different CPUs. So there is a chance that a callback is executed
+	 * even though it has been unregistered. Add a barrier, in order to
+	 * ensure that after returning from this function, the new DISPC IRQ
+	 * will use an updated callback array, and NOT its cached copy.
+	 */
+	synchronize_irq(dispc.irq);
+#endif
+
+	return ret;
+}
 
 #ifdef DEBUG
 static void print_irq_status(u32 status)
@@ -3566,7 +3597,8 @@ int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)
 
 	timeout = wait_for_completion_timeout(&completion, timeout);
 
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+	omap_dispc_unregister_isr_sync(dispc_irq_wait_handler, &completion,
+			irqmask);
 
 	if (timeout == 0)
 		return -ETIMEDOUT;
@@ -3597,7 +3629,8 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	timeout = wait_for_completion_interruptible_timeout(&completion,
 			timeout);
 
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+	omap_dispc_unregister_isr_sync(dispc_irq_wait_handler, &completion,
+			irqmask);
 
 	if (timeout == 0)
 		return -ETIMEDOUT;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b07e886..46f6c6c 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4430,7 +4430,7 @@ static int dsi_display_init_dispc(struct omap_dss_device *dssdev)
 	return 0;
 err1:
 	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_CMD_MODE)
-		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
+		omap_dispc_unregister_isr_sync(dsi_framedone_irq_callback,
 			(void *) dssdev, irq);
 err:
 	return r;
@@ -4443,7 +4443,7 @@ static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 
 		irq = dispc_mgr_get_framedone_irq(dssdev->manager->id);
 
-		omap_dispc_unregister_isr(dsi_framedone_irq_callback,
+		omap_dispc_unregister_isr_sync(dsi_framedone_irq_callback,
 			(void *) dssdev, irq);
 	}
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 7c08742..31d167c 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -930,7 +930,7 @@ EXPORT_SYMBOL(omapdss_rfbi_display_enable);
 
 void omapdss_rfbi_display_disable(struct omap_dss_device *dssdev)
 {
-	omap_dispc_unregister_isr(framedone_callback, NULL,
+	omap_dispc_unregister_isr_sync(framedone_callback, NULL,
 			DISPC_IRQ_FRAMEDONE);
 	omap_dss_stop_device(dssdev);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a6267a2..2287368 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -707,7 +707,8 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
-int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
+int omap_dispc_unregister_isr_sync(omap_dispc_isr_t isr, void *arg, u32 mask);
+int omap_dispc_unregister_isr_nosync(omap_dispc_isr_t isr, void *arg, u32 mask);
 
 int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout);
 int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
-- 
1.7.10.4

