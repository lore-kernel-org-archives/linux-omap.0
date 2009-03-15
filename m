From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 20:36:31 -0700
Message-ID: <200903142036.31155.david-b@pacbell.net>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <200903141414.06045.david-b@pacbell.net> <20090314223435.GA6523@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from n21.bullet.mail.mud.yahoo.com ([68.142.206.160]:42830 "HELO
	n21.bullet.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754290AbZCODgf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 23:36:35 -0400
In-Reply-To: <20090314223435.GA6523@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: linux-omap <linux-omap@vger.kernel.org>

[ this being afield from over-specific issues, I dropped the
extra copies to Steve and Tony ... ]


On Saturday 14 March 2009, Mark Brown wrote:
> On Sat, Mar 14, 2009 at 02:14:05PM -0700, David Brownell wrote:
> 
> > But thinking about how to handle the video support makes
> > it clear that's not always the best solution.  One needs
> > bootloaders to be able to throw a splash screen which
> > stays active until the window system kicks in ... but
> > turning off video regulators would clearly blacken the
> > screen, which is the wrong model.  (And marking them as
> > "always on" or "boot_on" is wrong for other reasons.)
> 
> Yes, this sounds like one of those cases where just leaving the
> regulator alone and letting the drivers figure things out will probably
> work best.

But the regulator framework needs to change before the drivers
can do that.  Right now, that framework creates self-inconsistent
state (at init time) for that type of regulator.  And it's not
realistic to expect *every* driver to "figure things out".


> > The way clocks handle that is with a late disable,
> > so drivers have a chance to start up.  You rejected
> 
> This behaviour is specific to the OMAP implementation of the clock API
> (and is an optional feature of that from the looks of it).

No; the AT91 clock framework does it too.  Non-conditionally.

Ditto the DaVinci clock framework (the new saner code that looks
to merge in 2.6.30, not the initial incomplete dm644x-only stuff
currently in mainline).  There, it's conditional.

And MSM, and surely others (just looking at ARM code for now).
Some of the S3C platforms do "early" disable, not late.  Most
of the non-TI versions seem to be non-conditional.

Basically any platform that's serious about power management
will be disabling unused clocks as one of the strategies used
to conserve power.

I think the OMAP code does it conditionally since getting it
all right is so much work ... it's an order of magnitude more
complex than most of other platforms, if not more, and getting
all the hardware automagic to behave involves cooperation from
drivers that may not yet be ready to cooperate.


> It's 
> probably also worth rembembering that the clock API is working in a very
> much more controlled domain (in that it mostly only covers well known
> devices on a given architecture), requires little if any per-machine
> setup and isn't an optional feature.  Most of the clock API setup is a
> feature of the SoC CPU rather than of the board.

I see your point, but I don't think there's really all that
much of a difference.  In the end, drivers need to be given
a sane initial configuration ... and the framework needs to
behave consistently.

(But the regulator framework is now self-inconsistent.)


> > the REGULATOR_DISABLE_UNUSED patch I sent, applying
> > that model ... and that's why I started to think about
> > other approaches, as in the "early disable" patch I
> > sent earlier in this thread.
> 
> I didn't reject the concept - I asked for some changes in the interface
> to make it be something that the machine drivers can control rather than
> have it be a Kconfig option that's selected by end users and can't be
> part of the power description that the machine has to have anyway.

Poking Kconfig was more of a quick hack following one
existing model, to show how simple a fix might be, than
claiming that the right fix looked that way.

The problem with needing to put *anything* into a machine
description is that it leaves unfixed that basic hole in
the regulator framework:  self-inconsistent initialization.

If it's guaranteed that regulator_register() returns a
device that's either (a) disabled, with enable count == 0,
else (b) enabled, with enable count == 1 ... the rest can
be dealt with as a configuration issue.


> As I 
> said at the time if it were something that could be enabled by the
> machine driver, either per regulator or per system, then I'd be happy
> with this approach.  I think that it is a better approach than the one
> you're currently going for.

I'll disagree.  Any approach that promotes self-inconsistent
initialization of the regulator framework is a big problem.
Not "better" in any way.  And *requiring* folk to set a flag
just to get the behavior they legitimately expect in the first
place ... not even vaguely better.

- Dave



