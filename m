From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 09/17] iommu/omap: Consolidate OMAP IOMMU modules
Date: Wed, 22 Oct 2014 17:22:27 -0500
Message-ID: <1414016555-28067-10-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46472 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933492AbaJVWWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2014 18:22:51 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The OMAP IOMMU driver was originally designed as modules, and split
into a core module and a thin arch-specific module through the OMAP
arch-specific struct iommu_functions, to scale for both OMAP1 and
OMAP2+ IOMMU variants. The driver can only be built for OMAP2+
platforms currently, and also can only be built-in after the
adaptation to generic IOMMU API. The OMAP1 variant was never added
and will most probably be never added (the code for the only potential
user, its parent, DSP processor has already been cleaned up). So,
consolidate the OMAP2 specific omap-iommu2 module into the core OMAP
IOMMU driver - this eliminates the arch-specific ops structure and
simplifies the driver into a single module that only implements the
generic IOMMU API's iommu_ops.

The following are the main changes:
- omap-iommu2 module is completely eliminated, with the common
  definitions moved to the internal omap-iommu.h, and the ops
  implementations moved into omap-iommu.c
- OMAP arch-specific struct iommu_functions is also eliminated,
  with the ops implementations directly absorbed into the calling
  functions
- iotlb_alloc_cr() is no longer inlined and defined only when
  PREFETCH_IOTLB is defined
- iotlb_dump_cr() is similarly defined only when CONFIG_OMAP_IOMMU_DEBUG
  is defined
- Elimination of the OMAP IOMMU exported functions to register the
  arch ops, omap_install_iommu_arch() & omap_uninstall_iommu_arch()
- Any stale comments about OMAP1 are also cleaned up

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/Makefile      |   1 -
 drivers/iommu/omap-iommu.c  | 263 ++++++++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h  |  61 +++++----
 drivers/iommu/omap-iommu2.c | 311 --------------------------------------------
 4 files changed, 217 insertions(+), 419 deletions(-)
 delete mode 100644 drivers/iommu/omap-iommu2.c

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 16edef7..18fa446 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,7 +11,6 @@ obj-$(CONFIG_INTEL_IOMMU) += iova.o intel-iommu.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
 obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
-obj-$(CONFIG_OMAP_IOMMU) += omap-iommu2.o
 obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
 obj-$(CONFIG_TEGRA_IOMMU_GART) += tegra-gart.o
 obj-$(CONFIG_TEGRA_IOMMU_SMMU) += tegra-smmu.o
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index f9efa6b..91262fa 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -76,53 +76,23 @@ struct iotlb_lock {
 	short vict;
 };
 
-/* accommodate the difference between omap1 and omap2/3 */
-static const struct iommu_functions *arch_iommu;
-
 static struct platform_driver omap_iommu_driver;
 static struct kmem_cache *iopte_cachep;
 
 /**
- * omap_install_iommu_arch - Install archtecure specific iommu functions
- * @ops:	a pointer to architecture specific iommu functions
- *
- * There are several kind of iommu algorithm(tlb, pagetable) among
- * omap series. This interface installs such an iommu algorighm.
- **/
-int omap_install_iommu_arch(const struct iommu_functions *ops)
-{
-	if (arch_iommu)
-		return -EBUSY;
-
-	arch_iommu = ops;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(omap_install_iommu_arch);
-
-/**
- * omap_uninstall_iommu_arch - Uninstall archtecure specific iommu functions
- * @ops:	a pointer to architecture specific iommu functions
- *
- * This interface uninstalls the iommu algorighm installed previously.
- **/
-void omap_uninstall_iommu_arch(const struct iommu_functions *ops)
-{
-	if (arch_iommu != ops)
-		pr_err("%s: not your arch\n", __func__);
-
-	arch_iommu = NULL;
-}
-EXPORT_SYMBOL_GPL(omap_uninstall_iommu_arch);
-
-/**
  * omap_iommu_save_ctx - Save registers for pm off-mode support
  * @dev:	client device
  **/
 void omap_iommu_save_ctx(struct device *dev)
 {
 	struct omap_iommu *obj = dev_to_omap_iommu(dev);
+	u32 *p = obj->ctx;
+	int i;
 
-	arch_iommu->save_ctx(obj);
+	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
+		p[i] = iommu_read_reg(obj, i * sizeof(u32));
+		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
+	}
 }
 EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
 
@@ -133,20 +103,75 @@ EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
 void omap_iommu_restore_ctx(struct device *dev)
 {
 	struct omap_iommu *obj = dev_to_omap_iommu(dev);
+	u32 *p = obj->ctx;
+	int i;
 
-	arch_iommu->restore_ctx(obj);
+	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
+		iommu_write_reg(obj, p[i], i * sizeof(u32));
+		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
+	}
 }
 EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
 
+static void __iommu_set_twl(struct omap_iommu *obj, bool on)
+{
+	u32 l = iommu_read_reg(obj, MMU_CNTL);
+
+	if (on)
+		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
+	else
+		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
+
+	l &= ~MMU_CNTL_MASK;
+	if (on)
+		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
+	else
+		l |= (MMU_CNTL_MMU_EN);
+
+	iommu_write_reg(obj, l, MMU_CNTL);
+}
+
+static int omap2_iommu_enable(struct omap_iommu *obj)
+{
+	u32 l, pa;
+
+	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
+		return -EINVAL;
+
+	pa = virt_to_phys(obj->iopgd);
+	if (!IS_ALIGNED(pa, SZ_16K))
+		return -EINVAL;
+
+	l = iommu_read_reg(obj, MMU_REVISION);
+	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
+		 (l >> 4) & 0xf, l & 0xf);
+
+	iommu_write_reg(obj, pa, MMU_TTB);
+
+	if (obj->has_bus_err_back)
+		iommu_write_reg(obj, MMU_GP_REG_BUS_ERR_BACK_EN, MMU_GP_REG);
+
+	__iommu_set_twl(obj, true);
+
+	return 0;
+}
+
+static void omap2_iommu_disable(struct omap_iommu *obj)
+{
+	u32 l = iommu_read_reg(obj, MMU_CNTL);
+
+	l &= ~MMU_CNTL_MASK;
+	iommu_write_reg(obj, l, MMU_CNTL);
+
+	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
+}
+
 static int iommu_enable(struct omap_iommu *obj)
 {
 	int err;
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	if (!arch_iommu)
-		return -ENODEV;
-
 	if (pdata && pdata->deassert_reset) {
 		err = pdata->deassert_reset(pdev, pdata->reset_name);
 		if (err) {
@@ -157,7 +182,7 @@ static int iommu_enable(struct omap_iommu *obj)
 
 	pm_runtime_get_sync(obj->dev);
 
-	err = arch_iommu->enable(obj);
+	err = omap2_iommu_enable(obj);
 
 	return err;
 }
@@ -167,7 +192,7 @@ static void iommu_disable(struct omap_iommu *obj)
 	struct platform_device *pdev = to_platform_device(obj->dev);
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
-	arch_iommu->disable(obj);
+	omap2_iommu_disable(obj);
 
 	pm_runtime_put_sync(obj->dev);
 
@@ -182,7 +207,13 @@ void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
 {
 	BUG_ON(!cr || !e);
 
-	arch_iommu->cr_to_e(cr, e);
+	e->da		= cr->cam & MMU_CAM_VATAG_MASK;
+	e->pa		= cr->ram & MMU_RAM_PADDR_MASK;
+	e->valid	= cr->cam & MMU_CAM_V;
+	e->pgsz		= cr->cam & MMU_CAM_PGSZ_MASK;
+	e->endian	= cr->ram & MMU_RAM_ENDIAN_MASK;
+	e->elsz		= cr->ram & MMU_RAM_ELSZ_MASK;
+	e->mixed	= cr->ram & MMU_RAM_MIXED;
 }
 EXPORT_SYMBOL_GPL(omap_iotlb_cr_to_e);
 
@@ -191,31 +222,46 @@ static inline int iotlb_cr_valid(struct cr_regs *cr)
 	if (!cr)
 		return -EINVAL;
 
-	return arch_iommu->cr_valid(cr);
-}
-
-static inline struct cr_regs *iotlb_alloc_cr(struct omap_iommu *obj,
-					     struct iotlb_entry *e)
-{
-	if (!e)
-		return NULL;
-
-	return arch_iommu->alloc_cr(obj, e);
+	return cr->cam & MMU_CAM_V;
 }
 
 static u32 iotlb_cr_to_virt(struct cr_regs *cr)
 {
-	return arch_iommu->cr_to_virt(cr);
+	u32 page_size = cr->cam & MMU_CAM_PGSZ_MASK;
+	u32 mask = get_cam_va_mask(cr->cam & page_size);
+
+	return cr->cam & mask;
 }
 
 static u32 get_iopte_attr(struct iotlb_entry *e)
 {
-	return arch_iommu->get_pte_attr(e);
+	u32 attr;
+
+	attr = e->mixed << 5;
+	attr |= e->endian;
+	attr |= e->elsz >> 3;
+	attr <<= (((e->pgsz == MMU_CAM_PGSZ_4K) ||
+			(e->pgsz == MMU_CAM_PGSZ_64K)) ? 0 : 6);
+	return attr;
 }
 
 static u32 iommu_report_fault(struct omap_iommu *obj, u32 *da)
 {
-	return arch_iommu->fault_isr(obj, da);
+	u32 status, fault_addr;
+
+	status = iommu_read_reg(obj, MMU_IRQSTATUS);
+	status &= MMU_IRQ_MASK;
+	if (!status) {
+		*da = 0;
+		return 0;
+	}
+
+	fault_addr = iommu_read_reg(obj, MMU_FAULT_AD);
+	*da = fault_addr;
+
+	iommu_write_reg(obj, status, MMU_IRQSTATUS);
+
+	return status;
 }
 
 static void iotlb_lock_get(struct omap_iommu *obj, struct iotlb_lock *l)
@@ -241,31 +287,19 @@ static void iotlb_lock_set(struct omap_iommu *obj, struct iotlb_lock *l)
 
 static void iotlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
-	arch_iommu->tlb_read_cr(obj, cr);
+	cr->cam = iommu_read_reg(obj, MMU_READ_CAM);
+	cr->ram = iommu_read_reg(obj, MMU_READ_RAM);
 }
 
 static void iotlb_load_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
-	arch_iommu->tlb_load_cr(obj, cr);
+	iommu_write_reg(obj, cr->cam | MMU_CAM_V, MMU_CAM);
+	iommu_write_reg(obj, cr->ram, MMU_RAM);
 
 	iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
 	iommu_write_reg(obj, 1, MMU_LD_TLB);
 }
 
-/**
- * iotlb_dump_cr - Dump an iommu tlb entry into buf
- * @obj:	target iommu
- * @cr:		contents of cam and ram register
- * @buf:	output buffer
- **/
-static inline ssize_t iotlb_dump_cr(struct omap_iommu *obj, struct cr_regs *cr,
-				    char *buf)
-{
-	BUG_ON(!cr || !buf);
-
-	return arch_iommu->dump_cr(obj, cr, buf);
-}
-
 /* only used in iotlb iteration for-loop */
 static struct cr_regs __iotlb_read_cr(struct omap_iommu *obj, int n)
 {
@@ -280,12 +314,36 @@ static struct cr_regs __iotlb_read_cr(struct omap_iommu *obj, int n)
 	return cr;
 }
 
+#ifdef PREFETCH_IOTLB
+static struct cr_regs *iotlb_alloc_cr(struct omap_iommu *obj,
+				      struct iotlb_entry *e)
+{
+	struct cr_regs *cr;
+
+	if (!e)
+		return NULL;
+
+	if (e->da & ~(get_cam_va_mask(e->pgsz))) {
+		dev_err(obj->dev, "%s:\twrong alignment: %08x\n", __func__,
+			e->da);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
+	if (!cr)
+		return ERR_PTR(-ENOMEM);
+
+	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
+	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
+
+	return cr;
+}
+
 /**
  * load_iotlb_entry - Set an iommu tlb entry
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-#ifdef PREFETCH_IOTLB
 static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
@@ -416,6 +474,44 @@ static void flush_iotlb_all(struct omap_iommu *obj)
 
 #if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
 
+#define pr_reg(name)							\
+	do {								\
+		ssize_t bytes;						\
+		const char *str = "%20s: %08x\n";			\
+		const int maxcol = 32;					\
+		bytes = snprintf(p, maxcol, str, __stringify(name),	\
+				 iommu_read_reg(obj, MMU_##name));	\
+		p += bytes;						\
+		len -= bytes;						\
+		if (len < maxcol)					\
+			goto out;					\
+	} while (0)
+
+static ssize_t
+omap2_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len)
+{
+	char *p = buf;
+
+	pr_reg(REVISION);
+	pr_reg(IRQSTATUS);
+	pr_reg(IRQENABLE);
+	pr_reg(WALKING_ST);
+	pr_reg(CNTL);
+	pr_reg(FAULT_AD);
+	pr_reg(TTB);
+	pr_reg(LOCK);
+	pr_reg(LD_TLB);
+	pr_reg(CAM);
+	pr_reg(RAM);
+	pr_reg(GFLUSH);
+	pr_reg(FLUSH_ENTRY);
+	pr_reg(READ_CAM);
+	pr_reg(READ_RAM);
+	pr_reg(EMU_FAULT_AD);
+out:
+	return p - buf;
+}
+
 ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 {
 	if (!obj || !buf)
@@ -423,7 +519,7 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 
 	pm_runtime_get_sync(obj->dev);
 
-	bytes = arch_iommu->dump_ctx(obj, buf, bytes);
+	bytes = omap2_iommu_dump_ctx(obj, buf, bytes);
 
 	pm_runtime_put_sync(obj->dev);
 
@@ -455,6 +551,24 @@ __dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
 }
 
 /**
+ * iotlb_dump_cr - Dump an iommu tlb entry into buf
+ * @obj:	target iommu
+ * @cr:		contents of cam and ram register
+ * @buf:	output buffer
+ **/
+static ssize_t iotlb_dump_cr(struct omap_iommu *obj, struct cr_regs *cr,
+			     char *buf)
+{
+	char *p = buf;
+
+	/* FIXME: Need more detail analysis of cam/ram */
+	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
+					(cr->cam & MMU_CAM_P) ? 1 : 0);
+
+	return p - buf;
+}
+
+/**
  * omap_dump_tlb_entries - dump cr arrays to given buffer
  * @obj:	target iommu
  * @buf:	output buffer
@@ -1008,7 +1122,6 @@ static u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa, int pgsz)
 	e->da		= da;
 	e->pa		= pa;
 	e->valid	= MMU_CAM_V;
-	/* FIXME: add OMAP1 support */
 	e->pgsz		= pgsz;
 	e->endian	= MMU_RAM_ENDIAN_LITTLE;
 	e->elsz		= MMU_RAM_ELSZ_8;
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 45fe67d..0516e0e 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -13,10 +13,6 @@
 #ifndef _OMAP_IOMMU_H
 #define _OMAP_IOMMU_H
 
-#if defined(CONFIG_ARCH_OMAP1)
-#error "iommu for this processor not implemented yet"
-#endif
-
 struct iotlb_entry {
 	u32 da;
 	u32 pa;
@@ -68,31 +64,6 @@ struct cr_regs {
 	};
 };
 
-/* architecture specific functions */
-struct iommu_functions {
-	int (*enable)(struct omap_iommu *obj);
-	void (*disable)(struct omap_iommu *obj);
-	void (*set_twl)(struct omap_iommu *obj, bool on);
-	u32 (*fault_isr)(struct omap_iommu *obj, u32 *ra);
-
-	void (*tlb_read_cr)(struct omap_iommu *obj, struct cr_regs *cr);
-	void (*tlb_load_cr)(struct omap_iommu *obj, struct cr_regs *cr);
-
-	struct cr_regs *(*alloc_cr)(struct omap_iommu *obj,
-							struct iotlb_entry *e);
-	int (*cr_valid)(struct cr_regs *cr);
-	u32 (*cr_to_virt)(struct cr_regs *cr);
-	void (*cr_to_e)(struct cr_regs *cr, struct iotlb_entry *e);
-	ssize_t (*dump_cr)(struct omap_iommu *obj, struct cr_regs *cr,
-							char *buf);
-
-	u32 (*get_pte_attr)(struct iotlb_entry *e);
-
-	void (*save_ctx)(struct omap_iommu *obj);
-	void (*restore_ctx)(struct omap_iommu *obj);
-	ssize_t (*dump_ctx)(struct omap_iommu *obj, char *buf, ssize_t len);
-};
-
 /**
  * dev_to_omap_iommu() - retrieves an omap iommu object from a user device
  * @dev: iommu client device
@@ -130,6 +101,28 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 /*
  * MMU Register bit definitions
  */
+/* IRQSTATUS & IRQENABLE */
+#define MMU_IRQ_MULTIHITFAULT	(1 << 4)
+#define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
+#define MMU_IRQ_EMUMISS		(1 << 2)
+#define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
+#define MMU_IRQ_TLBMISS		(1 << 0)
+
+#define __MMU_IRQ_FAULT		\
+	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS | MMU_IRQ_TRANSLATIONFAULT)
+#define MMU_IRQ_MASK		\
+	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_TLBMISS)
+#define MMU_IRQ_TWL_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT)
+#define MMU_IRQ_TLB_MISS_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TLBMISS)
+
+/* MMU_CNTL */
+#define MMU_CNTL_SHIFT		1
+#define MMU_CNTL_MASK		(7 << MMU_CNTL_SHIFT)
+#define MMU_CNTL_EML_TLB	(1 << 3)
+#define MMU_CNTL_TWL_EN		(1 << 2)
+#define MMU_CNTL_MMU_EN		(1 << 1)
+
+/* CAM */
 #define MMU_CAM_VATAG_SHIFT	12
 #define MMU_CAM_VATAG_MASK \
 	((~0UL >> MMU_CAM_VATAG_SHIFT) << MMU_CAM_VATAG_SHIFT)
@@ -141,6 +134,7 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 #define MMU_CAM_PGSZ_4K		(2 << 0)
 #define MMU_CAM_PGSZ_16M	(3 << 0)
 
+/* RAM */
 #define MMU_RAM_PADDR_SHIFT	12
 #define MMU_RAM_PADDR_MASK \
 	((~0UL >> MMU_RAM_PADDR_SHIFT) << MMU_RAM_PADDR_SHIFT)
@@ -162,6 +156,12 @@ static inline struct omap_iommu *dev_to_omap_iommu(struct device *dev)
 
 #define MMU_GP_REG_BUS_ERR_BACK_EN	0x1
 
+#define get_cam_va_mask(pgsz)				\
+	(((pgsz) == MMU_CAM_PGSZ_16M) ? 0xff000000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_1M)  ? 0xfff00000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
+	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
+
 /*
  * utilities for super page(16MB, 1MB, 64KB and 4KB)
  */
@@ -197,9 +197,6 @@ omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 extern int omap_foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));
 
-extern int omap_install_iommu_arch(const struct iommu_functions *ops);
-extern void omap_uninstall_iommu_arch(const struct iommu_functions *ops);
-
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
 extern size_t
diff --git a/drivers/iommu/omap-iommu2.c b/drivers/iommu/omap-iommu2.c
deleted file mode 100644
index ce2fff3..0000000
--- a/drivers/iommu/omap-iommu2.c
+++ /dev/null
@@ -1,311 +0,0 @@
-/*
- * omap iommu: omap2/3 architecture specific functions
- *
- * Copyright (C) 2008-2009 Nokia Corporation
- *
- * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
- *		Paul Mundt and Toshihiro Kobayashi
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/err.h>
-#include <linux/device.h>
-#include <linux/io.h>
-#include <linux/jiffies.h>
-#include <linux/module.h>
-#include <linux/omap-iommu.h>
-#include <linux/slab.h>
-#include <linux/stringify.h>
-#include <linux/platform_data/iommu-omap.h>
-
-#include "omap-iommu.h"
-
-/*
- * omap2 architecture specific register bit definitions
- */
-/* IRQSTATUS & IRQENABLE */
-#define MMU_IRQ_MULTIHITFAULT	(1 << 4)
-#define MMU_IRQ_TABLEWALKFAULT	(1 << 3)
-#define MMU_IRQ_EMUMISS		(1 << 2)
-#define MMU_IRQ_TRANSLATIONFAULT	(1 << 1)
-#define MMU_IRQ_TLBMISS		(1 << 0)
-
-#define __MMU_IRQ_FAULT		\
-	(MMU_IRQ_MULTIHITFAULT | MMU_IRQ_EMUMISS | MMU_IRQ_TRANSLATIONFAULT)
-#define MMU_IRQ_MASK		\
-	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT | MMU_IRQ_TLBMISS)
-#define MMU_IRQ_TWL_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TABLEWALKFAULT)
-#define MMU_IRQ_TLB_MISS_MASK	(__MMU_IRQ_FAULT | MMU_IRQ_TLBMISS)
-
-/* MMU_CNTL */
-#define MMU_CNTL_SHIFT		1
-#define MMU_CNTL_MASK		(7 << MMU_CNTL_SHIFT)
-#define MMU_CNTL_EML_TLB	(1 << 3)
-#define MMU_CNTL_TWL_EN		(1 << 2)
-#define MMU_CNTL_MMU_EN		(1 << 1)
-
-#define get_cam_va_mask(pgsz)				\
-	(((pgsz) == MMU_CAM_PGSZ_16M) ? 0xff000000 :	\
-	 ((pgsz) == MMU_CAM_PGSZ_1M)  ? 0xfff00000 :	\
-	 ((pgsz) == MMU_CAM_PGSZ_64K) ? 0xffff0000 :	\
-	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
-
-static void __iommu_set_twl(struct omap_iommu *obj, bool on)
-{
-	u32 l = iommu_read_reg(obj, MMU_CNTL);
-
-	if (on)
-		iommu_write_reg(obj, MMU_IRQ_TWL_MASK, MMU_IRQENABLE);
-	else
-		iommu_write_reg(obj, MMU_IRQ_TLB_MISS_MASK, MMU_IRQENABLE);
-
-	l &= ~MMU_CNTL_MASK;
-	if (on)
-		l |= (MMU_CNTL_MMU_EN | MMU_CNTL_TWL_EN);
-	else
-		l |= (MMU_CNTL_MMU_EN);
-
-	iommu_write_reg(obj, l, MMU_CNTL);
-}
-
-
-static int omap2_iommu_enable(struct omap_iommu *obj)
-{
-	u32 l, pa;
-
-	if (!obj->iopgd || !IS_ALIGNED((u32)obj->iopgd,  SZ_16K))
-		return -EINVAL;
-
-	pa = virt_to_phys(obj->iopgd);
-	if (!IS_ALIGNED(pa, SZ_16K))
-		return -EINVAL;
-
-	l = iommu_read_reg(obj, MMU_REVISION);
-	dev_info(obj->dev, "%s: version %d.%d\n", obj->name,
-		 (l >> 4) & 0xf, l & 0xf);
-
-	iommu_write_reg(obj, pa, MMU_TTB);
-
-	if (obj->has_bus_err_back)
-		iommu_write_reg(obj, MMU_GP_REG_BUS_ERR_BACK_EN, MMU_GP_REG);
-
-	__iommu_set_twl(obj, true);
-
-	return 0;
-}
-
-static void omap2_iommu_disable(struct omap_iommu *obj)
-{
-	u32 l = iommu_read_reg(obj, MMU_CNTL);
-
-	l &= ~MMU_CNTL_MASK;
-	iommu_write_reg(obj, l, MMU_CNTL);
-
-	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
-}
-
-static void omap2_iommu_set_twl(struct omap_iommu *obj, bool on)
-{
-	__iommu_set_twl(obj, false);
-}
-
-static u32 omap2_iommu_fault_isr(struct omap_iommu *obj, u32 *ra)
-{
-	u32 stat, da;
-
-	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
-	stat &= MMU_IRQ_MASK;
-	if (!stat) {
-		*ra = 0;
-		return 0;
-	}
-
-	da = iommu_read_reg(obj, MMU_FAULT_AD);
-	*ra = da;
-
-	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
-
-	return stat;
-}
-
-static void omap2_tlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
-{
-	cr->cam = iommu_read_reg(obj, MMU_READ_CAM);
-	cr->ram = iommu_read_reg(obj, MMU_READ_RAM);
-}
-
-static void omap2_tlb_load_cr(struct omap_iommu *obj, struct cr_regs *cr)
-{
-	iommu_write_reg(obj, cr->cam | MMU_CAM_V, MMU_CAM);
-	iommu_write_reg(obj, cr->ram, MMU_RAM);
-}
-
-static u32 omap2_cr_to_virt(struct cr_regs *cr)
-{
-	u32 page_size = cr->cam & MMU_CAM_PGSZ_MASK;
-	u32 mask = get_cam_va_mask(cr->cam & page_size);
-
-	return cr->cam & mask;
-}
-
-static struct cr_regs *omap2_alloc_cr(struct omap_iommu *obj,
-						struct iotlb_entry *e)
-{
-	struct cr_regs *cr;
-
-	if (e->da & ~(get_cam_va_mask(e->pgsz))) {
-		dev_err(obj->dev, "%s:\twrong alignment: %08x\n", __func__,
-			e->da);
-		return ERR_PTR(-EINVAL);
-	}
-
-	cr = kmalloc(sizeof(*cr), GFP_KERNEL);
-	if (!cr)
-		return ERR_PTR(-ENOMEM);
-
-	cr->cam = (e->da & MMU_CAM_VATAG_MASK) | e->prsvd | e->pgsz | e->valid;
-	cr->ram = e->pa | e->endian | e->elsz | e->mixed;
-
-	return cr;
-}
-
-static inline int omap2_cr_valid(struct cr_regs *cr)
-{
-	return cr->cam & MMU_CAM_V;
-}
-
-static u32 omap2_get_pte_attr(struct iotlb_entry *e)
-{
-	u32 attr;
-
-	attr = e->mixed << 5;
-	attr |= e->endian;
-	attr |= e->elsz >> 3;
-	attr <<= (((e->pgsz == MMU_CAM_PGSZ_4K) ||
-			(e->pgsz == MMU_CAM_PGSZ_64K)) ? 0 : 6);
-	return attr;
-}
-
-static ssize_t
-omap2_dump_cr(struct omap_iommu *obj, struct cr_regs *cr, char *buf)
-{
-	char *p = buf;
-
-	/* FIXME: Need more detail analysis of cam/ram */
-	p += sprintf(p, "%08x %08x %01x\n", cr->cam, cr->ram,
-					(cr->cam & MMU_CAM_P) ? 1 : 0);
-
-	return p - buf;
-}
-
-#define pr_reg(name)							\
-	do {								\
-		ssize_t bytes;						\
-		const char *str = "%20s: %08x\n";			\
-		const int maxcol = 32;					\
-		bytes = snprintf(p, maxcol, str, __stringify(name),	\
-				 iommu_read_reg(obj, MMU_##name));	\
-		p += bytes;						\
-		len -= bytes;						\
-		if (len < maxcol)					\
-			goto out;					\
-	} while (0)
-
-static ssize_t
-omap2_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len)
-{
-	char *p = buf;
-
-	pr_reg(REVISION);
-	pr_reg(IRQSTATUS);
-	pr_reg(IRQENABLE);
-	pr_reg(WALKING_ST);
-	pr_reg(CNTL);
-	pr_reg(FAULT_AD);
-	pr_reg(TTB);
-	pr_reg(LOCK);
-	pr_reg(LD_TLB);
-	pr_reg(CAM);
-	pr_reg(RAM);
-	pr_reg(GFLUSH);
-	pr_reg(FLUSH_ENTRY);
-	pr_reg(READ_CAM);
-	pr_reg(READ_RAM);
-	pr_reg(EMU_FAULT_AD);
-out:
-	return p - buf;
-}
-
-static void omap2_iommu_save_ctx(struct omap_iommu *obj)
-{
-	int i;
-	u32 *p = obj->ctx;
-
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		p[i] = iommu_read_reg(obj, i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
-	}
-}
-
-static void omap2_iommu_restore_ctx(struct omap_iommu *obj)
-{
-	int i;
-	u32 *p = obj->ctx;
-
-	for (i = 0; i < (MMU_REG_SIZE / sizeof(u32)); i++) {
-		iommu_write_reg(obj, p[i], i * sizeof(u32));
-		dev_dbg(obj->dev, "%s\t[%02d] %08x\n", __func__, i, p[i]);
-	}
-}
-
-static void omap2_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
-{
-	e->da		= cr->cam & MMU_CAM_VATAG_MASK;
-	e->pa		= cr->ram & MMU_RAM_PADDR_MASK;
-	e->valid	= cr->cam & MMU_CAM_V;
-	e->pgsz		= cr->cam & MMU_CAM_PGSZ_MASK;
-	e->endian	= cr->ram & MMU_RAM_ENDIAN_MASK;
-	e->elsz		= cr->ram & MMU_RAM_ELSZ_MASK;
-	e->mixed	= cr->ram & MMU_RAM_MIXED;
-}
-
-static const struct iommu_functions omap2_iommu_ops = {
-	.enable		= omap2_iommu_enable,
-	.disable	= omap2_iommu_disable,
-	.set_twl	= omap2_iommu_set_twl,
-	.fault_isr	= omap2_iommu_fault_isr,
-
-	.tlb_read_cr	= omap2_tlb_read_cr,
-	.tlb_load_cr	= omap2_tlb_load_cr,
-
-	.cr_to_e	= omap2_cr_to_e,
-	.cr_to_virt	= omap2_cr_to_virt,
-	.alloc_cr	= omap2_alloc_cr,
-	.cr_valid	= omap2_cr_valid,
-	.dump_cr	= omap2_dump_cr,
-
-	.get_pte_attr	= omap2_get_pte_attr,
-
-	.save_ctx	= omap2_iommu_save_ctx,
-	.restore_ctx	= omap2_iommu_restore_ctx,
-	.dump_ctx	= omap2_iommu_dump_ctx,
-};
-
-static int __init omap2_iommu_init(void)
-{
-	return omap_install_iommu_arch(&omap2_iommu_ops);
-}
-module_init(omap2_iommu_init);
-
-static void __exit omap2_iommu_exit(void)
-{
-	omap_uninstall_iommu_arch(&omap2_iommu_ops);
-}
-module_exit(omap2_iommu_exit);
-
-MODULE_AUTHOR("Hiroshi DOYU, Paul Mundt and Toshihiro Kobayashi");
-MODULE_DESCRIPTION("omap iommu: omap2/3 architecture specific functions");
-MODULE_LICENSE("GPL v2");
-- 
2.1.0

