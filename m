From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Thu, 24 Dec 2015 21:05:38 +0100
Message-ID: <1450987538.11913.12.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <1450980773.11913.3.camel@collins>
	 <20151224193538.GJ579@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-N3GvhIiv6cmwpW1WG0S+"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151224193538.GJ579@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Milo Kim <milo.kim@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-N3GvhIiv6cmwpW1WG0S+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 24 d=C3=A9cembre 2015 =C3=A0 19:35 +0000, Mark Brown a =C3=A9crit =
:
> On Thu, Dec 24, 2015 at 07:12:53PM +0100, Paul Kocialkowski wrote:
> > Le mercredi 23 d=C3=A9cembre 2015 =C3=A0 11:56 +0000, Mark Brown a =C3=
=A9crit :
>=20
> > > This isn't really adding support for the enable GPIO as the changelog
> > > suggests, it's requesting but not managing the GPIO.  Since there is
> > > core support for manging enable GPIOs this seems especially silly,
> > > please tell the core about the GPIO and then it will work at runtime
> > > too.
>=20
> > It looks like the core bindings for GPIO can only be used instead of th=
e
> > rdev->desc->ops->enable callback, not jointly, which doesn't fit my use
> > case, where both the GPIO and register write have to be used to enable
> > regulators.
>=20
> > I think it would be worth making it possible to use both in core, since
> > that situation is probably shared with other regulators. I suggest the
> > following diff (that would be split into a separate patch in v2 of this
> > series):
>=20
> No, that's broken - the whole point with using a GPIO for enable control
> on a lot of devices is that it is much faster than doing a register
> write.  What I would expect to happen in this case is that when
> initialsing the GPIO we set the register to enabled and then only manage
> the GPIO at runtime.

That GPIO is shared with all regulators that the chip provides, so doing
things this way certainly won't work if we don't want all the regulators
powered at all times: in that case, the GPIO has precedence over the
regulator-specific registers.

Doing things the other way round would work and I suppose that chips
that can use a GPIO over registers just wouldn't register any
ops->enable callback in their description.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-N3GvhIiv6cmwpW1WG0S+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWfFASAAoJEIT9weqP7pUMFc4P/jFu8UBpuvfNRPidsc0T2ZMb
PTVzJuIkARzmF5wTv/bm9lWsolcMfgr9fQqhyiOIXapw1Fk0Pm7GMmlL+dFUrX0S
nQr6l8ATuoRy9M8CQZ9V+fgCngEGKTxdSxO+Vmx42mjjMjyZfif7zc54PqzWGqhC
bPfGsGFJ4j/RiBniuWhHJNRxnjxzgdXdUlTg689r4FDY3cIenpl3toLqxY2vQ4K3
zHiVZQyyF2zAXyTqct2FFKkyDtKtFUdhMDmO43Nw8DrR0pO9GJSmjADpiYMdB8Lb
/8rrWiir8rht6l7S8DKQstAAudZfsxB+YNuS70alIad6fFYy6DvjFTo0lRMiguwu
LNZwcogcAfMLom3nUIx7SEc2BKgsLX54FY/LqRztJX/qd/ZN/dy0+CQ2+DBlgqYX
Qb3IYrsHyB22CE+I9JC3flcNr1eHHQqg9IfuhTrUymJhelRq0FSNcBWLd2JjmtAz
Qyi47S+RIotAmz+B2W0fE472WV8bOd5GM3QQcO38uvtXgzWyxkgiOutSekaRFj/5
1YXhxfY5JWd8Gsp0IzCjX6iwI3xVnL1k4UwXzg3Ma3KZJ0jQgrte7PdtUs0b4J0k
XdvVbz7oAXiIXcDJrKeFyK5bcxEPqI5/sAc0y9JOUBr8Y1z+dNuREo8k7mYC93/l
TfiQfJ9qbLe52wECgJ2U
=bSXJ
-----END PGP SIGNATURE-----

--=-N3GvhIiv6cmwpW1WG0S+--
