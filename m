From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 05/17] iommu/omap: Remove ver debugfs entry
Date: Wed, 22 Oct 2014 17:22:23 -0500
Message-ID: <1414016555-28067-6-git-send-email-s-anna@ti.com>
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

The debugfs entry 'ver' to read the OMAP IOMMU version is
not much useful for developers, so it has been removed. The
same can be deduced from the register dump, provided by the
debugfs entry 'regs', REVISION register. This also allows us
to remove the omap_iommu_arch_revision() which is currently
returning a fixed value.

Signed-off-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 drivers/iommu/omap-iommu-debug.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 531658d..0fb92aa 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -30,17 +30,6 @@ static DEFINE_MUTEX(iommu_debug_lock);
 
 static struct dentry *iommu_debug_root;
 
-static ssize_t debug_read_ver(struct file *file, char __user *userbuf,
-			      size_t count, loff_t *ppos)
-{
-	u32 ver = omap_iommu_arch_version();
-	char buf[MAXCOLUMN], *p = buf;
-
-	p += sprintf(p, "H/W version: %d.%d\n", (ver >> 4) & 0xf , ver & 0xf);
-
-	return simple_read_from_buffer(userbuf, count, ppos, buf, p - buf);
-}
-
 static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
@@ -228,7 +217,6 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 		.llseek = generic_file_llseek,				\
 	};
 
-DEBUG_FOPS_RO(ver);
 DEBUG_FOPS_RO(regs);
 DEBUG_FOPS_RO(tlb);
 DEBUG_FOPS(pagetable);
@@ -273,7 +261,6 @@ static int iommu_debug_register(struct device *dev, void *data)
 	if (!d)
 		goto nomem;
 
-	DEBUG_ADD_FILE_RO(ver);
 	DEBUG_ADD_FILE_RO(regs);
 	DEBUG_ADD_FILE_RO(tlb);
 	DEBUG_ADD_FILE(pagetable);
-- 
2.1.0
