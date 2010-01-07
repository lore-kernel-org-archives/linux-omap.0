From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] omap: serial: fix coding style indentaion
Date: Thu, 07 Jan 2010 11:51:44 -0800
Message-ID: <877hrty9pr.fsf@deeprootsystems.com>
References: <1262893095-5091-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:35622 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753939Ab0AGTvq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 14:51:46 -0500
Received: by pwj9 with SMTP id 9so12180762pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 07 Jan 2010 11:51:46 -0800 (PST)
In-Reply-To: <1262893095-5091-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Thu\,  7 Jan 2010 13\:38\:15 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, "Menon, Nishanth" <nm@ti.com>

Vikram Pandita <vikram.pandita@ti.com> writes:

> No logical code change
>
> Fix coding style indentaion as per checkpatch.pl
> Fix multi-line comment style reported by Nishanth Menon
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Menon, Nishanth <nm@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/serial.c |   19 ++++++++++---------
>  1 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 8c964be..837b347 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -694,15 +694,16 @@ void __init omap_serial_init_port(int port)
>  		DEV_CREATE_FILE(dev, &dev_attr_sleep_timeout);
>  	}
>  
> -		/* omap44xx: Never read empty UART fifo
> -		 * omap3xxx: Never read empty UART fifo on UARTs
> -		 * with IP rev >=0x52
> -		 */
> -		if (cpu_is_omap44xx())
> -			uart->p->serial_in = serial_in_override;
> -		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> -				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> -			uart->p->serial_in = serial_in_override;
> +	/*
> +	 * omap44xx: Never read empty UART fifo
> +	 * omap3xxx: Never read empty UART fifo on UARTs
> +	 * with IP rev >=0x52
> +	 */
> +	if (cpu_is_omap44xx())
> +		uart->p->serial_in = serial_in_override;
> +	else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> +			>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +		uart->p->serial_in = serial_in_override;
>  }
>  
>  /**
> -- 
> 1.6.6.rc0.66.ge160d
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
