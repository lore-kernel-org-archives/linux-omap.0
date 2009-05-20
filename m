From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 7/7] omap iommu: add MPU_BRIDGE_IOMMU for tidspbridge migration
Date: Wed, 20 May 2009 09:42:42 +0300
Message-ID: <20090520064242.24734.73350.stgit@oreo.research.nokia.com>
References: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:52902 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220AbZETGn0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 02:43:26 -0400
In-Reply-To: <20090520064211.24734.80725.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, omar.ramirez@ti.com, sakari.ailus@maxwell.research.nokia.com, tony@atomide.com

Currently "tidspbridge" driver uses its own mmu implementation and
will migrate to use this "omap iommu" eventually. This config is
provided to make this migration happen smoothly.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/mach-omap2/omap3-iommu.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap3-iommu.c b/arch/arm/mach-omap2/omap3-iommu.c
index 91ee38a..194189c 100644
--- a/arch/arm/mach-omap2/omap3-iommu.c
+++ b/arch/arm/mach-omap2/omap3-iommu.c
@@ -36,11 +36,13 @@ static const struct iommu_platform_data omap3_iommu_pdata[] __initconst = {
 		.nr_tlb_entries = 8,
 		.clk_name = "cam_ick",
 	},
+#if defined(CONFIG_MPU_BRIDGE_IOMMU)
 	{
 		.name = "iva2",
 		.nr_tlb_entries = 32,
 		.clk_name = "iva2_ck",
 	},
+#endif
 };
 #define NR_IOMMU_DEVICES ARRAY_SIZE(omap3_iommu_pdata)
 

