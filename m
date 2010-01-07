From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] omap: make serial_in_override() address the right uart port
Date: Wed, 06 Jan 2010 16:05:16 -0800
Message-ID: <87r5q293ur.fsf@deeprootsystems.com>
References: <1262710660-25376-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:60228 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933161Ab0AGAFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jan 2010 19:05:22 -0500
Received: by pzk1 with SMTP id 1so2522070pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 06 Jan 2010 16:05:18 -0800 (PST)
In-Reply-To: <1262710660-25376-1-git-send-email-virtuoso@slind.org> (Alexander Shishkin's message of "Tue\,  5 Jan 2010 18\:57\:40 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>

Alexander Shishkin <virtuoso@slind.org> writes:

> Commit f62349ee9788b1d94c55eb6c291d74a1f69bdd9e makes it possible to
> have some other than first uart port as ttyS0, which breaks the workaround
> serial_in_override() function which will try to address the first uart
> port (for ttyS0) and not the one that was initialized.
>
> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> CC: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/serial.c |   12 ++++++++++--
>  1 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 19805a7..8c964be 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -125,6 +125,13 @@ static struct plat_serial8250_port serial_platform_data3[] = {
>  	}
>  };
>  #endif
> +static inline unsigned int __serial_read_reg(struct uart_port *up,
> +					   int offset)
> +{
> +	offset <<= up->regshift;
> +	return (unsigned int)__raw_readb(up->membase + offset);
> +}
> +
>  static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
>  					   int offset)
>  {
> @@ -583,11 +590,12 @@ static unsigned int serial_in_override(struct uart_port *up, int offset)
>  {
>  	if (UART_RX == offset) {
>  		unsigned int lsr;
> -		lsr = serial_read_reg(omap_uart[up->line].p, UART_LSR);
> +		lsr = __serial_read_reg(up, UART_LSR);
>  		if (!(lsr & UART_LSR_DR))
>  			return -EPERM;
>  	}
> -	return serial_read_reg(omap_uart[up->line].p, offset);
> +
> +	return __serial_read_reg(up, offset);
>  }
>  
>  void __init omap_serial_early_init(void)
> -- 
> 1.6.3.3
