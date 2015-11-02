From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ARM: OMAP: hwmod: AM33xx/43xx: Add HWMOD_INIT_NO_IDLE
 flag to tptc
Date: Mon, 2 Nov 2015 15:54:40 +0530
Message-ID: <20151102102440.GM21326@localhost>
References: <1446459060-16220-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446459060-16220-1-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Nov 02, 2015 at 12:11:00PM +0200, Peter Ujfalusi wrote:
> In Linux we do not have driver for TPTCs of eDMA3 since there is no need to
> do any configuration within TPTC for the eDMA3 to be operational. All
> configuration is via the TPCC.
> To prevent the omap_device_late_idle() to disable the TPTCs when they are
> no longer bind with the edma driver, the HWMOD_INIT_NO_IDLE need to be
> added.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
> Vinod, Olof,
> 
> This patch somehow got lost in my working branch. It was mixed within the patches
> I will have for 4.5 while it should have been within the new eDMA3 binding
> series..

Does this fix the issue reported by Olof? Also ACK pls for this

-- 
~Vinod
> 
> Regards,
> Peter
> 
>  arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> index 907a452b78ea..3c7106a09801 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
> @@ -1169,7 +1169,8 @@ struct omap_hwmod am33xx_tptc0_hwmod = {
>  	.name		= "tptc0",
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.flags		= HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY,
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> +			   HWMOD_INIT_NO_IDLE),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1183,7 +1184,8 @@ struct omap_hwmod am33xx_tptc1_hwmod = {
>  	.name		= "tptc1",
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> +			   HWMOD_INIT_NO_IDLE),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> @@ -1197,7 +1199,8 @@ struct omap_hwmod am33xx_tptc2_hwmod = {
>  	.name		= "tptc2",
>  	.class		= &am33xx_tptc_hwmod_class,
>  	.clkdm_name	= "l3_clkdm",
> -	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY),
> +	.flags		= (HWMOD_SWSUP_SIDLE | HWMOD_SWSUP_MSTANDBY |
> +			   HWMOD_INIT_NO_IDLE),
>  	.main_clk	= "l3_gclk",
>  	.prcm		= {
>  		.omap4	= {
> -- 
> 2.6.1
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
