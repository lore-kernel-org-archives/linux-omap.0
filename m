From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] iommu/omap: Add support to program multiple iommus
Date: Thu, 31 Aug 2017 08:14:02 -0500
Message-ID: <20170831131402.29502-3-s-anna@ti.com>
References: <20170831131402.29502-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170831131402.29502-1-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

A client user instantiates and attaches to an iommu_domain to
program the OMAP IOMMU associated with the domain. The iommus
programmed by a client user are bound with the iommu_domain
through the user's device archdata. The OMAP IOMMU driver
currently supports only one IOMMU per IOMMU domain per user.

The OMAP IOMMU driver has been enhanced to support allowing
multiple IOMMUs to be programmed by a single client user. This
support is being added mainly to handle the DSP subsystems on
the DRA7xx SoCs, which have two MMUs within the same subsystem.
These MMUs provide translations to a processor core port and
an internal EDMA port. This support allows both the MMUs to
be programmed together, but with each one retaining it's own
internal state objects. The internal EDMA is managed by the
software running on the DSPs, and this design provides on-par
functionality with previous generation OMAP DSPs where the
EDMA and the DSP core shared the same MMU.

The multiple iommus are expected to be provided through a
sentinel terminated array of omap_iommu_arch_data objects
through the client user's device archdata. The OMAP driver
core is enhanced to loop through the array of attached
iommus and program them for all common operations. The
sentinel-terminated logic is used so as to not change the
omap_iommu_arch_data structure.

NOTE:
1. The IOMMU groups are still defined for both the DSP MMUs,
   but the IOMMU device linking uses only the first MMU device.
2. The OMAP IOMMU debugfs code still continues to operate on
   individual IOMMU objects.

Signed-off-by: Suman Anna <s-anna@ti.com>
[t-kristo@ti.com: ported support to 4.13 based kernel]
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/iommu/omap-iommu.c | 307 ++++++++++++++++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h |  30 +++--
 2 files changed, 248 insertions(+), 89 deletions(-)

diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 81ef729994ce..9dd810f13c28 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -2,6 +2,7 @@
  * omap iommu: tlb and pagetable primitives
  *
  * Copyright (C) 2008-2010 Nokia Corporation
+ * Copyright (C) 2013-2017 Texas Instruments Incorporated - http://www.ti.com/
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
  *		Paul Mundt and Toshihiro Kobayashi
@@ -71,13 +72,23 @@ static struct omap_iommu_domain *to_omap_domain(struct iommu_domain *dom)
  **/
 void omap_iommu_save_ctx(struct device *dev)
 {
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	u32 *p = obj->ctx;
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct omap_iommu *obj;
+	u32 *p;
 	int i;
 
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		p[i] = iommu_read_reg(obj, i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
+	if (!arch_data)
+		return;
+
+	while (arch_data->iommu_dev) {
+		obj = arch_data->iommu_dev;
+		p = obj->ctx;
+		for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
+			p[i] = iommu_read_reg(obj, i * sizeof(u32));
+			dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i,
+				p[i]);
+		}
+		arch_data++;
 	}
 }
 EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
@@ -88,13 +99,23 @@ EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
  **/
 void omap_iommu_restore_ctx(struct device *dev)
 {
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	u32 *p = obj->ctx;
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct omap_iommu *obj;
+	u32 *p;
 	int i;
 
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		iommu_write_reg(obj, p[i], i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
+	if (!arch_data)
+		return;
+
+	while (arch_data->iommu_dev) {
+		obj = arch_data->iommu_dev;
+		p = obj->ctx;
+		for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
+			iommu_write_reg(obj, p[i], i * sizeof(u32));
+			dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i,
+				p[i]);
+		}
+		arch_data++;
 	}
 }
 EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
@@ -1068,11 +1089,13 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 			  phys_addr_t pa, size_t bytes, int prot)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
-	struct omap_iommu *oiommu = omap_domain->iommu_dev;
-	struct device *dev = oiommu->dev;
+	struct device *dev = omap_domain->dev;
+	struct omap_iommu_device *iommu;
+	struct omap_iommu *oiommu;
 	struct iotlb_entry e;
 	int omap_pgsz;
-	u32 ret;
+	u32 ret = -EINVAL;
+	int i;
 
 	omap_pgsz = bytes_to_iopgsz(bytes);
 	if (omap_pgsz < 0) {
@@ -1084,9 +1107,24 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	iotlb_init_entry(&e, da, pa, omap_pgsz);
 
-	ret = omap_iopgtable_store_entry(oiommu, &e);
-	if (ret)
-		dev_err(dev, "omap_iopgtable_store_entry failed: %d\n", ret);
+	iommu = omap_domain->iommus;
+	for (i = 0; i < omap_domain->num_iommus; i++, iommu++) {
+		oiommu = iommu->iommu_dev;
+		ret = omap_iopgtable_store_entry(oiommu, &e);
+		if (ret) {
+			dev_err(dev, "omap_iopgtable_store_entry failed: %d\n",
+				ret);
+			break;
+		}
+	}
+
+	if (ret) {
+		while (i--) {
+			iommu--;
+			oiommu = iommu->iommu_dev;
+			iopgtable_clear_entry(oiommu, da);
+		}
+	}
 
 	return ret;
 }
@@ -1095,12 +1133,90 @@ static size_t omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
 			       size_t size)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
-	struct omap_iommu *oiommu = omap_domain->iommu_dev;
-	struct device *dev = oiommu->dev;
+	struct device *dev = omap_domain->dev;
+	struct omap_iommu_device *iommu;
+	struct omap_iommu *oiommu;
+	bool error = false;
+	size_t bytes = 0;
+	int i;
 
 	dev_dbg(dev, "unmapping da 0x%lx size %u\n", da, size);
 
-	return iopgtable_clear_entry(oiommu, da);
+	iommu = omap_domain->iommus;
+	for (i = 0; i < omap_domain->num_iommus; i++, iommu++) {
+		oiommu = iommu->iommu_dev;
+		bytes = iopgtable_clear_entry(oiommu, da);
+		if (!bytes)
+			error = true;
+	}
+
+	/*
+	 * simplify return - we are only checking if any of the iommus
+	 * reported an error, but not if all of them are unmapping the
+	 * same number of entries. This should not occur due to the
+	 * mirror programming.
+	 */
+	return error ? 0 : bytes;
+}
+
+static int omap_iommu_count(struct device *dev)
+{
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	int count = 0;
+
+	while (arch_data->iommu_dev) {
+		count++;
+		arch_data++;
+	}
+
+	return count;
+}
+
+/* caller should call cleanup if this function fails */
+static int omap_iommu_attach_init(struct device *dev,
+				  struct omap_iommu_domain *odomain)
+{
+	struct omap_iommu_device *iommu;
+	int i;
+
+	odomain->num_iommus = omap_iommu_count(dev);
+	if (!odomain->num_iommus)
+		return -EINVAL;
+
+	odomain->iommus = kcalloc(odomain->num_iommus, sizeof(*iommu),
+				  GFP_ATOMIC);
+	if (!odomain->iommus)
+		return -ENOMEM;
+
+	iommu = odomain->iommus;
+	for (i = 0; i < odomain->num_iommus; i++, iommu++) {
+		iommu->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_ATOMIC);
+		if (!iommu->pgtable)
+			return -ENOMEM;
+
+		/*
+		 * should never fail, but please keep this around to ensure
+		 * we keep the hardware happy
+		 */
+		if (WARN_ON(!IS_ALIGNED((long)iommu->pgtable,
+					IOPGD_TABLE_SIZE)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void omap_iommu_detach_fini(struct omap_iommu_domain *odomain)
+{
+	int i;
+	struct omap_iommu_device *iommu = odomain->iommus;
+
+	for (i = 0; iommu && i < odomain->num_iommus; i++, iommu++)
+		kfree(iommu->pgtable);
+
+	kfree(odomain->iommus);
+	odomain->num_iommus = 0;
+	odomain->iommus = NULL;
 }
 
 static int
@@ -1108,8 +1224,10 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
 	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct omap_iommu_device *iommu;
 	struct omap_iommu *oiommu;
 	int ret = 0;
+	int i;
 
 	if (!arch_data || !arch_data->iommu_dev) {
 		dev_err(dev, "device doesn't have an associated iommu\n");
@@ -1125,19 +1243,42 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		goto out;
 	}
 
-	oiommu = arch_data->iommu_dev;
-
-	/* get a handle to and enable the omap iommu */
-	ret = omap_iommu_attach(oiommu, omap_domain->pgtable);
+	ret = omap_iommu_attach_init(dev, omap_domain);
 	if (ret) {
-		dev_err(dev, "can't get omap iommu: %d\n", ret);
-		goto out;
+		dev_err(dev, "failed to allocate required iommu data %d\n",
+			ret);
+		goto init_fail;
+	}
+
+	iommu = omap_domain->iommus;
+	for (i = 0; i < omap_domain->num_iommus; i++, iommu++, arch_data++) {
+		/* configure and enable the omap iommu */
+		oiommu = arch_data->iommu_dev;
+		ret = omap_iommu_attach(oiommu, iommu->pgtable);
+		if (ret) {
+			dev_err(dev, "can't get omap iommu: %d\n", ret);
+			goto attach_fail;
+		}
+
+		oiommu->domain = domain;
+		iommu->iommu_dev = oiommu;
 	}
 
-	omap_domain->iommu_dev = oiommu;
 	omap_domain->dev = dev;
-	oiommu->domain = domain;
 
+	goto out;
+
+attach_fail:
+	while (i--) {
+		iommu--;
+		arch_data--;
+		oiommu = iommu->iommu_dev;
+		omap_iommu_detach(oiommu);
+		iommu->iommu_dev = NULL;
+		oiommu->domain = NULL;
+	}
+init_fail:
+	omap_iommu_detach_fini(omap_domain);
 out:
 	spin_unlock(&omap_domain->lock);
 	return ret;
@@ -1146,7 +1287,10 @@ omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 				   struct device *dev)
 {
-	struct omap_iommu *oiommu = dev_to_omap_iommu(dev);
+	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
+	struct omap_iommu_device *iommu = omap_domain->iommus;
+	struct omap_iommu *oiommu;
+	int i;
 
 	if (!omap_domain->dev) {
 		dev_err(dev, "domain has no attached device\n");
@@ -1159,13 +1303,24 @@ static void _omap_iommu_detach_dev(struct omap_iommu_domain *omap_domain,
 		return;
 	}
 
-	iopgtable_clear_entry_all(oiommu);
+	/*
+	 * cleanup in the reverse order of attachment - this addresses
+	 * any h/w dependencies between multiple instances, if any
+	 */
+	iommu += (omap_domain->num_iommus - 1);
+	arch_data += (omap_domain->num_iommus - 1);
+	for (i = 0; i < omap_domain->num_iommus; i++, iommu--, arch_data--) {
+		oiommu = iommu->iommu_dev;
+		iopgtable_clear_entry_all(oiommu);
+
+		omap_iommu_detach(oiommu);
+		iommu->iommu_dev = NULL;
+		oiommu->domain = NULL;
+	}
 
-	omap_iommu_detach(oiommu);
+	omap_iommu_detach_fini(omap_domain);
 
-	omap_domain->iommu_dev = NULL;
 	omap_domain->dev = NULL;
-	oiommu->domain = NULL;
 }
 
 static void omap_iommu_detach_dev(struct iommu_domain *domain,
@@ -1187,18 +1342,7 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 
 	omap_domain = kzalloc(sizeof(*omap_domain), GFP_KERNEL);
 	if (!omap_domain)
-		goto out;
-
-	omap_domain->pgtable = kzalloc(IOPGD_TABLE_SIZE, GFP_KERNEL);
-	if (!omap_domain->pgtable)
-		goto fail_nomem;
-
-	/*
-	 * should never fail, but please keep this around to ensure
-	 * we keep the hardware happy
-	 */
-	if (WARN_ON(!IS_ALIGNED((long)omap_domain->pgtable, IOPGD_TABLE_SIZE)))
-		goto fail_align;
+		return NULL;
 
 	spin_lock_init(&omap_domain->lock);
 
@@ -1207,13 +1351,6 @@ static struct iommu_domain *omap_iommu_domain_alloc(unsigned type)
 	omap_domain->domain.geometry.force_aperture = true;
 
 	return &omap_domain->domain;
-
-fail_align:
-	kfree(omap_domain->pgtable);
-fail_nomem:
-	kfree(omap_domain);
-out:
-	return NULL;
 }
 
 static void omap_iommu_domain_free(struct iommu_domain *domain)
@@ -1227,7 +1364,6 @@ static void omap_iommu_domain_free(struct iommu_domain *domain)
 	if (omap_domain->dev)
 		_omap_iommu_detach_dev(omap_domain, omap_domain->dev);
 
-	kfree(omap_domain->pgtable);
 	kfree(omap_domain);
 }
 
@@ -1235,11 +1371,16 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t da)
 {
 	struct omap_iommu_domain *omap_domain = to_omap_domain(domain);
-	struct omap_iommu *oiommu = omap_domain->iommu_dev;
+	struct omap_iommu_device *iommu = omap_domain->iommus;
+	struct omap_iommu *oiommu = iommu->iommu_dev;
 	struct device *dev = oiommu->dev;
 	u32 *pgd, *pte;
 	phys_addr_t ret = 0;
 
+	/*
+	 * all the iommus within the domain will have identical programming,
+	 * so perform the lookup using just the first iommu
+	 */
 	iopgtable_lookup_entry(oiommu, da, &pgd, &pte);
 
 	if (pte) {
@@ -1265,11 +1406,12 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static int omap_iommu_add_device(struct device *dev)
 {
-	struct omap_iommu_arch_data *arch_data;
+	struct omap_iommu_arch_data *arch_data, *tmp;
 	struct omap_iommu *oiommu;
 	struct iommu_group *group;
 	struct device_node *np;
 	struct platform_device *pdev;
+	int num_iommus, i;
 	int ret;
 
 	/*
@@ -1281,36 +1423,57 @@ static int omap_iommu_add_device(struct device *dev)
 	if (!dev->of_node)
 		return 0;
 
-	np = of_parse_phandle(dev->of_node, "iommus", 0);
-	if (!np)
+	/*
+	 * retrieve the count of IOMMU nodes using phandle size as element size
+	 * since #iommu-cells = 0 for OMAP
+	 */
+	num_iommus = of_property_count_elems_of_size(dev->of_node, "iommus",
+						     sizeof(phandle));
+	if (num_iommus < 0)
 		return 0;
 
-	pdev = of_find_device_by_node(np);
-	if (WARN_ON(!pdev)) {
-		of_node_put(np);
-		return -EINVAL;
-	}
+	arch_data = kzalloc((num_iommus + 1) * sizeof(*arch_data), GFP_KERNEL);
+	if (!arch_data)
+		return -ENOMEM;
 
-	oiommu = platform_get_drvdata(pdev);
-	if (!oiommu) {
-		of_node_put(np);
-		return -EINVAL;
-	}
+	for (i = 0, tmp = arch_data; i < num_iommus; i++, tmp++) {
+		np = of_parse_phandle(dev->of_node, "iommus", i);
+		if (!np) {
+			kfree(arch_data);
+			return -EINVAL;
+		}
+
+		pdev = of_find_device_by_node(np);
+		if (WARN_ON(!pdev)) {
+			of_node_put(np);
+			kfree(arch_data);
+			return -EINVAL;
+		}
+
+		oiommu = platform_get_drvdata(pdev);
+		if (!oiommu) {
+			of_node_put(np);
+			kfree(arch_data);
+			return -EINVAL;
+		}
+
+		tmp->iommu_dev = oiommu;
 
-	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
-	if (!arch_data) {
 		of_node_put(np);
-		return -ENOMEM;
 	}
 
+	/*
+	 * use the first IOMMU alone for the sysfs device linking.
+	 * TODO: Evaluate if a single iommu_group needs to be
+	 * maintained for both IOMMUs
+	 */
+	oiommu = arch_data->iommu_dev;
 	ret = iommu_device_link(&oiommu->iommu, dev);
 	if (ret) {
 		kfree(arch_data);
-		of_node_put(np);
 		return ret;
 	}
 
-	arch_data->iommu_dev = oiommu;
 	dev->archdata.iommu = arch_data;
 
 	/*
@@ -1326,8 +1489,6 @@ static int omap_iommu_add_device(struct device *dev)
 	}
 	iommu_group_put(group);
 
-	of_node_put(np);
-
 	return 0;
 }
 
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index a675af29a6ec..1703159ef5af 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -29,17 +29,26 @@ struct iotlb_entry {
 };
 
 /**
+ * struct omap_iommu_device - omap iommu device data
+ * @pgtable:	page table used by an omap iommu attached to a domain
+ * @iommu_dev:	pointer to store an omap iommu instance attached to a domain
+ */
+struct omap_iommu_device {
+	u32 *pgtable;
+	struct omap_iommu *iommu_dev;
+};
+
+/**
  * struct omap_iommu_domain - omap iommu domain
- * @pgtable:	the page table
- * @iommu_dev:	an omap iommu device attached to this domain. only a single
- *		iommu device can be attached for now.
+ * @num_iommus: number of iommus in this domain
+ * @iommus:	omap iommu device data for all iommus in this domain
  * @dev:	Device using this domain.
  * @lock:	domain lock, should be taken when attaching/detaching
  * @domain:	generic domain handle used by iommu core code
  */
 struct omap_iommu_domain {
-	u32 *pgtable;
-	struct omap_iommu *iommu_dev;
+	u32 num_iommus;
+	struct omap_iommu_device *iommus;
 	struct device *dev;
 	spinlock_t lock;
 	struct iommu_domain domain;
@@ -97,17 +106,6 @@ struct iotlb_lock {
 	short vict;
 };
 
-/**
- * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
- * @dev: iommu client device
- */
-static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
-{
-	struct omap_iommu_arch_data *arch_data = dev->archdata.iommu;
-
-	return arch_data->iommu_dev;
-}
-
 /*
  * MMU Register offsets
  */
-- 
2.13.1
