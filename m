From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/5] omap iommu: Reject unaligned physical address at setting page table entry
Date: Fri,  7 May 2010 09:56:00 +0300
Message-ID: <1273215364-15098-1-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:55512 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab0EGG43 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:56:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: h-kanigeri2@ti.com, vimarsh.zutshi@nokia.com, Sakari.Ailus@nokia.com, david.cohen@nokia.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

This rejects unaligned physical address at setting page table entry
and informs error to caller. Otherwise, a wrong address may be used by
IO device.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/iommu.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index 0e13766..b3591ee 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -503,6 +503,12 @@ static int iopgd_alloc_section(struct iommu *obj, u32 da, u32 pa, u32 prot)
 {
 	u32 *iopgd = iopgd_offset(obj, da);
 
+	if (pa & ~IOSECTION_MASK) {
+		dev_err(obj->dev, "%s: pa:%08x should aligned on %08lx\n",
+			__func__, pa, IOSECTION_SIZE);
+		return -EINVAL;
+	}
+
 	*iopgd = (pa & IOSECTION_MASK) | prot | IOPGD_SECTION;
 	flush_iopgd_range(iopgd, iopgd);
 	return 0;
@@ -513,6 +519,12 @@ static int iopgd_alloc_super(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	u32 *iopgd = iopgd_offset(obj, da);
 	int i;
 
+	if (pa & ~IOSUPER_MASK) {
+		dev_err(obj->dev, "%s: pa:%08x should aligned on %08lx\n",
+			__func__, pa, IOSUPER_SIZE);
+		return -EINVAL;
+	}
+
 	for (i = 0; i < 16; i++)
 		*(iopgd + i) = (pa & IOSUPER_MASK) | prot | IOPGD_SUPER;
 	flush_iopgd_range(iopgd, iopgd + 15);
@@ -542,6 +554,12 @@ static int iopte_alloc_large(struct iommu *obj, u32 da, u32 pa, u32 prot)
 	u32 *iopte = iopte_alloc(obj, iopgd, da);
 	int i;
 
+	if (pa & ~IOLARGE_MASK) {
+		dev_err(obj->dev, "%s: pa:%08x should aligned on %08lx\n",
+			__func__, pa, IOLARGE_SIZE);
+		return -EINVAL;
+	}
+
 	if (IS_ERR(iopte))
 		return PTR_ERR(iopte);
 
-- 
1.7.1.rc1

