From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4] dmaengine: omap-dma: add support for pause of
 non-cyclic transfers
Date: Tue, 18 Oct 2016 20:22:23 +0530
Message-ID: <20161018145223.GA2467@localhost>
References: <20161010120755.26153-1-vigneshr@ti.com>
 <20161014050047.28447-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161014050047.28447-1-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 14, 2016 at 10:30:47AM +0530, Vignesh R wrote:
> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> This DMA driver is used by 8250-omap on DRA7-evm. There is one
> requirement that is to pause a transfer. This is currently used on the RX
> side. It is possible that the UART HW aborted the RX (UART's RX-timeout)
> but the DMA controller starts the transfer shortly after.
> Before we can manually purge the FIFO we need to pause the transfer,
> check how many bytes it already received and terminate the transfer
> without it making any progress.
> 
> From testing on the TX side it seems that it is possible that we invoke
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

Applied, thanks

-- 
~Vinod
