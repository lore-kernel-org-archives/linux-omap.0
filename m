From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 11/17] iommu/omap: Make pagetable debugfs entry read-only
Date: Tue, 30 Sep 2014 16:16:06 -0500
Message-ID: <1412111772-38006-12-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Remove the writeability on the 'pagetable' debugfs entry,
so that the mapping/unmapping into an OMAP IOMMU is only
limited to actual client devices/drivers at kernel-level.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
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
