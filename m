From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 08/24] omap4: clocks: Make Uart driver's clock calls
 OMAP4 compatible
Date: Tue, 16 Feb 2010 15:32:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161516080.10478@utopia.booyaka.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com> <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54601 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933126Ab0BPWcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 17:32:39 -0500
In-Reply-To: <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk

Hello Abhijit, Santosh,

On Tue, 16 Feb 2010, Santosh Shilimkar wrote:

> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> The uart driver has been adapted for the OMAP4 way of clock calls.

This patch needs some revision.

According to the 4430 TRM ES1.0 Rev A section 23.3.3 "UART/IrDA/CIR 
Integration", and cross-referencing it with clock44xx_data.c, these clocks 
which are marked as interface clocks should really be marked as functional 
clocks.  For example, in the clock data, they descend from per_48_fclk, 
which according to the TRM diagram, indicates that they are functional 
clocks.  The TRM diagram also names these clocks "UARTx_FCLK" rather than 
"UARTx_CK", perhaps this naming should be preserved? 

Also, rather than adding an extra cpu_is_omap*() conditional in the code 
for a missing clock, please use the dummy_ck functionality.  Santosh will 
need this for OMAP4 I2C anyway; this appears to be another example where 
this is needed.


- Paul

> 
> Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b79bc89..97859b0 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -257,7 +257,8 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
>  		return;
>  
>  	clk_enable(uart->ick);
> -	clk_enable(uart->fck);
> +	if (!cpu_is_omap44xx())
> +		clk_enable(uart->fck);
>  	uart->clocked = 1;
>  	omap_uart_restore_context(uart);
>  }
> @@ -272,7 +273,8 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
>  	omap_uart_save_context(uart);
>  	uart->clocked = 0;
>  	clk_disable(uart->ick);
> -	clk_disable(uart->fck);
> +	if (!cpu_is_omap44xx())
> +		clk_disable(uart->fck);
>  }
>  
>  static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
> @@ -669,18 +671,24 @@ void __init omap_serial_early_init(void)
>  			continue;
>  		}
>  
> -		sprintf(name, "uart%d_ick", i+1);
> +		if (!cpu_is_omap44xx())
> +			sprintf(name, "uart%d_ick", i+1);
> +		else
> +			sprintf(name, "uart%d_ck", i+1);
>  		uart->ick = clk_get(NULL, name);
>  		if (IS_ERR(uart->ick)) {
>  			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
>  			uart->ick = NULL;
>  		}
>  
> -		sprintf(name, "uart%d_fck", i+1);
> -		uart->fck = clk_get(NULL, name);
> -		if (IS_ERR(uart->fck)) {
> -			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> -			uart->fck = NULL;
> +		if (!cpu_is_omap44xx()) {
> +			sprintf(name, "uart%d_fck", i+1);
> +			uart->fck = clk_get(NULL, name);
> +			if (IS_ERR(uart->fck)) {
> +				printk(KERN_ERR "Could not get uart%d_fck\n",
> +									 i+1);
> +				uart->fck = NULL;
> +			}
>  		}
>  
>  		/* FIXME: Remove this once the clkdev is ready */
> -- 
> 1.6.0.4
> 


- Paul
