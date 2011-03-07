From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Mon,  7 Mar 2011 01:53:08 -0600
Message-ID: <1299484388-16205-5-git-send-email-omar.ramirez@ti.com>
References: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42935 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab1CGIEz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 03:04:55 -0500
In-Reply-To: <1299484388-16205-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@eeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Use runtime PM functionality interfaced with hwmod enable/idle
functions, to replace direct clock operations, reset and sysconfig
handling.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/iommu2.c             |   17 ----------
 arch/arm/mach-omap2/omap-iommu.c         |    1 -
 arch/arm/plat-omap/include/plat/iommu.h  |    2 -
 arch/arm/plat-omap/include/plat/iommu2.h |    2 -
 arch/arm/plat-omap/iommu.c               |   50 ++++++++++++++----------------
 5 files changed, 23 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index a22d812..89821d7 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -25,15 +25,6 @@
  */
 #define IOMMU_ARCH_VERSION	0x00000011
 
-/* SYSCONF */
-#define MMU_SYS_IDLE_SHIFT	3
-#define MMU_SYS_IDLE_FORCE	(0 << MMU_SYS_IDLE_SHIFT)
-#define MMU_SYS_IDLE_NONE	(1 << MMU_SYS_IDLE_SHIFT)
-#define MMU_SYS_IDLE_SMART	(2 << MMU_SYS_IDLE_SHIFT)
-#define MMU_SYS_IDLE_MASK	(3 << MMU_SYS_IDLE_SHIFT)
-
-#define MMU_SYS_AUTOIDLE	1
-
 /* IRQSTATUS & IRQENABLE */
 #define MMU_IRQ_MULTIHITFAULT	(1 << 4)
 #define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
@@ -96,11 +87,6 @@ static int omap2_iommu_enable(struct iommu *obj)
 	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
 		 (l >> 4) & 0xf, l & 0xf);
 
-	l = iommu_read_reg(obj, MMU_SYSCONFIG);
-	l &= ~MMU_SYS_IDLE_MASK;
-	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
-	iommu_write_reg(obj, l, MMU_SYSCONFIG);
-
 	iommu_write_reg(obj, pa, MMU_TTB);
 
 	__iommu_set_twl(obj, true);
@@ -114,7 +100,6 @@ static void omap2_iommu_disable(struct iommu *obj)
 
 	l &= ~MMU_CNTL_MASK;
 	iommu_write_reg(obj, l, MMU_CNTL);
-	iommu_write_reg(obj, MMU_SYS_IDLE_FORCE, MMU_SYSCONFIG);
 
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
@@ -240,8 +225,6 @@ static ssize_t omap2_iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len)
 	char *p = buf;
 
 	pr_reg(REVISION);
-	pr_reg(SYSCONFIG);
-	pr_reg(SYSSTATUS);
 	pr_reg(IRQSTATUS);
 	pr_reg(IRQENABLE);
 	pr_reg(WALKING_ST);
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 564a078..37a000c 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -33,7 +33,6 @@ static int omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 	static int i;
 
 	pdata.name = oh->name;
-	pdata.clk_name = oh->main_clk;
 	pdata.nr_tlb_entries = a->nr_tlb_entries;
 	pdata.da_start = a->da_start;
 	pdata.da_end = a->da_end;
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 60f7c77..1ee01a9 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -28,7 +28,6 @@ struct iotlb_entry {
 struct iommu {
 	const char	*name;
 	struct module	*owner;
-	struct clk	*clk;
 	void __iomem	*regbase;
 	struct device	*dev;
 	void		*isr_priv;
@@ -114,7 +113,6 @@ struct omap_mmu_dev_attr {
 
 struct iommu_platform_data {
 	const char *name;
-	const char *clk_name;
 	int nr_tlb_entries;
 	u32 da_start;
 	u32 da_end;
diff --git a/arch/arm/plat-omap/include/plat/iommu2.h b/arch/arm/plat-omap/include/plat/iommu2.h
index 10ad05f..0cd475e 100644
--- a/arch/arm/plat-omap/include/plat/iommu2.h
+++ b/arch/arm/plat-omap/include/plat/iommu2.h
@@ -19,8 +19,6 @@
  * MMU Register offsets
  */
 #define MMU_REVISION		0x00
-#define MMU_SYSCONFIG		0x10
-#define MMU_SYSSTATUS		0x14
 #define MMU_IRQSTATUS		0x18
 #define MMU_IRQENABLE		0x1c
 #define MMU_WALKING_ST		0x40
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index e3eb038..510b5bb 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -16,8 +16,8 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/cacheflush.h>
 
@@ -107,11 +107,13 @@ static int iommu_enable(struct iommu *obj)
 	if (!arch_iommu)
 		return -ENODEV;
 
-	clk_enable(obj->clk);
+	pm_runtime_enable(obj->dev);
+	pm_runtime_get_sync(obj->dev);
 
 	err = arch_iommu->enable(obj);
 
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
+
 	return err;
 }
 
@@ -120,11 +122,12 @@ static void iommu_disable(struct iommu *obj)
 	if (!obj)
 		return;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	arch_iommu->disable(obj);
 
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
+	pm_runtime_disable(obj->dev);
 }
 
 /*
@@ -247,7 +250,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 	if (!obj || !obj->nr_tlb_entries || !e)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	iotlb_lock_get(obj, &l);
 	if (l.base == obj->nr_tlb_entries) {
@@ -277,7 +280,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 
 	cr = iotlb_alloc_cr(obj, e);
 	if (IS_ERR(cr)) {
-		clk_disable(obj->clk);
+		pm_runtime_put_sync(obj->dev);
 		return PTR_ERR(cr);
 	}
 
@@ -291,7 +294,7 @@ int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
 		l.vict = l.base;
 	iotlb_lock_set(obj, &l);
 out:
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(load_iotlb_entry);
@@ -308,7 +311,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 	int i;
 	struct cr_regs cr;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, cr) {
 		u32 start;
@@ -327,7 +330,7 @@ void flush_iotlb_page(struct iommu *obj, u32 da)
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 
 	if (i == obj->nr_tlb_entries)
 		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
@@ -362,7 +365,7 @@ void flush_iotlb_all(struct iommu *obj)
 {
 	struct iotlb_lock l;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	l.base = 0;
 	l.vict = 0;
@@ -370,7 +373,7 @@ void flush_iotlb_all(struct iommu *obj)
 
 	iommu_write_reg(obj, 1, MMU_GFLUSH);
 
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 }
 EXPORT_SYMBOL_GPL(flush_iotlb_all);
 
@@ -385,9 +388,9 @@ EXPORT_SYMBOL_GPL(flush_iotlb_all);
  */
 void iommu_set_twl(struct iommu *obj, bool on)
 {
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 	arch_iommu->set_twl(obj, on);
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 }
 EXPORT_SYMBOL_GPL(iommu_set_twl);
 
@@ -398,11 +401,11 @@ ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
 	if (!obj || !buf)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
 
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 
 	return bytes;
 }
@@ -415,7 +418,7 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 	struct cr_regs tmp;
 	struct cr_regs *p = crs;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 	iotlb_lock_get(obj, &saved);
 
 	for_each_iotlb_cr(obj, num, i, tmp) {
@@ -425,7 +428,7 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 	}
 
 	iotlb_lock_set(obj, &saved);
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 
 	return  p - crs;
 }
@@ -790,9 +793,9 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!obj->refcount)
 		return IRQ_NONE;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 	errs = iommu_report_fault(obj, &da);
-	clk_disable(obj->clk);
+	pm_runtime_put_sync(obj->dev);
 
 	/* Fault callback or TLB/PTE Dynamic loading */
 	if (obj->isr && !obj->isr(obj, da, errs, obj->isr_priv))
@@ -961,10 +964,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	if (!obj)
 		return -ENOMEM;
 
-	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(obj->clk))
-		goto err_clk;
-
 	obj->nr_tlb_entries = pdata->nr_tlb_entries;
 	obj->name = pdata->name;
 	obj->dev = &pdev->dev;
@@ -1026,8 +1025,6 @@ err_irq:
 	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
 err_mem:
-	clk_put(obj->clk);
-err_clk:
 	kfree(obj);
 	return err;
 }
@@ -1049,7 +1046,6 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
 
-	clk_put(obj->clk);
 	dev_info(&pdev->dev, "%s removed\n", obj->name);
 	kfree(obj);
 	return 0;
-- 
1.7.1

