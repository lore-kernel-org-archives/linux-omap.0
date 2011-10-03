From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 3/9] OMAP3: HWMOD: Fix DSS reset
Date: Mon, 3 Oct 2011 10:54:39 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110031054170.4611@utopia.booyaka.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com> <1314102499-30407-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53356 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1JCQyl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 12:54:41 -0400
In-Reply-To: <1314102499-30407-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

On Tue, 23 Aug 2011, Tomi Valkeinen wrote:

> DSS needs all DSS clocks to be enabled to be able to finish reset
> properly. Before v3.1-rc1 the omapdss driver was managing clocks and
> resets correctly. However, when omapdss started using runtime PM at
> v3.1-rc1, the responsibility for the reset moved to HWMOD framework.
> 
> HWMOD framework does not currently enable all the DSS clocks when
> resetting the DSS hardware. This hasn't caused any problems so far, but
> we may just have been lucky.
> 
> dss_core's opt-clocks is also missing dss_96m_fck, which is a DSS clock
> present only on OMAP3430, and thus required on OMAP3430 to finish the
> reset.
> 
> This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET and adds the dss_96m_fck
> opt-clock for dss_core in OMAP3 HWMOD data, fixing the issue.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index 25bf43b..484eda3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -1365,13 +1365,19 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
>  };
>  
>  static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> -	{ .role = "tv_clk", .clk = "dss_tv_fck" },
> -	{ .role = "video_clk", .clk = "dss_96m_fck" },
> +	/*
> +	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
> +	 * driver does not use these clocks.
> +	 */
>  	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
> +	{ .role = "tv_clk", .clk = "dss_tv_fck" },
> +	/* required only on OMAP3430 */
> +	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
>  };
>  
>  static struct omap_hwmod omap3430es1_dss_core_hwmod = {
>  	.name		= "dss_core",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>  	.class		= &omap2_dss_hwmod_class,
>  	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
>  	.sdma_reqs	= omap3xxx_dss_sdma_chs,
> @@ -1396,6 +1402,7 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
>  
>  static struct omap_hwmod omap3xxx_dss_core_hwmod = {
>  	.name		= "dss_core",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>  	.class		= &omap2_dss_hwmod_class,
>  	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
>  	.sdma_reqs	= omap3xxx_dss_sdma_chs,
> -- 
> 1.7.4.1


This patch adds an extra 'flags' field, overriding the existing ones for  
these hwmods, and causing sparse warnings.  Updated patch below.


- Paul

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Aug 2011 15:28:13 +0300
Subject: [PATCH] OMAP3: HWMOD: Fix DSS reset

DSS needs all DSS clocks to be enabled to be able to finish reset
properly. Before v3.1-rc1 the omapdss driver was managing clocks and
resets correctly. However, when omapdss started using runtime PM at
v3.1-rc1, the responsibility for the reset moved to HWMOD framework.

HWMOD framework does not currently enable all the DSS clocks when
resetting the DSS hardware. This hasn't caused any problems so far, but
we may just have been lucky.

dss_core's opt-clocks is also missing dss_96m_fck, which is a DSS clock
present only on OMAP3430, and thus required on OMAP3430 to finish the
reset.

This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET and adds the dss_96m_fck
opt-clock for dss_core in OMAP3 HWMOD data, fixing the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[paul@pwsan.com: merged duplicate .flags fields]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..99a0db0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1365,9 +1365,14 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
-	{ .role = "tv_clk", .clk = "dss_tv_fck" },
-	{ .role = "video_clk", .clk = "dss_96m_fck" },
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "sys_clk", .clk = "dss2_alwon_fck" },
+	{ .role = "tv_clk", .clk = "dss_tv_fck" },
+	/* required only on OMAP3430 */
+	{ .role = "tv_dac_clk", .clk = "dss_96m_fck" },
 };
 
 static struct omap_hwmod omap3430es1_dss_core_hwmod = {
@@ -1391,11 +1396,12 @@ static struct omap_hwmod omap3430es1_dss_core_hwmod = {
 	.masters	= omap3xxx_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap3xxx_dss_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
-	.flags		= HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 };
 
 static struct omap_hwmod omap3xxx_dss_core_hwmod = {
 	.name		= "dss_core",
+	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 	.class		= &omap2_dss_hwmod_class,
 	.main_clk	= "dss1_alwon_fck", /* instead of dss_fck */
 	.sdma_reqs	= omap3xxx_dss_sdma_chs,
-- 
1.7.6.3

