From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH] omap: iovmm: s/sg_dma_len(sg)/sg->length/
Date: Wed,  8 Jun 2011 09:43:55 +0300
Message-ID: <1307515436-20805-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48690 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab1FHGpx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 02:45:53 -0400
Received: by wwa36 with SMTP id 36so220873wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 23:45:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Russell King <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>

iovmm is erroneously using sg_dma_len with unmapped (DMA API-wise)
SG entries, and will break if CONFIG_NEED_SG_DMA_LENGTH is enabled.

Fix that by using sg->length instead.

Reported-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/iovmm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 83a37c5..c60737c 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -72,7 +72,7 @@ static size_t sgtable_len(const struct sg_table *sgt)
 	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
 		size_t bytes;
 
-		bytes = sg_dma_len(sg);
+		bytes = sg->length;
 
 		if (!iopgsz_ok(bytes)) {
 			pr_err("%s: sg[%d] not iommu pagesize(%x)\n",
@@ -198,7 +198,7 @@ static void *vmap_sg(const struct sg_table *sgt)
 		int err;
 
 		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		bytes = sg->length;
 
 		BUG_ON(bytes != PAGE_SIZE);
 
@@ -476,7 +476,7 @@ static int map_iovm_area(struct iommu *obj, struct iovm_struct *new,
 		struct iotlb_entry e;
 
 		pa = sg_phys(sg);
-		bytes = sg_dma_len(sg);
+		bytes = sg->length;
 
 		flags &= ~IOVMF_PGSZ_MASK;
 		pgsz = bytes_to_iopgsz(bytes);
-- 
1.7.1

