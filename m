From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 19/19] DSPBRIDGE: reorganize the code to handle peripheral clocks
Date: Thu,  8 Apr 2010 18:16:08 -0500
Message-ID: <1270768568-10712-20-git-send-email-omar.ramirez@ti.com>
References: <1270768568-10712-1-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-2-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-3-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-4-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-5-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-6-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-7-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-8-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-9-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-10-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-11-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-12-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-13-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-14-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-15-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-16-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-17-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-18-git-send-email-omar.ramirez@ti.com>
 <1270768568-10712-19-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48642 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933819Ab0DHW7g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Apr 2010 18:59:36 -0400
In-Reply-To: <1270768568-10712-19-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>, Ameya Palande <ameya.palande@nokia.com>, Guzman Lugo Fernando <x0095840@ti.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Omar Ramirez Luna <omar.ramirez@hotmail.com>

This patch moves and simplifies the code used to enable/disable
all the requested peripheral clocks.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@hotmail.com>
---
 arch/arm/plat-omap/include/dspbridge/clk.h |    4 ++
 drivers/dsp/bridge/wmd/_tiomap_pwr.h       |   17 -----------
 drivers/dsp/bridge/wmd/dsp-clock.c         |   41 +++++++++++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430_pwr.c    |   42 +--------------------------
 drivers/dsp/bridge/wmd/tiomap_io.c         |    4 +-
 drivers/dsp/bridge/wmd/ue_deh.c            |    2 +-
 6 files changed, 50 insertions(+), 60 deletions(-)

diff --git a/arch/arm/plat-omap/include/dspbridge/clk.h b/arch/arm/plat-omap/include/dspbridge/clk.h
index da2549d..7b43852 100644
--- a/arch/arm/plat-omap/include/dspbridge/clk.h
+++ b/arch/arm/plat-omap/include/dspbridge/clk.h
@@ -47,6 +47,8 @@ enum dsp_clk_id {
  */
 extern dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id);
 
+u32 dsp_clock_enable_all(u32 dsp_per_clocks);
+
 /*
  *  ======== dsp_clk_disable ========
  *  Purpose:
@@ -60,6 +62,8 @@ extern dsp_status dsp_clk_enable(IN enum dsp_clk_id clk_id);
  */
 extern dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id);
 
+u32 dsp_clock_disable_all(u32 dsp_per_clocks);
+
 void ssi_clk_exit(void);
 
 void ssi_clk_init(void);
diff --git a/drivers/dsp/bridge/wmd/_tiomap_pwr.h b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
index a7a4fc2..1948e83 100644
--- a/drivers/dsp/bridge/wmd/_tiomap_pwr.h
+++ b/drivers/dsp/bridge/wmd/_tiomap_pwr.h
@@ -64,23 +64,6 @@ dsp_status pre_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs);
  */
 dsp_status handle_constraints_set(struct wmd_dev_context *dev_context,
 				  IN void *pargs);
-/*
- *  ======== dsp_peripheral_clocks_disable ========
- *  	This function disables all the peripheral clocks that
- *	were enabled by DSP. Call this function only when
- *	DSP is entering Hibernation or when DSP is in
- *	Error state
- */
-dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
-					 IN void *pargs);
-
-/*
- *  ======== dsp_peripheral_clocks_enable ========
- *  	This function enables all the peripheral clocks that
- *	were requested by DSP.
- */
-dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
-					IN void *pargs);
 
 /*
  *  ======== dsp_clk_wakeup_event_ctrl ========
diff --git a/drivers/dsp/bridge/wmd/dsp-clock.c b/drivers/dsp/bridge/wmd/dsp-clock.c
index 8f539fd..187c71c 100644
--- a/drivers/dsp/bridge/wmd/dsp-clock.c
+++ b/drivers/dsp/bridge/wmd/dsp-clock.c
@@ -242,6 +242,25 @@ out:
 	return status;
 }
 
+/**
+ * dsp_clock_enable_all - Enable clocks used by the DSP
+ * @dev_context		Driver's device context strucure
+ *
+ * This function enables all the peripheral clocks that were requested by DSP.
+ */
+u32 dsp_clock_enable_all(u32 dsp_per_clocks)
+{
+	u32 clk_id;
+	u32 status = DSP_EFAIL;
+
+	for (clk_id = 0; clk_id < DSP_CLK_NOT_DEFINED; clk_id++) {
+		if (is_dsp_clk_active(dsp_per_clocks, clk_id))
+			status = dsp_clk_enable(clk_id);
+	}
+
+	return status;
+}
+
 /*
  *  ======== dsp_clk_disable ========
  *  Purpose:
@@ -287,3 +306,25 @@ dsp_status dsp_clk_disable(IN enum dsp_clk_id clk_id)
 out:
 	return status;
 }
+
+/**
+ * dsp_clock_disable_all - Disable all active clocks
+ * @dev_context		Driver's device context structure
+ *
+ * This function disables all the peripheral clocks that were enabled by DSP.
+ * It is meant to be called only when DSP is entering hibernation or when DSP
+ * is in error state.
+ */
+u32 dsp_clock_disable_all(u32 dsp_per_clocks)
+{
+	u32 clk_id;
+	u32 status = DSP_EFAIL;
+
+	for (clk_id = 0; clk_id < DSP_CLK_NOT_DEFINED; clk_id++) {
+		if (is_dsp_clk_active(dsp_per_clocks, clk_id))
+			status = dsp_clk_disable(clk_id);
+	}
+
+	return status;
+}
+
diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
index a6e8e57..5db2076 100644
--- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
+++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
@@ -123,7 +123,7 @@ dsp_status handle_hibernation_from_dsp(struct wmd_dev_context *dev_context)
 		omap_mbox_save_ctx(dev_context->mbox);
 
 		/* Turn off DSP Peripheral clocks and DSP Load monitor timer */
-		status = dsp_peripheral_clocks_disable(dev_context, NULL);
+		status = dsp_clock_disable_all(dev_context->dsp_per_clks);
 
 		if (DSP_SUCCEEDED(status)) {
 			/* Update the Bridger Driver state */
@@ -240,7 +240,7 @@ dsp_status sleep_dsp(struct wmd_dev_context *dev_context, IN u32 dw_cmd,
 			dev_context->dw_brd_state = BRD_RETENTION;
 
 		/* Turn off DSP Peripheral clocks */
-		status = dsp_peripheral_clocks_disable(dev_context, NULL);
+		status = dsp_clock_disable_all(dev_context->dsp_per_clks);
 		if (DSP_FAILED(status)) {
 			return status;
 		}
@@ -422,44 +422,6 @@ dsp_status post_scale_dsp(struct wmd_dev_context *dev_context, IN void *pargs)
 	return status;
 }
 
-/*
- *  ========dsp_peripheral_clocks_disable========
- *  Disables all the peripheral clocks that were requested by DSP
- */
-dsp_status dsp_peripheral_clocks_disable(struct wmd_dev_context *dev_context,
-					 IN void *pargs)
-{
-	u32 clk_idx;
-	dsp_status status = DSP_SOK;
-
-	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
-		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			/* Disables the clocks of the peripheral */
-			status = dsp_clk_disable(bpwr_clks[clk_idx].clk);
-		}
-	}
-	return status;
-}
-
-/*
- *  ========dsp_peripheral_clocks_enable========
- *  Enables all the peripheral clocks that were requested by DSP
- */
-dsp_status dsp_peripheral_clocks_enable(struct wmd_dev_context *dev_context,
-					IN void *pargs)
-{
-	u32 clk_idx;
-	dsp_status clk_status = DSP_EFAIL;
-
-	for (clk_idx = 0; clk_idx < MBX_PM_MAX_RESOURCES; clk_idx++) {
-		if (((dev_context->dsp_per_clks) >> clk_idx) & 0x01) {
-			/* Enable the clocks of the peripheral */
-			clk_status = dsp_clk_enable(bpwr_clks[clk_idx].clk);
-		}
-	}
-	return clk_status;
-}
-
 void dsp_clk_wakeup_event_ctrl(u32 ClkId, bool enable)
 {
 	struct cfg_hostres resources;
diff --git a/drivers/dsp/bridge/wmd/tiomap_io.c b/drivers/dsp/bridge/wmd/tiomap_io.c
index b5504a9..b4c30be 100644
--- a/drivers/dsp/bridge/wmd/tiomap_io.c
+++ b/drivers/dsp/bridge/wmd/tiomap_io.c
@@ -425,7 +425,7 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
 		}
 #endif
 		/* Restart the peripheral clocks */
-		dsp_peripheral_clocks_enable(dev_context, NULL);
+		dsp_clock_enable_all(dev_context->dsp_per_clks);
 
 		/*
 		 * 2:0 AUTO_IVA2_DPLL - Enabling IVA2 DPLL auto control
@@ -451,7 +451,7 @@ dsp_status sm_interrupt_dsp(struct wmd_dev_context *dev_context, u16 mb_val)
 		dev_context->dw_brd_state = BRD_RUNNING;
 	} else if (dev_context->dw_brd_state == BRD_RETENTION) {
 		/* Restart the peripheral clocks */
-		dsp_peripheral_clocks_enable(dev_context, NULL);
+		dsp_clock_enable_all(dev_context->dsp_per_clks);
 	}
 
 	status = omap_mbox_msg_send(dev_context->mbox, mb_val);
diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index b88112e..68d6b22 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -283,7 +283,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		/* Set the Board state as ERROR */
 		dev_context->dw_brd_state = BRD_ERROR;
 		/* Disable all the clocks that were enabled by DSP */
-		(void)dsp_peripheral_clocks_disable(dev_context, NULL);
+		dsp_clock_disable_all(dev_context->dsp_per_clks);
 		/* Call DSP Trace Buffer */
 		print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
 
-- 
1.6.2.4

