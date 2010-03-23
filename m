From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/10] dsp-bridge: deh: fix dummy_va_addr
Date: Tue, 23 Mar 2010 23:25:42 +0200
Message-ID: <1269379542-11892-11-git-send-email-felipe.contreras@gmail.com>
References: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:46268 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0CWV0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 17:26:36 -0400
Received: by mail-bw0-f209.google.com with SMTP id 1so2292192bwz.21
        for <linux-omap@vger.kernel.org>; Tue, 23 Mar 2010 14:26:35 -0700 (PDT)
In-Reply-To: <1269379542-11892-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

It's supposed to be virtual, so u32 doesn't make sense.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/wmd/ue_deh.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/dsp/bridge/wmd/ue_deh.c b/drivers/dsp/bridge/wmd/ue_deh.c
index b1c3189..018905e 100644
--- a/drivers/dsp/bridge/wmd/ue_deh.c
+++ b/drivers/dsp/bridge/wmd/ue_deh.c
@@ -52,15 +52,15 @@
 #include "_tiomap_pwr.h"
 #include <dspbridge/io_sm.h>
 
+#define ALIGN_DOWN(x,a)  ((x)&(~((a)-1)))
+
 static struct hw_mmu_map_attrs_t map_attrs = {
 	HW_LITTLE_ENDIAN,
 	HW_ELEM_SIZE16BIT,
 	HW_MMU_CPUES
 };
 
-#define VIRT_TO_PHYS(x)       ((x) - PAGE_OFFSET + PHYS_OFFSET)
-
-static u32 dummy_va_addr;
+static void *dummy_va_addr;
 
 dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 		struct dev_object *hdev_obj)
@@ -80,7 +80,7 @@ dsp_status bridge_deh_create(struct deh_mgr **ret_deh_mgr,
 	/* Get WMD context info. */
 	dev_get_wmd_context(hdev_obj, &hwmd_context);
 	DBC_ASSERT(hwmd_context);
-	dummy_va_addr = 0;
+	dummy_va_addr = NULL;
 	/* Allocate IO manager object: */
 	MEM_ALLOC_OBJECT(deh_mgr, struct deh_mgr, SIGNATURE);
 	if (!deh_mgr) {
@@ -210,13 +210,11 @@ void bridge_deh_notify(struct deh_mgr *deh_mgr, u32 ulEventMask, u32 dwErrInfo)
 				(unsigned int) deh_mgr->err_info.dw_val1,
 				(unsigned int) deh_mgr->err_info.dw_val2,
 				(unsigned int) fault_addr);
-		dummy_va_addr =
-			(u32) mem_calloc(sizeof(char) * 0x1000, MEM_PAGED);
-		mem_physical =
-			VIRT_TO_PHYS(PG_ALIGN_LOW
-					((u32) dummy_va_addr, PG_SIZE4K));
+		dummy_va_addr = mem_calloc(0x1000, MEM_PAGED);
+		mem_physical = ALIGN_DOWN(virt_to_phys(dummy_va_addr), PAGE_SIZE);
 		dev_context = (struct wmd_dev_context *)
 			deh_mgr->hwmd_context;
+
 		/*
 		 * Reset the dynamic mmu index to fixed count if it exceeds
 		 * 31. So that the dynmmuindex is always between the range of
@@ -291,6 +289,6 @@ dsp_status bridge_deh_get_info(struct deh_mgr *deh_mgr,
 
 void bridge_deh_release_dummy_mem(void)
 {
-	kfree((void *)dummy_va_addr);
-	dummy_va_addr = 0;
+	kfree(dummy_va_addr);
+	dummy_va_addr = NULL;
 }
-- 
1.7.0.3

