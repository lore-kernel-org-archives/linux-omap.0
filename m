From: Mark Brown <broonie@kernel.org>
Subject: Re: Regulator regression in next-20180305
Date: Wed, 7 Mar 2018 14:10:27 +0000
Message-ID: <20180307141027.GD7290@sirena.org.uk>
References: <20180305231246.GB5799@atomide.com>
 <CAOMZO5CXy=7ZKVapp_2Q4wq=mY-dJ0owZZN84vqUj1j1xasOKg@mail.gmail.com>
 <CGME20180306163044epcas2p1b5bc62e4cba6c6e8c8ea7e75329c11ef@epcas2p1.samsung.com>
 <20180306163035.GE13586@sirena.org.uk>
 <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb1adc11-40ff-d37d-60f1-d6e706b058a6@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Purski <m.purski@samsung.com>
Cc: Fabio Estevam <festevam@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-omap@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2018 at 01:57:12PM +0100, Maciej Purski wrote:

> I'm trying to figure out what is so special about these boards. The only
> strange thing, that I haven't noticed at first, is that all regulators share
> a common supply - dummy regulator. It is defined in anatop_regulator.c.

No, that's a regulator framework thing - the regulator framework will
use the dummy regulator as a supply when there's nothing described in
the DT so long as the client doesn't explicitly tell it that the supply
might be optional.

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqf8tIACgkQJNaLcl1U
h9BGlgf+PRwjpmWYL9RWHYSFyl9NE+Av0pg57e5S2CUGYQpZw9iUEClJn7P5P9L3
FizLSWWRBCCmg0ZhS+qspwQyUCHnINNH9VO6vxSGVTBbsHGzQ0178uZPtLLGF0wR
eCmyTOATh6O4sH+a+CXDRUy8uTej/7dE1NenQZBsDEODb5wVgD4fITny5xuoog0R
6TQK9lyiZSGiVD5SAC2x8fy8bElW2qDtDMYwiXbiNSI4iWzOCbwS+AFYEyUtMuxH
2zQ1OySkM4Bx7Zc81JKZX7f/R+UI2VzmXY1H1ZO0vgHkRVWqPely+3R3EO9NGYPv
xkZZQi0+YN1sLzrkux2bhxBja7ZTIQ==
=q7o/
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
