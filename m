From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 14/16] ARM: OMAP3: hwmod data: cleanup data for IOMMUs
Date: Thu, 13 Feb 2014 12:15:45 -0600
Message-ID: <1392315347-32967-15-git-send-email-s-anna@ti.com>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50111 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752599AbaBMSRj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 13:17:39 -0500
In-Reply-To: <1392315347-32967-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Tony Lindgren <tony@atomide.com>
Cc: Florian Vaussard <florian.vaussard@epfl.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

From: Florian Vaussard <florian.vaussard@epfl.ch>

The irq numbers, ocp address space and device attribute data
have all been cleaned up for OMAP3 IOMMUs. All this data is
populated via the corresponding dt node.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 46 ------------------------------
 1 file changed, 46 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 9c7e23a..d68c131 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -24,7 +24,6 @@
 #include "l4_3xxx.h"
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 #include <linux/platform_data/spi-omap2-mcspi.h>
-#include <linux/platform_data/iommu-omap.h>
 #include <linux/platform_data/mailbox-omap.h>
 #include <plat/dmtimer.h>
 
@@ -2991,83 +2990,39 @@ static struct omap_hwmod_class omap3xxx_mmu_hwmod_class = {
 
 /* mmu isp */
 
-static struct omap_mmu_dev_attr mmu_isp_dev_attr = {
-	.da_start	= 0x0,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 8,
-};
-
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_isp_irqs[] = {
-	{ .irq = 24 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
-
-static struct omap_hwmod_addr_space omap3xxx_mmu_isp_addrs[] = {
-	{
-		.pa_start	= 0x480bd400,
-		.pa_end		= 0x480bd47f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
 
 /* l4_core -> mmu isp */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__mmu_isp = {
 	.master		= &omap3xxx_l4_core_hwmod,
 	.slave		= &omap3xxx_mmu_isp_hwmod,
-	.addr		= omap3xxx_mmu_isp_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_isp_hwmod = {
 	.name		= "mmu_isp",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_isp_irqs,
 	.main_clk	= "cam_ick",
-	.dev_attr	= &mmu_isp_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
 /* mmu iva */
 
-static struct omap_mmu_dev_attr mmu_iva_dev_attr = {
-	.da_start	= 0x11000000,
-	.da_end		= 0xfffff000,
-	.nr_tlb_entries = 32,
-};
-
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod;
-static struct omap_hwmod_irq_info omap3xxx_mmu_iva_irqs[] = {
-	{ .irq = 28 + OMAP_INTC_START, },
-	{ .irq = -1 }
-};
-
 static struct omap_hwmod_rst_info omap3xxx_mmu_iva_resets[] = {
 	{ .name = "mmu", .rst_shift = 1, .st_shift = 9 },
 };
 
-static struct omap_hwmod_addr_space omap3xxx_mmu_iva_addrs[] = {
-	{
-		.pa_start	= 0x5d000000,
-		.pa_end		= 0x5d00007f,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 /* l3_main -> iva mmu */
 static struct omap_hwmod_ocp_if omap3xxx_l3_main__mmu_iva = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_mmu_iva_hwmod,
-	.addr		= omap3xxx_mmu_iva_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
 static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 	.name		= "mmu_iva",
 	.class		= &omap3xxx_mmu_hwmod_class,
-	.mpu_irqs	= omap3xxx_mmu_iva_irqs,
 	.clkdm_name	= "iva2_clkdm",
 	.rst_lines	= omap3xxx_mmu_iva_resets,
 	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_mmu_iva_resets),
@@ -3080,7 +3035,6 @@ static struct omap_hwmod omap3xxx_mmu_iva_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_IVA2_SHIFT,
 		},
 	},
-	.dev_attr	= &mmu_iva_dev_attr,
 	.flags		= HWMOD_NO_IDLEST,
 };
 
-- 
1.8.5.3

