From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/6] omap: iommu: remove redundant clock usage
Date: Fri,  5 Nov 2010 19:19:51 -0600
Message-ID: <1289006396-27230-2-git-send-email-omar.ramirez@ti.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50214 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752281Ab0KFBaa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:30:30 -0400
In-Reply-To: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

iommu driver is meant to provide control of mmu hardware blocks
its current users (MMUs) are part of larger subsystems and do not
have a dedicated clock as the one they use is shared with the
entire subsystem, it doesn't make sense to enable/disable on each
register read/write operation as the driver using its interface
should also be handling the same clock.

iommu should only enable/disable the clock on mmu request/free from
the driver wanting to use it.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/iommu.c |   38 +++++---------------------------------
 1 files changed, 5 insertions(+), 33 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 6cd151b..de992c8 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -108,7 +108,6 @@ static int iommu_enable(struct iommu *obj)
 
 	err = arch_iommu->enable(obj);
 
-	clk_disable(obj->clk);
 	return err;
 }
 
@@ -117,8 +116,6 @@ static void iommu_disable(struct iommu *obj)
 	if (!obj)
 		return;
 
-	clk_enable(obj->clk);
-
 	arch_iommu->disable(obj);
 
 	clk_disable(obj->clk);
@@ -237,20 +234,16 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
  **/
 int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 {
-	int err = 0;
 	struct iotlb_lock l;
 	struct cr_regs *cr;
 
 	if (!obj || !obj->nr_tlb_entries || !e)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
-
 	iotlb_lock_get(obj, &l);
 	if (l.base == obj->nr_tlb_entries) {
 		dev_warn(obj->dev, "%s: preserve entries full\n", __func__);
-		err = -EBUSY;
-		goto out;
+		return -EBUSY;
 	}
 	if (!e->prsvd) {
 		int i;
@@ -262,8 +255,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 
 		if (i == obj->nr_tlb_entries) {
 			dev_dbg(obj->dev, "%s: full: no entry\n", __func__);
-			err = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 
 		iotlb_lock_get(obj, &l);
@@ -273,10 +265,8 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 	}
 
 	cr = iotlb_alloc_cr(obj, e);
-	if (IS_ERR(cr)) {
-		clk_disable(obj->clk);
+	if (IS_ERR(cr))
 		return PTR_ERR(cr);
-	}
 
 	iotlb_load_cr(obj, cr);
 	kfree(cr);
@@ -287,9 +277,8 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 	if (++l.vict == obj->nr_tlb_entries)
 		l.vict = l.base;
 	iotlb_lock_set(obj, &l);
-out:
-	clk_disable(obj->clk);
-	return err;
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(load_iotlb_entry);
 
@@ -305,8 +294,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 	int i;
 	struct cr_regs cr;
 
-	clk_enable(obj->clk);
-
 	for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, cr) {
 		u32 start;
 		size_t bytes;
@@ -324,7 +311,6 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
-	clk_disable(obj->clk);
 
 	if (i == obj->nr_tlb_entries)
 		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
@@ -359,15 +345,11 @@ void flush_iotlb_all(struct iommu *obj)
 {
 	struct iotlb_lock l;
 
-	clk_enable(obj->clk);
-
 	l.base = 0;
 	l.vict = 0;
 	iotlb_lock_set(obj, &l);
 
 	iommu_write_reg(obj, 1, MMU_GFLUSH);
-
-	clk_disable(obj->clk);
 }
 EXPORT_SYMBOL_GPL(flush_iotlb_all);
 
@@ -382,9 +364,7 @@ EXPORT_SYMBOL_GPL(flush_iotlb_all);
  */
 void iommu_set_twl(struct iommu *obj, bool on)
 {
-	clk_enable(obj->clk);
 	arch_iommu->set_twl(obj, on);
-	clk_disable(obj->clk);
 }
 EXPORT_SYMBOL_GPL(iommu_set_twl);
 
@@ -395,12 +375,8 @@ ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
 	if (!obj || !buf)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
-
 	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
 
-	clk_disable(obj->clk);
-
 	return bytes;
 }
 EXPORT_SYMBOL_GPL(iommu_dump_ctx);
@@ -412,7 +388,6 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 	struct cr_regs tmp;
 	struct cr_regs *p = crs;
 
-	clk_enable(obj->clk);
 	iotlb_lock_get(obj, &saved);
 
 	for_each_iotlb_cr(obj, num, i, tmp) {
@@ -422,7 +397,6 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 	}
 
 	iotlb_lock_set(obj, &saved);
-	clk_disable(obj->clk);
 
 	return  p - crs;
 }
@@ -795,9 +769,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!err)
 		return IRQ_HANDLED;
 
-	clk_enable(obj->clk);
 	stat = iommu_report_fault(obj, &da);
-	clk_disable(obj->clk);
 	if (!stat)
 		return IRQ_HANDLED;
 
-- 
1.7.1

