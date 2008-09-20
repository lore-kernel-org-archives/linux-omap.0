From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Sat, 20 Sep 2008 14:24:44 +0300
Message-ID: <20080920112441.GD10156@frodo>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60325 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbYITLZJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2008 07:25:09 -0400
Content-Disposition: inline
In-Reply-To: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Sep 20, 2008 at 02:51:40AM -0400, arun c wrote:
> without this the below error messages were coming continuously
> 
> TWL4030 module irq 369 is disabled but can't be masked!
> <2>TWL4030 module irq 369 is disabled but can't be masked!
> 
> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>

Acked-by: Felipe Balbi <felipe.balbi@nokia.com>

> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
> b/arch/arm/mach-omap2/board-omap3evm.c
> index 92f70ce..f9fd06b 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -22,6 +22,7 @@
>  #include <linux/input.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spi/ads7846.h>
> +#include <linux/i2c/twl4030.h>
> 
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -176,6 +177,7 @@ static struct omap_kp_platform_data omap3evm_kp_data = {
>  	.keymap 	= omap3evm_keymap,
>  	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
>  	.rep		= 1,
> +	.irq		= TWL4030_MODIRQ_KEYPAD,
>  };
> 
>  static struct platform_device omap3evm_kp_device = {
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
