From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: UART: fix full-fifo write abort
Date: Wed, 27 Jan 2010 09:32:50 -0800
Message-ID: <20100127173249.GC23505@atomide.com>
References: <1264588584-13301-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62123 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab0A0Rca (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Jan 2010 12:32:30 -0500
Content-Disposition: inline
In-Reply-To: <1264588584-13301-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Woodruff Richard <r-woodruff2@ti.com>, Ghorai Sukumar <s-ghorai@ti.com>

* Santosh Shilimkar <santosh.shilimkar@ti.com> [100127 02:34]:
> This patch is addition to the already merged commit on non-empty
> uart fifo read abort. "ce13d4716a276f4331d78ba28a5093a63822ab95"
> 
> OMAP3630 and OMAP4430 UART IP blocks have a restriction on TX FIFO
> too. If you try to write to the tx fifo when it is full, the system aborts.
> 
> This can be easily reproducible by not suppressing interconnect errors or
> long duartion testing where continous prints over console from multiple
> threads . This patch is addressing the issue by ensuring that write is
> not issued while fifo is full. A timeout is added to avoid any hang
> on fifo-full for 10 mS which is unlikely case.
> 
> Patch is validated on OMAP3630 and OMAP4 SDP.

Can you do this as needed based on the FIFO interrupt?

 
> Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Ghorai Sukumar <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c

<snip>
  
> +static void serial_out_override(struct uart_port *up, int offset, int value)
> +{
> +	unsigned int status, tmout = 10000;
> +
> +	/* Wait up to 10ms for the character(s) to be sent. */
> +	do {
> +		status = __serial_read_reg(up, UART_LSR);
> +		if (--tmout == 0)
> +			break;
> +		udelay(1);
> +	} while (!(status & UART_LSR_THRE));
> +
> +	__serial_write_reg(up, offset, value);

Do you really want to have a udelay on every TX?

How about:

	status = __serial_read_reg(up, UART_LSR);
	while (!(status & UART_LSR_THRE)) {

		if (--tmout == 0)
			break;

		udelay(1);
		status = __serial_read_reg(up, UART_LSR);
	}
	__serial_write_reg(up, offset, value);

Regards,

Tony
