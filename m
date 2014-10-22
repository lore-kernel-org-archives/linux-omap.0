From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 17/17] iommu/omap: Switch pagetable debugfs entry to use
	seq_file
Date: Wed, 22 Oct 2014 17:22:35 -0500
Message-ID: <1414016555-28067-18-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna-l0cyMroinI0@public.gmane.org>
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

The debugfs entry 'pagetable' that shows the page table entry
(PTE) data currently outputs only data that can be fit into a
page. Switch the entry to use the seq_file interface so that
it can show all the valid page table entries.

The patch also corrected the output for L2 entries, and prints
the proper L2 PTE instead of the previous L1 page descriptor
pointer.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/omap-iommu-debug.c | 81 ++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 41b09a1..f3d20a2 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -85,95 +85,70 @@ static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 	return bytes;
 }
 
-#define dump_ioptable_entry_one(lv, da, val)			\
-	({							\
-		int __err = 0;					\
-		ssize_t bytes;					\
-		const int maxcol = 22;				\
-		const char *str = "%d: %08x %08x\n";		\
-		bytes = snprintf(p, maxcol, str, lv, da, val);	\
-		p += bytes;					\
-		len -= bytes;					\
-		if (len < maxcol)				\
-			__err = -ENOMEM;			\
-		__err;						\
-	})
-
-static ssize_t dump_ioptable(struct omap_iommu *obj, char *buf, ssize_t len)
+static void dump_ioptable(struct seq_file *s)
 {
-	int i;
-	u32 *iopgd;
-	char *p = buf;
+	int i, j;
+	u32 da;
+	u32 *iopgd, *iopte;
+	struct omap_iommu *obj = s->private;
 
 	spin_lock(&obj->page_table_lock);
 
 	iopgd = iopgd_offset(obj, 0);
 	for (i = 0; i < PTRS_PER_IOPGD; i++, iopgd++) {
-		int j, err;
-		u32 *iopte;
-		u32 da;
-
 		if (!*iopgd)
 			continue;
 
 		if (!(*iopgd & IOPGD_TABLE)) {
 			da = i << IOPGD_SHIFT;
-
-			err = dump_ioptable_entry_one(1, da, *iopgd);
-			if (err)
-				goto out;
+			seq_printf(s, "1: 0x%08x 0x%08x\n", da, *iopgd);
 			continue;
 		}
 
 		iopte = iopte_offset(iopgd, 0);
-
 		for (j = 0; j < PTRS_PER_IOPTE; j++, iopte++) {
 			if (!*iopte)
 				continue;
 
 			da = (i << IOPGD_SHIFT) + (j << IOPTE_SHIFT);
-			err = dump_ioptable_entry_one(2, da, *iopgd);
-			if (err)
-				goto out;
+			seq_printf(s, "2: 0x%08x 0x%08x\n", da, *iopte);
 		}
 	}
-out:
-	spin_unlock(&obj->page_table_lock);
 
-	return p - buf;
+	spin_unlock(&obj->page_table_lock);
 }
 
-static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
-				    size_t count, loff_t *ppos)
+static int debug_read_pagetable(struct seq_file *s, void *data)
 {
-	struct omap_iommu *obj = file->private_data;
-	char *p, *buf;
-	size_t bytes;
+	struct omap_iommu *obj = s->private;
 
 	if (is_omap_iommu_detached(obj))
 		return -EPERM;
 
-	buf = (char *)__get_free_page(GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-	p = buf;
-
-	p += sprintf(p, "L: %8s %8s\n", "da:", "pa:");
-	p += sprintf(p, "-----------------------------------------\n");
-
 	mutex_lock(&iommu_debug_lock);
 
-	bytes = PAGE_SIZE - (p - buf);
-	p += dump_ioptable(obj, p, bytes);
-
-	bytes = simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
+	seq_printf(s, "L: %8s %8s\n", "da:", "pte:");
+	seq_puts(s, "--------------------------\n");
+	dump_ioptable(s);
 
 	mutex_unlock(&iommu_debug_lock);
-	free_page((unsigned long)buf);
 
-	return bytes;
+	return 0;
 }
 
+#define DEBUG_SEQ_FOPS_RO(name)						       \
+	static int debug_open_##name(struct inode *inode, struct file *file)   \
+	{								       \
+		return single_open(file, debug_read_##name, inode->i_private); \
+	}								       \
+									       \
+	static const struct file_operations debug_##name##_fops = {	       \
+		.open		= debug_open_##name,			       \
+		.read		= seq_read,				       \
+		.llseek		= seq_lseek,				       \
+		.release	= single_release,			       \
+	}
+
 #define DEBUG_FOPS_RO(name)						\
 	static const struct file_operations debug_##name##_fops = {	\
 		.open = simple_open,					\
@@ -183,7 +158,7 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 
 DEBUG_FOPS_RO(regs);
 DEBUG_FOPS_RO(tlb);
-DEBUG_FOPS_RO(pagetable);
+DEBUG_SEQ_FOPS_RO(pagetable);
 
 #define __DEBUG_ADD_FILE(attr, mode)					\
 	{								\
-- 
2.1.0
