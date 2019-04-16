From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 01/12] i2c: remove use of in_atomic()
Date: Tue, 16 Apr 2019 12:48:23 +0200
Message-ID: <20190416104823.zabxzdxarzfhdw7m@ninjato>
References: <20190403124019.8947-1-wsa+renesas@sang-engineering.com>
 <20190403124019.8947-2-wsa+renesas@sang-engineering.com>
 <20190415215546.xr7aftkahcu4ygak@porty>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="va5zqs4dempdj6of"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190415215546.xr7aftkahcu4ygak@porty>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Lengfeld <contact@stefanchrist.eu>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>, linux-omap@vger.kernel.org, linux-tegra@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-omap@vger.kernel.org


--va5zqs4dempdj6of
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

> Tested-by: Stefan Lengfeld <contact@stefanchrist.eu>

Thanks for your comments and testing! I will fix the issues you
mentioned and add your tags.

> > +/*
> > + * We only allow atomic transfers for very late communication, e.g. to=
 send
> > + * the powerdown command to a PMIC. Atomic transfers are a corner case=
 and not
> > + * for generic use!
> > + */
> > +static inline bool i2c_in_atomic_xfer_mode(void)
> > +{
> > +	return system_state > SYSTEM_RUNNING && irqs_disabled();
> > +}
>=20
> I agree that this code is a lot better than the previous
> 'irqs_disabled() || in_atomic()'. It also makes clear that the atomic
> I2C transfers is only meant for late shutdown I2C communcation.
>=20
>=20
> After I read the article https://lwn.net/Articles/274695/ again I
> nevertheless cannot really say whether the usage of 'irqs_disabled()' is
> the theoretical correct approach. The article states explicitly that
> only the caller can really decided whether the operation should be
> atomic or not.

During the discussion with Peter, he stated we need irqs_disabled()
because 'system_state > SYSTEM_RUNNING' alone won't do.

> Recap from previous discussions:
>=20
> But then you have to patch every call site to use either a new function
> like 'i2c_transfer_atomic()' or the extend I2C message flags. And mostly
> also supported this trough regmap and maybe other translation layers,
> which seems unpractical, may breaking existing usages and maybe not
> worth the hassle.

Yes, I kinda gave up on white-listing late I2C transfers. My hope is
that not too many drivers will have an atomic callback, so the WARN will
trigger often enough to find late transfers which are inappropriate.

Another idea just popping up: Maybe we can improve that even further by
first globally disabling atomic transfers. Drivers knowing they need
this can then call an I2C core helper to enable them (again globally).
Still not perfect as some unwanted late I2C transfers from another
driver could slip through, but this should be rare enough. The pro-side
is we will detect more unwanted late transfers if support for them is
default off. It should be noted that "disabling" means keeping the old
behaviour which is: we try the regular transfer but complain about it.
Only enabling atomic will make the core quiet.

Regards,

   Wolfram


--va5zqs4dempdj6of
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly1svMACgkQFA3kzBSg
KbZxBRAApfDnYlIej1zlztDILL+sczBMwOC2hii04cYsWcmCh3D+0h6upc7U3ibE
pVykQ6KN5qrvSyu07V1aw2Z/iM2T2rA/MSMKEOAKmnydQLzWGU/VpgKKXWdd6o7J
aol3sP+ovgih1qolxcAFw9sW8EfrrkEp8AbcGcfTCALWHfEmcLWyvWcm3kedBZIX
br6lJHvLUU4WrKZxhUsuz1VQ/wq9iIcZiG/pEbyBAD/4Yo2Ot2WyiYw4TjScxgvP
aGWKC3+GX08/O1PMjnMVTrtGyW2LhrMcQx1w0s3We93KWsSnzRPRQjbNUa0e/uIZ
Hes/jSfFV3a8paryTaipp2w2k4u11h3ZbLsRFrN2SXKTv3oJxrh6bcRd2j7dJB4q
iwjOQnd5CWRjljZ1xhS2i+RY1TD2ZxspLIS4Z+PAqjE4qTGlioyqkZkH9/aC4Kb2
kbzFu8oOzSVTptTZVslEgCZgjoNB77Z7unFDAiogat71VL1473XT7mdW4sGTT8iy
aI60L8EXdYrsde0pcyH23v/iz9e9gV8wk4zo47v48osiPXLw59CmUqr9/8/6jnn/
nAEKyMK5qyQkc3u792gAF9Ex7g1w3QRFBD+6ZIvY3gMeMSoHpUwoysxklQuXWE5e
T3OfXcZ3hSYof1AUlO7BfEQ89r/Uil9mtZPrYJ0N6qDTX7eDfY8=
=HlAN
-----END PGP SIGNATURE-----

--va5zqs4dempdj6of--
