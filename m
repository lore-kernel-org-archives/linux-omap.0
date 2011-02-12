From: David Cohen <dacohen@gmail.com>
Subject: [RFC/PATCH 2/3] OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
Date: Sat, 12 Feb 2011 12:42:52 +0200
Message-ID: <1297507373-1520-3-git-send-email-dacohen@gmail.com>
References: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:38649 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638Ab1BLKnF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Feb 2011 05:43:05 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1719507ewy.19
        for <linux-omap@vger.kernel.org>; Sat, 12 Feb 2011 02:43:04 -0800 (PST)
In-Reply-To: <1297507373-1520-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, David Cohen <dacohen@gmail.com>

IOMMU upper layer is already printing error message. OMAP2+ specific
layer may print error message only for debug purpose.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/mach-omap2/iommu2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 14ee686..641f54a 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -163,7 +163,7 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
 
-	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
+	dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
 
 	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
 		if (stat & (1 << i))
-- 
1.7.1

