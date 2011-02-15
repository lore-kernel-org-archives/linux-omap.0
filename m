From: David Cohen <dacohen@gmail.com>
Subject: [PATCH 1/2] OMAP2+: IOMMU: change OMAP2+ error message to dev_dbg()
Date: Tue, 15 Feb 2011 15:20:32 +0200
Message-ID: <1297776033-8579-2-git-send-email-dacohen@gmail.com>
References: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:47795 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357Ab1BONPh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 08:15:37 -0500
In-Reply-To: <1297776033-8579-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi.DOYU@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

IOMMU upper layer is already printing error message. OMAP2+ specific
layer may print error message only for debug purpose.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/mach-omap2/iommu2.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 14ee686..4244a07 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -163,13 +163,13 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
 
-	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
+	dev_dbg(obj->dev, "%s:\tda:%08x ", __func__, da);
 
 	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
 		if (stat & (1 << i))
-			printk("%s ", err_msg[i]);
+			printk(KERN_DEBUG "%s ", err_msg[i]);
 	}
-	printk("\n");
+	printk(KERN_DEBUG "\n");
 
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
 
-- 
1.7.2.3

