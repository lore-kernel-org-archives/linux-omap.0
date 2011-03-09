From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/6] OMAP: DSS2: DSI: Restructure IRQ handler
Date: Wed, 9 Mar 2011 09:21:23 +0200
Message-ID: <1299655288-7121-2-git-send-email-tomi.valkeinen@ti.com>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39585 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab1CIHVm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 02:21:42 -0500
In-Reply-To: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Clean up the IRQ handler a bit by separating collection of IRQ stats and
handling of IRQ errors to separate functions.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  123 ++++++++++++++++++++++++-----------------
 1 files changed, 73 insertions(+), 50 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index be7694f..a0881da 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -480,26 +480,33 @@ static void print_irq_status_cio(u32 status)
 	printk("\n");
 }
 
-static int debug_irq;
-
-/* called from dss */
-static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
+#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
+static void dsi_collect_irq_stats(u32 irqstatus, u32 *vcstatus, u32 ciostatus)
 {
-	u32 irqstatus, vcstatus, ciostatus;
 	int i;
 
-	irqstatus = dsi_read_reg(DSI_IRQSTATUS);
-
-	/* IRQ is not for us */
-	if (!irqstatus)
-		return IRQ_NONE;
-
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
 	spin_lock(&dsi.irq_stats_lock);
+
 	dsi.irq_stats.irq_count++;
 	dss_collect_irq_stats(irqstatus, dsi.irq_stats.dsi_irqs);
+
+	for (i = 0; i < 4; ++i)
+		dss_collect_irq_stats(vcstatus[i], dsi.irq_stats.vc_irqs[i]);
+
+	dss_collect_irq_stats(ciostatus, dsi.irq_stats.cio_irqs);
+
+	spin_unlock(&dsi.irq_stats_lock);
+}
+#else
+#define dsi_collect_irq_stats(irqstatus, vcstatus, ciostatus)
 #endif
 
+static int debug_irq;
+
+static void dsi_handle_irq_errors(u32 irqstatus, u32 *vcstatus, u32 ciostatus)
+{
+	int i;
+
 	if (irqstatus & DSI_IRQ_ERROR_MASK) {
 		DSSERR("DSI error, irqstatus %x\n", irqstatus);
 		print_irq_status(irqstatus);
@@ -510,37 +517,48 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 		print_irq_status(irqstatus);
 	}
 
-#ifdef DSI_CATCH_MISSING_TE
-	if (irqstatus & DSI_IRQ_TE_TRIGGER)
-		del_timer(&dsi.te_timer);
-#endif
-
 	for (i = 0; i < 4; ++i) {
-		if ((irqstatus & (1<<i)) == 0)
-			continue;
+		if (vcstatus[i] & DSI_VC_IRQ_ERROR_MASK) {
+			DSSERR("DSI VC(%d) error, vc irqstatus %x\n",
+				       i, vcstatus[i]);
+			print_irq_status_vc(i, vcstatus[i]);
+		} else if (debug_irq) {
+			print_irq_status_vc(i, vcstatus[i]);
+		}
+	}
 
-		vcstatus = dsi_read_reg(DSI_VC_IRQSTATUS(i));
+	if (ciostatus & DSI_CIO_IRQ_ERROR_MASK) {
+		DSSERR("DSI CIO error, cio irqstatus %x\n", ciostatus);
+		print_irq_status_cio(ciostatus);
+	} else if (debug_irq) {
+		print_irq_status_cio(ciostatus);
+	}
+}
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-		dss_collect_irq_stats(vcstatus, dsi.irq_stats.vc_irqs[i]);
-#endif
+static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
+{
+	u32 irqstatus, vcstatus[4], ciostatus;
+	int i;
 
-		if (vcstatus & DSI_VC_IRQ_BTA) {
-			complete(&dsi.bta_completion);
+	irqstatus = dsi_read_reg(DSI_IRQSTATUS);
 
-			if (dsi.bta_callback)
-				dsi.bta_callback();
-		}
+	/* IRQ is not for us */
+	if (!irqstatus)
+		return IRQ_NONE;
 
-		if (vcstatus & DSI_VC_IRQ_ERROR_MASK) {
-			DSSERR("DSI VC(%d) error, vc irqstatus %x\n",
-				       i, vcstatus);
-			print_irq_status_vc(i, vcstatus);
-		} else if (debug_irq) {
-			print_irq_status_vc(i, vcstatus);
+	dsi_write_reg(DSI_IRQSTATUS, irqstatus & ~DSI_IRQ_CHANNEL_MASK);
+	/* flush posted write */
+	dsi_read_reg(DSI_IRQSTATUS);
+
+	for (i = 0; i < 4; ++i) {
+		if ((irqstatus & (1 << i)) == 0) {
+			vcstatus[i] = 0;
+			continue;
 		}
 
-		dsi_write_reg(DSI_VC_IRQSTATUS(i), vcstatus);
+		vcstatus[i] = dsi_read_reg(DSI_VC_IRQSTATUS(i));
+
+		dsi_write_reg(DSI_VC_IRQSTATUS(i), vcstatus[i]);
 		/* flush posted write */
 		dsi_read_reg(DSI_VC_IRQSTATUS(i));
 	}
@@ -548,29 +566,34 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 	if (irqstatus & DSI_IRQ_COMPLEXIO_ERR) {
 		ciostatus = dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-		dss_collect_irq_stats(ciostatus, dsi.irq_stats.cio_irqs);
-#endif
-
 		dsi_write_reg(DSI_COMPLEXIO_IRQ_STATUS, ciostatus);
 		/* flush posted write */
 		dsi_read_reg(DSI_COMPLEXIO_IRQ_STATUS);
+	} else {
+		ciostatus = 0;
+	}
 
-		if (ciostatus & DSI_CIO_IRQ_ERROR_MASK) {
-			DSSERR("DSI CIO error, cio irqstatus %x\n", ciostatus);
-			print_irq_status_cio(ciostatus);
-		} else if (debug_irq) {
-			print_irq_status_cio(ciostatus);
+#ifdef DSI_CATCH_MISSING_TE
+	if (irqstatus & DSI_IRQ_TE_TRIGGER)
+		del_timer(&dsi.te_timer);
+#endif
+
+	for (i = 0; i < 4; ++i) {
+		if (vcstatus[i] == 0)
+			continue;
+
+		if (vcstatus[i] & DSI_VC_IRQ_BTA) {
+			complete(&dsi.bta_completion);
+
+			if (dsi.bta_callback)
+				dsi.bta_callback();
 		}
 	}
 
-	dsi_write_reg(DSI_IRQSTATUS, irqstatus & ~DSI_IRQ_CHANNEL_MASK);
-	/* flush posted write */
-	dsi_read_reg(DSI_IRQSTATUS);
+	dsi_handle_irq_errors(irqstatus, vcstatus, ciostatus);
+
+	dsi_collect_irq_stats(irqstatus, vcstatus, ciostatus);
 
-#ifdef CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS
-	spin_unlock(&dsi.irq_stats_lock);
-#endif
 	return IRQ_HANDLED;
 }
 
-- 
1.7.1

