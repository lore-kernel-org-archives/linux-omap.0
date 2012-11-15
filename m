From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 24/32] OMAPDSS: move irq handling to dispc-compat
Date: Thu, 15 Nov 2012 17:58:32 +0200
Message-ID: <1352995120-3288-25-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768307Ab2KOP7u (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:50 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The whole dispc irq handling system we currently have is only needed for
compat layer, and thus can be moved from dispc.c to the compat layer.

This is quite straigtforward, but we need to add new dispc functions to
request and free the actual hardware irq: dispc_request_irq() and
dispc_free_irq().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c        |   14 +
 drivers/video/omap2/dss/dispc-compat.c |  430 +++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dispc-compat.h |    3 +
 drivers/video/omap2/dss/dispc.c        |  437 +-------------------------------
 drivers/video/omap2/dss/dss.h          |    5 +
 5 files changed, 463 insertions(+), 426 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 45d837f..51124ab 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1606,11 +1606,23 @@ int omapdss_compat_init(void)
 	if (r)
 		goto err_mgr_ops;
 
+	dispc_runtime_get();
+
+	r = dss_dispc_initialize_irq();
+	if (r)
+		goto err_init_irq;
+
+	dispc_runtime_put();
+
 out:
 	mutex_unlock(&apply_lock);
 
 	return 0;
 
+err_init_irq:
+	dispc_runtime_put();
+	dss_uninstall_mgr_ops();
+
 err_mgr_ops:
 	dss_uninit_overlay_managers(pdev);
 	dss_uninit_overlays(pdev);
@@ -1632,6 +1644,8 @@ void omapdss_compat_uninit(void)
 	if (--compat_refcnt > 0)
 		goto out;
 
+	dss_dispc_uninitialize_irq();
+
 	dss_uninstall_mgr_ops();
 
 	dss_uninit_overlay_managers(pdev);
diff --git a/drivers/video/omap2/dss/dispc-compat.c b/drivers/video/omap2/dss/dispc-compat.c
index 24e1d5e..928884c 100644
--- a/drivers/video/omap2/dss/dispc-compat.c
+++ b/drivers/video/omap2/dss/dispc-compat.c
@@ -23,6 +23,8 @@
 #include <linux/spinlock.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/seq_file.h>
 
 #include <video/omapdss.h>
 
@@ -30,6 +32,434 @@
 #include "dss_features.h"
 #include "dispc-compat.h"
 
+#define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_OCP_ERR | \
+					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_VID2_FIFO_UNDERFLOW | \
+					 DISPC_IRQ_SYNC_LOST | \
+					 DISPC_IRQ_SYNC_LOST_DIGIT)
+
+#define DISPC_MAX_NR_ISRS		8
+
+struct omap_dispc_isr_data {
+	omap_dispc_isr_t	isr;
+	void			*arg;
+	u32			mask;
+};
+
+struct dispc_irq_stats {
+	unsigned long last_reset;
+	unsigned irq_count;
+	unsigned irqs[32];
+};
+
+static struct {
+	spinlock_t irq_lock;
+	u32 irq_error_mask;
+	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
+	u32 error_irqs;
+	struct work_struct error_work;
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spinlock_t irq_stats_lock;
+	struct dispc_irq_stats irq_stats;
+#endif
+} dispc_compat;
+
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+static void dispc_dump_irqs(struct seq_file *s)
+{
+	unsigned long flags;
+	struct dispc_irq_stats stats;
+
+	spin_lock_irqsave(&dispc_compat.irq_stats_lock, flags);
+
+	stats = dispc_compat.irq_stats;
+	memset(&dispc_compat.irq_stats, 0, sizeof(dispc_compat.irq_stats));
+	dispc_compat.irq_stats.last_reset = jiffies;
+
+	spin_unlock_irqrestore(&dispc_compat.irq_stats_lock, flags);
+
+	seq_printf(s, "period %u ms\n",
+			jiffies_to_msecs(jiffies - stats.last_reset));
+
+	seq_printf(s, "irqs %d\n", stats.irq_count);
+#define PIS(x) \
+	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1]);
+
+	PIS(FRAMEDONE);
+	PIS(VSYNC);
+	PIS(EVSYNC_EVEN);
+	PIS(EVSYNC_ODD);
+	PIS(ACBIAS_COUNT_STAT);
+	PIS(PROG_LINE_NUM);
+	PIS(GFX_FIFO_UNDERFLOW);
+	PIS(GFX_END_WIN);
+	PIS(PAL_GAMMA_MASK);
+	PIS(OCP_ERR);
+	PIS(VID1_FIFO_UNDERFLOW);
+	PIS(VID1_END_WIN);
+	PIS(VID2_FIFO_UNDERFLOW);
+	PIS(VID2_END_WIN);
+	if (dss_feat_get_num_ovls() > 3) {
+		PIS(VID3_FIFO_UNDERFLOW);
+		PIS(VID3_END_WIN);
+	}
+	PIS(SYNC_LOST);
+	PIS(SYNC_LOST_DIGIT);
+	PIS(WAKEUP);
+	if (dss_has_feature(FEAT_MGR_LCD2)) {
+		PIS(FRAMEDONE2);
+		PIS(VSYNC2);
+		PIS(ACBIAS_COUNT_STAT2);
+		PIS(SYNC_LOST2);
+	}
+	if (dss_has_feature(FEAT_MGR_LCD3)) {
+		PIS(FRAMEDONE3);
+		PIS(VSYNC3);
+		PIS(ACBIAS_COUNT_STAT3);
+		PIS(SYNC_LOST3);
+	}
+#undef PIS
+}
+#endif
+
+/* dispc.irq_lock has to be locked by the caller */
+static void _omap_dispc_set_irqs(void)
+{
+	u32 mask;
+	int i;
+	struct omap_dispc_isr_data *isr_data;
+
+	mask = dispc_compat.irq_error_mask;
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc_compat.registered_isr[i];
+
+		if (isr_data->isr == NULL)
+			continue;
+
+		mask |= isr_data->mask;
+	}
+
+	dispc_write_irqenable(mask);
+}
+
+int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+{
+	int i;
+	int ret;
+	unsigned long flags;
+	struct omap_dispc_isr_data *isr_data;
+
+	if (isr == NULL)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dispc_compat.irq_lock, flags);
+
+	/* check for duplicate entry */
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc_compat.registered_isr[i];
+		if (isr_data->isr == isr && isr_data->arg == arg &&
+				isr_data->mask == mask) {
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
+	isr_data = NULL;
+	ret = -EBUSY;
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc_compat.registered_isr[i];
+
+		if (isr_data->isr != NULL)
+			continue;
+
+		isr_data->isr = isr;
+		isr_data->arg = arg;
+		isr_data->mask = mask;
+		ret = 0;
+
+		break;
+	}
+
+	if (ret)
+		goto err;
+
+	_omap_dispc_set_irqs();
+
+	spin_unlock_irqrestore(&dispc_compat.irq_lock, flags);
+
+	return 0;
+err:
+	spin_unlock_irqrestore(&dispc_compat.irq_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_dispc_register_isr);
+
+int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
+{
+	int i;
+	unsigned long flags;
+	int ret = -EINVAL;
+	struct omap_dispc_isr_data *isr_data;
+
+	spin_lock_irqsave(&dispc_compat.irq_lock, flags);
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &dispc_compat.registered_isr[i];
+		if (isr_data->isr != isr || isr_data->arg != arg ||
+				isr_data->mask != mask)
+			continue;
+
+		/* found the correct isr */
+
+		isr_data->isr = NULL;
+		isr_data->arg = NULL;
+		isr_data->mask = 0;
+
+		ret = 0;
+		break;
+	}
+
+	if (ret == 0)
+		_omap_dispc_set_irqs();
+
+	spin_unlock_irqrestore(&dispc_compat.irq_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(omap_dispc_unregister_isr);
+
+static void print_irq_status(u32 status)
+{
+	if ((status & dispc_compat.irq_error_mask) == 0)
+		return;
+
+#define PIS(x) (status & DISPC_IRQ_##x) ? (#x " ") : ""
+
+	pr_debug("DISPC IRQ: 0x%x: %s%s%s%s%s%s%s%s%s\n",
+		status,
+		PIS(OCP_ERR),
+		PIS(GFX_FIFO_UNDERFLOW),
+		PIS(VID1_FIFO_UNDERFLOW),
+		PIS(VID2_FIFO_UNDERFLOW),
+		dss_feat_get_num_ovls() > 3 ? PIS(VID3_FIFO_UNDERFLOW) : "",
+		PIS(SYNC_LOST),
+		PIS(SYNC_LOST_DIGIT),
+		dss_has_feature(FEAT_MGR_LCD2) ? PIS(SYNC_LOST2) : "",
+		dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : "");
+#undef PIS
+}
+
+/* Called from dss.c. Note that we don't touch clocks here,
+ * but we presume they are on because we got an IRQ. However,
+ * an irq handler may turn the clocks off, so we may not have
+ * clock later in the function. */
+static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
+{
+	int i;
+	u32 irqstatus, irqenable;
+	u32 handledirqs = 0;
+	u32 unhandled_errors;
+	struct omap_dispc_isr_data *isr_data;
+	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
+
+	spin_lock(&dispc_compat.irq_lock);
+
+	irqstatus = dispc_read_irqstatus();
+	irqenable = dispc_read_irqenable();
+
+	/* IRQ is not for us */
+	if (!(irqstatus & irqenable)) {
+		spin_unlock(&dispc_compat.irq_lock);
+		return IRQ_NONE;
+	}
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock(&dispc_compat.irq_stats_lock);
+	dispc_compat.irq_stats.irq_count++;
+	dss_collect_irq_stats(irqstatus, dispc_compat.irq_stats.irqs);
+	spin_unlock(&dispc_compat.irq_stats_lock);
+#endif
+
+	print_irq_status(irqstatus);
+
+	/* Ack the interrupt. Do it here before clocks are possibly turned
+	 * off */
+	dispc_clear_irqstatus(irqstatus);
+	/* flush posted write */
+	dispc_read_irqstatus();
+
+	/* make a copy and unlock, so that isrs can unregister
+	 * themselves */
+	memcpy(registered_isr, dispc_compat.registered_isr,
+			sizeof(registered_isr));
+
+	spin_unlock(&dispc_compat.irq_lock);
+
+	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
+		isr_data = &registered_isr[i];
+
+		if (!isr_data->isr)
+			continue;
+
+		if (isr_data->mask & irqstatus) {
+			isr_data->isr(isr_data->arg, irqstatus);
+			handledirqs |= isr_data->mask;
+		}
+	}
+
+	spin_lock(&dispc_compat.irq_lock);
+
+	unhandled_errors = irqstatus & ~handledirqs & dispc_compat.irq_error_mask;
+
+	if (unhandled_errors) {
+		dispc_compat.error_irqs |= unhandled_errors;
+
+		dispc_compat.irq_error_mask &= ~unhandled_errors;
+		_omap_dispc_set_irqs();
+
+		schedule_work(&dispc_compat.error_work);
+	}
+
+	spin_unlock(&dispc_compat.irq_lock);
+
+	return IRQ_HANDLED;
+}
+
+static void dispc_error_worker(struct work_struct *work)
+{
+	int i;
+	u32 errors;
+	unsigned long flags;
+	static const unsigned fifo_underflow_bits[] = {
+		DISPC_IRQ_GFX_FIFO_UNDERFLOW,
+		DISPC_IRQ_VID1_FIFO_UNDERFLOW,
+		DISPC_IRQ_VID2_FIFO_UNDERFLOW,
+		DISPC_IRQ_VID3_FIFO_UNDERFLOW,
+	};
+
+	spin_lock_irqsave(&dispc_compat.irq_lock, flags);
+	errors = dispc_compat.error_irqs;
+	dispc_compat.error_irqs = 0;
+	spin_unlock_irqrestore(&dispc_compat.irq_lock, flags);
+
+	dispc_runtime_get();
+
+	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+		struct omap_overlay *ovl;
+		unsigned bit;
+
+		ovl = omap_dss_get_overlay(i);
+		bit = fifo_underflow_bits[i];
+
+		if (bit & errors) {
+			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
+					ovl->name);
+			dispc_ovl_enable(ovl->id, false);
+			dispc_mgr_go(ovl->manager->id);
+			msleep(50);
+		}
+	}
+
+	for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+		struct omap_overlay_manager *mgr;
+		unsigned bit;
+
+		mgr = omap_dss_get_overlay_manager(i);
+		bit = dispc_mgr_get_sync_lost_irq(i);
+
+		if (bit & errors) {
+			int j;
+
+			DSSERR("SYNC_LOST on channel %s, restarting the output "
+					"with video overlays disabled\n",
+					mgr->name);
+
+			dss_mgr_disable(mgr);
+
+			for (j = 0; j < omap_dss_get_num_overlays(); ++j) {
+				struct omap_overlay *ovl;
+				ovl = omap_dss_get_overlay(j);
+
+				if (ovl->id != OMAP_DSS_GFX &&
+						ovl->manager == mgr)
+					ovl->disable(ovl);
+			}
+
+			dss_mgr_enable(mgr);
+		}
+	}
+
+	if (errors & DISPC_IRQ_OCP_ERR) {
+		DSSERR("OCP_ERR\n");
+		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
+			struct omap_overlay_manager *mgr;
+
+			mgr = omap_dss_get_overlay_manager(i);
+			dss_mgr_disable(mgr);
+		}
+	}
+
+	spin_lock_irqsave(&dispc_compat.irq_lock, flags);
+	dispc_compat.irq_error_mask |= errors;
+	_omap_dispc_set_irqs();
+	spin_unlock_irqrestore(&dispc_compat.irq_lock, flags);
+
+	dispc_runtime_put();
+}
+
+int dss_dispc_initialize_irq(void)
+{
+	int r;
+
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+	spin_lock_init(&dispc_compat.irq_stats_lock);
+	dispc_compat.irq_stats.last_reset = jiffies;
+	dss_debugfs_create_file("dispc_irq", dispc_dump_irqs);
+#endif
+
+	spin_lock_init(&dispc_compat.irq_lock);
+
+	memset(dispc_compat.registered_isr, 0,
+			sizeof(dispc_compat.registered_isr));
+
+	dispc_compat.irq_error_mask = DISPC_IRQ_MASK_ERROR;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		dispc_compat.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
+	if (dss_has_feature(FEAT_MGR_LCD3))
+		dispc_compat.irq_error_mask |= DISPC_IRQ_SYNC_LOST3;
+	if (dss_feat_get_num_ovls() > 3)
+		dispc_compat.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
+
+	/*
+	 * there's SYNC_LOST_DIGIT waiting after enabling the DSS,
+	 * so clear it
+	 */
+	dispc_clear_irqstatus(dispc_read_irqstatus());
+
+	INIT_WORK(&dispc_compat.error_work, dispc_error_worker);
+
+	_omap_dispc_set_irqs();
+
+	r = dispc_request_irq(omap_dispc_irq_handler, &dispc_compat);
+	if (r) {
+		DSSERR("dispc_request_irq failed\n");
+		return r;
+	}
+
+	return 0;
+}
+
+void dss_dispc_uninitialize_irq(void)
+{
+	dispc_free_irq(&dispc_compat);
+}
+
 static void dispc_mgr_disable_isr(void *data, u32 mask)
 {
 	struct completion *compl = data;
diff --git a/drivers/video/omap2/dss/dispc-compat.h b/drivers/video/omap2/dss/dispc-compat.h
index 8322d43..14a69b3 100644
--- a/drivers/video/omap2/dss/dispc-compat.h
+++ b/drivers/video/omap2/dss/dispc-compat.h
@@ -24,4 +24,7 @@ void dispc_mgr_disable_sync(enum omap_channel channel);
 int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 		unsigned long timeout);
 
+int dss_dispc_initialize_irq(void);
+void dss_dispc_uninitialize_irq(void);
+
 #endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index b976838..b3bb604 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -33,7 +33,6 @@
 #include <linux/delay.h>
 #include <linux/workqueue.h>
 #include <linux/hardirq.h>
-#include <linux/interrupt.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
@@ -47,21 +46,6 @@
 /* DISPC */
 #define DISPC_SZ_REGS			SZ_4K
 
-#define DISPC_IRQ_MASK_ERROR            (DISPC_IRQ_GFX_FIFO_UNDERFLOW | \
-					 DISPC_IRQ_OCP_ERR | \
-					 DISPC_IRQ_VID1_FIFO_UNDERFLOW | \
-					 DISPC_IRQ_VID2_FIFO_UNDERFLOW | \
-					 DISPC_IRQ_SYNC_LOST | \
-					 DISPC_IRQ_SYNC_LOST_DIGIT)
-
-#define DISPC_MAX_NR_ISRS		8
-
-struct omap_dispc_isr_data {
-	omap_dispc_isr_t	isr;
-	void			*arg;
-	u32			mask;
-};
-
 enum omap_burst_size {
 	BURST_SIZE_X2 = 0,
 	BURST_SIZE_X4 = 1,
@@ -74,12 +58,6 @@ enum omap_burst_size {
 #define REG_FLD_MOD(idx, val, start, end)				\
 	dispc_write_reg(idx, FLD_MOD(dispc_read_reg(idx), val, start, end))
 
-struct dispc_irq_stats {
-	unsigned long last_reset;
-	unsigned irq_count;
-	unsigned irqs[32];
-};
-
 struct dispc_features {
 	u8 sw_start;
 	u8 fp_start;
@@ -120,21 +98,10 @@ static struct {
 	/* maps which plane is using a fifo. fifo-id -> plane-id */
 	int fifo_assignment[DISPC_MAX_NR_FIFOS];
 
-	spinlock_t irq_lock;
-	u32 irq_error_mask;
-	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
-	u32 error_irqs;
-	struct work_struct error_work;
-
 	bool		ctx_valid;
 	u32		ctx[DISPC_SZ_REGS / sizeof(u32)];
 
 	const struct dispc_features *feat;
-
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spinlock_t irq_stats_lock;
-	struct dispc_irq_stats irq_stats;
-#endif
 } dispc;
 
 enum omap_color_component {
@@ -245,7 +212,6 @@ struct color_conv_coef {
 	int full_range;
 };
 
-static void _omap_dispc_set_irqs(void);
 static unsigned long dispc_plane_pclk_rate(enum omap_plane plane);
 static unsigned long dispc_plane_lclk_rate(enum omap_plane plane);
 
@@ -3120,64 +3086,6 @@ void dispc_dump_clocks(struct seq_file *s)
 	dispc_runtime_put();
 }
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-static void dispc_dump_irqs(struct seq_file *s)
-{
-	unsigned long flags;
-	struct dispc_irq_stats stats;
-
-	spin_lock_irqsave(&dispc.irq_stats_lock, flags);
-
-	stats = dispc.irq_stats;
-	memset(&dispc.irq_stats, 0, sizeof(dispc.irq_stats));
-	dispc.irq_stats.last_reset = jiffies;
-
-	spin_unlock_irqrestore(&dispc.irq_stats_lock, flags);
-
-	seq_printf(s, "period %u ms\n",
-			jiffies_to_msecs(jiffies - stats.last_reset));
-
-	seq_printf(s, "irqs %d\n", stats.irq_count);
-#define PIS(x) \
-	seq_printf(s, "%-20s %10d\n", #x, stats.irqs[ffs(DISPC_IRQ_##x)-1]);
-
-	PIS(FRAMEDONE);
-	PIS(VSYNC);
-	PIS(EVSYNC_EVEN);
-	PIS(EVSYNC_ODD);
-	PIS(ACBIAS_COUNT_STAT);
-	PIS(PROG_LINE_NUM);
-	PIS(GFX_FIFO_UNDERFLOW);
-	PIS(GFX_END_WIN);
-	PIS(PAL_GAMMA_MASK);
-	PIS(OCP_ERR);
-	PIS(VID1_FIFO_UNDERFLOW);
-	PIS(VID1_END_WIN);
-	PIS(VID2_FIFO_UNDERFLOW);
-	PIS(VID2_END_WIN);
-	if (dss_feat_get_num_ovls() > 3) {
-		PIS(VID3_FIFO_UNDERFLOW);
-		PIS(VID3_END_WIN);
-	}
-	PIS(SYNC_LOST);
-	PIS(SYNC_LOST_DIGIT);
-	PIS(WAKEUP);
-	if (dss_has_feature(FEAT_MGR_LCD2)) {
-		PIS(FRAMEDONE2);
-		PIS(VSYNC2);
-		PIS(ACBIAS_COUNT_STAT2);
-		PIS(SYNC_LOST2);
-	}
-	if (dss_has_feature(FEAT_MGR_LCD3)) {
-		PIS(FRAMEDONE3);
-		PIS(VSYNC3);
-		PIS(ACBIAS_COUNT_STAT3);
-		PIS(SYNC_LOST3);
-	}
-#undef PIS
-}
-#endif
-
 static void dispc_dump_regs(struct seq_file *s)
 {
 	int i, j;
@@ -3456,319 +3364,6 @@ void dispc_write_irqenable(u32 mask)
 	dispc_write_reg(DISPC_IRQENABLE, mask);
 }
 
-/* dispc.irq_lock has to be locked by the caller */
-static void _omap_dispc_set_irqs(void)
-{
-	u32 mask;
-	int i;
-	struct omap_dispc_isr_data *isr_data;
-
-	mask = dispc.irq_error_mask;
-
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		isr_data = &dispc.registered_isr[i];
-
-		if (isr_data->isr == NULL)
-			continue;
-
-		mask |= isr_data->mask;
-	}
-
-	dispc_write_irqenable(mask);
-}
-
-int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
-{
-	int i;
-	int ret;
-	unsigned long flags;
-	struct omap_dispc_isr_data *isr_data;
-
-	if (isr == NULL)
-		return -EINVAL;
-
-	spin_lock_irqsave(&dispc.irq_lock, flags);
-
-	/* check for duplicate entry */
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		isr_data = &dispc.registered_isr[i];
-		if (isr_data->isr == isr && isr_data->arg == arg &&
-				isr_data->mask == mask) {
-			ret = -EINVAL;
-			goto err;
-		}
-	}
-
-	isr_data = NULL;
-	ret = -EBUSY;
-
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		isr_data = &dispc.registered_isr[i];
-
-		if (isr_data->isr != NULL)
-			continue;
-
-		isr_data->isr = isr;
-		isr_data->arg = arg;
-		isr_data->mask = mask;
-		ret = 0;
-
-		break;
-	}
-
-	if (ret)
-		goto err;
-
-	_omap_dispc_set_irqs();
-
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-
-	return 0;
-err:
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(omap_dispc_register_isr);
-
-int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
-{
-	int i;
-	unsigned long flags;
-	int ret = -EINVAL;
-	struct omap_dispc_isr_data *isr_data;
-
-	spin_lock_irqsave(&dispc.irq_lock, flags);
-
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		isr_data = &dispc.registered_isr[i];
-		if (isr_data->isr != isr || isr_data->arg != arg ||
-				isr_data->mask != mask)
-			continue;
-
-		/* found the correct isr */
-
-		isr_data->isr = NULL;
-		isr_data->arg = NULL;
-		isr_data->mask = 0;
-
-		ret = 0;
-		break;
-	}
-
-	if (ret == 0)
-		_omap_dispc_set_irqs();
-
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-
-	return ret;
-}
-EXPORT_SYMBOL(omap_dispc_unregister_isr);
-
-static void print_irq_status(u32 status)
-{
-	if ((status & dispc.irq_error_mask) == 0)
-		return;
-
-#define PIS(x) (status & DISPC_IRQ_##x) ? (#x " ") : ""
-
-	pr_debug("DISPC IRQ: 0x%x: %s%s%s%s%s%s%s%s%s\n",
-		status,
-		PIS(OCP_ERR),
-		PIS(GFX_FIFO_UNDERFLOW),
-		PIS(VID1_FIFO_UNDERFLOW),
-		PIS(VID2_FIFO_UNDERFLOW),
-		dss_feat_get_num_ovls() > 3 ? PIS(VID3_FIFO_UNDERFLOW) : "",
-		PIS(SYNC_LOST),
-		PIS(SYNC_LOST_DIGIT),
-		dss_has_feature(FEAT_MGR_LCD2) ? PIS(SYNC_LOST2) : "",
-		dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : "");
-#undef PIS
-}
-
-/* Called from dss.c. Note that we don't touch clocks here,
- * but we presume they are on because we got an IRQ. However,
- * an irq handler may turn the clocks off, so we may not have
- * clock later in the function. */
-static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
-{
-	int i;
-	u32 irqstatus, irqenable;
-	u32 handledirqs = 0;
-	u32 unhandled_errors;
-	struct omap_dispc_isr_data *isr_data;
-	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
-
-	spin_lock(&dispc.irq_lock);
-
-	irqstatus = dispc_read_irqstatus();
-	irqenable = dispc_read_irqenable();
-
-	/* IRQ is not for us */
-	if (!(irqstatus & irqenable)) {
-		spin_unlock(&dispc.irq_lock);
-		return IRQ_NONE;
-	}
-
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spin_lock(&dispc.irq_stats_lock);
-	dispc.irq_stats.irq_count++;
-	dss_collect_irq_stats(irqstatus, dispc.irq_stats.irqs);
-	spin_unlock(&dispc.irq_stats_lock);
-#endif
-
-	print_irq_status(irqstatus);
-
-	/* Ack the interrupt. Do it here before clocks are possibly turned
-	 * off */
-	dispc_clear_irqstatus(irqstatus);
-	/* flush posted write */
-	dispc_read_irqstatus();
-
-	/* make a copy and unlock, so that isrs can unregister
-	 * themselves */
-	memcpy(registered_isr, dispc.registered_isr,
-			sizeof(registered_isr));
-
-	spin_unlock(&dispc.irq_lock);
-
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		isr_data = &registered_isr[i];
-
-		if (!isr_data->isr)
-			continue;
-
-		if (isr_data->mask & irqstatus) {
-			isr_data->isr(isr_data->arg, irqstatus);
-			handledirqs |= isr_data->mask;
-		}
-	}
-
-	spin_lock(&dispc.irq_lock);
-
-	unhandled_errors = irqstatus & ~handledirqs & dispc.irq_error_mask;
-
-	if (unhandled_errors) {
-		dispc.error_irqs |= unhandled_errors;
-
-		dispc.irq_error_mask &= ~unhandled_errors;
-		_omap_dispc_set_irqs();
-
-		schedule_work(&dispc.error_work);
-	}
-
-	spin_unlock(&dispc.irq_lock);
-
-	return IRQ_HANDLED;
-}
-
-static void dispc_error_worker(struct work_struct *work)
-{
-	int i;
-	u32 errors;
-	unsigned long flags;
-	static const unsigned fifo_underflow_bits[] = {
-		DISPC_IRQ_GFX_FIFO_UNDERFLOW,
-		DISPC_IRQ_VID1_FIFO_UNDERFLOW,
-		DISPC_IRQ_VID2_FIFO_UNDERFLOW,
-		DISPC_IRQ_VID3_FIFO_UNDERFLOW,
-	};
-
-	spin_lock_irqsave(&dispc.irq_lock, flags);
-	errors = dispc.error_irqs;
-	dispc.error_irqs = 0;
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-
-	dispc_runtime_get();
-
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
-		struct omap_overlay *ovl;
-		unsigned bit;
-
-		ovl = omap_dss_get_overlay(i);
-		bit = fifo_underflow_bits[i];
-
-		if (bit & errors) {
-			DSSERR("FIFO UNDERFLOW on %s, disabling the overlay\n",
-					ovl->name);
-			dispc_ovl_enable(ovl->id, false);
-			dispc_mgr_go(ovl->manager->id);
-			msleep(50);
-		}
-	}
-
-	for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-		struct omap_overlay_manager *mgr;
-		unsigned bit;
-
-		mgr = omap_dss_get_overlay_manager(i);
-		bit = mgr_desc[i].sync_lost_irq;
-
-		if (bit & errors) {
-			int j;
-
-			DSSERR("SYNC_LOST on channel %s, restarting the output "
-					"with video overlays disabled\n",
-					mgr->name);
-
-			dss_mgr_disable(mgr);
-
-			for (j = 0; j < omap_dss_get_num_overlays(); ++j) {
-				struct omap_overlay *ovl;
-				ovl = omap_dss_get_overlay(j);
-
-				if (ovl->id != OMAP_DSS_GFX &&
-						ovl->manager == mgr)
-					ovl->disable(ovl);
-			}
-
-			dss_mgr_enable(mgr);
-		}
-	}
-
-	if (errors & DISPC_IRQ_OCP_ERR) {
-		DSSERR("OCP_ERR\n");
-		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
-			struct omap_overlay_manager *mgr;
-
-			mgr = omap_dss_get_overlay_manager(i);
-			dss_mgr_disable(mgr);
-		}
-	}
-
-	spin_lock_irqsave(&dispc.irq_lock, flags);
-	dispc.irq_error_mask |= errors;
-	_omap_dispc_set_irqs();
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-
-	dispc_runtime_put();
-}
-
-static void _omap_dispc_initialize_irq(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&dispc.irq_lock, flags);
-
-	memset(dispc.registered_isr, 0, sizeof(dispc.registered_isr));
-
-	dispc.irq_error_mask = DISPC_IRQ_MASK_ERROR;
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST2;
-	if (dss_has_feature(FEAT_MGR_LCD3))
-		dispc.irq_error_mask |= DISPC_IRQ_SYNC_LOST3;
-	if (dss_feat_get_num_ovls() > 3)
-		dispc.irq_error_mask |= DISPC_IRQ_VID3_FIFO_UNDERFLOW;
-
-	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
-	 * so clear it */
-	dispc_clear_irqstatus(dispc_read_irqstatus());
-
-	_omap_dispc_set_irqs();
-
-	spin_unlock_irqrestore(&dispc.irq_lock, flags);
-}
-
 void dispc_enable_sidle(void)
 {
 	REG_FLD_MOD(DISPC_SYSCONFIG, 2, 4, 3);	/* SIDLEMODE: smart idle */
@@ -3905,6 +3500,17 @@ static int __init dispc_init_features(struct platform_device *pdev)
 	return 0;
 }
 
+int dispc_request_irq(irq_handler_t handler, void *dev_id)
+{
+	return devm_request_irq(&dispc.pdev->dev, dispc.irq, handler,
+			     IRQF_SHARED, "OMAP DISPC", dev_id);
+}
+
+void dispc_free_irq(void *dev_id)
+{
+	devm_free_irq(&dispc.pdev->dev, dispc.irq, dev_id);
+}
+
 /* DISPC HW IP initialisation */
 static int __init omap_dispchw_probe(struct platform_device *pdev)
 {
@@ -3919,15 +3525,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 	if (r)
 		return r;
 
-	spin_lock_init(&dispc.irq_lock);
-
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spin_lock_init(&dispc.irq_stats_lock);
-	dispc.irq_stats.last_reset = jiffies;
-#endif
-
-	INIT_WORK(&dispc.error_work, dispc_error_worker);
-
 	dispc_mem = platform_get_resource(dispc.pdev, IORESOURCE_MEM, 0);
 	if (!dispc_mem) {
 		DSSERR("can't get IORESOURCE_MEM DISPC\n");
@@ -3947,13 +3544,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	r = devm_request_irq(&pdev->dev, dispc.irq, omap_dispc_irq_handler,
-			     IRQF_SHARED, "OMAP DISPC", dispc.pdev);
-	if (r < 0) {
-		DSSERR("request_irq failed\n");
-		return r;
-	}
-
 	clk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
 		DSSERR("can't get fck\n");
@@ -3971,8 +3561,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	_omap_dispc_initial_config();
 
-	_omap_dispc_initialize_irq();
-
 	rev = dispc_read_reg(DISPC_REVISION);
 	dev_dbg(&pdev->dev, "OMAP DISPC rev %d.%d\n",
 	       FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
@@ -3981,9 +3569,6 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 
 	dss_debugfs_create_file("dispc", dispc_dump_regs);
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	dss_debugfs_create_file("dispc_irq", dispc_dump_irqs);
-#endif
 	return 0;
 
 err_runtime_get:
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 10995d3..16fbaaa 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -23,6 +23,8 @@
 #ifndef __OMAP2_DSS_H
 #define __OMAP2_DSS_H
 
+#include <linux/interrupt.h>
+
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
@@ -386,6 +388,9 @@ void dispc_clear_irqstatus(u32 mask);
 u32 dispc_read_irqenable(void);
 void dispc_write_irqenable(u32 mask);
 
+int dispc_request_irq(irq_handler_t handler, void *dev_id);
+void dispc_free_irq(void *dev_id);
+
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
 
-- 
1.7.10.4

