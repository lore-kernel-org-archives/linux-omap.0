From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] arm: omap4: Fix omap_barriers_init for generic ioremap
	changes
Date: Thu, 12 Jan 2012 20:11:12 +0000
Message-ID: <20120112201112.GB16726@n2100.arm.linux.org.uk>
References: <20120112184256.GA2287@atomide.com> <20120112200443.GA16726@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45934 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2ALULT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Jan 2012 15:11:19 -0500
Content-Disposition: inline
In-Reply-To: <20120112200443.GA16726@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, Jan 12, 2012 at 08:04:43PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 12, 2012 at 10:42:57AM -0800, Tony Lindgren wrote:
> > Commit 73829af71fdb8655e7ba4b5a2a6612ad34a75a11
> > (Merge branch 'vmalloc' of git://git.linaro.org/people/nico/linux
> > into devel-stable) merged generic ioremap changes.
> > 
> > Commit 137d105d50f6e6c373c1aa759f59045e6239cf66
> > (ARM: OMAP4: Fix errata i688 with MPU interconnect barriers)
> > added a workaround for omap4.
> > 
> > In order for the errata to work, we now need the following
> > patch or else we'll get:
> > 
> > kernel BUG at mm/vmalloc.c:1134!
> 
> Oh my, I've just read this, and I'm extremely annoyed that this even hit
> mainline in the first place.  It's utter crap.
> 
> It's trying to use memblock to allocate memory _AFTER_ that memory has
> been passed on from memblock's control to other allocators.  Calling
> memblock_alloc() at *any* initcall is Bad News (it _may_ appear to work
> but there's no way for memblock_alloc to tell anything else that the
> memory is being re-used.)
> 
> Calling it and then trying to reserve it at ->map_io time is also Bad
> News - the memory at that point has already been mapped, and if you're
> expecting to be able to remap it with different attributes, you're going
> to double-map it with differing attributes.  You lose.
> 
> Not only that, but it's an abuse of the various callback functions into
> machine code.  Don't do it.
> 
> By all means, allocate the memory via memblock, but do it in the ->reserve
> callback.  It's *exactly* what that callback is there for.  The map it in
> the ->map_io callback.
> 
> Don't try to be clever and abuse these callbacks.  They aren't named just
> for fun and my delectation.  They have *specific* purposes.  Stick to
> those purposes in them and don't try to be clever, or you'll be moaned at.
> 
> So, NAK.  NAK for the original patch too.  Do it properly.

It seems I missed this detail when I quickly read through the original
patch last September, which is rather unfortunate.

That doesn't stop this being completely the wrong approach though - and
being very very broken as it currently stands.
