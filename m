From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 16:53:27 -0800
Message-ID: <20120205005326.GP20333@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
 <20120204230507.GM20333@atomide.com>
 <20120205000930.GE17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34059 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab2BEAxa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 19:53:30 -0500
Content-Disposition: inline
In-Reply-To: <20120205000930.GE17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 15:38]:
> On Sat, Feb 04, 2012 at 03:05:07PM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> > > I'm seriously considering requesting that all OMAP changes for the merge
> > > window come through me rather than arm-soc, so that I can boot and build
> > > test them before the merge window opens, and we can cut down on this
> > > repetitive cycle of build (and boot) breakage at every merge window.
> > 
> > I agree it would be nice to see these issues earlier. I build and boot
> > test every patch I merge, but mostly with omap2plus_defconfig as that
> > does the job for all the boards I have with a single zImage.
> > 
> > Looks like the issues you're seeing are related to .config settings.
> > 
> > How about let's plan on testing your .configs with for-next before the
> > next merge window?
> 
> I was thinking about something more than just a build-test, because
> that's just a part of the problem.
> 
> Let me make it clear what my motivation here is (before someone starts
> making any accusations).
> 
> There is a view widely held that the mainline OMAP kernels are in a
> pretty poor shape when it comes to people being buildable (I've been
> told so.)  That reflects my experience each cycle when I try to test
> a mainline OMAP kernel - and I invariably encounter build or boot
> problems of various degrees.

Hmm well I can only do so much of testing. That's usually build and
boot test on 8 omap machines for pretty much all the patches that I
merge. Naturally I can't do that for all the 50 or so defconfigs that
I'm aware of, so I mostly stick to the generic omap1_defconfig and
omap2plus_defconfig.
 
> What I would _prefer_ to see is that your tree gets build _and_ boot
> tested by people in the OMAP community with a range of configurations,
> and any build or boot problems get reported back in a timely manner
> so that those problems can be solved before the tree goes to arm-soc.

Sure that would be nice. Still the place to do that testing is
for-next as I can't keep track of all driver changes.

> Obviously, some of that does happen, but it's clearly not enough as
> we keep going around this loop at every merge window where there's
> breakage each time, there isn't enough of it.  So, we need a different
> solution to this.
>
> So, I was thinking about pulling your tree, building and booting
> it _and_ requiring it to pass before it goes to mainline.  Yes, that's
> pretty drastic, but I think it's about the only way to ensure that
> the amount of regressions are reduced down to an acceptable level.

I'd rather see this happen on constant basis, otherwise we still have
the problem of these issues popping up too late. But feel free to do
your checks as often as you can :)
 
> Let's be clear - I'm not talking about the pulls that you'd send to
> Arnd and Olof for fixes during or after the merge window.  I'm talking
> about the merge window stuff only - because that seems to be where most
> of the breakage happens.
> 
> I've been wondering whether I could set something up which did this all
> automatically - maybe running a build overnight and then automatically
> boot testing it and logging the results - including running some
> userspace testing.  One of the issues I'd face is that my current build
> machine is the laptop, which isn't aways available to run the builds
> each day.
> 
> But... things are complicated by the OMAP boards having USB to serial
> devices on them rather than standard RS232, which rather limits what I
> can do to automate testing with them, especially as others require a
> USB socket as a source of power to run themselves.

Well maybe mail me your defconfigs, and I'll do build tests on those too
when merging stuff. Sounds like I don't have all the boards you have,
but probably have some of them to boot too.

Regards,

Tony

Regards,

Tony
