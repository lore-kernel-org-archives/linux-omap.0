From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 11:55:46 +0100
Message-ID: <20150807105546.GL7576@n2100.arm.linux.org.uk>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
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

How do you cope with the OMAP DMA hardware clearing its FIFO when you
pause it?

The problem is that on mem-to-device transfers, the DMA hardware can
prefetch some data from memory into its FIFO before the device wants
the data.  If you then disable the channel, the hardware clears the
FIFO.

It is unspecified whether the hardware updates the source address in
this case, or by how much.  So it's pretty hard to undo the prefetching
in software.

The net result is: data loss.

This is why I explicitly did not implement pause/resume for non-cyclic
channels.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
