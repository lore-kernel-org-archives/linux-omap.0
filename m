From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 7/8] OMAP4: clock data: Export control to enable/disable CORE/PER M3 clocks
Date: Thu, 9 Dec 2010 23:13:39 +0100
Message-ID: <1291932820-11163-8-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55472 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757379Ab0LIWOO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Dec 2010 17:14:14 -0500
In-Reply-To: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

The CORE and PER M3 post dividers are different from the rest of the
DPLL post dividers as in they go to SCRM, and are used
there to export clocks for instance used by external sensor.

There is no automatic HW dependency in PRCM to manage them. Hence these
two clocks (dpll post dividers) should be managed by SW and explicitly
enabled/disabled.

Add control in clock framework to handle that.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index fd7efe8..51f28a0 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -610,7 +610,9 @@ static struct clk dpll_core_m3x2_ck = {
 	.clksel		= dpll_core_m6x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_CORE,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
@@ -869,7 +871,9 @@ static struct clk dpll_per_m3x2_ck = {
 	.clksel		= dpll_per_m2x2_div,
 	.clksel_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
 	.clksel_mask	= OMAP4430_DPLL_CLKOUTHIF_DIV_MASK,
-	.ops		= &clkops_null,
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_DIV_M3_DPLL_PER,
+	.enable_bit	= OMAP4430_DPLL_CLKOUTHIF_GATE_CTRL_SHIFT,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
 	.set_rate	= &omap2_clksel_set_rate,
-- 
1.7.0.4

