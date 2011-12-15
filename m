From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Wed, 14 Dec 2011 22:18:29 -0600
Message-ID: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43206 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754814Ab1LOESz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 23:18:55 -0500
In-Reply-To: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Joerg Roedel <joerg.roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, MyungJoo Ham <myungjoo.ham@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, Linux PM <linux-pm@vger.kernel.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Use runtime PM functionality interfaced with hwmod enable/idle
functions, to replace direct clock operations, reset and sysconfig
handling.

Removed clk handling during interrupt, given that in order to receive one,
the device should be powered on in advance. Now doing pm_runtime_get/put
on iommu_enable/disable so it doesn't rely on others to keep the clocks on.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/iommu2.c             |   17 -----------
 arch/arm/mach-omap2/omap-iommu.c         |    1 -
 arch/arm/plat-omap/include/plat/iommu.h  |    2 -
 arch/arm/plat-omap/include/plat/iommu2.h |    2 -
 drivers/iommu/omap-iommu.c               |   44 ++++++++++++-----------------
 5 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 35cab47..3e47786 100644
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
@@ -96,11 +87,6 @@ static int omap2_iommu_enable(struct omap_iommu *obj)
 	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
 		 (l >> 4) & 0xf, l & 0xf);
 
-	l = iommu_read_reg(obj, MMU_SYSCONFIG);
-	l &= ~MMU_SYS_IDLE_MASK;
-	l |= (MMU_SYS_IDLE_SMART | MMU_SYS_AUTOIDLE);
-	iommu_write_reg(obj, l, MMU_SYSCONFIG);
-
 	iommu_write_reg(obj, pa, MMU_TTB);
 
 	__iommu_set_twl(obj, true);
@@ -114,7 +100,6 @@ static void omap2_iommu_disable(struct omap_iommu *obj)
 
 	l &= ~MMU_CNTL_MASK;
 	iommu_write_reg(obj, l, MMU_CNTL);
-	iommu_write_reg(obj, MMU_SYS_IDLE_FORCE, MMU_SYSCONFIG);
 
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
@@ -243,8 +228,6 @@ omap2_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len)
 	char *p = buf;
 
 	pr_reg(REVISION);
-	pr_reg(SYSCONFIG);
-	pr_reg(SYSSTATUS);
 	pr_reg(IRQSTATUS);
 	pr_reg(IRQENABLE);
 	pr_reg(WALKING_ST);
diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index 6da05e1..99ed583 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -27,7 +27,6 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 	static int i;
 
 	pdata.name = oh->name;
-	pdata.clk_name = oh->main_clk;
 	pdata.nr_tlb_entries = a->nr_tlb_entries;
 	pdata.da_start = a->da_start;
 	pdata.da_end = a->da_end;
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index c5b23b8..46d2b9a 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -28,7 +28,6 @@ struct iotlb_entry {
 struct omap_iommu {
 	const char	*name;
 	struct module	*owner;
-	struct clk	*clk;
 	void __iomem	*regbase;
 	struct device	*dev;
 	void		*isr_priv;
@@ -118,7 +117,6 @@ struct omap_mmu_dev_attr {
 
 struct iommu_platform_data {
 	const char *name;
-	const char *clk_name;
 	int nr_tlb_entries;
 	u32 da_start;
 	u32 da_end;
diff --git a/arch/arm/plat-omap/include/plat/iommu2.h b/arch/arm/plat-omap/include/plat/iommu2.h
index d4116b5..1579694 100644
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
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 78e62b1..e8ae36c 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -16,11 +16,11 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
-#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/iommu.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/pm_runtime.h>
 
 #include <asm/cacheflush.h>
 
@@ -123,11 +123,10 @@ static int iommu_enable(struct omap_iommu *obj)
 	if (!arch_iommu)
 		return -ENODEV;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	err = arch_iommu->enable(obj);
 
-	clk_disable(obj->clk);
 	return err;
 }
 
@@ -136,11 +135,9 @@ static void iommu_disable(struct omap_iommu *obj)
 	if (!obj)
 		return;
 
-	clk_enable(obj->clk);
-
 	arch_iommu->disable(obj);
 
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 }
 
 /*
@@ -263,7 +260,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 	if (!obj || !obj->nr_tlb_entries || !e)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	iotlb_lock_get(obj, &l);
 	if (l.base == obj->nr_tlb_entries) {
@@ -293,7 +290,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 
 	cr = iotlb_alloc_cr(obj, e);
 	if (IS_ERR(cr)) {
-		clk_disable(obj->clk);
+		pm_runtime_put(obj->dev);
 		return PTR_ERR(cr);
 	}
 
@@ -307,7 +304,7 @@ static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 		l.vict = l.base;
 	iotlb_lock_set(obj, &l);
 out:
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 	return err;
 }
 
@@ -337,7 +334,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 	int i;
 	struct cr_regs cr;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	for_each_iotlb_cr(obj, obj->nr_tlb_entries, i, cr) {
 		u32 start;
@@ -356,7 +353,7 @@ static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 			iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 		}
 	}
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 
 	if (i == obj->nr_tlb_entries)
 		dev_dbg(obj->dev, "%s: no page for %08x\n", __func__, da);
@@ -370,7 +367,7 @@ static void flush_iotlb_all(struct omap_iommu *obj)
 {
 	struct iotlb_lock l;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	l.base = 0;
 	l.vict = 0;
@@ -378,7 +375,7 @@ static void flush_iotlb_all(struct omap_iommu *obj)
 
 	iommu_write_reg(obj, 1, MMU_GFLUSH);
 
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 }
 
 #if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
@@ -388,11 +385,11 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 	if (!obj || !buf)
 		return -EINVAL;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 
 	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
 
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 
 	return bytes;
 }
@@ -406,7 +403,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
 	struct cr_regs tmp;
 	struct cr_regs *p = crs;
 
-	clk_enable(obj->clk);
+	pm_runtime_get_sync(obj->dev);
 	iotlb_lock_get(obj, &saved);
 
 	for_each_iotlb_cr(obj, num, i, tmp) {
@@ -416,7 +413,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
 	}
 
 	iotlb_lock_set(obj, &saved);
-	clk_disable(obj->clk);
+	pm_runtime_put(obj->dev);
 
 	return  p - crs;
 }
@@ -780,9 +777,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!obj->refcount)
 		return IRQ_NONE;
 
-	clk_enable(obj->clk);
 	errs = iommu_report_fault(obj, &da);
-	clk_disable(obj->clk);
 	if (errs == 0)
 		return IRQ_HANDLED;
 
@@ -920,10 +915,6 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 	if (!obj)
 		return -ENOMEM;
 
-	obj->clk = clk_get(&pdev->dev, pdata->clk_name);
-	if (IS_ERR(obj->clk))
-		goto err_clk;
-
 	obj->nr_tlb_entries = pdata->nr_tlb_entries;
 	obj->name = pdata->name;
 	obj->dev = &pdev->dev;
@@ -966,6 +957,8 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 		goto err_irq;
 	platform_set_drvdata(pdev, obj);
 
+	pm_runtime_enable(obj->dev);
+
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
 
@@ -974,8 +967,6 @@ err_irq:
 err_ioremap:
 	release_mem_region(res->start, resource_size(res));
 err_mem:
-	clk_put(obj->clk);
-err_clk:
 	kfree(obj);
 	return err;
 }
@@ -996,7 +987,8 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	iounmap(obj->regbase);
 
-	clk_put(obj->clk);
+	pm_runtime_disable(obj->dev);
+
 	dev_info(&pdev->dev, "%s removed\n", obj->name);
 	kfree(obj);
 	return 0;
-- 
1.7.4.1

