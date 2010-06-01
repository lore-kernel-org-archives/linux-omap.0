From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 1/8] omap iommu: update ducati mmu irq define name
Date: Tue,  1 Jun 2010 08:30:40 +0300
Message-ID: <1275370247-15888-1-git-send-email-Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:30947 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab0FAFba (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jun 2010 01:31:30 -0400
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

From: Kanigeri, Hari <h-kanigeri2@ti.com>

2.6.34-rc6 kernel has the Ducati mmu irq define name changed, which is
resulting in compilation error.

Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
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
1.7.1.rc1

