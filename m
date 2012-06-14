From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/3] ARM: OMAP3: Move McBSP fck clock alias to hwmod data
Date: Thu, 14 Jun 2012 15:27:26 +0300
Message-ID: <1339676846-12791-4-git-send-email-peter.ujfalusi@ti.com>
References: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:60609 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab2FNM11 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:27:27 -0400
Received: by lboj14 with SMTP id j14so2749677lbo.21
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 05:27:23 -0700 (PDT)
In-Reply-To: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the existing alias for pad_fck, prcm_fck from the clock data and
add them as opt_clks to the hwmod data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c       |   10 ----------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 4e1a3b0..d6889b5 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -3236,11 +3236,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
 	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_3XXX),
-	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
-	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
-	CLK("omap-mcbsp.3",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
-	CLK("omap-mcbsp.4",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
-	CLK("omap-mcbsp.5",	"pad_fck",	&mcbsp_clks,	CK_3XXX),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
 	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
 	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
@@ -3307,8 +3302,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("usbhs_omap",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
-	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"mmchs3_fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck,	CK_3XXX),
@@ -3413,9 +3406,6 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
-	CLK("omap-mcbsp.2",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
-	CLK("omap-mcbsp.3",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
-	CLK("omap-mcbsp.4",	"prcm_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
 	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b26d3c9..7ac0511 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1074,6 +1074,17 @@ static struct omap_hwmod_class omap3xxx_mcbsp_hwmod_class = {
 	.rev  = MCBSP_CONFIG_TYPE3,
 };
 
+/* McBSP functional clock mapping */
+static struct omap_hwmod_opt_clk mcbsp15_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "mcbsp_clks" },
+	{ .role = "prcm_fck", .clk = "core_96m_fck" },
+};
+
+static struct omap_hwmod_opt_clk mcbsp234_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "mcbsp_clks" },
+	{ .role = "prcm_fck", .clk = "per_96m_fck" },
+};
+
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap3xxx_mcbsp1_irqs[] = {
 	{ .name = "common", .irq = 16 },
@@ -1097,6 +1108,8 @@ static struct omap_hwmod omap3xxx_mcbsp1_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MCBSP1_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp15_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp15_opt_clks),
 };
 
 /* mcbsp2 */
@@ -1126,6 +1139,8 @@ static struct omap_hwmod omap3xxx_mcbsp2_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MCBSP2_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp234_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
 	.dev_attr	= &omap34xx_mcbsp2_dev_attr,
 };
 
@@ -1156,6 +1171,8 @@ static struct omap_hwmod omap3xxx_mcbsp3_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MCBSP3_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp234_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
 	.dev_attr	= &omap34xx_mcbsp3_dev_attr,
 };
 
@@ -1188,6 +1205,8 @@ static struct omap_hwmod omap3xxx_mcbsp4_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MCBSP4_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp234_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp234_opt_clks),
 };
 
 /* mcbsp5 */
@@ -1219,6 +1238,8 @@ static struct omap_hwmod omap3xxx_mcbsp5_hwmod = {
 			.idlest_idle_bit = OMAP3430_ST_MCBSP5_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp15_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp15_opt_clks),
 };
 
 /* 'mcbsp sidetone' class */
-- 
1.7.8.6

