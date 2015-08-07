From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 10:55:02 -0700
Message-ID: <20150807175502.GA10282@kroah.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 10:41:57AM +0200, Sebastian Andrzej Siewior wrote:
> This DMA driver is used by 8250-omap on DRA7-evm. There is one
> requirement that is to pause a transfer. This is currently used on the RX
> side. It is possible that the UART HW aborted the RX (UART's RX-timeout)
> but the DMA controller starts the transfer shortly after.
> Before we can manually purge the FIFO we need to pause the transfer,
> check how many bytes it already received and terminate the transfer
> without it making any progress.
> 
> >From testing on the TX side it seems that it is possible that we invoke
> pause once the transfer has completed which is indicated by the missing
> CCR_ENABLE bit but before the interrupt has been noticed. In that case the
> interrupt will come even after disabling it.
> 
> The AM572x manual says that we have to wait for the CCR_RD_ACTIVE &
> CCR_WR_ACTIVE bits to be gone before programming it again here is the
> drain loop. Also it looks like without the drain the TX-transfer makes
> sometimes progress.
> 
> One note: The pause + resume combo is broken because after resume the
> the complete transfer will be programmed again. That means the already
> transferred bytes (until the pause event) will be sent again. This is
> currently not important for my UART user because it does only pause +
> terminate.
> 
> Cc: <stable@vger.kernel.org>

You don't get a "add support" patch into the stable tree unless it's a
trivial device id or quirk table addition, please go re-read
Documentation/stable_kernel_rules.txt

thanks,

greg k-h
