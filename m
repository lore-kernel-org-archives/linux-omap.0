From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: omap4: hwmod: Remove elm address space from
 hwmod data
Date: Mon, 30 Nov 2015 13:19:13 -0800
Message-ID: <20151130211912.GS2517@atomide.com>
References: <1446066137-11527-1-git-send-email-fcooper@ti.com>
 <1446066137-11527-3-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446066137-11527-3-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, rogerq@ti.com, nm@ti.com, lokeshvutla@ti.com
List-Id: linux-omap@vger.kernel.org

* Franklin S Cooper Jr <fcooper@ti.com> [151028 14:02]:
> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.
> 
> This patch has only been boot tested.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

And this one seems safe for me to apply into omap-for-v4.5/soc thanks.

Tony

> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 43eebf2..8f13f4a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -3915,21 +3915,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
>  	.user		= OCP_USER_MPU,
>  };
>  
> -static struct omap_hwmod_addr_space omap44xx_elm_addrs[] = {
> -	{
> -		.pa_start	= 0x48078000,
> -		.pa_end		= 0x48078fff,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  /* l4_per -> elm */
>  static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
>  	.master		= &omap44xx_l4_per_hwmod,
>  	.slave		= &omap44xx_elm_hwmod,
>  	.clk		= "l4_div_ck",
> -	.addr		= omap44xx_elm_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> -- 
> 2.6.1
> 
