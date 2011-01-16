From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: State of LDP3430 platform
Date: Sun, 16 Jan 2011 00:30:07 +0000
Message-ID: <20110116003007.GB18159@n2100.arm.linux.org.uk>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk> <20101206181913.GH8345@atomide.com> <alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com> <20101207083720.GB18336@n2100.arm.linux.org.uk> <alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com> <alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com> <20110115000301.GT4957@atomide.com> <alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com> <20110115233744.GA18159@n2100.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE896716203EAE6F3B1@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41852 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034Ab1APAaX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Jan 2011 19:30:23 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203EAE6F3B1@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>

On Sat, Jan 15, 2011 at 06:05:24PM -0600, Woodruff, Richard wrote:
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Sent: Saturday, January 15, 2011 5:38 PM
> > Why does OMAP initialize its clock sources soo late, outside of
> > the timer initialization?  This means you have no counter in place
> > (except for the jiffies counter) during early boot.
> >
> > Is there a reason why OMAP uniquely does this?
> 
> Not any good reason.  I'm aware of historic porting issue and the missed/
> hidden need for early init for some time services.
> 
> 1st attempts to do really early init (like 7 years back) were messed as
> not all kernel services used to be available when the time early time
> init functions happened.

The background here is:

We now have common generic sched_clock() support which provides true
full 64-bit nanosecond time measurements, as required by the scheduler
code.

We need sched_clock() initialized before the first use which matters -
which is inside sched_init().

As sched_init() is called by generic code, we don't have much choice over
where it happens during the kernel boot - any change will need a very
good justification because it's risking breaking other architectures.

The only preceding hook we have into generic code is setup_arch(), and
I now provide a .init_early platform callback to setup sched_clock().
The point at which init_sched_clock*() is called defines the sched_clock()
time zero.

However, this is too early to setup the sched_clock() keep-alive soft
timer - this is delayed until the time_init() callback.  This happens
after sched_init(), so we expect that init_sched_clock() will have been
called by this point - and given that it's already been used, this is
not an unreasonable assumption.  This is fine as we expect that the
counter backing the sched_clock() implementation will not wrap between
these two calls - and to make sure we kick off an update at this point.

So, as a platform, there are two places where init_sched_clock() is
callable - either .init_early (preferred) or the sys_timer .init method
(if it must be late).

If sched_clock() support is enabled, then init_sched_clock() must have
been called no later than the return of sys_timer .init method otherwise
you will get an oops (which is what is happening) when the first update
cycle is kicked off.
