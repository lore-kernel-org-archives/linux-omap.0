From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 3/4] ARM: DRA7: hwmod: Fix DCAN1 stuck in transition
Date: Mon, 13 Mar 2017 13:53:15 +0200
Message-ID: <1489405996-10718-4-git-send-email-rogerq@ti.com>
References: <1489405996-10718-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489405996-10718-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com
Cc: bcousson@baylibre.com, t-kristo@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Add HWMOD_CLKDM_NOAUTO flag to DCAN1 module.

Without this DCAN1 module remains stuck in transition
after the CAN interface is brought down. This is also suggested
in Errata i893 "DCAN Initialization Sequence".

Add the HWMOD_CLKDM_NOAUTO to DCAN2 module as well
as it is mentioned in Errata i893.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index d058529..896f238 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -359,6 +359,7 @@ static struct omap_hwmod dra7xx_dcan1_hwmod = {
 	.class		= &dra7xx_dcan_hwmod_class,
 	.clkdm_name	= "wkupaon_clkdm",
 	.main_clk	= "dcan1_sys_clk_mux",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_WKUPAON_DCAN1_CLKCTRL_OFFSET,
@@ -374,6 +375,7 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
 	.class		= &dra7xx_dcan_hwmod_class,
 	.clkdm_name	= "l4per2_clkdm",
 	.main_clk	= "sys_clkin1",
+	.flags		= HWMOD_CLKDM_NOAUTO,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = DRA7XX_CM_L4PER2_DCAN2_CLKCTRL_OFFSET,
-- 
2.7.4
