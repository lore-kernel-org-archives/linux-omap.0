From: Hari Kanigeri <h-kanigeri2@ti.com>
Subject: [PATCH] omap: iommu- update ducati mmu irq define name
Date: Fri, 14 May 2010 17:55:41 -0500
Message-ID: <1273877741-15635-1-git-send-email-h-kanigeri2@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab0ENWtf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 May 2010 18:49:35 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

2.6.34-rc6 kernel has the Ducati mmu irq define name changed, which is
resulting in compilation error.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index eb9bee7..f5a1aad 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -59,7 +59,7 @@ static struct platform_device *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
 static struct iommu_device omap4_devices[] = {
 	{
 		.base = OMAP4_MMU1_BASE,
-		.irq = INT_44XX_DUCATI_MMU_IRQ,
+		.irq = OMAP44XX_IRQ_DUCATI_MMU,
 		.pdata = {
 			.name = "ducati",
 			.nr_tlb_entries = 32,
-- 
1.7.0

