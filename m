From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/1] omap iommu: add initial debugfs support
Date: Wed, 22 Jul 2009 17:24:02 +0300
Message-ID: <1248272642-5200-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48565 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbZGVOYj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jul 2009 10:24:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ameya.palande@nokia.com, h-kanigeri2@ti.com, x0095840@ti.com, omar.ramirez@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This enables to peek the following data.

$ /debug/iommu/isp# ls
mem             nr_tlb_entries  regs
mmap            pagetable       tlb
$ /debug/iommu/isp# head pagetable
L:      da:      pa:
-----------------------------------------
2: 00001000 8ae4a002
2: 00002000 8e7bb002
2: 00003000 8ae49002
2: 00004000 8ae65002
.....

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/iommu.h |   11 +-
 arch/arm/plat-omap/iommu-debug.c        |  334 +++++++++++++++++++++++++++++++
 arch/arm/plat-omap/iommu.c              |  140 +++++++++-----
 3 files changed, 433 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/plat-omap/iommu-debug.c

diff --git a/arch/arm/plat-omap/include/mach/iommu.h b/arch/arm/plat-omap/include/mach/iommu.h
index ef04d7a..ac42b59 100644
--- a/arch/arm/plat-omap/include/mach/iommu.h
+++ b/arch/arm/plat-omap/include/mach/iommu.h
@@ -135,13 +135,14 @@ struct iommu_platform_data {
  */
 extern u32 iommu_arch_version(void);
 
+extern void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e);
+extern u32 iotlb_cr_to_virt(struct cr_regs *cr);
+
 extern int load_iotlb_entry(struct iommu *obj, struct iotlb_entry *e);
 extern void flush_iotlb_page(struct iommu *obj, u32 da);
 extern void flush_iotlb_range(struct iommu *obj, u32 start, u32 end);
 extern void flush_iotlb_all(struct iommu *obj);
 
-ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf);
-
 extern int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e);
 extern size_t iopgtable_clear_entry(struct iommu *obj, u32 iova);
 
@@ -154,4 +155,10 @@ extern void iommu_restore_ctx(struct iommu *obj);
 extern int install_iommu_arch(const struct iommu_functions *ops);
 extern void uninstall_iommu_arch(const struct iommu_functions *ops);
 
+extern int foreach_iommu_device(void *data,
+				int (*fn)(struct device *, void *));
+
+extern ssize_t iommu_dump_ctx(struct iommu *obj, char *buf);
+extern size_t dump_tlb_entries(struct iommu *obj, char *buf);
+
 #endif /* __MACH_IOMMU_H */
diff --git a/arch/arm/plat-omap/iommu-debug.c b/arch/arm/plat-omap/iommu-debug.c
new file mode 100644
index 0000000..9811c19
--- /dev/null
+++ b/arch/arm/plat-omap/iommu-debug.c
@@ -0,0 +1,334 @@
+/*
+ * omap iommu: debugfs interface
+ *
+ * Copyright (C) 2008-2009 Nokia Corporation
+ *
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/err.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
+#include <linux/platform_device.h>
+#include <linux/debugfs.h>
+
+#include <mach/iommu.h>
+#include <mach/iovmm.h>
+
+#include "iopgtable.h"
+
+#define MAXCOLUMN 100 /* for short messages */
+
+static DEFINE_MUTEX(iommu_debug_lock);
+static char local_buffer[SZ_4K];
+
+static struct dentry *iommu_debug_root;
+
+static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	u32 ver = iommu_arch_version();
+	char buf[MAXCOLUMN], *p = buf;
+
+	p += sprintf(p, "H/W version: %d.%d\n", (ver >> 4) & 0xf , ver & 0xf);
+
+	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+}
+
+static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct iommu *obj = file->private_data;
+	char *p = local_buffer;
+	ssize_t bytes;
+
+	mutex_lock(&iommu_debug_lock);
+	p += iommu_dump_ctx(obj, p);
+	bytes = simple_read_from_buffer(userbuf, count, ppos, local_buffer,
+					p - local_buffer);
+	mutex_unlock(&iommu_debug_lock);
+	return bytes;
+}
+
+static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	struct iommu *obj = file->private_data;
+	char *p = local_buffer;
+	ssize_t bytes;
+
+	mutex_lock(&iommu_debug_lock);
+	p += sprintf(p, "%8s %8s\n", "cam:", "ram:");
+	p += sprintf(p, "-----------------------------------------\n");
+	p += dump_tlb_entries(obj, p);
+	bytes = simple_read_from_buffer(userbuf, count, ppos, local_buffer,
+					p - local_buffer);
+	mutex_unlock(&iommu_debug_lock);
+	return bytes;
+}
+
+static ssize_t debug_write_pagetable(struct file *file,
+		     const char __user *userbuf, size_t count, loff_t *ppos)
+{
+	struct iotlb_entry e;
+	struct cr_regs cr;
+	int err;
+	struct iommu *obj = file->private_data;
+	char buf[MAXCOLUMN], *p = buf;
+
+	count = min(count, sizeof(buf));
+
+	mutex_lock(&iommu_debug_lock);
+	if (copy_from_user(p, userbuf, count)) {
+		mutex_unlock(&iommu_debug_lock);
+		return -EFAULT;
+	}
+
+	sscanf(p, "%x %x", &cr.cam, &cr.ram);
+	if (!cr.cam || !cr.ram) {
+		mutex_unlock(&iommu_debug_lock);
+		return -EINVAL;
+	}
+
+	iotlb_cr_to_e(&cr, &e);
+	err = iopgtable_store_entry(obj, &e);
+	if (err)
+		dev_err(obj->dev, "%s: fail to store cr\n", __func__);
+
+	mutex_unlock(&iommu_debug_lock);
+	return count;
+}
+
+static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
+				    size_t count, loff_t *ppos)
+{
+	int i;
+	u32 *iopgd;
+	struct iommu *obj = file->private_data;
+	char *p = local_buffer;
+	ssize_t bytes;
+
+	mutex_lock(&iommu_debug_lock);
+
+	p += sprintf(p, "L: %8s %8s\n", "da:", "pa:");
+	p += sprintf(p, "-----------------------------------------\n");
+
+	spin_lock(&obj->page_table_lock);
+
+	iopgd = iopgd_offset(obj, 0);
+	for (i = 0; i < PTRS_PER_IOPGD; i++, iopgd++) {
+		int j;
+		u32 *iopte;
+
+		if (!*iopgd)
+			continue;
+
+		if (!(*iopgd & IOPGD_TABLE)) {
+			u32 da;
+
+			da = i << IOPGD_SHIFT;
+			p += sprintf(p, "1: %08x %08x\n", da, *iopgd);
+			continue;
+		}
+
+		iopte = iopte_offset(iopgd, 0);
+
+		for (j = 0; j < PTRS_PER_IOPTE; j++, iopte++) {
+			u32 da;
+
+			if (!*iopte)
+				continue;
+
+			da = (i << IOPGD_SHIFT) + (j << IOPTE_SHIFT);
+			p += sprintf(p, "2: %08x %08x\n", da, *iopte);
+		}
+	}
+	spin_unlock(&obj->page_table_lock);
+
+	bytes = simple_read_from_buffer(userbuf, count, ppos, local_buffer,
+					p - local_buffer);
+	mutex_unlock(&iommu_debug_lock);
+	return bytes;
+}
+
+static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct iommu *obj = file->private_data;
+	char *p = local_buffer;
+	struct iovm_struct *tmp;
+	int uninitialized_var(i);
+	ssize_t bytes;
+
+	mutex_lock(&iommu_debug_lock);
+
+	p += sprintf(p, "%-3s %-8s %-8s %6s %8s\n",
+		     "No", "start", "end", "size", "flags");
+	p += sprintf(p, "-------------------------------------------------\n");
+
+	list_for_each_entry(tmp, &obj->mmap, list) {
+		size_t len;
+
+		len = tmp->da_end - tmp->da_start;
+		p += sprintf(p, "%3d %08x-%08x %6x %8x\n",
+			     i, tmp->da_start, tmp->da_end, len, tmp->flags);
+		i++;
+	}
+	bytes = simple_read_from_buffer(userbuf, count, ppos, local_buffer,
+					p - local_buffer);
+	mutex_unlock(&iommu_debug_lock);
+	return bytes;
+}
+
+static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
+			      size_t count, loff_t *ppos)
+{
+	struct iommu *obj = file->private_data;
+	char *p = local_buffer;
+	struct iovm_struct *area;
+	ssize_t bytes;
+
+	mutex_lock(&iommu_debug_lock);
+
+	area = find_iovm_area(obj, (u32)ppos);
+	if (IS_ERR(area)) {
+		mutex_unlock(&iommu_debug_lock);
+		return -EINVAL;
+	}
+	memcpy(p, area->va, count);
+	p += count;
+
+	bytes = simple_read_from_buffer(userbuf, count, ppos, local_buffer,
+					p - local_buffer);
+	mutex_unlock(&iommu_debug_lock);
+	return bytes;
+}
+
+static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
+			       size_t count, loff_t *ppos)
+{
+	struct iommu *obj = file->private_data;
+	struct iovm_struct *area;
+	char *p = local_buffer;
+
+	count = min(count, sizeof(local_buffer));
+
+	mutex_lock(&iommu_debug_lock);
+
+	if (copy_from_user(p, userbuf, count)) {
+		mutex_unlock(&iommu_debug_lock);
+		return -EFAULT;
+	}
+
+	area = find_iovm_area(obj, (u32)ppos);
+	if (IS_ERR(area)) {
+		mutex_unlock(&iommu_debug_lock);
+		return -EINVAL;
+	}
+	memcpy(area->va, p, count);
+	mutex_unlock(&iommu_debug_lock);
+	return count;
+}
+
+static int debug_open_generic(struct inode *inode, struct file *file)
+{
+	file->private_data = inode->i_private;
+	return 0;
+}
+
+#define DEBUG_FOPS(name)						\
+	static const struct file_operations debug_##name##_fops = {	\
+		.open = debug_open_generic,				\
+		.read = debug_read_##name,				\
+		.write = debug_write_##name,				\
+	};
+
+#define DEBUG_FOPS_RO(name)						\
+	static const struct file_operations debug_##name##_fops = {	\
+		.open = debug_open_generic,				\
+		.read = debug_read_##name,				\
+	};
+
+DEBUG_FOPS_RO(ver);
+DEBUG_FOPS_RO(regs);
+DEBUG_FOPS_RO(tlb);
+DEBUG_FOPS(pagetable);
+DEBUG_FOPS_RO(mmap);
+DEBUG_FOPS(mem);
+
+#define __DEBUG_ADD_FILE(attr, mode)					\
+	{								\
+		struct dentry *dent;					\
+		dent = debugfs_create_file(#attr, mode, parent,		\
+					   obj, &debug_##attr##_fops);	\
+		if (!dent)						\
+			return -ENOMEM;					\
+	}
+
+#define DEBUG_ADD_FILE(name) __DEBUG_ADD_FILE(name, 600)
+#define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 400)
+
+static int iommu_debug_register(struct device *dev, void *data)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct iommu *obj = platform_get_drvdata(pdev);
+	struct dentry *d, *parent;
+
+	if (!obj || !obj->dev)
+		return -EINVAL;
+
+	d = debugfs_create_dir(obj->name, iommu_debug_root);
+	if (!d)
+		return -ENOMEM;
+	parent = d;
+
+	d = debugfs_create_u8("nr_tlb_entries", 400, parent,
+			      (u8 *)&obj->nr_tlb_entries);
+	if (!d)
+		return -ENOMEM;
+
+	DEBUG_ADD_FILE_RO(ver);
+	DEBUG_ADD_FILE_RO(regs);
+	DEBUG_ADD_FILE_RO(tlb);
+	DEBUG_ADD_FILE(pagetable);
+	DEBUG_ADD_FILE_RO(mmap);
+	DEBUG_ADD_FILE(mem);
+
+	return 0;
+}
+
+static int __init iommu_debug_init(void)
+{
+	struct dentry *d;
+	int err;
+
+	d = debugfs_create_dir("iommu", NULL);
+	if (!d)
+		return -ENOMEM;
+	iommu_debug_root = d;
+
+	err = foreach_iommu_device(d, iommu_debug_register);
+	if (err)
+		goto err_out;
+	return 0;
+
+err_out:
+	debugfs_remove_recursive(iommu_debug_root);
+	return err;
+}
+module_init(iommu_debug_init)
+
+static void __exit iommu_debugfs_exit(void)
+{
+	debugfs_remove_recursive(iommu_debug_root);
+}
+module_exit(iommu_debugfs_exit)
+
+MODULE_DESCRIPTION("omap iommu: debugfs interface");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index e638883..8ed29e8 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -120,25 +120,16 @@ static void iommu_disable(struct iommu *obj)
 	clk_disable(obj->clk);
 }
 
-#ifdef DEBUG
-static ssize_t iommu_dump_ctx(struct iommu *obj, char *buf)
-{
-	if (!obj || !buf)
-		return -EINVAL;
-
-	return arch_iommu->dump_ctx(obj, buf);
-}
-#endif
-
 /*
  *	TLB operations
  */
-static inline void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
+void iotlb_cr_to_e(struct cr_regs *cr, struct iotlb_entry *e)
 {
 	BUG_ON(!cr || !e);
 
 	arch_iommu->cr_to_e(cr, e);
 }
+EXPORT_SYMBOL_GPL(iotlb_cr_to_e);
 
 static inline int iotlb_cr_valid(struct cr_regs *cr)
 {
@@ -157,10 +148,11 @@ static inline struct cr_regs *iotlb_alloc_cr(struct iommu *obj,
 	return arch_iommu->alloc_cr(obj, e);
 }
 
-static inline u32 iotlb_cr_to_virt(struct cr_regs *cr)
+u32 iotlb_cr_to_virt(struct cr_regs *cr)
 {
 	return arch_iommu->cr_to_virt(cr);
 }
+EXPORT_SYMBOL_GPL(iotlb_cr_to_virt);
 
 static u32 get_iopte_attr(struct iotlb_entry *e)
 {
@@ -215,13 +207,13 @@ static void iotlb_load_cr(struct iommu *obj, struct cr_regs *cr)
  * @cr:		contents of cam and ram register
  * @buf:	output buffer
  **/
-ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr, char *buf)
+static inline ssize_t iotlb_dump_cr(struct iommu *obj, struct cr_regs *cr,
+				    char *buf)
 {
 	BUG_ON(!cr || !buf);
 
 	return arch_iommu->dump_cr(obj, cr, buf);
 }
-EXPORT_SYMBOL_GPL(iotlb_dump_cr);
 
 /**
  * load_iotlb_entry() - Set an iommu tlb entry
@@ -359,6 +351,87 @@ void flush_iotlb_all(struct iommu *obj)
 }
 EXPORT_SYMBOL_GPL(flush_iotlb_all);
 
+#if defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
+
+ssize_t iommu_dump_ctx(struct iommu *obj, char *buf)
+{
+	ssize_t bytes;
+
+	if (!obj || !buf)
+		return -EINVAL;
+
+	clk_enable(obj->clk);
+
+	bytes = arch_iommu->dump_ctx(obj, buf);
+
+	clk_disable(obj->clk);
+
+	return bytes;
+}
+EXPORT_SYMBOL_GPL(iommu_dump_ctx);
+
+static int __dump_tlb_entries(struct iommu *obj, struct cr_regs *crs)
+{
+	int i;
+	struct iotlb_lock saved, l;
+	struct cr_regs *p = crs;
+
+	clk_enable(obj->clk);
+
+	iotlb_lock_get(obj, &saved);
+	memcpy(&l, &saved, sizeof(saved));
+
+	for (i = 0; i < obj->nr_tlb_entries; i++) {
+		struct cr_regs tmp;
+
+		iotlb_lock_get(obj, &l);
+		l.vict = i;
+		iotlb_lock_set(obj, &l);
+		iotlb_read_cr(obj, &tmp);
+		if (!iotlb_cr_valid(&tmp))
+			continue;
+
+		*p++ = tmp;
+	}
+	iotlb_lock_set(obj, &saved);
+	clk_disable(obj->clk);
+
+	return  p - crs;
+}
+
+/**
+ * dump_tlb_entries() - dump cr arrays to given buffer
+ * @obj:	target iommu
+ * @buf:	output buffer
+ **/
+size_t dump_tlb_entries(struct iommu *obj, char *buf)
+{
+	int i, n;
+	struct cr_regs *cr;
+	char *p = buf;
+
+	cr = kcalloc(obj->nr_tlb_entries, sizeof(*cr), GFP_KERNEL);
+	if (!cr)
+		return 0;
+
+	n = __dump_tlb_entries(obj, cr);
+	for (i = 0; i < n; i++)
+		p += iotlb_dump_cr(obj, cr + i, p);
+	kfree(cr);
+
+	return p - buf;
+}
+EXPORT_SYMBOL_GPL(dump_tlb_entries);
+
+int foreach_iommu_device(void *data, int (*fn)(struct device *, void *))
+{
+	return driver_for_each_device(&omap_iommu_driver.driver,
+				      NULL, data, fn);
+}
+EXPORT_SYMBOL_GPL(foreach_iommu_device);
+
+#endif /* CONFIG_OMAP_IOMMU_DEBUG_MODULE */
+
 /*
  *	H/W pagetable operations
  */
@@ -515,39 +588,6 @@ static int iopgtable_store_entry_core(struct iommu *obj, struct iotlb_entry *e)
 	return err;
 }
 
-#ifdef DEBUG
-static void dump_tlb_entries(struct iommu *obj)
-{
-	int i;
-	struct iotlb_lock l;
-
-	clk_enable(obj->clk);
-
-	pr_info("%8s %8s\n", "cam:", "ram:");
-	pr_info("-----------------------------------------\n");
-
-	for (i = 0; i < obj->nr_tlb_entries; i++) {
-		struct cr_regs cr;
-		static char buf[4096];
-
-		iotlb_lock_get(obj, &l);
-		l.vict = i;
-		iotlb_lock_set(obj, &l);
-		iotlb_read_cr(obj, &cr);
-		if (!iotlb_cr_valid(&cr))
-			continue;
-
-		memset(buf, 0, 4096);
-		iotlb_dump_cr(obj, &cr, buf);
-		pr_err("%s", buf);
-	}
-
-	clk_disable(obj->clk);
-}
-#else
-static inline void dump_tlb_entries(struct iommu *obj) {}
-#endif
-
 /**
  * iopgtable_store_entry() - Make an iommu pte entry
  * @obj:	target iommu
@@ -559,7 +599,7 @@ int iopgtable_store_entry(struct iommu *obj, struct iotlb_entry *e)
 
 	flush_iotlb_page(obj, e->da);
 	err = iopgtable_store_entry_core(obj, e);
-#ifdef USE_IOTLB
+#ifdef PREFETCH_IOTLB
 	if (!err)
 		load_iotlb_entry(obj, e);
 #endif
@@ -703,7 +743,9 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	if (!err)
 		return IRQ_HANDLED;
 
+	clk_enable(obj->clk);
 	stat = iommu_report_fault(obj, &da);
+	clk_disable(obj->clk);
 	if (!stat)
 		return IRQ_HANDLED;
 
@@ -720,8 +762,6 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
 		__func__, da, iopgd, *iopgd, iopte, *iopte);
 
-	dump_tlb_entries(obj);
-
 	return IRQ_NONE;
 }
 
-- 
1.6.0.4

