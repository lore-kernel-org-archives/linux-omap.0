From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix off by one error in the loop
 stucture.
Date: Mon, 24 Nov 2014 18:46:47 +0000
Message-ID: <20141124184647.GA7712@sirena.org.uk>
References: <1416854232-29432-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TUp3RUwt6Yfp+hcS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:37245 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbaKXSsn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Nov 2014 13:48:43 -0500
Content-Disposition: inline
In-Reply-To: <1416854232-29432-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, dcb314@hotmail.com


--TUp3RUwt6Yfp+hcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2014 at 08:37:12PM +0200, Jyri Sarha wrote:
> Fix off by one read beyond the end of a table.

Applied, thanks.

--TUp3RUwt6Yfp+hcS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc30WAAoJECTWi3JdVIfQX3wH/A+ipoR2ArtCbHPcCEIlUAJT
tSLPXaXr5sGbMtycEEDbTT5M2DFE+HVeC0dvob7dCzoBkprARwtl3RgOhxHAtBct
mJdUiuOePPv+xRKurHbCEhUHXBdb2RBKSTWojKT1VgwrqVNz0OP6Np+CF4YcYohu
W23j8FxSsldmfOkxl4glbwQkbO1W6Fty5TW4rseg5q2XNvpxF3fw7eMkG4Q4xqxC
LDg5CKAipGFfGGm85iQMXCLv1q3fSwQKMm7Jg7VIJ1GNellSXEBlE8DPdkVeHsFM
g5YL511HJG93cpZQom1KPLT9raIP19EQCcyz//uiotXtZLB4bbZOQqSmn9z3YFs=
=+k22
-----END PGP SIGNATURE-----

--TUp3RUwt6Yfp+hcS--
