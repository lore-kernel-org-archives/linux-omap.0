From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 3/7] omap: iommu: stop exporting local functions
Date: Wed, 24 Aug 2011 20:08:10 +0300
Message-ID: <1314205694-28935-4-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39540 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab1HXRJG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 13:09:06 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1002345wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 10:09:05 -0700 (PDT)
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Stop exporting functions that are used only within the iommu
driver itself.

Eventually OMAP's iommu driver should only expose API via the generic
IOMMU framework.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/plat/iommu.h |    8 --------
 drivers/iommu/omap-iommu.c              |   19 +++++++------------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index dcb757b..4e9c05c 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -153,18 +153,10 @@ struct iommu_platform_data {
 extern u32 iommu_arch_version(void);
 
 extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
-extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
-
-extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
 extern void iommu_set_twl(struct iommu *obj, bool on);
-extern void flush_iotlb_page(struct iommu *obj, u32 da);
 extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
-extern void flush_iotlb_all(struct iommu *obj);
 
 extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
-extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd,
-				   u32 **ppte);
-extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
 extern int iommu_set_isr(const char *name,
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index bf8de64..3aad2e3 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -171,11 +171,10 @@ static inline struct cr_regs *iotlb_alloc_cr(struct iommu *obj,
 	return arch_iommu->alloc_cr(obj, e);
 }
 
-u32 iotlb_cr_to_virt(struct cr_regs *cr)
+static u32 iotlb_cr_to_virt(struct cr_regs *cr)
 {
 	return arch_iommu->cr_to_virt(cr);
 }
-EXPORT_SYMBOL_GPL(iotlb_cr_to_virt);
 
 static u32 get_iopte_attr(struct iotlb_entry *e)
 {
@@ -254,7 +253,7 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
 	struct iotlb_lock l;
@@ -310,7 +309,6 @@ out:
 	clk_disable(obj->clk);
 	return err;
 }
-EXPORT_SYMBOL_GPL(load_iotlb_entry);
 
 /**
  * flush_iotlb_page - Clear an iommu tlb entry
@@ -319,7 +317,7 @@ EXPORT_SYMBOL_GPL(load_iotlb_entry);
  *
  * Clear an iommu tlb entry which includes 'da' address.
  **/
-void flush_iotlb_page(struct iommu *obj, u32 da)
+static void flush_iotlb_page(struct iommu *obj, u32 da)
 {
 	int i;
 	struct cr_regs cr;
@@ -348,7 +346,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 	if (i == obj->nr_tlb_entries)
 		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
 }
-EXPORT_SYMBOL_GPL(flush_iotlb_page);
 
 /**
  * flush_iotlb_range - Clear an iommu tlb entries
@@ -374,7 +371,7 @@ EXPORT_SYMBOL_GPL(flush_iotlb_range);
  * flush_iotlb_all - Clear all iommu tlb entries
  * @obj:	target iommu
  **/
-void flush_iotlb_all(struct iommu *obj)
+static void flush_iotlb_all(struct iommu *obj)
 {
 	struct iotlb_lock l;
 
@@ -388,7 +385,6 @@ void flush_iotlb_all(struct iommu *obj)
 
 	clk_disable(obj->clk);
 }
-EXPORT_SYMBOL_GPL(flush_iotlb_all);
 
 /**
  * iommu_set_twl - enable/disable table walking logic
@@ -682,7 +678,8 @@ EXPORT_SYMBOL_GPL(iopgtable_store_entry);
  * @ppgd:	iommu pgd entry pointer to be returned
  * @ppte:	iommu pte entry pointer to be returned
  **/
-void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd, u32 **ppte)
+static void
+iopgtable_lookup_entry(struct omap_iommu *obj, u32 da, u32 **ppgd, u32 **ppte)
 {
 	u32 *iopgd, *iopte = NULL;
 
@@ -696,7 +693,6 @@ out:
 	*ppgd = iopgd;
 	*ppte = iopte;
 }
-EXPORT_SYMBOL_GPL(iopgtable_lookup_entry);
 
 static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
 {
@@ -751,7 +747,7 @@ out:
  * @obj:	target iommu
  * @da:		iommu device virtual address
  **/
-size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
+static size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
 {
 	size_t bytes;
 
@@ -764,7 +760,6 @@ size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(iopgtable_clear_entry);
 
 static void iopgtable_clear_entry_all(struct iommu *obj)
 {
-- 
1.7.4.1

