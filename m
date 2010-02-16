From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/24] omap4: clocks: Make Uart driver's clock calls
 OMAP4 compatible
Date: Tue, 16 Feb 2010 10:38:31 -0800
Message-ID: <20100216183831.GK21755@atomide.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50845 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055Ab0BPShr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:37:47 -0500
Content-Disposition: inline
In-Reply-To: <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Abhijit Pagare <abhijitpagare@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100216 07:55]:
> From: Abhijit Pagare <abhijitpagare@ti.com>
> 
> The uart driver has been adapted for the OMAP4 way of clock calls.
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

As discussed outside the lists, the fck handling for omap4 should be
done with dummy_ck the same way as we're already doing for omap1. 

Regards,

Tony
  
