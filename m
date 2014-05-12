From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/19] ASoC: omap: Remove obsolete HDMI audio code and
 Kconfig options
Date: Mon, 12 May 2014 18:22:43 +0100
Message-ID: <20140512172243.GD12304@sirena.org.uk>
References: <cover.1399884780.git.jsarha@ti.com>
 <df664d05d8208f5789623604a4e0f5342bc6e405.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ix8ND813NDRFdDE4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42465 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756008AbaELRW4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 13:22:56 -0400
Content-Disposition: inline
In-Reply-To: <df664d05d8208f5789623604a4e0f5342bc6e405.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com


--ix8ND813NDRFdDE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 12, 2014 at 12:12:22PM +0300, Jyri Sarha wrote:
> Removes omap-hdmi DAI driver, omap-hdmi-card driver, the related
> Kconfig options, and Makefile entries. The HDMI DAI drivers has been
> integrated directly to OMAP4+ HDMI drivers and simple-card driver is
> used instead of omap-hdmi-card driver.

Acked-by: Mark Brown <broonie@linaro.org>

--ix8ND813NDRFdDE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcQNgAAoJELSic+t+oim9VcEP+wQ9RRAyPFn6WlQjf1TuL7qR
SGEl0Vvf76ngM7Bau/He6sXS6SJNANoZXrHUwLbpH3TLl+wj/MkKYz734rXzXb2A
+d9BBqU8YnJAOx4dMVMFZ9mtLvtrBlv9IaIc0q6tSQotplCXVBUgUsRyC0cVGZ7/
FbriH1X+3vp5t+WonazQQUbrzNAvRBfSoGnGvkhN50tybjOai66WQ3Q8Mrb7a7VO
k/h9vX1R4E/6bafyXRQWM84jRzu3oBFkx/vBfril8FVMjciixWJroGkogT43gdwC
oWGOp2oKHL/E7O8XHjURReQQKEJL4OGLJwM/1q+veu91b9Ffp+xHsj0ufxQoYXsF
DNNEIa8JDjvJG6ooYOLczRsBAshAKFTOJn0TZg4VqfFJmoBkUsqTe2b82byYClrB
zxG3tN7f1/eN9tyvq331MOm6c/Eh6OdGFX2BYK2XOsSNf5EaITKZwmCsxaAxpIvH
LfIJSe9SvVyequOcUZYo31mWBNOyt6AWxwJ72HYexVNf30+xYIao9o0pwGdR/EIZ
hzI3Avhnpi1psc7QpKJny3QhfhQmeExrsXBsAGBySWNHQ5AGVIaLNKOS4IiCeVpM
o142T9VYI2dCmLiPpsFAykMFfmCxV/5ZjjRTvYH9wS6FlLHLzq0UzIff2oWqokjG
v1pLQ7yJdGA46BzjE4Pg
=apVs
-----END PGP SIGNATURE-----

--ix8ND813NDRFdDE4--
