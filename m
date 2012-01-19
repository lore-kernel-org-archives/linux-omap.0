From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [GIT PULL] HSI framework
Date: Thu, 19 Jan 2012 14:14:19 +0200
Message-ID: <1326975259.28477.57.camel@sauron.fi.intel.com>
References: <1326461140.32183.40.camel@groo>
Reply-To: artem.bityutskiy@linux.intel.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6hXVUt9HrbFkvk7H1zqZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1326461140.32183.40.camel@groo>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: CarlosChinea <carlos.chinea@nokia.com>, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Linus Walleij <linus.walleij@linaro.org>, "peter_henn@gmx.de" <peter_henn@gmx.de>, "sjur.brandeland@stericsson.com" <sjur.brandeland@stericsson.com>, "govindraj.ti@gmail.com" <govindraj.ti@gmail.com>, "pawel.szyszuk@stericsson.com" <pawel.szyszuk@stericsson.com>, Sebastian Reichel <sre@debian.org>, Andras Domokos <andras.domokos@nokia.com>, ext Shubhrajyoti <shubhrajyoti@ti.com>, ext Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, ext Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-omap@vger.kernel.org


--=-6hXVUt9HrbFkvk7H1zqZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-01-13 at 15:25 +0200, Carlos Chinea wrote:
> Hi Linus,
>=20
> I have been working in an HSI framework. The High Speed Synchronous
> Serial Interface (HSI) is a serial interface mainly used for
> connecting application engines (APE) with cellular modem engines (CMT)
> in cellular handsets.
>=20
> The framework is currently being used for some people and we would
> like to see it integrated into the kernel for 3.3. There is no HW
> controller drivers in this pull, but some people have already some of
> them pending which they would like to push as soon as this integrated.
> I am also working on the acceptance for an TI OMAP one, based on a
> compatible legacy version of the interface called SSI.

Hi Linus,

I've noticed that you have not pulled this (yet). I would like to
confirm that we at Intel are also very interested to have HSI upstream.

I believe this code base is more than worth merging since it has many
users and it has proven itself in real Nokia products. Would you please
pull it?

--=20
Best Regards,
Artem Bityutskiy

--=-6hXVUt9HrbFkvk7H1zqZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPGAkbAAoJECmIfjd9wqK0P8gQAMhm7DVb5RkMf40fxBk3GIGO
Lblr9Q0RDKu42ZMHFYkoZiomTU/eBDRbEfUMKxUOjOdCdU4y0RVfUGuItzmGH/M5
xCkgOrFmBRgEGs3l5w+l0AK0pACQxBGfx/XaCBGrUViBEEm1vPiOac/4uh1zcR96
0YuKb51uLc2SUc/Gse/D8meW8+0SDDrg6iT4+fBkm1g2ugYATjN95ARHI6LbLBmQ
rJg/V2WxFWkFHU/aLVi4apFyhoxPzqMRBZKLlgiNb3mjIRc6VYFSpQ9/moaKfdRt
bjwyGXx236WBN17SX+2aH/L4wRGZ+cfi9uYIacayI01wSGQKzH3EYxMwkddgzODy
cGWCkNv9ET8D3UsxVxlLEsIlnYPJrgxQP5xW2UR267u+mqUV/DROKnLQZvQwGe3h
vRAxG3Sunq5y17Mf1E6XPQwDGa4C7pMQjLA1J2n/dyXWoOZZXoIF+3a5/TobG0e6
2vF7vaNCWADCZAmEHBBmTmgyi/OuG/eiTqwSg/0q0bUeUU3W9vK6F7zMMnkL1W1T
rAguv3ZTQJ2OEUmwuLQNOoQFRxMWhUD9fCMmkkV4fqQzMhToe0XIAf7Eu16mdINs
nId6TCwHXHmo3MZ0HcoOpWebDFwbaE4jR2OHZyJmKiISFpwTHI7fzlEyBD4edk/B
4vzEiIFHsNem4px8uiC2
=ipI3
-----END PGP SIGNATURE-----

--=-6hXVUt9HrbFkvk7H1zqZ--
