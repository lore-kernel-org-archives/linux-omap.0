From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 16/17] iommu/omap: Fix bus error on debugfs access of unattached IOMMU
Date: Wed, 22 Oct 2014 17:22:34 -0500
Message-ID: <1414016555-28067-17-git-send-email-s-anna@ti.com>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47587 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933487AbaJVWWv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Oct 2014 18:22:51 -0400
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
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
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/iommu/omap-iommu-debug.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index 4813d3a..41b09a1 100644
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

