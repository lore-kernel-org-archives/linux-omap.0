From: "Tuukka.O Toivonen" <tuukka.o.toivonen@nokia.com>
Subject: [PATCH] ARM: OMAP3: allow setting cam_mclk rate
Date: Wed, 1 Jul 2009 14:27:28 +0300
Message-ID: <200907011427.29318.tuukka.o.toivonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46630 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755675AbZGAL1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 07:27:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: sailus@maxwell.research.nokia.com, camera@ok.research.nokia.com, "Cohen David.A (Nokia-D/Helsinki)" <david.cohen@nokia.com>, "Hurskainen Mikko (Nokia-D/Helsinki)" <mikko.hurskainen@nokia.com>, "core-review@ok.research.nokia.com" <core-review@ok.research.nokia.com>, linux-omap@vger.kernel.org

This patch allows drivers to modify cam_mclk rate which is
used for generating external cam_xclka and cam_xclkb for cameras.

Signed-off-by: Tuukka Toivonen <tuukka.o.toivonen@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |   18 ++++++++++++++++++
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 045da92..667a608 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -898,6 +898,24 @@ static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 	return rate;
 }
 
+/* Clock control for OMAP3 camera */
+
+static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long rate)
+{
+	const unsigned int dpll4_rate = 864000000; /* Hz */
+	int clksel;
+
+	if (rate <= 0)
+		return -EINVAL;
+
+	clksel = (dpll4_rate + (rate>>1)) / rate;
+	clksel = clamp(clksel, 1, 16);
+	cm_write_mod_reg(clksel, OMAP3430_CAM_MOD, CM_CLKSEL);
+	clk->rate = dpll4_rate / clksel;
+
+	return 0;
+}
+
 /* Common clock code */
 
 /*
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index e433aec..bd09709 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -37,6 +37,7 @@ static u32 omap3_dpll_autoidle_read(struct clk *clk);
 static int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate);
 static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate);
 static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate);
+static int omap3_cam_mclk_set_rate(struct clk *clk, unsigned long rate);
 
 /* Maximum DPLL multiplier, divider values for OMAP3 */
 #define OMAP3_MAX_DPLL_MULT		2048
@@ -2342,6 +2343,7 @@ static struct clk uart3_fck = {
 	.enable_bit	= OMAP3430_EN_UART3_SHIFT,
 	.clkdm_name	= "per_clkdm",
 	.recalc		= &followparent_recalc,
+	.set_rate	= &omap3_cam_mclk_set_rate,
 };
 
 static struct clk gpt2_fck = {
-- 
1.5.4.3

