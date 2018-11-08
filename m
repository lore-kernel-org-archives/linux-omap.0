From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 10/11] regulator: core: Use ww_mutex for regulators
 locking
Date: Thu, 8 Nov 2018 13:07:14 +0000
Message-ID: <20181108130714.GE6675@sirena.org.uk>
References: <20181005153638.1886-1-digetx@gmail.com>
 <20181005153638.1886-11-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005153638.1886-11-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Maciej Purski <m.purski@samsung.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 05, 2018 at 06:36:37PM +0300, Dmitry Osipenko wrote:

> Wait/wound mutex shall be used in order to avoid lockups on locking of
> coupled regulators.

This breaks the build due to a few of the drivers (wm8350 and da9210 at
least) taking rdev locks in their interrupt handlers.  I'd suggest
adding a function for those drivers to use - exposing the ww context
seems like the wrong thing to do there.

Otherwise the series looks good, I've applied everything up to here.
Thanks for taking the time to pick this up, and especially for figuring
out the ww_mutex conversion.

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvkNQIACgkQJNaLcl1U
h9CBHgf+NUaKw5RG4K/VmM+a/RA5SHTaEUvbBkj0rbZxteC/KbFdAKRHaHyEMfdO
INQon26sjFFX8o8qiiYJHfFkWnJN1tKxODp474RfIL/Sy5U8pNMUfjUPS52qgd56
1onsQCk0cqWlswJAvntF5Ui7XW3MwZXL0xm4/QQsU8yiET9lR2nG8p5Y/Fnn+Enx
9phPizZN1F8+DolLlTjMvuGQXOGXxg8K/UZMHFE3Wtni3aaCGnQsv+eZvge/ga8h
wrxfR9cB7usKdNOFHr0lRwHTrKP0nBus0hgeaGBGGcv5Le3IGLJ4jeVBpolui+jd
1m7N+z7cn27BHlChofvH/ST5ypkq4w==
=oaPc
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--
