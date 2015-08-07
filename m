From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 14:25:51 +0100
Message-ID: <20150807132551.GO7576@n2100.arm.linux.org.uk>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
 <20150807105546.GL7576@n2100.arm.linux.org.uk>
 <55C4A621.4050102@linutronix.de>
 <20150807131746.GM7576@n2100.arm.linux.org.uk>
 <55C4B130.5020409@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C4B130.5020409@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 03:22:56PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/07/2015 03:17 PM, Russell King - ARM Linux wrote:
> > On Fri, Aug 07, 2015 at 02:35:45PM +0200, Sebastian Andrzej Siewior wrote:
> >> On 08/07/2015 12:55 PM, Russell King - ARM Linux wrote:
> >>> On Fri, Aug 07, 2015 at 10:41:57AM +0200, Sebastian Andrzej Siewior wrote:
> >>>> This DMA driver is used by 8250-omap on DRA7-evm. There is one
> >>>> requirement that is to pause a transfer. This is currently used on the RX
> >>>> side. It is possible that the UART HW aborted the RX (UART's RX-timeout)
> >>>> but the DMA controller starts the transfer shortly after.
> >>>> Before we can manually purge the FIFO we need to pause the transfer,
> >>>> check how many bytes it already received and terminate the transfer
> >>>> without it making any progress.
> >>>>
> >>>> >From testing on the TX side it seems that it is possible that we invoke
> >>>> pause once the transfer has completed which is indicated by the missing
> >>>> CCR_ENABLE bit but before the interrupt has been noticed. In that case the
> >>>> interrupt will come even after disabling it.
> >>>
> >>> How do you cope with the OMAP DMA hardware clearing its FIFO when you
> >>> pause it?
> >>
> >> I don't
> > 
> > ... and so you introduce a silent data loss bug into the driver.  That's
> > not very clever.
> > 
> >> Right now the 820-omap (8250-dma in general, too but they don't use
> >> this driver) pause only the RX transfer in an error condition. This
> >> means it is only device-to-mem transfer. I only mentioned the TX
> >> transfer here since this was easier to test.
> > 
> > That may be how 8250 works, but 8250 is not everything.  You can't ignore
> > this problem.  You have to deal with it - either by not allowing a channel
> > that would loose data to be paused, or by recovering from that condition.
> > You're not doing either in your patch.
> > 
> > Therefore, I have no other option but to NAK your change.  Sorry.
> > 
> > Please fix this.
> 
> Would it be okay if I only allow pause for RX-transfers?

Yes, that satisfies one of my suggestions above.

> For TX-transfers, I would need to update the start-address so the
> transfers begins where it stopped. However based on your concern I
> can't really assume that the position reported by the HW is the correct
> one.

Exactly - I don't believe that existing OMAP DMA hardware can ever support
pausing a mem-to-device transfer without data loss as you have no idea
how many bytes have been prefetched by the DMA, and therefore you have
no idea how many bytes to unwind the hardware position.  It gets worse
than that when you have to cross into the previous descriptor.  It's
really not nice.

So, disallowing pause for mem-to-device is entirely reasonable given the
data loss implications.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
