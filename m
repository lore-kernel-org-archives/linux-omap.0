From: Dimitar Dimitrov <dinuxbg@gmail.com>
Subject: [RFC PATCH v2] OMAPDSS: Fix IRQ unregister race
Date: Sat,  8 Sep 2012 18:05:53 +0300
Message-ID: <1347116753-17064-1-git-send-email-dinuxbg@gmail.com>
References: <201209071742.11735.dinuxbg@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57511 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754606Ab2IHPE5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Sep 2012 11:04:57 -0400
In-Reply-To: <201209071742.11735.dinuxbg@gmail.com>
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

Also fix DSI IRQ unregister which has similar logic to DISPC IRQ handling.

Signed-off-by: Dimitar Dimitrov <dinuxbg@gmail.com>
---

WARNING: This bug is quite old. The patch has been tested on v3.0. No testing
has been done after rebasing to v3.6. Hence the RFC tag. Hopefully someone
will beat me in testing with latest linux-omap/master.

Changes since v1 per Tomi Valkeinen's comments:
  - Don't rename omap_dispc_unregister_isr, just introduce nosync variant.
  - Apply the same fix for DSI IRQ which suffers from the same race condition.

 drivers/staging/omapdrm/omap_plane.c |    2 +-
 drivers/video/omap2/dss/apply.c      |    2 +-
 drivers/video/omap2/dss/dispc.c      |   45 +++++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dsi.c        |   19 ++++++++++++++
 include/video/omapdss.h              |    1 +
 5 files changed, 61 insertions(+), 8 deletions(-)

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
index ee9e296..a67d92c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2421,8 +2421,8 @@ static void dispc_mgr_enable_digit_out(bool enable)
 					enable ? "start" : "stop");
 	}
 
-	r = omap_dispc_unregister_isr(dispc_disable_isr, &frame_done_completion,
-			irq_mask);
+	r = omap_dispc_unregister_isr(dispc_disable_isr,
+			&frame_done_completion, irq_mask);
 	if (r)
 		DSSERR("failed to unregister %x isr\n", irq_mask);
 
@@ -3320,7 +3320,8 @@ err:
 }
 EXPORT_SYMBOL(omap_dispc_register_isr);
 
-int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+/* WARNING: callback might be executed even after this function returns! */
+int omap_dispc_unregister_isr_nosync(omap_dispc_isr_t isr, void *arg, u32 mask)
 {
 	int i;
 	unsigned long flags;
@@ -3352,7 +3353,37 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 
 	return ret;
 }
-EXPORT_SYMBOL(omap_dispc_unregister_isr);
+EXPORT_SYMBOL(omap_dispc_unregister_isr_nosync);
+
+/*
+ * Ensure that callback <isr> will NOT be executed after this function
+ * returns. Must be called from sleepable context, though!
+ */
+int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
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
@@ -3567,7 +3598,8 @@ int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)
 
 	timeout = wait_for_completion_timeout(&completion, timeout);
 
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion,
+			irqmask);
 
 	if (timeout == 0)
 		return -ETIMEDOUT;
@@ -3598,7 +3630,8 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	timeout = wait_for_completion_interruptible_timeout(&completion,
 			timeout);
 
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion,
+			irqmask);
 
 	if (timeout == 0)
 		return -ETIMEDOUT;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index b07e886..24b4a3e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -960,6 +960,13 @@ static int dsi_unregister_isr(struct platform_device *dsidev,
 
 	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
+	might_sleep();
+
+#if defined(CONFIG_SMP)
+	/* See notes for dispc.c:omap_dispc_unregister_isr() . */
+	synchronize_irq(dsi->irq);
+#endif
+
 	return r;
 }
 
@@ -1002,6 +1009,12 @@ static int dsi_unregister_isr_vc(struct platform_device *dsidev, int channel,
 
 	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
+	might_sleep();
+
+#if defined(CONFIG_SMP)
+	/* See notes for dispc.c:omap_dispc_unregister_isr() . */
+	synchronize_irq(dsi->irq);
+#endif
 	return r;
 }
 
@@ -1042,6 +1055,12 @@ static int dsi_unregister_isr_cio(struct platform_device *dsidev,
 
 	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
+	might_sleep();
+
+#if defined(CONFIG_SMP)
+	/* See notes for dispc.c:omap_dispc_unregister_isr() . */
+	synchronize_irq(dsi->irq);
+#endif
 	return r;
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a6267a2..769f981 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -708,6 +708,7 @@ void omapdss_default_get_timings(struct omap_dss_device *dssdev,
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
+int omap_dispc_unregister_isr_nosync(omap_dispc_isr_t isr, void *arg, u32 mask);
 
 int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout);
 int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
-- 
1.7.10.4

