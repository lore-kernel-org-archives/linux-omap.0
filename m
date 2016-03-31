From: John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Thu, 31 Mar 2016 12:51:36 +0200
Message-ID: <87vb42gbt3.fsf@linutronix.de>
References: <8737r7ght7.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8737r7ght7.fsf@linutronix.de> (John Ogness's message of "Thu, 31
	Mar 2016 10:41:56 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 2016-03-31, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 6f76051..9459b4d 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -460,6 +451,24 @@ static void omap_8250_set_termios(struct uart_port *port,
>  			priv->efr |= OMAP_UART_SW_TX;
>  		}
>  	}
> +
> +	if (dma && dma->tx_running) {
> +		/*
> +		 * TCSANOW requests the change to occur immediately, however
> +		 * if we have a TX-DMA operation in progress then it has been
> +		 * observed that it might stall and never complete. Therefore
> +		 * we wait until DMA completes to prevent this hang from
> +		 * happening.
> +		 */
> +
> +		dma->tx_running = 2;
> +
> +		spin_unlock_irq(&up->port.lock);
> +		wait_event_interruptible(priv->termios_wait,
> +					 dma->tx_running == 3);
> +		spin_lock_irq(&up->port.lock);
> +		complete_dma = 1;
> +	}

Sorry, I just realized that wait_event_interruptible() is used
here. IMHO this should be changed to wait_event(), otherwise a signal
could trigger the TX-DMA deadlock this code is trying to prevent.

If hardware flow control is active, it is possible that wait_event()
leads to the caller waiting forever. But allowing interruptible causes
too many problems since set_termios() cannot communicate errors.

John Ogness
