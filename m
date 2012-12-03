From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 2/4] ARM: OMAP4: Add function table for non-M4X dplls
Date: Mon, 3 Dec 2012 14:41:13 -0600
Message-ID: <1354567275-6447-3-git-send-email-jon-hunter@ti.com>
References: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55724 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752009Ab2LCUl0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Dec 2012 15:41:26 -0500
In-Reply-To: <1354567275-6447-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently all OMAP4 non-core DPLLs use the same function table for
configuring DPLLs. For these DPLLs, the function
omap4_dpll_regm4xen_recalc() is used to recalculate the DPLL rate and
the function omap4_dpll_regm4xen_round_rate() is used to calculate the
closest rate to that requested. However, these omap4_dpll_regm4xen_xxx()
functions are only applicable to the ABE DPLL and not the other non-core
DPLLs. Therefore, add a new function table for non-core DPLLs that do
not include the 4X-multiplier (M4X).

Please note that using these omap4_dpll_regm4x_xxx() function works for
the non-M4X DPLLs today because we only check to see if the 4X
multiplier is enabled when calculating the rate. However, it is planned
that the dpll functions will be enhanced to enable the 4X multiplier as
necessary (in order to achieve the requested rate) and so calling these
functions for non-M4X dplls will no longer work.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index a1f0b55..7c1ffe6 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -365,6 +365,15 @@ static struct dpll_data dpll_iva_dd = {
 
 static struct clk dpll_iva_ck;
 
+static const struct clk_ops dpll_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+
 static struct clk_hw_omap dpll_iva_ck_hw = {
 	.hw = {
 		.clk = &dpll_iva_ck,
@@ -373,7 +382,7 @@ static struct clk_hw_omap dpll_iva_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_iva_ck, dpll_core_ck_parents, dpll_ck_ops);
 
 static const char *dpll_iva_x2_ck_parents[] = {
 	"dpll_iva_ck",
@@ -426,7 +435,7 @@ static struct clk_hw_omap dpll_mpu_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_mpu_ck, dpll_core_ck_parents, dpll_ck_ops);
 
 DEFINE_CLK_FIXED_FACTOR(mpu_periphclk, "dpll_mpu_ck", &dpll_mpu_ck, 0x0, 1, 2);
 
@@ -475,7 +484,7 @@ static struct clk_hw_omap dpll_per_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_per_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_per_ck, dpll_core_ck_parents, dpll_ck_ops);
 
 DEFINE_CLK_DIVIDER(dpll_per_m2_ck, "dpll_per_ck", &dpll_per_ck, 0x0,
 		   OMAP4430_CM_DIV_M2_DPLL_PER, OMAP4430_DPLL_CLKOUT_DIV_SHIFT,
@@ -569,7 +578,7 @@ static struct clk_hw_omap dpll_usb_ck_hw = {
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_core_ck_parents, dpll_abe_ck_ops);
+DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_core_ck_parents, dpll_ck_ops);
 
 static const char *dpll_usb_clkdcoldo_ck_parents[] = {
 	"dpll_usb_ck",
-- 
1.7.9.5

