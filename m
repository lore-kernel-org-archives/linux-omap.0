From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM][PATCH 1/4] OMAP3: Serial: Add context save and restore for mcr
Date: Wed, 05 May 2010 16:49:38 -0700
Message-ID: <87pr19ykml.fsf@deeprootsystems.com>
References: <1270749249-14041-1-git-send-email-nm@ti.com>
	<1270749249-14041-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52457 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133Ab0EEXtn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 19:49:43 -0400
Received: by vws12 with SMTP id 12so1525644vws.19
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 16:49:42 -0700 (PDT)
In-Reply-To: <1270749249-14041-2-git-send-email-nm@ti.com> (Nishanth Menon's message of "Thu\,  8 Apr 2010 12\:54\:06 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Govindraj R <govindraj.raja@ti.com>, Tero Kristo <tero.kristo@nokia.com>

Nishanth Menon <nm@ti.com> writes:

> From: Govindraj R <govindraj.raja@ti.com>
>
> Ref:
> http://git.omapzoom.org/?p=kernel/omap.git;a=commitdiff;h=c74952c3077e4b19e649b5b48c785c01f73ab9d4
>
> Adds context save/restore for mcr register as state of mcr register
> is lost after core off.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Tero Kristo <tero.kristo@nokia.com>
>
> Signed-off-by: Govindraj R <govindraj.raja@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

OK, adding to pm-next, and queing (hopefully) for 2.6.35.

Kevin

> ---
> Note: Original Patch was done for android kernel, was ported and sanity
> tested to l-o pm.  A quick check did not reveal any mcr access in
> arch/arm/mach-omap2/serial.c though drivers/serial/8250.c seems to
> hit on it a lot, hence posting.
>
>  arch/arm/mach-omap2/serial.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index b731556..86d3b47 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -78,6 +78,7 @@ struct omap_uart_state {
>  	u16 sysc;
>  	u16 scr;
>  	u16 wer;
> +	u16 mcr;
>  #endif
>  };
>  
> @@ -201,6 +202,9 @@ static void omap_uart_save_context(struct omap_uart_state *uart)
>  	uart->sysc = serial_read_reg(p, UART_OMAP_SYSC);
>  	uart->scr = serial_read_reg(p, UART_OMAP_SCR);
>  	uart->wer = serial_read_reg(p, UART_OMAP_WER);
> +	serial_write_reg(p, UART_LCR, 0x80);
> +	uart->mcr = serial_read_reg(p, UART_MCR);
> +	serial_write_reg(p, UART_LCR, lcr);
>  
>  	uart->context_valid = 1;
>  }
> @@ -229,6 +233,8 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
>  	serial_write_reg(p, UART_DLM, uart->dlh);
>  	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
>  	serial_write_reg(p, UART_IER, uart->ier);
> +	serial_write_reg(p, UART_LCR, 0x80);
> +	serial_write_reg(p, UART_MCR, uart->mcr);
>  	serial_write_reg(p, UART_FCR, 0xA1);
>  	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
>  	serial_write_reg(p, UART_EFR, efr);
> -- 
> 1.6.3.3
