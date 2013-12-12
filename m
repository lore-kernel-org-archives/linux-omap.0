From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH] ARM: DRA7: hwmod: Fix boot crash with DEBUG_LL
Date: Thu, 12 Dec 2013 15:40:34 +0530
Message-ID: <52A98B9A.4080804@ti.com>
References: <1386841969-765-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50577 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab3LLKLC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Dec 2013 05:11:02 -0500
In-Reply-To: <1386841969-765-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, bcousson@baylibre.com, paul@pwsan.com

Hi Rajendra,
On Thursday 12 December 2013 03:22 PM, Rajendra Nayak wrote:
> With commit '7dedd34: ARM: OMAP2+: hwmod: Fix a crash in _setup_reset() with
>  DEBUG_LL' we moved from parsing cmdline to identify uart used for earlycon
> to using the requsite hwmod CONFIG_DEBUG_OMAPxUARTy FLAGS.
> 
> On DRA7 though, we seem to be missing this flag, and atleast on the DRA7 EVM
> where we use uart1 for console, boot fails with DEBUG_LL enabled.
> 
> Reported-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Tested on DRA7 evm using Tero's V10 clock series.

Tested-by:  Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh 
> ---
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> index db32d53..18f333c 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -1637,7 +1637,7 @@ static struct omap_hwmod dra7xx_uart1_hwmod = {
>  	.class		= &dra7xx_uart_hwmod_class,
>  	.clkdm_name	= "l4per_clkdm",
>  	.main_clk	= "uart1_gfclk_mux",
> -	.flags		= HWMOD_SWSUP_SIDLE_ACT,
> +	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP2UART1_FLAGS,
>  	.prcm = {
>  		.omap4 = {
>  			.clkctrl_offs = DRA7XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
> 

