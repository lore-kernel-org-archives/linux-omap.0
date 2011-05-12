From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 4/7] OMAP: DSS2: DSI: Use platform_device pointer to get dsi data
Date: Thu, 12 May 2011 17:26:27 +0530
Message-ID: <1305201390-9724-5-git-send-email-archit@ti.com>
References: <1305201390-9724-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35132 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab1ELLwE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 07:52:04 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4CBq4wO019039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:04 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4CBq38P009259
	for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:52:03 -0500 (CDT)
In-Reply-To: <1305201390-9724-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The dsi related data structure currently creates one global instance of itself
which is accessed by dsi functions. Remove this global structure instance and
declare the struct as dsi_data. Modify dsi_init() to allocate a "dsi_data"
structure for each platform device instance. Link this data with the device's
platform_device pointer. Create the function dsi_get_dsidrv_data() which takes
the pdev and return a pointer to the device's dsi_data.

Make dsi_get_dsidev_id() return only 0 for now, this will be removed once the
name of the DSI platform device is changed to the device instance form, like
"omapdss_dsi.0" and "omapdss_dsi.1" etc.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  672 +++++++++++++++++++++++++----------------
 1 files changed, 409 insertions(+), 263 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d03eb6..61ee3db 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -34,6 +34,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/sched.h>
+#include <linux/slab.h>
 
 #include <video/omapdss.h>
 #include <plat/clock.h>
@@ -257,7 +258,7 @@ struct dsi_isr_tables {
 	struct dsi_isr_data isr_table_cio[DSI_MAX_NR_ISRS];
 };
 
-static struct dsi_data {
+struct dsi_data {
 	struct platform_device *pdev;
 	void __iomem	*base;
 	int irq;
@@ -327,7 +328,7 @@ static struct dsi_data {
 	unsigned long lpdiv_max;
 
 	unsigned scp_clk_refcount;
-} dsi;
+};
 
 static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
 
@@ -336,6 +337,11 @@ static unsigned int dsi_perf;
 module_param_named(dsi_perf, dsi_perf, bool, 0644);
 #endif
 
+static inline struct dsi_data *dsi_get_dsidrv_data(struct platform_device *dsidev)
+{
+	return dev_get_drvdata(&dsidev->dev);
+}
+
 static inline struct platform_device *dsi_get_dsidev_from_dssdev(struct omap_dss_device *dssdev)
 {
 	return dsi_pdev_map[dssdev->phy.dsi.module];
@@ -346,16 +352,30 @@ struct platform_device *dsi_get_dsidev_from_id(int module)
 	return dsi_pdev_map[module];
 }
 
+static int dsi_get_dsidev_id(struct platform_device *dsidev)
+{
+	/* TEMP: Pass 0 as the dsi module index till the time the dsi platform
+	 * device names aren't changed to the form "omapdss_dsi.0",
+	 * "omapdss_dsi.1" and so on */
+	BUG_ON(dsidev->id != -1);
+
+	return 0;
+}
+
 static inline void dsi_write_reg(struct platform_device *dsidev,
 		const struct dsi_reg idx, u32 val)
 {
-	__raw_writel(val, dsi.base + idx.idx);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	__raw_writel(val, dsi->base + idx.idx);
 }
 
 static inline u32 dsi_read_reg(struct platform_device *dsidev,
 		const struct dsi_reg idx)
 {
-	return __raw_readl(dsi.base + idx.idx);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	return __raw_readl(dsi->base + idx.idx);
 }
 
 
@@ -369,19 +389,27 @@ void dsi_restore_context(void)
 
 void dsi_bus_lock(struct omap_dss_device *dssdev)
 {
-	down(&dsi.bus_lock);
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	down(&dsi->bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_lock);
 
 void dsi_bus_unlock(struct omap_dss_device *dssdev)
 {
-	up(&dsi.bus_lock);
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	up(&dsi->bus_lock);
 }
 EXPORT_SYMBOL(dsi_bus_unlock);
 
 static bool dsi_bus_is_locked(struct platform_device *dsidev)
 {
-	return dsi.bus_lock.count == 0;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	return dsi->bus_lock.count == 0;
 }
 
 static void dsi_completion_handler(void *data, u32 mask)
@@ -405,16 +433,19 @@ static inline int wait_for_bit_change(struct platform_device *dsidev,
 #ifdef DEBUG
 static void dsi_perf_mark_setup(struct platform_device *dsidev)
 {
-	dsi.perf_setup_time = ktime_get();
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	dsi->perf_setup_time = ktime_get();
 }
 
 static void dsi_perf_mark_start(struct platform_device *dsidev)
 {
-	dsi.perf_start_time = ktime_get();
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	dsi->perf_start_time = ktime_get();
 }
 
 static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	ktime_t t, setup_time, trans_time;
 	u32 total_bytes;
 	u32 setup_us, trans_us, total_us;
@@ -424,21 +455,21 @@ static void dsi_perf_show(struct platform_device *dsidev, const char *name)
 
 	t = ktime_get();
 
-	setup_time = ktime_sub(dsi.perf_start_time, dsi.perf_setup_time);
+	setup_time = ktime_sub(dsi->perf_start_time, dsi->perf_setup_time);
 	setup_us = (u32)ktime_to_us(setup_time);
 	if (setup_us == 0)
 		setup_us = 1;
 
-	trans_time = ktime_sub(t, dsi.perf_start_time);
+	trans_time = ktime_sub(t, dsi->perf_start_time);
 	trans_us = (u32)ktime_to_us(trans_time);
 	if (trans_us == 0)
 		trans_us = 1;
 
 	total_us = setup_us + trans_us;
 
-	total_bytes = dsi.update_region.w *
-		dsi.update_region.h *
-		dsi.update_region.device->ctrl.pixel_size / 8;
+	total_bytes = dsi->update_region.w *
+		dsi->update_region.h *
+		dsi->update_region.device->ctrl.pixel_size / 8;
 
 	printk(KERN_INFO "DSI(%s): %u us + %u us = %u us (%uHz), "
 			"%u bytes, %u kbytes/sec\n",
@@ -562,19 +593,20 @@ static void print_irq_status_cio(u32 status)
 static void dsi_collect_irq_stats(struct platform_device *dsidev, u32 irqstatus,
 		u32 *vcstatus, u32 ciostatus)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 
-	spin_lock(&dsi.irq_stats_lock);
+	spin_lock(&dsi->irq_stats_lock);
 
-	dsi.irq_stats.irq_count++;
-	dss_collect_irq_stats(irqstatus, dsi.irq_stats.dsi_irqs);
+	dsi->irq_stats.irq_count++;
+	dss_collect_irq_stats(irqstatus, dsi->irq_stats.dsi_irqs);
 
 	for (i = 0; i < 4; ++i)
-		dss_collect_irq_stats(vcstatus[i], dsi.irq_stats.vc_irqs[i]);
+		dss_collect_irq_stats(vcstatus[i], dsi->irq_stats.vc_irqs[i]);
 
-	dss_collect_irq_stats(ciostatus, dsi.irq_stats.cio_irqs);
+	dss_collect_irq_stats(ciostatus, dsi->irq_stats.cio_irqs);
 
-	spin_unlock(&dsi.irq_stats_lock);
+	spin_unlock(&dsi->irq_stats_lock);
 }
 #else
 #define dsi_collect_irq_stats(dsidev, irqstatus, vcstatus, ciostatus)
@@ -585,14 +617,15 @@ static int debug_irq;
 static void dsi_handle_irq_errors(struct platform_device *dsidev, u32 irqstatus,
 		u32 *vcstatus, u32 ciostatus)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 
 	if (irqstatus & DSI_IRQ_ERROR_MASK) {
 		DSSERR("DSI error, irqstatus %x\n", irqstatus);
 		print_irq_status(irqstatus);
-		spin_lock(&dsi.errors_lock);
-		dsi.errors |= irqstatus & DSI_IRQ_ERROR_MASK;
-		spin_unlock(&dsi.errors_lock);
+		spin_lock(&dsi->errors_lock);
+		dsi->errors |= irqstatus & DSI_IRQ_ERROR_MASK;
+		spin_unlock(&dsi->errors_lock);
 	} else if (debug_irq) {
 		print_irq_status(irqstatus);
 	}
@@ -654,18 +687,20 @@ static void dsi_handle_isrs(struct dsi_isr_tables *isr_tables,
 static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 {
 	struct platform_device *dsidev;
+	struct dsi_data *dsi;
 	u32 irqstatus, vcstatus[4], ciostatus;
 	int i;
 
 	dsidev = (struct platform_device *) arg;
+	dsi = dsi_get_dsidrv_data(dsidev);
 
-	spin_lock(&dsi.irq_lock);
+	spin_lock(&dsi->irq_lock);
 
 	irqstatus = dsi_read_reg(dsidev, DSI_IRQSTATUS);
 
 	/* IRQ is not for us */
 	if (!irqstatus) {
-		spin_unlock(&dsi.irq_lock);
+		spin_unlock(&dsi->irq_lock);
 		return IRQ_NONE;
 	}
 
@@ -698,16 +733,17 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 
 #ifdef DSI_CATCH_MISSING_TE
 	if (irqstatus & DSI_IRQ_TE_TRIGGER)
-		del_timer(&dsi.te_timer);
+		del_timer(&dsi->te_timer);
 #endif
 
 	/* make a copy and unlock, so that isrs can unregister
 	 * themselves */
-	memcpy(&dsi.isr_tables_copy, &dsi.isr_tables, sizeof(dsi.isr_tables));
+	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
+		sizeof(dsi->isr_tables));
 
-	spin_unlock(&dsi.irq_lock);
+	spin_unlock(&dsi->irq_lock);
 
-	dsi_handle_isrs(&dsi.isr_tables_copy, irqstatus, vcstatus, ciostatus);
+	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
 
 	dsi_handle_irq_errors(dsidev, irqstatus, vcstatus, ciostatus);
 
@@ -716,7 +752,7 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-/* dsi.irq_lock has to be locked by the caller */
+/* dsi->irq_lock has to be locked by the caller */
 static void _omap_dsi_configure_irqs(struct platform_device *dsidev,
 		struct dsi_isr_data *isr_array,
 		unsigned isr_array_size, u32 default_mask,
@@ -749,51 +785,57 @@ static void _omap_dsi_configure_irqs(struct platform_device *dsidev,
 	dsi_read_reg(dsidev, status_reg);
 }
 
-/* dsi.irq_lock has to be locked by the caller */
+/* dsi->irq_lock has to be locked by the caller */
 static void _omap_dsi_set_irqs(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 mask = DSI_IRQ_ERROR_MASK;
 #ifdef DSI_CATCH_MISSING_TE
 	mask |= DSI_IRQ_TE_TRIGGER;
 #endif
-	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table,
-			ARRAY_SIZE(dsi.isr_tables.isr_table), mask,
+	_omap_dsi_configure_irqs(dsidev, dsi->isr_tables.isr_table,
+			ARRAY_SIZE(dsi->isr_tables.isr_table), mask,
 			DSI_IRQENABLE, DSI_IRQSTATUS);
 }
 
-/* dsi.irq_lock has to be locked by the caller */
+/* dsi->irq_lock has to be locked by the caller */
 static void _omap_dsi_set_irqs_vc(struct platform_device *dsidev, int vc)
 {
-	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table_vc[vc],
-			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[vc]),
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	_omap_dsi_configure_irqs(dsidev, dsi->isr_tables.isr_table_vc[vc],
+			ARRAY_SIZE(dsi->isr_tables.isr_table_vc[vc]),
 			DSI_VC_IRQ_ERROR_MASK,
 			DSI_VC_IRQENABLE(vc), DSI_VC_IRQSTATUS(vc));
 }
 
-/* dsi.irq_lock has to be locked by the caller */
+/* dsi->irq_lock has to be locked by the caller */
 static void _omap_dsi_set_irqs_cio(struct platform_device *dsidev)
 {
-	_omap_dsi_configure_irqs(dsidev, dsi.isr_tables.isr_table_cio,
-			ARRAY_SIZE(dsi.isr_tables.isr_table_cio),
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	_omap_dsi_configure_irqs(dsidev, dsi->isr_tables.isr_table_cio,
+			ARRAY_SIZE(dsi->isr_tables.isr_table_cio),
 			DSI_CIO_IRQ_ERROR_MASK,
 			DSI_COMPLEXIO_IRQ_ENABLE, DSI_COMPLEXIO_IRQ_STATUS);
 }
 
 static void _dsi_initialize_irq(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int vc;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
-	memset(&dsi.isr_tables, 0, sizeof(dsi.isr_tables));
+	memset(&dsi->isr_tables, 0, sizeof(dsi->isr_tables));
 
 	_omap_dsi_set_irqs(dsidev);
 	for (vc = 0; vc < 4; ++vc)
 		_omap_dsi_set_irqs_vc(dsidev, vc);
 	_omap_dsi_set_irqs_cio(dsidev);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 }
 
 static int _dsi_register_isr(omap_dsi_isr_t isr, void *arg, u32 mask,
@@ -855,18 +897,19 @@ static int _dsi_unregister_isr(omap_dsi_isr_t isr, void *arg, u32 mask,
 static int dsi_register_isr(struct platform_device *dsidev, omap_dsi_isr_t isr,
 		void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
-	r = _dsi_register_isr(isr, arg, mask, dsi.isr_tables.isr_table,
-			ARRAY_SIZE(dsi.isr_tables.isr_table));
+	r = _dsi_register_isr(isr, arg, mask, dsi->isr_tables.isr_table,
+			ARRAY_SIZE(dsi->isr_tables.isr_table));
 
 	if (r == 0)
 		_omap_dsi_set_irqs(dsidev);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
@@ -874,18 +917,19 @@ static int dsi_register_isr(struct platform_device *dsidev, omap_dsi_isr_t isr,
 static int dsi_unregister_isr(struct platform_device *dsidev,
 		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
-	r = _dsi_unregister_isr(isr, arg, mask, dsi.isr_tables.isr_table,
-			ARRAY_SIZE(dsi.isr_tables.isr_table));
+	r = _dsi_unregister_isr(isr, arg, mask, dsi->isr_tables.isr_table,
+			ARRAY_SIZE(dsi->isr_tables.isr_table));
 
 	if (r == 0)
 		_omap_dsi_set_irqs(dsidev);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
@@ -893,19 +937,20 @@ static int dsi_unregister_isr(struct platform_device *dsidev,
 static int dsi_register_isr_vc(struct platform_device *dsidev, int channel,
 		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
 	r = _dsi_register_isr(isr, arg, mask,
-			dsi.isr_tables.isr_table_vc[channel],
-			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[channel]));
+			dsi->isr_tables.isr_table_vc[channel],
+			ARRAY_SIZE(dsi->isr_tables.isr_table_vc[channel]));
 
 	if (r == 0)
 		_omap_dsi_set_irqs_vc(dsidev, channel);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
@@ -913,19 +958,20 @@ static int dsi_register_isr_vc(struct platform_device *dsidev, int channel,
 static int dsi_unregister_isr_vc(struct platform_device *dsidev, int channel,
 		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
 	r = _dsi_unregister_isr(isr, arg, mask,
-			dsi.isr_tables.isr_table_vc[channel],
-			ARRAY_SIZE(dsi.isr_tables.isr_table_vc[channel]));
+			dsi->isr_tables.isr_table_vc[channel],
+			ARRAY_SIZE(dsi->isr_tables.isr_table_vc[channel]));
 
 	if (r == 0)
 		_omap_dsi_set_irqs_vc(dsidev, channel);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
@@ -933,18 +979,19 @@ static int dsi_unregister_isr_vc(struct platform_device *dsidev, int channel,
 static int dsi_register_isr_cio(struct platform_device *dsidev,
 		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
-	r = _dsi_register_isr(isr, arg, mask, dsi.isr_tables.isr_table_cio,
-			ARRAY_SIZE(dsi.isr_tables.isr_table_cio));
+	r = _dsi_register_isr(isr, arg, mask, dsi->isr_tables.isr_table_cio,
+			ARRAY_SIZE(dsi->isr_tables.isr_table_cio));
 
 	if (r == 0)
 		_omap_dsi_set_irqs_cio(dsidev);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
@@ -952,30 +999,32 @@ static int dsi_register_isr_cio(struct platform_device *dsidev,
 static int dsi_unregister_isr_cio(struct platform_device *dsidev,
 		omap_dsi_isr_t isr, void *arg, u32 mask)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	int r;
 
-	spin_lock_irqsave(&dsi.irq_lock, flags);
+	spin_lock_irqsave(&dsi->irq_lock, flags);
 
-	r = _dsi_unregister_isr(isr, arg, mask, dsi.isr_tables.isr_table_cio,
-			ARRAY_SIZE(dsi.isr_tables.isr_table_cio));
+	r = _dsi_unregister_isr(isr, arg, mask, dsi->isr_tables.isr_table_cio,
+			ARRAY_SIZE(dsi->isr_tables.isr_table_cio));
 
 	if (r == 0)
 		_omap_dsi_set_irqs_cio(dsidev);
 
-	spin_unlock_irqrestore(&dsi.irq_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_lock, flags);
 
 	return r;
 }
 
 static u32 dsi_get_errors(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	u32 e;
-	spin_lock_irqsave(&dsi.errors_lock, flags);
-	e = dsi.errors;
-	dsi.errors = 0;
-	spin_unlock_irqrestore(&dsi.errors_lock, flags);
+	spin_lock_irqsave(&dsi->errors_lock, flags);
+	e = dsi->errors;
+	dsi->errors = 0;
+	spin_unlock_irqrestore(&dsi->errors_lock, flags);
 	return e;
 }
 
@@ -992,12 +1041,14 @@ static inline void enable_clocks(bool enable)
 static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 		bool enable)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	if (enable)
 		dss_clk_enable(DSS_CLK_SYSCK);
 	else
 		dss_clk_disable(DSS_CLK_SYSCK);
 
-	if (enable && dsi.pll_locked) {
+	if (enable && dsi->pll_locked) {
 		if (wait_for_bit_change(dsidev, DSI_PLL_STATUS, 1, 1) != 1)
 			DSSERR("cannot lock PLL when enabling clocks\n");
 	}
@@ -1065,17 +1116,23 @@ static inline int dsi_if_enable(struct platform_device *dsidev, bool enable)
 
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
-	return dsi.current_cinfo.dsi_pll_hsdiv_dispc_clk;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	return dsi->current_cinfo.dsi_pll_hsdiv_dispc_clk;
 }
 
 static unsigned long dsi_get_pll_hsdiv_dsi_rate(struct platform_device *dsidev)
 {
-	return dsi.current_cinfo.dsi_pll_hsdiv_dsi_clk;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	return dsi->current_cinfo.dsi_pll_hsdiv_dsi_clk;
 }
 
 static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
 {
-	return dsi.current_cinfo.clkin4ddr / 16;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	return dsi->current_cinfo.clkin4ddr / 16;
 }
 
 static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
@@ -1096,13 +1153,14 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long dsi_fclk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
 
 	lp_clk_div = dssdev->clocks.dsi.lp_clk_div;
 
-	if (lp_clk_div == 0 || lp_clk_div > dsi.lpdiv_max)
+	if (lp_clk_div == 0 || lp_clk_div > dsi->lpdiv_max)
 		return -EINVAL;
 
 	dsi_fclk = dsi_fclk_rate(dsidev);
@@ -1110,8 +1168,8 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 	lp_clk = dsi_fclk / 2 / lp_clk_div;
 
 	DSSDBG("LP_CLK_DIV %u, LP_CLK %lu\n", lp_clk_div, lp_clk);
-	dsi.current_cinfo.lp_clk = lp_clk;
-	dsi.current_cinfo.lp_clk_div = lp_clk_div;
+	dsi->current_cinfo.lp_clk = lp_clk;
+	dsi->current_cinfo.lp_clk_div = lp_clk_div;
 
 	/* LP_CLK_DIVISOR */
 	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, lp_clk_div, 12, 0);
@@ -1124,14 +1182,18 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 
 static void dsi_enable_scp_clk(struct platform_device *dsidev)
 {
-	if (dsi.scp_clk_refcount++ == 0)
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->scp_clk_refcount++ == 0)
 		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 1, 14, 14); /* CIO_CLK_ICG */
 }
 
 static void dsi_disable_scp_clk(struct platform_device *dsidev)
 {
-	WARN_ON(dsi.scp_clk_refcount == 0);
-	if (--dsi.scp_clk_refcount == 0)
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	WARN_ON(dsi->scp_clk_refcount == 0);
+	if (--dsi->scp_clk_refcount == 0)
 		REG_FLD_MOD(dsidev, DSI_CLK_CTRL, 0, 14, 14); /* CIO_CLK_ICG */
 }
 
@@ -1172,16 +1234,19 @@ static int dsi_pll_power(struct platform_device *dsidev,
 static int dsi_calc_clock_rates(struct omap_dss_device *dssdev,
 		struct dsi_clock_info *cinfo)
 {
-	if (cinfo->regn == 0 || cinfo->regn > dsi.regn_max)
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (cinfo->regn == 0 || cinfo->regn > dsi->regn_max)
 		return -EINVAL;
 
-	if (cinfo->regm == 0 || cinfo->regm > dsi.regm_max)
+	if (cinfo->regm == 0 || cinfo->regm > dsi->regm_max)
 		return -EINVAL;
 
-	if (cinfo->regm_dispc > dsi.regm_dispc_max)
+	if (cinfo->regm_dispc > dsi->regm_dispc_max)
 		return -EINVAL;
 
-	if (cinfo->regm_dsi > dsi.regm_dsi_max)
+	if (cinfo->regm_dsi > dsi->regm_dsi_max)
 		return -EINVAL;
 
 	if (cinfo->use_sys_clk) {
@@ -1200,7 +1265,7 @@ static int dsi_calc_clock_rates(struct omap_dss_device *dssdev,
 
 	cinfo->fint = cinfo->clkin / (cinfo->regn * (cinfo->highfreq ? 2 : 1));
 
-	if (cinfo->fint > dsi.fint_max || cinfo->fint < dsi.fint_min)
+	if (cinfo->fint > dsi->fint_max || cinfo->fint < dsi->fint_min)
 		return -EINVAL;
 
 	cinfo->clkin4ddr = 2 * cinfo->regm * cinfo->fint;
@@ -1227,6 +1292,7 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
 		unsigned long req_pck, struct dsi_clock_info *dsi_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dsi_clock_info cur, best;
 	struct dispc_clock_info best_dispc;
 	int min_fck_per_pck;
@@ -1237,10 +1303,10 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
 
 	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
-	if (req_pck == dsi.cache_req_pck &&
-			dsi.cache_cinfo.clkin == dss_sys_clk) {
+	if (req_pck == dsi->cache_req_pck &&
+			dsi->cache_cinfo.clkin == dss_sys_clk) {
 		DSSDBG("DSI clock info found from cache\n");
-		*dsi_cinfo = dsi.cache_cinfo;
+		*dsi_cinfo = dsi->cache_cinfo;
 		dispc_find_clk_divs(is_tft, req_pck,
 			dsi_cinfo->dsi_pll_hsdiv_dispc_clk, dispc_cinfo);
 		return 0;
@@ -1270,17 +1336,17 @@ retry:
 	/* no highfreq: 0.75MHz < Fint = clkin / regn < 2.1MHz */
 	/* highfreq: 0.75MHz < Fint = clkin / (2*regn) < 2.1MHz */
 	/* To reduce PLL lock time, keep Fint high (around 2 MHz) */
-	for (cur.regn = 1; cur.regn < dsi.regn_max; ++cur.regn) {
+	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
 		if (cur.highfreq == 0)
 			cur.fint = cur.clkin / cur.regn;
 		else
 			cur.fint = cur.clkin / (2 * cur.regn);
 
-		if (cur.fint > dsi.fint_max || cur.fint < dsi.fint_min)
+		if (cur.fint > dsi->fint_max || cur.fint < dsi->fint_min)
 			continue;
 
 		/* DSIPHY(MHz) = (2 * regm / regn) * (clkin / (highfreq + 1)) */
-		for (cur.regm = 1; cur.regm < dsi.regm_max; ++cur.regm) {
+		for (cur.regm = 1; cur.regm < dsi->regm_max; ++cur.regm) {
 			unsigned long a, b;
 
 			a = 2 * cur.regm * (cur.clkin/1000);
@@ -1292,8 +1358,8 @@ retry:
 
 			/* dsi_pll_hsdiv_dispc_clk(MHz) =
 			 * DSIPHY(MHz) / regm_dispc  < 173MHz/186Mhz */
-			for (cur.regm_dispc = 1; cur.regm_dispc < dsi.regm_dispc_max;
-					++cur.regm_dispc) {
+			for (cur.regm_dispc = 1; cur.regm_dispc <
+					dsi->regm_dispc_max; ++cur.regm_dispc) {
 				struct dispc_clock_info cur_dispc;
 				cur.dsi_pll_hsdiv_dispc_clk =
 					cur.clkin4ddr / cur.regm_dispc;
@@ -1353,9 +1419,9 @@ found:
 	if (dispc_cinfo)
 		*dispc_cinfo = best_dispc;
 
-	dsi.cache_req_pck = req_pck;
-	dsi.cache_clk_freq = 0;
-	dsi.cache_cinfo = best;
+	dsi->cache_req_pck = req_pck;
+	dsi->cache_clk_freq = 0;
+	dsi->cache_cinfo = best;
 
 	return 0;
 }
@@ -1363,6 +1429,7 @@ found:
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
 	u32 l;
 	int f = 0;
@@ -1371,20 +1438,20 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	DSSDBGF();
 
-	dsi.current_cinfo.use_sys_clk = cinfo->use_sys_clk;
-	dsi.current_cinfo.highfreq = cinfo->highfreq;
+	dsi->current_cinfo.use_sys_clk = cinfo->use_sys_clk;
+	dsi->current_cinfo.highfreq = cinfo->highfreq;
 
-	dsi.current_cinfo.fint = cinfo->fint;
-	dsi.current_cinfo.clkin4ddr = cinfo->clkin4ddr;
-	dsi.current_cinfo.dsi_pll_hsdiv_dispc_clk =
+	dsi->current_cinfo.fint = cinfo->fint;
+	dsi->current_cinfo.clkin4ddr = cinfo->clkin4ddr;
+	dsi->current_cinfo.dsi_pll_hsdiv_dispc_clk =
 			cinfo->dsi_pll_hsdiv_dispc_clk;
-	dsi.current_cinfo.dsi_pll_hsdiv_dsi_clk =
+	dsi->current_cinfo.dsi_pll_hsdiv_dsi_clk =
 			cinfo->dsi_pll_hsdiv_dsi_clk;
 
-	dsi.current_cinfo.regn = cinfo->regn;
-	dsi.current_cinfo.regm = cinfo->regm;
-	dsi.current_cinfo.regm_dispc = cinfo->regm_dispc;
-	dsi.current_cinfo.regm_dsi = cinfo->regm_dsi;
+	dsi->current_cinfo.regn = cinfo->regn;
+	dsi->current_cinfo.regm = cinfo->regm;
+	dsi->current_cinfo.regm_dispc = cinfo->regm_dispc;
+	dsi->current_cinfo.regm_dsi = cinfo->regm_dsi;
 
 	DSSDBG("DSI Fint %ld\n", cinfo->fint);
 
@@ -1439,7 +1506,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 			regm_dsi_start, regm_dsi_end);
 	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION1, l);
 
-	BUG_ON(cinfo->fint < dsi.fint_min || cinfo->fint > dsi.fint_max);
+	BUG_ON(cinfo->fint < dsi->fint_min || cinfo->fint > dsi->fint_max);
 
 	if (dss_has_feature(FEAT_DSI_PLL_FREQSEL)) {
 		f = cinfo->fint < 1000000 ? 0x3 :
@@ -1476,7 +1543,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		goto err;
 	}
 
-	dsi.pll_locked = 1;
+	dsi->pll_locked = 1;
 
 	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION2);
 	l = FLD_MOD(l, 0, 0, 0);	/* DSI_PLL_IDLE */
@@ -1503,22 +1570,23 @@ err:
 int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		bool enable_hsdiv)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
 	enum dsi_pll_power_state pwstate;
 
 	DSSDBG("PLL init\n");
 
-	if (dsi.vdds_dsi_reg == NULL) {
+	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
-		vdds_dsi = regulator_get(&dsi.pdev->dev, "vdds_dsi");
+		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
 
 		if (IS_ERR(vdds_dsi)) {
 			DSSERR("can't get VDDS_DSI regulator\n");
 			return PTR_ERR(vdds_dsi);
 		}
 
-		dsi.vdds_dsi_reg = vdds_dsi;
+		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
 	enable_clocks(1);
@@ -1528,11 +1596,11 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 	 */
 	dsi_enable_scp_clk(dsidev);
 
-	if (!dsi.vdds_dsi_enabled) {
-		r = regulator_enable(dsi.vdds_dsi_reg);
+	if (!dsi->vdds_dsi_enabled) {
+		r = regulator_enable(dsi->vdds_dsi_reg);
 		if (r)
 			goto err0;
-		dsi.vdds_dsi_enabled = true;
+		dsi->vdds_dsi_enabled = true;
 	}
 
 	/* XXX PLL does not come out of reset without this... */
@@ -1567,9 +1635,9 @@ int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 
 	return 0;
 err1:
-	if (dsi.vdds_dsi_enabled) {
-		regulator_disable(dsi.vdds_dsi_reg);
-		dsi.vdds_dsi_enabled = false;
+	if (dsi->vdds_dsi_enabled) {
+		regulator_disable(dsi->vdds_dsi_reg);
+		dsi->vdds_dsi_enabled = false;
 	}
 err0:
 	dsi_disable_scp_clk(dsidev);
@@ -1580,12 +1648,14 @@ err0:
 
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 {
-	dsi.pll_locked = 0;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	dsi->pll_locked = 0;
 	dsi_pll_power(dsidev, DSI_PLL_POWER_OFF);
 	if (disconnect_lanes) {
-		WARN_ON(!dsi.vdds_dsi_enabled);
-		regulator_disable(dsi.vdds_dsi_reg);
-		dsi.vdds_dsi_enabled = false;
+		WARN_ON(!dsi->vdds_dsi_enabled);
+		regulator_disable(dsi->vdds_dsi_reg);
+		dsi->vdds_dsi_enabled = false;
 	}
 
 	dsi_disable_scp_clk(dsidev);
@@ -1598,7 +1668,8 @@ void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes)
 void dsi_dump_clocks(struct seq_file *s)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
-	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	struct dsi_clock_info *cinfo = &dsi->current_cinfo;
 	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 
 	dispc_clk_src = dss_get_dispc_clk_source();
@@ -1658,16 +1729,18 @@ void dsi_dump_clocks(struct seq_file *s)
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 void dsi_dump_irqs(struct seq_file *s)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned long flags;
 	struct dsi_irq_stats stats;
 
-	spin_lock_irqsave(&dsi.irq_stats_lock, flags);
+	spin_lock_irqsave(&dsi->irq_stats_lock, flags);
 
-	stats = dsi.irq_stats;
-	memset(&dsi.irq_stats, 0, sizeof(dsi.irq_stats));
-	dsi.irq_stats.last_reset = jiffies;
+	stats = dsi->irq_stats;
+	memset(&dsi->irq_stats, 0, sizeof(dsi->irq_stats));
+	dsi->irq_stats.last_reset = jiffies;
 
-	spin_unlock_irqrestore(&dsi.irq_stats_lock, flags);
+	spin_unlock_irqrestore(&dsi->irq_stats_lock, flags);
 
 	seq_printf(s, "period %u ms\n",
 			jiffies_to_msecs(jiffies - stats.last_reset));
@@ -1898,14 +1971,18 @@ static void dsi_set_lane_config(struct omap_dss_device *dssdev)
 
 static inline unsigned ns2ddr(struct platform_device *dsidev, unsigned ns)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	/* convert time in ns to ddr ticks, rounding up */
-	unsigned long ddr_clk = dsi.current_cinfo.clkin4ddr / 4;
+	unsigned long ddr_clk = dsi->current_cinfo.clkin4ddr / 4;
 	return (ns * (ddr_clk / 1000 / 1000) + 999) / 1000;
 }
 
 static inline unsigned ddr2ns(struct platform_device *dsidev, unsigned ddr)
 {
-	unsigned long ddr_clk = dsi.current_cinfo.clkin4ddr / 4;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	unsigned long ddr_clk = dsi->current_cinfo.clkin4ddr / 4;
 	return ddr * 1000 * 1000 / (ddr_clk / 1000);
 }
 
@@ -2097,13 +2174,14 @@ static int dsi_cio_wait_tx_clk_esc_reset(struct omap_dss_device *dssdev)
 static int dsi_cio_init(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r;
 	u32 l;
 
 	DSSDBGF();
 
-	if (dsi.dsi_mux_pads)
-		dsi.dsi_mux_pads(true);
+	if (dsi->dsi_mux_pads)
+		dsi->dsi_mux_pads(true);
 
 	dsi_enable_scp_clk(dsidev);
 
@@ -2128,7 +2206,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	l = FLD_MOD(l, 0x1fff, 12, 0);	/* STOP_STATE_COUNTER_IO */
 	dsi_write_reg(dsidev, DSI_TIMING1, l);
 
-	if (dsi.ulps_enabled) {
+	if (dsi->ulps_enabled) {
 		DSSDBG("manual ulps exit\n");
 
 		/* ULPS is exited by Mark-1 state for 1ms, followed by
@@ -2161,7 +2239,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 	if (r)
 		goto err_tx_clk_esc_rst;
 
-	if (dsi.ulps_enabled) {
+	if (dsi->ulps_enabled) {
 		/* Keep Mark-1 state for 1ms (as per DSI spec) */
 		ktime_t wait = ns_to_ktime(1000 * 1000);
 		set_current_state(TASK_UNINTERRUPTIBLE);
@@ -2177,7 +2255,7 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
 
 	dsi_cio_timings(dsidev);
 
-	dsi.ulps_enabled = false;
+	dsi->ulps_enabled = false;
 
 	DSSDBG("CIO init done\n");
 
@@ -2188,21 +2266,23 @@ err_tx_clk_esc_rst:
 err_cio_pwr_dom:
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 err_cio_pwr:
-	if (dsi.ulps_enabled)
+	if (dsi->ulps_enabled)
 		dsi_cio_disable_lane_override(dsidev);
 err_scp_clk_dom:
 	dsi_disable_scp_clk(dsidev);
-	if (dsi.dsi_mux_pads)
-		dsi.dsi_mux_pads(false);
+	if (dsi->dsi_mux_pads)
+		dsi->dsi_mux_pads(false);
 	return r;
 }
 
 static void dsi_cio_uninit(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	dsi_cio_power(dsidev, DSI_COMPLEXIO_POWER_OFF);
 	dsi_disable_scp_clk(dsidev);
-	if (dsi.dsi_mux_pads)
-		dsi.dsi_mux_pads(false);
+	if (dsi->dsi_mux_pads)
+		dsi->dsi_mux_pads(false);
 }
 
 static int _dsi_wait_reset(struct platform_device *dsidev)
@@ -2231,18 +2311,19 @@ static void dsi_config_tx_fifo(struct platform_device *dsidev,
 		enum fifo_size size1, enum fifo_size size2,
 		enum fifo_size size3, enum fifo_size size4)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r = 0;
 	int add = 0;
 	int i;
 
-	dsi.vc[0].fifo_size = size1;
-	dsi.vc[1].fifo_size = size2;
-	dsi.vc[2].fifo_size = size3;
-	dsi.vc[3].fifo_size = size4;
+	dsi->vc[0].fifo_size = size1;
+	dsi->vc[1].fifo_size = size2;
+	dsi->vc[2].fifo_size = size3;
+	dsi->vc[3].fifo_size = size4;
 
 	for (i = 0; i < 4; i++) {
 		u8 v;
-		int size = dsi.vc[i].fifo_size;
+		int size = dsi->vc[i].fifo_size;
 
 		if (add + size > 4) {
 			DSSERR("Illegal FIFO configuration\n");
@@ -2262,18 +2343,19 @@ static void dsi_config_rx_fifo(struct platform_device *dsidev,
 		enum fifo_size size1, enum fifo_size size2,
 		enum fifo_size size3, enum fifo_size size4)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r = 0;
 	int add = 0;
 	int i;
 
-	dsi.vc[0].fifo_size = size1;
-	dsi.vc[1].fifo_size = size2;
-	dsi.vc[2].fifo_size = size3;
-	dsi.vc[3].fifo_size = size4;
+	dsi->vc[0].fifo_size = size1;
+	dsi->vc[1].fifo_size = size2;
+	dsi->vc[2].fifo_size = size3;
+	dsi->vc[3].fifo_size = size4;
 
 	for (i = 0; i < 4; i++) {
 		u8 v;
-		int size = dsi.vc[i].fifo_size;
+		int size = dsi->vc[i].fifo_size;
 
 		if (add + size > 4) {
 			DSSERR("Illegal FIFO configuration\n");
@@ -2313,8 +2395,9 @@ static bool dsi_vc_is_enabled(struct platform_device *dsidev, int channel)
 static void dsi_packet_sent_handler_vp(void *data, u32 mask)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
-	const int channel = dsi.update_channel;
-	u8 bit = dsi.te_enabled ? 30 : 31;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	const int channel = dsi->update_channel;
+	u8 bit = dsi->te_enabled ? 30 : 31;
 
 	if (REG_GET(dsidev, DSI_VC_TE(channel), bit, bit) == 0)
 		complete((struct completion *)data);
@@ -2322,12 +2405,13 @@ static void dsi_packet_sent_handler_vp(void *data, u32 mask)
 
 static int dsi_sync_vc_vp(struct platform_device *dsidev, int channel)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
 	u8 bit;
 
 	DECLARE_COMPLETION_ONSTACK(completion);
 
-	bit = dsi.te_enabled ? 30 : 31;
+	bit = dsi->te_enabled ? 30 : 31;
 
 	r = dsi_register_isr_vc(dsidev, channel, dsi_packet_sent_handler_vp,
 		&completion, DSI_VC_IRQ_PACKET_SENT);
@@ -2358,7 +2442,8 @@ err0:
 static void dsi_packet_sent_handler_l4(void *data, u32 mask)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_id(0);
-	const int channel = dsi.update_channel;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	const int channel = dsi->update_channel;
 
 	if (REG_GET(dsidev, DSI_VC_CTRL(channel), 5, 5) == 0)
 		complete((struct completion *)data);
@@ -2398,6 +2483,8 @@ err0:
 
 static int dsi_sync_vc(struct platform_device *dsidev, int channel)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
 	WARN_ON(in_interrupt());
@@ -2405,7 +2492,7 @@ static int dsi_sync_vc(struct platform_device *dsidev, int channel)
 	if (!dsi_vc_is_enabled(dsidev, channel))
 		return 0;
 
-	switch (dsi.vc[channel].mode) {
+	switch (dsi->vc[channel].mode) {
 	case DSI_VC_MODE_VP:
 		return dsi_sync_vc_vp(dsidev, channel);
 	case DSI_VC_MODE_L4:
@@ -2464,7 +2551,9 @@ static void dsi_vc_initial_config(struct platform_device *dsidev, int channel)
 
 static int dsi_vc_config_l4(struct platform_device *dsidev, int channel)
 {
-	if (dsi.vc[channel].mode == DSI_VC_MODE_L4)
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->vc[channel].mode == DSI_VC_MODE_L4)
 		return 0;
 
 	DSSDBGF("%d", channel);
@@ -2487,14 +2576,16 @@ static int dsi_vc_config_l4(struct platform_device *dsidev, int channel)
 
 	dsi_vc_enable(dsidev, channel, 1);
 
-	dsi.vc[channel].mode = DSI_VC_MODE_L4;
+	dsi->vc[channel].mode = DSI_VC_MODE_L4;
 
 	return 0;
 }
 
 static int dsi_vc_config_vp(struct platform_device *dsidev, int channel)
 {
-	if (dsi.vc[channel].mode == DSI_VC_MODE_VP)
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->vc[channel].mode == DSI_VC_MODE_VP)
 		return 0;
 
 	DSSDBGF("%d", channel);
@@ -2518,7 +2609,7 @@ static int dsi_vc_config_vp(struct platform_device *dsidev, int channel)
 
 	dsi_vc_enable(dsidev, channel, 1);
 
-	dsi.vc[channel].mode = DSI_VC_MODE_VP;
+	dsi->vc[channel].mode = DSI_VC_MODE_VP;
 
 	return 0;
 }
@@ -2627,7 +2718,9 @@ static u16 dsi_vc_flush_receive_data(struct platform_device *dsidev,
 
 static int dsi_vc_send_bta(struct platform_device *dsidev, int channel)
 {
-	if (dsi.debug_write || dsi.debug_read)
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->debug_write || dsi->debug_read)
 		DSSDBG("dsi_vc_send_bta %d\n", channel);
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
@@ -2691,12 +2784,13 @@ EXPORT_SYMBOL(dsi_vc_send_bta_sync);
 static inline void dsi_vc_write_long_header(struct platform_device *dsidev,
 		int channel, u8 data_type, u16 len, u8 ecc)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 val;
 	u8 data_id;
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	data_id = data_type | dsi.vc[channel].vc_id << 6;
+	data_id = data_type | dsi->vc[channel].vc_id << 6;
 
 	val = FLD_VAL(data_id, 7, 0) | FLD_VAL(len, 23, 8) |
 		FLD_VAL(ecc, 31, 24);
@@ -2721,16 +2815,17 @@ static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
 		u8 data_type, u8 *data, u16 len, u8 ecc)
 {
 	/*u32 val; */
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 	u8 *p;
 	int r = 0;
 	u8 b1, b2, b3, b4;
 
-	if (dsi.debug_write)
+	if (dsi->debug_write)
 		DSSDBG("dsi_vc_send_long, %d bytes\n", len);
 
 	/* len + header */
-	if (dsi.vc[channel].fifo_size * 32 * 4 < len + 4) {
+	if (dsi->vc[channel].fifo_size * 32 * 4 < len + 4) {
 		DSSERR("unable to send long packet: packet too long.\n");
 		return -EINVAL;
 	}
@@ -2741,7 +2836,7 @@ static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
 
 	p = data;
 	for (i = 0; i < len >> 2; i++) {
-		if (dsi.debug_write)
+		if (dsi->debug_write)
 			DSSDBG("\tsending full packet %d\n", i);
 
 		b1 = *p++;
@@ -2756,7 +2851,7 @@ static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
 	if (i) {
 		b1 = 0; b2 = 0; b3 = 0;
 
-		if (dsi.debug_write)
+		if (dsi->debug_write)
 			DSSDBG("\tsending remainder bytes %d\n", i);
 
 		switch (i) {
@@ -2783,12 +2878,13 @@ static int dsi_vc_send_long(struct platform_device *dsidev, int channel,
 static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
 		u8 data_type, u16 data, u8 ecc)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 r;
 	u8 data_id;
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	if (dsi.debug_write)
+	if (dsi->debug_write)
 		DSSDBG("dsi_vc_send_short(ch%d, dt %#x, b1 %#x, b2 %#x)\n",
 				channel,
 				data_type, data & 0xff, (data >> 8) & 0xff);
@@ -2800,7 +2896,7 @@ static int dsi_vc_send_short(struct platform_device *dsidev, int channel,
 		return -EINVAL;
 	}
 
-	data_id = data_type | dsi.vc[channel].vc_id << 6;
+	data_id = data_type | dsi->vc[channel].vc_id << 6;
 
 	r = (data_id << 0) | (data << 8) | (ecc << 24);
 
@@ -2893,11 +2989,12 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		u8 *buf, int buflen)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	u32 val;
 	u8 dt;
 	int r;
 
-	if (dsi.debug_read)
+	if (dsi->debug_read)
 		DSSDBG("dsi_vc_dcs_read(ch%d, dcs_cmd %x)\n", channel, dcs_cmd);
 
 	r = dsi_vc_send_short(dsidev, channel, DSI_DT_DCS_READ, dcs_cmd, 0);
@@ -2916,7 +3013,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	}
 
 	val = dsi_read_reg(dsidev, DSI_VC_SHORT_PACKET_HEADER(channel));
-	if (dsi.debug_read)
+	if (dsi->debug_read)
 		DSSDBG("\theader: %08x\n", val);
 	dt = FLD_GET(val, 5, 0);
 	if (dt == DSI_DT_RX_ACK_WITH_ERR) {
@@ -2927,7 +3024,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 
 	} else if (dt == DSI_DT_RX_SHORT_READ_1) {
 		u8 data = FLD_GET(val, 15, 8);
-		if (dsi.debug_read)
+		if (dsi->debug_read)
 			DSSDBG("\tDCS short response, 1 byte: %02x\n", data);
 
 		if (buflen < 1) {
@@ -2940,7 +3037,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 		return 1;
 	} else if (dt == DSI_DT_RX_SHORT_READ_2) {
 		u16 data = FLD_GET(val, 23, 8);
-		if (dsi.debug_read)
+		if (dsi->debug_read)
 			DSSDBG("\tDCS short response, 2 byte: %04x\n", data);
 
 		if (buflen < 2) {
@@ -2955,7 +3052,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 	} else if (dt == DSI_DT_RX_DCS_LONG_READ) {
 		int w;
 		int len = FLD_GET(val, 23, 8);
-		if (dsi.debug_read)
+		if (dsi->debug_read)
 			DSSDBG("\tDCS long response, len %d\n", len);
 
 		if (len > buflen) {
@@ -2968,7 +3065,7 @@ int dsi_vc_dcs_read(struct omap_dss_device *dssdev, int channel, u8 dcs_cmd,
 			int b;
 			val = dsi_read_reg(dsidev,
 				DSI_VC_SHORT_PACKET_HEADER(channel));
-			if (dsi.debug_read)
+			if (dsi->debug_read)
 				DSSDBG("\t\t%02x %02x %02x %02x\n",
 						(val >> 0) & 0xff,
 						(val >> 8) & 0xff,
@@ -3049,6 +3146,7 @@ EXPORT_SYMBOL(dsi_vc_set_max_rx_packet_size);
 
 static int dsi_enter_ulps(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	DECLARE_COMPLETION_ONSTACK(completion);
 	int r;
 
@@ -3056,9 +3154,9 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	WARN_ON(dsi.ulps_enabled);
+	WARN_ON(dsi->ulps_enabled);
 
-	if (dsi.ulps_enabled)
+	if (dsi->ulps_enabled)
 		return 0;
 
 	if (REG_GET(dsidev, DSI_CLK_CTRL, 13, 13)) {
@@ -3112,7 +3210,7 @@ static int dsi_enter_ulps(struct platform_device *dsidev)
 
 	dsi_if_enable(dsidev, false);
 
-	dsi.ulps_enabled = true;
+	dsi->ulps_enabled = true;
 
 	return 0;
 
@@ -3384,6 +3482,7 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 {
 	/* Note: supports only 24bit colors in 32bit container */
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int first = 1;
 	int fifo_stalls = 0;
 	int max_dsi_packet_size;
@@ -3422,7 +3521,7 @@ static int dsi_update_screen_l4(struct omap_dss_device *dssdev,
 	 * in fifo */
 
 	/* When using CPU, max long packet size is TX buffer size */
-	max_dsi_packet_size = dsi.vc[0].fifo_size * 32 * 4;
+	max_dsi_packet_size = dsi->vc[0].fifo_size * 32 * 4;
 
 	/* we seem to get better perf if we divide the tx fifo to half,
 	   and while the other half is being sent, we fill the other half
@@ -3518,6 +3617,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		u16 x, u16 y, u16 w, u16 h)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	unsigned bytespp;
 	unsigned bytespl;
 	unsigned bytespf;
@@ -3526,7 +3626,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	unsigned packet_len;
 	u32 l;
 	int r;
-	const unsigned channel = dsi.update_channel;
+	const unsigned channel = dsi->update_channel;
 	/* line buffer is 1024 x 24bits */
 	/* XXX: for some reason using full buffer size causes considerable TX
 	 * slowdown with update sizes that fill the whole buffer */
@@ -3561,7 +3661,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 	dsi_vc_write_long_header(dsidev, channel, DSI_DT_DCS_LONG_WRITE,
 		packet_len, 0);
 
-	if (dsi.te_enabled)
+	if (dsi->te_enabled)
 		l = FLD_MOD(l, 1, 30, 30); /* TE_EN */
 	else
 		l = FLD_MOD(l, 1, 31, 31); /* TE_START */
@@ -3577,13 +3677,13 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 
 	dsi_perf_mark_start(dsidev);
 
-	r = queue_delayed_work(dsi.workqueue, &dsi.framedone_timeout_work,
+	r = queue_delayed_work(dsi->workqueue, &dsi->framedone_timeout_work,
 			msecs_to_jiffies(250));
 	BUG_ON(r == 0);
 
 	dss_start_update(dssdev);
 
-	if (dsi.te_enabled) {
+	if (dsi->te_enabled) {
 		/* disable LP_RX_TO, so that we can receive TE.  Time to wait
 		 * for TE is longer than the timer allows */
 		REG_FLD_MOD(dsidev, DSI_TIMING2, 0, 15, 15); /* LP_RX_TO */
@@ -3591,7 +3691,7 @@ static void dsi_update_screen_dispc(struct omap_dss_device *dssdev,
 		dsi_vc_send_bta(dsidev, channel);
 
 #ifdef DSI_CATCH_MISSING_TE
-		mod_timer(&dsi.te_timer, jiffies + msecs_to_jiffies(250));
+		mod_timer(&dsi->te_timer, jiffies + msecs_to_jiffies(250));
 #endif
 	}
 }
@@ -3605,15 +3705,17 @@ static void dsi_te_timeout(unsigned long arg)
 
 static void dsi_handle_framedone(struct platform_device *dsidev, int error)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	/* SIDLEMODE back to smart-idle */
 	dispc_enable_sidle();
 
-	if (dsi.te_enabled) {
+	if (dsi->te_enabled) {
 		/* enable LP_RX_TO again after the TE */
 		REG_FLD_MOD(dsidev, DSI_TIMING2, 1, 15, 15); /* LP_RX_TO */
 	}
 
-	dsi.framedone_callback(error, dsi.framedone_data);
+	dsi->framedone_callback(error, dsi->framedone_data);
 
 	if (!error)
 		dsi_perf_show(dsidev, "DISPC");
@@ -3621,6 +3723,8 @@ static void dsi_handle_framedone(struct platform_device *dsidev, int error)
 
 static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 {
+	struct dsi_data *dsi = container_of(work, struct dsi_data,
+			framedone_timeout_work.work);
 	/* XXX While extremely unlikely, we could get FRAMEDONE interrupt after
 	 * 250ms which would conflict with this timeout work. What should be
 	 * done is first cancel the transfer on the HW, and then cancel the
@@ -3630,19 +3734,21 @@ static void dsi_framedone_timeout_work_callback(struct work_struct *work)
 
 	DSSERR("Framedone not received for 250ms!\n");
 
-	dsi_handle_framedone(dsi.pdev, -ETIMEDOUT);
+	dsi_handle_framedone(dsi->pdev, -ETIMEDOUT);
 }
 
 static void dsi_framedone_irq_callback(void *data, u32 mask)
 {
 	struct omap_dss_device *dssdev = (struct omap_dss_device *) data;
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	/* Note: We get FRAMEDONE when DISPC has finished sending pixels and
 	 * turns itself off. However, DSI still has the pixels in its buffers,
 	 * and is sending the data.
 	 */
 
-	__cancel_delayed_work(&dsi.framedone_timeout_work);
+	__cancel_delayed_work(&dsi->framedone_timeout_work);
 
 	dsi_handle_framedone(dsidev, 0);
 
@@ -3693,8 +3799,9 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 		void (*callback)(int, void *), void *data)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	dsi.update_channel = channel;
+	dsi->update_channel = channel;
 
 	/* OMAP DSS cannot send updates of odd widths.
 	 * omap_dsi_prepare_update() makes the widths even, but add a BUG_ON
@@ -3703,14 +3810,14 @@ int omap_dsi_update(struct omap_dss_device *dssdev,
 	BUG_ON(x % 2 == 1);
 
 	if (dssdev->manager->caps & OMAP_DSS_OVL_MGR_CAP_DISPC) {
-		dsi.framedone_callback = callback;
-		dsi.framedone_data = data;
+		dsi->framedone_callback = callback;
+		dsi->framedone_data = data;
 
-		dsi.update_region.x = x;
-		dsi.update_region.y = y;
-		dsi.update_region.w = w;
-		dsi.update_region.h = h;
-		dsi.update_region.device = dssdev;
+		dsi->update_region.x = x;
+		dsi->update_region.y = y;
+		dsi->update_region.w = w;
+		dsi->update_region.h = h;
+		dsi->update_region.device = dssdev;
 
 		dsi_update_screen_dispc(dssdev, x, y, w, h);
 	} else {
@@ -3890,8 +3997,9 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	if (enter_ulps && !dsi.ulps_enabled)
+	if (enter_ulps && !dsi->ulps_enabled)
 		dsi_enter_ulps(dsidev);
 
 	/* disable interface */
@@ -3926,13 +4034,14 @@ static int dsi_core_init(struct platform_device *dsidev)
 int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int r = 0;
 
 	DSSDBG("dsi_display_enable\n");
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	mutex_lock(&dsi.lock);
+	mutex_lock(&dsi->lock);
 
 	r = omap_dss_start_device(dssdev);
 	if (r) {
@@ -3957,7 +4066,7 @@ int omapdss_dsi_display_enable(struct omap_dss_device *dssdev)
 	if (r)
 		goto err2;
 
-	mutex_unlock(&dsi.lock);
+	mutex_unlock(&dsi->lock);
 
 	return 0;
 
@@ -3968,7 +4077,7 @@ err1:
 	dsi_enable_pll_clock(dsidev, 0);
 	omap_dss_stop_device(dssdev);
 err0:
-	mutex_unlock(&dsi.lock);
+	mutex_unlock(&dsi->lock);
 	DSSDBG("dsi_display_enable FAILED\n");
 	return r;
 }
@@ -3978,12 +4087,13 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 		bool disconnect_lanes, bool enter_ulps)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	DSSDBG("dsi_display_disable\n");
 
 	WARN_ON(!dsi_bus_is_locked(dsidev));
 
-	mutex_lock(&dsi.lock);
+	mutex_lock(&dsi->lock);
 
 	dsi_display_uninit_dispc(dssdev);
 
@@ -3994,13 +4104,16 @@ void omapdss_dsi_display_disable(struct omap_dss_device *dssdev,
 
 	omap_dss_stop_device(dssdev);
 
-	mutex_unlock(&dsi.lock);
+	mutex_unlock(&dsi->lock);
 }
 EXPORT_SYMBOL(omapdss_dsi_display_disable);
 
 int omapdss_dsi_enable_te(struct omap_dss_device *dssdev, bool enable)
 {
-	dsi.te_enabled = enable;
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	dsi->te_enabled = enable;
 	return 0;
 }
 EXPORT_SYMBOL(omapdss_dsi_enable_te);
@@ -4020,23 +4133,26 @@ void dsi_get_overlay_fifo_thresholds(enum omap_plane plane,
 
 int dsi_init_display(struct omap_dss_device *dssdev)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	DSSDBG("DSI init\n");
 
 	/* XXX these should be figured out dynamically */
 	dssdev->caps = OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE |
 		OMAP_DSS_DISPLAY_CAP_TEAR_ELIM;
 
-	if (dsi.vdds_dsi_reg == NULL) {
+	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
-		vdds_dsi = regulator_get(&dsi.pdev->dev, "vdds_dsi");
+		vdds_dsi = regulator_get(&dsi->pdev->dev, "vdds_dsi");
 
 		if (IS_ERR(vdds_dsi)) {
 			DSSERR("can't get VDDS_DSI regulator\n");
 			return PTR_ERR(vdds_dsi);
 		}
 
-		dsi.vdds_dsi_reg = vdds_dsi;
+		dsi->vdds_dsi_reg = vdds_dsi;
 	}
 
 	return 0;
@@ -4044,11 +4160,13 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 
 int omap_dsi_request_vc(struct omap_dss_device *dssdev, int *channel)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(dsi.vc); i++) {
-		if (!dsi.vc[i].dssdev) {
-			dsi.vc[i].dssdev = dssdev;
+	for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
+		if (!dsi->vc[i].dssdev) {
+			dsi->vc[i].dssdev = dssdev;
 			*channel = i;
 			return 0;
 		}
@@ -4061,6 +4179,9 @@ EXPORT_SYMBOL(omap_dsi_request_vc);
 
 int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	if (vc_id < 0 || vc_id > 3) {
 		DSSERR("VC ID out of range\n");
 		return -EINVAL;
@@ -4071,13 +4192,13 @@ int omap_dsi_set_vc_id(struct omap_dss_device *dssdev, int channel, int vc_id)
 		return -EINVAL;
 	}
 
-	if (dsi.vc[channel].dssdev != dssdev) {
+	if (dsi->vc[channel].dssdev != dssdev) {
 		DSSERR("Virtual Channel not allocated to display %s\n",
 			dssdev->name);
 		return -EINVAL;
 	}
 
-	dsi.vc[channel].vc_id = vc_id;
+	dsi->vc[channel].vc_id = vc_id;
 
 	return 0;
 }
@@ -4085,10 +4206,13 @@ EXPORT_SYMBOL(omap_dsi_set_vc_id);
 
 void omap_dsi_release_vc(struct omap_dss_device *dssdev, int channel)
 {
+	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	if ((channel >= 0 && channel <= 3) &&
-		dsi.vc[channel].dssdev == dssdev) {
-		dsi.vc[channel].dssdev = NULL;
-		dsi.vc[channel].vc_id = 0;
+		dsi->vc[channel].dssdev == dssdev) {
+		dsi->vc[channel].dssdev = NULL;
+		dsi->vc[channel].vc_id = 0;
 	}
 }
 EXPORT_SYMBOL(omap_dsi_release_vc);
@@ -4111,13 +4235,16 @@ void dsi_wait_pll_hsdiv_dsi_active(struct platform_device *dsidev)
 
 static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 {
-	dsi.regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
-	dsi.regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
-	dsi.regm_dispc_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DISPC);
-	dsi.regm_dsi_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DSI);
-	dsi.fint_min = dss_feat_get_param_min(FEAT_PARAM_DSIPLL_FINT);
-	dsi.fint_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_FINT);
-	dsi.lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	dsi->regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
+	dsi->regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
+	dsi->regm_dispc_max =
+		dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DISPC);
+	dsi->regm_dsi_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DSI);
+	dsi->fint_min = dss_feat_get_param_min(FEAT_PARAM_DSIPLL_FINT);
+	dsi->fint_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_FINT);
+	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
 }
 
 static int dsi_init(struct platform_device *dsidev)
@@ -4125,70 +4252,81 @@ static int dsi_init(struct platform_device *dsidev)
 	struct omap_display_platform_data *dss_plat_data;
 	struct omap_dss_board_info *board_info;
 	u32 rev;
-	int r, i;
+	int r, i, dsi_module = dsi_get_dsidev_id(dsidev);
 	struct resource *dsi_mem;
+	struct dsi_data *dsi;
+
+	dsi = kzalloc(sizeof(*dsi), GFP_KERNEL);
+	if (!dsi) {
+		r = -ENOMEM;
+		goto err0;
+	}
 
-	dsi_pdev_map[dsidev->id] = dsidev;
+	dsi->pdev = dsidev;
+	dsi_pdev_map[dsi_module] = dsidev;
+	dev_set_drvdata(&dsidev->dev, dsi);
 
 	dss_plat_data = dsidev->dev.platform_data;
 	board_info = dss_plat_data->board_data;
-	dsi.dsi_mux_pads = board_info->dsi_mux_pads;
+	dsi->dsi_mux_pads = board_info->dsi_mux_pads;
 
-	spin_lock_init(&dsi.irq_lock);
-	spin_lock_init(&dsi.errors_lock);
-	dsi.errors = 0;
+	spin_lock_init(&dsi->irq_lock);
+	spin_lock_init(&dsi->errors_lock);
+	dsi->errors = 0;
 
 #ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spin_lock_init(&dsi.irq_stats_lock);
-	dsi.irq_stats.last_reset = jiffies;
+	spin_lock_init(&dsi->irq_stats_lock);
+	dsi->irq_stats.last_reset = jiffies;
 #endif
 
-	mutex_init(&dsi.lock);
-	sema_init(&dsi.bus_lock, 1);
+	mutex_init(&dsi->lock);
+	sema_init(&dsi->bus_lock, 1);
 
-	dsi.workqueue = create_singlethread_workqueue("dsi");
-	if (dsi.workqueue == NULL)
-		return -ENOMEM;
+	dsi->workqueue = create_singlethread_workqueue(dev_name(&dsidev->dev));
+	if (dsi->workqueue == NULL) {
+		r = -ENOMEM;
+		goto err1;
+	}
 
-	INIT_DELAYED_WORK_DEFERRABLE(&dsi.framedone_timeout_work,
+	INIT_DELAYED_WORK_DEFERRABLE(&dsi->framedone_timeout_work,
 			dsi_framedone_timeout_work_callback);
 
 #ifdef DSI_CATCH_MISSING_TE
-	init_timer(&dsi.te_timer);
-	dsi.te_timer.function = dsi_te_timeout;
-	dsi.te_timer.data = 0;
+	init_timer(&dsi->te_timer);
+	dsi->te_timer.function = dsi_te_timeout;
+	dsi->te_timer.data = 0;
 #endif
-	dsi_mem = platform_get_resource(dsi.pdev, IORESOURCE_MEM, 0);
+	dsi_mem = platform_get_resource(dsi->pdev, IORESOURCE_MEM, 0);
 	if (!dsi_mem) {
 		DSSERR("can't get IORESOURCE_MEM DSI\n");
 		r = -EINVAL;
-		goto err1;
+		goto err2;
 	}
-	dsi.base = ioremap(dsi_mem->start, resource_size(dsi_mem));
-	if (!dsi.base) {
+	dsi->base = ioremap(dsi_mem->start, resource_size(dsi_mem));
+	if (!dsi->base) {
 		DSSERR("can't ioremap DSI\n");
 		r = -ENOMEM;
-		goto err1;
+		goto err2;
 	}
-	dsi.irq	= platform_get_irq(dsi.pdev, 0);
-	if (dsi.irq < 0) {
+	dsi->irq = platform_get_irq(dsi->pdev, 0);
+	if (dsi->irq < 0) {
 		DSSERR("platform_get_irq failed\n");
 		r = -ENODEV;
-		goto err2;
+		goto err3;
 	}
 
-	r = request_irq(dsi.irq, omap_dsi_irq_handler, IRQF_SHARED,
-		"OMAP DSI1", dsi.pdev);
+	r = request_irq(dsi->irq, omap_dsi_irq_handler, IRQF_SHARED,
+		dev_name(&dsidev->dev), dsi->pdev);
 	if (r < 0) {
 		DSSERR("request_irq failed\n");
-		goto err2;
+		goto err3;
 	}
 
 	/* DSI VCs initialization */
-	for (i = 0; i < ARRAY_SIZE(dsi.vc); i++) {
-		dsi.vc[i].mode = DSI_VC_MODE_L4;
-		dsi.vc[i].dssdev = NULL;
-		dsi.vc[i].vc_id = 0;
+	for (i = 0; i < ARRAY_SIZE(dsi->vc); i++) {
+		dsi->vc[i].mode = DSI_VC_MODE_L4;
+		dsi->vc[i].dssdev = NULL;
+		dsi->vc[i].vc_id = 0;
 	}
 
 	dsi_calc_clock_param_ranges(dsidev);
@@ -4202,29 +4340,35 @@ static int dsi_init(struct platform_device *dsidev)
 	enable_clocks(0);
 
 	return 0;
+err3:
+	iounmap(dsi->base);
 err2:
-	iounmap(dsi.base);
+	destroy_workqueue(dsi->workqueue);
 err1:
-	destroy_workqueue(dsi.workqueue);
+	kfree(dsi);
+err0:
 	return r;
 }
 
 static void dsi_exit(struct platform_device *dsidev)
 {
-	if (dsi.vdds_dsi_reg != NULL) {
-		if (dsi.vdds_dsi_enabled) {
-			regulator_disable(dsi.vdds_dsi_reg);
-			dsi.vdds_dsi_enabled = false;
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
+	if (dsi->vdds_dsi_reg != NULL) {
+		if (dsi->vdds_dsi_enabled) {
+			regulator_disable(dsi->vdds_dsi_reg);
+			dsi->vdds_dsi_enabled = false;
 		}
 
-		regulator_put(dsi.vdds_dsi_reg);
-		dsi.vdds_dsi_reg = NULL;
+		regulator_put(dsi->vdds_dsi_reg);
+		dsi->vdds_dsi_reg = NULL;
 	}
 
-	free_irq(dsi.irq, dsi.pdev);
-	iounmap(dsi.base);
+	free_irq(dsi->irq, dsi->pdev);
+	iounmap(dsi->base);
 
-	destroy_workqueue(dsi.workqueue);
+	destroy_workqueue(dsi->workqueue);
+	kfree(dsi);
 
 	DSSDBG("omap_dsi_exit\n");
 }
@@ -4233,7 +4377,7 @@ static void dsi_exit(struct platform_device *dsidev)
 static int omap_dsi1hw_probe(struct platform_device *dsidev)
 {
 	int r;
-	dsi.pdev = dsidev;
+
 	r = dsi_init(dsidev);
 	if (r) {
 		DSSERR("Failed to initialize DSI\n");
@@ -4245,8 +4389,10 @@ err_dsi:
 
 static int omap_dsi1hw_remove(struct platform_device *dsidev)
 {
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+
 	dsi_exit(dsidev);
-	WARN_ON(dsi.scp_clk_refcount > 0);
+	WARN_ON(dsi->scp_clk_refcount > 0);
 	return 0;
 }
 
-- 
1.7.1

