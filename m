From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] serial: 8250_omap: check how many bytes were injected
Date: Wed, 26 Aug 2015 08:44:55 -0400
Message-ID: <55DDB4C7.5070709@hurleysoftware.com>
References: <1439568064-7907-1-git-send-email-bigeasy@linutronix.de>
 <1439568064-7907-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439568064-7907-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/14/2015 12:01 PM, Sebastian Andrzej Siewior wrote:
> The function tty_insert_flip_string() returns an int and as such it
> might fail. So the result is that I kindly asked to insert 48 bytes and
> the function only insterted 32.
> I have no idea what to do with the remaining 16 so I think dropping them
> is the only option. I also increase the buf_overrun counter so userpace
> has a clue that we lost bytes.

No objection to the patch but I'm curious whether this is something you've
actually observed and under what circumstances.

Regards,
Peter Hurley


> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_omap.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 2ac63c8bd946..933f7ef2c004 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -738,6 +738,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p, bool error)
>  	struct dma_tx_state     state;
>  	int                     count;
>  	unsigned long		flags;
> +	int			ret;
>  
>  	dma_sync_single_for_cpu(dma->rxchan->device->dev, dma->rx_addr,
>  				dma->rx_size, DMA_FROM_DEVICE);
> @@ -753,8 +754,10 @@ static void __dma_rx_do_complete(struct uart_8250_port *p, bool error)
>  
>  	count = dma->rx_size - state.residue;
>  
> -	tty_insert_flip_string(tty_port, dma->rx_buf, count);
> -	p->port.icount.rx += count;
> +	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
> +
> +	p->port.icount.rx += ret;
> +	p->port.icount.buf_overrun += count - ret;
>  unlock:
>  	spin_unlock_irqrestore(&priv->rx_dma_lock, flags);
>  
> 
