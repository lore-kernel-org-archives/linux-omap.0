From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Spurious interrupt warning
Date: Wed, 7 Jan 2009 17:13:13 +0000
Message-ID: <20090107171313.GA17855@flint.arm.linux.org.uk>
References: <20090106110837.GG9752@atomide.com> <19F8576C6E063C45BE387C64729E739403ECEDD480@dbde02.ent.ti.com> <20090106111928.GA10260@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036D480BD0@dlee02.ent.ti.com> <20090107082618.GC27566@atomide.com> <13B9B4C6EF24D648824FF11BE8967162036D4815E2@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39156 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbZAGRNd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 12:13:33 -0500
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036D4815E2@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Hiremath, Vaibhav" <hvaibhav@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Jan 07, 2009 at 10:13:30AM -0600, Woodruff, Richard wrote:
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Wednesday, January 07, 2009 2:26 AM
> > > It just happens to be the IRQ path has a very slow dissertation path when
> > you take into account timing domains that it shows up.
> > >
> > > Shrinking the race window with SO then using a read back to get the last one
> > or two is most conservative and safe.  Probably 97% for IO accesses are ok on
> > OMAP as device, but that is probably 99.9% with SO.  In our testing we may be
> > able to make that 97 a 99.  Still I'd rather not risk the 1% for production.
> >
> > Sure you can patch the SO back if you want to. However, it's a more
> > generic problem, and Russell has stated that he does not want to
> > merge it.
> 
> Yes Russell doesn't like it.  However, I didn't see any viable alternate
> solution offered.  If ARM or any hardware vendor does something badly in
> hardware punishing the current generation in hopes of changing the next
> is not so good. Especially if some work around exists.

I do hope you realise that precisely the same argument can be made for
the posting of writes to the timers.

And this is what's soo hard to grasp about your position - at one moment
you're talking about needing maximal performance (which involves the use
of device mappings.)  The next moment you're talking about wanting 100%
predictability by using strongly ordered mappings.

The fact of the matter is that from point of view of the ARM CPU, a
readback of the same address which was written to with a device mapping
can not bypass the write.  So a write to register X followed by an
immediate read of X and an execution dependency on that result _will_
cause the write to appear on the bus before execution can continue.
If anything else happens, the CPU is buggy because its allowing writes
to pass reads which is unpredictable from the system point of view.

If you can't get it to work with a readback and dependency, that suggests
that something else external to the CPU is misbehaving or broken.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
