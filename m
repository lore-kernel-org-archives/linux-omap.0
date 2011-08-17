From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/7] omap: iommu: migrate to the generic IOMMU API
Date: Thu, 18 Aug 2011 02:10:02 +0300
Message-ID: <1313622608-30397-2-git-send-email-ohad@wizery.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63099 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754751Ab1HQXKi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Aug 2011 19:10:38 -0400
Received: by wwf5 with SMTP id 5so1482308wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 17 Aug 2011 16:10:37 -0700 (PDT)
In-Reply-To: <1313622608-30397-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Migrate OMAP's iommu driver to the generic IOMMU API, so users can stay
generic, and any generic IOMMU functionality can be developed once
in the generic framework.

Migrate omap's iovmm (virtual memory manager) to the generic IOMMU API,
and adapt omap3isp as needed, so the latter won't break.

The plan is to eventually remove iovmm completely by replacing it
with the (upcoming) IOMMU-based DMA-API.

Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/Kconfig              |    4 +-
 arch/arm/plat-omap/include/plat/iommu.h |    3 +-
 arch/arm/plat-omap/include/plat/iovmm.h |   27 ++--
 arch/arm/plat-omap/iommu.c              |  295 +++++++++++++++++++++++++++----
 arch/arm/plat-omap/iopgtable.h          |   18 ++
 arch/arm/plat-omap/iovmm.c              |  115 +++++++-----
 drivers/media/video/omap3isp/isp.c      |   41 ++++-
 drivers/media/video/omap3isp/isp.h      |    3 +
 drivers/media/video/omap3isp/ispccdc.c  |   16 +-
 drivers/media/video/omap3isp/ispstat.c  |    6 +-
 drivers/media/video/omap3isp/ispvideo.c |    4 +-
 11 files changed, 414 insertions(+), 118 deletions(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index bb8f4a6..e1e954d 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -132,8 +132,10 @@ config OMAP_MBOX_KFIFO_SIZE
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
 
+#can't be tristate; iommu api doesn't support un-registration
 config OMAP_IOMMU
-	tristate
+	bool
+	select IOMMU_API
 
 config OMAP_IOMMU_DEBUG
        tristate "Export OMAP IOMMU internals in DebugFS"
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 174f1b9..db1c492 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -167,8 +167,6 @@ extern void iopgtable_lookup_entry(struct iommu *obj, u32 da, u32 **ppgd,
 extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
 extern int iommu_set_da_range(struct iommu *obj, u32 start, u32 end);
-extern struct iommu *iommu_get(const char *name);
-extern void iommu_put(struct iommu *obj);
 extern int iommu_set_isr(const char *name,
 			 int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
 				    void *priv),
@@ -185,5 +183,6 @@ extern int foreach_iommu_device(void *data,
 
 extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len);
 extern size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t len);
+struct device *omap_find_iommu_device(const char *name);
 
 #endif /* __MACH_IOMMU_H */
diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/arch/arm/plat-omap/include/plat/iovmm.h
index e992b96..e2f0b38 100644
--- a/arch/arm/plat-omap/include/plat/iovmm.h
+++ b/arch/arm/plat-omap/include/plat/iovmm.h
@@ -13,6 +13,8 @@
 #ifndef __IOMMU_MMAP_H
 #define __IOMMU_MMAP_H
 
+#include <linux/iommu.h>
+
 struct iovm_struct {
 	struct iommu		*iommu;	/* iommu object which this belongs to */
 	u32			da_start; /* area definition */
@@ -71,18 +73,21 @@ struct iovm_struct {
 
 
 extern struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da);
-extern u32 iommu_vmap(struct iommu *obj, u32 da,
+extern u32 iommu_vmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
 			const struct sg_table *sgt, u32 flags);
-extern struct sg_table *iommu_vunmap(struct iommu *obj, u32 da);
-extern u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes,
-			   u32 flags);
-extern void iommu_vfree(struct iommu *obj, const u32 da);
-extern u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa, size_t bytes,
-			u32 flags);
-extern void iommu_kunmap(struct iommu *obj, u32 da);
-extern u32 iommu_kmalloc(struct iommu *obj, u32 da, size_t bytes,
-			   u32 flags);
-extern void iommu_kfree(struct iommu *obj, u32 da);
+extern struct sg_table *iommu_vunmap(struct iommu_domain *domain,
+				struct iommu *obj, u32 da);
+extern u32 iommu_vmalloc(struct iommu_domain *domain, struct iommu *obj,
+				u32 da, size_t bytes, u32 flags);
+extern void iommu_vfree(struct iommu_domain *domain, struct iommu *obj,
+				const u32 da);
+extern u32 iommu_kmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
+				u32 pa, size_t bytes, u32 flags);
+extern void iommu_kunmap(struct iommu_domain *domain, struct iommu *obj,
+				u32 da);
+extern u32 iommu_kmalloc(struct iommu_domain *domain, struct iommu *obj,
+				u32 da, size_t bytes, u32 flags);
+extern void iommu_kfree(struct iommu_domain *domain, struct iommu *obj, u32 da);
 
 extern void *da_to_va(struct iommu *obj, u32 da);
 
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 34fc31e..70a271c 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -18,6 +18,8 @@
 #include <linux/ioport.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
+#include <linux/iommu.h>
+#include <linux/mutex.h>
 
 #include <asm/cacheflush.h>
 
@@ -30,6 +32,19 @@
 	     (__i < (n)) && (cr = __iotlb_read_cr((obj), __i), true);	\
 	     __i++)
 
+/**
+ * struct omap_iommu_domain - omap iommu domain
+ * @pgtable:	the page table
+ * @iommu_dev:	an omap iommu device attached to this domain. only a single
+ *		iommu device can be attached for now.
+ * @lock:	domain lock, should be taken when attaching/detaching
+ */
+struct omap_iommu_domain {
+	u32 *pgtable;
+	struct iommu *iommu_dev;
+	struct mutex lock;
+};
+
 /* accommodate the difference between omap1 and omap2/3 */
 static const struct iommu_functions *arch_iommu;
 
@@ -852,31 +867,51 @@ int iommu_set_da_range(struct iommu *obj, u32 start, u32 end)
 EXPORT_SYMBOL_GPL(iommu_set_da_range);
 
 /**
- * iommu_get - Get iommu handler
- * @name:	target iommu name
+ * omap_find_iommu_device() - find an omap iommu device by name
+ * @name:	name of the iommu device
+ *
+ * The generic iommu API requires the caller to provide the device
+ * he wishes to attach to a certain iommu domain.
+ *
+ * Drivers generally should not bother with this as it should just
+ * be taken care of by the DMA-API using dev_archdata.
+ *
+ * This function is provided as an interim solution until the latter
+ * materializes, and omap3isp is fully migrated to the DMA-API.
+ */
+struct device *omap_find_iommu_device(const char *name)
+{
+	return driver_find_device(&omap_iommu_driver.driver, NULL,
+				(void *)name,
+				device_match_by_alias);
+}
+EXPORT_SYMBOL_GPL(omap_find_iommu_device);
+
+/**
+ * omap_iommu_attach() - attach iommu device to an iommu domain
+ * @dev:	target omap iommu device
+ * @iopgd:	page table
  **/
-struct iommu *iommu_get(const char *name)
+static struct iommu *omap_iommu_attach(struct device *dev, u32 *iopgd)
 {
 	int err = -ENOMEM;
-	struct device *dev;
-	struct iommu *obj;
-
-	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
-				 device_match_by_alias);
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	obj = to_iommu(dev);
+	struct iommu *obj = to_iommu(dev);
 
 	mutex_lock(&obj->iommu_lock);
 
-	if (obj->refcount++ == 0) {
-		err = iommu_enable(obj);
-		if (err)
-			goto err_enable;
-		flush_iotlb_all(obj);
+	/* an iommu device can only be attached once */
+	if (++obj->refcount > 1) {
+		dev_err(dev, "%s: already attached!\n", obj->name);
+		err = -EBUSY;
+		goto err_enable;
 	}
 
+	obj->iopgd = iopgd;
+	err = iommu_enable(obj);
+	if (err)
+		goto err_enable;
+	flush_iotlb_all(obj);
+
 	if (!try_module_get(obj->owner))
 		goto err_module;
 
@@ -893,13 +928,12 @@ err_enable:
 	mutex_unlock(&obj->iommu_lock);
 	return ERR_PTR(err);
 }
-EXPORT_SYMBOL_GPL(iommu_get);
 
 /**
- * iommu_put - Put back iommu handler
+ * omap_iommu_detach - release iommu device
  * @obj:	target iommu
  **/
-void iommu_put(struct iommu *obj)
+static void omap_iommu_detach(struct iommu *obj)
 {
 	if (!obj || IS_ERR(obj))
 		return;
@@ -911,11 +945,12 @@ void iommu_put(struct iommu *obj)
 
 	module_put(obj->owner);
 
+	obj->iopgd = NULL;
+
 	mutex_unlock(&obj->iommu_lock);
 
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
 }
-EXPORT_SYMBOL_GPL(iommu_put);
 
 int iommu_set_isr(const char *name,
 		  int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
@@ -950,7 +985,6 @@ EXPORT_SYMBOL_GPL(iommu_set_isr);
 static int __devinit omap_iommu_probe(struct platform_device *pdev)
 {
 	int err = -ENODEV;
-	void *p;
 	int irq;
 	struct iommu *obj;
 	struct resource *res;
@@ -1009,22 +1043,9 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 		goto err_irq;
 	platform_set_drvdata(pdev, obj);
 
-	p = (void *)__get_free_pages(GFP_KERNEL, get_order(IOPGD_TABLE_SIZE));
-	if (!p) {
-		err = -ENOMEM;
-		goto err_pgd;
-	}
-	memset(p, 0, IOPGD_TABLE_SIZE);
-	clean_dcache_area(p, IOPGD_TABLE_SIZE);
-	obj->iopgd = p;
-
-	BUG_ON(!IS_ALIGNED((unsigned long)obj->iopgd, IOPGD_TABLE_SIZE));
-
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
 
-err_pgd:
-	free_irq(irq, obj);
 err_irq:
 	iounmap(obj->regbase);
 err_ioremap:
@@ -1045,7 +1066,6 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	iopgtable_clear_entry_all(obj);
-	free_pages((unsigned long)obj->iopgd, get_order(IOPGD_TABLE_SIZE));
 
 	irq = platform_get_irq(pdev, 0);
 	free_irq(irq, obj);
@@ -1072,6 +1092,207 @@ static void iopte_cachep_ctor(void *iopte)
 	clean_dcache_area(iopte, IOPTE_TABLE_SIZE);
 }
 
+static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
+			 phys_addr_t pa, int order, int prot)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct device *dev = oiommu->dev;
+	size_t bytes = PAGE_SIZE << order;
+	struct iotlb_entry e;
+	int omap_pgsz;
+	u32 ret, flags;
+
+	/* we only support mapping a single iommu page for now */
+	omap_pgsz = bytes_to_iopgsz(bytes);
+	if (omap_pgsz < 0) {
+		dev_err(dev, "invalid size to map: %d\n", bytes);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "mapping da 0x%lx to pa 0x%x size 0x%x\n", da, pa, bytes);
+
+	flags = omap_pgsz | prot;
+
+	iotlb_init_entry(&e, da, pa, flags);
+
+	ret = iopgtable_store_entry(oiommu, &e);
+	if (ret) {
+		dev_err(dev, "iopgtable_store_entry failed: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
+			    int order)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct device *dev = oiommu->dev;
+	size_t bytes = PAGE_SIZE << order;
+	size_t ret;
+
+	dev_dbg(dev, "unmapping da 0x%lx size 0x%x\n", da, bytes);
+
+	ret = iopgtable_clear_entry(oiommu, da);
+	if (ret != bytes) {
+		dev_err(dev, "entry @ 0x%lx was %d; not %d\n", da, ret, bytes);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int
+omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+	struct iommu *oiommu;
+	int ret = 0;
+
+	mutex_lock(&omap_domain->lock);
+
+	/* only a single device is supported per domain for now */
+	if (omap_domain->iommu_dev) {
+		dev_err(dev, "iommu domain is already attached\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	/* get a handle to and enable the omap iommu */
+	oiommu = omap_iommu_attach(dev, omap_domain->pgtable);
+	if (IS_ERR(oiommu)) {
+		ret = PTR_ERR(oiommu);
+		dev_err(dev, "can't get omap iommu: %d\n", ret);
+		goto out;
+	}
+
+	omap_domain->iommu_dev = oiommu;
+
+out:
+	mutex_unlock(&omap_domain->lock);
+	return ret;
+}
+
+static void omap_iommu_detach_dev(struct iommu_domain *domain,
+				 struct device *dev)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+	struct iommu *oiommu = to_iommu(dev);
+
+	mutex_lock(&omap_domain->lock);
+
+	/* only a single device is supported per domain for now */
+	if (omap_domain->iommu_dev != oiommu) {
+		dev_err(dev, "invalid iommu device\n");
+		goto out;
+	}
+
+	iopgtable_clear_entry_all(oiommu);
+
+	omap_iommu_detach(oiommu);
+
+	omap_domain->iommu_dev = NULL;
+
+out:
+	mutex_unlock(&omap_domain->lock);
+}
+
+static int omap_iommu_domain_init(struct iommu_domain *domain)
+{
+	struct omap_iommu_domain *omap_domain;
+
+	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
+	if (!omap_domain) {
+		pr_err("kzalloc failed\n");
+		goto out;
+	}
+
+	omap_domain->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_KERNEL);
+	if (!omap_domain->pgtable) {
+		pr_err("kzalloc failed\n");
+		goto fail_nomem;
+	}
+
+	/*
+	 * should never fail, but please keep this around to ensure
+	 * we keep the hardware happy
+	 */
+	BUG_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE));
+
+	clean_dcache_area(omap_domain->pgtable, IOPGD_TABLE_SIZE);
+	mutex_init(&omap_domain->lock);
+
+	domain->priv = omap_domain;
+
+	return 0;
+
+fail_nomem:
+	kfree(omap_domain);
+out:
+	return -ENOMEM;
+}
+
+/* assume device was already detached */
+static void omap_iommu_domain_destroy(struct iommu_domain *domain)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+
+	domain->priv = NULL;
+
+	kfree(omap_domain->pgtable);
+	kfree(omap_domain);
+}
+
+static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
+					  unsigned long da)
+{
+	struct omap_iommu_domain *omap_domain = domain->priv;
+	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct device *dev = oiommu->dev;
+	u32 *pgd, *pte;
+	phys_addr_t ret = 0;
+
+	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
+
+	if (pte) {
+		if (iopte_is_small(*pte))
+			ret = omap_iommu_translate(*pte, da, IOPTE_MASK);
+		else if (iopte_is_large(*pte))
+			ret = omap_iommu_translate(*pte, da, IOLARGE_MASK);
+		else
+			dev_err(dev, "bogus pte 0x%x", *pte);
+	} else {
+		if (iopgd_is_section(*pgd))
+			ret = omap_iommu_translate(*pgd, da, IOSECTION_MASK);
+		else if (iopgd_is_super(*pgd))
+			ret = omap_iommu_translate(*pgd, da, IOSUPER_MASK);
+		else
+			dev_err(dev, "bogus pgd 0x%x", *pgd);
+	}
+
+	return ret;
+}
+
+static int omap_iommu_domain_has_cap(struct iommu_domain *domain,
+				    unsigned long cap)
+{
+	return 0;
+}
+
+static struct iommu_ops omap_iommu_ops = {
+	.domain_init	= omap_iommu_domain_init,
+	.domain_destroy	= omap_iommu_domain_destroy,
+	.attach_dev	= omap_iommu_attach_dev,
+	.detach_dev	= omap_iommu_detach_dev,
+	.map		= omap_iommu_map,
+	.unmap		= omap_iommu_unmap,
+	.iova_to_phys	= omap_iommu_iova_to_phys,
+	.domain_has_cap	= omap_iommu_domain_has_cap,
+};
+
 static int __init omap_iommu_init(void)
 {
 	struct kmem_cache *p;
@@ -1084,6 +1305,8 @@ static int __init omap_iommu_init(void)
 		return -ENOMEM;
 	iopte_cachep = p;
 
+	register_iommu(&omap_iommu_ops);
+
 	return platform_driver_register(&omap_iommu_driver);
 }
 module_init(omap_iommu_init);
diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/iopgtable.h
index c3e93bb..33c7aa9 100644
--- a/arch/arm/plat-omap/iopgtable.h
+++ b/arch/arm/plat-omap/iopgtable.h
@@ -56,6 +56,19 @@
 
 #define IOPAGE_MASK		IOPTE_MASK
 
+/**
+ * omap_iommu_translate() - va to pa translation
+ * @d:		omap iommu descriptor
+ * @va:		virtual address
+ * @mask:	omap iommu descriptor mask
+ *
+ * va to pa translation
+ */
+static inline phys_addr_t omap_iommu_translate(u32 d, u32 va, u32 mask)
+{
+	return (d & mask) | (va & (~mask));
+}
+
 /*
  * some descriptor attributes.
  */
@@ -64,10 +77,15 @@
 #define IOPGD_SUPER		(1 << 18 | 2 << 0)
 
 #define iopgd_is_table(x)	(((x) & 3) == IOPGD_TABLE)
+#define iopgd_is_section(x)	(((x) & (1 << 18 | 3)) == IOPGD_SECTION)
+#define iopgd_is_super(x)	(((x) & (1 << 18 | 3)) == IOPGD_SUPER)
 
 #define IOPTE_SMALL		(2 << 0)
 #define IOPTE_LARGE		(1 << 0)
 
+#define iopte_is_small(x)	(((x) & 2) == IOPTE_SMALL)
+#define iopte_is_large(x)	(((x) & 3) == IOPTE_LARGE)
+
 /* to find an entry in a page-table-directory */
 #define iopgd_index(da)		(((da) >> IOPGD_SHIFT) & (PTRS_PER_IOPGD - 1))
 #define iopgd_offset(obj, da)	((obj)->iopgd + iopgd_index(da))
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 79e7fed..aa2c478 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/device.h>
 #include <linux/scatterlist.h>
+#include <linux/iommu.h>
 
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
@@ -453,39 +454,38 @@ static inline void sgtable_drain_kmalloc(struct sg_table *sgt)
 }
 
 /* create 'da' <-> 'pa' mapping from 'sgt' */
-static int map_iovm_area(struct iommu *obj, struct iovm_struct *new,
-			 const struct sg_table *sgt, u32 flags)
+static int map_iovm_area(struct iommu_domain *domain, struct iovm_struct *new,
+			const struct sg_table *sgt, u32 flags)
 {
 	int err;
 	unsigned int i, j;
 	struct scatterlist *sg;
 	u32 da = new->da_start;
+	int order;
 
-	if (!obj || !sgt)
+	if (!domain || !sgt)
 		return -EINVAL;
 
 	BUG_ON(!sgtable_ok(sgt));
 
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		u32 pa;
-		int pgsz;
 		size_t bytes;
-		struct iotlb_entry e;
 
 		pa = sg_phys(sg);
 		bytes = sg->length;
 
 		flags &= ~IOVMF_PGSZ_MASK;
-		pgsz = bytes_to_iopgsz(bytes);
-		if (pgsz < 0)
+
+		if (bytes_to_iopgsz(bytes) < 0)
 			goto err_out;
-		flags |= pgsz;
+
+		order = get_order(bytes);
 
 		pr_debug("%s: [%d] %08x %08x(%x)\n", __func__,
 			 i, da, pa, bytes);
 
-		iotlb_init_entry(&e, da, pa, flags);
-		err = iopgtable_store_entry(obj, &e);
+		err = iommu_map(domain, da, pa, order, flags);
 		if (err)
 			goto err_out;
 
@@ -499,9 +499,11 @@ err_out:
 	for_each_sg(sgt->sgl, sg, i, j) {
 		size_t bytes;
 
-		bytes = iopgtable_clear_entry(obj, da);
+		bytes = sg->length;
+		order = get_order(bytes);
 
-		BUG_ON(!iopgsz_ok(bytes));
+		/* ignore failures.. we're already handling one */
+		iommu_unmap(domain, da, order);
 
 		da += bytes;
 	}
@@ -509,22 +511,31 @@ err_out:
 }
 
 /* release 'da' <-> 'pa' mapping */
-static void unmap_iovm_area(struct iommu *obj, struct iovm_struct *area)
+static void unmap_iovm_area(struct iommu_domain *domain, struct iommu *obj,
+						struct iovm_struct *area)
 {
 	u32 start;
 	size_t total = area->da_end - area->da_start;
+	const struct sg_table *sgt = area->sgt;
+	struct scatterlist *sg;
+	int i, err;
 
+	BUG_ON(!sgtable_ok(sgt));
 	BUG_ON((!total) || !IS_ALIGNED(total, PAGE_SIZE));
 
 	start = area->da_start;
-	while (total > 0) {
+	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes;
+		int order;
+
+		bytes = sg->length;
+		order = get_order(bytes);
+
+		err = iommu_unmap(domain, start, order);
+		if (err)
+			break;
 
-		bytes = iopgtable_clear_entry(obj, start);
-		if (bytes == 0)
-			bytes = PAGE_SIZE;
-		else
-			dev_dbg(obj->dev, "%s: unmap %08x(%x) %08x\n",
+		dev_dbg(obj->dev, "%s: unmap %08x(%x) %08x\n",
 				__func__, start, bytes, area->flags);
 
 		BUG_ON(!IS_ALIGNED(bytes, PAGE_SIZE));
@@ -536,7 +547,8 @@ static void unmap_iovm_area(struct iommu *obj, struct iovm_struct *area)
 }
 
 /* template function for all unmapping */
-static struct sg_table *unmap_vm_area(struct iommu *obj, const u32 da,
+static struct sg_table *unmap_vm_area(struct iommu_domain *domain,
+				      struct iommu *obj, const u32 da,
 				      void (*fn)(const void *), u32 flags)
 {
 	struct sg_table *sgt = NULL;
@@ -562,7 +574,7 @@ static struct sg_table *unmap_vm_area(struct iommu *obj, const u32 da,
 	}
 	sgt = (struct sg_table *)area->sgt;
 
-	unmap_iovm_area(obj, area);
+	unmap_iovm_area(domain, obj, area);
 
 	fn(area->va);
 
@@ -577,8 +589,9 @@ out:
 	return sgt;
 }
 
-static u32 map_iommu_region(struct iommu *obj, u32 da,
-	      const struct sg_table *sgt, void *va, size_t bytes, u32 flags)
+static u32 map_iommu_region(struct iommu_domain *domain, struct iommu *obj,
+				u32 da, const struct sg_table *sgt, void *va,
+				size_t bytes, u32 flags)
 {
 	int err = -ENOMEM;
 	struct iovm_struct *new;
@@ -593,7 +606,7 @@ static u32 map_iommu_region(struct iommu *obj, u32 da,
 	new->va = va;
 	new->sgt = sgt;
 
-	if (map_iovm_area(obj, new, sgt, new->flags))
+	if (map_iovm_area(domain, new, sgt, new->flags))
 		goto err_map;
 
 	mutex_unlock(&obj->mmap_lock);
@@ -610,10 +623,11 @@ err_alloc_iovma:
 	return err;
 }
 
-static inline u32 __iommu_vmap(struct iommu *obj, u32 da,
-		 const struct sg_table *sgt, void *va, size_t bytes, u32 flags)
+static inline u32 __iommu_vmap(struct iommu_domain *domain, struct iommu *obj,
+				u32 da, const struct sg_table *sgt,
+				void *va, size_t bytes, u32 flags)
 {
-	return map_iommu_region(obj, da, sgt, va, bytes, flags);
+	return map_iommu_region(domain, obj, da, sgt, va, bytes, flags);
 }
 
 /**
@@ -625,8 +639,8 @@ static inline u32 __iommu_vmap(struct iommu *obj, u32 da,
  * Creates 1-n-1 mapping with given @sgt and returns @da.
  * All @sgt element must be io page size aligned.
  */
-u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
-		 u32 flags)
+u32 iommu_vmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
+		const struct sg_table *sgt, u32 flags)
 {
 	size_t bytes;
 	void *va = NULL;
@@ -648,7 +662,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 	flags |= IOVMF_DISCONT;
 	flags |= IOVMF_MMIO;
 
-	da = __iommu_vmap(obj, da, sgt, va, bytes, flags);
+	da = __iommu_vmap(domain, obj, da, sgt, va, bytes, flags);
 	if (IS_ERR_VALUE(da))
 		vunmap_sg(va);
 
@@ -664,14 +678,16 @@ EXPORT_SYMBOL_GPL(iommu_vmap);
  * Free the iommu virtually contiguous memory area starting at
  * @da, which was returned by 'iommu_vmap()'.
  */
-struct sg_table *iommu_vunmap(struct iommu *obj, u32 da)
+struct sg_table *
+iommu_vunmap(struct iommu_domain *domain, struct iommu *obj, u32 da)
 {
 	struct sg_table *sgt;
 	/*
 	 * 'sgt' is allocated before 'iommu_vmalloc()' is called.
 	 * Just returns 'sgt' to the caller to free
 	 */
-	sgt = unmap_vm_area(obj, da, vunmap_sg, IOVMF_DISCONT | IOVMF_MMIO);
+	sgt = unmap_vm_area(domain, obj, da, vunmap_sg,
+					IOVMF_DISCONT | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
 	return sgt;
@@ -688,7 +704,8 @@ EXPORT_SYMBOL_GPL(iommu_vunmap);
  * Allocate @bytes linearly and creates 1-n-1 mapping and returns
  * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set.
  */
-u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
+u32 iommu_vmalloc(struct iommu_domain *domain, struct iommu *obj, u32 da,
+						size_t bytes, u32 flags)
 {
 	void *va;
 	struct sg_table *sgt;
@@ -712,7 +729,7 @@ u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
 	}
 	sgtable_fill_vmalloc(sgt, va);
 
-	da = __iommu_vmap(obj, da, sgt, va, bytes, flags);
+	da = __iommu_vmap(domain, obj, da, sgt, va, bytes, flags);
 	if (IS_ERR_VALUE(da))
 		goto err_iommu_vmap;
 
@@ -735,19 +752,20 @@ EXPORT_SYMBOL_GPL(iommu_vmalloc);
  * Frees the iommu virtually continuous memory area starting at
  * @da, as obtained from 'iommu_vmalloc()'.
  */
-void iommu_vfree(struct iommu *obj, const u32 da)
+void iommu_vfree(struct iommu_domain *domain, struct iommu *obj, const u32 da)
 {
 	struct sg_table *sgt;
 
-	sgt = unmap_vm_area(obj, da, vfree, IOVMF_DISCONT | IOVMF_ALLOC);
+	sgt = unmap_vm_area(domain, obj, da, vfree,
+						IOVMF_DISCONT | IOVMF_ALLOC);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
 	sgtable_free(sgt);
 }
 EXPORT_SYMBOL_GPL(iommu_vfree);
 
-static u32 __iommu_kmap(struct iommu *obj, u32 da, u32 pa, void *va,
-			  size_t bytes, u32 flags)
+static u32 __iommu_kmap(struct iommu_domain *domain, struct iommu *obj,
+			u32 da, u32 pa, void *va, size_t bytes, u32 flags)
 {
 	struct sg_table *sgt;
 
@@ -757,7 +775,7 @@ static u32 __iommu_kmap(struct iommu *obj, u32 da, u32 pa, void *va,
 
 	sgtable_fill_kmalloc(sgt, pa, da, bytes);
 
-	da = map_iommu_region(obj, da, sgt, va, bytes, flags);
+	da = map_iommu_region(domain, obj, da, sgt, va, bytes, flags);
 	if (IS_ERR_VALUE(da)) {
 		sgtable_drain_kmalloc(sgt);
 		sgtable_free(sgt);
@@ -776,8 +794,8 @@ static u32 __iommu_kmap(struct iommu *obj, u32 da, u32 pa, void *va,
  * Creates 1-1-1 mapping and returns @da again, which can be
  * adjusted if 'IOVMF_DA_FIXED' is not set.
  */
-u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa, size_t bytes,
-		 u32 flags)
+u32 iommu_kmap(struct iommu_domain *domain, struct iommu *obj, u32 da, u32 pa,
+						size_t bytes, u32 flags)
 {
 	void *va;
 
@@ -793,7 +811,7 @@ u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa, size_t bytes,
 	flags |= IOVMF_LINEAR;
 	flags |= IOVMF_MMIO;
 
-	da = __iommu_kmap(obj, da, pa, va, bytes, flags);
+	da = __iommu_kmap(domain, obj, da, pa, va, bytes, flags);
 	if (IS_ERR_VALUE(da))
 		iounmap(va);
 
@@ -809,12 +827,12 @@ EXPORT_SYMBOL_GPL(iommu_kmap);
  * Frees the iommu virtually contiguous memory area starting at
  * @da, which was passed to and was returned by'iommu_kmap()'.
  */
-void iommu_kunmap(struct iommu *obj, u32 da)
+void iommu_kunmap(struct iommu_domain *domain, struct iommu *obj, u32 da)
 {
 	struct sg_table *sgt;
 	typedef void (*func_t)(const void *);
 
-	sgt = unmap_vm_area(obj, da, (func_t)iounmap,
+	sgt = unmap_vm_area(domain, obj, da, (func_t)iounmap,
 			    IOVMF_LINEAR | IOVMF_MMIO);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
@@ -832,7 +850,8 @@ EXPORT_SYMBOL_GPL(iommu_kunmap);
  * Allocate @bytes linearly and creates 1-1-1 mapping and returns
  * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set.
  */
-u32 iommu_kmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
+u32 iommu_kmalloc(struct iommu_domain *domain, struct iommu *obj, u32 da,
+						size_t bytes, u32 flags)
 {
 	void *va;
 	u32 pa;
@@ -850,7 +869,7 @@ u32 iommu_kmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
 	flags |= IOVMF_LINEAR;
 	flags |= IOVMF_ALLOC;
 
-	da = __iommu_kmap(obj, da, pa, va, bytes, flags);
+	da = __iommu_kmap(domain, obj, da, pa, va, bytes, flags);
 	if (IS_ERR_VALUE(da))
 		kfree(va);
 
@@ -866,11 +885,11 @@ EXPORT_SYMBOL_GPL(iommu_kmalloc);
  * Frees the iommu virtually contiguous memory area starting at
  * @da, which was passed to and was returned by'iommu_kmalloc()'.
  */
-void iommu_kfree(struct iommu *obj, u32 da)
+void iommu_kfree(struct iommu_domain *domain, struct iommu *obj, u32 da)
 {
 	struct sg_table *sgt;
 
-	sgt = unmap_vm_area(obj, da, kfree, IOVMF_LINEAR | IOVMF_ALLOC);
+	sgt = unmap_vm_area(domain, obj, da, kfree, IOVMF_LINEAR | IOVMF_ALLOC);
 	if (!sgt)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
 	sgtable_free(sgt);
diff --git a/drivers/media/video/omap3isp/isp.c b/drivers/media/video/omap3isp/isp.c
index 5cea2bb..0db45ac 100644
--- a/drivers/media/video/omap3isp/isp.c
+++ b/drivers/media/video/omap3isp/isp.c
@@ -80,6 +80,13 @@
 #include "isph3a.h"
 #include "isphist.h"
 
+/*
+ * this is provided as an interim solution until omap3isp doesn't need
+ * any omap-specific iommu API
+ */
+#define to_iommu(dev)							\
+	(struct iommu *)platform_get_drvdata(to_platform_device(dev))
+
 static unsigned int autoidle;
 module_param(autoidle, int, 0444);
 MODULE_PARM_DESC(autoidle, "Enable OMAP3ISP AUTOIDLE support");
@@ -1975,7 +1982,8 @@ static int isp_remove(struct platform_device *pdev)
 	isp_cleanup_modules(isp);
 
 	omap3isp_get(isp);
-	iommu_put(isp->iommu);
+	iommu_detach_device(isp->domain, isp->iommu_dev);
+	iommu_domain_free(isp->domain);
 	omap3isp_put(isp);
 
 	free_irq(isp->irq_num, isp);
@@ -2123,25 +2131,41 @@ static int isp_probe(struct platform_device *pdev)
 	}
 
 	/* IOMMU */
-	isp->iommu = iommu_get("isp");
-	if (IS_ERR_OR_NULL(isp->iommu)) {
-		isp->iommu = NULL;
+	isp->iommu_dev = omap_find_iommu_device("isp");
+	if (!isp->iommu_dev) {
+		dev_err(isp->dev, "omap_find_iommu_device failed\n");
 		ret = -ENODEV;
 		goto error_isp;
 	}
 
+	/* to be removed once iommu migration is complete */
+	isp->iommu = to_iommu(isp->iommu_dev);
+
+	isp->domain = iommu_domain_alloc();
+	if (!isp->domain) {
+		dev_err(isp->dev, "can't alloc iommu domain\n");
+		ret = -ENOMEM;
+		goto error_isp;
+	}
+
+	ret = iommu_attach_device(isp->domain, isp->iommu_dev);
+	if (ret) {
+		dev_err(&pdev->dev, "can't attach iommu device: %d\n", ret);
+		goto free_domain;
+	}
+
 	/* Interrupt */
 	isp->irq_num = platform_get_irq(pdev, 0);
 	if (isp->irq_num <= 0) {
 		dev_err(isp->dev, "No IRQ resource\n");
 		ret = -ENODEV;
-		goto error_isp;
+		goto detach_dev;
 	}
 
 	if (request_irq(isp->irq_num, isp_isr, IRQF_SHARED, "OMAP3 ISP", isp)) {
 		dev_err(isp->dev, "Unable to request IRQ\n");
 		ret = -EINVAL;
-		goto error_isp;
+		goto detach_dev;
 	}
 
 	/* Entities */
@@ -2162,8 +2186,11 @@ error_modules:
 	isp_cleanup_modules(isp);
 error_irq:
 	free_irq(isp->irq_num, isp);
+detach_dev:
+	iommu_detach_device(isp->domain, isp->iommu_dev);
+free_domain:
+	iommu_domain_free(isp->domain);
 error_isp:
-	iommu_put(isp->iommu);
 	omap3isp_put(isp);
 error:
 	isp_put_clocks(isp);
diff --git a/drivers/media/video/omap3isp/isp.h b/drivers/media/video/omap3isp/isp.h
index 529e582..c9ec7a2 100644
--- a/drivers/media/video/omap3isp/isp.h
+++ b/drivers/media/video/omap3isp/isp.h
@@ -32,6 +32,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/wait.h>
+#include <linux/iommu.h>
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
 
@@ -295,6 +296,8 @@ struct isp_device {
 	unsigned int subclk_resources;
 
 	struct iommu *iommu;
+	struct iommu_domain *domain;
+	struct device *iommu_dev;
 
 	struct isp_platform_callback platform_cb;
 };
diff --git a/drivers/media/video/omap3isp/ispccdc.c b/drivers/media/video/omap3isp/ispccdc.c
index 9d3459d..de25474 100644
--- a/drivers/media/video/omap3isp/ispccdc.c
+++ b/drivers/media/video/omap3isp/ispccdc.c
@@ -365,7 +365,7 @@ static void ccdc_lsc_free_request(struct isp_ccdc_device *ccdc,
 		dma_unmap_sg(isp->dev, req->iovm->sgt->sgl,
 			     req->iovm->sgt->nents, DMA_TO_DEVICE);
 	if (req->table)
-		iommu_vfree(isp->iommu, req->table);
+		iommu_vfree(isp->domain, isp->iommu, req->table);
 	kfree(req);
 }
 
@@ -437,8 +437,8 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 
 		req->enable = 1;
 
-		req->table = iommu_vmalloc(isp->iommu, 0, req->config.size,
-					   IOMMU_FLAG);
+		req->table = iommu_vmalloc(isp->domain, isp->iommu, 0,
+					req->config.size, IOMMU_FLAG);
 		if (IS_ERR_VALUE(req->table)) {
 			req->table = 0;
 			ret = -ENOMEM;
@@ -733,15 +733,15 @@ static int ccdc_config(struct isp_ccdc_device *ccdc,
 			 * already done by iommu_vmalloc().
 			 */
 			size = ccdc->fpc.fpnum * 4;
-			table_new = iommu_vmalloc(isp->iommu, 0, size,
-						  IOMMU_FLAG);
+			table_new = iommu_vmalloc(isp->domain, isp->iommu, 0,
+							size, IOMMU_FLAG);
 			if (IS_ERR_VALUE(table_new))
 				return -ENOMEM;
 
 			if (copy_from_user(da_to_va(isp->iommu, table_new),
 					   (__force void __user *)
 					   ccdc->fpc.fpcaddr, size)) {
-				iommu_vfree(isp->iommu, table_new);
+				iommu_vfree(isp->domain, isp->iommu, table_new);
 				return -EFAULT;
 			}
 
@@ -751,7 +751,7 @@ static int ccdc_config(struct isp_ccdc_device *ccdc,
 
 		ccdc_configure_fpc(ccdc);
 		if (table_old != 0)
-			iommu_vfree(isp->iommu, table_old);
+			iommu_vfree(isp->domain, isp->iommu, table_old);
 	}
 
 	return ccdc_lsc_config(ccdc, ccdc_struct);
@@ -2286,5 +2286,5 @@ void omap3isp_ccdc_cleanup(struct isp_device *isp)
 	ccdc_lsc_free_queue(ccdc, &ccdc->lsc.free_queue);
 
 	if (ccdc->fpc.fpcaddr != 0)
-		iommu_vfree(isp->iommu, ccdc->fpc.fpcaddr);
+		iommu_vfree(isp->domain, isp->iommu, ccdc->fpc.fpcaddr);
 }
diff --git a/drivers/media/video/omap3isp/ispstat.c b/drivers/media/video/omap3isp/ispstat.c
index 8080659..98af736 100644
--- a/drivers/media/video/omap3isp/ispstat.c
+++ b/drivers/media/video/omap3isp/ispstat.c
@@ -366,7 +366,7 @@ static void isp_stat_bufs_free(struct ispstat *stat)
 				dma_unmap_sg(isp->dev, buf->iovm->sgt->sgl,
 					     buf->iovm->sgt->nents,
 					     DMA_FROM_DEVICE);
-			iommu_vfree(isp->iommu, buf->iommu_addr);
+			iommu_vfree(isp->domain, isp->iommu, buf->iommu_addr);
 		} else {
 			if (!buf->virt_addr)
 				continue;
@@ -399,8 +399,8 @@ static int isp_stat_bufs_alloc_iommu(struct ispstat *stat, unsigned int size)
 		struct iovm_struct *iovm;
 
 		WARN_ON(buf->dma_addr);
-		buf->iommu_addr = iommu_vmalloc(isp->iommu, 0, size,
-						IOMMU_FLAG);
+		buf->iommu_addr = iommu_vmalloc(isp->domain, isp->iommu, 0,
+							size, IOMMU_FLAG);
 		if (IS_ERR((void *)buf->iommu_addr)) {
 			dev_err(stat->isp->dev,
 				 "%s: Can't acquire memory for "
diff --git a/drivers/media/video/omap3isp/ispvideo.c b/drivers/media/video/omap3isp/ispvideo.c
index fd965ad..023b502 100644
--- a/drivers/media/video/omap3isp/ispvideo.c
+++ b/drivers/media/video/omap3isp/ispvideo.c
@@ -446,7 +446,7 @@ ispmmu_vmap(struct isp_device *isp, const struct scatterlist *sglist, int sglen)
 	sgt->nents = sglen;
 	sgt->orig_nents = sglen;
 
-	da = iommu_vmap(isp->iommu, 0, sgt, IOMMU_FLAG);
+	da = iommu_vmap(isp->domain, isp->iommu, 0, sgt, IOMMU_FLAG);
 	if (IS_ERR_VALUE(da))
 		kfree(sgt);
 
@@ -462,7 +462,7 @@ static void ispmmu_vunmap(struct isp_device *isp, dma_addr_t da)
 {
 	struct sg_table *sgt;
 
-	sgt = iommu_vunmap(isp->iommu, (u32)da);
+	sgt = iommu_vunmap(isp->domain, isp->iommu, (u32)da);
 	kfree(sgt);
 }
 
-- 
1.7.4.1

