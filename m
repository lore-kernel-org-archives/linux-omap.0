From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH 4/4][v4] OMAP:iommu- add TLB preservation support
Date: Thu, 22 Apr 2010 18:26:11 -0500
Message-ID: <1271978771-26889-5-git-send-email-h-kanigeri2@ti.com>
References: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56187 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab0DVXIZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Apr 2010 19:08:25 -0400
In-Reply-To: <1271978771-26889-1-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

This patch adds TLB preservation support to IOMMU module

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    4 ++-
 arch/arm/plat-omap/iommu.c   |   43 +++++++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index f01f985..5ce76e4 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -146,6 +146,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	printk("\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	omap2_iommu_disable(obj);
 	return stat;
 }
 
@@ -211,7 +212,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
 	char *p = buf;
 
 	/* FIXME: Need more detail analysis of cam/ram */
-	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
+	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
+					(cr->cam & MMU_CAM_P) ? 1 : 0);
 
 	return p - buf;
 }
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 463d638..38658e3 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -171,15 +171,12 @@ static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
 	l->base = MMU_LOCK_BASE(val);
 	l->vict = MMU_LOCK_VICT(val);
 
-	BUG_ON(l->base != 0); /* Currently no preservation is used */
 }
 
 static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
 {
 	u32 val;
 
-	BUG_ON(l->base != 0); /* Currently no preservation is used */
-
 	val = (l->base << MMU_LOCK_BASE_SHIFT);
 	val |= (l->vict << MMU_LOCK_VICT_SHIFT);
 
@@ -230,22 +227,32 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 
 	clk_enable(obj->clk);
 
-	for (i = 0; i < obj->nr_tlb_entries; i++) {
-		struct cr_regs tmp;
-
-		iotlb_lock_get(obj, &l);
-		l.vict = i;
-		iotlb_lock_set(obj, &l);
-		iotlb_read_cr(obj, &tmp);
-		if (!iotlb_cr_valid(&tmp))
-			break;
-	}
-
-	if (i == obj->nr_tlb_entries) {
-		dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
+	iotlb_lock_get(obj, &l);
+	if (l.base == obj->nr_tlb_entries) {
+		dev_warn(obj->dev, "%s: preserve entries full\n", __func__);
 		err = -EBUSY;
 		goto out;
 	}
+	if (!e->prsvd) {
+		for (i = l.base; i < obj->nr_tlb_entries; i++) {
+			struct cr_regs tmp;
+
+			iotlb_lock_get(obj, &l);
+			l.vict = i;
+			iotlb_lock_set(obj, &l);
+			iotlb_read_cr(obj, &tmp);
+			if (!iotlb_cr_valid(&tmp))
+				break;
+		}
+		if (i == obj->nr_tlb_entries) {
+			dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
+			err = -EBUSY;
+			goto out;
+		}
+	} else {
+		l.vict = l.base;
+		iotlb_lock_set(obj, &l);
+	}
 
 	cr = iotlb_alloc_cr(obj, e);
 	if (IS_ERR(cr)) {
@@ -256,9 +263,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 	iotlb_load_cr(obj, cr);
 	kfree(cr);
 
+	if (e->prsvd)
+		l.base++;
 	/* increment victim for next tlb load */
 	if (++l.vict == obj->nr_tlb_entries)
-		l.vict = 0;
+		l.vict = l.base;
 	iotlb_lock_set(obj, &l);
 out:
 	clk_disable(obj->clk);
-- 
1.7.0

