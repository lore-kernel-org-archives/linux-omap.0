From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 09/12] OMAP2/3 clock: note clockdomains for remaining clocks
Date: Wed, 10 Sep 2008 10:48:01 -0600
Message-ID: <20080910164758.17024.40958.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58271 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988AbYIJQs5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:48:57 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Fill in clockdomains for all remaining clocks.  On OMAP2, these mostly
involve IVA and DSP clocks; on OMAP3, these mostly involve some core_l4_clkdm
devices and the secure peripherals.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |    7 ++++++-
 arch/arm/mach-omap2/clock34xx.h |   26 +++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 5845850..e339f6d 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1090,12 +1090,13 @@ static struct clk dsp_irate_ick = {
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
@@ -1103,6 +1104,7 @@ static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
 };
@@ -1112,6 +1114,7 @@ static struct clk iva2_1_ick = {
 	.name		= "iva2_1_ick",
 	.parent		= &dsp_irate_ick,
 	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.clkdm		= { .name = "dsp_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(OMAP24XX_DSP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
@@ -1691,6 +1694,7 @@ static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2586,6 +2590,7 @@ static struct clk mmchs2_fck = {
 	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 682f43a..8fe87e3 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -795,7 +795,7 @@ static struct clk virt_omap_54m_fck = {
 	.clksel		= virt_omap_54m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
-	.clkdm		= { .name = "cm_clkdm" },
+	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1020,6 +1020,7 @@ static struct clk omap_120m_fck = {
 	.clksel		= omap_120m_fck_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES2 | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "dpll5_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1175,6 +1176,7 @@ static struct clk arm_fck = {
 	.clksel		= arm_fck_clksel,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -1189,6 +1191,7 @@ static struct clk emu_mpu_alwon_ck = {
 	.parent		= &mpu_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "mpu_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1306,6 +1309,7 @@ static struct clk gfx_l3_ck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(GFX_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP_EN_GFX_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "gfx_3430es1_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1459,6 +1463,7 @@ static struct clk ts_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_TS_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1468,6 +1473,7 @@ static struct clk usbtll_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1624,6 +1630,7 @@ static struct clk mcspi4_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1634,6 +1641,7 @@ static struct clk mcspi3_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1644,6 +1652,7 @@ static struct clk mcspi2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1654,6 +1663,7 @@ static struct clk mcspi1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1663,6 +1673,7 @@ static struct clk uart2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1672,6 +1683,7 @@ static struct clk uart1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_UART1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1681,6 +1693,7 @@ static struct clk fshostusb_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES1_EN_FSHOSTUSB_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1701,6 +1714,7 @@ static struct clk hdq_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1739,6 +1753,7 @@ static struct clk ssi_sst_fck = {
 	.parent		= &ssi_ssr_fck,
 	.fixed_div	= 2,
 	.flags		= CLOCK_IN_OMAP343X | PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
@@ -1796,6 +1811,7 @@ static struct clk security_l3_ick = {
 	.parent		= &l3_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -1805,6 +1821,7 @@ static struct clk pka_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_PKA_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l3_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2089,6 +2106,7 @@ static struct clk omapctrl_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_OMAPCTRL_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X | ENABLE_ON_INIT,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2131,6 +2149,7 @@ static struct clk usb_l4_ick = {
 	.clksel_mask	= OMAP3430ES1_CLKSEL_FSHOSTUSB_MASK,
 	.clksel		= usb_l4_clksel,
 	.flags		= CLOCK_IN_OMAP3430ES1,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2143,6 +2162,7 @@ static struct clk security_l4_ick2 = {
 	.parent		= &l4_ick,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
 				PARENT_CONTROLS_CLOCK,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2152,6 +2172,7 @@ static struct clk aes1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_AES1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2161,6 +2182,7 @@ static struct clk rng_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_RNG_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2170,6 +2192,7 @@ static struct clk sha11_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_SHA11_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2179,6 +2202,7 @@ static struct clk des1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
 	.enable_bit	= OMAP3430_EN_DES1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
+	.clkdm		= { .name = "core_l4_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 


