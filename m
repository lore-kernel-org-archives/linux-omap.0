From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V4 5/5] OMAPDSS: Remove dss_debug variable
Date: Sat, 29 Sep 2012 16:19:26 +0530
Message-ID: <35fdb3cf12637076709451da23bb5179490a380e.1348914940.git.cmahapatra@ti.com>
References: <cover.1348826106.git.cmahapatra@ti.com> <cover.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55632 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753724Ab2I2KwS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Sep 2012 06:52:18 -0400
In-Reply-To: <cover.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

All the debug prints have been replaced with pr_debug(). Thus, the dependency on
dss_debug variable is replaced with dyndbg in dynamic debugging mode and DEBUG
flag otherwise. So, the dss_debug variable is removed along with checks for
DEBUG flag.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/core.c  |    5 -----
 drivers/video/omap2/dss/dispc.c |    8 ++------
 drivers/video/omap2/dss/dsi.c   |    7 -------
 drivers/video/omap2/dss/dss.h   |    4 ----
 4 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 1e1f50f..9abcf43 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -53,11 +53,6 @@ static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
 MODULE_PARM_DESC(def_disp, "default display name");
 
-#ifdef DEBUG
-bool dss_debug;
-module_param_named(debug, dss_debug, bool, 0644);
-#endif
-
 const char *dss_get_default_display_name(void)
 {
 	return core.default_display_name;
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 67d9f3b..b5204b4 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3669,7 +3669,6 @@ int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask)
 }
 EXPORT_SYMBOL(omap_dispc_unregister_isr);
 
-#ifdef DEBUG
 static void print_irq_status(u32 status)
 {
 	if ((status & dispc.irq_error_mask) == 0)
@@ -3690,7 +3689,6 @@ static void print_irq_status(u32 status)
 		dss_has_feature(FEAT_MGR_LCD3) ? PIS(SYNC_LOST3) : "");
 #undef PIS
 }
-#endif
 
 /* Called from dss.c. Note that we don't touch clocks here,
  * but we presume they are on because we got an IRQ. However,
@@ -3723,10 +3721,8 @@ static irqreturn_t omap_dispc_irq_handler(int irq, void *arg)
 	spin_unlock(&dispc.irq_stats_lock);
 #endif
 
-#ifdef DEBUG
-	if (dss_debug)
-		print_irq_status(irqstatus);
-#endif
+	print_irq_status(irqstatus);
+
 	/* Ack the interrupt. Do it here before clocks are possibly turned
 	 * off */
 	dispc_write_reg(DISPC_IRQSTATUS, irqstatus);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 6dd073a..4e41c7e 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1107,15 +1107,11 @@ static inline void dsi_enable_pll_clock(struct platform_device *dsidev,
 	}
 }
 
-#ifdef DEBUG
 static void _dsi_print_reset_status(struct platform_device *dsidev)
 {
 	u32 l;
 	int b0, b1, b2;
 
-	if (!dss_debug)
-		return;
-
 	/* A dummy read using the SCP interface to any DSIPHY register is
 	 * required after DSIPHY reset to complete the reset of the DSI complex
 	 * I/O. */
@@ -1146,9 +1142,6 @@ static void _dsi_print_reset_status(struct platform_device *dsidev)
 
 #undef DSI_FLD_GET
 }
-#else
-#define _dsi_print_reset_status(x)
-#endif
 
 static inline int dsi_if_enable(struct platform_device *dsidev, bool enable)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8bef7ee..739cfeb 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -23,10 +23,6 @@
 #ifndef __OMAP2_DSS_H
 #define __OMAP2_DSS_H
 
-#ifdef DEBUG
-extern bool dss_debug;
-#endif
-
 #ifdef pr_fmt
 #undef pr_fmt
 #endif
-- 
1.7.10

