From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Tue, 10 Mar 2009 23:33:12 +0000
Message-ID: <20090310233310.GB8189@sirena.org.uk>
References: <20090226140450.GB8595@sirena.org.uk> <200903081354.36044.david-b@pacbell.net> <20090308224145.GD18035@sirena.org.uk> <200903091745.28071.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2524 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbZCJXde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2009 19:33:34 -0400
Content-Disposition: inline
In-Reply-To: <200903091745.28071.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 09, 2009 at 04:45:26PM -0800, David Brownell wrote:
> On Sunday 08 March 2009, Mark Brown wrote:

> > >  - Regulators not marked as "boot_on" or "always_on" won't
> > >    be active (and usecount will be 0) on return from setup.

> > This breaks the idea that we don't do anything unless explictly told to
> > do so.

> I'm not sure where you're drawing this "explicitly" line, but
> clearly it's not where I would draw it!  The board init code
> explicitly said "here's a regulator, with these settings for
> the boot_on and always_on flags".  If neither was set, they
> are obviously clear ... so the regulator shouldn't be enabled.

At the minute a zero initialised set of constraints means "don't touch
anything" - it doesn't grant any permissions to do anything, all that
can actually be done is inspect the state.  Some of the drivers use this
currently, having a block of regulator constraint data in a larger block
of platform data and registering all regulators on the chip
unconditionally.  Requiring boot_on or always_on to be set would mean
that these drivers would start powering everything off once the change
is merged unless the drivers are changed first.

If we are going to make this change it might be best to first spend a
release printing a big fat warning so it's harder for people to get
surprised by it, especially with stuff getting merged via platform
trees.

> > I did actually still consider adding code to power off the 
> > regulator but thought that there may also be situations where the state
> > really is unknown (eg, it depends on what the system booted from) and
> > it'd be useful to be able to punt to the consumers to figure it out.

The other use case I should've mentioned is for people who are reverse
engineering systems and initially want to fire things up and inspect the
state they get left with before they go figuring out what (if anything)
they want to do with it.  Even if you do know the design this can be
quite handy for testing that everything came up as expected, the kernel
provides a fairly convenient UI.

> The core problem with that thought is that if you try doing that,
> then consumers have exactly zero ways to fix the issue.  It's the
> scenario I listed above:  regulator is enabled, but refcount is
> zero.  So they're not allowed to disable.

It can do it by enabling (which is a noop) and then disabling - it's not
nice and wasn't really intentional but it gets the job done.

> That's in addition to the fact that "unknown" states are
> extremely error prone.  The state after initialization should
> fully known, without having to play such guessing games.

Yes, doing it via constriants is clearly better - I'm more thinking
about this in terms of "if you really want to do it this is how" than as
something I'd recommend people use.

> defined values.  Adding a second "always_on" flag makes for
> some confusion, since it only defines a third state, not a
> pair of states (it's not orthogonal).

We should just be able to remove always_on; it's equivalent to setting
boot_on and not enabling REGULATOR_CHANGE_STATUS.  I'll look into that
but it's got cross tree issues too.

> always have the consumer ops delegate to the real regulator.
> And have that real regulator's usecount set to one when it's
> enabled at boot time, so regulator_disable() will work then.

Clearly.  I'm wondering how that plays with multiple consumers, though.
Consumers will be able to disable regulators that were left on but
they'll need something to let them figure out why the device was left
on.  Or just not worry about supporting such users too strongly suggest
that they should be using something that gets added to the constraints.

Fancy kicking off a couple of new discussions on lkml?
