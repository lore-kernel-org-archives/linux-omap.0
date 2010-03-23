From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 03/10] dsp-bridge: deh: remove unnecessary casts
Date: Tue, 23 Mar 2010 23:25:35 +0200
Message-ID: <1269379542-11892-4-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:33760 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab0CWV0I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:08 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292169bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:07 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 284f378..fae036f 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -137,7 +137,7 @@ dsp_status bridge_deh_destroy(struct deh_mgr *hdeh_mgr)
 		bridge_deh_release_dummy_mem();
 		/* If notification object exists, delete it */
 		if (deh_mgr_obj->ntfy_obj)
-			(void)ntfy_delete(deh_mgr_obj->ntfy_obj);
+			ntfy_delete(deh_mgr_obj->ntfy_obj);
 		/* Disable DSP MMU fault */
 		free_irq(INT_DSP_MMU_IRQ, deh_mgr_obj);
 
@@ -275,7 +275,7 @@ void bridge_deh_notify(struct deh_mgr *hdeh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		/* Set the Board state as ERROR */
 		dev_context->dw_brd_state = BRD_ERROR;
 		/* Disable all the clocks that were enabled by DSP */
-		(void)dsp_peripheral_clocks_disable(dev_context, NULL);
+		dsp_peripheral_clocks_disable(dev_context, NULL);
 		/* Call DSP Trace Buffer */
 		print_dsp_trace_buffer(hdeh_mgr->hwmd_context);
 
-- 
1.7.0.3

