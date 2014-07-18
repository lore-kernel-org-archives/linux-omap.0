From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 2/3] ARM: omap: Don't set iommu pdata da_start and da_end fields
Date: Fri, 18 Jul 2014 12:49:56 +0200
Message-ID: <1405680597-10012-3-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42818 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761357AbaGRKtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jul 2014 06:49:55 -0400
In-Reply-To: <1405680597-10012-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Florian Vaussard <florian.vaussard@epfl.ch>

The fields are not used by the driver and will be removed from platform
data. Don't set them.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/omap-iommu.c           | 2 --
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 4 ----
 3 files changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
index f1fab56..4068350 100644
--- a/arch/arm/mach-omap2/omap-iommu.c
+++ b/arch/arm/mach-omap2/omap-iommu.c
@@ -34,8 +34,6 @@ static int __init omap_iommu_dev_init(struct omap_hwmod *oh, void *unused)
 
 	pdata->name = oh->name;
 	pdata->nr_tlb_entries = a->nr_tlb_entries;
-	pdata->da_start = a->da_start;
-	pdata->da_end = a->da_end;
 
 	if (oh->rst_lines_cnt == 1) {
 		pdata->reset_name = oh->rst_lines->name;
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 1cd0cfd..e9516b4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2986,8 +2986,6 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
 /* mmu isp */
 
 static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
 	.nr_tlb_entries = 8,
 };
 
@@ -3026,8 +3024,6 @@ static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 /* mmu iva */
 
 static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
-	.da_start	= 0x11000000,
-	.da_end		= 0xfffff000,
 	.nr_tlb_entries = 32,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 41e54f7..b4acc0a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -2084,8 +2084,6 @@ static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
 /* mmu ipu */
 
 static struct omap_mmu_dev_attr mmu_ipu_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
 	.nr_tlb_entries = 32,
 };
 
@@ -2133,8 +2131,6 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 /* mmu dsp */
 
 static struct omap_mmu_dev_attr mmu_dsp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
 	.nr_tlb_entries = 32,
 };
 
-- 
1.8.5.5

