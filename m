From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 3/4] OMAP4: HWMOD: fix DSS opt clocks
Date: Fri, 5 Aug 2011 17:21:54 +0200
Message-ID: <4E3C0A92.1000301@ti.com>
References: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com> <1312281204-4708-3-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754377Ab1HEPV6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 11:21:58 -0400
In-Reply-To: <1312281204-4708-3-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On 8/2/2011 12:33 PM, Valkeinen, Tomi wrote:
> Remove the opt clocks for dss and dispc, as they are not needed.
>
> Change the main_clk for hdmi and venc to dss_48mhz_clk and dss_tv_clk,
> respectively.
>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>

That one alone is OK, but associated with the next one, it is weird.

Benoit

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 ++-------------------
>   1 files changed, 2 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 6201422..21f03d4 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1254,13 +1254,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_slaves[] = {
>   	&omap44xx_l4_per__dss,
>   };
>
> -static struct omap_hwmod_opt_clk dss_opt_clks[] = {
> -	{ .role = "sys_clk", .clk = "dss_sys_clk" },
> -	{ .role = "tv_clk", .clk = "dss_tv_clk" },
> -	{ .role = "dss_clk", .clk = "dss_dss_clk" },
> -	{ .role = "video_clk", .clk = "dss_48mhz_clk" },
> -};
> -
>   static struct omap_hwmod omap44xx_dss_hwmod = {
>   	.name		= "dss_core",
>   	.class		=&omap44xx_dss_hwmod_class,
> @@ -1272,8 +1265,6 @@ static struct omap_hwmod omap44xx_dss_hwmod = {
>   			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
>   		},
>   	},
> -	.opt_clks	= dss_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(dss_opt_clks),
>   	.slaves		= omap44xx_dss_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_slaves),
>   	.masters	= omap44xx_dss_masters,
> @@ -1358,12 +1349,6 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
>   	&omap44xx_l4_per__dss_dispc,
>   };
>
> -static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
> -	{ .role = "sys_clk", .clk = "dss_sys_clk" },
> -	{ .role = "tv_clk", .clk = "dss_tv_clk" },
> -	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
> -};
> -
>   static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>   	.name		= "dss_dispc",
>   	.class		=&omap44xx_dispc_hwmod_class,
> @@ -1377,8 +1362,6 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>   			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
>   		},
>   	},
> -	.opt_clks	= dss_dispc_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
>   	.slaves		= omap44xx_dss_dispc_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> @@ -1645,7 +1628,7 @@ static struct omap_hwmod omap44xx_dss_hdmi_hwmod = {
>   	.clkdm_name	= "l3_dss_clkdm",
>   	.mpu_irqs	= omap44xx_dss_hdmi_irqs,
>   	.sdma_reqs	= omap44xx_dss_hdmi_sdma_reqs,
> -	.main_clk	= "dss_dss_clk",
> +	.main_clk	= "dss_48mhz_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,
> @@ -1808,7 +1791,7 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
>   	.name		= "dss_venc",
>   	.class		=&omap44xx_venc_hwmod_class,
>   	.clkdm_name	= "l3_dss_clkdm",
> -	.main_clk	= "dss_dss_clk",
> +	.main_clk	= "dss_tv_clk",
>   	.prcm = {
>   		.omap4 = {
>   			.clkctrl_offs = OMAP4_CM_DSS_DSS_CLKCTRL_OFFSET,

