From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20150629 build: 1 failures 74 warnings (next-20150629)
Date: Mon, 29 Jun 2015 18:15:41 +0100
Message-ID: <20150629171541.GK11162@sirena.org.uk>
References: <E1Z9WQC-000356-Bd@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="T4Djgzn3z2HSNnx0"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1Z9WQC-000356-Bd@optimist>
Sender: linux-next-owner@vger.kernel.org
To: Lars Poeschel <poeschel@lemonage.de>, Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--T4Djgzn3z2HSNnx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2015 at 11:36:17AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build an ARM allmodconfig due to:

> ../drivers/watchdog/omap_wdt.c:288:18: error: 'omap_wdt' undeclared (first use in this function)

which is introduced by "watchdog: omap_wdt: early_enable module
parameter" which adds the above reference to a nonexistant variable.
Presumably the patch was generated against something sufficiently old to
lack "watchdog: omap: put struct watchdog_device into driver data" which
appears to be where it was removed.

--T4Djgzn3z2HSNnx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVkX09AAoJECTWi3JdVIfQTmgH/16VaJpAUhRs+5RF4w9pN3Ai
Vy8bSmP/wsXoefiqZtqUJGV+pkY8a87xzpR77vvL6bYrWhVqs/qbVw5hSt77kBmp
04+fDRlsrC9PjEbbNy4D70KCLjMUu0eKHAXMFyY+sBRBiYKLEQ5pM01Ju2ypppeH
oakxYNY+cMQIGBUMqjAjiS5kvpzwPK4yT3KwEu2aBxmSE5oan5kQbUiSOcuKfZi5
sv96VN2o3jt0Vtg/S1+YGZya/o64mPP7bzYo9ezF16e9DauoqGTEm/bncrBhcsFE
nRXzbdyKY2ygKa9w8Utmm8Q/Qolbk7Gkyp3p73e5Wd1ypJiLz4NxQofR5/j5MBM=
=FXwm
-----END PGP SIGNATURE-----

--T4Djgzn3z2HSNnx0--
