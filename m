From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 02/15] tidspbridge: hw_mmu: Removed unused functions
Date: Wed, 19 Sep 2012 14:06:50 +0200
Message-ID: <1348056423-25573-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35804 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755520Ab2ISMGc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:32 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

The hw_mmu_tlb_flush() function is unused, and the mmu_flush_entry()
function is used by hw_mmu_tlb_flush() only. Remove them both.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/hw/hw_mmu.c |   72 -------------------------------
 drivers/staging/tidspbridge/hw/hw_mmu.h |    3 -
 2 files changed, 0 insertions(+), 75 deletions(-)

diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index 2194a3f..981794d 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
@@ -48,40 +48,6 @@ enum hw_mmu_page_size_t {
 };
 
 /*
- * FUNCTION	      : mmu_flush_entry
- *
- * INPUTS:
- *
- *       Identifier      : base_address
- *       Type		: const u32
- *       Description     : Base Address of instance of MMU module
- *
- * RETURNS:
- *
- *       Type		: hw_status
- *       Description     : 0		 -- No errors occurred
- *			 RET_BAD_NULL_PARAM     -- A Pointer
- *						Paramater was set to NULL
- *
- * PURPOSE:	      : Flush the TLB entry pointed by the
- *			lock counter register
- *			even if this entry is set protected
- *
- * METHOD:	       : Check the Input parameter and Flush a
- *			 single entry in the TLB.
- */
-static hw_status mmu_flush_entry(const void __iomem *base_address)
-{
-	hw_status status = 0;
-	u32 flush_entry_data = 0x1;
-
-	/* write values to register */
-	MMUMMU_FLUSH_ENTRY_WRITE_REGISTER32(base_address, flush_entry_data);
-
-	return status;
-}
-
-/*
  * FUNCTION	      : mmu_set_cam_entry
  *
  * INPUTS:
@@ -321,44 +287,6 @@ hw_status hw_mmu_twl_disable(const void __iomem *base_address)
 	return status;
 }
 
-hw_status hw_mmu_tlb_flush(const void __iomem *base_address, u32 virtual_addr,
-			   u32 page_sz)
-{
-	hw_status status = 0;
-	u32 virtual_addr_tag;
-	enum hw_mmu_page_size_t pg_size_bits;
-
-	switch (page_sz) {
-	case HW_PAGE_SIZE4KB:
-		pg_size_bits = HW_MMU_SMALL_PAGE;
-		break;
-
-	case HW_PAGE_SIZE64KB:
-		pg_size_bits = HW_MMU_LARGE_PAGE;
-		break;
-
-	case HW_PAGE_SIZE1MB:
-		pg_size_bits = HW_MMU_SECTION;
-		break;
-
-	case HW_PAGE_SIZE16MB:
-		pg_size_bits = HW_MMU_SUPERSECTION;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	/* Generate the 20-bit tag from virtual address */
-	virtual_addr_tag = ((virtual_addr & MMU_ADDR_MASK) >> 12);
-
-	mmu_set_cam_entry(base_address, pg_size_bits, 0, 0, virtual_addr_tag);
-
-	mmu_flush_entry(base_address);
-
-	return status;
-}
-
 hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 			 u32 physical_addr,
 			 u32 virtual_addr,
diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.h b/drivers/staging/tidspbridge/hw/hw_mmu.h
index 1458a2c..7f960cd 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.h
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.h
@@ -76,9 +76,6 @@ extern hw_status hw_mmu_twl_enable(const void __iomem *base_address);
 
 extern hw_status hw_mmu_twl_disable(const void __iomem *base_address);
 
-extern hw_status hw_mmu_tlb_flush(const void __iomem *base_address,
-				  u32 virtual_addr, u32 page_sz);
-
 extern hw_status hw_mmu_tlb_add(const void __iomem *base_address,
 				u32 physical_addr,
 				u32 virtual_addr,
-- 
1.7.8.6

