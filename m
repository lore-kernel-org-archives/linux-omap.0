From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problems while designing TPS65023 regulator driver
Date: Sat, 7 Mar 2009 16:22:36 +0000
Message-ID: <20090307162233.GA12858@sirena.org.uk>
References: <20090226140450.GB8595@sirena.org.uk> <5A47E75E594F054BAF48C5E4FC4B92AB02FADBF6CF@dbde02.ent.ti.com> <20090306133428.GA4327@sirena.org.uk> <200903061607.16825.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:2970 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbZCGQXJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Mar 2009 11:23:09 -0500
Content-Disposition: inline
In-Reply-To: <200903061607.16825.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Mar 06, 2009 at 04:07:16PM -0800, David Brownell wrote:

> The boot_on semantics are kind of odd then ...

> What I thought they meant:  Bootloader turned this on.

That's still roughly the case, though in practice there's no actual need
to do this for the vast majority of regulators since it is possible for
the kernel to just read the status of the regulator back at runtime
which is obviously more reliable.

> What you describe above:    Kernel turn this on during startup.

What's happening here is that the kernel is making sure that the
information it was given about the state of the regulator is actually
true in case it was important (things could drift if the bootloader or
hardware are improved to boot up with a better default configuration,
for example).  The kernel could warn here but we'd need to be clear why
the constraints tell us that the regulator is on.

This also has the side effect of allowing the constraints to turn the
regulator on at startup, perhaps to aid early boot or perhaps because
not all the drivers in the system that need it have regulator support
yet, but that wasn't the primary purpose.

> Versus normal behavior:     Consumer turns it on, as needed.

That now works as normal.  Originally using boot_on would've had the
effect of setting an always_on constraint which really wasn't desirable
since we already have that.

> I wouldn't have thought there would be a need for that
> second case, since the board-specific init code can
> just define a consumer that turns it on if that's what
> it needs.

Yes, it could - or it could define an always_on constraint if that were
what's needed.  On the other hand, it's the sort of thing that more than
one board is going to need to do so it does make sense to factor it out
a bit.
