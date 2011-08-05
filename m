From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 4/4] OMAP4: HWMOD: fix DSS reset
Date: Fri, 5 Aug 2011 16:56:24 +0200
Message-ID: <4E3C0498.50108@ti.com>
References: <1312281204-4708-1-git-send-email-tomi.valkeinen@ti.com> <1312281204-4708-4-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46315 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755960Ab1HEO4b (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Aug 2011 10:56:31 -0400
In-Reply-To: <1312281204-4708-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "paul@pwsan.com" <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tomi,

On 8/2/2011 12:33 PM, Valkeinen, Tomi wrote:
> The HWMOD code currently fails to reset dispc and rfbi modules.
>
> This patch adds all DSS clocks as opt clocks for dispc, and sets
> HWMOD_CONTROL_OPT_CLKS_IN_RESET. This seems to fix the issue, although
> this feels like a hack.

Enabling the opt clock for a proper reset seems to be a feature in 
several IPs. GPIO does require the same kind of trick.

> The reason why this patch fixes the reset issue is probably because
> dispc is the first DSS module being reset, and by enabling all the
> clocks during dispc's reset we also allow the other DSS modules to
> finish their reset as a side effect.

That part is a little bit unclear. Did you check that assumption with 
the HW architect?

> Cc: Benoit Cousson<b-cousson@ti.com>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
>   1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 21f03d4..4731f6b 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -1349,8 +1349,15 @@ static struct omap_hwmod_ocp_if *omap44xx_dss_dispc_slaves[] = {
>   	&omap44xx_l4_per__dss_dispc,
>   };
>
> +static struct omap_hwmod_opt_clk dss_dispc_opt_clks[] = {
> +	{ .role = "sys_clk", .clk = "dss_sys_clk" },
> +	{ .role = "tv_clk", .clk = "dss_tv_clk" },
> +	{ .role = "hdmi_clk", .clk = "dss_48mhz_clk" },
> +};
> +

It seems that your are adding back the optional clocks your remove the 
patch before. Is it done on purpose?

Benoit

>   static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>   	.name		= "dss_dispc",
> +	.flags		= HWMOD_CONTROL_OPT_CLKS_IN_RESET,
>   	.class		=&omap44xx_dispc_hwmod_class,
>   	.clkdm_name	= "l3_dss_clkdm",
>   	.mpu_irqs	= omap44xx_dss_dispc_irqs,
> @@ -1362,6 +1369,8 @@ static struct omap_hwmod omap44xx_dss_dispc_hwmod = {
>   			.context_offs = OMAP4_RM_DSS_DSS_CONTEXT_OFFSET,
>   		},
>   	},
> +	.opt_clks	= dss_dispc_opt_clks,
> +	.opt_clks_cnt	= ARRAY_SIZE(dss_dispc_opt_clks),
>   	.slaves		= omap44xx_dss_dispc_slaves,
>   	.slaves_cnt	= ARRAY_SIZE(omap44xx_dss_dispc_slaves),
>   	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),

