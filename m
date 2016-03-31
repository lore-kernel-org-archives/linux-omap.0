From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] tty: serial: 8250_omap: do not defer termios changes
Date: Thu, 31 Mar 2016 15:33:39 +0100
Message-ID: <20160331153339.671d305f@lxorguk.ukuu.org.uk>
References: <8737r7ght7.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8737r7ght7.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

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

This look wrong if a signal is received. termios setting is not an
interruptible event and this would mean for example that a random other
signal to a terminal process would cause mysterious non-setting of
termios changes.

Should this therefore not just be a straight wait_event or even a
completion() handler ?

Alan
