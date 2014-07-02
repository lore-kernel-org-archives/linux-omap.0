From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 08/13] ARM: OMAP2+: clock/dpll: convert bypass check to use clk_features
Date: Wed, 2 Jul 2014 11:47:42 +0300
Message-ID: <1404290867-6768-9-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38803 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbaGBIsC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:48:02 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

OMAP2 DPLL code for checking whether DPLL is in bypass mode now uses
clk_features data provided during boot. This avoids the need to use
cpu_is_X type checks runtime, and allows us to eventually move the
clock code under the clock driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |   25 +++++++++++++------------
 arch/arm/mach-omap2/clock.c     |   17 +++++++++++++++++
 arch/arm/mach-omap2/clock.h     |    1 +
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index f1b052a..51f995a 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -184,18 +184,19 @@ static int _dpll_test_mult(int *m, int n, unsigned long *new_rate,
  */
 static int _omap2_dpll_is_in_bypass(u32 v)
 {
-	if (cpu_is_omap24xx()) {
-		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
-			return 1;
-	} else if (cpu_is_omap34xx()) {
-		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
-			return 1;
-	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx()) {
-		if (v == OMAP4XXX_EN_DPLL_LPBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_FRBYPASS ||
-		    v == OMAP4XXX_EN_DPLL_MNBYPASS)
+	u8 mask, val;
+
+	mask = ti_clk_features.dpll_bypass_vals;
+
+	/*
+	 * Each set bit in the mask corresponds to a bypass value equal
+	 * to the bitshift. Go through each set-bit in the mask and
+	 * compare against the given register value.
+	 */
+	while (mask) {
+		val = __ffs(mask);
+		mask ^= (1 << val);
+		if (v == val)
 			return 1;
 	}
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7efe66e..e438437 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -767,4 +767,21 @@ void __init ti_clk_init_features(void)
 		ti_clk_features.fint_min = OMAP3PLUS_DPLL_FINT_MIN;
 		ti_clk_features.fint_max = OMAP3PLUS_DPLL_FINT_MAX;
 	}
+
+	/* Bypass value setup for DPLLs */
+	if (cpu_is_omap24xx()) {
+		ti_clk_features.dpll_bypass_vals |=
+			(1 << OMAP2XXX_EN_DPLL_LPBYPASS) |
+			(1 << OMAP2XXX_EN_DPLL_FRBYPASS);
+	} else if (cpu_is_omap34xx()) {
+		ti_clk_features.dpll_bypass_vals |=
+			(1 << OMAP3XXX_EN_DPLL_LPBYPASS) |
+			(1 << OMAP3XXX_EN_DPLL_FRBYPASS);
+	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx() ||
+		   soc_is_omap54xx() || soc_is_dra7xx()) {
+		ti_clk_features.dpll_bypass_vals |=
+			(1 << OMAP4XXX_EN_DPLL_LPBYPASS) |
+			(1 << OMAP4XXX_EN_DPLL_FRBYPASS) |
+			(1 << OMAP4XXX_EN_DPLL_MNBYPASS);
+	}
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 02aa2e3..7b2b099 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -232,6 +232,7 @@ struct ti_clk_features {
 	long fint_max;
 	long fint_band1_max;
 	long fint_band2_min;
+	u8 dpll_bypass_vals;
 };
 extern struct ti_clk_features ti_clk_features;
 
-- 
1.7.9.5

