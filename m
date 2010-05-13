From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] dspbridge: deh: fix corruption on MMU fault
Date: Thu, 13 May 2010 23:46:40 +0300
Message-ID: <1273783601-13472-2-git-send-email-felipe.contreras@gmail.com>
References: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:27230 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab0EMUqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 16:46:50 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1321319fga.1
        for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 13:46:49 -0700 (PDT)
In-Reply-To: <1273783601-13472-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>, Hiroshi Doyu <hiroshi.doyu@nokia.com>, Felipe Contreras <felipe.contreras@gmail.com>

... by removing unnecessary fault handling.

>From the looks of it, when an MMU fault happens, the DSP wants us to
come up with the data that is supposed to be on the faulty address.
Clearly, there's no way to provide that information, and such errors are
fatal, so there's no point in allocating a buffer and mapping it.

Moreover, kmalloc() doesn't return paged memory, so if the DSP tries to
write to an unaligned buffer, memory corruption ensures.

Based on the analysis of Fernando Guzman Lugo and Deepak Chitriki:
http://article.gmane.org/gmane.linux.ports.arm.omap/34207

I tested a similar patch on Nokia custom hardware and memory corruption
was gone. I tested this particular patch on a beagleboard, and although
I was never able to reproduce the corruption, it didn't cause any
further problems.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   28 ----------------------------
 1 files changed, 0 insertions(+), 28 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index 03b29b6..233ad17 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -62,13 +62,6 @@
 /* Max time to check for GP Timer IRQ */
 #define GPTIMER_IRQ_WAIT_MAX_CNT       1000
 
-static struct hw_mmu_map_attrs_t map_attrs = { HW_LITTLE_ENDIAN,
-	HW_ELEM_SIZE16BIT,
-	HW_MMU_CPUES
-};
-
-static void *dummy_va_addr;
-
 static struct omap_dm_timer *timer;
 
 dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
@@ -84,7 +77,6 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	/* Get WMD context info. */
 	dev_get_wmd_context(hdev_obj, &hwmd_context);
 	DBC_ASSERT(hwmd_context);
-	dummy_va_addr = NULL;
 	/* Allocate IO manager object: */
 	deh_mgr = kzalloc(sizeof(struct deh_mgr), GFP_KERNEL);
 	if (!deh_mgr) {
@@ -190,12 +182,8 @@ dsp_status bridge_deh_register_notify(struct deh_mgr *deh_mgr, u32 event_mask,
 void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 {
 	struct wmd_dev_context *dev_context;
-	dsp_status status = DSP_SOK;
-	u32 mem_physical = 0;
 	u32 hw_mmu_max_tlb_count = 31;
 	extern u32 fault_addr;
-	struct cfg_hostres *resources;
-	hw_status hw_status_obj;
 	u32 cnt = 0;
 
 	if (!deh_mgr)
@@ -203,7 +191,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 
 	dev_info(bridge, "%s: device exception\n", __func__);
 	dev_context = (struct wmd_dev_context *)deh_mgr->hwmd_context;
-	resources = dev_context->resources;
 
 	switch (ulEventMask) {
 	case DSP_SYSERROR:
@@ -228,9 +215,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			(unsigned int) deh_mgr->err_info.dw_val1,
 			(unsigned int) deh_mgr->err_info.dw_val2,
 			(unsigned int) fault_addr);
-		dummy_va_addr = kzalloc(sizeof(char) * 0x1000, GFP_ATOMIC);
-		mem_physical =
-			ALIGN_DOWN(virt_to_phys(dummy_va_addr), PAGE_SIZE);
 		dev_context = (struct wmd_dev_context *)
 			deh_mgr->hwmd_context;
 
@@ -247,13 +231,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			dev_context->num_tlb_entries =
 				dev_context->fixed_tlb_entries;
 		}
-		if (DSP_SUCCEEDED(status)) {
-			hw_status_obj =
-				hw_mmu_tlb_add(resources->dw_dmmu_base,
-						mem_physical, fault_addr,
-						HW_PAGE_SIZE4KB, 1,
-						&map_attrs, HW_SET, HW_SET);
-		}
 
 		/*
 		 * Send a GP Timer interrupt to DSP.
@@ -286,9 +263,6 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 			}
 		}
 
-		/* Clear MMU interrupt */
-		hw_mmu_event_ack(resources->dw_dmmu_base,
-				HW_MMU_TRANSLATION_FAULT);
 		dump_dsp_stack(deh_mgr->hwmd_context);
 		omap_dm_timer_disable(timer);
 		break;
@@ -356,6 +330,4 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 void bridge_deh_release_dummy_mem(void)
 {
-	kfree(dummy_va_addr);
-	dummy_va_addr = NULL;
 }
-- 
1.7.1

