From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 16/17] iommu/omap: Fix bus error on debugfs access of unattached IOMMU
Date: Tue, 30 Sep 2014 16:16:11 -0500
Message-ID: <1412111772-38006-17-git-send-email-s-anna@ti.com>
References: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44915 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbaI3VQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2014 17:16:29 -0400
In-Reply-To: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Any debugfs access on an OMAP IOMMU that is not enabled (done during
attach) results in a bus error due to access of registers without
the clock or the reset enabled for the respective IOMMU. So, add a
check to make sure the IOMMU is enabled/attached by a client device.
This gracefully prints a "Operation not permitted" trace when the
corresponding IOMMU is not enabled.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/iommu/omap-iommu-debug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 54a0dc6..e7b8aca 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -24,6 +24,11 @@ static DEFINE_MUTEX(iommu_debug_lock);
 
 static struct dentry *iommu_debug_root;
 
+static inline bool is_omap_iommu_detached(struct omap_iommu *obj)
+{
+	return !obj->domain;
+}
+
 static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 			       size_t count, loff_t *ppos)
 {
@@ -31,6 +36,9 @@ static ssize_t debug_read_regs(struct file *file, char __user *userbuf,
 	char *p, *buf;
 	ssize_t bytes;
 
+	if (is_omap_iommu_detached(obj))
+		return -EPERM;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -54,6 +62,9 @@ static ssize_t debug_read_tlb(struct file *file, char __user *userbuf,
 	char *p, *buf;
 	ssize_t bytes, rest;
 
+	if (is_omap_iommu_detached(obj))
+		return -EPERM;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -139,6 +150,9 @@ static ssize_t debug_read_pagetable(struct file *file, char __user *userbuf,
 	char *p, *buf;
 	size_t bytes;
 
+	if (is_omap_iommu_detached(obj))
+		return -EPERM;
+
 	buf = (char *)__get_free_page(GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.1.0

