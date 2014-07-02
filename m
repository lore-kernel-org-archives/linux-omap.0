From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/13] ARM: OMAP2+: clock/interface: add a clk_features definition for idlest value
Date: Wed, 2 Jul 2014 11:47:44 +0300
Message-ID: <1404290867-6768-11-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38805 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024AbaGBIsH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:48:07 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Helps to get rid of some runtime cpu_is_x checks. This also allows eventual
migration of the code under clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   18 +++++++++++-------
 arch/arm/mach-omap2/clock.h |    1 +
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 23b5f05..5a0cac9 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -305,13 +305,7 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 	 * 34xx reverses this, just to keep us on our toes
 	 * AM35xx uses both, depending on the module.
 	 */
-	if (cpu_is_omap24xx())
-		*idlest_val = OMAP24XX_CM_IDLEST_VAL;
-	else if (cpu_is_omap34xx())
-		*idlest_val = OMAP34XX_CM_IDLEST_VAL;
-	else
-		BUG();
-
+	*idlest_val = ti_clk_features.cm_idlest_val;
 }
 
 /**
@@ -788,4 +782,14 @@ void __init ti_clk_init_features(void)
 	/* Jitter correction only available on OMAP343X */
 	if (cpu_is_omap343x())
 		ti_clk_features.flags |= TI_CLK_DPLL_HAS_FREQSEL;
+
+	/* Idlest value for interface clocks.
+	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
+	 * 34xx reverses this, just to keep us on our toes
+	 * AM35xx uses both, depending on the module.
+	 */
+	if (cpu_is_omap24xx())
+		ti_clk_features.cm_idlest_val = OMAP24XX_CM_IDLEST_VAL;
+	else if (cpu_is_omap34xx())
+		ti_clk_features.cm_idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d3ef147..0f100dc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -233,6 +233,7 @@ struct ti_clk_features {
 	long fint_band1_max;
 	long fint_band2_min;
 	u8 dpll_bypass_vals;
+	u8 cm_idlest_val;
 };
 
 #define TI_CLK_DPLL_HAS_FREQSEL		(1 << 0)
-- 
1.7.9.5

