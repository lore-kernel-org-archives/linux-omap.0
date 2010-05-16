From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/14] dspbridge: deh: free dummy page immediately
Date: Sun, 16 May 2010 18:45:55 +0300
Message-ID: <1274024765-21076-5-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:34390 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0EPPqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:17 -0400
Received: by fg-out-1718.google.com with SMTP id 22so178499fge.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:17 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

There's no need to keep it around. DSP should stop trying to access
system memory.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 605cec7..593a0e3 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -60,8 +60,6 @@
 /* Max time to check for GP Timer IRQ */
 #define GPTIMER_IRQ_WAIT_MAX_CNT       1000
 
-static void *dummy_va_addr;
-
 static struct omap_dm_timer *timer;
 
 dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
@@ -203,6 +201,7 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		.element_size = HW_ELEM_SIZE16BIT,
 		.mixed_size = HW_MMU_CPUES,
 	};
+	void *dummy_va_addr;
 
 	if (!deh_mgr)
 		return;
@@ -259,6 +258,9 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		hw_mmu_event_ack(resources->dw_dmmu_base,
 				HW_MMU_TRANSLATION_FAULT);
 		dump_dsp_stack(dev_context);
+
+		hw_mmu_disable(resources->dw_dmmu_base);
+		free_page((unsigned long)dummy_va_addr);
 		break;
 #ifdef CONFIG_BRIDGE_NTFY_PWRERR
 	case DSP_PWRERROR:
@@ -321,6 +323,4 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 void bridge_deh_release_dummy_mem(void)
 {
-	free_page((unsigned long)dummy_va_addr);
-	dummy_va_addr = NULL;
 }
-- 
1.7.1

