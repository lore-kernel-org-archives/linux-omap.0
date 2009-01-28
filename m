From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH B 05/10] OMAP2/3 clock: add clockdomains to all remaining
	clocks; fix clkdm init
Date: Tue, 27 Jan 2009 19:44:21 -0700
Message-ID: <20090128024418.27240.52292.stgit@localhost.localdomain>
References: <20090128024301.27240.39391.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090128024301.27240.39391.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-omap@vger.kernel.org

Add clockdomains for all remaining clocks without them, and warn in
clk_register() if any are missing a clockdomain.  On OMAP2, call
omap2_init_clk_clkdm() immediately after clk_register(), just as OMAP3
does.  Remove omap2_init_clk_clkdm() from all of the struct clk .init
function pointers, since the OMAP2/3 arch clock init code now calls it.

The following TI documents are used as reference:

OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 TRM Version Q
OMAP2430 Multimedia Device Package-on-Package (POP) Silicon Revision 2.1 TRM
    Version Q
OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.0 Security
    Addendum Version B TRM

The bug caused by the missing call to omap2_init_clk_clkdm() on OMAP2
was reported by Felipe Balbi <felipe.balbi@nokia.com>.

linux-omap source commits are acea9d4a96dc50aa850d4b808aa560020070fe6e,
f2576b3289f6bb58b2a2f0f039aa6caf1f0b7ead,
baee1ca8e61aa9df034e1706052a0eefc193f688, and
61d3e74f1f61a92e45a31014ad93372856d3c9d9.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>.
---
 arch/arm/mach-omap2/clock.c     |    8 ++++---
 arch/arm/mach-omap2/clock24xx.c |    2 ++
 arch/arm/mach-omap2/clock24xx.h |    7 +++++-
 arch/arm/mach-omap2/clock34xx.h |   44 ++++++++++++++++++++++-----------------
 4 files changed, 38 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7aa09f5..d902309 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -77,8 +77,10 @@ void omap2_init_clk_clkdm(struct clk *clk)
 {
 	struct clockdomain *clkdm;
 
-	if (!clk->clkdm.name)
+	if (!clk->clkdm.name) {
+		pr_err("clock: %s: missing clockdomain", clk->name);
 		return;
+	}
 
 	clkdm = clkdm_lookup(clk->clkdm.name);
 	if (clkdm) {
@@ -86,8 +88,8 @@ void omap2_init_clk_clkdm(struct clk *clk)
 			 clk->name, clk->clkdm.name);
 		clk->clkdm.ptr = clkdm;
 	} else {
-		pr_debug("clock: could not associate clk %s to "
-			 "clkdm %s\n", clk->name, clk->clkdm.name);
+		pr_err("clock: %s: could not associate to clkdm %s\n",
+		       clk->name, clk->clkdm.name);
 	}
 }
 
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 9240e64..8533c3a 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -567,11 +567,13 @@ int __init omap2_clk_init(void)
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
 			clk_register(*clkp);
+			omap2_init_clk_clkdm(*clkp);
 			continue;
 		}
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP243X && cpu_is_omap2430()) {
 			clk_register(*clkp);
+			omap2_init_clk_clkdm(*clkp);
 			continue;
 		}
 	}
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 50c3e01..2587c3d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1088,12 +1088,13 @@ static struct clk dsp_irate_ick = {
 	.parent		= &dsp_fck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
 				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dsp_clkdm" },
 	.clksel_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_CLKSEL),
 	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
 	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
 	.round_rate	= &omap2_clksel_round_rate,
-	.set_rate	      = &omap2_clksel_set_rate
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* 2420 only */
@@ -1101,6 +1102,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
@@ -1110,6 +1112,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
@@ -1689,6 +1692,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2582,6 +2586,7 @@ static struct clk mmchs2_fck = {
 	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index e1650f2..781da12 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -790,7 +790,7 @@ static struct clk virt_omap_54m_fck = {
 	.clksel		= virt_omap_54m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "cm_clkdm" },
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1017,6 +1017,7 @@ static struct clk omap_120m_fck = {
 	.clksel		= omap_120m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1165,6 +1166,7 @@ static struct clk arm_fck = {
 	.clksel		= arm_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1179,6 +1181,7 @@ static struct clk emu_mpu_alwon_ck = {
 	.parent		= &mpu_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1291,6 +1294,7 @@ static struct clk gfx_l3_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "gfx_3430es1_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1318,7 +1322,6 @@ static struct clk gfx_l3_ick = {
 static struct clk gfx_cg1_ck = {
 	.name		= "gfx_cg1_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1329,7 +1332,6 @@ static struct clk gfx_cg1_ck = {
 static struct clk gfx_cg2_ck = {
 	.name		= "gfx_cg2_ck",
 	.parent		= &gfx_l3_fck, /* REVISIT: correct? */
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES1_EN_3D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1373,7 +1375,6 @@ static struct clk sgx_fck = {
 static struct clk sgx_ick = {
 	.name		= "sgx_ick",
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_SGX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_CM_ICLKEN_SGX_EN_SGX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -1386,7 +1387,6 @@ static struct clk sgx_ick = {
 static struct clk d2d_26m_fck = {
 	.name		= "d2d_26m_fck",
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_D2D_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
@@ -1444,6 +1444,7 @@ static struct clk ts_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1453,6 +1454,7 @@ static struct clk usbtll_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1608,6 +1610,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1618,6 +1621,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1628,6 +1632,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1638,6 +1643,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1647,6 +1653,7 @@ static struct clk uart2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1656,6 +1663,7 @@ static struct clk uart1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1665,6 +1673,7 @@ static struct clk fshostusb_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1685,6 +1694,7 @@ static struct clk hdq_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1723,6 +1733,7 @@ static struct clk ssi_sst_fck = {
 	.parent		= &ssi_ssr_fck,
 	.fixed_div	= 2,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1737,7 +1748,6 @@ static struct clk ssi_sst_fck = {
 static struct clk core_l3_ick = {
 	.name		= "core_l3_ick",
 	.parent		= &l3_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l3_clkdm" },
@@ -1780,6 +1790,7 @@ static struct clk security_l3_ick = {
 	.parent		= &l3_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1789,6 +1800,7 @@ static struct clk pka_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1797,7 +1809,6 @@ static struct clk pka_ick = {
 static struct clk core_l4_ick = {
 	.name		= "core_l4_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "core_l4_clkdm" },
@@ -2072,6 +2083,7 @@ static struct clk omapctrl_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2114,6 +2126,7 @@ static struct clk usb_l4_ick = {
 	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
 	.clksel		= usb_l4_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2126,6 +2139,7 @@ static struct clk security_l4_ick2 = {
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2135,6 +2149,7 @@ static struct clk aes1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2144,6 +2159,7 @@ static struct clk rng_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2153,6 +2169,7 @@ static struct clk sha11_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2162,6 +2179,7 @@ static struct clk des1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2189,7 +2207,6 @@ static struct clk dss1_alwon_fck = {
 static struct clk dss_tv_fck = {
 	.name		= "dss_tv_fck",
 	.parent		= &omap_54m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2200,7 +2217,6 @@ static struct clk dss_tv_fck = {
 static struct clk dss_96m_fck = {
 	.name		= "dss_96m_fck",
 	.parent		= &omap_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_TV_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2211,7 +2227,6 @@ static struct clk dss_96m_fck = {
 static struct clk dss2_alwon_fck = {
 	.name		= "dss2_alwon_fck",
 	.parent		= &sys_ck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_DSS2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2223,7 +2238,6 @@ static struct clk dss_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "dss_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_DSS_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_CM_ICLKEN_DSS_EN_DSS_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2257,7 +2271,6 @@ static struct clk cam_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "cam_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_CAM_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2268,7 +2281,6 @@ static struct clk cam_ick = {
 static struct clk csi2_96m_fck = {
 	.name		= "csi2_96m_fck",
 	.parent		= &core_96m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
@@ -2281,7 +2293,6 @@ static struct clk csi2_96m_fck = {
 static struct clk usbhost_120m_fck = {
 	.name		= "usbhost_120m_fck",
 	.parent		= &omap_120m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST2_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2292,7 +2303,6 @@ static struct clk usbhost_120m_fck = {
 static struct clk usbhost_48m_fck = {
 	.name		= "usbhost_48m_fck",
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST1_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2304,7 +2314,6 @@ static struct clk usbhost_ick = {
 	/* Handles both L3 and L4 clocks */
 	.name		= "usbhost_ick",
 	.parent		= &l4_ick,
-	.init		= &omap2_init_clk_clkdm,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USBHOST_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
@@ -2367,7 +2376,6 @@ static struct clk gpt1_fck = {
 
 static struct clk wkup_32k_fck = {
 	.name		= "wkup_32k_fck",
-	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
 	.clkdm		= { .name = "prm_clkdm" },
@@ -2481,7 +2489,6 @@ static struct clk gpt1_ick = {
 static struct clk per_96m_fck = {
 	.name		= "per_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },
@@ -2491,7 +2498,6 @@ static struct clk per_96m_fck = {
 static struct clk per_48m_fck = {
 	.name		= "per_48m_fck",
 	.parent		= &omap_48m_fck,
-	.init		= &omap2_init_clk_clkdm,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "per_clkdm" },



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
