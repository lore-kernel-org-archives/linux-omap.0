From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 01/15] tidspbridge: hw_mmu: Reorder functions to avoid forward declarations
Date: Wed, 19 Sep 2012 14:06:49 +0200
Message-ID: <1348056423-25573-2-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35801 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754259Ab2ISMGb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 08:06:31 -0400
In-Reply-To: <1348056423-25573-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 drivers/staging/tidspbridge/hw/hw_mmu.c |   95 +++++++++++++------------------
 1 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/tidspbridge/hw/hw_mmu.c b/drivers/staging/tidspbridge/hw/hw_mmu.c
index 8a93d55..2194a3f 100644
--- a/drivers/staging/tidspbridge/hw/hw_mmu.c
+++ b/drivers/staging/tidspbridge/hw/hw_mmu.c
@@ -70,7 +70,16 @@ enum hw_mmu_page_size_t {
  * METHOD:	       : Check the Input parameter and Flush a
  *			 single entry in the TLB.
  */
-static hw_status mmu_flush_entry(const void __iomem *base_address);
+static hw_status mmu_flush_entry(const void __iomem *base_address)
+{
+	hw_status status = 0;
+	u32 flush_entry_data = 0x1;
+
+	/* write values to register */
+	MMUMMU_FLUSH_ENTRY_WRITE_REGISTER32(base_address, flush_entry_data);
+
+	return status;
+}
 
 /*
  * FUNCTION	      : mmu_set_cam_entry
@@ -116,7 +125,20 @@ static hw_status mmu_set_cam_entry(const void __iomem *base_address,
 				   const u32 page_sz,
 				   const u32 preserved_bit,
 				   const u32 valid_bit,
-				   const u32 virtual_addr_tag);
+				   const u32 virtual_addr_tag)
+{
+	hw_status status = 0;
+	u32 mmu_cam_reg;
+
+	mmu_cam_reg = (virtual_addr_tag << 12);
+	mmu_cam_reg = (mmu_cam_reg) | (page_sz) | (valid_bit << 2) |
+	    (preserved_bit << 3);
+
+	/* write values to register */
+	MMUMMU_CAM_WRITE_REGISTER32(base_address, mmu_cam_reg);
+
+	return status;
+}
 
 /*
  * FUNCTION	      : mmu_set_ram_entry
@@ -161,7 +183,21 @@ static hw_status mmu_set_ram_entry(const void __iomem *base_address,
 				   const u32 physical_addr,
 				   enum hw_endianism_t endianism,
 				   enum hw_element_size_t element_size,
-				   enum hw_mmu_mixed_size_t mixed_size);
+				   enum hw_mmu_mixed_size_t mixed_size)
+{
+	hw_status status = 0;
+	u32 mmu_ram_reg;
+
+	mmu_ram_reg = (physical_addr & MMU_ADDR_MASK);
+	mmu_ram_reg = (mmu_ram_reg) | ((endianism << 9) | (element_size << 7) |
+				       (mixed_size << 6));
+
+	/* write values to register */
+	MMUMMU_RAM_WRITE_REGISTER32(base_address, mmu_ram_reg);
+
+	return status;
+
+}
 
 /* HW FUNCTIONS */
 
@@ -503,59 +539,6 @@ hw_status hw_mmu_pte_clear(const u32 pg_tbl_va, u32 virtual_addr, u32 page_size)
 	return status;
 }
 
-/* mmu_flush_entry */
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
-/* mmu_set_cam_entry */
-static hw_status mmu_set_cam_entry(const void __iomem *base_address,
-				   const u32 page_sz,
-				   const u32 preserved_bit,
-				   const u32 valid_bit,
-				   const u32 virtual_addr_tag)
-{
-	hw_status status = 0;
-	u32 mmu_cam_reg;
-
-	mmu_cam_reg = (virtual_addr_tag << 12);
-	mmu_cam_reg = (mmu_cam_reg) | (page_sz) | (valid_bit << 2) |
-	    (preserved_bit << 3);
-
-	/* write values to register */
-	MMUMMU_CAM_WRITE_REGISTER32(base_address, mmu_cam_reg);
-
-	return status;
-}
-
-/* mmu_set_ram_entry */
-static hw_status mmu_set_ram_entry(const void __iomem *base_address,
-				   const u32 physical_addr,
-				   enum hw_endianism_t endianism,
-				   enum hw_element_size_t element_size,
-				   enum hw_mmu_mixed_size_t mixed_size)
-{
-	hw_status status = 0;
-	u32 mmu_ram_reg;
-
-	mmu_ram_reg = (physical_addr & MMU_ADDR_MASK);
-	mmu_ram_reg = (mmu_ram_reg) | ((endianism << 9) | (element_size << 7) |
-				       (mixed_size << 6));
-
-	/* write values to register */
-	MMUMMU_RAM_WRITE_REGISTER32(base_address, mmu_ram_reg);
-
-	return status;
-
-}
-
 void hw_mmu_tlb_flush_all(const void __iomem *base)
 {
 	__raw_writel(1, base + MMU_GFLUSH);
-- 
1.7.8.6

