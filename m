From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 05/27] ARM: OMAP3: dpll3-m2: get rid of obsolete clksel access
Date: Mon, 11 May 2015 11:54:31 +0300
Message-ID: <1431334493-24455-6-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49462 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbbEKIyw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 May 2015 04:54:52 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Core DVFS support code is currently referencing clksel functionality, which
is wrong. The m2 divisor has been implemented as a divider clock for a long
time already, so replace the validrate check call with proper functionality.
Core DVFS is currently not supported in the kernel so verifying this patch
can be rather tricky, this should probably be fixed at some point.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt34xx_dpll3m2.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
index eb69acf..825e3da 100644
--- a/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
+++ b/arch/arm/mach-omap2/clkt34xx_dpll3m2.c
@@ -60,7 +60,9 @@ int omap3_core_dpll_m2_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (!clk || !rate)
 		return -EINVAL;
 
-	validrate = omap2_clksel_round_rate_div(clk, rate, &new_div);
+	new_div = DIV_ROUND_UP(parent_rate, rate);
+	validrate = parent_rate / new_div;
+
 	if (validrate != rate)
 		return -EINVAL;
 
-- 
1.7.9.5

