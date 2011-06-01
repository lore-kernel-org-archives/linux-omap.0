From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 1/2] omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
Date: Wed,  1 Jun 2011 14:25:01 +0200
Message-ID: <1306931102-10943-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <20110531132233.GQ11352@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:47415 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758876Ab1FAMZX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jun 2011 08:25:23 -0400
Received: from localhost.localdomain (unknown [91.178.85.245])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7A69835998
	for <linux-omap@vger.kernel.org>; Wed,  1 Jun 2011 12:25:21 +0000 (UTC)
In-Reply-To: <20110531132233.GQ11352@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

sg_alloc_table can only allocate multi-page scatter-gather list tables
if the architecture supports scatter-gather lists chaining. ARM doesn't
fit in that category.

The IOMMU driver abuses the sg table structure only to hold page
addresses without ever passing the table to the device.

Use __sg_alloc_table instead of sg_alloc_table and allocate all entries
in one go. Otherwise trying to use a large userspace to capture video
will hit a BUG_ON in __sg_alloc_table.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 51ef43e..b82cef4 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -121,6 +121,16 @@ static unsigned sgtable_nents(size_t bytes, u32 da, u32 pa)
 	return nr_entries;
 }
 
+static struct scatterlist *sg_alloc(unsigned int nents, gfp_t gfp_mask)
+{
+	return kmalloc(nents * sizeof(struct scatterlist), gfp_mask);
+}
+
+static void sg_free(struct scatterlist *sg, unsigned int nents)
+{
+	kfree(sg);
+}
+
 /* allocate and initialize sg_table header(a kind of 'superblock') */
 static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags,
 							u32 da, u32 pa)
@@ -146,7 +156,7 @@ static struct sg_table *sgtable_alloc(const size_t bytes, u32 flags,
 	if (!sgt)
 		return ERR_PTR(-ENOMEM);
 
-	err = sg_alloc_table(sgt, nr_entries, GFP_KERNEL);
+	err = __sg_alloc_table(sgt, nr_entries, -1, GFP_KERNEL, sg_alloc);
 	if (err) {
 		kfree(sgt);
 		return ERR_PTR(err);
@@ -163,7 +173,7 @@ static void sgtable_free(struct sg_table *sgt)
 	if (!sgt)
 		return;
 
-	sg_free_table(sgt);
+	__sg_free_table(sgt, -1, sg_free);
 	kfree(sgt);
 
 	pr_debug("%s: sgt:%p\n", __func__, sgt);
-- 
1.7.3.4

