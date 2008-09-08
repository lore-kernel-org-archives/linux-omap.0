From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 4/4] ARM: OMAP: Introduce MMU class
Date: Mon,  8 Sep 2008 08:56:34 +0300
Message-ID: <1220853394-21529-6-git-send-email-Hiroshi.DOYU@nokia.com>
References: <1220853394-21529-1-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-2-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-3-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-4-git-send-email-Hiroshi.DOYU@nokia.com>
 <1220853394-21529-5-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:27222 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbYIHF51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 01:57:27 -0400
In-Reply-To: <1220853394-21529-5-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux@arm.linux.org.uk, r-woodruff2@ti.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

User application interface(sysfs)		(*partialy implemented)

"mmu-class" provides (5) to present some generic MMU information and
to control them too, like setting a TLB entry and a pagetable entry, from
userland through sysfs files. Since this is a normal MMU(TLB +
Pagetable + VMA) class, this can handle any MMU as well. This
"mmu-class" enables to implement an userland MMU manager for devices
later. This sysfs entires are just examples. "mmu-class" can be
considered as the entry point for any MMU to register itself to any
upper layter interface modules. "dspfs" registration also can be done
here.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/include/mach/mmu-class.h |   32 ++++
 arch/arm/plat-omap/mmu-class.c              |  213 +++++++++++++++++++++++++++
 2 files changed, 245 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/mach/mmu-class.h
 create mode 100644 arch/arm/plat-omap/mmu-class.c

diff --git a/arch/arm/plat-omap/include/mach/mmu-class.h b/arch/arm/plat-omap/include/mach/mmu-class.h
new file mode 100644
index 0000000..37e994b
--- /dev/null
+++ b/arch/arm/plat-omap/include/mach/mmu-class.h
@@ -0,0 +1,32 @@
+/* Generic MMU sysfs interface */
+#ifndef _MMU_CLASS_H_
+#define _MMU_CLASS_H_
+
+/* Primitive MMU info for any upper layer to handle */
+struct mmu_info {
+	char *name;
+#if 0	/* pagetable *//* REVISIT */
+	int (*pte_set)(struct mmu_info *i, void *entry, int way);
+	int (*pte_clear)(struct mmu_info *i, void *entry);
+	int (*dump_pagetable)(struct mmu_info *i, char *buf, void *entry);
+#endif
+	/* TLB *//* FIXME: multiple level TLB support */
+	int nr_ways;
+	int nr_sets;
+	int (*read_tlb)(struct mmu_info *i, void *entry, int way);
+	int (*write_tlb)(struct mmu_info *i, void *entry);
+	int (*dump_tlb)(struct mmu_info *i, char *buf, void *entry);
+#if 0	/* VMA *//* REVISIT */
+	unsigned long (*get_unmapped_area)(struct mmu_info *i,
+					   unsigned long len);
+	dma_addr_t (*dvmap_region)(struct mmu_info *i, void *entry,
+				   size_t bytes);
+	void (*dvunmap_region)(struct mmu_info *i unsigned long dvva,
+			       size_t len);
+#endif
+};
+
+int mmu_register_sysfs(struct mmu_info *i);
+void mmu_unregister_sysfs(struct mmu_info *i);
+
+#endif /* _MMU_CLASS_H_ */
diff --git a/arch/arm/plat-omap/mmu-class.c b/arch/arm/plat-omap/mmu-class.c
new file mode 100644
index 0000000..03c80f6
--- /dev/null
+++ b/arch/arm/plat-omap/mmu-class.c
@@ -0,0 +1,213 @@
+/*
+ * Generic MMU sysfs interface
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/module.h>
+#include <linux/kdev_t.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/err.h>
+
+#include <mach/mmu-class.h>
+
+static struct class *mmu_class;
+
+struct mmu_object {
+	struct device	*dev;
+	struct mmu_info	*info;
+};
+#define to_mmu_info(dev) \
+	(((struct mmu_object *)dev_get_drvdata(dev))->info)
+
+static ssize_t generic_attr_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct mmu_info *info = to_mmu_info(dev);
+	int err;
+	if (strcmp(attr->attr.name, "name") == 0)
+		err = sprintf(buf, "%s\n", info->name);
+	else if (strcmp(attr->attr.name, "set") == 0)
+		err = sprintf(buf, "%d\n", info->nr_sets);
+	else if (strcmp(attr->attr.name, "way") == 0)
+		err = sprintf(buf, "%d\n", info->nr_ways);
+	else
+		err = -EINVAL;
+	return err;
+}
+
+static ssize_t tlb_entries_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	unsigned long long *entry, *p;
+	int i, nr_entries, bytes = 0;
+	struct mmu_info *info = to_mmu_info(dev);
+
+	if (!info->read_tlb || !info->dump_tlb)
+		return -EIO;
+
+	nr_entries = info->nr_ways * info->nr_sets;
+	entry = kzalloc(nr_entries * sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+	p = entry;
+	for (i = 0; i < info->nr_ways; i++) {
+		int err;
+		p += i * info->nr_sets;
+		err = info->read_tlb(info, (unsigned long *)p, i);
+		if (err)
+			goto out;
+	}
+	bytes = info->dump_tlb(info, buf, (void *)entry);
+out:
+	kfree(entry);
+	return bytes;
+}
+
+static ssize_t tlb_entries_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct mmu_info *info = to_mmu_info(dev);
+	if (count != sizeof(long long))
+		return -EINVAL;
+	if (!info->write_tlb)
+		return -EIO;
+	return info->write_tlb(info, (unsigned long *)buf);
+}
+
+/*
+ *	MMU
+ */
+static DEVICE_ATTR(name, S_IRUGO, generic_attr_show, NULL);
+static struct attribute *mmu_attrs[] = {
+	&dev_attr_name.attr,
+	NULL,
+};
+static struct attribute_group mmu_attr_grp = {
+	.attrs	= mmu_attrs,
+};
+
+/*
+ *	TLB
+ */
+static DEVICE_ATTR(way, S_IRUGO, generic_attr_show, NULL);
+static DEVICE_ATTR(set, S_IRUGO, generic_attr_show, NULL);
+static DEVICE_ATTR(buf, S_IRUGO, tlb_entries_show, tlb_entries_store);
+static struct attribute *tlb_attrs[] = {
+	&dev_attr_way.attr,
+	&dev_attr_set.attr,
+	&dev_attr_buf.attr,
+	NULL,
+};
+
+static struct attribute_group tlb_attr_grp = {
+	.name	= "tlb",
+	.attrs	= tlb_attrs,
+};
+
+/*
+ *	PageTable: REVISIT
+ */
+static DEVICE_ATTR(pgt, S_IRUGO, NULL, NULL);
+static struct attribute *pgt_attrs[] = {
+	&dev_attr_pgt.attr,
+	NULL,
+};
+static struct attribute_group pgt_attr_grp = {
+	.attrs	= pgt_attrs,
+};
+
+int mmu_register_sysfs(struct mmu_info *info)
+{
+	int err;
+	struct mmu_object *mmu;
+
+	if (!info || !info->name)
+		return -EINVAL;
+	mmu = kzalloc(sizeof(*mmu), GFP_KERNEL);
+	if (!mmu)
+		return -ENOMEM;
+	mmu->info = info;
+	mmu->dev = device_create(mmu_class, NULL, 0, "%s", info->name);
+	if (IS_ERR(mmu->dev)) {
+		err =  PTR_ERR(mmu->dev);
+		goto err_device;
+	}
+	dev_set_drvdata(mmu->dev, mmu);
+	err = sysfs_create_group(&mmu->dev->kobj, &mmu_attr_grp);
+	if (err)
+		goto err_mmu_attr;
+	err = sysfs_create_group(&mmu->dev->kobj, &tlb_attr_grp);
+	if (err)
+		goto err_tlb_attr;
+	err = sysfs_create_group(&mmu->dev->kobj, &pgt_attr_grp);
+	if (err)
+		goto err_pgt_attr;
+
+	/*
+	 * You can add any upper layer interface(ex: dspfs, debugfs)
+	 * Or these can be configurable here ultimately.
+	 */
+	return 0;
+err_mmu_attr:
+	sysfs_remove_group(&mmu->dev->kobj, &pgt_attr_grp);
+err_pgt_attr:
+	sysfs_remove_group(&mmu->dev->kobj, &tlb_attr_grp);
+err_tlb_attr:
+	device_unregister(mmu->dev);
+err_device:
+	kfree(mmu);
+	return err;
+}
+EXPORT_SYMBOL(mmu_register_sysfs);
+
+static int match_by_info(struct device *dev, void *data)
+{
+	return data == (void *)to_mmu_info(dev);
+}
+
+void mmu_unregister_sysfs(struct mmu_info *info)
+{
+	struct mmu_object *mmu;
+	struct device *dev;
+
+	if (!info)
+		return;
+	dev = class_find_device(mmu_class, NULL, info, match_by_info);
+	if (!dev)
+		return;
+	mmu = dev_get_drvdata(dev);
+
+	sysfs_remove_group(&mmu->dev->kobj, &tlb_attr_grp);
+	sysfs_remove_group(&mmu->dev->kobj, &pgt_attr_grp);
+	sysfs_remove_group(&mmu->dev->kobj, &mmu_attr_grp);
+
+	dev_set_drvdata(mmu->dev, NULL);
+	device_unregister(mmu->dev);
+	kfree(mmu);
+}
+EXPORT_SYMBOL(mmu_unregister_sysfs);
+
+static int __init mmu_class_init(void)
+{
+	mmu_class = class_create(THIS_MODULE, "mmu");
+	if (IS_ERR(mmu_class))
+		return PTR_ERR(mmu_class);
+	return 0;
+}
+static void __exit mmu_class_exit(void)
+{
+	class_destroy(mmu_class);
+}
+arch_initcall(mmu_class_init);
+module_exit(mmu_class_exit);
+
+MODULE_DESCRIPTION("Generic MMU handling interface");
+MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
+MODULE_LICENSE("GPL");
-- 
1.5.5.1.357.g1af8b

