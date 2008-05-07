From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mach-omap2/serial.c: fix minor bug and checkpatch
	warnings
Date: Wed, 7 May 2008 16:38:40 -0700
Message-ID: <20080507233840.GT18682@atomide.com>
References: <alpine.DEB.1.00.0805071348280.8498@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55239 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYEGXim (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2008 19:38:42 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0805071348280.8498@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com

* Paul Walmsley <paul@pwsan.com> [080507 12:51]:
> 
> omap_serial_init() in arch/arm/mach-omap2/serial.c clears the wrong
> variable if it can't clk_get() a fclk - fix this.  Also fix some
> checkpatch.pl warnings.

I've pushed this but left out the unnecessary braces around both 
clk_enable() lines.

Tony

> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
> 
>  arch/arm/mach-omap2/serial.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
> 
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 54ab7af..bb79f43 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -18,7 +18,7 @@
>  #include <linux/serial_reg.h>
>  #include <linux/clk.h>
>  
> -#include <asm/io.h>
> +#include <linux/io.h>
>  
>  #include <asm/arch/common.h>
>  #include <asm/arch/board.h>
> @@ -127,17 +127,17 @@ void __init omap_serial_init(void)
>  		if (IS_ERR(uart_ick[i])) {
>  			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
>  			uart_ick[i] = NULL;
> -		}
> -		else
> +		} else {
>  			clk_enable(uart_ick[i]);
> +		}
>  		sprintf(name, "uart%d_fck", i+1);
>  		uart_fck[i] = clk_get(NULL, name);
>  		if (IS_ERR(uart_fck[i])) {
>  			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> -			uart_ick[i] = NULL;
> -		}
> -		else
> +			uart_fck[i] = NULL;
> +		} else {
>  			clk_enable(uart_fck[i]);
> +		}
>  
>  		omap_serial_reset(p);
>  	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
