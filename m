From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV3 1/2] OMAP3: Set MPU and IVA bypass Clock Divider
Date: Thu,  1 Apr 2010 18:32:18 +0800
Message-ID: <1270117939-10730-2-git-send-email-vishwanath.bs@ti.com>
References: <>
 <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40188 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644Ab0DAEy6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 1 Apr 2010 00:54:58 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o314stqv005405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 31 Mar 2010 23:54:57 -0500
In-Reply-To: <1270117939-10730-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

DSP usage at VDD1 OPP1 and OPP2 with Smartreflex enabled and any MM
UCs running DSP codec was earlier restricted as DSP crashed.
The root cause is wrong DPLL1/DPLL2 Bypass clock at VDD1 OPP1 and OPP2.
The solution is to make sure DPLL1/DPLL2 bypass clock is always less
than maximum supported frequency for the specific OPP.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d5153b6..d8e57a6
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1149,6 +1149,8 @@ static struct clk dpll1_fck = {
 	.clksel_mask	= OMAP3430_MPU_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 };
 
 static struct clk mpu_ck = {
@@ -1205,6 +1207,8 @@ static struct clk dpll2_fck = {
 	.clksel_mask	= OMAP3430_IVA2_CLK_SRC_MASK,
 	.clksel		= div4_core_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 };
 
 static struct clk iva2_ck = {
@@ -3597,5 +3601,13 @@ int __init omap3xxx_clk_init(void)
 	sdrc_ick_p = clk_get(NULL, "sdrc_ick");
 	arm_fck_p = clk_get(NULL, "arm_fck");
 
+	/* Set the bypass clock dividers for DPLL1 and DPLL2 */
+	if (cpu_is_omap3630()) {
+		clk_set_rate(&dpll1_fck, 400000000/2);
+		clk_set_rate(&dpll2_fck, 400000000/2);
+	} else {
+		clk_set_rate(&dpll1_fck, 332000000/4);
+		clk_set_rate(&dpll2_fck, 332000000/4);
+	}
 	return 0;
 }
-- 
1.5.4.3

