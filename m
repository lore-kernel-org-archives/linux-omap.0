From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] regulator: lp873x: Update the enable mask for LDOs and
 BUCKs
Date: Tue, 10 Oct 2017 09:55:21 +0100
Message-ID: <20171010085521.sax2kpxdzznfzpv2@sirena.co.uk>
References: <1506515140-26058-1-git-send-email-j-keerthy@ti.com>
 <20171009142053.rogvykzmoatduv6i@sirena.co.uk>
 <72182869-6102-1178-91c4-0be632d4be32@ti.com>
 <20171009155026.63aghfli7bkemiux@sirena.co.uk>
 <0e3aba27-d17a-1c3a-f384-5e393310668b@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gghsmsyfh43xpgik"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e3aba27-d17a-1c3a-f384-5e393310668b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--gghsmsyfh43xpgik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 10, 2017 at 07:34:52AM +0530, Keerthy wrote:
> On Monday 09 October 2017 09:20 PM, Mark Brown wrote:
> > On Mon, Oct 09, 2017 at 06:35:14PM +0300, Tero Kristo wrote:

> >> I wonder if we should tie this somehow to the system-power-controller
> >> property though.... If the PMIC is not system-power-controller, we should
> >> disable the EN_PIN_CTRL from all regulators so that they don't go down if
> >> the EN_PIN itself is floating for example.

> > Seems plausible, if someone does decided to use control at runtime the
> > behaviour can always be changed if the GPIO is present.

> Okay. So Implement a poweroff function where EN pin magic is done based
> on system-power-controller property?

That's up to you lot.

--gghsmsyfh43xpgik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlncivgACgkQJNaLcl1U
h9Difwf7B7waMpuLG5mmdOYYOSKBzy8fx3ao5RalgIsyc/PPZy/+55gQRon7EeKN
SoDzjUF6cG8DCNGz7B8qVOoUDgroaPXvOWiYSVcY8TstwO7zrGYU6Dyn60ELKQUS
PLkPoYUTHoDax7sfoClnR+rF/N1xKwiyYG9x4x0T0GSYRvwrFrOUNR1eW1nEi7+7
zkD9q5oNw7fMrmdE5IS/DQjzZoNckc4bBraNTnAg8lYDQdkh3pW7Z8JxoYCii+yR
RRagDzKcfatrAeMXD07neo+yKJGfnDxgDtHEmtTVp+yJThAfrxmAD20YdJuB4haO
9tpT7oF60naQtSkAl59hzC8QV9t9jQ==
=jD/m
-----END PGP SIGNATURE-----

--gghsmsyfh43xpgik--
