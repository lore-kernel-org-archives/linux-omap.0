From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v4 3/4] ARM: DRA7: hwmod: Add ocp2scp3 and sata hwmods
Date: Thu, 12 Jun 2014 15:47:07 +0300
Message-ID: <5399A14B.9070806@ti.com>
References: <1398274237-24510-1-git-send-email-rogerq@ti.com> <1398274559-24777-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1398274559-24777-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, george.cherian-l0cyMroinI0@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Tony,

We need this one as well for 3.16.

cheers,
-roger

On 04/23/2014 08:35 PM, Roger Quadros wrote:
> From: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
> 
> Add hwmods for ocp2scp3 and sata modules.
> 
> [Roger Q] Clean up.
> 
> CC: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> CC: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nikhil Devshatwar <nikhil.nd-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 810c205..b02a4ab 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1215,6 +1215,30 @@ static struct omap_hwmod dra7xx_ocp2scp1_hwmod = {
>  	},
>  };
>  
> +/* ocp2scp3 */
> +static struct omap_hwmod dra7xx_ocp2scp3_hwmod;
> +
> +/* l4_cfg -> ocp2scp3 */
> +static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp3 = {
> +	.master		= &dra7xx_l4_cfg_hwmod,
> +	.slave		= &dra7xx_ocp2scp3_hwmod,
> +	.clk		= "l4_root_clk_div",
> +	.user		= OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +static struct omap_hwmod dra7xx_ocp2scp3_hwmod = {
> +	.name		= "ocp2scp3",
> +	.class		= &dra7xx_ocp2scp_hwmod_class,
> +	.clkdm_name	= "l3init_clkdm",
> +	.prcm = {
> +		.omap4 = {
> +			.clkctrl_offs = DRA7XX_CM_L3INIT_OCP2SCP3_CLKCTRL_OFFSET,
> +			.context_offs = DRA7XX_RM_L3INIT_OCP2SCP3_CONTEXT_OFFSET,
> +			.modulemode   = MODULEMODE_HWCTRL,
> +		},
> +	},
> +};
> +
>  /*
>   * 'qspi' class
>   *
> @@ -1268,9 +1292,6 @@ static struct omap_hwmod_class dra7xx_sata_hwmod_class = {
>  };
>  
>  /* sata */
> -static struct omap_hwmod_opt_clk sata_opt_clks[] = {
> -	{ .role = "ref_clk", .clk = "sata_ref_clk" },
> -};
>  
>  static struct omap_hwmod dra7xx_sata_hwmod = {
>  	.name		= "sata",
> @@ -1278,6 +1299,7 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
>  	.clkdm_name	= "l3init_clkdm",
>  	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
>  	.main_clk	= "func_48m_fclk",
> +	.mpu_rt_idx	= 1,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L3INIT_SATA_CLKCTRL_OFFSET,
> @@ -1285,8 +1307,6 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
>  			.modulemode   = MODULEMODE_SWCTRL,
>  		},
>  	},
> -	.opt_clks	= sata_opt_clks,
> -	.opt_clks_cnt	= ARRAY_SIZE(sata_opt_clks),
>  };
>  
>  /*
> @@ -2682,6 +2702,7 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
>  	&dra7xx_l4_per1__mmc4,
>  	&dra7xx_l4_cfg__mpu,
>  	&dra7xx_l4_cfg__ocp2scp1,
> +	&dra7xx_l4_cfg__ocp2scp3,
>  	&dra7xx_l3_main_1__qspi,
>  	&dra7xx_l4_cfg__sata,
>  	&dra7xx_l4_cfg__smartreflex_core,
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
