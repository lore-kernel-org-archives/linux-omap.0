From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2] OMAP: iovmm: fix SW flags passed by user
Date: Fri, 25 Mar 2011 14:04:31 -0600
Message-ID: <1301083471-11284-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42529 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab1CYUP4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Mar 2011 16:15:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Omar Ramirez Luna <omar.ramirez@ti.com>, David Cohen <dacohen@gmail.com>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Commit d038aee24dcd5a2a0d8547f5396f67ae9698ac8e
"omap: iovmm: don't check 'da' to set IOVMF_DA_FIXED flag",
changes iovmm to receive flags specified by user, however
the upper 16 bits of the flags are wiped by iovmm itself.

This fixes IOVMF_DA_FIXED flags from being lost, and lets the user
map its desired "device addresses".

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---

v2:
Include missing reference (commit and name) to patch in
description.

 arch/arm/plat-omap/include/plat/iovmm.h |    3 ---
 arch/arm/plat-omap/iovmm.c              |    4 ----
 2 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/arch/arm/plat-omap/include/plat/iovmm.h
index 32a2f6c..e992b96 100644
--- a/arch/arm/plat-omap/include/plat/iovmm.h
+++ b/arch/arm/plat-omap/include/plat/iovmm.h
@@ -29,9 +29,6 @@ struct iovm_struct {
  * lower 16 bit is used for h/w and upper 16 bit is for s/w.
  */
 #define IOVMF_SW_SHIFT		16
-#define IOVMF_HW_SIZE		(1 << IOVMF_SW_SHIFT)
-#define IOVMF_HW_MASK		(IOVMF_HW_SIZE - 1)
-#define IOVMF_SW_MASK		(~IOVMF_HW_MASK)UL
 
 /*
  * iovma: h/w flags derived from cam and ram attribute
diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
index 51ef43e..83a37c5 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/arch/arm/plat-omap/iovmm.c
@@ -648,7 +648,6 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const struct sg_table *sgt,
 			return PTR_ERR(va);
 	}
 
-	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_DISCONT;
 	flags |= IOVMF_MMIO;
 
@@ -706,7 +705,6 @@ u32 iommu_vmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
 	if (!va)
 		return -ENOMEM;
 
-	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_DISCONT;
 	flags |= IOVMF_ALLOC;
 
@@ -795,7 +793,6 @@ u32 iommu_kmap(struct iommu *obj, u32 da, u32 pa, size_t bytes,
 	if (!va)
 		return -ENOMEM;
 
-	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_LINEAR;
 	flags |= IOVMF_MMIO;
 
@@ -853,7 +850,6 @@ u32 iommu_kmalloc(struct iommu *obj, u32 da, size_t bytes, u32 flags)
 		return -ENOMEM;
 	pa = virt_to_phys(va);
 
-	flags &= IOVMF_HW_MASK;
 	flags |= IOVMF_LINEAR;
 	flags |= IOVMF_ALLOC;
 
-- 
1.7.1

