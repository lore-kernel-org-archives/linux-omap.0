From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 2/2 v2] ARM: DRA7/335x/437x: hwmod: Remove gpmc address space from hwmod data
Date: Thu, 15 Oct 2015 11:27:41 -0500
Message-ID: <1444926461-16092-2-git-send-email-fcooper@ti.com>
References: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444926461-16092-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
Cc: Franklin S Cooper Jr <fcooper@ti.com>
List-Id: linux-omap@vger.kernel.org

GPMC address information is provided by device tree. No longer need
to include this information within hwmod.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 2 changes:
None

 arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c | 10 ----------
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c                    | 10 ----------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
index 9ba431c..1c210cb 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -275,20 +275,10 @@ struct omap_hwmod_ocp_if am33xx_epwmss2__ehrpwm2 = {
 };
 
 /* l3s cfg -> gpmc */
-static struct omap_hwmod_addr_space am33xx_gpmc_addr_space[] = {
-	{
-		.pa_start	= 0x50000000,
-		.pa_end		= 0x50000000 + SZ_8K - 1,
-		.flags		= ADDR_TYPE_RT,
-	},
-	{ }
-};
-
 struct omap_hwmod_ocp_if am33xx_l3_s__gpmc = {
 	.master		= &am33xx_l3_s_hwmod,
 	.slave		= &am33xx_gpmc_hwmod,
 	.clk		= "l3s_gclk",
-	.addr		= am33xx_gpmc_addr_space,
 	.user		= OCP_USER_MPU,
 };
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index ad2cc7a..7bf106a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -2638,21 +2638,11 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio8 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_gpmc_addrs[] = {
-	{
-		.pa_start	= 0x50000000,
-		.pa_end		= 0x500003ff,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l3_main_1 -> gpmc */
 static struct omap_hwmod_ocp_if dra7xx_l3_main_1__gpmc = {
 	.master		= &dra7xx_l3_main_1_hwmod,
 	.slave		= &dra7xx_gpmc_hwmod,
 	.clk		= "l3_iclk_div",
-	.addr		= dra7xx_gpmc_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-- 
2.6.1
