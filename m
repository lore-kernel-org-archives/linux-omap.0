From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/14] dspbridge: deh: refactor into wait_for_timer()
Date: Sun, 16 May 2010 18:45:52 +0300
Message-ID: <1274024765-21076-2-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0EPPqL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:11 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:10 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Self-documenting code is better.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |   65 +++++++++++++++++++------------------
 1 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index ab95916..48c11e9 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -185,6 +185,38 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 	return status;
 }
 
+static void wait_for_timer(void)
+{
+	u32 cnt = 0;
+
+	omap_dm_timer_enable(timer);
+
+	/* Enable overflow interrupt */
+	omap_dm_timer_set_int_enable(timer,
+			GPTIMER_IRQ_OVERFLOW);
+	/*
+	 * Set counter value to overflow counter after
+	 * one tick and start timer.
+	 */
+	omap_dm_timer_set_load_start(timer, 0, 0xfffffffe);
+
+	/* Wait 80us for timer to overflow */
+	udelay(80);
+
+	/* Check interrupt status and wait for interrupt */
+	cnt = 0;
+	while (!(omap_dm_timer_read_status(timer) &
+				GPTIMER_IRQ_OVERFLOW)) {
+		if (cnt++ >= GPTIMER_IRQ_WAIT_MAX_CNT) {
+			pr_err("%s: GPTimer interrupt failed\n",
+					__func__);
+			break;
+		}
+	}
+
+	omap_dm_timer_disable(timer);
+}
+
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct bridge_dev_context *dev_context;
@@ -192,7 +224,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 	u32 hw_mmu_max_tlb_count = 31;
 	struct cfg_hostres *resources;
 	hw_status hw_status_obj;
-	u32 cnt = 0;
 
 	if (!deh_mgr)
 		return;
@@ -249,42 +280,12 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 						&map_attrs, HW_SET, HW_SET);
 		}
 
-		/*
-		 * Send a GP Timer interrupt to DSP.
-		 * The DSP expects a GP timer interrupt after an
-		 * MMU-Fault Request GPTimer.
-		 */
-		if (timer) {
-			omap_dm_timer_enable(timer);
-			/* Enable overflow interrupt */
-			omap_dm_timer_set_int_enable(timer,
-						     GPTIMER_IRQ_OVERFLOW);
-			/*
-			 * Set counter value to overflow counter after
-			 * one tick and start timer.
-			 */
-			omap_dm_timer_set_load_start(timer, 0, 0xfffffffe);
-
-			/* Wait 80us for timer to overflow */
-			udelay(80);
-
-			/* Check interrupt status and wait for interrupt */
-			cnt = 0;
-			while (!(omap_dm_timer_read_status(timer) &
-				GPTIMER_IRQ_OVERFLOW)) {
-				if (cnt++ >= GPTIMER_IRQ_WAIT_MAX_CNT) {
-					pr_err("%s: GPTimer interrupt failed\n",
-								__func__);
-					break;
-				}
-			}
-		}
+		wait_for_timer();
 
 		/* Clear MMU interrupt */
 		hw_mmu_event_ack(resources->dw_dmmu_base,
 				HW_MMU_TRANSLATION_FAULT);
 		dump_dsp_stack(deh_mgr->hbridge_context);
-		omap_dm_timer_disable(timer);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
-- 
1.7.1

