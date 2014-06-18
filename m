From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] ARM: DRA7: hwmod: Fixup SATA hwmod
Date: Wed, 18 Jun 2014 15:16:56 +0300
Message-ID: <1403093816-10960-3-git-send-email-rogerq@ti.com>
References: <1403093816-10960-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1403093816-10960-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com
Cc: rnayak@ti.com, nm@ti.com, kishon@ti.com, george.cherian@ti.com, balbi@ti.com, balajitk@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Get rid of optional clock as that is now managed by the
AHCI platform driver.

Correct .mpu_rt_idx to 1 as the module register space (SYSCONFIG..)
is passed as the second memory resource in the device tree.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Tested-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index cedef6b..bc42eab 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1292,9 +1292,6 @@ static struct omap_hwmod_class dra7xx_sata_hwmod_class = {
 };
 
 /* sata */
-static struct omap_hwmod_opt_clk sata_opt_clks[] = {
-	{ .role = "ref_clk", .clk = "sata_ref_clk" },
-};
 
 static struct omap_hwmod dra7xx_sata_hwmod = {
 	.name		= "sata",
@@ -1302,6 +1299,7 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 	.clkdm_name	= "l3init_clkdm",
 	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
 	.main_clk	= "func_48m_fclk",
+	.mpu_rt_idx	= 1,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
@@ -1309,8 +1307,6 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 			.modulemode   = MODULEMODE_SWCTRL,
 		},
 	},
-	.opt_clks	= sata_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(sata_opt_clks),
 };
 
 /*
-- 
1.8.3.2
