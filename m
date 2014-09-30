From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 05/17] iommu/omap: Remove ver debugfs entry
Date: Tue, 30 Sep 2014 16:16:00 -0500
Message-ID: <1412111772-38006-6-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44913 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbaI3VQ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2014 17:16:28 -0400
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

The debugfs entry 'ver' to read the OMAP IOMMU version is
not much useful for developers, so it has been removed. The
same can be deduced from the register dump, provided by the
debugfs entry 'regs', REVISION register. This also allows us
to remove the omap_iommu_arch_revision() which is currently
returning a fixed value.

Signed-off-by: Suman Anna <s-anna@ti.com>
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

