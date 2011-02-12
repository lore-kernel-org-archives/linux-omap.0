From: David Cohen <dacohen@gmail.com>
Subject: [PATCH] omap iommu: print module name on error messages
Date: Sat, 12 Feb 2011 12:02:29 +0200
Message-ID: <1297504949-26233-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:41797 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab1BLKCm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:02:42 -0500
Received: by ewy5 with SMTP id 5so1713465ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:02:40 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, David Cohen <dacohen@gmail.com>

OMAP IOMMU generic layer doesn't need ot print function name during
error messages. Print module name instead which is more useful.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/plat-omap/iommu.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
index b1107c0..f55f458 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/arch/arm/plat-omap/iommu.c
@@ -806,7 +806,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	iopgd = iopgd_offset(obj, da);
 
 	if (!iopgd_is_table(*iopgd)) {
-		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", __func__,
+		dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x\n", obj->name,
 			da, iopgd, *iopgd);
 		return IRQ_NONE;
 	}
@@ -814,7 +814,7 @@ static irqreturn_t iommu_fault_handler(int irq, void *data)
 	iopte = iopte_offset(iopgd, da);
 
 	dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p *pte:%08x\n",
-		__func__, da, iopgd, *iopgd, iopte, *iopte);
+		obj->name, da, iopgd, *iopgd, iopte, *iopte);
 
 	return IRQ_NONE;
 }
-- 
1.7.1

