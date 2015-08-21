From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] dma: add __must_check annotation for
 dmaengine_pause()
Date: Fri, 21 Aug 2015 14:02:45 +0530
Message-ID: <20150821083245.GM13546@localhost>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-3-git-send-email-bigeasy@linutronix.de>
 <20150811095852.GW11789@localhost>
 <20150811100617.GD7576@n2100.arm.linux.org.uk>
 <55C9EBD5.3090203@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C9EBD5.3090203@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, peter@hurleysoftware.com, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Aug 11, 2015 at 02:34:29PM +0200, Sebastian Andrzej Siewior wrote:
> On 08/11/2015 12:06 PM, Russell King - ARM Linux wrote:
> > I think what people need to learn is that an API in the kernel which
> > returns an int _can_ fail - it returns an int so it _can_ return an
> > error code.  If it _can_ return an error code, there _will_ be
> > implementations which _do_.
> > 
> > If you don't check the return code, either your code doesn't care whether
> > the function was successful or not, or you're playing with fire.  This is
> > a prime example of playing with fire.
> > 
> > Let's leave the crappy userspace laziness with regard to error checking
> > to userspace, and keep it out of the kernel.
> > 
> > Yes, the DMA engine capabilities may not be sufficient to describe every
> > detail of DMA engines, but that's absolutely no reason to skimp on error
> > checking.  Had there been some kind of error checking at the site, this
> > problem would have been spotted before the 8250-omap driver was merged.
> 
> Let me disable RX-DMA in 8250-omap code and push that stable. Then we
> won't need a special annotation for pause support because it remains
> off and is currently about one user. I browsed each driver in
> drivers/dma each one which does support pause supports it and all of
> them implement it unconditionally (ipu_idmac grabs a mutex first but
> this is another story).
> Adding error checking to 8250-omap like I have it in #1 and disabling
> RX-DMA in case pause fails looks be reasonable since there is nothing
> else that can be done I guess.
> Once we have the missing piece in omap-dma the RX-DMA can be enabled in
> 8250-omap.
> Does this sound like a plan we can agree on?

Yes sounds good to me..

-- 
~Vinod
