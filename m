From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] omap: serial: fix non-empty rx uart fifo abort
Date: Tue, 17 Nov 2009 09:06:46 -0800
Message-ID: <20091117170646.GD29266@atomide.com>
References: <1258412036-31986-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53658 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbZKQRGp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 12:06:45 -0500
Content-Disposition: inline
In-Reply-To: <1258412036-31986-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org

* Vikram Pandita <vikram.pandita@ti.com> [091116 15:00]:
> Empty uart rx fifo read can cause omap to abort
> OMAP silicon affected: OMAP3630, OMAP4430
> OMAP silicon not-affected: omap1/2/3
> 
> So pass flag UPF_NO_EMPTY_FIFO_READ in plat_serial8250_port, so that 8250
> driver does not abort on empty rx fifo read
> 
> Tested on zoom3(3630) board

This too as it depends on the 1/2 patch.

Tony
 
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 2e17b57..669652b 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -624,8 +624,15 @@ void __init omap_serial_early_init(void)
>  		uart->p = p;
>  		list_add_tail(&uart->node, &uart_list);
>  
> -		if (cpu_is_omap44xx())
> +		if (cpu_is_omap44xx()) {
>  			p->irq += 32;
> +			/* Do not read empty UART fifo on omap4 */
> +			p->flags |= UPF_NO_EMPTY_FIFO_READ;
> +		}
> +
> +		/* Do not read empty UART fifo on omap3630 */
> +		if (cpu_is_omap3630())
> +			p->flags |= UPF_NO_EMPTY_FIFO_READ;
>  
>  		omap_uart_enable_clocks(uart);
>  	}
> -- 
> 1.6.5.1.69.g36942
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
