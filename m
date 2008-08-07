From: Catalin Marinas <catalin.marinas@arm.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 07 Aug 2008 17:45:10 +0100
Message-ID: <1218127510.7718.41.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <20080805114920.GC27299@trinity.fluff.org>
	 <13B9B4C6EF24D648824FF11BE89671620361EE1A9C@dlee02.ent.ti.com>
	 <1218018018.25235.23.camel@pc1117.cambridge.arm.com>
	 <alpine.DEB.1.00.0808062355060.18201@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59894 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752750AbYHGQqR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 12:46:17 -0400
In-Reply-To: <alpine.DEB.1.00.0808062355060.18201@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, tony@atomide.com, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, 2008-08-07 at 07:01 +0100, Paul Walmsley wrote:
> On Wed, 6 Aug 2008, Catalin Marinas wrote:
> 
> > On Tue, 2008-08-05 at 07:15 -0500, Woodruff, Richard wrote:
> > > > Is the controller allowed to write dirty cache lines out at any time
> > > > it
> > > > likes? Surely a better fix is to drain the cache of the changes before
> > > > changing the clock for the SDRAM?
> > >
> > > - Previously the SRAM was marked as cached.  _Execution_ using that
> > > attribute will generate line fetches to SRAM.  This will cause
> > > displacement write-outs of resident DDR lines.  Similarly,
> > > _load/store_ sequences in that code have the same effect.  This cast
> > > outs dead lock the CPU and it can't fetch to progress.
> > [...]
> > > * Flushing the entire L1 & L2 cache frequently is very expensive and
> > > better not done if you don't have.  Also, it is not sufficient for the
> > > context-restore path which needs to NOT live in DDR.
> > >
> > > The code need to execute in a non-cached region.
> >
> > I don't think there is any guarantee that dirty cache line won't be
> > evicted to SDRAM even if your code uses uncached memory only. The CPU is
> > allowed to do speculative reads from the normal cached memory and these
> > reads may force a dirty cache line to be written back to memory. You may
> > need to do at least a cache clean operation (invalidate not necessary).
> 
> If we turn off speculative reads via a CP15 control register Z-bit write
> for the duration of the SRAM code execution, and use either normal
> non-cached memory or strongly-ordered memory for the SRAM code, will that
> effectively prevent any cache line writeback during that time?  (assuming
> interrupts are disabled, that is).

The Z bit disables the branch prediction but I think prefetches into the
pipeline are still allowed. After the last instruction enabling the
SDRAM controller, you might have to put a number of nops (depending on
the pipeline size) to ensure that you don't get a prefetch beyond your
code, though with branch prediction disabled it shouldn't prefetch from
SDRAM. You probably need additional barriers like ISB and DSB as well.

Many of the architecture people in ARM seem to be on holiday, I'll try
to get clarification in about a week time.

> Also, a somewhat-related question about strongly-ordered memory regions:
> these are described as bracketing accesses to those regions with data
> memory barriers.  In this case, are those barriers specific to the
> strongly-ordered pages, or will they affect all memory transactions, even
> to normal cached memory?

For an observer outside the CPU (and not part of the cache coherency
domain), accesses to strongly-ordered memory are strictly ordered
relative to any uncached memory type. The ordering happens at the
write-buffer level but for normal cached memory a store may end up in
the cache and hence not visible from outside. In this case, you need to
flush the cache followed by a DSB to ensure the termination of the cache
operation.

-- 
Catalin

