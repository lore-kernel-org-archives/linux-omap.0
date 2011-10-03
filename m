From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/9] OMAP2xxx: HWMOD: Fix DSS reset
Date: Mon, 3 Oct 2011 10:53:17 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110031050470.4611@utopia.booyaka.com>
References: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com> <1314102499-30407-2-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53339 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756944Ab1JCQxS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 12:53:18 -0400
In-Reply-To: <1314102499-30407-2-git-send-email-tomi.valkeinen@ti.com>
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
> This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core in OMAP2xxx
> HWMOD data, fixing the issue.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_2420_data.c |    5 +++++
>  arch/arm/mach-omap2/omap_hwmod_2430_data.c |    5 +++++
>  2 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> index a015c69..8fe373d 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
> @@ -874,12 +874,17 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
>  };
>  
>  static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> +	/*
> +	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
> +	 * driver does not use these clocks.
> +	 */
>  	{ .role = "tv_clk", .clk = "dss_54m_fck" },
>  	{ .role = "sys_clk", .clk = "dss2_fck" },
>  };
>  
>  static struct omap_hwmod omap2420_dss_core_hwmod = {
>  	.name		= "dss_core",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>  	.class		= &omap2_dss_hwmod_class,
>  	.main_clk	= "dss1_fck", /* instead of dss_fck */
>  	.sdma_reqs	= omap2xxx_dss_sdma_chs,
> diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> index 16743c7..7a5e7f5 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> @@ -940,12 +940,17 @@ static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
>  };
>  
>  static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> +	/*
> +	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
> +	 * driver does not use these clocks.
> +	 */
>  	{ .role = "tv_clk", .clk = "dss_54m_fck" },
>  	{ .role = "sys_clk", .clk = "dss2_fck" },
>  };
>  
>  static struct omap_hwmod omap2430_dss_core_hwmod = {
>  	.name		= "dss_core",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>  	.class		= &omap2_dss_hwmod_class,
>  	.main_clk	= "dss1_fck", /* instead of dss_fck */
>  	.sdma_reqs	= omap2xxx_dss_sdma_chs,
> -- 
> 1.7.4.1

This patch adds an extra 'flags' field, causing conflicts with the 
existing ones for these hwmods, and causing sparse warnings.  Updated 
patch below.


- Paul

From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Aug 2011 15:28:11 +0300
Subject: [PATCH] OMAP2xxx: HWMOD: Fix DSS reset

DSS needs all DSS clocks to be enabled to be able to finish reset
properly. Before v3.1-rc1 the omapdss driver was managing clocks and
resets correctly. However, when omapdss started using runtime PM at
v3.1-rc1, the responsibility for the reset moved to HWMOD framework.

HWMOD framework does not currently enable all the DSS clocks when
resetting the DSS hardware. This hasn't caused any problems so far, but
we may just have been lucky.

This patch sets HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core in OMAP2xxx
HWMOD data, fixing the issue.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
[paul@pwsan.com: merged duplicate .flags fields]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    6 +++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index a015c69..e8a9b73 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -874,6 +874,10 @@ static struct omap_hwmod_ocp_if *omap2420_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
@@ -899,7 +903,7 @@ static struct omap_hwmod omap2420_dss_core_hwmod = {
 	.masters	= omap2420_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2420_dss_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
-	.flags		= HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 };
 
 /* l4_core -> dss_dispc */
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..b7486f4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -940,6 +940,10 @@ static struct omap_hwmod_ocp_if *omap2430_dss_slaves[] = {
 };
 
 static struct omap_hwmod_opt_clk dss_opt_clks[] = {
+	/*
+	 * The DSS HW needs all DSS clocks enabled during reset. The dss_core
+	 * driver does not use these clocks.
+	 */
 	{ .role = "tv_clk", .clk = "dss_54m_fck" },
 	{ .role = "sys_clk", .clk = "dss2_fck" },
 };
@@ -965,7 +969,7 @@ static struct omap_hwmod omap2430_dss_core_hwmod = {
 	.masters	= omap2430_dss_masters,
 	.masters_cnt	= ARRAY_SIZE(omap2430_dss_masters),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
-	.flags		= HWMOD_NO_IDLEST,
+	.flags		= HWMOD_NO_IDLEST | HWMOD_CONTROL_OPT_CLKS_IN_RESET,
 };
 
 /* l4_core -> dss_dispc */
-- 
1.7.6.3

