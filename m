From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: DRA7: beagle-x15: hwmod: Fix boot crash with
 DEBUG_LL
Date: Tue, 6 Jan 2015 08:05:17 -0600
Message-ID: <20150106140517.GA3897@kahuna>
References: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1420532690-29340-1-git-send-email-lokeshvutla@ti.com>
Sender: stable-owner@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, nsekhar@ti.com, t-kristo@ti.com, balbi@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

$subject should probably need a cleanup: this is hwmod support for
DEBUG_LL on UART3 - x15 happens to be one of the platforms that uses
that, but not the only one.. I suggest removing x15 from $subject and
rephrasing accordingly.

On 13:54-20150106, Lokesh Vutla wrote:
> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
> DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
> to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On beagle-x15, we use uart3 for console and missed enabling this flag

Official name of the platform is BeagleBoard-X15

> for uart3 hwmod, so boot fails with DEBUG_LL. Enable DEBUG_OMAP4UART3_FLAGS for
> uart3 hwmod.

Could you align your commit message to 70 chars if possible?
> 
> For using DEBUG_LL, enable CONFIG_DEBUG_OMAP4UART3 in menuconfig.
> 
> Fixes: 90020c7 (ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data)

Fixes: 90020c7b2c5e ("ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data")

> Cc: <stable@vger.kernel.org> # v3.12+
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index ffd6604..b6ea88f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2017,7 +2017,7 @@ static struct omap_hwmod dra7xx_uart3_hwmod = {
>  	.class		= &dra7xx_uart_hwmod_class,
>  	.clkdm_name	= "l4per_clkdm",
>  	.main_clk	= "uart3_gfclk_mux",
> -	.flags		= HWMOD_SWSUP_SIDLE_ACT,
> +	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART3_FLAGS,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
> -- 
> 1.9.1
> 

-- 
Regards,
Nishanth Menon
