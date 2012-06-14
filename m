From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/3] ARM: OMAP2: Move McBSP fck clock alias to hwmod data for OMAP2420
Date: Thu, 14 Jun 2012 15:27:24 +0300
Message-ID: <1339676846-12791-2-git-send-email-peter.ujfalusi@ti.com>
References: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:44426 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753396Ab2FNM1W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 08:27:22 -0400
Received: by laai10 with SMTP id i10so1207734laa.41
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 05:27:19 -0700 (PDT)
In-Reply-To: <1339676846-12791-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the existing alias for pad_fck, prcm_fck from the clock data and
add them as opt_clks to the hwmod data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c       |    4 ----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    9 +++++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index bace930..7e39015 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -1774,8 +1774,6 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"osc_ck",	&osc_ck,	CK_242X),
 	CLK(NULL,	"sys_ck",	&sys_ck,	CK_242X),
 	CLK(NULL,	"alt_ck",	&alt_ck,	CK_242X),
-	CLK("omap-mcbsp.1",	"pad_fck",	&mcbsp_clks,	CK_242X),
-	CLK("omap-mcbsp.2",	"pad_fck",	&mcbsp_clks,	CK_242X),
 	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_242X),
 	/* internal analog sources */
 	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_242X),
@@ -1784,8 +1782,6 @@ static struct omap_clk omap2420_clks[] = {
 	/* internal prcm root sources */
 	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_242X),
 	CLK(NULL,	"core_ck",	&core_ck,	CK_242X),
-	CLK("omap-mcbsp.1",	"prcm_fck",	&func_96m_ck,	CK_242X),
-	CLK("omap-mcbsp.2",	"prcm_fck",	&func_96m_ck,	CK_242X),
 	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
 	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
 	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a7640d1..910d256 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -192,6 +192,11 @@ static struct omap_hwmod_class omap2420_mcbsp_hwmod_class = {
 	.name = "mcbsp",
 };
 
+static struct omap_hwmod_opt_clk mcbsp_opt_clks[] = {
+	{ .role = "pad_fck", .clk = "mcbsp_clks" },
+	{ .role = "prcm_fck", .clk = "func_96m_ck" },
+};
+
 /* mcbsp1 */
 static struct omap_hwmod_irq_info omap2420_mcbsp1_irqs[] = {
 	{ .name = "tx", .irq = 59 },
@@ -214,6 +219,8 @@ static struct omap_hwmod omap2420_mcbsp1_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP1_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 /* mcbsp2 */
@@ -238,6 +245,8 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 			.idlest_idle_bit = OMAP24XX_ST_MCBSP2_SHIFT,
 		},
 	},
+	.opt_clks	= mcbsp_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(mcbsp_opt_clks),
 };
 
 static struct omap_hwmod_class_sysconfig omap2420_msdi_sysc = {
-- 
1.7.8.6

