From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 03/16] tty: serial: 8250_core: read only RX if there is
 something in the FIFO
Date: Thu, 12 Feb 2015 14:55:38 -0500
Message-ID: <54DD053A.8060905@hurleysoftware.com>
References: <1410377411-26656-4-git-send-email-bigeasy@linutronix.de> <54D8B772.1010405@freebox.fr> <54D9441B.7070403@hurleysoftware.com> <54D9F3C7.5000809@freebox.fr> <54DA43F8.9090904@hurleysoftware.com> <54DBB531.2030504@hurleysoftware.com> <20150211200313.GE2531@atomide.com> <54DBBE9E.90104@hurleysoftware.com> <54DC6832.3070507@linutronix.de> <54DCD584.3010500@hurleysoftware.com> <20150212192333.GA18882@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150212192333.GA18882@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, Nicolas Schichan <nschichan@freebox.fr>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/12/2015 02:23 PM, Sebastian Andrzej Siewior wrote:
> * Peter Hurley | 2015-02-12 11:32:04 [-0500]:
> 
>> That said, I don't think serial8250_do_startup() is really doing that much
>> for OMAP h/w startup; open-coding what omap_8250 really needs is probably
>> < 10 loc.
> 
> 10 loc? I have a few more.

:)

> serial8250_clear_fifos(),
> serial_link_irq_chain() aren't exported. serial8250_set_mctrl() can
> maybe accessed via uart_ops->set_mctrl(). Maybe I'm not removing the
> obvious not required code but here it looks better to just a BUG flag for
> the Omap.

Ok.

FWIW,

> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -557,9 +557,74 @@ static int omap_8250_startup(struct uart_port *port)
>  
>  	pm_runtime_get_sync(port->dev);
>  
> -	ret = serial8250_do_startup(port);
> -	if (ret)
> -		goto err;
> +	up->mcr = 0;
> +
> +	/*
> +	 * Clear the FIFO buffers and disable them.
> +	 * (they will be reenabled in set_termios())
> +	 */
> +	serial8250_clear_fifos(up);

For omap this would just be:

	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);

In any event, the fifo enable/disable is probably not happening since
FIFO_EN is ignored unless the divisor == 0.

> +
> +	/*
> +	 * Clear the interrupt registers.
> +	 */
> +	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
> +	serial_port_in(port, UART_IIR);
> +	serial_port_in(port, UART_MSR);
> +
> +	retval = serial_link_irq_chain(up);
> +	if (retval)
> +		goto out;

omap doesn't really need the legacy irq chain handling; this could just be
request_irq().

In the 8250 split I'll be posting soon, all the irq chaining and
polling-via-timeout workarounds stays in the universal/legacy driver so
other 8250 drivers can opt-out.

> +
> +	/*
> +	 * Now, initialize the UART
> +	 */
> +	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
> +

--- >% ---
> +	spin_lock_irqsave(&port->lock, flags);
> +	/*
> +	 * Most PC uarts need OUT2 raised to enable interrupts.
> +	 */
> +	if (port->irq)
> +		up->port.mctrl |= TIOCM_OUT2;
> +
> +	serial8250_set_mctrl(port, port->mctrl);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +

None of this is required because there is no OUT2 on omap.
---------

--- >% ----
> +	/*
> +	 * Clear the interrupt registers again for luck, and clear the
> +	 * saved flags to avoid getting false values from polling
> +	 * routines or the previous session.
> +	 */
> +	if (serial_port_in(port, UART_LSR) & UART_LSR_DR)
> +		serial_port_in(port, UART_RX);
> +	serial_port_in(port, UART_IIR);
> +	serial_port_in(port, UART_MSR);

None of this is required because none of the probing is taking place.
------------


> +	up->lsr_saved_flags = 0;
> +	up->msr_saved_flags = 0;
> +
> +	/*
> +	 * Request DMA channels for both RX and TX.
> +	 */
> +	if (up->dma) {
> +		retval = serial8250_request_dma(up);
> +		if (retval) {
> +			pr_warn_ratelimited("ttyS%d - failed to request DMA\n",
> +					    serial_index(port));
> +			up->dma = NULL;
> +		}
> +	}
> +
> +	/*
> +	 * Finally, enable interrupts.  Note: Modem status interrupts
> +	 * are set via set_termios(), which will be occurring imminently
> +	 * anyway, so we don't enable them here.
> +	 */
> +	up->ier = UART_IER_RLSI | UART_IER_RDI;
> +	serial_port_out(port, UART_IER, up->ier);
> +
>  
>  #ifdef CONFIG_PM
>  	up->capabilities |= UART_CAP_RPM;
> 
> Sebastian
> 
