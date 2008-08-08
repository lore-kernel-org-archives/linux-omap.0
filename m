From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check
	and repost
Date: Fri, 8 Aug 2008 13:29:34 +0300
Message-ID: <20080808102933.GS24923@atomide.com>
References: <20080805143519.GS7193@atomide.com> <200808061630.09530.david-b@pacbell.net> <20080807105725.GJ27799@atomide.com> <200808071650.39469.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56815 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYHHK3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 06:29:38 -0400
Content-Disposition: inline
In-Reply-To: <200808071650.39469.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [080808 02:51]:
> On Thursday 07 August 2008, Tony Lindgren wrote:
> >=20
> > > Two problems on the OSK5912:
> > >=20
> > > =A0- cpufreq oopses on boot
> > > =A0- continuous i2c overflow errors
> > >=20
> > > ISTR both of these bugs are in mainline too. =A0I'd say the
> > > I2C regression is higher priority.
> >=20
> > Hmm, I wonder what has broken I2C?
>=20
> Seems fixed now; goof in earlier error handling patch.
>=20
>=20
> > Anyways, let's fix these regressions before tagging.
>=20
> I've not yet looked at the cpufreq thing, but after
> applying the patch from Chandra Shekhar the I2C problem
> went away.

OK

> However that still doesn't make OSK happy.  It wedges
> sometime after freeing init memory ... timer interrupts
> are no longer happening, the LED stops flashing.  The
> userspace has sometimes started the watchdog daemon, in
> which case a watchdog timeout fires and it reboots.

Hmm could it be the dmtimer posted mode patch applied
earlier?

> FWIW mainline fails *really* early, before showing any
> kernel messages at all.

Bummer, too bad my osk is also connected to my non-responding remote
power switch :(

I'll tag v2.6.26-omap1 despite these issues, we can branch
and do -omap2 when we have sorted these remaining issues out.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
