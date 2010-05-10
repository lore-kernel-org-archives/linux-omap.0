From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: add TLB preservation support
Date: Mon, 10 May 2010 12:16:07 +0300
Message-ID: <1273482972-5586-4-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:28047 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753599Ab0EJJRF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 05:17:05 -0400
In-Reply-To: <1273482972-5586-1-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

This patch adds TLB preservation support to IOMMU module

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c |    4 ++-
 arch/arm/plat-omap/iommu.c   |   43 +++++++++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index d29ebff..e82da68 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -147,6 +147,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	printk("\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
+	omap2_iommu_disable(obj);
 	return stat;
 }
 
@@ -212,7 +213,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
 	char *p = buf;
 
 	/* FIXME: Need more detail analysis of cam/ram */
-	p += sprintf(p, "%08x %08x\n", cr->cam, cr->ram);
+	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
+					(cr->cam & MMU_CAM_P) ? 1 : 0);
 
 	return p - buf;
 }
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 0e13766..1e83fac 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -172,15 +172,12 @@ static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
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
 
@@ -231,22 +228,32 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 
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
@@ -257,9 +264,11 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
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
1.7.1.rc1

