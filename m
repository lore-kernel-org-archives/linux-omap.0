From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH] omap iommu: avoid remapping if it's been mapped in MPU side
Date: Wed, 26 Aug 2009 13:45:40 +0300 (EEST)
Message-ID: <20090826.134540.189712717.Hiroshi.DOYU@nokia.com>
References: <1251283037-19573-1-git-send-email-sakari.ailus@maxwell.research.nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:60425 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159AbZHZKpq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Aug 2009 06:45:46 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7QAiGBr004228
	for <linux-omap@vger.kernel.org>; Wed, 26 Aug 2009 05:45:17 -0500
Received: from localhost (esdhcp04130.research.nokia.com [172.21.41.30])
	by mgw-da02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n7QAjZEN029950
	for <linux-omap@vger.kernel.org>; Wed, 26 Aug 2009 13:45:36 +0300
In-Reply-To: <1251283037-19573-1-git-send-email-sakari.ailus@maxwell.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

MPU side (v)-(p) mapping is necessary only if IOVMF_MMIO is set in
"flags".

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iovmm.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 6fc52fc..004fd83 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -615,7 +615,7 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 		 u32 flags)
 {
 	size_t bytes;
-	void *va;
+	void *va = NULL;
 
 	if (!obj || !obj->dev || !sgt)
 		return -EINVAL;
@@ -625,9 +625,11 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
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
-- 
1.5.6.5

