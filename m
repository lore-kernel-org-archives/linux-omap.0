From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 2/3] DSS2 LPR enable and disable function defintion
Date: Tue, 22 Dec 2009 15:07:53 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026AD401DC@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49075 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbZLVJhc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Dec 2009 04:37:32 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tomi Valkeinen (tomi.valkeinen@nokia.com)" <tomi.valkeinen@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Subramani Venkatesh <x0108988@ti.com>

Patch has definition for LPR enable and disable funtion.

lpr_enable: Implements the power saving technique defined in the
document by implementing FIFO merge and thus enabling long idle of the
DMA, which inturn saves power when whole system is in IDLE state.

lpr_disable: Restores the DSS into its old state before enabling the
LPR.

Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Sudeep Basavaraj <sudeep.basavaraj@ti.com>
---
 drivers/video/omap2/dss/dispc.c |  132 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 132 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 5f7819b..daf1ae4 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -132,6 +132,13 @@ struct dispc_reg { u16 idx; };
 
 #define DISPC_MAX_NR_ISRS		8
 
+#define LPR_GFX_FIFO_HIGH_THRES	0xB9C
+#define LPR_GFX_FIFO_LOW_THRES		0x7F8
+#define DISPC_VID_ATTRIBUTES_ENABLE	(1 << 0)
+#define DSS_CONTROL_APLL_CLK		1
+static int lpr_enabled;
+static int gfx_in_use;
+
 struct omap_dispc_isr_data {
 	omap_dispc_isr_t	isr;
 	void			*arg;
@@ -154,6 +161,7 @@ static struct {
 	u32	fifo_size[3];
 
 	spinlock_t irq_lock;
+	spinlock_t lpr_lock;
 	u32 irq_error_mask;
 	struct omap_dispc_isr_data registered_isr[DISPC_MAX_NR_ISRS];
 	u32 error_irqs;
@@ -2633,6 +2641,122 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 }
 EXPORT_SYMBOL(omap_dispc_unregister_isr);
 
+/* This functions adds the OMAPDSS power saving capability by
+ * FIFO Merge when display is not in use, thus ehancing the DSS for
+ * Screen saver support.
+ */
+int omap_dispc_lpr_enable(void)
+{
+	int rc = 0;
+	unsigned long flags;
+	struct omap_overlay *ovl;
+	int v_attr;
+
+	/* Cannot enable lpr if DSS is inactive */
+	if (!gfx_in_use) {
+		DSSDBG("\nGRX plane in use\n");
+		return -EBUSY;
+	}
+
+	spin_lock_irqsave(&dispc.lpr_lock, flags);
+
+	if (lpr_enabled) {
+		DSSDBG("\nLPR is enabled\n");
+		goto lpr_out;
+	}
+
+	/* Check whether LPR can be triggered
+	 * - gfx pipeline is routed to LCD
+	 * - both video pipelines are disabled (this allows FIFOs merge)
+	 */
+
+	ovl = omap_dss_get_overlay(0);
+
+	if (!ovl) {
+		rc = -ENODEV;
+		goto lpr_out;
+	}
+
+	if (ovl->manager->id != OMAP_DSS_CHANNEL_LCD) {
+		rc = -ENODEV;
+		goto lpr_out;
+	}
+
+	v_attr = dispc_read_reg(DISPC_VID_ATTRIBUTES(0)) |
+			dispc_read_reg(DISPC_VID_ATTRIBUTES(1));
+
+	if (v_attr & DISPC_VID_ATTRIBUTES_ENABLE) {
+		rc = -ENODEV;
+		goto lpr_out;
+	}
+
+	/* Currently DSS is running on DSS1 by default. just warn if it has
+	 * changed in the future
+	 */
+	if (dss_get_dispc_clk_source() == DSS_CONTROL_APLL_CLK)
+		BUG();
+
+	dispc_setup_plane_fifo(ovl->id, LPR_GFX_FIFO_LOW_THRES,
+				LPR_GFX_FIFO_HIGH_THRES);
+
+	dispc_enable_fifomerge(1);
+
+	/* Enable LCD */
+	dispc_enable_lcd_out(1);
+
+	spin_unlock_irqrestore(&dispc.lpr_lock, flags);
+
+	/* Let LPR settings take an effect */
+	dispc_go(ovl->manager->id);
+
+	lpr_enabled = 1;
+
+	return 0;
+
+lpr_out:
+	spin_unlock_irqrestore(&dispc.lpr_lock, flags);
+	return rc;
+}
+EXPORT_SYMBOL(omap_dispc_lpr_enable);
+
+int omap_dispc_lpr_disable(void)
+{
+	unsigned long flags;
+	struct omap_overlay *ovl;
+	u32 fifo_low, fifo_high;
+	enum omap_burst_size burst_size;
+
+	if (!gfx_in_use)
+		return -EBUSY;
+
+	spin_lock_irqsave(&dispc.lpr_lock, flags);
+
+	ovl = omap_dss_get_overlay(0);
+
+	if (!lpr_enabled) {
+		spin_unlock_irqrestore(&dispc.lpr_lock, flags);
+		return 0;
+	}
+	/* Disable Fifo Merge */
+	dispc_enable_fifomerge(0);
+
+	default_get_overlay_fifo_thresholds(ovl->id, dispc.fifo_size[ovl->id],
+				&burst_size, &fifo_low, &fifo_high);
+
+	/* Restore default fifo size*/
+	dispc_setup_plane_fifo(ovl->id, fifo_low, fifo_high);
+
+	lpr_enabled = 0;
+
+	spin_unlock_irqrestore(&dispc.lpr_lock, flags);
+
+	/* Let DSS take an effect */
+	dispc_go(ovl->manager->id);
+
+	return 0;
+}
+EXPORT_SYMBOL(omap_dispc_lpr_disable);
+
 #ifdef DEBUG
 static void print_irq_status(u32 status)
 {
@@ -3056,6 +3180,14 @@ int dispc_enable_plane(enum omap_plane plane, bool enable)
 
 	enable_clocks(1);
 	_dispc_enable_plane(plane, enable);
+
+	if (plane == OMAP_DSS_GFX) {
+		if (enable)
+			gfx_in_use = 1;
+		else
+			gfx_in_use = 0;
+	}
+
 	enable_clocks(0);
 
 	return 0;
-- 
1.5.4.3


Regards,
Kishore Y

