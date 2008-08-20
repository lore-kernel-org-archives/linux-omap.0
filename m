From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2EVM TWL4030 keypad update
Date: Wed, 20 Aug 2008 15:24:09 +0300
Message-ID: <20080820122408.GI29374@atomide.com>
References: <dfeb90390808190200m200eb292q194b648236ba0f0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58461 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753012AbYHTMYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Aug 2008 08:24:41 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390808190200m200eb292q194b648236ba0f0e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <getarunks@gmail.com>
Cc: linux-omap@vger.kernel.org

* Arun KS <getarunks@gmail.com> [080819 12:01]:
> Now we are passing irq number via platform_data

Pushing today.

Tony


> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/mach-omap2/board-omap2evm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap2evm.c
> b/arch/arm/mach-omap2/board-omap2evm.c
> index 9bb8fba..4188222 100644
> --- a/arch/arm/mach-omap2/board-omap2evm.c
> +++ b/arch/arm/mach-omap2/board-omap2evm.c
> @@ -18,6 +18,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/input.h>
> +#include <linux/i2c/twl4030.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -99,6 +100,7 @@ static struct omap_kp_platform_data omap2evm_kp_data = {
>  	.keymap 	= omap2evm_keymap,
>  	.keymapsize	= ARRAY_SIZE(omap2evm_keymap),
>  	.rep		= 1,
> +	.irq		= TWL4030_MODIRQ_KEYPAD,
>  };
> 
>  static struct platform_device omap2evm_kp_device = {
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
