From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v2] OMAP: UART: fix full-fifo write abort
Date: Fri, 5 Feb 2010 01:12:56 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C0B426A1@dbde02.ent.ti.com>
References: <1264760889-6973-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48258 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572Ab0BDTnK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 14:43:10 -0500
In-Reply-To: <1264760889-6973-1-git-send-email-santosh.shilimkar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Woodruff, Richard" <r-woodruff2@ti.com>, "Ghorai, Sukumar" <s-ghorai@ti.com>

Tony,
Can this be merged now in linux-omap ?
> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Friday, January 29, 2010 3:58 PM
> To: tony@atomide.com
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; Woodruff, Richard; Ghorai, Sukumar
> Subject: [PATCH v2] OMAP: UART: fix full-fifo write abort
> 
> This patch is addition to the already merged commit on non-empty
> uart fifo read abort. "ce13d4716a276f4331d78ba28a5093a63822ab95"
> 
> OMAP3630 and OMAP4430 UART IP blocks have a restriction on TX FIFO
> too. If you try to write to the tx fifo when it is full, the system aborts.
> 
> This can be easily reproducible by not suppressing interconnect errors or
> long duration testing where continuous prints over console from multiple
> threads. This patch is addressing the issue by ensuring that write is
> not issued while fifo is full. A timeout is added to avoid any hang
> on fifo-full for 10 mS which is unlikely case.
> 
> Patch is validated on OMAP3630 and OMAP4 SDP.
> 
> V2 version removed the additional 1 uS on every TX as per
> Tony's suggestion
> 
> Signed-off-by: Woodruff Richard <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> CC: Ghorai Sukumar <s-ghorai@ti.com>
> ---
>  arch/arm/mach-omap2/serial.c |   30 ++++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 8c964be..324928d 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -23,6 +23,7 @@
>  #include <linux/serial_reg.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <linux/delay.h>
> 
>  #include <plat/common.h>
>  #include <plat/board.h>
> @@ -139,6 +140,13 @@ static inline unsigned int serial_read_reg(struct plat_serial8250_port *up,
>  	return (unsigned int)__raw_readb(up->membase + offset);
>  }
> 
> +static inline void __serial_write_reg(struct uart_port *up, int offset,
> +		int value)
> +{
> +	offset <<= up->regshift;
> +	__raw_writeb(value, up->membase + offset);
> +}
> +
>  static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
>  				    int value)
>  {
> @@ -598,6 +606,20 @@ static unsigned int serial_in_override(struct uart_port *up, int offset)
>  	return __serial_read_reg(up, offset);
>  }
> 
> +static void serial_out_override(struct uart_port *up, int offset, int value)
> +{
> +	unsigned int status, tmout = 10000;
> +
> +	status = __serial_read_reg(up, UART_LSR);
> +	while (!(status & UART_LSR_THRE)) {
> +		/* Wait up to 10ms for the character(s) to be sent. */
> +		if (--tmout == 0)
> +			break;
> +		udelay(1);
> +		status = __serial_read_reg(up, UART_LSR);
> +	}
> +	__serial_write_reg(up, offset, value);
> +}
>  void __init omap_serial_early_init(void)
>  {
>  	int i;
> @@ -698,11 +720,15 @@ void __init omap_serial_init_port(int port)
>  		 * omap3xxx: Never read empty UART fifo on UARTs
>  		 * with IP rev >=0x52
>  		 */
> -		if (cpu_is_omap44xx())
> +		if (cpu_is_omap44xx()) {
>  			uart->p->serial_in = serial_in_override;
> +			uart->p->serial_out = serial_out_override;
> +		}
>  		else if ((serial_read_reg(uart->p, UART_OMAP_MVER) & 0xFF)
> -				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV)
> +				>= UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV) {
>  			uart->p->serial_in = serial_in_override;
> +			uart->p->serial_out = serial_out_override;
> +		}
>  }
> 
>  /**
> --
> 1.6.0.4

