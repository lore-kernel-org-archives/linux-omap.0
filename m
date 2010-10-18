From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] Add OMAP hardware spinlock misc driver
Date: Mon, 18 Oct 2010 17:58:39 +0200
Message-ID: <1287417519.1998.1943.camel@laptop>
References: <1287387875-14168-1-git-send-email-ohad@wizery.com>
	 <1287406015.29097.1579.camel@twins>
	 <20101018133502.GA12449@n2100.arm.linux.org.uk>
	 <1287409417.29097.1598.camel@twins>
	 <tnxeibnh67q.fsf@e102109-lin.cambridge.arm.com>
	 <1287415929.29097.1616.camel@twins>
	 <tnxaambh52q.fsf@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:39572 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab0JRP6y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Oct 2010 11:58:54 -0400
In-Reply-To: <tnxaambh52q.fsf@e102109-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Ohad Ben-Cohen <ohad@wizery.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Suman Anna <s-anna@ti.com>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 2010-10-18 at 16:51 +0100, Catalin Marinas wrote:
> Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, 2010-10-18 at 16:27 +0100, Catalin Marinas wrote:
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >> > On Mon, 2010-10-18 at 14:35 +0100, Russell King - ARM Linux wrote:
> >> >> In any case, Linux's spinlock API (or more accurately, the ARM exclusive
> >> >> access instructions) relies upon hardware coherency support (a piece of
> >> >> hardware called an exclusive monitor) which isn't present on the M3 nor
> >> >> DSP processors.  So there's no way to ensure that updates from the M3
> >> >> and DSP are atomic wrt the A9 updates.
> >> >
> >> > Right, so the problem is that there simply is no way to do atomic memory
> >> > access from these auxiliary processing units wrt the main CPU? Seeing as
> >> > they operate on the same memory space, wouldn't it make sense to have
> >> > them cache-coherent and thus provide atomicy guarantees through that?
> >> 
> >> With cache coherency you may get atomicity of writes or reads but
> >> usually not atomic modifications.

Right, so you forgot the qualifying part of your stmt: on ARM.

> > Sure, but you can 'easily' extend your coherency protocols with support
> > for things like ll/sc (or larger transactions).
> >
> > Have ll bring the cacheline into exclusive state and tag it, then
> > anything that demotes the cacheline will clear the tag and make sc fail.
> 
> For the ll/sc operations on ARM (exclusive load/store) there is a
> per-CPU local exclusive monitor and a (virtual) global one. The global
> one may either be a separate piece of hardware or emulated via cache
> lines as you said. 

> But if you need synchronisation with a CPU (or DSP)
> like Cortex-M3 which doesn't have any built-in caches, you can only get
> atomic operations on the main processor (A9) but not on the M3 (as you
> can't have a cache line in exclusive state on the M3).

Right, and I take it that modifying the M3 to participate in the full
coherency/exclusive monitor thing would have been more work.

> The M3 may have a local exclusive monitor (like the main CPU) but it
> isn't cleared by memory accesses from the main CPU.

Sounds like asking for trouble if you ask me ;-)



