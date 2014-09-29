From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 12/16] tty: serial: 8250_dma: handle the UART RDI event
 while DMA remains idle
Date: Mon, 29 Sep 2014 11:23:40 +0200
Message-ID: <20140929092340.GB13952@ci00147.xsens-tech.local>
References: <1410377411-26656-1-git-send-email-bigeasy@linutronix.de>
 <1410377411-26656-13-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1410377411-26656-13-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 10, 2014 at 09:30:07PM +0200, Sebastian Andrzej Siewior wrote:
> Sometimes the OMAP UART does not signal the DMA engine to unload the FIFO.
> Usually this happens when we have >threshold bytes in the FIFO
> and start the DMA transfer. It seems that in those cases the UART won't
> trigger the transfer once the requested threshold is reached. In some
> rare cases the UART does not trigger the DMA transfer even if programmed
> while the FIFO was empty.
> In those cases the UART drops an RDI event and we have to empty the FIFO
> manually. If we ignore it because the DMA transfer is programmed then we
> will enter the function a few times until we receive the RX_TIMEOUT
> event. At that point the FIFO is usually full and we risk to overflow
> the FIFO.
> 
> Reviewed-by: Tony Lindgren <tony@atomide.com>
> Tested-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/tty/serial/8250/8250_dma.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
> index fa1dc966f394..898a6781d0b3 100644
> --- a/drivers/tty/serial/8250/8250_dma.c
> +++ b/drivers/tty/serial/8250/8250_dma.c
> @@ -193,6 +193,24 @@ int serial8250_rx_dma(struct uart_8250_port *p, unsigned int iir)
>  			__dma_rx_do_complete(p, true);
>  		}
>  		return -ETIMEDOUT;
> +	case UART_IIR_RDI:
> +		if (p->bugs & UART_BUG_DMA_RX)
> +			break;
> +		/*
> +		 * The OMAP UART is a special BEAST. If we receive RDI we _have_
> +		 * a DMA transfer programmed but it didn't worked. One reason is

didn't work

> +		 * that we were too slow and there were too many bytes in the
> +		 * FIFO, the UART counted wrong and never kicked the DMA engine
> +		 * to do anything. That means once we receive RDI on OMAP than

then

> +		 * the DMA won't do anything soon so we have to cancel the DMA
> +		 * transfer and purge the FIFO manually.
> +		 */
> +		if (dma->rx_running) {
> +			dmaengine_pause(dma->rxchan);
> +			__dma_rx_do_complete(p, true);
> +		}
> +		return -ETIMEDOUT;
> +
>  	default:
>  		break;
>  	}
> -- 
> 2.1.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
