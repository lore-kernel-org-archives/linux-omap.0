From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: Introduce iteration macro for iotlb entry scan
Date: Mon, 10 May 2010 12:16:08 +0300
Message-ID: <1273482972-5586-5-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48645 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178Ab0EJJQm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:16:42 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

There are some places to scan iotlb entries. This iteration macro
could make these code a bit simpler with proceeding iotlb entries
transparently.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Tested-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/plat-omap/iommu.c |   58 +++++++++++++++++++++++--------------------
 1 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 1e83fac..9598d40 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -25,6 +25,11 @@
 
 #include "iopgtable.h"
 
+#define for_each_iotlb_cr(obj, n, __i, cr)				\
+	for (__i = 0;							\
+	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
+	     __i++)
+
 /* accommodate the difference between omap1 and omap2/3 */
 static const struct iommu_functions *arch_iommu;
 
@@ -211,6 +216,20 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
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
@@ -218,7 +237,6 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
  **/
 int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
-	int i;
 	int err = 0;
 	struct iotlb_lock l;
 	struct cr_regs *cr;
@@ -235,21 +253,20 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
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
@@ -285,20 +302,15 @@ EXPORT_SYMBOL_GPL(load_iotlb_entry);
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
 
@@ -308,7 +320,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 		if ((start <= da) && (da < start + bytes)) {
 			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
 				__func__, start, da, bytes);
-			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
@@ -379,26 +390,19 @@ EXPORT_SYMBOL_GPL(iommu_dump_ctx);
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

