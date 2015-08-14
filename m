From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: pbias: use untranslated address to
 program pbias regulator
Date: Fri, 14 Aug 2015 19:00:06 +0100
Message-ID: <20150814180006.GB10748@sirena.org.uk>
References: <1437996250-2913-1-git-send-email-kishon@ti.com>
 <1437996250-2913-2-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PgFjNgMZ2k7V6t4+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437996250-2913-2-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, grygorii.strashko@ti.com, nsekhar@ti.com, stable@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org


--PgFjNgMZ2k7V6t4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2015 at 04:54:09PM +0530, Kishon Vijay Abraham I wrote:

> vsel_reg and enable_reg of the pbias regulator descriptor should actually
> have the offset from syscon. However after the pbias device tree node

I'm having a hard time understanding this statement, sorry.  What makes
you say that they "shouild actually have the offset from syscon"?  What
is the problem that this is supposed to fix?

> is moved as a child node of syscon, vsel_reg and enable_reg has the
> absolute address because of the address translation that happens while
> creating device from device tree node.
> So avoid using platform_get_resource and use of_get_address in order to
> get only the offset (untranslated address) and populate these in
> vsel_reg and enable_reg.

This sounds like we're going in the wrong direction, we're moving from a
more generic API to a firmware specific one.  Why is this a good fix?

--PgFjNgMZ2k7V6t4+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVziylAAoJECTWi3JdVIfQaOMH/3Rk/ouE+Qi7y2sGKljwxsb/
8vJRM2j4Mdw/+i9ngU0i7nRgvqsicwSaHPXK7sCVHMz45zgW2w75UUn+aXRoMYID
3MzlSSB7i7o4f3FjPMlCqTy4BFAinOEyej9AHFGfeYs21UvtBww90JB4IIIST7o3
tNOTCD3N/LGBhFa16aXIk/B+4/iErYlNH7xvqxHEAi5slpqhCNzKnMJ4eeTIJx/b
fXOFpU8j0Ur+GAH4UYChfz2jBigRMYVA57F7K0nvsQXplwH55AKcThsQLwEUysYU
S58lop6XvTxjlP4YlR2ajXqjO8Oc+3qt9x4kp8p3lMJyBtAHifspZseAIdrjOd0=
=g6YC
-----END PGP SIGNATURE-----

--PgFjNgMZ2k7V6t4+--
