From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 08/17] iommu/omap: Simplify omap2_iommu_fault_isr()
Date: Wed, 22 Oct 2014 17:22:26 -0500
Message-ID: <1414016555-28067-9-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49931 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933392AbaJVWWr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:47 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The function omap2_iommu_fault_isr() does an unnecessary
recomputation of the return value. The logic relies on
setting the same bit fields as the MMU fault error status
bits, so simplify this function and remove the unneeded
macros. These macros were originally exported to notify
MMU faults to users prior to the IOMMU framework adaptation,
but are now redundant.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu2.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
index 372141b..ce2fff3 100644
--- a/drivers/iommu/omap-iommu2.c
+++ b/drivers/iommu/omap-iommu2.c
@@ -53,13 +53,6 @@
 	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
 	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
 
-/* IOMMU errors */
-#define OMAP_IOMMU_ERR_TLB_MISS		(1 << 0)
-#define OMAP_IOMMU_ERR_TRANS_FAULT	(1 << 1)
-#define OMAP_IOMMU_ERR_EMU_MISS		(1 << 2)
-#define OMAP_IOMMU_ERR_TBLWALK_FAULT	(1 << 3)
-#define OMAP_IOMMU_ERR_MULTIHIT_FAULT	(1 << 4)
-
 static void __iommu_set_twl(struct omap_iommu *obj, bool on)
 {
 	u32 l = iommu_read_reg(obj, MMU_CNTL);
@@ -122,7 +115,6 @@ static void omap2_iommu_set_twl(struct omap_iommu *obj, bool on)
 static u32 omap2_iommu_fault_isr(struct omap_iommu *obj, u32 *ra)
 {
 	u32 stat, da;
-	u32 errs = 0;
 
 	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
 	stat &= MMU_IRQ_MASK;
@@ -134,19 +126,9 @@ static u32 omap2_iommu_fault_isr(struct omap_iommu *obj, u32 *ra)
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
 
-	if (stat & MMU_IRQ_TLBMISS)
-		errs |= OMAP_IOMMU_ERR_TLB_MISS;
-	if (stat & MMU_IRQ_TRANSLATIONFAULT)
-		errs |= OMAP_IOMMU_ERR_TRANS_FAULT;
-	if (stat & MMU_IRQ_EMUMISS)
-		errs |= OMAP_IOMMU_ERR_EMU_MISS;
-	if (stat & MMU_IRQ_TABLEWALKFAULT)
-		errs |= OMAP_IOMMU_ERR_TBLWALK_FAULT;
-	if (stat & MMU_IRQ_MULTIHITFAULT)
-		errs |= OMAP_IOMMU_ERR_MULTIHIT_FAULT;
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
 
-	return errs;
+	return stat;
 }
 
 static void omap2_tlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
-- 
2.1.0

