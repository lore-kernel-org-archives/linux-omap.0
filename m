From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] 34xx spurious interrupts unravelling
Date: Fri, 31 Oct 2008 13:35:30 -0700
Message-ID: <20081031203529.GB28924@atomide.com>
References: <1225480873-30835-1-git-send-email-tony@atomide.com> <200810311307.15154.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51417 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbYJaUfd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 16:35:33 -0400
Content-Disposition: inline
In-Reply-To: <200810311307.15154.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081031 13:07]:
> On Friday 31 October 2008, Tony Lindgren wrote:
> > So it's now starting to look like we need to ensure write posting in
> > interrupt handlers for 34xx instead of marking the IO areas as strongly
> > ordered.
> 
> I always thought the terminology was to "flush posted writes"
> by the readback ... a "posted write" being one that's sitting
> in a hardware queue, like a letter sitting in a mailbox until
> the postal service picks it up (then, much later, delivers it).

That sounds more professional. Let's standardize the comments
to say "flush posted write" so we can easily grep for them later
on.

> Regardless, these patches just go to show that OMAP hardware
> is starting to act more like bigger hardware ... like stuff
> with PCI busses, where writes are normally posted to bridge
> writebuffers and drivers need to defend against the relevant
> write latencies.  :)
> 
> 
> One thing for folk to remember:  the consequent races happen
> outside of IRQ handling too.
> 
> Every time you write to an I/O register you should ask when
> its effect *must* be known to the hardware ... and ensure some
> read flushes that write before that deadline.  When you get it
> wrong, be prepared to waste time tracking down intermittent
> race induced failures at very low levels.
> 
> When in doubt, flush it out!
> 
> 
> For PIO drivers, IRQ handling is the main place these races
> will appear.  If DMA is in use, there are a boatload of
> additional complications that can crop up ... sometimes you
> need to worry about when writes get to memory (DMA mapping
> ops don't necessarily ensure the CPU write buffer is empty),
> and unless the peripheral has an integrated DMA engine you
> need to flush writes to the DMA engine separately from
> writes to the peripheral.

Yeah, especially when recycling dma buffers.. The call to use
there is dma_cache_maint().

Tony
