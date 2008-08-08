From: Tony Lindgren <tony@atomide.com>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check
	and repost
Date: Fri, 8 Aug 2008 13:34:02 +0300
Message-ID: <20080808103400.GT24923@atomide.com>
References: <20080805143519.GS7193@atomide.com> <200808061630.09530.david-b@pacbell.net> <20080807105725.GJ27799@atomide.com> <200808071650.39469.david-b@pacbell.net> <20080808102933.GS24923@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59465 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890AbYHHKeG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 06:34:06 -0400
Content-Disposition: inline
In-Reply-To: <20080808102933.GS24923@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080808 13:29]:
> * David Brownell <david-b@pacbell.net> [080808 02:51]:
> > On Thursday 07 August 2008, Tony Lindgren wrote:
> > >=20
> > > > Two problems on the OSK5912:
> > > >=20
> > > > =A0- cpufreq oopses on boot
> > > > =A0- continuous i2c overflow errors
> > > >=20
> > > > ISTR both of these bugs are in mainline too. =A0I'd say the
> > > > I2C regression is higher priority.
> > >=20
> > > Hmm, I wonder what has broken I2C?
> >=20
> > Seems fixed now; goof in earlier error handling patch.
> >=20
> >=20
> > > Anyways, let's fix these regressions before tagging.
> >=20
> > I've not yet looked at the cpufreq thing, but after
> > applying the patch from Chandra Shekhar the I2C problem
> > went away.
>=20
> OK
>=20
> > However that still doesn't make OSK happy.  It wedges
> > sometime after freeing init memory ... timer interrupts
> > are no longer happening, the LED stops flashing.  The
> > userspace has sometimes started the watchdog daemon, in
> > which case a watchdog timeout fires and it reboots.
>=20
> Hmm could it be the dmtimer posted mode patch applied
> earlier?
>=20
> > FWIW mainline fails *really* early, before showing any
> > kernel messages at all.
>=20
> Bummer, too bad my osk is also connected to my non-responding remote
> power switch :(
>=20
> I'll tag v2.6.26-omap1 despite these issues, we can branch
> and do -omap2 when we have sorted these remaining issues out.

Currently only pushed to kernel.org git tree, looks like
source.mvista.com is down right now.

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
