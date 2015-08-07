From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 17:39:21 +0100
Message-ID: <20150807163921.GU7576@n2100.arm.linux.org.uk>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de>
 <55C47DE1.9020902@ti.com>
 <55C48A1E.3070007@linutronix.de>
 <20150807132241.GN7576@n2100.arm.linux.org.uk>
 <55C4B5AE.10309@linutronix.de>
 <20150807135727.GP7576@n2100.arm.linux.org.uk>
 <55C4CA00.3060206@hurleysoftware.com>
 <20150807152939.GQ7576@n2100.arm.linux.org.uk>
 <55C4D243.4080305@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C4D243.4080305@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 05:44:03PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/07/2015 05:29 PM, Russell King - ARM Linux wrote:
> > On Fri, Aug 07, 2015 at 11:08:48AM -0400, Peter Hurley wrote:
> >> [ + Greg KH ]
> >>
> >> On 08/07/2015 09:57 AM, Russell King - ARM Linux wrote:
> >>> As it is something that the driver has _not_ supported, you are clearly
> >>> adding a feature to an existing driver.  It's not a bug fix.
> >>>
> >>>>> If something else has been converted to pause channels and that is causing
> >>>>> a problem, then _that_ conversion is where the bug lies, not the lack of
> >>>>> support in the omap-dma.
> >>
> >> FWIW, the actual bug is the api that silently does nothing.
> > 
> > Incorrect.
> > 
> > static int omap_dma_pause(struct dma_chan *chan)
> > {
> >         struct omap_chan *c = to_omap_dma_chan(chan);
> > 
> >         /* Pause/Resume only allowed with cyclic mode */
> >         if (!c->cyclic)
> >                 return -EINVAL;
> > 
> > Asking for the channel to be paused will return an error code indicating
> > that the request failed.  That will be propagated back through to the
> > return code of dmaengine_pause().
> > 
> > If we look at what 8250-dma.c is doing:
> > 
> >                 if (dma->rx_running) {
> >                         dmaengine_pause(dma->rxchan);
> > 
> > It's 8250-dma.c which is silently _ignoring_ the return code, failing
> > to check that the operation it requested worked.  Maybe this should be
> > WARN_ON(dmaengine_pause(dma->rxchan)) or at least it should print a
> > message?
> 
> I think this is what Peter meant by saying "silently does nothing".

Maybe Peter should phrase his replies better.  "the actual bug is the
api that silently does nothing." to me means he is complaining that
dmaengine_pause() had no effect.  _That_ is what I'm objecting to,
and claiming that Peter's comment is wrong.

He's now blaming me for snide remarks.  I could call his one above an
incorrect snide remark against the quality of DMA engine code.  He's
totally wrong, and been proven wrong by my analysis above, plain and
simple.

He should now accept that he's wrong and move along with sorting out
this mess _without_ requiring optional features to be implemented in
other subsystems to fix bugs in code he's supposed to be maintaining.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
