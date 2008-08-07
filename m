From: David Brownell <david-b@pacbell.net>
Subject: Re: About to tag v2.6.26-omap1, patch queue deleted, please check and repost
Date: Thu, 7 Aug 2008 16:50:39 -0700
Message-ID: <200808071650.39469.david-b@pacbell.net>
References: <20080805143519.GS7193@atomide.com> <200808061630.09530.david-b@pacbell.net> <20080807105725.GJ27799@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp122.sbc.mail.sp1.yahoo.com ([69.147.64.95]:32233 "HELO
	smtp122.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751877AbYHGXvD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 19:51:03 -0400
In-Reply-To: <20080807105725.GJ27799@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Thursday 07 August 2008, Tony Lindgren wrote:
>=20
> > Two problems on the OSK5912:
> >=20
> > =A0- cpufreq oopses on boot
> > =A0- continuous i2c overflow errors
> >=20
> > ISTR both of these bugs are in mainline too. =A0I'd say the
> > I2C regression is higher priority.
>=20
> Hmm, I wonder what has broken I2C?

Seems fixed now; goof in earlier error handling patch.


> Anyways, let's fix these regressions before tagging.

I've not yet looked at the cpufreq thing, but after
applying the patch from Chandra Shekhar the I2C problem
went away.

However that still doesn't make OSK happy.  It wedges
sometime after freeing init memory ... timer interrupts
are no longer happening, the LED stops flashing.  The
userspace has sometimes started the watchdog daemon, in
which case a watchdog timeout fires and it reboots.

=46WIW mainline fails *really* early, before showing any
kernel messages at all.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
