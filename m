From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 03/14] omap: iommu: avoid remapping if it's been mapped in MPU
	side
Date: Thu, 12 Nov 2009 16:07:50 -0800
Message-ID: <20091113000749.9034.95911.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51567 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbZKMAHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:07:45 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

MPU side (v)-(p) mapping is necessary only if IOVMF_MMIO is set in
"flags".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/iovmm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 0ce36bb..577d8c0 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -617,7 +617,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 		 u32 flags)
 {
 	size_t bytes;
-	void *va;
+	void *va = NULL;
 
 	if (!obj || !obj->dev || !sgt)
 		return -EINVAL;
@@ -627,9 +627,11 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 		return -EINVAL;
 	bytes = PAGE_ALIGN(bytes);
 
-	va = vmap_sg(sgt);
-	if (IS_ERR(va))
-		return PTR_ERR(va);
+	if (flags & IOVMF_MMIO) {
+		va = vmap_sg(sgt);
+		if (IS_ERR(va))
+			return PTR_ERR(va);
+	}
 
 	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_DISCONT;

