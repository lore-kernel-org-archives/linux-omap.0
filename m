From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 3/3] ARM: OMAP2+: dmtimer: cleanup fclk usage
Date: Mon, 16 Apr 2012 17:55:25 +0530
Message-ID: <1334579125-15566-4-git-send-email-tarun.kanti@ti.com>
References: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34850 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754271Ab2DPMZh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 08:25:37 -0400
In-Reply-To: <1334579125-15566-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, santosh.shilimkar@ti.com, rnayak@ti.com, Tarun Kanti DebBarma <tarun.kanti@ti.com>

Timer clock nodes have been re-named as "timer1_fck", "timer2_fck", ...
in place of "gpt1_fck", "gpt2_fck", ... This is in line with the names
present in OMAP4 gptimer hwmod database assigned to oh->main_clk.
Now we can get the fck name directly from oh->main_clk and pass the
same to clk_get() to extract the fclk and thus avoid construction
of fclk clock name.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/clock2420_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock2430_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock3xxx_data.c       |   72 ++++++++++++++--------------
 arch/arm/mach-omap2/clock44xx_data.c       |   22 ++++----
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   24 +++++-----
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   24 +++++-----
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   24 +++++-----
 arch/arm/mach-omap2/timer.c                |    3 +-
 8 files changed, 156 insertions(+), 157 deletions(-)

diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index bace930..8d12e8e 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -847,8 +847,8 @@ static struct clk gpt1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -873,8 +873,8 @@ static struct clk gpt2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
+static struct clk timer2_fck = {
+	.name		= "timer2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -897,8 +897,8 @@ static struct clk gpt3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
+static struct clk timer3_fck = {
+	.name		= "timer3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -921,8 +921,8 @@ static struct clk gpt4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
+static struct clk timer4_fck = {
+	.name		= "timer4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -945,8 +945,8 @@ static struct clk gpt5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
+static struct clk timer5_fck = {
+	.name		= "timer5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -969,8 +969,8 @@ static struct clk gpt6_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
+static struct clk timer6_fck = {
+	.name		= "timer6_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -993,8 +993,8 @@ static struct clk gpt7_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
+static struct clk timer7_fck = {
+	.name		= "timer7_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1017,8 +1017,8 @@ static struct clk gpt8_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
+static struct clk timer8_fck = {
+	.name		= "timer8_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1041,8 +1041,8 @@ static struct clk gpt9_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
+static struct clk timer9_fck = {
+	.name		= "timer9_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1065,8 +1065,8 @@ static struct clk gpt10_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
+static struct clk timer10_fck = {
+	.name		= "timer10_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1089,8 +1089,8 @@ static struct clk gpt11_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
+static struct clk timer11_fck = {
+	.name		= "timer11_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1113,8 +1113,8 @@ static struct clk gpt12_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt12_fck = {
-	.name		= "gpt12_fck",
+static struct clk timer12_fck = {
+	.name		= "timer12_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &secure_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1823,29 +1823,29 @@ static struct omap_clk omap2420_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
+	CLK(NULL,	"timer1_fck",	&timer1_fck,	CK_242X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
+	CLK(NULL,	"timer2_fck",	&timer2_fck,	CK_242X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
+	CLK(NULL,	"timer3_fck",	&timer3_fck,	CK_242X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
+	CLK(NULL,	"timer4_fck",	&timer4_fck,	CK_242X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
+	CLK(NULL,	"timer5_fck",	&timer5_fck,	CK_242X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
+	CLK(NULL,	"timer6_fck",	&timer6_fck,	CK_242X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
+	CLK(NULL,	"timer7_fck",	&timer7_fck,	CK_242X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
+	CLK(NULL,	"timer8_fck",	&timer8_fck,	CK_242X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
+	CLK(NULL,	"timer9_fck",	&timer9_fck,	CK_242X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
+	CLK(NULL,	"timer10_fck",	&timer10_fck,	CK_242X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
+	CLK(NULL,	"timer11_fck",	&timer11_fck,	CK_242X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
+	CLK(NULL,	"timer12_fck",	&timer12_fck,	CK_242X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
 	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_242X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 3b4d09a..bb56b75 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -834,8 +834,8 @@ static struct clk gpt1_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -860,8 +860,8 @@ static struct clk gpt2_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
+static struct clk timer2_fck = {
+	.name		= "timer2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -884,8 +884,8 @@ static struct clk gpt3_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
+static struct clk timer3_fck = {
+	.name		= "timer3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -908,8 +908,8 @@ static struct clk gpt4_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
+static struct clk timer4_fck = {
+	.name		= "timer4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -932,8 +932,8 @@ static struct clk gpt5_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
+static struct clk timer5_fck = {
+	.name		= "timer5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -956,8 +956,8 @@ static struct clk gpt6_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
+static struct clk timer6_fck = {
+	.name		= "timer6_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -980,8 +980,8 @@ static struct clk gpt7_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
+static struct clk timer7_fck = {
+	.name		= "timer7_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1004,8 +1004,8 @@ static struct clk gpt8_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
+static struct clk timer8_fck = {
+	.name		= "timer8_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1028,8 +1028,8 @@ static struct clk gpt9_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
+static struct clk timer9_fck = {
+	.name		= "timer9_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1052,8 +1052,8 @@ static struct clk gpt10_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
+static struct clk timer10_fck = {
+	.name		= "timer10_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1076,8 +1076,8 @@ static struct clk gpt11_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
+static struct clk timer11_fck = {
+	.name		= "timer11_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1100,8 +1100,8 @@ static struct clk gpt12_ick = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk gpt12_fck = {
-	.name		= "gpt12_fck",
+static struct clk timer12_fck = {
+	.name		= "timer12_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &secure_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1912,29 +1912,29 @@ static struct omap_clk omap2430_clks[] = {
 	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
 	/* general l4 interface ck, multi-parent functional clk */
 	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
+	CLK(NULL,	"timer1_fck",	&timer1_fck,	CK_243X),
 	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
+	CLK(NULL,	"timer2_fck",	&timer2_fck,	CK_243X),
 	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
+	CLK(NULL,	"timer3_fck",	&timer3_fck,	CK_243X),
 	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
+	CLK(NULL,	"timer4_fck",	&timer4_fck,	CK_243X),
 	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
+	CLK(NULL,	"timer5_fck",	&timer5_fck,	CK_243X),
 	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
+	CLK(NULL,	"timer6_fck",	&timer6_fck,	CK_243X),
 	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
+	CLK(NULL,	"timer7_fck",	&timer7_fck,	CK_243X),
 	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
+	CLK(NULL,	"timer8_fck",	&timer8_fck,	CK_243X),
 	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
+	CLK(NULL,	"timer9_fck",	&timer9_fck,	CK_243X),
 	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
+	CLK(NULL,	"timer10_fck",	&timer10_fck,	CK_243X),
 	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
+	CLK(NULL,	"timer11_fck",	&timer11_fck,	CK_243X),
 	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
+	CLK(NULL,	"timer12_fck",	&timer12_fck,	CK_243X),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
 	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_243X),
 	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index f4a626f..5912238 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1362,8 +1362,8 @@ static const struct clksel omap343x_gpt_clksel[] = {
 	{ .parent = NULL}
 };
 
-static struct clk gpt10_fck = {
-	.name		= "gpt10_fck",
+static struct clk timer10_fck = {
+	.name		= "timer10_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
@@ -1376,8 +1376,8 @@ static struct clk gpt10_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt11_fck = {
-	.name		= "gpt11_fck",
+static struct clk timer11_fck = {
+	.name		= "timer11_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &sys_ck,
 	.init		= &omap2_init_clksel_parent,
@@ -2326,8 +2326,8 @@ static struct clk usim_fck = {
 };
 
 /* XXX should gpt1's clksel have wkup_32k_fck as the 32k opt? */
-static struct clk gpt1_fck = {
-	.name		= "gpt1_fck",
+static struct clk timer1_fck = {
+	.name		= "timer1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
@@ -2498,8 +2498,8 @@ static struct clk uart4_fck_am35xx = {
 	.recalc         = &followparent_recalc,
 };
 
-static struct clk gpt2_fck = {
-	.name		= "gpt2_fck",
+static struct clk timer2_fck = {
+	.name		= "timer2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2511,8 +2511,8 @@ static struct clk gpt2_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt3_fck = {
-	.name		= "gpt3_fck",
+static struct clk timer3_fck = {
+	.name		= "timer3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2524,8 +2524,8 @@ static struct clk gpt3_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt4_fck = {
-	.name		= "gpt4_fck",
+static struct clk timer4_fck = {
+	.name		= "timer4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2537,8 +2537,8 @@ static struct clk gpt4_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt5_fck = {
-	.name		= "gpt5_fck",
+static struct clk timer5_fck = {
+	.name		= "timer5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2550,8 +2550,8 @@ static struct clk gpt5_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt6_fck = {
-	.name		= "gpt6_fck",
+static struct clk timer6_fck = {
+	.name		= "timer6_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2563,8 +2563,8 @@ static struct clk gpt6_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt7_fck = {
-	.name		= "gpt7_fck",
+static struct clk timer7_fck = {
+	.name		= "timer7_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2576,8 +2576,8 @@ static struct clk gpt7_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt8_fck = {
-	.name		= "gpt8_fck",
+static struct clk timer8_fck = {
+	.name		= "timer8_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -2589,8 +2589,8 @@ static struct clk gpt8_fck = {
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk gpt9_fck = {
-	.name		= "gpt9_fck",
+static struct clk timer9_fck = {
+	.name		= "timer9_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
@@ -3092,8 +3092,8 @@ static struct clk sr_l4_ick = {
 
 /* SECURE_32K_FCK clocks */
 
-static struct clk gpt12_fck = {
-	.name		= "gpt12_fck",
+static struct clk timer12_fck = {
+	.name		= "timer12_fck",
 	.ops		= &clkops_null,
 	.parent		= &secure_32k_fck,
 	.clkdm_name	= "wkup_clkdm",
@@ -3300,8 +3300,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
+	CLK(NULL,	"timer10_fck",	&timer10_fck,	CK_3XXX),
+	CLK(NULL,	"timer11_fck",	&timer11_fck,	CK_3XXX),
 	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
@@ -3400,7 +3400,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
 	CLK("usbhs_omap",	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
 	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
+	CLK(NULL,	"timer1_fck",	&timer1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK(NULL,	"wdt2_fck",		&wdt2_fck,	CK_3XXX),
@@ -3420,14 +3420,14 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
 	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_3505 | CK_3517),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
+	CLK(NULL,	"timer2_fck",	&timer2_fck,	CK_3XXX),
+	CLK(NULL,	"timer3_fck",	&timer3_fck,	CK_3XXX),
+	CLK(NULL,	"timer4_fck",	&timer4_fck,	CK_3XXX),
+	CLK(NULL,	"timer5_fck",	&timer5_fck,	CK_3XXX),
+	CLK(NULL,	"timer6_fck",	&timer6_fck,	CK_3XXX),
+	CLK(NULL,	"timer7_fck",	&timer7_fck,	CK_3XXX),
+	CLK(NULL,	"timer8_fck",	&timer8_fck,	CK_3XXX),
+	CLK(NULL,	"timer9_fck",	&timer9_fck,	CK_3XXX),
 	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
 	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
 	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
@@ -3468,7 +3468,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
+	CLK(NULL,	"timer12_fck",	&timer12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
 	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
 	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2172f66..17f3bcd 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -3294,17 +3294,17 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_443X),
-	CLK(NULL,	"gpt10_fck",			&timer10_fck,	CK_443X),
-	CLK(NULL,	"gpt11_fck",			&timer11_fck,	CK_443X),
-	CLK(NULL,	"gpt2_fck",			&timer2_fck,	CK_443X),
-	CLK(NULL,	"gpt3_fck",			&timer3_fck,	CK_443X),
-	CLK(NULL,	"gpt4_fck",			&timer4_fck,	CK_443X),
-	CLK(NULL,	"gpt5_fck",			&timer5_fck,	CK_443X),
-	CLK(NULL,	"gpt6_fck",			&timer6_fck,	CK_443X),
-	CLK(NULL,	"gpt7_fck",			&timer7_fck,	CK_443X),
-	CLK(NULL,	"gpt8_fck",			&timer8_fck,	CK_443X),
-	CLK(NULL,	"gpt9_fck",			&timer9_fck,	CK_443X),
+	CLK(NULL,	"timer1_fck",			&timer1_fck,	CK_443X),
+	CLK(NULL,	"timer10_fck",			&timer10_fck,	CK_443X),
+	CLK(NULL,	"timer11_fck",			&timer11_fck,	CK_443X),
+	CLK(NULL,	"timer2_fck",			&timer2_fck,	CK_443X),
+	CLK(NULL,	"timer3_fck",			&timer3_fck,	CK_443X),
+	CLK(NULL,	"timer4_fck",			&timer4_fck,	CK_443X),
+	CLK(NULL,	"timer5_fck",			&timer5_fck,	CK_443X),
+	CLK(NULL,	"timer6_fck",			&timer6_fck,	CK_443X),
+	CLK(NULL,	"timer7_fck",			&timer7_fck,	CK_443X),
+	CLK(NULL,	"timer8_fck",			&timer8_fck,	CK_443X),
+	CLK(NULL,	"timer9_fck",			&timer9_fck,	CK_443X),
 	CLK(NULL,	"uart1_fck",			&uart1_fck,	CK_443X),
 	CLK(NULL,	"uart2_fck",			&uart2_fck,	CK_443X),
 	CLK(NULL,	"uart3_fck",			&uart3_fck,	CK_443X),
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a5409ce..37d2fc8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -309,7 +309,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer1_slaves[] = {
 static struct omap_hwmod omap2420_timer1_hwmod = {
 	.name		= "timer1",
 	.mpu_irqs	= omap2_timer1_mpu_irqs,
-	.main_clk	= "gpt1_fck",
+	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -346,7 +346,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer2_slaves[] = {
 static struct omap_hwmod omap2420_timer2_hwmod = {
 	.name		= "timer2",
 	.mpu_irqs	= omap2_timer2_mpu_irqs,
-	.main_clk	= "gpt2_fck",
+	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -383,7 +383,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer3_slaves[] = {
 static struct omap_hwmod omap2420_timer3_hwmod = {
 	.name		= "timer3",
 	.mpu_irqs	= omap2_timer3_mpu_irqs,
-	.main_clk	= "gpt3_fck",
+	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -420,7 +420,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer4_slaves[] = {
 static struct omap_hwmod omap2420_timer4_hwmod = {
 	.name		= "timer4",
 	.mpu_irqs	= omap2_timer4_mpu_irqs,
-	.main_clk	= "gpt4_fck",
+	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -457,7 +457,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer5_slaves[] = {
 static struct omap_hwmod omap2420_timer5_hwmod = {
 	.name		= "timer5",
 	.mpu_irqs	= omap2_timer5_mpu_irqs,
-	.main_clk	= "gpt5_fck",
+	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -495,7 +495,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer6_slaves[] = {
 static struct omap_hwmod omap2420_timer6_hwmod = {
 	.name		= "timer6",
 	.mpu_irqs	= omap2_timer6_mpu_irqs,
-	.main_clk	= "gpt6_fck",
+	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -532,7 +532,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer7_slaves[] = {
 static struct omap_hwmod omap2420_timer7_hwmod = {
 	.name		= "timer7",
 	.mpu_irqs	= omap2_timer7_mpu_irqs,
-	.main_clk	= "gpt7_fck",
+	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -569,7 +569,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer8_slaves[] = {
 static struct omap_hwmod omap2420_timer8_hwmod = {
 	.name		= "timer8",
 	.mpu_irqs	= omap2_timer8_mpu_irqs,
-	.main_clk	= "gpt8_fck",
+	.main_clk	= "timer8_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -606,7 +606,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer9_slaves[] = {
 static struct omap_hwmod omap2420_timer9_hwmod = {
 	.name		= "timer9",
 	.mpu_irqs	= omap2_timer9_mpu_irqs,
-	.main_clk	= "gpt9_fck",
+	.main_clk	= "timer9_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -643,7 +643,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer10_slaves[] = {
 static struct omap_hwmod omap2420_timer10_hwmod = {
 	.name		= "timer10",
 	.mpu_irqs	= omap2_timer10_mpu_irqs,
-	.main_clk	= "gpt10_fck",
+	.main_clk	= "timer10_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -680,7 +680,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer11_slaves[] = {
 static struct omap_hwmod omap2420_timer11_hwmod = {
 	.name		= "timer11",
 	.mpu_irqs	= omap2_timer11_mpu_irqs,
-	.main_clk	= "gpt11_fck",
+	.main_clk	= "timer11_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -717,7 +717,7 @@ static struct omap_hwmod_ocp_if *omap2420_timer12_slaves[] = {
 static struct omap_hwmod omap2420_timer12_hwmod = {
 	.name		= "timer12",
 	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
-	.main_clk	= "gpt12_fck",
+	.main_clk	= "timer12_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index c4f56cb..bd70a40 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -383,7 +383,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer1_slaves[] = {
 static struct omap_hwmod omap2430_timer1_hwmod = {
 	.name		= "timer1",
 	.mpu_irqs	= omap2_timer1_mpu_irqs,
-	.main_clk	= "gpt1_fck",
+	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -420,7 +420,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer2_slaves[] = {
 static struct omap_hwmod omap2430_timer2_hwmod = {
 	.name		= "timer2",
 	.mpu_irqs	= omap2_timer2_mpu_irqs,
-	.main_clk	= "gpt2_fck",
+	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -457,7 +457,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer3_slaves[] = {
 static struct omap_hwmod omap2430_timer3_hwmod = {
 	.name		= "timer3",
 	.mpu_irqs	= omap2_timer3_mpu_irqs,
-	.main_clk	= "gpt3_fck",
+	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -494,7 +494,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer4_slaves[] = {
 static struct omap_hwmod omap2430_timer4_hwmod = {
 	.name		= "timer4",
 	.mpu_irqs	= omap2_timer4_mpu_irqs,
-	.main_clk	= "gpt4_fck",
+	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -531,7 +531,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer5_slaves[] = {
 static struct omap_hwmod omap2430_timer5_hwmod = {
 	.name		= "timer5",
 	.mpu_irqs	= omap2_timer5_mpu_irqs,
-	.main_clk	= "gpt5_fck",
+	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -568,7 +568,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer6_slaves[] = {
 static struct omap_hwmod omap2430_timer6_hwmod = {
 	.name		= "timer6",
 	.mpu_irqs	= omap2_timer6_mpu_irqs,
-	.main_clk	= "gpt6_fck",
+	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -605,7 +605,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer7_slaves[] = {
 static struct omap_hwmod omap2430_timer7_hwmod = {
 	.name		= "timer7",
 	.mpu_irqs	= omap2_timer7_mpu_irqs,
-	.main_clk	= "gpt7_fck",
+	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -642,7 +642,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer8_slaves[] = {
 static struct omap_hwmod omap2430_timer8_hwmod = {
 	.name		= "timer8",
 	.mpu_irqs	= omap2_timer8_mpu_irqs,
-	.main_clk	= "gpt8_fck",
+	.main_clk	= "timer8_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -679,7 +679,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer9_slaves[] = {
 static struct omap_hwmod omap2430_timer9_hwmod = {
 	.name		= "timer9",
 	.mpu_irqs	= omap2_timer9_mpu_irqs,
-	.main_clk	= "gpt9_fck",
+	.main_clk	= "timer9_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -716,7 +716,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer10_slaves[] = {
 static struct omap_hwmod omap2430_timer10_hwmod = {
 	.name		= "timer10",
 	.mpu_irqs	= omap2_timer10_mpu_irqs,
-	.main_clk	= "gpt10_fck",
+	.main_clk	= "timer10_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -753,7 +753,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer11_slaves[] = {
 static struct omap_hwmod omap2430_timer11_hwmod = {
 	.name		= "timer11",
 	.mpu_irqs	= omap2_timer11_mpu_irqs,
-	.main_clk	= "gpt11_fck",
+	.main_clk	= "timer11_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -790,7 +790,7 @@ static struct omap_hwmod_ocp_if *omap2430_timer12_slaves[] = {
 static struct omap_hwmod omap2430_timer12_hwmod = {
 	.name		= "timer12",
 	.mpu_irqs	= omap2xxx_timer12_mpu_irqs,
-	.main_clk	= "gpt12_fck",
+	.main_clk	= "timer12_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 34b9766..595b4cd 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -640,7 +640,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer1_slaves[] = {
 static struct omap_hwmod omap3xxx_timer1_hwmod = {
 	.name		= "timer1",
 	.mpu_irqs	= omap2_timer1_mpu_irqs,
-	.main_clk	= "gpt1_fck",
+	.main_clk	= "timer1_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -686,7 +686,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer2_slaves[] = {
 static struct omap_hwmod omap3xxx_timer2_hwmod = {
 	.name		= "timer2",
 	.mpu_irqs	= omap2_timer2_mpu_irqs,
-	.main_clk	= "gpt2_fck",
+	.main_clk	= "timer2_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -732,7 +732,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer3_slaves[] = {
 static struct omap_hwmod omap3xxx_timer3_hwmod = {
 	.name		= "timer3",
 	.mpu_irqs	= omap2_timer3_mpu_irqs,
-	.main_clk	= "gpt3_fck",
+	.main_clk	= "timer3_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -778,7 +778,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer4_slaves[] = {
 static struct omap_hwmod omap3xxx_timer4_hwmod = {
 	.name		= "timer4",
 	.mpu_irqs	= omap2_timer4_mpu_irqs,
-	.main_clk	= "gpt4_fck",
+	.main_clk	= "timer4_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -824,7 +824,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer5_slaves[] = {
 static struct omap_hwmod omap3xxx_timer5_hwmod = {
 	.name		= "timer5",
 	.mpu_irqs	= omap2_timer5_mpu_irqs,
-	.main_clk	= "gpt5_fck",
+	.main_clk	= "timer5_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -870,7 +870,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer6_slaves[] = {
 static struct omap_hwmod omap3xxx_timer6_hwmod = {
 	.name		= "timer6",
 	.mpu_irqs	= omap2_timer6_mpu_irqs,
-	.main_clk	= "gpt6_fck",
+	.main_clk	= "timer6_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -916,7 +916,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer7_slaves[] = {
 static struct omap_hwmod omap3xxx_timer7_hwmod = {
 	.name		= "timer7",
 	.mpu_irqs	= omap2_timer7_mpu_irqs,
-	.main_clk	= "gpt7_fck",
+	.main_clk	= "timer7_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -962,7 +962,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer8_slaves[] = {
 static struct omap_hwmod omap3xxx_timer8_hwmod = {
 	.name		= "timer8",
 	.mpu_irqs	= omap2_timer8_mpu_irqs,
-	.main_clk	= "gpt8_fck",
+	.main_clk	= "timer8_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1008,7 +1008,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer9_slaves[] = {
 static struct omap_hwmod omap3xxx_timer9_hwmod = {
 	.name		= "timer9",
 	.mpu_irqs	= omap2_timer9_mpu_irqs,
-	.main_clk	= "gpt9_fck",
+	.main_clk	= "timer9_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1045,7 +1045,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer10_slaves[] = {
 static struct omap_hwmod omap3xxx_timer10_hwmod = {
 	.name		= "timer10",
 	.mpu_irqs	= omap2_timer10_mpu_irqs,
-	.main_clk	= "gpt10_fck",
+	.main_clk	= "timer10_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1082,7 +1082,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer11_slaves[] = {
 static struct omap_hwmod omap3xxx_timer11_hwmod = {
 	.name		= "timer11",
 	.mpu_irqs	= omap2_timer11_mpu_irqs,
-	.main_clk	= "gpt11_fck",
+	.main_clk	= "timer11_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -1132,7 +1132,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_timer12_slaves[] = {
 static struct omap_hwmod omap3xxx_timer12_hwmod = {
 	.name		= "timer12",
 	.mpu_irqs	= omap3xxx_timer12_mpu_irqs,
-	.main_clk	= "gpt12_fck",
+	.main_clk	= "timer12_fck",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5d7a0ee..9459d70 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -164,8 +164,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		return -ENXIO;
 
 	/* After the dmtimer is using hwmod these clocks won't be needed */
-	sprintf(name, "gpt%d_fck", gptimer_id);
-	timer->fclk = clk_get(NULL, name);
+	timer->fclk = clk_get(NULL, oh->main_clk);
 	if (IS_ERR(timer->fclk))
 		return -ENODEV;
 
-- 
1.7.0.4

