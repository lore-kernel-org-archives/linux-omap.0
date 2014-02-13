From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 15/16] ARM: OMAP4: hwmod data: cleanup data for IOMMUs
Date: Thu, 13 Feb 2014 12:15:46 -0600
Message-ID: <1392315347-32967-16-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54974 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbaBMSRn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 13:17:43 -0500
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

From: Florian Vaussard <florian.vaussard@epfl.ch>

The device attribute data and ocp address space have all been
cleaned up for OMAP4 iommus. All this data is populated via
the corresponding dt node.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 35 ------------------------------
 1 file changed, 35 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3318cae9..caca6c2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -29,7 +29,6 @@
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
-#include <linux/platform_data/iommu-omap.h>
 #include <plat/dmtimer.h>
 
 #include "omap_hwmod.h"
@@ -2083,32 +2082,16 @@ static struct omap_hwmod_class omap44xx_mmu_hwmod_class = {
 
 /* mmu ipu */
 
-static struct omap_mmu_dev_attr mmu_ipu_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap44xx_mmu_ipu_hwmod;
 static struct omap_hwmod_rst_info omap44xx_mmu_ipu_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 2 },
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmu_ipu_addrs[] = {
-	{
-		.pa_start	= 0x55082000,
-		.pa_end		= 0x550820ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l3_main_2 -> mmu_ipu */
 static struct omap_hwmod_ocp_if omap44xx_l3_main_2__mmu_ipu = {
 	.master		= &omap44xx_l3_main_2_hwmod,
 	.slave		= &omap44xx_mmu_ipu_hwmod,
 	.clk		= "l3_div_ck",
-	.addr		= omap44xx_mmu_ipu_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2127,37 +2110,20 @@ static struct omap_hwmod omap44xx_mmu_ipu_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.dev_attr	= &mmu_ipu_dev_attr,
 };
 
 /* mmu dsp */
 
-static struct omap_mmu_dev_attr mmu_dsp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap44xx_mmu_dsp_hwmod;
 static struct omap_hwmod_rst_info omap44xx_mmu_dsp_resets[] = {
 	{ .name = "mmu_cache", .rst_shift = 1 },
 };
 
-static struct omap_hwmod_addr_space omap44xx_mmu_dsp_addrs[] = {
-	{
-		.pa_start	= 0x4a066000,
-		.pa_end		= 0x4a0660ff,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l4_cfg -> dsp */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mmu_dsp = {
 	.master		= &omap44xx_l4_cfg_hwmod,
 	.slave		= &omap44xx_mmu_dsp_hwmod,
 	.clk		= "l4_div_ck",
-	.addr		= omap44xx_mmu_dsp_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
@@ -2176,7 +2142,6 @@ static struct omap_hwmod omap44xx_mmu_dsp_hwmod = {
 			.modulemode   = MODULEMODE_HWCTRL,
 		},
 	},
-	.dev_attr	= &mmu_dsp_dev_attr,
 };
 
 /*
-- 
1.8.5.3

