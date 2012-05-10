From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v3 2/2] omap4: iommu: fix irq and clock name for dsp-iommu
Date: Wed,  9 May 2012 21:19:30 -0500
Message-ID: <1336616370-28268-3-git-send-email-jgutierrez@ti.com>
References: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:40306 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752532Ab2EJCTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 22:19:51 -0400
Received: by obbuo13 with SMTP id uo13so2272881obb.1
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 19:19:50 -0700 (PDT)
In-Reply-To: <1336616370-28268-1-git-send-email-jgutierrez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ohad@wizery.com
Cc: Juan Gutierrez <jgutierrez@ti.com>

Irq and clock names were wrong for dsp iommu configuration
for omap4.

- Renamed tesla_ick to dsp_fck:
   This is required because the new naming convention introduced
   by: commit 0e43327 "OMAP4 clock: Fix clock names and align
   with hwmod names"

- Renamed INT_44XX_DSP_MMU to OMAP44XX_IRQ_TESLA_MMU.
   Naming convention adopted since: commit e927f8d "omap4: Add
   auto-generated irq and dma headers"

- dsp-iommu is enabled by default.

Signed-off-by: Juan Gutierrez <jgutierrez@ti.com>
---
 arch/arm/mach-omap2/omap-iommu.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index ac49384..1be8bcb 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -73,19 +73,17 @@ static struct iommu_device omap4_devices[] = {
 			.da_end = 0xFFFFF000,
 		},
 	},
-#if defined(CONFIG_MPU_TESLA_IOMMU)
 	{
 		.base = OMAP4_MMU2_BASE,
-		.irq = INT_44XX_DSP_MMU,
+		.irq = OMAP44XX_IRQ_TESLA_MMU,
 		.pdata = {
 			.name = "tesla",
 			.nr_tlb_entries = 32,
-			.clk_name = "tesla_ick",
+			.clk_name = "dsp_fck",
 			.da_start = 0x0,
 			.da_end = 0xFFFFF000,
 		},
 	},
-#endif
 };
 #define NR_OMAP4_IOMMU_DEVICES ARRAY_SIZE(omap4_devices)
 static struct platform_device *omap4_iommu_pdev[NR_OMAP4_IOMMU_DEVICES];
-- 
1.7.5.4

