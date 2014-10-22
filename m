From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 11/17] iommu/omap: Make pagetable debugfs entry read-only
Date: Wed, 22 Oct 2014 17:22:29 -0500
Message-ID: <1414016555-28067-12-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49933 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932962AbaJVWWs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:48 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Remove the writeability on the 'pagetable' debugfs entry,
so that the mapping/unmapping into an OMAP IOMMU is only
limited to actual client devices/drivers at kernel-level.

Signed-off-by: Suman Anna <s-anna@ti.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu-debug.c | 48 ++--------------------------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index a520438..28de657 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -24,8 +24,6 @@
 #include "omap-iopgtable.h"
 #include "omap-iommu.h"
 
-#define MAXCOLUMN 100 /* for short messages */
-
 static DEFINE_MUTEX(iommu_debug_lock);
 
 static struct dentry *iommu_debug_root;
@@ -82,39 +80,6 @@ static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 	return bytes;
 }
 
-static ssize_t debug_write_pagetable(struct file *file,
-		     const char __user *userbuf, size_t count, loff_t *ppos)
-{
-	struct iotlb_entry e;
-	struct cr_regs cr;
-	int err;
-	struct device *dev = file->private_data;
-	struct omap_iommu *obj = dev_to_omap_iommu(dev);
-	char buf[MAXCOLUMN], *p = buf;
-
-	count = min(count, sizeof(buf));
-
-	mutex_lock(&iommu_debug_lock);
-	if (copy_from_user(p, userbuf, count)) {
-		mutex_unlock(&iommu_debug_lock);
-		return -EFAULT;
-	}
-
-	sscanf(p, "%x %x", &cr.cam, &cr.ram);
-	if (!cr.cam || !cr.ram) {
-		mutex_unlock(&iommu_debug_lock);
-		return -EINVAL;
-	}
-
-	omap_iotlb_cr_to_e(&cr, &e);
-	err = omap_iopgtable_store_entry(obj, &e);
-	if (err)
-		dev_err(obj->dev, "%s: fail to store cr\n", __func__);
-
-	mutex_unlock(&iommu_debug_lock);
-	return count;
-}
-
 #define dump_ioptable_entry_one(lv, da, val)			\
 	({							\
 		int __err = 0;					\
@@ -202,14 +167,6 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 	return bytes;
 }
 
-#define DEBUG_FOPS(name)						\
-	static const struct file_operations debug_##name##_fops = {	\
-		.open = simple_open,					\
-		.read = debug_read_##name,				\
-		.write = debug_write_##name,				\
-		.llseek = generic_file_llseek,				\
-	};
-
 #define DEBUG_FOPS_RO(name)						\
 	static const struct file_operations debug_##name##_fops = {	\
 		.open = simple_open,					\
@@ -219,7 +176,7 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 
 DEBUG_FOPS_RO(regs);
 DEBUG_FOPS_RO(tlb);
-DEBUG_FOPS(pagetable);
+DEBUG_FOPS_RO(pagetable);
 
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
@@ -230,7 +187,6 @@ DEBUG_FOPS(pagetable);
 			return -ENOMEM;					\
 	}
 
-#define DEBUG_ADD_FILE(name) __DEBUG_ADD_FILE(name, 0600)
 #define DEBUG_ADD_FILE_RO(name) __DEBUG_ADD_FILE(name, 0400)
 
 static int iommu_debug_register(struct device *dev, void *data)
@@ -263,7 +219,7 @@ static int iommu_debug_register(struct device *dev, void *data)
 
 	DEBUG_ADD_FILE_RO(regs);
 	DEBUG_ADD_FILE_RO(tlb);
-	DEBUG_ADD_FILE(pagetable);
+	DEBUG_ADD_FILE_RO(pagetable);
 
 	return 0;
 
-- 
2.1.0

