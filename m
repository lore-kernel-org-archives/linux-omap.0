From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 17:26:48 +0100
Message-ID: <20150807162648.GR7576@n2100.arm.linux.org.uk>
References: <1438961765-22554-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438961765-22554-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 05:36:05PM +0200, Sebastian Andrzej Siewior wrote:
> +		/*
> +		 * We do not allow DMA_MEM_TO_DEV transfers to be paused.
> +		 * According to RMK the OMAP hardware might prefetch bytes from
> +		 * memory into its FIFO and not send it to the device due to the
> +		 * pause. The bytes in the FIFO are cleared on pause. It is
> +		 * unspecified by how many bytes the source address is updated
> +		 * if at all.

Would you mind rewording the above.

Please take the time to read the manuals for the device you are playing
with.  It's mostly documented in there.  See the OMAP4430 ES2.x TRM,
16.4.18 and 16.4.19.

16.4.19 states that:

 "When a source-synchronized channel is disabled during a transfer...
 "In all other cases, the channel undergoes an abort."

A source-synchronised channel is one where the fetching of data is under
control of the device.  In other words, a device-to-memory transfer.

So, a destination-synchronised channel (which would be a memory-to-device
transfer) undergoes an abort if you clear the enable bit.

16.4.20.4.6.2 defines what happens when a channel aborts:

 "If an abort trigger occurs, the channel aborts immediately after
  completion of current read/write transactions and then FIFO is
  cleaned up."

It doesn't define what "cleaned up" means, so that's open to some
interpretation.  That's why I contacted TI about this back in 2012:
| What is the behaviour of the OMAP DMA hardware when the DMA4_CCRi[7]
| enable bit is cleared and subsequently set without any additional
| reprogramming?  I'm thinking specifically about memory-to-device DMA
| operations, in particular the UART ports.
| 
| Will this allow a transfer to be temporarily paused, and then
| subsequently resumed with out loss of data in the DMA hardware, as if
| nothing had actually happened?

The answer I received was to check that RD_ACTIVE and WR_ACTIVE are both
clear _before_ disabling the channel, otherwise data loss will occur.

The problem is that if the channel is active, then device activity can
result in DMA activity starting between reading those as both clear and
the write to DMA_CCR to clear the enable bit hitting the hardware.

The explanation went on to say that if the DMA hardware can't drain
the data in its FIFO to the destination, then data loss "might" occur.

That will occur if we're destination-synchronised (eg) to a UART and
the UART is not accepting any further data.

Due to this, the OMAP DMA engine driver was submitted with this in the
cover note:

"For the OMAP DMAengine driver, there's a few short-comings:

1. pause/resume support is not implemented; it's not clear whether the
   OMAP hardware is capable of supporting this sanely."

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
