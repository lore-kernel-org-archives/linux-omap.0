From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Thu, 30 Jul 2015 20:51:10 -0400
Message-ID: <55BAC67E.1010400@hurleysoftware.com>
References: <87egjp2r4a.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87egjp2r4a.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi John,

On 07/30/2015 06:54 PM, John Ogness wrote:
> If DMA is active during a shutdown, a delayed restore of the
> registers may be pending. The restore must be performed after
> the DMA is stopped, otherwise the delayed restore remains
> pending and will fire upon the first DMA TX complete of a
> totally different serial session.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 5b39892..25f6255 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -657,9 +657,15 @@ static void omap_8250_shutdown(struct uart_port *port)
>  	up->ier = 0;
>  	serial_out(up, UART_IER, 0);
>  
> -	if (up->dma)
> +	if (up->dma) {
>  		serial8250_release_dma(up);
>  
> +		if (priv->delayed_restore) {
> +			priv->delayed_restore = 0;
> +			omap8250_restore_regs(up);
> +		}

I was never really a fan of the deferred set_termios();
I think it's more appropriate to wait for tx dma to
complete in omap_8250_set_termios().

Regards,
Peter Hurley


> +	}
> +
>  	/*
>  	 * Disable break condition and FIFOs
>  	 */
> 
