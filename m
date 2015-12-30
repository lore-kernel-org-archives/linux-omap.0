From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
Date: Wed, 30 Dec 2015 19:37:19 +0100
Message-ID: <1451500639.14341.6.camel@collins>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
	 <1450868319-20513-5-git-send-email-contact@paulk.fr>
	 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
	 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
	 <1451387613.18148.9.camel@collins> <568323B7.7080101@ti.com>
	 <1451464521.2531.4.camel@collins> <20151230163307.GW16023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-LSx1ZIlV1MMhc/8HbKM5"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151230163307.GW16023@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Milo Kim <milo.kim@ti.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--=-LSx1ZIlV1MMhc/8HbKM5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 30 d=C3=A9cembre 2015 =C3=A0 16:33 +0000, Mark Brown a =C3=A9cr=
it :
> On Wed, Dec 30, 2015 at 09:35:21AM +0100, Paul Kocialkowski wrote:
>=20
> > In my opinion, it would be more elegant to adapt the core regulator
> > framework to first enable the GPIO and then call the regulator enable
> > ops callback instead of handling the GPIO in the driver.
>=20
> Why would we want to actively manage both things at runtime?  It's more
> work, what do we gain from it?

Well, I figured that it would be best to disable the EN pin when we're
not using any of the regulators, since that allows the chip to enter
standby mode (and thus consume less power).

Implementing that logic in the driver seems very redundant when we're
one step away from doing it with the core regulator framework.
It is also likely that in the future, other chips will use and need to
handle a global enable pin for the same purpose, while allowing
regulator configuration and enable via registers.

It also doesn't hurt regulators that only use a GPIO for enable.

The diff to do this is very minimal, I already have a patch ready, that
I could send if there is a chance for it to get through.

--=20
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/


--=-LSx1ZIlV1MMhc/8HbKM5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWhCRfAAoJEIT9weqP7pUM8DYQAJyNvHDw0gfikZ2+He8Q5cL9
E4fDdmCAOKphHK9j/WAYwuIGticmCn7ea2DsNFQbdbY55T5irS+BSvh93+HRCSTs
PrFD7Y3oZm7vsyXqmClSinMDqA3BZN1JMNmLxKK9L0/h9y6Ya+O5CfYx2YR+nqMN
QITCfQAJjTkSvIVu7HhjmCDmxmLQu19CMq57vNOMj8/ClftvHKLeNjhyJdanu9gw
aaneqz2qB81XQFESkCzdvfIujbt7xbYcGUMCB4oo4Et5fZ1Teb+4t8e4or05keO2
iYG/pxny6kEcRW1RFpdr4SBr3MHrdT4ApfbcOA6JNBo9xkPeP8J1aQVj3Jr1fTDo
8lN5a2c7Xi7dicgSA1tp9Y5GL9Sy32OIMwLmgakpQmk5+Z79EkCUpLZyy1kmGeGt
V2qw+MTgNVMgGCMAVlT9YS/7nn+c4LLuHsxE/aaUpW3IGLE0s7qBG7zCP9i+2cT9
P24qhJ73pk56wVze1EXKGfeCL/q4RFLNrowwF2Ur/RHXjhKXSM8pqpsbWWhRnLj5
jWOgaAHyGtyfxLhpJfgXZsPhIALoqoiEB/O/t3pYIcCMExJwZP8hJvty7enevHFm
5YTF1bB3e+VgptaZ/WkwUL7MF/QljghKGUvnB+hyxGToaJl4q3Hs6AZfsxyOFQBq
nrxXznyXhsYFtdjDImiS
=aKaA
-----END PGP SIGNATURE-----

--=-LSx1ZIlV1MMhc/8HbKM5--
