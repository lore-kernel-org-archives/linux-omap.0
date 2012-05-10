From: Juan Gutierrez <jgutierrez@ti.com>
Subject: [PATCH v4 2/2] omap4: iommu: fix irq and clock name for dsp-iommu
Date: Thu, 10 May 2012 15:09:48 -0500
Message-ID: <1336680588-8572-3-git-send-email-jgutierrez@ti.com>
References: <1336680588-8572-1-git-send-email-jgutierrez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42023 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752801Ab2EJUKI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 16:10:08 -0400
Received: by yhjj72 with SMTP id j72so2118288yhj.12
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 13:10:06 -0700 (PDT)
In-Reply-To: <1336680588-8572-1-git-send-email-jgutierrez@ti.com>
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
Acked-by: Ohad Ben-Cohen <ohad@wizery.com>
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
1.7.1

