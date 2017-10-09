From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: lp873x: Update the enable mask for LDOs and
 BUCKs
Date: Mon, 9 Oct 2017 16:50:26 +0100
Message-ID: <20171009155026.63aghfli7bkemiux@sirena.co.uk>
References: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
 <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
 <72182869-6102-1178-91c4-0be632d4be32@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hxh3xoqhqs3opq23"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <72182869-6102-1178-91c4-0be632d4be32@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--hxh3xoqhqs3opq23
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 09, 2017 at 06:35:14PM +0300, Tero Kristo wrote:

> The EN signal coming in to the PMIC is actually used to poweroff the system
> completely. There is no other mechanism for doing this in lp873x based
> systems, they removed the bit for controlling dev-power-off from the
> register space. If the EN bit is down for a specific regulator, it won't go
> down when attempting to poweroff the system, otherwise the state of a
> regulator is the result of (EN_PIN | EN_BIT).

This should be clear from the changelog (and probably the code as well).

> I wonder if we should tie this somehow to the system-power-controller
> property though.... If the PMIC is not system-power-controller, we should
> disable the EN_PIN_CTRL from all regulators so that they don't go down if
> the EN_PIN itself is floating for example.

Seems plausible, if someone does decided to use control at runtime the
behaviour can always be changed if the GPIO is present.

--hxh3xoqhqs3opq23
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnbmsEACgkQJNaLcl1U
h9CeFQf4h2CIUdtZ7CFG82sX9SKkdq8zPW+AkZQLHHTwnKrkRiK2vYKdPlgbhrVy
QrlSFrF7EQ/M/opJfig2ntaI27jej3TrXe6VcJwK6kWhysBa25gv5rCjwXJ9uDYP
8vgxgh0php6a7jDIfSvivvJk7mjkS3NxWEesJvnFbWZl61n7K3+Pe9GXKd8urRt8
crw3Z8ZSSh/ymWLR5EcdjgqI18bhAtIrZnijKaI9yk3AnJkIHdd0/QgpDkU5U1iI
TzwO+5TsUt/zCcgnYtDMMQYy9/1vDpOgwo5FU2P0ouxZ88PybVN5ruLSDLxSHrXi
fE7Esg7ot3g4u5MU4CxJ+HWc2MMh
=eYw7
-----END PGP SIGNATURE-----

--hxh3xoqhqs3opq23--
