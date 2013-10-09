From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 4/5] ARM: OMAP2+: hwmod: Cleanup usage of HWMOD_INIT_NO_RESET and HWMOD_INIT_NO_IDLE
Date: Wed, 9 Oct 2013 15:42:00 +0530
Message-ID: <1381313521-10422-5-git-send-email-rnayak@ti.com>
References: <1381313521-10422-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46472 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757020Ab3JIKMl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 06:12:41 -0400
In-Reply-To: <1381313521-10422-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

With DT bindings to specify which devices should not be idled and reset
at init being in place, and the corresponding dtsi files for am33xx/omap4
and omap5 updated using those bindings, we can now clean up hwmod internal
flags for HWMOD_INIT_NO_RESET and HWMOD_INIT_NO_IDLE which were infact used
to specify the exact same information.

For GPMC, the HWMOD_INIT_NO_RESET flag seems to be added in hwmod not due to
any errata around the GPMC IP, but rather because any timings
set by the bootloader are not being correctly programmed by the kernel.
This seems like something that needs to be fixed as part of GPMC driver
in the kernel, and hence the flag is left as is in hwmod, which can be
removed once the driver does what its expected to.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    4 +---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c |    2 --
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 2815a91..e8dc72d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -198,7 +198,7 @@ static struct omap_hwmod am33xx_wkup_m3_hwmod = {
 	.class		= &am33xx_wkup_m3_hwmod_class,
 	.clkdm_name	= "l4_wkup_aon_clkdm",
 	/* Keep hardreset asserted */
-	.flags		= HWMOD_INIT_NO_RESET | HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST,
 	.main_clk	= "dpll_core_m4_div2_ck",
 	.prcm		= {
 		.omap4	= {
@@ -932,7 +932,7 @@ static struct omap_hwmod am33xx_gpmc_hwmod = {
 	.name		= "gpmc",
 	.class		= &am33xx_gpmc_hwmod_class,
 	.clkdm_name	= "l3s_clkdm",
-	.flags		= (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+	.flags		= HWMOD_INIT_NO_RESET,
 	.main_clk	= "l3s_gclk",
 	.prcm		= {
 		.omap4	= {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 1e5b12c..a507a70 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -914,7 +914,6 @@ static struct omap_hwmod omap44xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -930,7 +929,6 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap44xx_emif_hwmod_class,
 	.clkdm_name	= "l3_emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "ddrphy_ck",
 	.prcm = {
 		.omap4 = {
@@ -1184,7 +1182,7 @@ static struct omap_hwmod omap44xx_gpmc_hwmod = {
 	 * the kernel from the board file or DT data.
 	 * HWMOD_INIT_NO_RESET should be removed ASAP.
 	 */
-	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_INIT_NO_RESET,
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_L3_2_GPMC_CLKCTRL_OFFSET,
diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
index e3caee1..e47f24d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -352,7 +352,6 @@ static struct omap_hwmod omap54xx_emif1_hwmod = {
 	.name		= "emif1",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
@@ -368,7 +367,6 @@ static struct omap_hwmod omap54xx_emif2_hwmod = {
 	.name		= "emif2",
 	.class		= &omap54xx_emif_hwmod_class,
 	.clkdm_name	= "emif_clkdm",
-	.flags		= HWMOD_INIT_NO_IDLE,
 	.main_clk	= "dpll_core_h11x2_ck",
 	.prcm = {
 		.omap4 = {
-- 
1.7.9.5

