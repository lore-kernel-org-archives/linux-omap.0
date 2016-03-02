From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH 3/3] serial: 8250: omap: restore registers on shutdown
Date: Wed, 02 Mar 2016 10:54:03 +0100
Message-ID: <87egbtdx38.fsf@linutronix.de>
References: <87egjp2r4a.fsf@linutronix.de>
	<55BAC67E.1010400@hurleysoftware.com>
	<20150803160937.GA26497@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150803160937.GA26497@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Mon, 3 Aug 2015 18:09:37 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, nsekhar@ti.com, nm@ti.com, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian, Peter,

On 2015-08-03, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> * Peter Hurley | 2015-07-30 20:51:10 [-0400]:
>> I was never really a fan of the deferred set_termios();
>> I think it's more appropriate to wait for tx dma to
>> complete in omap_8250_set_termios().
>
> So you want something like this? This was only compile + boot tested
> (without triggering the corner case) [...] Just checking if this is
> what you had in mind.

I tested this against next-20160226 using an AM335x (beaglebone
black). I made sure the corner case was hit. I also ran tests of
terminating the sender or termios-setter while in the corner
case. Everything ran without any problems.

> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index d9a37191a1ae..12249125a218 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -100,9 +100,9 @@ struct omap8250_priv {
>  	u8 wer;
>  	u8 xon;
>  	u8 xoff;
> -	u8 delayed_restore;
>  	u16 quot;
>  
> +	wait_queue_head_t termios_wait;
>  	bool is_suspending;
>  	int wakeirq;
>  	int wakeups_enabled;
> @@ -256,18 +256,6 @@ static void omap8250_update_mdr1(struct uart_8250_port *up,
>  static void omap8250_restore_regs(struct uart_8250_port *up)
>  {
>  	struct omap8250_priv *priv = up->port.private_data;
> -	struct uart_8250_dma	*dma = up->dma;
> -
> -	if (dma && dma->tx_running) {
> -		/*
> -		 * TCSANOW requests the change to occur immediately however if
> -		 * we have a TX-DMA operation in progress then it has been
> -		 * observed that it might stall and never complete. Therefore we
> -		 * delay DMA completes to prevent this hang from happen.
> -		 */
> -		priv->delayed_restore = 1;
> -		return;
> -	}
>  
>  	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
>  	serial_out(up, UART_EFR, UART_EFR_ECB);
> @@ -309,6 +297,7 @@ static void omap8250_restore_regs(struct uart_8250_port *up)
>  	up->port.ops->set_mctrl(&up->port, up->port.mctrl);
>  }
>  
> +static void omap_8250_dma_tx_complete(void *param);
>  /*
>   * OMAP can use "CLK / (16 or 13) / div" for baud rate. And then we have have
>   * some differences in how we want to handle flow control.
> @@ -322,6 +311,7 @@ static void omap_8250_set_termios(struct uart_port *port,
>  	struct omap8250_priv *priv = up->port.private_data;
>  	unsigned char cval = 0;
>  	unsigned int baud;
> +	unsigned int complete_dma = 0;
>  
>  	switch (termios->c_cflag & CSIZE) {
>  	case CS5:
> @@ -473,6 +463,25 @@ static void omap_8250_set_termios(struct uart_port *port,
>  		if (termios->c_iflag & IXANY)
>  			up->mcr |= UART_MCR_XONANY;
>  	}
> +
> +	if (up->dma && up->dma->tx_running) {
> +		struct uart_8250_dma	*dma = up->dma;
> +
> +		/*
> +		 * TCSANOW requests the change to occur immediately however if
> +		 * we have a TX-DMA operation in progress then it has been
> +		 * observed that it might stall and never complete. Therefore we
> +		 * wait until DMA completes to prevent this hang from happen.
> +		 */
> +
> +		dma->tx_running = 2;
> +
> +		spin_unlock_irq(&up->port.lock);
> +		wait_event(priv->termios_wait,
> +			   dma->tx_running == 3);

If I comment out the wait_event() call here, I can reproduce the DMA
stalls reported by the comments.

> +		spin_lock_irq(&up->port.lock);
> +		complete_dma = 1;
> +	}
>  	omap8250_restore_regs(up);
>  
>  	spin_unlock_irq(&up->port.lock);
> @@ -488,6 +497,8 @@ static void omap_8250_set_termios(struct uart_port *port,
>  	/* Don't rewrite B0 */
>  	if (tty_termios_baud_rate(termios))
>  		tty_termios_encode_baud_rate(termios, baud, baud);
> +	if (complete_dma)
> +		omap_8250_dma_tx_complete(up);
>  }
>  
>  /* same as 8250 except that we may have extra flow bits set in EFR */
> @@ -869,17 +880,18 @@ static void omap_8250_dma_tx_complete(void *param)
>  
>  	spin_lock_irqsave(&p->port.lock, flags);
>  
> +	if (dma->tx_running == 2) {
> +		dma->tx_running = 3;
> +		wake_up(&priv->termios_wait);
> +		goto out;
> +	}
> +
>  	dma->tx_running = 0;
>  
>  	xmit->tail += dma->tx_size;
>  	xmit->tail &= UART_XMIT_SIZE - 1;
>  	p->port.icount.tx += dma->tx_size;
>  
> -	if (priv->delayed_restore) {
> -		priv->delayed_restore = 0;
> -		omap8250_restore_regs(p);
> -	}
> -
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>  		uart_write_wakeup(&p->port);
>  
> @@ -899,7 +911,7 @@ static void omap_8250_dma_tx_complete(void *param)
>  		p->ier |= UART_IER_THRI;
>  		serial_port_out(&p->port, UART_IER, p->ier);
>  	}
> -
> +out:
>  	spin_unlock_irqrestore(&p->port.lock, flags);
>  }
>  
> @@ -1216,6 +1228,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  			priv->omap8250_dma.rx_size = RX_TRIGGER;
>  			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
>  			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
> +			init_waitqueue_head(&priv->termios_wait);
>  
>  			if (of_machine_is_compatible("ti,am33xx"))
>  				priv->habit |= OMAP_DMA_TX_KICK;
>

John Ogness
