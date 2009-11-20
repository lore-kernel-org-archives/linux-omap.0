From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 4/4] OMAP3: add support for 192Mhz sgx clock
Date: Fri, 20 Nov 2009 20:58:57 +0530
Message-ID: <1258730937-1962-5-git-send-email-vishwanath.bs@ti.com>
References: <1258730937-1962-1-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-2-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-3-git-send-email-vishwanath.bs@ti.com>
 <1258730937-1962-4-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020AbZKTP17 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Nov 2009 10:27:59 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKFS3Gl012815
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 09:28:05 -0600
In-Reply-To: <1258730937-1962-4-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, vishwanath.bs@ti.com

SGX can run at 192MHz on 3630 and this patch has changes to support this
feature. Basically DPLL4 M2 will be 192Mhz which will be used as SGX
Clock. 192Mhz clock is divided by 2 (using CM_CLKSEL_CORE) to generate
96Mh clock

Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c       |   16 +++++++++++++++-
 arch/arm/mach-omap2/clock34xx.h       |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 arch/arm/mach-omap2/id.c              |    7 +++++--
 arch/arm/plat-omap/include/plat/cpu.h |    3 +++
 5 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1e35f9a..bce7e46 100755
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
@@ -1226,7 +1227,20 @@ int __init omap2_clk_init(void)
 				OMAP3630_PERIPH_DPLL_SD_DIV_MASK;
 			dpll4_dd.mult_mask = OMAP3630_PERIPH_DPLL_MULT_MASK;
 			cpu_mask |= RATE_IN_363X;
-			}
+			cpu_clkflg |= CK_363X;
+		}
+
+		if (omap3_has_192mhz_clk()) {
+			omap_96m_alwon_fck.parent = &omap_192m_alwon_ck;
+			omap_96m_alwon_fck.init = &omap2_init_clksel_parent;
+			omap_96m_alwon_fck.clksel_reg =
+					OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL),
+			omap_96m_alwon_fck.clksel_mask =
+						OMAP3630_CLKSEL_96M_MASK;
+			omap_96m_alwon_fck.clksel = omap_96m_alwon_fck_clksel;
+			omap_96m_alwon_fck.recalc = &omap2_clksel_recalc;
+		}
+
 	}
 
 	clk_init(&omap2_clk_functions);
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 93c92e5..6fe89df 100644
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
index a6383f9..39b3399 100644
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
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 3c1194c..b1bc79d 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -176,8 +176,10 @@ void __init omap3_check_features(void)
 	OMAP3_CHECK_FEATURE(status, NEON);
 	OMAP3_CHECK_FEATURE(status, ISP);
 
-	if (cpu_is_omap3630())
-		omap3_features |= OMAP3_HAS_JTYPE_DPLL4;
+	if (cpu_is_omap3630()) {
+		omap3_features |= OMAP3_HAS_JTYPE_DPLL4 |
+							OMAP3_HAS_192MHZ_CLK;
+	}
 	/*
 	 * TODO: Get additional info (where applicable)
 	 *       e.g. Size of L2 cache.
@@ -319,6 +321,7 @@ void __init omap3_cpuinfo(void)
 	OMAP3_SHOW_FEATURE(neon);
 	OMAP3_SHOW_FEATURE(isp);
 	OMAP3_SHOW_FEATURE(jtype_dpll4);
+	OMAP3_SHOW_FEATURE(192mhz_clk);
 	printk(")\n");
 }
 
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 65c08d5..1dffe25 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -498,6 +498,7 @@ extern u32 omap3_features;
 #define OMAP3_HAS_NEON			BIT(3)
 #define OMAP3_HAS_ISP			BIT(4)
 #define OMAP3_HAS_JTYPE_DPLL4		BIT(5)
+#define OMAP3_HAS_192MHZ_CLK		BIT(6)
 
 #define OMAP3_HAS_FEATURE(feat,flag)			\
 static inline unsigned int omap3_has_ ##feat(void)	\
@@ -511,4 +512,6 @@ OMAP3_HAS_FEATURE(iva, IVA)
 OMAP3_HAS_FEATURE(neon, NEON)
 OMAP3_HAS_FEATURE(isp, ISP)
 OMAP3_HAS_FEATURE(jtype_dpll4, JTYPE_DPLL4)
+OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
+
 #endif
-- 
1.5.6.3

