From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Fri, 23 Apr 2010 15:34:11 +0300 (EEST)
Message-ID: <20100423.153411.116357255.Hiroshi.DOYU@nokia.com>
References: <1271978196-26792-1-git-send-email-h-kanigeri2@ti.com>
	<1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49140 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313Ab0DWMex (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 08:34:53 -0400
In-Reply-To: <1271978196-26792-5-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: grgupta@ti.com, linux-omap@vger.kernel.org

Hi Hari,

From: ext Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Fri, 23 Apr 2010 01:16:36 +0200

> This patch adds TLB preservation support to IOMMU module
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

The above should be "Acked-by:"?

BTW:
Now the code gets a bit complicated for tlb iteration. So what about
introducing the following macro?

Not yet tested, though....

>From a88de5ab41792b5a34c460741b8f75f1611327b9 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Fri, 23 Apr 2010 15:18:46 +0300
Subject: [PATCH 1/1] omap iommu: introduce iteration macro for iotlb entries scan

There are some places to scan iotlb entries. This iteration macro
could make these code a bit simpler.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c |   55 ++++++++++++++++++++++---------------------
 1 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 1e83fac..d09a0a1 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -25,6 +25,9 @@
 
 #include "iopgtable.h"
 
+#define for_each_iotlb_cr(obj, n, i, cr)				\
+	for (i = 0; (i < n) && (cr = get_iotlb_cr(obj, i)); i++)
+
 /* accommodate the difference between omap1 and omap2/3 */
 static const struct iommu_functions *arch_iommu;
 
@@ -211,6 +214,19 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
 	return arch_iommu->dump_cr(obj, cr, buf);
 }
 
+static struct cr_regs get_iotlb_cr(struct iommu *obj, int n)
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
@@ -218,7 +234,6 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
  **/
 int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
-	int i;
 	int err = 0;
 	struct iotlb_lock l;
 	struct cr_regs *cr;
@@ -235,21 +250,20 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
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
@@ -285,20 +299,15 @@ EXPORT_SYMBOL_GPL(load_iotlb_entry);
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
 
@@ -308,7 +317,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 		if ((start <= da) && (da < start + bytes)) {
 			dev_dbg(obj->dev, "%s: %08x<=%08x(%x)\n",
 				__func__, start, da, bytes);
-			iotlb_load_cr(obj, &cr);
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
@@ -379,26 +387,19 @@ EXPORT_SYMBOL_GPL(iommu_dump_ctx);
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


