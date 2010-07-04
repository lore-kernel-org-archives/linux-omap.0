From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/13] staging: ti dspbridge: mmu: add hw_mmu_tlb_flush_all()
Date: Sun,  4 Jul 2010 16:34:31 +0300
Message-ID: <1278250479-16982-6-git-send-email-felipe.contreras@gmail.com>
References: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40955 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757698Ab0GDNex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jul 2010 09:34:53 -0400
Received: by mail-bw0-f46.google.com with SMTP id 1so2295322bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 04 Jul 2010 06:34:52 -0700 (PDT)
In-Reply-To: <1278250479-16982-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Greg KH <greg@kroah.com>, Felipe Contreras <felipe.contreras@gmail.com>

So that it can be used in more than one place.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/core/tiomap3430.c |    9 +--------
 drivers/staging/tidspbridge/hw/hw_mmu.c       |    6 ++++++
 drivers/staging/tidspbridge/hw/hw_mmu.h       |    2 ++
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/tidspbridge/core/tiomap3430.c b/drivers/staging/tidspbridge/core/tiomap3430.c
index d1fa560..1000c04 100644
--- a/drivers/staging/tidspbridge/core/tiomap3430.c
+++ b/drivers/staging/tidspbridge/core/tiomap3430.c
@@ -73,8 +73,6 @@
 #define PAGES_II_LVL_TABLE   512
 #define PHYS_TO_PAGE(phys)      pfn_to_page((phys) >> PAGE_SHIFT)
 
-#define MMU_GFLUSH 0x60
-
 /* Forward Declarations: */
 static int bridge_brd_monitor(struct bridge_dev_context *dev_context);
 static int bridge_brd_read(struct bridge_dev_context *dev_context,
@@ -218,18 +216,13 @@ static struct bridge_drv_interface drv_interface_fxns = {
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
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index 965b659..e593358 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
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
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index 9b13468..0436974 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
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

