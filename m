From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v3 1/2] OMAP2+: IOMMU: don't print fault warning on specific layer
Date: Wed, 16 Feb 2011 21:35:50 +0200
Message-ID: <1297884951-3019-2-git-send-email-dacohen@gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:60921 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab1BPTbi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 14:31:38 -0500
In-Reply-To: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hiroshi.doyu@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

IOMMU upper layer and user are responsible to handle a fault and to
define whether it will end up as an error or not. OMAP2+ specific
layer should not print anything in such case.

Signed-off-by: David Cohen <dacohen@gmail.com>
---
 arch/arm/mach-omap2/iommu2.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
index 14ee686..49a1e5e 100644
--- a/arch/arm/mach-omap2/iommu2.c
+++ b/arch/arm/mach-omap2/iommu2.c
@@ -145,15 +145,7 @@ static void omap2_iommu_set_twl(struct iommu *obj, bool on)
 
 static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 {
-	int i;
 	u32 stat, da;
-	const char *err_msg[] =	{
-		"tlb miss",
-		"translation fault",
-		"emulation miss",
-		"table walk fault",
-		"multi hit fault",
-	};
 
 	stat = iommu_read_reg(obj, MMU_IRQSTATUS);
 	stat &= MMU_IRQ_MASK;
@@ -163,14 +155,6 @@ static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
 	da = iommu_read_reg(obj, MMU_FAULT_AD);
 	*ra = da;
 
-	dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
-
-	for (i = 0; i < ARRAY_SIZE(err_msg); i++) {
-		if (stat & (1 << i))
-			printk("%s ", err_msg[i]);
-	}
-	printk("\n");
-
 	iommu_write_reg(obj, stat, MMU_IRQSTATUS);
 
 	return stat;
-- 
1.7.2.3

