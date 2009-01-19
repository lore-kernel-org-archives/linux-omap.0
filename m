From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ioremap()/iounmap() problem
Date: Mon, 19 Jan 2009 13:56:54 +0000
Message-ID: <20090119135654.GB18301@n2100.arm.linux.org.uk>
References: <1232360583.6481.92.camel@tubuntu> <13B9B4C6EF24D648824FF11BE8967162036D6A19F2@dlee02.ent.ti.com> <20090119134329.GA18301@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57595 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbZASN5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Jan 2009 08:57:12 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D6A1A0F@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Jan 19, 2009 at 07:48:09AM -0600, Woodruff, Richard wrote:
> 
> > On Mon, Jan 19, 2009 at 07:34:47AM -0600, Woodruff, Richard wrote:
> > > > Running with latest linux-omap kernel on OMAP3 SDP board, I have problem
> > > > with iounmap(). It looks like iounmap() does not properly free large
> > > > areas. Below is a test which fails for me in 6-7 loops.
> > > >
> > > > OMAP spesific ioremap code doesn't do much, so I think it's somewhere in
> > > > generic ARM code. I looked at the ioremap code and for larger areas the
> > > > code uses area sections, and I believe the bug is somewhere there.
> > > >
> > > > Does this work on other processors?
> > >
> > > If you wait around a bit using some kind of schedule() + jiffy wait after
> > > free will it work longer?
> > >
> > > Every now and then I've seen some deferred resource releases cause
> > > failures of such loops.  Usually they are more obvious like if your
> > > really malloc/free'ing direct memory, but there are indirect allocations
> > > which might add up.
> > >
> > > Anyway, it's a behavioral question to help isolate.
> >
> > There is no deferred resource releasing here, so such a test is a waste
> > of time.
> 
> None?  Aren't at least TLB table structures allocated to cover memory
> but some other tables?
> 
> Or are those all synchronous allocate and release?  I was under some
> impression that kmalloc's to get some of these came from slabs which
> don't reap right away.

There are no L2 PTE tables for section and supersection mappings, so this
is irrelevent.  Section and supersection mappings live in the L1 page
table which persists for the lifetime of the task.

As such, ioremap/iounmap are only allocating and freeing a small structure
to account for the allocation - if things are so tight that 6-7 loops
causes that allocation to fail, you're not going to be able to run any
userspace programs.

This is clearly a bug report which is too vague - which talks about a
"failure" but doesn't say what the failure is.  Until we have more
information from the reporter, uninformed speculation is rather wasteful.

Let's wait until the reporter tells us what the nature of this failure
is, as I've already requested an hour ago.
