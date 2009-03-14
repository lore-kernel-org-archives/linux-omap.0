From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 22:34:36 +0000
Message-ID: <20090314223435.GA6523@sirena.org.uk>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <200903141208.30413.david-b@pacbell.net> <20090314202250.GA17554@sirena.org.uk> <200903141414.06045.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:3982 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZCNWes (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Mar 2009 18:34:48 -0400
Content-Disposition: inline
In-Reply-To: <200903141414.06045.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Sat, Mar 14, 2009 at 02:14:05PM -0700, David Brownell wrote:

> But thinking about how to handle the video support makes
> it clear that's not always the best solution.  One needs
> bootloaders to be able to throw a splash screen which
> stays active until the window system kicks in ... but
> turning off video regulators would clearly blacken the
> screen, which is the wrong model.  (And marking them as
> "always on" or "boot_on" is wrong for other reasons.)

Yes, this sounds like one of those cases where just leaving the
regulator alone and letting the drivers figure things out will probably
work best.

> The way clocks handle that is with a late disable,
> so drivers have a chance to start up.  You rejected

This behaviour is specific to the OMAP implementation of the clock API
(and is an optional feature of that from the looks of it).  It's
probably also worth rembembering that the clock API is working in a very
much more controlled domain (in that it mostly only covers well known
devices on a given architecture), requires little if any per-machine
setup and isn't an optional feature.  Most of the clock API setup is a
feature of the SoC CPU rather than of the board.

> the REGULATOR_DISABLE_UNUSED patch I sent, applying
> that model ... and that's why I started to think about
> other approaches, as in the "early disable" patch I
> sent earlier in this thread.

I didn't reject the concept - I asked for some changes in the interface
to make it be something that the machine drivers can control rather than
have it be a Kconfig option that's selected by end users and can't be
part of the power description that the machine has to have anyway.  As I
said at the time if it were something that could be enabled by the
machine driver, either per regulator or per system, then I'd be happy
with this approach.  I think that it is a better approach than the one
you're currently going for.

Unlike the clock API the machines are going to have to provide some
configuration for the regulators for this feature to be useful (to
specify the supplies that are actually in use) so there is little
additional cost to them in requesting this feature.  If it were only a
Kconfig option then people building the kernel have to know somehow how
well set up the regulators are for their system and some people will end
up with suboptimal configurations because they don't
know if they can turn the option on or not.

> A third approach (after applying that one patch that's
> in the regulator-next tree) would be

> 	if (rdev->is_enabled() > 0)
> 		rdev->use_count = 1;

That won't work with consumers that can share their supply - they can't
tell if the regulator was enabled because it was left on at startup or
if it was enabled by some other consumer.
