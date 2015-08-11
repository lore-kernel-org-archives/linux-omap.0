From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] dma: add __must_check annotation for
 dmaengine_pause()
Date: Tue, 11 Aug 2015 11:06:17 +0100
Message-ID: <20150811100617.GD7576@n2100.arm.linux.org.uk>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-3-git-send-email-bigeasy@linutronix.de>
 <20150811095852.GW11789@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150811095852.GW11789@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, peter@hurleysoftware.com, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 11, 2015 at 03:28:52PM +0530, Vinod Koul wrote:
> On Fri, Aug 07, 2015 at 10:00:18PM +0200, Sebastian Andrzej Siewior wrote:
> > In 8250-omap I learned it the hard way that ignoring the return code
> > of dmaengine_pause() might be bad because the underlying DMA driver
> > might not support the function at all and so not doing what one is
> > expecting.
> > This patch adds the __must_check annotation as suggested by Russell King.
> > 
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/dmaengine.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 8ad9a4e839f6..4eac4716bded 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -825,7 +825,7 @@ static inline int dmaengine_terminate_all(struct dma_chan *chan)
> >  	return -ENOSYS;
> >  }
> >  
> > -static inline int dmaengine_pause(struct dma_chan *chan)
> > +static inline int __must_check dmaengine_pause(struct dma_chan *chan)
> >  {
> >  	if (chan->device->device_pause)
> >  		return chan->device->device_pause(chan);
> 
> Give that there are bunch of users of this call which may or maynot be using
> this, I think putting this check is too stringent

I think what people need to learn is that an API in the kernel which
returns an int _can_ fail - it returns an int so it _can_ return an
error code.  If it _can_ return an error code, there _will_ be
implementations which _do_.

If you don't check the return code, either your code doesn't care whether
the function was successful or not, or you're playing with fire.  This is
a prime example of playing with fire.

Let's leave the crappy userspace laziness with regard to error checking
to userspace, and keep it out of the kernel.

Yes, the DMA engine capabilities may not be sufficient to describe every
detail of DMA engines, but that's absolutely no reason to skimp on error
checking.  Had there been some kind of error checking at the site, this
problem would have been spotted before the 8250-omap driver was merged.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
