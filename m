From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 13/16] tty: serial: 8250_dma: add pm runtime
Date: Mon, 29 Sep 2014 11:26:06 +0200
Message-ID: <20140929092606.GC13952@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-14-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410377411-26656-14-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 10, 2014 at 09:30:08PM +0200, Sebastian Andrzej Siewior wrote:
> There is nothing to do for RPM in the RX path. If the HW goes off then it
> won't assert the DMA line and the transfer won't happen. So we hope that
> the HW does not go off for RX to work (DMA or PIO makes no difference
> here).
> 
> For TX the situation is slightly different. RPM is enabled on
> start_tx(). We can't disable RPM on DMA complete callback because there
> is still data in the FIFO which is being sent. We have to wait until
> the FIFO is empty before we disable it.
> For this to happen we fake a TX sent error and enable THRI. Once the
> FIFO is empty we receive an interrupt and since the TTY-buffer is still
> empty we "put RPM" via __stop_tx(). Should it been filed then in the
> start_tx() path we should program the DMA transfer and remove the error
> flag and the THRI bit.

That last sentence starts out a bit messy.


> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index 898a6781d0b3..e8850219b150 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -21,6 +21,7 @@ static void __dma_tx_complete(void *param)
>  	struct uart_8250_dma	*dma = p->dma;
>  	struct circ_buf		*xmit = &p->port.state->xmit;
>  	unsigned long	flags;
> +	bool en_thri = false;
>  
>  	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
>  				UART_XMIT_SIZE, DMA_TO_DEVICE);
> @@ -40,11 +41,16 @@ static void __dma_tx_complete(void *param)
>  		int ret;
>  
>  		ret = serial8250_tx_dma(p);
> -		if (ret) {
> -			dma->tx_err = 1;
> -			p->ier |= UART_IER_THRI;
> -			serial_port_out(&p->port, UART_IER, p->ier);
> -		}
> +		if (ret)
> +			en_thri = true;
> +
> +	} else if (p->capabilities & UART_CAP_RPM)
> +		en_thri = true;
> +
> +	if (en_thri) {
> +		dma->tx_err = 1;
> +		p->ier |= UART_IER_THRI;
> +		serial_port_out(&p->port, UART_IER, p->ier);
>  	}
>  
>  	spin_unlock_irqrestore(&p->port.lock, flags);
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
