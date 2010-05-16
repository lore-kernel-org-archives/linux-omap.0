From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/14] dspbridge: mmu: add hw_mmu_tlb_flush_all()
Date: Sun, 16 May 2010 18:45:57 +0300
Message-ID: <1274024765-21076-7-git-send-email-felipe.contreras@gmail.com>
References: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:5081 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268Ab0EPPqV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 May 2010 11:46:21 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2359940fga.1
        for <linux-omap@vger.kernel.org>; Sun, 16 May 2010 08:46:20 -0700 (PDT)
In-Reply-To: <1274024765-21076-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

So that it can be used in more than one place.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/dsp/bridge/core/tiomap3430.c |    9 +--------
 drivers/dsp/bridge/hw/hw_mmu.c       |    6 ++++++
 drivers/dsp/bridge/hw/hw_mmu.h       |    2 ++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/dsp/bridge/core/tiomap3430.c b/drivers/dsp/bridge/core/tiomap3430.c
index 8a3eff9..d00eaaa 100644
--- a/drivers/dsp/bridge/core/tiomap3430.c
+++ b/drivers/dsp/bridge/core/tiomap3430.c
@@ -74,8 +74,6 @@
 #define PAGES_II_LVL_TABLE   512
 #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
 
-#define MMU_GFLUSH 0x60
-
 /* Forward Declarations: */
 static dsp_status bridge_brd_monitor(struct bridge_dev_context *dev_context);
 static dsp_status bridge_brd_read(struct bridge_dev_context *dev_context,
@@ -216,18 +214,13 @@ static struct bridge_drv_interface drv_interface_fxns = {
 	bridge_msg_set_queue_id,
 };
 
-static inline void tlb_flush_all(const void __iomem *base)
-{
-	__raw_writeb(__raw_readb(base + MMU_GFLUSH) | 1, base + MMU_GFLUSH);
-}
-
 static inline void flush_all(struct bridge_dev_context *dev_context)
 {
 	if (dev_context->dw_brd_state == BRD_DSP_HIBERNATION ||
 	    dev_context->dw_brd_state == BRD_HIBERNATION)
 		wake_dsp(dev_context, NULL);
 
-	tlb_flush_all(dev_context->dw_dsp_mmu_base);
+	hw_mmu_tlb_flush_all(dev_context->dw_dsp_mmu_base);
 }
 
 static void bad_page_dump(u32 pa, struct page *pg)
diff --git a/drivers/dsp/bridge/hw/hw_mmu.c b/drivers/dsp/bridge/hw/hw_mmu.c
index 965b659..e593358 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.c
+++ b/drivers/dsp/bridge/hw/hw_mmu.c
@@ -35,6 +35,7 @@
 #define MMU_SMALL_PAGE_MASK      0xFFFFF000
 
 #define MMU_LOAD_TLB	0x00000001
+#define MMU_GFLUSH	0x60
 
 /*
  * hw_mmu_page_size_t: Enumerated Type used to specify the MMU Page Size(SLSS)
@@ -585,3 +586,8 @@ static hw_status mmu_set_ram_entry(const void __iomem *baseAddress,
 	return status;
 
 }
+
+void hw_mmu_tlb_flush_all(const void __iomem *base)
+{
+	__raw_writeb(1, base + MMU_GFLUSH);
+}
diff --git a/drivers/dsp/bridge/hw/hw_mmu.h b/drivers/dsp/bridge/hw/hw_mmu.h
index 9b13468..0436974 100644
--- a/drivers/dsp/bridge/hw/hw_mmu.h
+++ b/drivers/dsp/bridge/hw/hw_mmu.h
@@ -97,6 +97,8 @@ extern hw_status hw_mmu_pte_set(const u32 pg_tbl_va,
 extern hw_status hw_mmu_pte_clear(const u32 pg_tbl_va,
 				  u32 page_size, u32 virtualAddr);
 
+void hw_mmu_tlb_flush_all(const void __iomem *base);
+
 static inline u32 hw_mmu_pte_addr_l1(u32 L1_base, u32 va)
 {
 	u32 pte_addr;
-- 
1.7.1

