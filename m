From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] watchdog: another ioremap() fix
Date: Sun, 21 Sep 2008 11:20:09 -0700
Message-ID: <20080921182008.GB7961@atomide.com>
References: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com> <200809181003.16664.david-b@pacbell.net> <20080918195007.GA14307@flint.arm.linux.org.uk> <200809181310.49569.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59200 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYIUSRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 21 Sep 2008 14:17:40 -0400
Content-Disposition: inline
In-Reply-To: <200809181310.49569.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Felipe Balbi <felipe.balbi@nokia.com>, linux-omap@vger.kernel.org, gdavis@mvista.com, wim@iguana.be

* David Brownell <david-b@pacbell.net> [080918 13:11]:
> On Thursday 18 September 2008, Russell King - ARM Linux wrote:
> > What I say to Tony: do you want OMAP to be merged into mainline, or
> > don't you. =A0If you do, do _not_ accept this patch but get the cha=
nges
> > already in your tree for omap_wdt.c up to Wim, and then get this pa=
tch
> > there. =A0Provide the carrot by getting the driver up to date in ma=
inline,
> > and the stick by only accepting patches for this driver once they'v=
e
> > been acked by Wim. =A0Explicitly ask Wim to ack them for you.
> >=20
> > Then you have one less driver to worry about constantly being out o=
f
> > date with mainline.
>=20
> That sounds like a plan.  One could go further and work
> something like the "stable" tree ... not merging into the
> OMAP tree until the patch is merged, or at least queued,
> for upstream.  Minimal exceptions, if any.  (And not for
> this watchdog!)
>=20
> That should be workable for most drivers; sometimes with
> a few arch/arm/plat-omap/include/mach/*.h updates you may
> need to ack.  Things like CBUS support (no framework for
> that is upstream) are cases where it'd fail.
>=20
> I'm not exactly in this particular loop except as a gadfly
> with relevant insight/background/experience, but I suspect
> that a basic goal *MUST* be to avoid having Tony and/or
> Russell in the loop unless it's unavoidable. =20

Been offline few days, glad to see the watchdog updates moving forward =
:)

Yes I agree we should deal with drivers directly on the appropriate
mailing lists. And then have them fall downstream to l-o tree.

We can use l-o tree for testing and integration, but let's add
a new rule like Russell is suggesting: Let's get at least an ack from
the appropriate maintainer before we apply the patches into l-o tree.

And of course we've already moved quite a bit of the driver development
to the right mailing lists like USB (except ehci-hcd, grr) and audio.

Cheers,

Tony





--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
