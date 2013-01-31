From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2] ARM: omap4: clock data: Add missing clkdm association for dpll_usb
Date: Thu, 31 Jan 2013 17:05:12 +0530
Message-ID: <1359632112-9808-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46992 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580Ab3AaLfW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Jan 2013 06:35:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: mturquette@linaro.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

dpll_usb needs the clkdm association so the clkdm can be
turned on before a relock. All other dplls for omap4 belong
to the ALWON (always on) domain.

The association was present as part of the older data file
(clock44xx_data.c) but looks like got accidently dropped with
the common clk convertion.

More details of the patch which fixed this up in the older
data file can be dound here..
http://www.spinics.net/lists/linux-omap/msg63076.html

Adding the .clkdm_name as part of the clk_hw_omap struct also
means a new .init needs to be part of the clk_ops for dpll_usb
to initialise the clkdm.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cclock44xx_data.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index a2cc046..e71a19c 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -595,15 +595,26 @@ static const char *dpll_usb_ck_parents[] = {
 
 static struct clk dpll_usb_ck;
 
+static const struct clk_ops dpll_usb_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+	.init		= &omap2_init_clk_clkdm,
+};
+
 static struct clk_hw_omap dpll_usb_ck_hw = {
 	.hw = {
 		.clk = &dpll_usb_ck,
 	},
 	.dpll_data	= &dpll_usb_dd,
+	.clkdm_name	= "l3_init_clkdm",
 	.ops		= &clkhwops_omap3_dpll,
 };
 
-DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_ck_ops);
+DEFINE_STRUCT_CLK(dpll_usb_ck, dpll_usb_ck_parents, dpll_usb_ck_ops);
 
 static const char *dpll_usb_clkdcoldo_ck_parents[] = {
 	"dpll_usb_ck",
-- 
1.7.9.5

