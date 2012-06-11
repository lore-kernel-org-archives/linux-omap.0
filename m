From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv2 11/12] ARM: OMAP4: clock data: add clockdomains for clocks
 used as main clocks
Date: Sun, 10 Jun 2012 18:46:26 -0600
Message-ID: <20120611004623.20034.52760.stgit@dusk>
References: <20120611004502.20034.8840.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42606 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752495Ab2FKAwM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Jun 2012 20:52:12 -0400
In-Reply-To: <20120611004502.20034.8840.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Until the OMAP4 code is converted to disable the use of the clock
framework-based clockdomain enable/disable sequence, any clock used as
a hwmod main_clk must have a clockdomain associated with it.  This
patch populates some clock structure clockdomain names to resolve the
following warnings during kernel init:

omap_hwmod: dpll_mpu_m2_ck: missing clockdomain for dpll_mpu_m2_ck.
omap_hwmod: trace_clk_div_ck: missing clockdomain for trace_clk_div_ck.
omap_hwmod: l3_div_ck: missing clockdomain for l3_div_ck.
omap_hwmod: ddrphy_ck: missing clockdomain for ddrphy_ck.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2=
/clock44xx_data.c
index 2172f66..e2b701e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -84,6 +84,7 @@ static struct clk slimbus_clk =3D {
=20
 static struct clk sys_32k_ck =3D {
 	.name		=3D "sys_32k_ck",
+	.clkdm_name	=3D "prm_clkdm",
 	.rate		=3D 32768,
 	.ops		=3D &clkops_null,
 };
@@ -512,6 +513,7 @@ static struct clk ddrphy_ck =3D {
 	.name		=3D "ddrphy_ck",
 	.parent		=3D &dpll_core_m2_ck,
 	.ops		=3D &clkops_null,
+	.clkdm_name	=3D "l3_emif_clkdm",
 	.fixed_div	=3D 2,
 	.recalc		=3D &omap_fixed_divisor_recalc,
 };
@@ -769,6 +771,7 @@ static const struct clksel dpll_mpu_m2_div[] =3D {
 static struct clk dpll_mpu_m2_ck =3D {
 	.name		=3D "dpll_mpu_m2_ck",
 	.parent		=3D &dpll_mpu_ck,
+	.clkdm_name	=3D "cm_clkdm",
 	.clksel		=3D dpll_mpu_m2_div,
 	.clksel_reg	=3D OMAP4430_CM_DIV_M2_DPLL_MPU,
 	.clksel_mask	=3D OMAP4430_DPLL_CLKOUT_DIV_MASK,
@@ -1149,6 +1152,7 @@ static const struct clksel l3_div_div[] =3D {
 static struct clk l3_div_ck =3D {
 	.name		=3D "l3_div_ck",
 	.parent		=3D &div_core_ck,
+	.clkdm_name	=3D "cm_clkdm",
 	.clksel		=3D l3_div_div,
 	.clksel_reg	=3D OMAP4430_CM_CLKSEL_CORE,
 	.clksel_mask	=3D OMAP4430_CLKSEL_L3_MASK,
@@ -2824,6 +2828,7 @@ static const struct clksel trace_clk_div_div[] =3D=
 {
 static struct clk trace_clk_div_ck =3D {
 	.name		=3D "trace_clk_div_ck",
 	.parent		=3D &pmd_trace_clk_mux_ck,
+	.clkdm_name	=3D "emu_sys_clkdm",
 	.clksel		=3D trace_clk_div_div,
 	.clksel_reg	=3D OMAP4430_CM_EMU_DEBUGSS_CLKCTRL,
 	.clksel_mask	=3D OMAP4430_CLKSEL_PMD_TRACE_CLK_MASK,


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
