From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/6] OMAP4: Pandaboard: Add omap_reserve functionality
Date: Sat, 18 Dec 2010 17:50:10 +0000
Message-ID: <20101218175010.GE3047@n2100.arm.linux.org.uk>
References: <20101218030406.10251.73118.stgit@baageli.muru.com> <20101218030521.10251.89993.stgit@baageli.muru.com> <20101218082703.GB3047@n2100.arm.linux.org.uk> <20101218172055.GT5941@atomide.com> <20101218173624.GD3047@n2100.arm.linux.org.uk> <20101218174136.GV5941@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36138 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757064Ab0LRRuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 12:50:21 -0500
Content-Disposition: inline
In-Reply-To: <20101218174136.GV5941@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Raghuveer Murthy <raghuveer.murthy@ti.com>

On Sat, Dec 18, 2010 at 09:41:36AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [101218 09:36]:
> > On Sat, Dec 18, 2010 at 09:20:56AM -0800, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [101218 00:26]:
> > > > On Fri, Dec 17, 2010 at 07:05:21PM -0800, Tony Lindgren wrote:
> > > > >  	/* Maintainer: David Anders - Texas Instruments Inc */
> > > > >  	.boot_params	= 0x80000100,
> > > > >  	.map_io		= omap4_panda_map_io,
> > > > > +	.reserve	= omap_reserve,
> > > > 
> > > > Please put .reserve before .map_io.
> > > 
> > > Hmm, that's the way it should be.. But we should also correct the
> > > earlier changes too?
> > 
> > Strangely that's what I've been doing in my init_early patches.  My
> > comment was aimed to ensure that no new instances are introduced.
> 
> OK, do you want to merge this one into your patches too?

Well, the main purpose of init_early is to provide a hook to allow
platforms to initialize their sched_clock() implementation before the
scheduler comes up.

init_early is already in my misc branch, and should appear in linux-next
during the next update, if it isn't there already.  The patch for using
this new hook is still work in progress (SMP issues has overtaken it
again today.)

However, the problem I currently have is that the sched_clock() patchset
depends on the ftrace changes from Rabin (in devel-stable) and the
init_early stuff is in the misc branch, and I'm trying to avoid merging
those two branches until the patches for using the new hook have been
finalized and reviewed.

Once that's happened there's another pile of work to sort out the
initialization of sched_clock(), especially as almost every machine
class is completely different in this regard (due to dependencies with
things like clk API.)

I think this is going to be rather hit and miss, so I'm probably going
to do this relatively slowly - let's do the init_early support and
moving stuff there for this merge window, and leave resolving the
sched_clock() initialization issue until the following merge window.
(The rest of the sched_clock() stuff can go in as-is because it's no
worse than what we do today.)
