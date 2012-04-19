From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: Ensure OPP100 when DSS is operational
Date: Thu, 19 Apr 2012 08:03:25 +0300
Message-ID: <1334811805.1521.27.camel@lappy>
References: <1331205217-19927-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331205217-19927-2-git-send-email-tomi.valkeinen@ti.com>
	 <1331646353.2856.354.camel@deskari> <87zkbkmjo1.fsf@ti.com>
	 <1331707131.1618.7.camel@lappy>  <87vckxm0px.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-kF36Jrda2a5gUtcJ10wA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:51831 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751038Ab2DSFDd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 01:03:33 -0400
Received: by lbbgh12 with SMTP id gh12so992171lbb.15
        for <linux-omap@vger.kernel.org>; Wed, 18 Apr 2012 22:03:30 -0700 (PDT)
In-Reply-To: <87vckxm0px.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, archit@ti.com


--=-kF36Jrda2a5gUtcJ10wA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-04-18 at 10:03 -0700, Kevin Hilman wrote:
> [ Tomi, sorry for the delay.  I thought I had sent this a while back,
>   but found it in my drafts folder. ]
>=20
> +Mike for clock comments
>=20
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>=20
> > On Tue, 2012-03-13 at 11:37 -0700, Kevin Hilman wrote:
> >> Hi Tomi,
> >>=20
> >> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> >>=20
> >> > Hi Kevin, Paul,
> >> >
> >> > I know you're busy, but I'd appreciate a comment/ack on these two sm=
all
> >> > patches, so I could get them in to next merge window. Otherwise usin=
g
> >> > any other OPP than OPP100 will most likely break the DSS.
> >> >
> >> > This looks quite straightforward fix for me, but I'm not sure if the=
re
> >> > could be any side effects.
> >>=20
> >> How does it affect OMAP3?  OPP50/OPP100 names are specific to OMAP4.
> >
> > They are? At least 3630 TRM speaks of them in the DSS chapter.
> >
>=20
> The OPP names might exist, but the freq/voltage values are different
> between 3430, 3630 and 4430.
>=20
> The point is that it's hard to make SoC independent code that depends on
> a particular OPP because OPPs are defined as SoC specific.

Hmm, true. But the OPP name is all we have (in TRM). And, if I
understand correctly, this restriction is a "feature" of the DSS
hardware, thus belongs to the DSS driver.

Is there such a concept as "full power", meaning OMAP's OPP100? Because
I think the table in the TRM could be defined in other words also:
OPP100 would mean "full power" or "normal" or similar, and OPP50 would
mean "any power saving mode which is not full power".

> >> Also, Can you help us understand the exact nature of the constraint?
> >
> > The TRM lists maximum clock rates for the DSS clocks. You should be abl=
e
> > to find them by searching "OPP100" in the DSS chapter. In my TRMs there
> > are:
> >
> > OMAP3630: Table 7-19. Display Subsystem Clocks
> > OMAP4430: Table 10-4. DSS Clock Frequencies
> >
> >> It sounds to me like it acutally is a throughput constraint on CORE.  =
If
> >> so, wouldn't it be clearer to set a throughput constraint that is
> >> calculated based on the pixel clock and resulting bitrate that would
> >> have the same effect?
> >
> > I don't see that these limits would have anything to do with CORE. I'm
> > guessing that the DSS HW just can't function properly with high clocks
> > and low voltage.
>=20
> OK, this gets back to something we've talked about a few times that is
> needed in the clock framework.  Basically, we need a way for clocks to
> prevent changes so these kinds of dependencies can be tracked.  We've
> talked about new APIs like clk_allow_changes(), clk_block_changes() or
> something like that.
>=20
> Basically, something that allows clocks to know that their will not be
> changed under them.=20

I don't think that is the issue.

The clocks do not change to "bad" values accidentally. The DSS driver is
always in control of the clocks. So when the DSS driver sets a clock to
a frequency that requires OPP100, the driver knows this, and similarly,
when the DSS clocks are all below the required limits and we could use
OPP50, the DSS driver knows it.

Also, the DSS clocks that come from DSI and HDMI PLLs are DSS internal
clocks, they do not come from PRCM. So a clock framework change is not
enough.

So, as far as I understand, what is needed is a way for the DSS driver
to inform the power management layer that from this point forward the
DSS HW needs "full power". DSS driver would then use this method when it
knows OPP100 is required and when it knows OPP100 is no longer required.

> > Making a constraint for the throughput is another matter, which should
> > be also fixed at some point. So in the future I hope we'll have PM
> > constraints coming from two sources: 1) a calculation based on the
> > memory throughput needs=20
>=20
> This can be done today.  That is the purpose of the tput constraint.
>=20
> > 2) the minimum clock rates.
>=20
> Right, today we don't have a way do to this, and clock framework support
> will be needed.  I'll let Paul & Mike comment on that aspect, and
> hopefully we'll have something in common clock that will be able to
> handle this eventually.

Even if the clock framework would support this, we still have the DSS
internal clocks that have to be handled.

And taking this into a more generic direction, I don't think this is
strictly clock related. I'm not a HW guy so I could as well be totally
wrong here, but I imagine that we could have a feature in DSS HW that
only works with with OPP100. Something that, for whatever reason,
doesn't work with lower voltage levels.

Obviously we don't have to care much about imaginary problems, but a way
for the drivers to constraint the PM OPP level would solve those also.

> > But both of those are non-trivial to code, so this patch aims to keep
> > DSS working until those are implemented. Also, in practice, it's quite
> > rare that the DSS clocks would all be below the limits in the tables.
> > That could only happen with a fixed, known configuration with rather
> > small displays.
>=20
> So, in summary, I have no objection $SUBJECT patch which implements the
> constraint using the only available method we have today.

I take that was an ack for these patches? =3D)

 Tomi


--=-kF36Jrda2a5gUtcJ10wA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj5yPAAoJEPo9qoy8lh71hT4P/RVuFnertOWoqQhQYQ7Bfxgu
jMFHcarJ/5tyXeMdTAYIdG8vxX4GK+fmAunMJcCuHMLMk1yjdXDNSgqbyrbwCC4g
+ohfiKwgzoC+fBKuqonHvFBrOMCIvnawQHnqqUgEBbvzJe71dybHPBlyZ5dnT36i
7y3JUoYQBVEpwwOruo3zhCZ8UeC3ifMnTzV0fCOlzCBh6DDk+cqO0aOL5ydfS/+3
QqC/lGbl3F1+tGNtbGfUfX/dngL6MKjM9oMNbbWhxK90Hw2aqVnRe+lQEszKqtAX
LcL6Dol1L76mZxYs7fh4T5lyd8Ry0ZfsnOKj1+/DLFlLO3vZaks6TE9LoQ7Re/Pl
kWrhn5PE43SGNrRE8bjYkaKi/0ixpRVkw2/NxA0c3RvhWtSmLQRLehPVhMxg3Seb
Z1ERdHBAwJNrr5aSQAR31PwFZiRHsaWEaYSq2NM8R+gbg8Y5Pa0l4/fafjj6U3s6
MtGIZCI+e0O+yOXSeXzCPi/mUy2PKucaKGME1vHBCRt2rNlSoOLYHp+jHB9fujqE
HpSFSAigcKyqifAOo8gf/xBm1/O+D2pQFmZz6vEdGCBO/dDPJ2h7QFUIYBAVbb2O
Ub8+CotmTllq2FaWUJhPoaArMT+zAtXA0u6xN6QkFX2pN+3debimGTrn10a3c/1r
GwHJh+yUY9dsoMwUrsWy
=SK5A
-----END PGP SIGNATURE-----

--=-kF36Jrda2a5gUtcJ10wA--

