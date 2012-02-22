From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/2] iommu/omap: fix erroneous omap-iommu-debug API calls
Date: Wed, 22 Feb 2012 10:52:51 +0200
Message-ID: <1329900772-9306-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60666 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065Ab2BVIxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Feb 2012 03:53:17 -0500
Received: by werb13 with SMTP id b13so4333690wer.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 00:53:16 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Hiroshi Doyu <hdoyu@nvidia.com>

Adapt omap-iommu-debug to the latest omap-iommu API changes, which
were introduced by commit fabdbca "iommu/omap: eliminate the public
omap_find_iommu_device() method".

In a nutshell, iommu users are not expected to provide the omap_iommu
handle anymore - instead, iommus are attached using their user's device
handle.

omap-iommu-debug is a hybrid beast though: it invokes both public and
private omap iommu API, so fix it as necessary (otherwise a crash
is imminent).

Note: omap-iommu-debug is a bit disturbing, as it fiddles with internal
omap iommu data and requires exposing API which is otherwise not needed.
It should better be more tightly coupled with omap-iommu, to prevent
further bit rot and avoid exposing redundant API. Naturally that's out
of scope for the -rc cycle, so for now just fix the obvious.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>
---
 drivers/iommu/omap-iommu-debug.c |   55 +++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 288da5c..bad9f9d 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -44,7 +44,8 @@ static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
 static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
+	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 	char *p, *buf;
 	ssize_t bytes;
 
@@ -67,7 +68,8 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
+	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 	char *p, *buf;
 	ssize_t bytes, rest;
 
@@ -97,7 +99,8 @@ static ssize_t debug_write_pagetable(struct file *file,
 	struct iotlb_entry e;
 	struct cr_regs cr;
 	int err;
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
+	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 	char buf[MAXCOLUMN], *p = buf;
 
 	count = min(count, sizeof(buf));
@@ -184,7 +187,8 @@ out:
 static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 				    size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
+	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 	char *p, *buf;
 	size_t bytes;
 
@@ -212,7 +216,8 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
+	struct omap_iommu *obj = dev_to_omap_iommu(dev);
 	char *p, *buf;
 	struct iovm_struct *tmp;
 	int uninitialized_var(i);
@@ -254,7 +259,7 @@ static ssize_t debug_read_mmap(struct file *file, char __user *userbuf,
 static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
 			      size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
 	char *p, *buf;
 	struct iovm_struct *area;
 	ssize_t bytes;
@@ -268,7 +273,7 @@ static ssize_t debug_read_mem(struct file *file, char __user *userbuf,
 
 	mutex_lock(&iommu_debug_lock);
 
-	area = omap_find_iovm_area(obj, (u32)ppos);
+	area = omap_find_iovm_area(dev, (u32)ppos);
 	if (IS_ERR(area)) {
 		bytes = -EINVAL;
 		goto err_out;
@@ -287,7 +292,7 @@ err_out:
 static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
-	struct omap_iommu *obj = file->private_data;
+	struct device *dev = file->private_data;
 	struct iovm_struct *area;
 	char *p, *buf;
 
@@ -305,7 +310,7 @@ static ssize_t debug_write_mem(struct file *file, const char __user *userbuf,
 		goto err_out;
 	}
 
-	area = omap_find_iovm_area(obj, (u32)ppos);
+	area = omap_find_iovm_area(dev, (u32)ppos);
 	if (IS_ERR(area)) {
 		count = -EINVAL;
 		goto err_out;
@@ -350,7 +355,7 @@ DEBUG_FOPS(mem);
 	{								\
 		struct dentry *dent;					\
 		dent = debugfs_create_file(#attr, mode, parent,		\
-					   obj, &debug_##attr##_fops);	\
+					   dev, &debug_##attr##_fops);	\
 		if (!dent)						\
 			return -ENOMEM;					\
 	}
@@ -362,20 +367,29 @@ static int iommu_debug_register(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct omap_iommu *obj = platform_get_drvdata(pdev);
+	struct omap_iommu_arch_data *arch_data;
 	struct dentry *d, *parent;
 
 	if (!obj || !obj->dev)
 		return -EINVAL;
 
+	arch_data = kzalloc(sizeof(*arch_data), GFP_KERNEL);
+	if (!arch_data)
+		return -ENOMEM;
+
+	arch_data->iommu_dev = obj;
+
+	dev->archdata.iommu = arch_data;
+
 	d = debugfs_create_dir(obj->name, iommu_debug_root);
 	if (!d)
-		return -ENOMEM;
+		goto nomem;
 	parent = d;
 
 	d = debugfs_create_u8("nr_tlb_entries", 400, parent,
 			      (u8 *)&obj->nr_tlb_entries);
 	if (!d)
-		return -ENOMEM;
+		goto nomem;
 
 	DEBUG_ADD_FILE_RO(ver);
 	DEBUG_ADD_FILE_RO(regs);
@@ -385,6 +399,22 @@ static int iommu_debug_register(struct device *dev, void *data)
 	DEBUG_ADD_FILE(mem);
 
 	return 0;
+
+nomem:
+	kfree(arch_data);
+	return -ENOMEM;
+}
+
+static int iommu_debug_unregister(struct device *dev, void *data)
+{
+	if (!dev->archdata.iommu)
+		return 0;
+
+	kfree(dev->archdata.iommu);
+
+	dev->archdata.iommu = NULL;
+
+	return 0;
 }
 
 static int __init iommu_debug_init(void)
@@ -411,6 +441,7 @@ module_init(iommu_debug_init)
 static void __exit iommu_debugfs_exit(void)
 {
 	debugfs_remove_recursive(iommu_debug_root);
+	omap_foreach_iommu_device(NULL, iommu_debug_unregister);
 }
 module_exit(iommu_debugfs_exit)
 
-- 
1.7.5.4

