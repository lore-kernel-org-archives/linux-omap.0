From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: [PATCH 4/4] OMAP3: add support for 192Mhz sgx clock
Date: Wed, 18 Nov 2009 19:46:23 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC35608702FA7510C6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41673 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756888AbZKROQV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 09:16:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAIEGPSe005365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 08:16:27 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAIEGOtj001705
	for <linux-omap@vger.kernel.org>; Wed, 18 Nov 2009 19:46:24 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

SGX can run at 192MHz on 3630 and this patch has changes to support this feature.

Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c       |   10 ++++++++++
 arch/arm/mach-omap2/clock34xx.h       |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 3 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 77b88aa..885043e 100755
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -128,6 +128,7 @@ static struct omap_clk omap34xx_clks[] = {
 	CLK(NULL,	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_3XXX),
 	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_3XXX),
 	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_3XXX),
+       CLK(NULL,       "omap_192m_alwon_ck", &omap_192m_alwon_ck, CK_363X),
 	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_3XXX),
 	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_3XXX),
 	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_3XXX),
@@ -1224,6 +1225,15 @@ int __init omap2_clk_init(void)
 			dpll4_ck.dpll_data->sd_div_mask = OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
 			dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
 			cpu_mask |= RATE_IN_363X;
+			cpu_clkflg |= CK_363X;
+			omap_96m_alwon_fck.parent = &omap_192m_alwon_ck;
+			omap_96m_alwon_fck.init = &omap2_init_clksel_parent;
+			omap_96m_alwon_fck.clksel_reg =
+					OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+			omap_96m_alwon_fck.clksel_mask =
+						OMAP3630_CLKSEL_96M_MASK;
+			omap_96m_alwon_fck.clksel = omap_96m_alwon_fck_clksel;
+			omap_96m_alwon_fck.recalc = &omap2_clksel_recalc;
 			}
 	}
 
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 93c92e5..6fe89df 100755
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -654,12 +654,31 @@ static struct clk dpll4_m2x2_ck = {
 	.recalc		= &omap3_clkoutx2_recalc,
 };
 
+/* Adding 192MHz Clock node needed by SGX */
+static struct clk omap_192m_alwon_ck = {
+	.name           = "omap_192m_alwon_ck",
+	.ops            = &clkops_null,
+	.parent         = &dpll4_m2x2_ck,
+	.recalc         = &followparent_recalc,
+};
+
 /*
  * DPLL4 generates DPLL4_M2X2_CLK which is then routed into the PRM as
  * PRM_96M_ALWON_(F)CLK.  Two clocks then emerge from the PRM:
  * 96M_ALWON_FCLK (called "omap_96m_alwon_fck" below) and
  * CM_96K_(F)CLK.
  */
+static const struct clksel_rate omap_96m_alwon_fck_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_363X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_363X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap_96m_alwon_fck_clksel[] = {
+	{ .parent = &omap_192m_alwon_ck, .rates = omap_96m_alwon_fck_rates },
+	{ .parent = NULL }
+};
+
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.ops		= &clkops_null,
@@ -1223,6 +1242,18 @@ static const struct clksel_rate sgx_core_rates[] = {
 	{ .div = 3, .val = 0, .flags = RATE_IN_3XXX | DEFAULT_RATE },
 	{ .div = 4, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 6, .val = 2, .flags = RATE_IN_3XXX },
+	{ .div = 2, .val = 5, .flags = RATE_IN_363X },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate sgx_192m_rates[] = {
+	{ .div = 1,  .val = 4, .flags = RATE_IN_363X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate sgx_corex2_rates[] = {
+	{ .div = 3, .val = 6, .flags = RATE_IN_363X | DEFAULT_RATE },
+	{ .div = 5, .val = 7, .flags = RATE_IN_363X },
 	{ .div = 0 },
 };
 
@@ -1234,6 +1265,8 @@ static const struct clksel_rate sgx_96m_rates[] = {
 static const struct clksel sgx_clksel[] = {
 	{ .parent = &core_ck,	 .rates = sgx_core_rates },
 	{ .parent = &cm_96m_fck, .rates = sgx_96m_rates },
+	{ .parent = &omap_192m_alwon_ck, .rates = sgx_192m_rates },
+	{ .parent = &corex2_fck, .rates = sgx_corex2_rates },
 	{ .parent = NULL },
 };
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a6383f9..39b3399 100755
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -336,6 +336,8 @@
 #define OMAP3430_CLKSEL_L4_MASK				(0x3 << 2)
 #define OMAP3430_CLKSEL_L3_SHIFT			0
 #define OMAP3430_CLKSEL_L3_MASK				(0x3 << 0)
+#define OMAP3630_CLKSEL_96M_SHIFT                      12
+#define OMAP3630_CLKSEL_96M_MASK                       (0x3 << 12)
 
 /* CM_CLKSTCTRL_CORE */
 #define OMAP3430ES1_CLKTRCTRL_D2D_SHIFT			4
-- 
1.5.6.3

