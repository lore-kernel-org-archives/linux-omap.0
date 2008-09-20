From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Sat, 20 Sep 2008 10:22:49 -0700
Message-ID: <200809201022.49350.david-b@pacbell.net>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:28345 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750779AbYITRWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 20 Sep 2008 13:22:51 -0400
In-Reply-To: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arun c <arunedarath@mistralsolutions.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Friday 19 September 2008, arun c wrote:
> without this the below error messages were coming continuously
> 
> TWL4030 module irq 369 is disabled but can't be masked!

I can see how it would fix that.  :)

But this is also a good illustration of why this keypad device
should be initialized differently ... this particular data is
not board-specific, and the root cause of the problem was that
the device wasn't set up as part of twl4030 setup.

The clean fix requires twl4030 to be a "new style" driver.
Fix not yet available. :(

- Dave


> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
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
