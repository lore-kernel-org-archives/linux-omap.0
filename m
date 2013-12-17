From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 6/7] ARM: OMAP2+: Remove legacy data from hwmod for omap3 isp iommu
Date: Tue, 17 Dec 2013 13:53:37 +0100
Message-ID: <1387284818-28739-7-git-send-email-florian.vaussard@epfl.ch>
References: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:36800 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430Ab3LQMyR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Dec 2013 07:54:17 -0500
In-Reply-To: <1387284818-28739-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Grant Likely <grant.likely@linaro.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Florian Vaussard <florian.vaussard@epfl.ch>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The data are now passed using the devicetree.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0477131..6dccd46 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2469,15 +2469,8 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
 
 /* mmu isp */
 
-static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 8,
-};
-
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
 
-
 /* l4_core -> mmu isp */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
 	.master		= &omap3xxx_l4_core_hwmod,
@@ -2489,7 +2482,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.name		= "mmu_isp",
 	.class		= &omap3xxx_mmu_hwmod_class,
 	.main_clk	= "cam_ick",
-	.dev_attr	= &mmu_isp_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-- 
1.8.1.2

