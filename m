From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 12/17] iommu/omap: Integrate omap-iommu-debug into omap-iommu
Date: Wed, 22 Oct 2014 17:22:30 -0500
Message-ID: <1414016555-28067-13-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47590 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933487AbaJVWWw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:52 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The debugfs support for OMAP IOMMU is currently implemented
as a module, warranting certain OMAP-specific IOMMU API to
be exported. The OMAP IOMMU, when enabled, can only be built-in
into the kernel, so integrate the OMAP IOMMU debug module
into the OMAP IOMMU driver. This helps in eliminating the
need to export most of the current OMAP IOMMU API.

The following are the main changes:
- The debugfs directory and entry creation logic is reversed,
  the calls are invoked by the OMAP IOMMU driver now.
- The current iffy circular logic of adding IOMMU archdata
  to the IOMMU devices itself to get a pointer to the omap_iommu
  object in the debugfs support code is replaced by directly
  using the omap_iommu structure while creating the debugfs
  entries.
- The debugfs root directory is renamed from the generic name
  "iommu" to a specific name "omap_iommu".
- Unneeded headers have also been cleaned up while at this.
- There will no longer be a omap-iommu-debug.ko module after
  this patch.
- The OMAP_IOMMU_DEBUG Kconfig option is converted to boolean
  only, the OMAP IOMMU debugfs support is built alongside the
  OMAP IOMMU driver only when this option is enabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/Kconfig            |  12 ++---
 drivers/iommu/omap-iommu-debug.c | 100 +++++++++++----------------------------
 drivers/iommu/omap-iommu.c       |  11 ++++-
 drivers/iommu/omap-iommu.h       |  15 ++++++
 4 files changed, 58 insertions(+), 80 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index dd51122..1d54996 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -144,13 +144,13 @@ config OMAP_IOMMU
 	select IOMMU_API
 
 config OMAP_IOMMU_DEBUG
-       tristate "Export OMAP IOMMU internals in DebugFS"
-       depends on OMAP_IOMMU && DEBUG_FS
-       help
-         Select this to see extensive information about
-         the internal state of OMAP IOMMU in debugfs.
+	bool "Export OMAP IOMMU internals in DebugFS"
+	depends on OMAP_IOMMU && DEBUG_FS
+	---help---
+	  Select this to see extensive information about
+	  the internal state of OMAP IOMMU in debugfs.
 
-         Say N unless you know you need this.
+	  Say N unless you know you need this.
 
 config TEGRA_IOMMU_GART
 	bool "Tegra GART IOMMU Support"
diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 28de657..4813d3a 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -10,15 +10,11 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
 #include <linux/err.h>
-#include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-#include <linux/platform_device.h>
 #include <linux/debugfs.h>
-#include <linux/omap-iommu.h>
 #include <linux/platform_data/iommu-omap.h>
 
 #include "omap-iopgtable.h"
@@ -31,8 +27,7 @@ static struct dentry *iommu_debug_root;
 static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct device *dev = file->private_data;
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	ssize_t bytes;
 
@@ -55,8 +50,7 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	struct device *dev = file->private_data;
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	ssize_t bytes, rest;
 
@@ -141,8 +135,7 @@ out:
 static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 				    size_t count, loff_t *ppos)
 {
-	struct device *dev = file->private_data;
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
+	struct omap_iommu *obj = file->private_data;
 	char *p, *buf;
 	size_t bytes;
 
@@ -181,93 +174,56 @@ DEBUG_FOPS_RO(pagetable);
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
 		struct dentry *dent;					\
-		dent = debugfs_create_file(#attr, mode, parent,		\
-					   dev, &debug_##attr##_fops);	\
+		dent = debugfs_create_file(#attr, mode, obj->debug_dir,	\
+					   obj, &debug_##attr##_fops);	\
 		if (!dent)						\
-			return -ENOMEM;					\
+			goto err;					\
 	}
 
 #define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 0400)
 
-static int iommu_debug_register(struct device *dev, void *data)
+void omap_iommu_debugfs_add(struct omap_iommu *obj)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct omap_iommu *obj = platform_get_drvdata(pdev);
-	struct omap_iommu_arch_data *arch_data;
-	struct dentry *d, *parent;
-
-	if (!obj || !obj->dev)
-		return -EINVAL;
-
-	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
-	if (!arch_data)
-		return -ENOMEM;
-
-	arch_data->iommu_dev = obj;
+	struct dentry *d;
 
-	dev->archdata.iommu = arch_data;
+	if (!iommu_debug_root)
+		return;
 
-	d = debugfs_create_dir(obj->name, iommu_debug_root);
-	if (!d)
-		goto nomem;
-	parent = d;
+	obj->debug_dir = debugfs_create_dir(obj->name, iommu_debug_root);
+	if (!obj->debug_dir)
+		return;
 
-	d = debugfs_create_u8("nr_tlb_entries", 0400, parent,
+	d = debugfs_create_u8("nr_tlb_entries", 0400, obj->debug_dir,
 			      (u8 *)&obj->nr_tlb_entries);
 	if (!d)
-		goto nomem;
+		return;
 
 	DEBUG_ADD_FILE_RO(regs);
 	DEBUG_ADD_FILE_RO(tlb);
 	DEBUG_ADD_FILE_RO(pagetable);
 
-	return 0;
+	return;
 
-nomem:
-	kfree(arch_data);
-	return -ENOMEM;
+err:
+	debugfs_remove_recursive(obj->debug_dir);
 }
 
-static int iommu_debug_unregister(struct device *dev, void *data)
+void omap_iommu_debugfs_remove(struct omap_iommu *obj)
 {
-	if (!dev->archdata.iommu)
-		return 0;
-
-	kfree(dev->archdata.iommu);
-
-	dev->archdata.iommu = NULL;
+	if (!obj->debug_dir)
+		return;
 
-	return 0;
+	debugfs_remove_recursive(obj->debug_dir);
 }
 
-static int __init iommu_debug_init(void)
+void __init omap_iommu_debugfs_init(void)
 {
-	struct dentry *d;
-	int err;
-
-	d = debugfs_create_dir("iommu", NULL);
-	if (!d)
-		return -ENOMEM;
-	iommu_debug_root = d;
-
-	err = omap_foreach_iommu_device(d, iommu_debug_register);
-	if (err)
-		goto err_out;
-	return 0;
-
-err_out:
-	debugfs_remove_recursive(iommu_debug_root);
-	return err;
+	iommu_debug_root = debugfs_create_dir("omap_iommu", NULL);
+	if (!iommu_debug_root)
+		pr_err("can't create debugfs dir\n");
 }
-module_init(iommu_debug_init)
 
-static void __exit iommu_debugfs_exit(void)
+void __exit omap_iommu_debugfs_exit(void)
 {
-	debugfs_remove_recursive(iommu_debug_root);
-	omap_foreach_iommu_device(NULL, iommu_debug_unregister);
+	debugfs_remove(iommu_debug_root);
 }
-module_exit(iommu_debugfs_exit)
-
-MODULE_DESCRIPTION("omap iommu: debugfs interface");
-MODULE_AUTHOR("Hiroshi DOYU <Hiroshi.DOYU@nokia.com>");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index 91262fa..b92b6fc 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -472,7 +472,7 @@ static void flush_iotlb_all(struct omap_iommu *obj)
 	pm_runtime_put_sync(obj->dev);
 }
 
-#if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOMMU_DEBUG_MODULE)
+#ifdef CONFIG_OMAP_IOMMU_DEBUG
 
 #define pr_reg(name)							\
 	do {								\
@@ -602,7 +602,7 @@ int omap_foreach_iommu_device(void *data, int (*fn)(struct device *, void *))
 }
 EXPORT_SYMBOL_GPL(omap_foreach_iommu_device);
 
-#endif /* CONFIG_OMAP_IOMMU_DEBUG_MODULE */
+#endif /* CONFIG_OMAP_IOMMU_DEBUG */
 
 /*
  *	H/W pagetable operations
@@ -1077,6 +1077,8 @@ static int omap_iommu_probe(struct platform_device *pdev)
 	pm_runtime_irq_safe(obj->dev);
 	pm_runtime_enable(obj->dev);
 
+	omap_iommu_debugfs_add(obj);
+
 	dev_info(&pdev->dev, "%s registered\n", obj->name);
 	return 0;
 }
@@ -1086,6 +1088,7 @@ static int omap_iommu_remove(struct platform_device *pdev)
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
 
 	iopgtable_clear_entry_all(obj);
+	omap_iommu_debugfs_remove(obj);
 
 	pm_runtime_disable(obj->dev);
 
@@ -1403,6 +1406,8 @@ static int __init omap_iommu_init(void)
 
 	bus_set_iommu(&platform_bus_type, &omap_iommu_ops);
 
+	omap_iommu_debugfs_init();
+
 	return platform_driver_register(&omap_iommu_driver);
 }
 /* must be ready before omap3isp is probed */
@@ -1413,6 +1418,8 @@ static void __exit omap_iommu_exit(void)
 	kmem_cache_destroy(iopte_cachep);
 
 	platform_driver_unregister(&omap_iommu_driver);
+
+	omap_iommu_debugfs_exit();
 }
 module_exit(omap_iommu_exit);
 
diff --git a/drivers/iommu/omap-iommu.h b/drivers/iommu/omap-iommu.h
index 0516e0e..4783779 100644
--- a/drivers/iommu/omap-iommu.h
+++ b/drivers/iommu/omap-iommu.h
@@ -30,6 +30,7 @@ struct omap_iommu {
 	void __iomem	*regbase;
 	struct device	*dev;
 	struct iommu_domain *domain;
+	struct dentry	*debug_dir;
 
 	spinlock_t	iommu_lock;	/* global for this whole object */
 
@@ -197,11 +198,25 @@ omap_iopgtable_store_entry(struct omap_iommu *obj, struct iotlb_entry *e);
 extern int omap_foreach_iommu_device(void *data,
 				int (*fn)(struct device *, void *));
 
+#ifdef CONFIG_OMAP_IOMMU_DEBUG
 extern ssize_t
 omap_iommu_dump_ctx(struct omap_iommu *obj, char *buf, ssize_t len);
 extern size_t
 omap_dump_tlb_entries(struct omap_iommu *obj, char *buf, ssize_t len);
 
+void omap_iommu_debugfs_init(void);
+void omap_iommu_debugfs_exit(void);
+
+void omap_iommu_debugfs_add(struct omap_iommu *obj);
+void omap_iommu_debugfs_remove(struct omap_iommu *obj);
+#else
+static inline void omap_iommu_debugfs_init(void) { }
+static inline void omap_iommu_debugfs_exit(void) { }
+
+static inline void omap_iommu_debugfs_add(struct omap_iommu *obj) { }
+static inline void omap_iommu_debugfs_remove(struct omap_iommu *obj) { }
+#endif
+
 /*
  * register accessors
  */
-- 
2.1.0

