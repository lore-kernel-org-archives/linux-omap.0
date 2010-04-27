From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap iommu: introduce iteration macro for iotlb entry scan
Date: Tue, 27 Apr 2010 08:37:12 +0300
Message-ID: <1272346632-30435-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E4B571F42@dlee03.ent.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:19348 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735Ab0D0Fiy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 01:38:54 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4B571F42@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: grgupta@ti.com, h-kanigeri2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There are some places to scan iotlb entries. This iteration macro
could make these code a bit simpler with proceeding iotlb entries
transparently.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Tested-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |   58 +++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 532b849..dc29b77 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -24,6 +24,11 @@
 
 #include "iopgtable.h"
 
+#define for_each_iotlb_cr(obj, n, __i, cr)				\
+	for (__i = 0;							\
+	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
+	     __i++)
+
 /* accommodate the difference between omap1 and omap2/3 */
 static const struct iommu_functions *arch_iommu;
 
@@ -210,6 +215,20 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
 	return arch_iommu->dump_cr(obj, cr, buf);
 }
 
+/* only used in iotlb iteration for-loop */
+static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
+{
+	struct cr_regs cr;
+	struct iotlb_lock l;
+
+	iotlb_lock_get(obj, &l);
+	l.vict = n;
+	iotlb_lock_set(obj, &l);
+	iotlb_read_cr(obj, &cr);
+
+	return cr;
+}
+
 /**
  * load_iotlb_entry - Set an iommu tlb entry
  * @obj:	target iommu
@@ -217,7 +236,6 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
  **/
 int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
-	int i;
 	int err = 0;
 	struct iotlb_lock l;
 	struct cr_regs *cr;
@@ -234,21 +252,20 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 		goto out;
 	}
 	if (!e->prsvd) {
-		for (i = l.base; i < obj->nr_tlb_entries; i++) {
-			struct cr_regs tmp;
+		int i;
+		struct cr_regs tmp;
 
-			iotlb_lock_get(obj, &l);
-			l.vict = i;
-			iotlb_lock_set(obj, &l);
-			iotlb_read_cr(obj, &tmp);
+		for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, tmp)
 			if (!iotlb_cr_valid(&tmp))
 				break;
-		}
+
 		if (i == obj->nr_tlb_entries) {
 			dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
 			err = -EBUSY;
 			goto out;
 		}
+
+		iotlb_lock_get(obj, &l);
 	} else {
 		l.vict = l.base;
 		iotlb_lock_set(obj, &l);
@@ -284,20 +301,15 @@ EXPORT_SYMBOL_GPL(load_iotlb_entry);
  **/
 void flush_iotlb_page(struct iommu *obj, u32 da)
 {
-	struct iotlb_lock l;
 	int i;
+	struct cr_regs cr;
 
 	clk_enable(obj->clk);
 
-	for (i = 0; i < obj->nr_tlb_entries; i++) {
-		struct cr_regs cr;
+	for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, cr) {
 		u32 start;
 		size_t bytes;
 
-		iotlb_lock_get(obj, &l);
-		l.vict = i;
-		iotlb_lock_set(obj, &l);
-		iotlb_read_cr(obj, &cr);
 		if (!iotlb_cr_valid(&cr))
 			continue;
 
@@ -307,7 +319,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 		if ((start <= da) && (da < start + bytes)) {
 			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
 				__func__, start, da, bytes);
-			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
@@ -378,26 +389,19 @@ EXPORT_SYMBOL_GPL(iommu_dump_ctx);
 static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 {
 	int i;
-	struct iotlb_lock saved, l;
+	struct iotlb_lock saved;
+	struct cr_regs tmp;
 	struct cr_regs *p = crs;
 
 	clk_enable(obj->clk);
-
 	iotlb_lock_get(obj, &saved);
-	memcpy(&l, &saved, sizeof(saved));
 
-	for (i = 0; i < num; i++) {
-		struct cr_regs tmp;
-
-		iotlb_lock_get(obj, &l);
-		l.vict = i;
-		iotlb_lock_set(obj, &l);
-		iotlb_read_cr(obj, &tmp);
+	for_each_iotlb_cr(obj, num, i, tmp) {
 		if (!iotlb_cr_valid(&tmp))
 			continue;
-
 		*p++ = tmp;
 	}
+
 	iotlb_lock_set(obj, &saved);
 	clk_disable(obj->clk);
 
-- 
1.7.1.rc1

