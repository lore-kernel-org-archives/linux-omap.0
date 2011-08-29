From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] usb: ehci: fix update qtd->token in qh_append_tds
Date: Mon, 29 Aug 2011 09:52:09 +0100
Message-ID: <20110829085209.GB26917@n2100.arm.linux.org.uk>
References: <20110828233648.GA14560@n2100.arm.linux.org.uk> <Pine.LNX.4.44L0.1108282137270.10614-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43926 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab1H2Iwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Aug 2011 04:52:37 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1108282137270.10614-100000@netrider.rowland.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ming Lei <ming.lei@canonical.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, Santosh <santosh.shilimkar@ti.com>, USB list <linux-usb@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

On Sun, Aug 28, 2011 at 09:51:10PM -0400, Alan Stern wrote:
> Hmmm.  Although the semantics of the various mb() macros were
> originally defined only for inter-CPU synchronization, I believe they
> are also supposed to work for guaranteeing the order of accesses to
> DMA-coherent memory.  If that's not the case with ARM, something is
> seriously wrong.  (Maybe I'm wrong about this, but if I am then there's
> currently _no_ way for the kernel to order DMA-coherent accesses on
> ARM.)

That is the case with ARM - mb() and wmb() does everything that's
required.  rmb() is weaker than the other two.

> You know better than I do what is needed to resolve the ordering issue.  
> However, contrary to what the original patch description said, this
> isn't entirely a matter of making the write visible to the host
> controller: No doubt in time the write will eventually become visible
> anyway.  It's a matter of making the write become visible reasonably
> quickly and in the correct order with respect to other writes.

I'm not entirely sure what the problem is - I think its about a write
by the CPU to dma coherent memory being delayed and not being visible
to the HC in a timely manner.  Either mb() or wmb() placed after the
write on ARM will do that - and ARM has no requirement to do a read-
back after the barrier.

> Is this extra L2-cache "poke" needed for proper ordering, or is it 
> needed merely to flush the write out to memory in a timely manner?

Both, though primerily it's about ensuring correct ordering.  A side
effect of it is that it will flush all pending writes in L2 before
completing.

>From the theoretical viewpoint, I think I'm right to say that mb()
doesn't need to provide that level of ordering as its supposed to be
an inter-CPU barrier - which probably means we need to invent a new
barrier to deal with DMA memory ordering.  However, given the
difficulty of getting the existing barriers placed correctly, I don't
think inventing new barriers is a very good idea.

What we can do is view devices which perform DMA as being strongly
ordered with respect to their memory accesses - iow, they have an
implicit memory barrier before and after their accesses to memory.
This would make the CPUs use of mb() have a conceptual pairing with
the DMA agents.
