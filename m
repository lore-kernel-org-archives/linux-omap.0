From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 7/7] omap: iommu: omapify 'struct iommu' and exposed API
Date: Wed, 24 Aug 2011 20:08:14 +0300
Message-ID: <1314205694-28935-8-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39540 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab1HXRJQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 13:09:16 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1002345wyg.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 10:09:15 -0700 (PDT)
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Prepend 'omap_' to OMAP's 'struct iommu' and exposed API, to prevent
namespace pollution and generally to improve readability of the code
that still uses the driver directly.

Update the users as needed as well.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/iommu2.c                |   31 +++---
 arch/arm/plat-omap/include/plat/iommu.h     |   55 ++++++-----
 arch/arm/plat-omap/include/plat/iommu2.h    |    4 +-
 arch/arm/plat-omap/include/plat/iopgtable.h |    2 +-
 arch/arm/plat-omap/include/plat/iovmm.h     |   19 ++--
 drivers/iommu/omap-iommu-debug.c            |   34 +++---
 drivers/iommu/omap-iommu.c                  |  146 ++++++++++++++-------------
 drivers/iommu/omap-iovmm.c                  |   62 ++++++------
 drivers/media/video/omap3isp/isp.c          |    6 +-
 drivers/media/video/omap3isp/isp.h          |    2 +-
 drivers/media/video/omap3isp/ispccdc.c      |   23 ++--
 drivers/media/video/omap3isp/ispstat.c      |    9 +-
 drivers/media/video/omap3isp/ispvideo.c     |    4 +-
 13 files changed, 208 insertions(+), 189 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index f286012..eefc379 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -66,7 +66,7 @@
 	 ((pgsz) == MMU_CAM_PGSZ_4K)  ? 0xfffff000 : 0)
 
 
-static void __iommu_set_twl(struct iommu *obj, bool on)
+static void __iommu_set_twl(struct omap_iommu *obj, bool on)
 {
 	u32 l = iommu_read_reg(obj, MMU_CNTL);
 
@@ -85,7 +85,7 @@ static void __iommu_set_twl(struct iommu *obj, bool on)
 }
 
 
-static int omap2_iommu_enable(struct iommu *obj)
+static int omap2_iommu_enable(struct omap_iommu *obj)
 {
 	u32 l, pa;
 	unsigned long timeout;
@@ -127,7 +127,7 @@ static int omap2_iommu_enable(struct iommu *obj)
 	return 0;
 }
 
-static void omap2_iommu_disable(struct iommu *obj)
+static void omap2_iommu_disable(struct omap_iommu *obj)
 {
 	u32 l = iommu_read_reg(obj, MMU_CNTL);
 
@@ -138,12 +138,12 @@ static void omap2_iommu_disable(struct iommu *obj)
 	dev_dbg(obj->dev, "%s is shutting down\n", obj->name);
 }
 
-static void omap2_iommu_set_twl(struct iommu *obj, bool on)
+static void omap2_iommu_set_twl(struct omap_iommu *obj, bool on)
 {
 	__iommu_set_twl(obj, false);
 }
 
-static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
+static u32 omap2_iommu_fault_isr(struct omap_iommu *obj, u32 *ra)
 {
 	u32 stat, da;
 	u32 errs = 0;
@@ -173,13 +173,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	return errs;
 }
 
-static void omap2_tlb_read_cr(struct iommu *obj, struct cr_regs *cr)
+static void omap2_tlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
 	cr->cam = iommu_read_reg(obj, MMU_READ_CAM);
 	cr->ram = iommu_read_reg(obj, MMU_READ_RAM);
 }
 
-static void omap2_tlb_load_cr(struct iommu *obj, struct cr_regs *cr)
+static void omap2_tlb_load_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
 	iommu_write_reg(obj, cr->cam | MMU_CAM_V, MMU_CAM);
 	iommu_write_reg(obj, cr->ram, MMU_RAM);
@@ -193,7 +193,8 @@ static u32 omap2_cr_to_virt(struct cr_regs *cr)
 	return cr->cam & mask;
 }
 
-static struct cr_regs *omap2_alloc_cr(struct iommu *obj, struct iotlb_entry *e)
+static struct cr_regs *omap2_alloc_cr(struct omap_iommu *obj,
+						struct iotlb_entry *e)
 {
 	struct cr_regs *cr;
 
@@ -230,7 +231,8 @@ static u32 omap2_get_pte_attr(struct iotlb_entry *e)
 	return attr;
 }
 
-static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
+static ssize_t
+omap2_dump_cr(struct omap_iommu *obj, struct cr_regs *cr, char *buf)
 {
 	char *p = buf;
 
@@ -254,7 +256,8 @@ static ssize_t omap2_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
 			goto out;					\
 	} while (0)
 
-static ssize_t omap2_iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len)
+static ssize_t
+omap2_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len)
 {
 	char *p = buf;
 
@@ -280,7 +283,7 @@ out:
 	return p - buf;
 }
 
-static void omap2_iommu_save_ctx(struct iommu *obj)
+static void omap2_iommu_save_ctx(struct omap_iommu *obj)
 {
 	int i;
 	u32 *p = obj->ctx;
@@ -293,7 +296,7 @@ static void omap2_iommu_save_ctx(struct iommu *obj)
 	BUG_ON(p[0] != IOMMU_ARCH_VERSION);
 }
 
-static void omap2_iommu_restore_ctx(struct iommu *obj)
+static void omap2_iommu_restore_ctx(struct omap_iommu *obj)
 {
 	int i;
 	u32 *p = obj->ctx;
@@ -343,13 +346,13 @@ static const struct iommu_functions omap2_iommu_ops = {
 
 static int __init omap2_iommu_init(void)
 {
-	return install_iommu_arch(&omap2_iommu_ops);
+	return omap_install_iommu_arch(&omap2_iommu_ops);
 }
 module_init(omap2_iommu_init);
 
 static void __exit omap2_iommu_exit(void)
 {
-	uninstall_iommu_arch(&omap2_iommu_ops);
+	omap_uninstall_iommu_arch(&omap2_iommu_ops);
 }
 module_exit(omap2_iommu_exit);
 
diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat-omap/include/plat/iommu.h
index 9ae1e27..7f1df0e 100644
--- a/arch/arm/plat-omap/include/plat/iommu.h
+++ b/arch/arm/plat-omap/include/plat/iommu.h
@@ -25,7 +25,7 @@ struct iotlb_entry {
 	};
 };
 
-struct iommu {
+struct omap_iommu {
 	const char	*name;
 	struct module	*owner;
 	struct clk	*clk;
@@ -48,7 +48,7 @@ struct iommu {
 	struct list_head	mmap;
 	struct mutex		mmap_lock; /* protect mmap */
 
-	int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs, void *priv);
+	int (*isr)(struct omap_iommu *obj, u32 da, u32 iommu_errs, void *priv);
 
 	void *ctx; /* iommu context: registres saved area */
 	u32 da_start;
@@ -81,25 +81,27 @@ struct iotlb_lock {
 struct iommu_functions {
 	unsigned long	version;
 
-	int (*enable)(struct iommu *obj);
-	void (*disable)(struct iommu *obj);
-	void (*set_twl)(struct iommu *obj, bool on);
-	u32 (*fault_isr)(struct iommu *obj, u32 *ra);
+	int (*enable)(struct omap_iommu *obj);
+	void (*disable)(struct omap_iommu *obj);
+	void (*set_twl)(struct omap_iommu *obj, bool on);
+	u32 (*fault_isr)(struct omap_iommu *obj, u32 *ra);
 
-	void (*tlb_read_cr)(struct iommu *obj, struct cr_regs *cr);
-	void (*tlb_load_cr)(struct iommu *obj, struct cr_regs *cr);
+	void (*tlb_read_cr)(struct omap_iommu *obj, struct cr_regs *cr);
+	void (*tlb_load_cr)(struct omap_iommu *obj, struct cr_regs *cr);
 
-	struct cr_regs *(*alloc_cr)(struct iommu *obj, struct iotlb_entry *e);
+	struct cr_regs *(*alloc_cr)(struct omap_iommu *obj,
+							struct iotlb_entry *e);
 	int (*cr_valid)(struct cr_regs *cr);
 	u32 (*cr_to_virt)(struct cr_regs *cr);
 	void (*cr_to_e)(struct cr_regs *cr, struct iotlb_entry *e);
-	ssize_t (*dump_cr)(struct iommu *obj, struct cr_regs *cr, char *buf);
+	ssize_t (*dump_cr)(struct omap_iommu *obj, struct cr_regs *cr,
+							char *buf);
 
 	u32 (*get_pte_attr)(struct iotlb_entry *e);
 
-	void (*save_ctx)(struct iommu *obj);
-	void (*restore_ctx)(struct iommu *obj);
-	ssize_t (*dump_ctx)(struct iommu *obj, char *buf, ssize_t len);
+	void (*save_ctx)(struct omap_iommu *obj);
+	void (*restore_ctx)(struct omap_iommu *obj);
+	ssize_t (*dump_ctx)(struct omap_iommu *obj, char *buf, ssize_t len);
 };
 
 struct iommu_platform_data {
@@ -150,28 +152,31 @@ struct iommu_platform_data {
 /*
  * global functions
  */
-extern u32 iommu_arch_version(void);
+extern u32 omap_iommu_arch_version(void);
 
-extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
+extern void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
 
-extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
+extern int
+omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 
-extern int iommu_set_isr(const char *name,
-			 int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
+extern int omap_iommu_set_isr(const char *name,
+		 int (*isr)(struct omap_iommu *obj, u32 da, u32 iommu_errs,
 				    void *priv),
 			 void *isr_priv);
 
-extern void iommu_save_ctx(struct iommu *obj);
-extern void iommu_restore_ctx(struct iommu *obj);
+extern void omap_iommu_save_ctx(struct omap_iommu *obj);
+extern void omap_iommu_restore_ctx(struct omap_iommu *obj);
 
-extern int install_iommu_arch(const struct iommu_functions *ops);
-extern void uninstall_iommu_arch(const struct iommu_functions *ops);
+extern int omap_install_iommu_arch(const struct iommu_functions *ops);
+extern void omap_uninstall_iommu_arch(const struct iommu_functions *ops);
 
-extern int foreach_iommu_device(void *data,
+extern int omap_foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));
 
-extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t len);
-extern size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t len);
+extern ssize_t
+omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
+extern size_t
+omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t len);
 struct device *omap_find_iommu_device(const char *name);
 
 #endif /* __MACH_IOMMU_H */
diff --git a/arch/arm/plat-omap/include/plat/iommu2.h b/arch/arm/plat-omap/include/plat/iommu2.h
index 10ad05f..d4116b5 100644
--- a/arch/arm/plat-omap/include/plat/iommu2.h
+++ b/arch/arm/plat-omap/include/plat/iommu2.h
@@ -83,12 +83,12 @@
 /*
  * register accessors
  */
-static inline u32 iommu_read_reg(struct iommu *obj, size_t offs)
+static inline u32 iommu_read_reg(struct omap_iommu *obj, size_t offs)
 {
 	return __raw_readl(obj->regbase + offs);
 }
 
-static inline void iommu_write_reg(struct iommu *obj, u32 val, size_t offs)
+static inline void iommu_write_reg(struct omap_iommu *obj, u32 val, size_t offs)
 {
 	__raw_writel(val, obj->regbase + offs);
 }
diff --git a/arch/arm/plat-omap/include/plat/iopgtable.h b/arch/arm/plat-omap/include/plat/iopgtable.h
index 33c7aa9..66a8139 100644
--- a/arch/arm/plat-omap/include/plat/iopgtable.h
+++ b/arch/arm/plat-omap/include/plat/iopgtable.h
@@ -115,6 +115,6 @@ static inline u32 iotlb_init_entry(struct iotlb_entry *e, u32 da, u32 pa,
 }
 
 #define to_iommu(dev)							\
-	(struct iommu *)platform_get_drvdata(to_platform_device(dev))
+	(struct omap_iommu *)platform_get_drvdata(to_platform_device(dev))
 
 #endif /* __PLAT_OMAP_IOMMU_H */
diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/arch/arm/plat-omap/include/plat/iovmm.h
index fc9aa6f..6af1a91 100644
--- a/arch/arm/plat-omap/include/plat/iovmm.h
+++ b/arch/arm/plat-omap/include/plat/iovmm.h
@@ -16,7 +16,7 @@
 #include <linux/iommu.h>
 
 struct iovm_struct {
-	struct iommu		*iommu;	/* iommu object which this belongs to */
+	struct omap_iommu	*iommu;	/* iommu object which this belongs to */
 	u32			da_start; /* area definition */
 	u32			da_end;
 	u32			flags; /* IOVMF_: see below */
@@ -72,15 +72,18 @@ struct iovm_struct {
 #define IOVMF_DA_FIXED		(1 << (4 + IOVMF_SW_SHIFT))
 
 
-extern struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da);
-extern u32 iommu_vmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
+extern struct iovm_struct *omap_find_iovm_area(struct omap_iommu *obj, u32 da);
+extern u32
+omap_iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da,
 			const struct sg_table *sgt, u32 flags);
-extern struct sg_table *iommu_vunmap(struct iommu_domain *domain,
-				struct iommu *obj, u32 da);
-extern u32 iommu_vmalloc(struct iommu_domain *domain, struct iommu *obj,
+extern struct sg_table *omap_iommu_vunmap(struct iommu_domain *domain,
+				struct omap_iommu *obj, u32 da);
+extern u32
+omap_iommu_vmalloc(struct iommu_domain *domain, struct omap_iommu *obj,
 				u32 da, size_t bytes, u32 flags);
-extern void iommu_vfree(struct iommu_domain *domain, struct iommu *obj,
+extern void
+omap_iommu_vfree(struct iommu_domain *domain, struct omap_iommu *obj,
 				const u32 da);
-extern void *da_to_va(struct iommu *obj, u32 da);
+extern void *omap_da_to_va(struct omap_iommu *obj, u32 da);
 
 #endif /* __IOMMU_MMAP_H */
diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 0f8c8dd..9c192e7 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -32,7 +32,7 @@ static struct dentry *iommu_debug_root;
 static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	u32 ver = iommu_arch_version();
+	u32 ver = omap_iommu_arch_version();
 	char buf[MAXCOLUMN], *p = buf;
 
 	p += sprintf(p, "H/W version: %d.%d\n", (ver >> 4) & 0xf , ver & 0xf);
@@ -43,7 +43,7 @@ static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
 static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	ssize_t bytes;
 
@@ -54,7 +54,7 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 
 	mutex_lock(&iommu_debug_lock);
 
-	bytes = iommu_dump_ctx(obj, p, count);
+	bytes = omap_iommu_dump_ctx(obj, p, count);
 	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, bytes);
 
 	mutex_unlock(&iommu_debug_lock);
@@ -66,7 +66,7 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	ssize_t bytes, rest;
 
@@ -80,7 +80,7 @@ static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 	p += sprintf(p, "%8s %8s\n", "cam:", "ram:");
 	p += sprintf(p, "-----------------------------------------\n");
 	rest = count - (p - buf);
-	p += dump_tlb_entries(obj, p, rest);
+	p += omap_dump_tlb_entries(obj, p, rest);
 
 	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
 
@@ -96,7 +96,7 @@ static ssize_t debug_write_pagetable(struct file *file,
 	struct iotlb_entry e;
 	struct cr_regs cr;
 	int err;
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char buf[MAXCOLUMN], *p = buf;
 
 	count = min(count, sizeof(buf));
@@ -113,8 +113,8 @@ static ssize_t debug_write_pagetable(struct file *file,
 		return -EINVAL;
 	}
 
-	iotlb_cr_to_e(&cr, &e);
-	err = iopgtable_store_entry(obj, &e);
+	omap_iotlb_cr_to_e(&cr, &e);
+	err = omap_iopgtable_store_entry(obj, &e);
 	if (err)
 		dev_err(obj->dev, "%s: fail to store cr\n", __func__);
 
@@ -136,7 +136,7 @@ static ssize_t debug_write_pagetable(struct file *file,
 		__err;						\
 	})
 
-static ssize_t dump_ioptable(struct iommu *obj, char *buf, ssize_t len)
+static ssize_t dump_ioptable(struct omap_iommu *obj, char *buf, ssize_t len)
 {
 	int i;
 	u32 *iopgd;
@@ -183,7 +183,7 @@ out:
 static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 				    size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	size_t bytes;
 
@@ -211,7 +211,7 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	struct iovm_struct *tmp;
 	int uninitialized_var(i);
@@ -253,7 +253,7 @@ static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
 static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	struct iovm_struct *area;
 	ssize_t bytes;
@@ -267,7 +267,7 @@ static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
 
 	mutex_lock(&iommu_debug_lock);
 
-	area = find_iovm_area(obj, (u32)ppos);
+	area = omap_find_iovm_area(obj, (u32)ppos);
 	if (IS_ERR(area)) {
 		bytes = -EINVAL;
 		goto err_out;
@@ -286,7 +286,7 @@ err_out:
 static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct iommu *obj = file->private_data;
+	struct omap_iommu *obj = file->private_data;
 	struct iovm_struct *area;
 	char *p, *buf;
 
@@ -304,7 +304,7 @@ static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
 		goto err_out;
 	}
 
-	area = find_iovm_area(obj, (u32)ppos);
+	area = omap_find_iovm_area(obj, (u32)ppos);
 	if (IS_ERR(area)) {
 		count = -EINVAL;
 		goto err_out;
@@ -360,7 +360,7 @@ DEBUG_FOPS(mem);
 static int iommu_debug_register(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct iommu *obj = platform_get_drvdata(pdev);
+	struct omap_iommu *obj = platform_get_drvdata(pdev);
 	struct dentry *d, *parent;
 
 	if (!obj || !obj->dev)
@@ -396,7 +396,7 @@ static int __init iommu_debug_init(void)
 		return -ENOMEM;
 	iommu_debug_root = d;
 
-	err = foreach_iommu_device(d, iommu_debug_register);
+	err = omap_foreach_iommu_device(d, iommu_debug_register);
 	if (err)
 		goto err_out;
 	return 0;
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d0f28e7..dad45ab 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -42,7 +42,7 @@
  */
 struct omap_iommu_domain {
 	u32 *pgtable;
-	struct iommu *iommu_dev;
+	struct omap_iommu *iommu_dev;
 	spinlock_t lock;
 };
 
@@ -53,13 +53,13 @@ static struct platform_driver omap_iommu_driver;
 static struct kmem_cache *iopte_cachep;
 
 /**
- * install_iommu_arch - Install archtecure specific iommu functions
+ * omap_install_iommu_arch - Install archtecure specific iommu functions
  * @ops:	a pointer to architecture specific iommu functions
  *
  * There are several kind of iommu algorithm(tlb, pagetable) among
  * omap series. This interface installs such an iommu algorighm.
  **/
-int install_iommu_arch(const struct iommu_functions *ops)
+int omap_install_iommu_arch(const struct iommu_functions *ops)
 {
 	if (arch_iommu)
 		return -EBUSY;
@@ -67,53 +67,53 @@ int install_iommu_arch(const struct iommu_functions *ops)
 	arch_iommu = ops;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(install_iommu_arch);
+EXPORT_SYMBOL_GPL(omap_install_iommu_arch);
 
 /**
- * uninstall_iommu_arch - Uninstall archtecure specific iommu functions
+ * omap_uninstall_iommu_arch - Uninstall archtecure specific iommu functions
  * @ops:	a pointer to architecture specific iommu functions
  *
  * This interface uninstalls the iommu algorighm installed previously.
  **/
-void uninstall_iommu_arch(const struct iommu_functions *ops)
+void omap_uninstall_iommu_arch(const struct iommu_functions *ops)
 {
 	if (arch_iommu != ops)
 		pr_err("%s: not your arch\n", __func__);
 
 	arch_iommu = NULL;
 }
-EXPORT_SYMBOL_GPL(uninstall_iommu_arch);
+EXPORT_SYMBOL_GPL(omap_uninstall_iommu_arch);
 
 /**
- * iommu_save_ctx - Save registers for pm off-mode support
+ * omap_iommu_save_ctx - Save registers for pm off-mode support
  * @obj:	target iommu
  **/
-void iommu_save_ctx(struct iommu *obj)
+void omap_iommu_save_ctx(struct omap_iommu *obj)
 {
 	arch_iommu->save_ctx(obj);
 }
-EXPORT_SYMBOL_GPL(iommu_save_ctx);
+EXPORT_SYMBOL_GPL(omap_iommu_save_ctx);
 
 /**
- * iommu_restore_ctx - Restore registers for pm off-mode support
+ * omap_iommu_restore_ctx - Restore registers for pm off-mode support
  * @obj:	target iommu
  **/
-void iommu_restore_ctx(struct iommu *obj)
+void omap_iommu_restore_ctx(struct omap_iommu *obj)
 {
 	arch_iommu->restore_ctx(obj);
 }
-EXPORT_SYMBOL_GPL(iommu_restore_ctx);
+EXPORT_SYMBOL_GPL(omap_iommu_restore_ctx);
 
 /**
- * iommu_arch_version - Return running iommu arch version
+ * omap_iommu_arch_version - Return running iommu arch version
  **/
-u32 iommu_arch_version(void)
+u32 omap_iommu_arch_version(void)
 {
 	return arch_iommu->version;
 }
-EXPORT_SYMBOL_GPL(iommu_arch_version);
+EXPORT_SYMBOL_GPL(omap_iommu_arch_version);
 
-static int iommu_enable(struct iommu *obj)
+static int iommu_enable(struct omap_iommu *obj)
 {
 	int err;
 
@@ -131,7 +131,7 @@ static int iommu_enable(struct iommu *obj)
 	return err;
 }
 
-static void iommu_disable(struct iommu *obj)
+static void iommu_disable(struct omap_iommu *obj)
 {
 	if (!obj)
 		return;
@@ -146,13 +146,13 @@ static void iommu_disable(struct iommu *obj)
 /*
  *	TLB operations
  */
-void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
+void omap_iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
 {
 	BUG_ON(!cr || !e);
 
 	arch_iommu->cr_to_e(cr, e);
 }
-EXPORT_SYMBOL_GPL(iotlb_cr_to_e);
+EXPORT_SYMBOL_GPL(omap_iotlb_cr_to_e);
 
 static inline int iotlb_cr_valid(struct cr_regs *cr)
 {
@@ -162,7 +162,7 @@ static inline int iotlb_cr_valid(struct cr_regs *cr)
 	return arch_iommu->cr_valid(cr);
 }
 
-static inline struct cr_regs *iotlb_alloc_cr(struct iommu *obj,
+static inline struct cr_regs *iotlb_alloc_cr(struct omap_iommu *obj,
 					     struct iotlb_entry *e)
 {
 	if (!e)
@@ -181,12 +181,12 @@ static u32 get_iopte_attr(struct iotlb_entry *e)
 	return arch_iommu->get_pte_attr(e);
 }
 
-static u32 iommu_report_fault(struct iommu *obj, u32 *da)
+static u32 iommu_report_fault(struct omap_iommu *obj, u32 *da)
 {
 	return arch_iommu->fault_isr(obj, da);
 }
 
-static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
+static void iotlb_lock_get(struct omap_iommu *obj, struct iotlb_lock *l)
 {
 	u32 val;
 
@@ -197,7 +197,7 @@ static void iotlb_lock_get(struct iommu *obj, struct iotlb_lock *l)
 
 }
 
-static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
+static void iotlb_lock_set(struct omap_iommu *obj, struct iotlb_lock *l)
 {
 	u32 val;
 
@@ -207,12 +207,12 @@ static void iotlb_lock_set(struct iommu *obj, struct iotlb_lock *l)
 	iommu_write_reg(obj, val, MMU_LOCK);
 }
 
-static void iotlb_read_cr(struct iommu *obj, struct cr_regs *cr)
+static void iotlb_read_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
 	arch_iommu->tlb_read_cr(obj, cr);
 }
 
-static void iotlb_load_cr(struct iommu *obj, struct cr_regs *cr)
+static void iotlb_load_cr(struct omap_iommu *obj, struct cr_regs *cr)
 {
 	arch_iommu->tlb_load_cr(obj, cr);
 
@@ -226,7 +226,7 @@ static void iotlb_load_cr(struct iommu *obj, struct cr_regs *cr)
  * @cr:		contents of cam and ram register
  * @buf:	output buffer
  **/
-static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
+static inline ssize_t iotlb_dump_cr(struct omap_iommu *obj, struct cr_regs *cr,
 				    char *buf)
 {
 	BUG_ON(!cr || !buf);
@@ -235,7 +235,7 @@ static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
 }
 
 /* only used in iotlb iteration for-loop */
-static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
+static struct cr_regs __iotlb_read_cr(struct omap_iommu *obj, int n)
 {
 	struct cr_regs cr;
 	struct iotlb_lock l;
@@ -254,7 +254,7 @@ static struct cr_regs __iotlb_read_cr(struct iommu *obj, int n)
  * @e:		an iommu tlb entry info
  **/
 #ifdef PREFETCH_IOTLB
-static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	int err = 0;
 	struct iotlb_lock l;
@@ -313,14 +313,14 @@ out:
 
 #else /* !PREFETCH_IOTLB */
 
-static int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+static int load_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	return 0;
 }
 
 #endif /* !PREFETCH_IOTLB */
 
-static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
+static int prefetch_iotlb_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	return load_iotlb_entry(obj, e);
 }
@@ -332,7 +332,7 @@ static int prefetch_iotlb_entry(struct iommu *obj, struct iotlb_entry *e)
  *
  * Clear an iommu tlb entry which includes 'da' address.
  **/
-static void flush_iotlb_page(struct iommu *obj, u32 da)
+static void flush_iotlb_page(struct omap_iommu *obj, u32 da)
 {
 	int i;
 	struct cr_regs cr;
@@ -366,7 +366,7 @@ static void flush_iotlb_page(struct iommu *obj, u32 da)
  * flush_iotlb_all - Clear all iommu tlb entries
  * @obj:	target iommu
  **/
-static void flush_iotlb_all(struct iommu *obj)
+static void flush_iotlb_all(struct omap_iommu *obj)
 {
 	struct iotlb_lock l;
 
@@ -383,7 +383,7 @@ static void flush_iotlb_all(struct iommu *obj)
 
 #if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
 
-ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
+ssize_t omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t bytes)
 {
 	if (!obj || !buf)
 		return -EINVAL;
@@ -396,9 +396,10 @@ ssize_t iommu_dump_ctx(struct iommu *obj, char *buf, ssize_t bytes)
 
 	return bytes;
 }
-EXPORT_SYMBOL_GPL(iommu_dump_ctx);
+EXPORT_SYMBOL_GPL(omap_iommu_dump_ctx);
 
-static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
+static int
+__dump_tlb_entries(struct omap_iommu *obj, struct cr_regs *crs, int num)
 {
 	int i;
 	struct iotlb_lock saved;
@@ -421,11 +422,11 @@ static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs, int num)
 }
 
 /**
- * dump_tlb_entries - dump cr arrays to given buffer
+ * omap_dump_tlb_entries - dump cr arrays to given buffer
  * @obj:	target iommu
  * @buf:	output buffer
  **/
-size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t bytes)
+size_t omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t bytes)
 {
 	int i, num;
 	struct cr_regs *cr;
@@ -445,14 +446,14 @@ size_t dump_tlb_entries(struct iommu *obj, char *buf, ssize_t bytes)
 
 	return p - buf;
 }
-EXPORT_SYMBOL_GPL(dump_tlb_entries);
+EXPORT_SYMBOL_GPL(omap_dump_tlb_entries);
 
-int foreach_iommu_device(void *data, int (*fn)(struct device *, void *))
+int omap_foreach_iommu_device(void *data, int (*fn)(struct device *, void *))
 {
 	return driver_for_each_device(&omap_iommu_driver.driver,
 				      NULL, data, fn);
 }
-EXPORT_SYMBOL_GPL(foreach_iommu_device);
+EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
 
 #endif /* CONFIG_OMAP_IOMMU_DEBUG_MODULE */
 
@@ -485,7 +486,7 @@ static void iopte_free(u32 *iopte)
 	kmem_cache_free(iopte_cachep, iopte);
 }
 
-static u32 *iopte_alloc(struct iommu *obj, u32 *iopgd, u32 da)
+static u32 *iopte_alloc(struct omap_iommu *obj, u32 *iopgd, u32 da)
 {
 	u32 *iopte;
 
@@ -523,7 +524,7 @@ pte_ready:
 	return iopte;
 }
 
-static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopgd_alloc_section(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 
@@ -538,7 +539,7 @@ static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopgd_alloc_super(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 	int i;
@@ -555,7 +556,7 @@ static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopte_alloc_page(struct iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopte_alloc_page(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 	u32 *iopte = iopte_alloc(obj, iopgd, da);
@@ -572,7 +573,7 @@ static int iopte_alloc_page(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
+static int iopte_alloc_large(struct omap_iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 	u32 *iopte = iopte_alloc(obj, iopgd, da);
@@ -593,9 +594,10 @@ static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	return 0;
 }
 
-static int iopgtable_store_entry_core(struct iommu *obj, struct iotlb_entry *e)
+static int
+iopgtable_store_entry_core(struct omap_iommu *obj, struct iotlb_entry *e)
 {
-	int (*fn)(struct iommu *, u32, u32, u32);
+	int (*fn)(struct omap_iommu *, u32, u32, u32);
 	u32 prot;
 	int err;
 
@@ -631,11 +633,11 @@ static int iopgtable_store_entry_core(struct iommu *obj, struct iotlb_entry *e)
 }
 
 /**
- * iopgtable_store_entry - Make an iommu pte entry
+ * omap_iopgtable_store_entry - Make an iommu pte entry
  * @obj:	target iommu
  * @e:		an iommu tlb entry info
  **/
-int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
+int omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e)
 {
 	int err;
 
@@ -645,7 +647,7 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 		prefetch_iotlb_entry(obj, e);
 	return err;
 }
-EXPORT_SYMBOL_GPL(iopgtable_store_entry);
+EXPORT_SYMBOL_GPL(omap_iopgtable_store_entry);
 
 /**
  * iopgtable_lookup_entry - Lookup an iommu pte entry
@@ -670,7 +672,7 @@ out:
 	*ppte = iopte;
 }
 
-static size_t iopgtable_clear_entry_core(struct iommu *obj, u32 da)
+static size_t iopgtable_clear_entry_core(struct omap_iommu *obj, u32 da)
 {
 	size_t bytes;
 	u32 *iopgd = iopgd_offset(obj, da);
@@ -723,7 +725,7 @@ out:
  * @obj:	target iommu
  * @da:		iommu device virtual address
  **/
-static size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
+static size_t iopgtable_clear_entry(struct omap_iommu *obj, u32 da)
 {
 	size_t bytes;
 
@@ -737,7 +739,7 @@ static size_t iopgtable_clear_entry(struct iommu *obj, u32 da)
 	return bytes;
 }
 
-static void iopgtable_clear_entry_all(struct iommu *obj)
+static void iopgtable_clear_entry_all(struct omap_iommu *obj)
 {
 	int i;
 
@@ -772,7 +774,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 {
 	u32 da, errs;
 	u32 *iopgd, *iopte;
-	struct iommu *obj = data;
+	struct omap_iommu *obj = data;
 
 	if (!obj->refcount)
 		return IRQ_NONE;
@@ -808,7 +810,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 
 static int device_match_by_alias(struct device *dev, void *data)
 {
-	struct iommu *obj = to_iommu(dev);
+	struct omap_iommu *obj = to_iommu(dev);
 	const char *name = data;
 
 	pr_debug("%s: %s %s\n", __func__, obj->name, name);
@@ -842,10 +844,10 @@ EXPORT_SYMBOL_GPL(omap_find_iommu_device);
  * @dev:	target omap iommu device
  * @iopgd:	page table
  **/
-static struct iommu *omap_iommu_attach(struct device *dev, u32 *iopgd)
+static struct omap_iommu *omap_iommu_attach(struct device *dev, u32 *iopgd)
 {
 	int err = -ENOMEM;
-	struct iommu *obj = to_iommu(dev);
+	struct omap_iommu *obj = to_iommu(dev);
 
 	spin_lock(&obj->iommu_lock);
 
@@ -883,7 +885,7 @@ err_enable:
  * omap_iommu_detach - release iommu device
  * @obj:	target iommu
  **/
-static void omap_iommu_detach(struct iommu *obj)
+static void omap_iommu_detach(struct omap_iommu *obj)
 {
 	if (!obj || IS_ERR(obj))
 		return;
@@ -902,13 +904,13 @@ static void omap_iommu_detach(struct iommu *obj)
 	dev_dbg(obj->dev, "%s: %s\n", __func__, obj->name);
 }
 
-int iommu_set_isr(const char *name,
-		  int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
+int omap_iommu_set_isr(const char *name,
+		  int (*isr)(struct omap_iommu *obj, u32 da, u32 iommu_errs,
 			     void *priv),
 		  void *isr_priv)
 {
 	struct device *dev;
-	struct iommu *obj;
+	struct omap_iommu *obj;
 
 	dev = driver_find_device(&omap_iommu_driver.driver, NULL, (void *)name,
 				 device_match_by_alias);
@@ -927,7 +929,7 @@ int iommu_set_isr(const char *name,
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(iommu_set_isr);
+EXPORT_SYMBOL_GPL(omap_iommu_set_isr);
 
 /*
  *	OMAP Device MMU(IOMMU) detection
@@ -936,7 +938,7 @@ static int __devinit omap_iommu_probe(struct platform_device *pdev)
 {
 	int err = -ENODEV;
 	int irq;
-	struct iommu *obj;
+	struct omap_iommu *obj;
 	struct resource *res;
 	struct iommu_platform_data *pdata = pdev->dev.platform_data;
 
@@ -1011,7 +1013,7 @@ static int __devexit omap_iommu_remove(struct platform_device *pdev)
 {
 	int irq;
 	struct resource *res;
-	struct iommu *obj = platform_get_drvdata(pdev);
+	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
 	platform_set_drvdata(pdev, NULL);
 
@@ -1046,7 +1048,7 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 			 phys_addr_t pa, int order, int prot)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct omap_iommu *oiommu = omap_domain->iommu_dev;
 	struct device *dev = oiommu->dev;
 	size_t bytes = PAGE_SIZE << order;
 	struct iotlb_entry e;
@@ -1066,9 +1068,9 @@ static int omap_iommu_map(struct iommu_domain *domain, unsigned long da,
 
 	iotlb_init_entry(&e, da, pa, flags);
 
-	ret = iopgtable_store_entry(oiommu, &e);
+	ret = omap_iopgtable_store_entry(oiommu, &e);
 	if (ret) {
-		dev_err(dev, "iopgtable_store_entry failed: %d\n", ret);
+		dev_err(dev, "omap_iopgtable_store_entry failed: %d\n", ret);
 		return ret;
 	}
 
@@ -1079,7 +1081,7 @@ static int omap_iommu_unmap(struct iommu_domain *domain, unsigned long da,
 			    int order)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct omap_iommu *oiommu = omap_domain->iommu_dev;
 	struct device *dev = oiommu->dev;
 	size_t bytes = PAGE_SIZE << order;
 	size_t ret;
@@ -1099,7 +1101,7 @@ static int
 omap_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct iommu *oiommu;
+	struct omap_iommu *oiommu;
 	int ret = 0;
 
 	spin_lock(&omap_domain->lock);
@@ -1130,7 +1132,7 @@ static void omap_iommu_detach_dev(struct iommu_domain *domain,
 				 struct device *dev)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct iommu *oiommu = to_iommu(dev);
+	struct omap_iommu *oiommu = to_iommu(dev);
 
 	spin_lock(&omap_domain->lock);
 
@@ -1200,7 +1202,7 @@ static phys_addr_t omap_iommu_iova_to_phys(struct iommu_domain *domain,
 					  unsigned long da)
 {
 	struct omap_iommu_domain *omap_domain = domain->priv;
-	struct iommu *oiommu = omap_domain->iommu_dev;
+	struct omap_iommu *oiommu = omap_domain->iommu_dev;
 	struct device *dev = oiommu->dev;
 	u32 *pgd, *pte;
 	phys_addr_t ret = 0;
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 996bec0..5e7f97d 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -191,7 +191,8 @@ static inline void vunmap_sg(const void *va)
 	vunmap(va);
 }
 
-static struct iovm_struct *__find_iovm_area(struct iommu *obj, const u32 da)
+static struct iovm_struct *__find_iovm_area(struct omap_iommu *obj,
+							const u32 da)
 {
 	struct iovm_struct *tmp;
 
@@ -213,12 +214,12 @@ static struct iovm_struct *__find_iovm_area(struct iommu *obj, const u32 da)
 }
 
 /**
- * find_iovm_area  -  find iovma which includes @da
+ * omap_find_iovm_area  -  find iovma which includes @da
  * @da:		iommu device virtual address
  *
  * Find the existing iovma starting at @da
  */
-struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da)
+struct iovm_struct *omap_find_iovm_area(struct omap_iommu *obj, u32 da)
 {
 	struct iovm_struct *area;
 
@@ -228,13 +229,13 @@ struct iovm_struct *find_iovm_area(struct iommu *obj, u32 da)
 
 	return area;
 }
-EXPORT_SYMBOL_GPL(find_iovm_area);
+EXPORT_SYMBOL_GPL(omap_find_iovm_area);
 
 /*
  * This finds the hole(area) which fits the requested address and len
  * in iovmas mmap, and returns the new allocated iovma.
  */
-static struct iovm_struct *alloc_iovm_area(struct iommu *obj, u32 da,
+static struct iovm_struct *alloc_iovm_area(struct omap_iommu *obj, u32 da,
 					   size_t bytes, u32 flags)
 {
 	struct iovm_struct *new, *tmp;
@@ -309,7 +310,7 @@ found:
 	return new;
 }
 
-static void free_iovm_area(struct iommu *obj, struct iovm_struct *area)
+static void free_iovm_area(struct omap_iommu *obj, struct iovm_struct *area)
 {
 	size_t bytes;
 
@@ -325,14 +326,14 @@ static void free_iovm_area(struct iommu *obj, struct iovm_struct *area)
 }
 
 /**
- * da_to_va - convert (d) to (v)
+ * omap_da_to_va - convert (d) to (v)
  * @obj:	objective iommu
  * @da:		iommu device virtual address
  * @va:		mpu virtual address
  *
  * Returns mpu virtual addr which corresponds to a given device virtual addr
  */
-void *da_to_va(struct iommu *obj, u32 da)
+void *omap_da_to_va(struct omap_iommu *obj, u32 da)
 {
 	void *va = NULL;
 	struct iovm_struct *area;
@@ -350,7 +351,7 @@ out:
 
 	return va;
 }
-EXPORT_SYMBOL_GPL(da_to_va);
+EXPORT_SYMBOL_GPL(omap_da_to_va);
 
 static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 {
@@ -364,7 +365,7 @@ static void sgtable_fill_vmalloc(struct sg_table *sgt, void *_va)
 		const size_t bytes = PAGE_SIZE;
 
 		/*
-		 * iommu 'superpage' isn't supported with 'iommu_vmalloc()'
+		 * iommu 'superpage' isn't supported with 'omap_iommu_vmalloc()'
 		 */
 		pg = vmalloc_to_page(va);
 		BUG_ON(!pg);
@@ -443,7 +444,7 @@ err_out:
 }
 
 /* release 'da' <-> 'pa' mapping */
-static void unmap_iovm_area(struct iommu_domain *domain, struct iommu *obj,
+static void unmap_iovm_area(struct iommu_domain *domain, struct omap_iommu *obj,
 						struct iovm_struct *area)
 {
 	u32 start;
@@ -480,7 +481,7 @@ static void unmap_iovm_area(struct iommu_domain *domain, struct iommu *obj,
 
 /* template function for all unmapping */
 static struct sg_table *unmap_vm_area(struct iommu_domain *domain,
-				      struct iommu *obj, const u32 da,
+				      struct omap_iommu *obj, const u32 da,
 				      void (*fn)(const void *), u32 flags)
 {
 	struct sg_table *sgt = NULL;
@@ -521,7 +522,7 @@ out:
 	return sgt;
 }
 
-static u32 map_iommu_region(struct iommu_domain *domain, struct iommu *obj,
+static u32 map_iommu_region(struct iommu_domain *domain, struct omap_iommu *obj,
 				u32 da, const struct sg_table *sgt, void *va,
 				size_t bytes, u32 flags)
 {
@@ -555,7 +556,8 @@ err_alloc_iovma:
 	return err;
 }
 
-static inline u32 __iommu_vmap(struct iommu_domain *domain, struct iommu *obj,
+static inline u32
+__iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj,
 				u32 da, const struct sg_table *sgt,
 				void *va, size_t bytes, u32 flags)
 {
@@ -563,7 +565,7 @@ static inline u32 __iommu_vmap(struct iommu_domain *domain, struct iommu *obj,
 }
 
 /**
- * iommu_vmap  -  (d)-(p)-(v) address mapper
+ * omap_iommu_vmap  -  (d)-(p)-(v) address mapper
  * @obj:	objective iommu
  * @sgt:	address of scatter gather table
  * @flags:	iovma and page property
@@ -571,7 +573,7 @@ static inline u32 __iommu_vmap(struct iommu_domain *domain, struct iommu *obj,
  * Creates 1-n-1 mapping with given @sgt and returns @da.
  * All @sgt element must be io page size aligned.
  */
-u32 iommu_vmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
+u32 omap_iommu_vmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da,
 		const struct sg_table *sgt, u32 flags)
 {
 	size_t bytes;
@@ -600,22 +602,22 @@ u32 iommu_vmap(struct iommu_domain *domain, struct iommu *obj, u32 da,
 
 	return da;
 }
-EXPORT_SYMBOL_GPL(iommu_vmap);
+EXPORT_SYMBOL_GPL(omap_iommu_vmap);
 
 /**
- * iommu_vunmap  -  release virtual mapping obtained by 'iommu_vmap()'
+ * omap_iommu_vunmap  -  release virtual mapping obtained by 'omap_iommu_vmap()'
  * @obj:	objective iommu
  * @da:		iommu device virtual address
  *
  * Free the iommu virtually contiguous memory area starting at
- * @da, which was returned by 'iommu_vmap()'.
+ * @da, which was returned by 'omap_iommu_vmap()'.
  */
 struct sg_table *
-iommu_vunmap(struct iommu_domain *domain, struct iommu *obj, u32 da)
+omap_iommu_vunmap(struct iommu_domain *domain, struct omap_iommu *obj, u32 da)
 {
 	struct sg_table *sgt;
 	/*
-	 * 'sgt' is allocated before 'iommu_vmalloc()' is called.
+	 * 'sgt' is allocated before 'omap_iommu_vmalloc()' is called.
 	 * Just returns 'sgt' to the caller to free
 	 */
 	sgt = unmap_vm_area(domain, obj, da, vunmap_sg,
@@ -624,10 +626,10 @@ iommu_vunmap(struct iommu_domain *domain, struct iommu *obj, u32 da)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
 	return sgt;
 }
-EXPORT_SYMBOL_GPL(iommu_vunmap);
+EXPORT_SYMBOL_GPL(omap_iommu_vunmap);
 
 /**
- * iommu_vmalloc  -  (d)-(p)-(v) address allocator and mapper
+ * omap_iommu_vmalloc  -  (d)-(p)-(v) address allocator and mapper
  * @obj:	objective iommu
  * @da:		contiguous iommu virtual memory
  * @bytes:	allocation size
@@ -636,7 +638,8 @@ EXPORT_SYMBOL_GPL(iommu_vunmap);
  * Allocate @bytes linearly and creates 1-n-1 mapping and returns
  * @da again, which might be adjusted if 'IOVMF_DA_FIXED' is not set.
  */
-u32 iommu_vmalloc(struct iommu_domain *domain, struct iommu *obj, u32 da,
+u32
+omap_iommu_vmalloc(struct iommu_domain *domain, struct omap_iommu *obj, u32 da,
 						size_t bytes, u32 flags)
 {
 	void *va;
@@ -674,17 +677,18 @@ err_sgt_alloc:
 	vfree(va);
 	return da;
 }
-EXPORT_SYMBOL_GPL(iommu_vmalloc);
+EXPORT_SYMBOL_GPL(omap_iommu_vmalloc);
 
 /**
- * iommu_vfree  -  release memory allocated by 'iommu_vmalloc()'
+ * omap_iommu_vfree  -  release memory allocated by 'omap_iommu_vmalloc()'
  * @obj:	objective iommu
  * @da:		iommu device virtual address
  *
  * Frees the iommu virtually continuous memory area starting at
- * @da, as obtained from 'iommu_vmalloc()'.
+ * @da, as obtained from 'omap_iommu_vmalloc()'.
  */
-void iommu_vfree(struct iommu_domain *domain, struct iommu *obj, const u32 da)
+void omap_iommu_vfree(struct iommu_domain *domain, struct omap_iommu *obj,
+								const u32 da)
 {
 	struct sg_table *sgt;
 
@@ -694,7 +698,7 @@ void iommu_vfree(struct iommu_domain *domain, struct iommu *obj, const u32 da)
 		dev_dbg(obj->dev, "%s: No sgt\n", __func__);
 	sgtable_free(sgt);
 }
-EXPORT_SYMBOL_GPL(iommu_vfree);
+EXPORT_SYMBOL_GPL(omap_iommu_vfree);
 
 static int __init iovmm_init(void)
 {
diff --git a/drivers/media/video/omap3isp/isp.c b/drivers/media/video/omap3isp/isp.c
index 0db45ac..a4baa61 100644
--- a/drivers/media/video/omap3isp/isp.c
+++ b/drivers/media/video/omap3isp/isp.c
@@ -85,7 +85,7 @@
  * any omap-specific iommu API
  */
 #define to_iommu(dev)							\
-	(struct iommu *)platform_get_drvdata(to_platform_device(dev))
+	(struct omap_iommu *)platform_get_drvdata(to_platform_device(dev))
 
 static unsigned int autoidle;
 module_param(autoidle, int, 0444);
@@ -1115,7 +1115,7 @@ static void isp_save_ctx(struct isp_device *isp)
 {
 	isp_save_context(isp, isp_reg_list);
 	if (isp->iommu)
-		iommu_save_ctx(isp->iommu);
+		omap_iommu_save_ctx(isp->iommu);
 }
 
 /*
@@ -1129,7 +1129,7 @@ static void isp_restore_ctx(struct isp_device *isp)
 {
 	isp_restore_context(isp, isp_reg_list);
 	if (isp->iommu)
-		iommu_restore_ctx(isp->iommu);
+		omap_iommu_restore_ctx(isp->iommu);
 	omap3isp_ccdc_restore_context(isp);
 	omap3isp_preview_restore_context(isp);
 }
diff --git a/drivers/media/video/omap3isp/isp.h b/drivers/media/video/omap3isp/isp.h
index c9ec7a2..81fdd85 100644
--- a/drivers/media/video/omap3isp/isp.h
+++ b/drivers/media/video/omap3isp/isp.h
@@ -295,7 +295,7 @@ struct isp_device {
 	unsigned int sbl_resources;
 	unsigned int subclk_resources;
 
-	struct iommu *iommu;
+	struct omap_iommu *iommu;
 	struct iommu_domain *domain;
 	struct device *iommu_dev;
 
diff --git a/drivers/media/video/omap3isp/ispccdc.c b/drivers/media/video/omap3isp/ispccdc.c
index de25474..9891dde 100644
--- a/drivers/media/video/omap3isp/ispccdc.c
+++ b/drivers/media/video/omap3isp/ispccdc.c
@@ -365,7 +365,7 @@ static void ccdc_lsc_free_request(struct isp_ccdc_device *ccdc,
 		dma_unmap_sg(isp->dev, req->iovm->sgt->sgl,
 			     req->iovm->sgt->nents, DMA_TO_DEVICE);
 	if (req->table)
-		iommu_vfree(isp->domain, isp->iommu, req->table);
+		omap_iommu_vfree(isp->domain, isp->iommu, req->table);
 	kfree(req);
 }
 
@@ -437,7 +437,7 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 
 		req->enable = 1;
 
-		req->table = iommu_vmalloc(isp->domain, isp->iommu, 0,
+		req->table = omap_iommu_vmalloc(isp->domain, isp->iommu, 0,
 					req->config.size, IOMMU_FLAG);
 		if (IS_ERR_VALUE(req->table)) {
 			req->table = 0;
@@ -445,7 +445,7 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 			goto done;
 		}
 
-		req->iovm = find_iovm_area(isp->iommu, req->table);
+		req->iovm = omap_find_iovm_area(isp->iommu, req->table);
 		if (req->iovm == NULL) {
 			ret = -ENOMEM;
 			goto done;
@@ -461,7 +461,7 @@ static int ccdc_lsc_config(struct isp_ccdc_device *ccdc,
 		dma_sync_sg_for_cpu(isp->dev, req->iovm->sgt->sgl,
 				    req->iovm->sgt->nents, DMA_TO_DEVICE);
 
-		table = da_to_va(isp->iommu, req->table);
+		table = omap_da_to_va(isp->iommu, req->table);
 		if (copy_from_user(table, config->lsc, req->config.size)) {
 			ret = -EFAULT;
 			goto done;
@@ -730,18 +730,19 @@ static int ccdc_config(struct isp_ccdc_device *ccdc,
 
 			/*
 			 * table_new must be 64-bytes aligned, but it's
-			 * already done by iommu_vmalloc().
+			 * already done by omap_iommu_vmalloc().
 			 */
 			size = ccdc->fpc.fpnum * 4;
-			table_new = iommu_vmalloc(isp->domain, isp->iommu, 0,
-							size, IOMMU_FLAG);
+			table_new = omap_iommu_vmalloc(isp->domain, isp->iommu,
+							0, size, IOMMU_FLAG);
 			if (IS_ERR_VALUE(table_new))
 				return -ENOMEM;
 
-			if (copy_from_user(da_to_va(isp->iommu, table_new),
+			if (copy_from_user(omap_da_to_va(isp->iommu, table_new),
 					   (__force void __user *)
 					   ccdc->fpc.fpcaddr, size)) {
-				iommu_vfree(isp->domain, isp->iommu, table_new);
+				omap_iommu_vfree(isp->domain, isp->iommu,
+								table_new);
 				return -EFAULT;
 			}
 
@@ -751,7 +752,7 @@ static int ccdc_config(struct isp_ccdc_device *ccdc,
 
 		ccdc_configure_fpc(ccdc);
 		if (table_old != 0)
-			iommu_vfree(isp->domain, isp->iommu, table_old);
+			omap_iommu_vfree(isp->domain, isp->iommu, table_old);
 	}
 
 	return ccdc_lsc_config(ccdc, ccdc_struct);
@@ -2286,5 +2287,5 @@ void omap3isp_ccdc_cleanup(struct isp_device *isp)
 	ccdc_lsc_free_queue(ccdc, &ccdc->lsc.free_queue);
 
 	if (ccdc->fpc.fpcaddr != 0)
-		iommu_vfree(isp->domain, isp->iommu, ccdc->fpc.fpcaddr);
+		omap_iommu_vfree(isp->domain, isp->iommu, ccdc->fpc.fpcaddr);
 }
diff --git a/drivers/media/video/omap3isp/ispstat.c b/drivers/media/video/omap3isp/ispstat.c
index 98af736..7329055 100644
--- a/drivers/media/video/omap3isp/ispstat.c
+++ b/drivers/media/video/omap3isp/ispstat.c
@@ -366,7 +366,8 @@ static void isp_stat_bufs_free(struct ispstat *stat)
 				dma_unmap_sg(isp->dev, buf->iovm->sgt->sgl,
 					     buf->iovm->sgt->nents,
 					     DMA_FROM_DEVICE);
-			iommu_vfree(isp->domain, isp->iommu, buf->iommu_addr);
+			omap_iommu_vfree(isp->domain, isp->iommu,
+							buf->iommu_addr);
 		} else {
 			if (!buf->virt_addr)
 				continue;
@@ -399,7 +400,7 @@ static int isp_stat_bufs_alloc_iommu(struct ispstat *stat, unsigned int size)
 		struct iovm_struct *iovm;
 
 		WARN_ON(buf->dma_addr);
-		buf->iommu_addr = iommu_vmalloc(isp->domain, isp->iommu, 0,
+		buf->iommu_addr = omap_iommu_vmalloc(isp->domain, isp->iommu, 0,
 							size, IOMMU_FLAG);
 		if (IS_ERR((void *)buf->iommu_addr)) {
 			dev_err(stat->isp->dev,
@@ -409,7 +410,7 @@ static int isp_stat_bufs_alloc_iommu(struct ispstat *stat, unsigned int size)
 			return -ENOMEM;
 		}
 
-		iovm = find_iovm_area(isp->iommu, buf->iommu_addr);
+		iovm = omap_find_iovm_area(isp->iommu, buf->iommu_addr);
 		if (!iovm ||
 		    !dma_map_sg(isp->dev, iovm->sgt->sgl, iovm->sgt->nents,
 				DMA_FROM_DEVICE)) {
@@ -418,7 +419,7 @@ static int isp_stat_bufs_alloc_iommu(struct ispstat *stat, unsigned int size)
 		}
 		buf->iovm = iovm;
 
-		buf->virt_addr = da_to_va(stat->isp->iommu,
+		buf->virt_addr = omap_da_to_va(stat->isp->iommu,
 					  (u32)buf->iommu_addr);
 		buf->empty = 1;
 		dev_dbg(stat->isp->dev, "%s: buffer[%d] allocated."
diff --git a/drivers/media/video/omap3isp/ispvideo.c b/drivers/media/video/omap3isp/ispvideo.c
index 023b502..912ac07 100644
--- a/drivers/media/video/omap3isp/ispvideo.c
+++ b/drivers/media/video/omap3isp/ispvideo.c
@@ -446,7 +446,7 @@ ispmmu_vmap(struct isp_device *isp, const struct scatterlist *sglist, int sglen)
 	sgt->nents = sglen;
 	sgt->orig_nents = sglen;
 
-	da = iommu_vmap(isp->domain, isp->iommu, 0, sgt, IOMMU_FLAG);
+	da = omap_iommu_vmap(isp->domain, isp->iommu, 0, sgt, IOMMU_FLAG);
 	if (IS_ERR_VALUE(da))
 		kfree(sgt);
 
@@ -462,7 +462,7 @@ static void ispmmu_vunmap(struct isp_device *isp, dma_addr_t da)
 {
 	struct sg_table *sgt;
 
-	sgt = iommu_vunmap(isp->domain, isp->iommu, (u32)da);
+	sgt = omap_iommu_vunmap(isp->domain, isp->iommu, (u32)da);
 	kfree(sgt);
 }
 
-- 
1.7.4.1

