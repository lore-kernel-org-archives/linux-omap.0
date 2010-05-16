From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] dspbridge: deh: fix corruption on MMU fault
Date: Sun, 16 May 2010 18:44:28 +0300
Message-ID: <1274024668-20899-2-git-send-email-felipe.contreras@gmail.com>
References: <1274024668-20899-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49359 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab0EPPoq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:44:46 -0400
Received: by fxm6 with SMTP id 6so2976907fxm.19
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:44:44 -0700 (PDT)
In-Reply-To: <1274024668-20899-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Deepak Chitriki <deepak.chitriki@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

The DSP might misbehave and write to the dummy memory. So let's make
sure that nobody else is using the pages related to it by grabbing a
full page.

Based on the analysis of Deepak Chitriki.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/ue_deh.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/core/ue_deh.c b/drivers/dsp/bridge/core/ue_deh.c
index 605f312..ab95916 100644
--- a/drivers/dsp/bridge/core/ue_deh.c
+++ b/drivers/dsp/bridge/core/ue_deh.c
@@ -53,8 +53,6 @@
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
-#define ALIGN_DOWN(x, a)  ((x)&(~((a)-1)))
-
 /* GP Timer number to trigger interrupt for MMU-fault ISR on DSP */
 #define GPTIMER_FOR_DSP_MMU_FAULT      8
 /* Bit mask to enable overflow interrupt */
@@ -191,7 +189,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct bridge_dev_context *dev_context;
 	dsp_status status = DSP_SOK;
-	u32 mem_physical = 0;
 	u32 hw_mmu_max_tlb_count = 31;
 	struct cfg_hostres *resources;
 	hw_status hw_status_obj;
@@ -227,9 +224,7 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			(unsigned int) deh_mgr->err_info.dw_val1,
 			(unsigned int) deh_mgr->err_info.dw_val2,
 			(unsigned int) fault_addr);
-		dummy_va_addr = kzalloc(sizeof(char) * 0x1000, GFP_ATOMIC);
-		mem_physical =
-			ALIGN_DOWN(virt_to_phys(dummy_va_addr), PAGE_SIZE);
+		dummy_va_addr = (void*)__get_free_page(GFP_ATOMIC);
 		dev_context = (struct bridge_dev_context *)
 			deh_mgr->hbridge_context;
 
@@ -249,7 +244,7 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 		if (DSP_SUCCEEDED(status)) {
 			hw_status_obj =
 				hw_mmu_tlb_add(resources->dw_dmmu_base,
-						mem_physical, fault_addr,
+						virt_to_phys(dummy_va_addr), fault_addr,
 						HW_PAGE_SIZE4KB, 1,
 						&map_attrs, HW_SET, HW_SET);
 		}
@@ -355,6 +350,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 void bridge_deh_release_dummy_mem(void)
 {
-	kfree(dummy_va_addr);
+	free_page((unsigned long)dummy_va_addr);
 	dummy_va_addr = NULL;
 }
-- 
1.7.1

