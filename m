From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP34xx
Date: Sun, 5 Feb 2012 00:09:30 +0000
Message-ID: <20120205000930.GE17309@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk> <20120204190109.GL20333@atomide.com> <20120204203453.GD17309@n2100.arm.linux.org.uk> <20120204230507.GM20333@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47666 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542Ab2BEAJj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 19:09:39 -0500
Content-Disposition: inline
In-Reply-To: <20120204230507.GM20333@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

On Sat, Feb 04, 2012 at 03:05:07PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> > I'm seriously considering requesting that all OMAP changes for the merge
> > window come through me rather than arm-soc, so that I can boot and build
> > test them before the merge window opens, and we can cut down on this
> > repetitive cycle of build (and boot) breakage at every merge window.
> 
> I agree it would be nice to see these issues earlier. I build and boot
> test every patch I merge, but mostly with omap2plus_defconfig as that
> does the job for all the boards I have with a single zImage.
> 
> Looks like the issues you're seeing are related to .config settings.
> 
> How about let's plan on testing your .configs with for-next before the
> next merge window?

I was thinking about something more than just a build-test, because
that's just a part of the problem.

Let me make it clear what my motivation here is (before someone starts
making any accusations).

There is a view widely held that the mainline OMAP kernels are in a
pretty poor shape when it comes to people being buildable (I've been
told so.)  That reflects my experience each cycle when I try to test
a mainline OMAP kernel - and I invariably encounter build or boot
problems of various degrees.

What I would _prefer_ to see is that your tree gets build _and_ boot
tested by people in the OMAP community with a range of configurations,
and any build or boot problems get reported back in a timely manner
so that those problems can be solved before the tree goes to arm-soc.

Obviously, some of that does happen, but it's clearly not enough as
we keep going around this loop at every merge window where there's
breakage each time, there isn't enough of it.  So, we need a different
solution to this.

So, I was thinking about pulling your tree, building and booting
it _and_ requiring it to pass before it goes to mainline.  Yes, that's
pretty drastic, but I think it's about the only way to ensure that
the amount of regressions are reduced down to an acceptable level.

Let's be clear - I'm not talking about the pulls that you'd send to
Arnd and Olof for fixes during or after the merge window.  I'm talking
about the merge window stuff only - because that seems to be where most
of the breakage happens.

I've been wondering whether I could set something up which did this all
automatically - maybe running a build overnight and then automatically
boot testing it and logging the results - including running some
userspace testing.  One of the issues I'd face is that my current build
machine is the laptop, which isn't aways available to run the builds
each day.

But... things are complicated by the OMAP boards having USB to serial
devices on them rather than standard RS232, which rather limits what I
can do to automate testing with them, especially as others require a
USB socket as a source of power to run themselves.
