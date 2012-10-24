From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/20] OMAPDSS: DISPC: Add IRQ enable/status helpers
Date: Wed, 24 Oct 2012 12:29:01 +0300
Message-ID: <1351070951-18616-11-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59711 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934475Ab2JXJ3l (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:41 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DISPC irqs need to be handled from the compat layer and also in the
future by the omapdrm. To make this possible, this patchs adds a set of
helper functions, so that the irqs can be managed without direct
register reads/writes.

The following functions are added, and all the current direct reg
reads/writes are changed to use these.

u32 dispc_read_irqstatus(void);
void dispc_clear_irqstatus(u32 mask);
u32 dispc_read_irqenable(void);
void dispc_write_irqenable(u32 mask);

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   44 ++++++++++++++++++++++++++++-----------
 drivers/video/omap2/dss/dss.h   |    4 ++++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3fd60ce..d294873 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -497,7 +497,7 @@ static void dispc_restore_context(void)
 	if (dss_has_feature(FEAT_MGR_LCD3))
 		RR(CONTROL3);
 	/* clear spurious SYNC_LOST_DIGIT interrupts */
-	dispc_write_reg(DISPC_IRQSTATUS, DISPC_IRQ_SYNC_LOST_DIGIT);
+	dispc_clear_irqstatus(DISPC_IRQ_SYNC_LOST_DIGIT);
 
 	/*
 	 * enable last so IRQs won't trigger before
@@ -3627,11 +3627,35 @@ int dispc_mgr_get_clock_div(enum omap_channel channel,
 	return 0;
 }
 
+u32 dispc_read_irqstatus(void)
+{
+	return dispc_read_reg(DISPC_IRQSTATUS);
+}
+
+void dispc_clear_irqstatus(u32 mask)
+{
+	dispc_write_reg(DISPC_IRQSTATUS, mask);
+}
+
+u32 dispc_read_irqenable(void)
+{
+	return dispc_read_reg(DISPC_IRQENABLE);
+}
+
+void dispc_write_irqenable(u32 mask)
+{
+	u32 old_mask = dispc_read_reg(DISPC_IRQENABLE);
+
+	/* clear the irqstatus for newly enabled irqs */
+	dispc_clear_irqstatus((mask ^ old_mask) & mask);
+
+	dispc_write_reg(DISPC_IRQENABLE, mask);
+}
+
 /* dispc.irq_lock has to be locked by the caller */
 static void _omap_dispc_set_irqs(void)
 {
 	u32 mask;
-	u32 old_mask;
 	int i;
 	struct omap_dispc_isr_data *isr_data;
 
@@ -3646,11 +3670,7 @@ static void _omap_dispc_set_irqs(void)
 		mask |= isr_data->mask;
 	}
 
-	old_mask = dispc_read_reg(DISPC_IRQENABLE);
-	/* clear the irqstatus for newly enabled irqs */
-	dispc_write_reg(DISPC_IRQSTATUS, (mask ^ old_mask) & mask);
-
-	dispc_write_reg(DISPC_IRQENABLE, mask);
+	dispc_write_irqenable(mask);
 }
 
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
@@ -3777,8 +3797,8 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 
 	spin_lock(&dispc.irq_lock);
 
-	irqstatus = dispc_read_reg(DISPC_IRQSTATUS);
-	irqenable = dispc_read_reg(DISPC_IRQENABLE);
+	irqstatus = dispc_read_irqstatus();
+	irqenable = dispc_read_irqenable();
 
 	/* IRQ is not for us */
 	if (!(irqstatus & irqenable)) {
@@ -3797,9 +3817,9 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 
 	/* Ack the interrupt. Do it here before clocks are possibly turned
 	 * off */
-	dispc_write_reg(DISPC_IRQSTATUS, irqstatus);
+	dispc_clear_irqstatus(irqstatus);
 	/* flush posted write */
-	dispc_read_reg(DISPC_IRQSTATUS);
+	dispc_read_irqstatus();
 
 	/* make a copy and unlock, so that isrs can unregister
 	 * themselves */
@@ -4008,7 +4028,7 @@ static void _omap_dispc_initialize_irq(void)
 
 	/* there's SYNC_LOST_DIGIT waiting after enabling the DSS,
 	 * so clear it */
-	dispc_write_reg(DISPC_IRQSTATUS, dispc_read_reg(DISPC_IRQSTATUS));
+	dispc_clear_irqstatus(dispc_read_irqstatus());
 
 	_omap_dispc_set_irqs();
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index be7678c..8bf9047 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -398,6 +398,10 @@ void dpi_uninit_platform_driver(void) __exit;
 int dispc_init_platform_driver(void) __init;
 void dispc_uninit_platform_driver(void) __exit;
 void dispc_dump_clocks(struct seq_file *s);
+u32 dispc_read_irqstatus(void);
+void dispc_clear_irqstatus(u32 mask);
+u32 dispc_read_irqenable(void);
+void dispc_write_irqenable(u32 mask);
 
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
-- 
1.7.9.5

