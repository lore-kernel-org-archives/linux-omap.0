From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Re: [Cocci] [PATCH v13 3/6] clk: Make clk API return per-user struct
 clk instances
Date: Thu, 05 Feb 2015 16:45:14 +0100
Message-ID: <54D3900A.9060200@gmail.com>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com> <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com> <20150201212432.22722.70917@quantum> <54CFE1FE.7040404@codeaurora.org> <alpine.DEB.2.02.1502022230110.2045@localhost6.localdomain6> <54CFFBCF.90706@codeaurora.org> <20150202225036.421.43421@quantum> <54D0F179.1040906@gmail.com> <54D2AA9B.7010800@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020401000005020408000305"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54D2AA9B.7010800@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@linaro.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------020401000005020408000305
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit


On 05/02/2015 00:26, Stephen Boyd wrote:
>> If you want me to I can enlarge the search to other directories.
> Yes please do. And if you could share the coccinelle patch that would be
> great. Thanks.
>
structclk.cocci is the coccinelle patch
structclk-arm.patch is the result I got when applying it to the arch/arm 
directory

Is there anything else I can do to help?



--------------020401000005020408000305
Content-Type: text/x-patch;
 name="structclk-arm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="structclk-arm.patch"

diff -u -p ./arch/arm/mach-imx/mach-imx6q.c /tmp/nothing/mach-imx/mach-imx6q.c
--- ./arch/arm/mach-imx/mach-imx6q.c
+++ /tmp/nothing/mach-imx/mach-imx6q.c
@@ -211,7 +211,6 @@ static void __init imx6q_1588_init(void)
 	 * set bit IOMUXC_GPR1[21].  Or the PTP clock must be from pad
 	 * (external OSC), and we need to clear the bit.
 	 */
-	clksel = ptp_clk == enet_ref ? IMX6Q_GPR1_ENET_CLK_SEL_ANATOP :
 				       IMX6Q_GPR1_ENET_CLK_SEL_PAD;
 	gpr = syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr");
 	if (!IS_ERR(gpr))
diff -u -p ./arch/arm/mach-shmobile/clock-r8a73a4.c /tmp/nothing/mach-shmobile/clock-r8a73a4.c
--- ./arch/arm/mach-shmobile/clock-r8a73a4.c
+++ /tmp/nothing/mach-shmobile/clock-r8a73a4.c
@@ -139,7 +139,6 @@ static int pll_set_parent(struct clk *cl
 
 	/* Search the parent */
 	for (i = 0; i < clk->parent_num; i++)
-		if (clk->parent_table[i] == parent)
 			break;
 
 	if (i == clk->parent_num)
diff -u -p ./arch/arm/mach-shmobile/clock-sh7372.c /tmp/nothing/mach-shmobile/clock-sh7372.c
--- ./arch/arm/mach-shmobile/clock-sh7372.c
+++ /tmp/nothing/mach-shmobile/clock-sh7372.c
@@ -223,7 +223,6 @@ static int pllc2_set_parent(struct clk *
 
 	/* Search the parent */
 	for (i = 0; i < clk->parent_num; i++)
-		if (clk->parent_table[i] == parent)
 			break;
 
 	if (i == clk->parent_num)
diff -u -p ./arch/arm/mach-shmobile/clock-r8a7740.c /tmp/nothing/mach-shmobile/clock-r8a7740.c
--- ./arch/arm/mach-shmobile/clock-r8a7740.c
+++ /tmp/nothing/mach-shmobile/clock-r8a7740.c
@@ -195,7 +195,6 @@ static int usb24s_set_parent(struct clk
 
 	/* Search the parent */
 	for (i = 0; i < clk->parent_num; i++)
-		if (clk->parent_table[i] == parent)
 			break;
 
 	if (i == clk->parent_num)
diff -u -p ./arch/arm/mach-omap2/clkt_clksel.c /tmp/nothing/mach-omap2/clkt_clksel.c
--- ./arch/arm/mach-omap2/clkt_clksel.c
+++ /tmp/nothing/mach-omap2/clkt_clksel.c
@@ -67,7 +67,6 @@ static const struct clksel *_get_clksel_
 		return NULL;
 
 	for (clks = clk->clksel; clks->parent; clks++)
-		if (clks->parent == src_clk)
 			break; /* Found the requested parent */
 
 	if (!clks->parent) {
diff -u -p ./arch/arm/mach-omap2/timer.c /tmp/nothing/mach-omap2/timer.c
--- ./arch/arm/mach-omap2/timer.c
+++ /tmp/nothing/mach-omap2/timer.c
@@ -298,7 +298,6 @@ static int __init omap_dm_timer_init_one
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
-	if (clk_get_parent(timer->fclk) != src) {
 		r = clk_set_parent(timer->fclk, src);
 		if (r < 0) {
 			pr_warn("%s: %s cannot set source\n", __func__,

--------------020401000005020408000305
Content-Type: text/plain; charset=UTF-8;
 name="structclk.cocci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="structclk.cocci"

/// Find any attempt to compare or dereference struct clk pointers.
///
// Confidence: High
// Copyright: (C) 2015 Quentin Lambert, INRIA/LiP6. GPLv2
// URL: http://coccinelle.lip6.fr/
// Options: --recursive-includes --relax-include-path
// Options: --include-headers-for-types

virtual context
virtual org
virtual report


// ----------------------------------------------------------------------------

@comparison_dereference depends on context || org || report@
struct clk *x1, x2;
position j0;
@@

(
*  x1@j0 == x2
|
*  x1@j0 != x2
|
*  *x1@j0
)

// ----------------------------------------------------------------------------

@script:python comparison_dereference_org depends on org@
j0 << comparison_dereference.j0;
@@

msg = "WARNING trying to compare or dereference struct clk pointers."
coccilib.org.print_todo(j0[0], msg)

// ----------------------------------------------------------------------------

@script:python comparison_dereference_report depends on report@
j0 << comparison_dereference.j0;
@@

msg = "WARNING trying to compare or dereference struct clk pointers."
coccilib.report.print_report(j0[0], msg)

--------------020401000005020408000305--
