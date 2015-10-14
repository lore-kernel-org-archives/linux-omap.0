From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Remove elm address space from hwmod
 data
Date: Wed, 14 Oct 2015 09:58:46 +0300
Message-ID: <561DFD26.9090702@ti.com>
References: <1444743874-4454-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444743874-4454-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, paul@pwsan.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, tony@atomide.com, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On 13/10/15 16:44, Franklin S Cooper Jr wrote:
> ELM address information is provided by device tree. No longer need
> to include this information within hwmod.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

Franklin,

Can you please do the same for gpmc_addr as well?

And looks like elm_addr needs to be removed from
omap_hwmod_33xx_43xx_interconnect_data.c and omap_hwmod_44xx_data.c as well, no?

cheers,
-roger

> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index 562247b..ad2cc7a 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2566,21 +2566,11 @@ static struct omap_hwmod_ocp_if dra7xx_l3_main_1__hdmi = {
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> -static struct omap_hwmod_addr_space dra7xx_elm_addrs[] = {
> -	{
> -		.pa_start	= 0x48078000,
> -		.pa_end		= 0x48078fff,
> -		.flags		= ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  /* l4_per1 -> elm */
>  static struct omap_hwmod_ocp_if dra7xx_l4_per1__elm = {
>  	.master		= &dra7xx_l4_per1_hwmod,
>  	.slave		= &dra7xx_elm_hwmod,
>  	.clk		= "l3_iclk_div",
> -	.addr		= dra7xx_elm_addrs,
>  	.user		= OCP_USER_MPU | OCP_USER_SDMA,
>  };
>  
> 
