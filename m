From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20150604 build: 2 failures 37 warnings (next-20150604)
Date: Thu, 4 Jun 2015 18:01:12 +0100
Message-ID: <20150604170112.GM14071@sirena.org.uk>
References: <E1Z0YIL-0008Ma-5O@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EnT6sQnqsTJq4oDy"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1Z0YIL-0008Ma-5O@optimist>
Sender: linux-next-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--EnT6sQnqsTJq4oDy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2015 at 05:47:05PM +0100, Build bot for Mark Brown wrote:

> 	arm-allmodconfig
> ../drivers/tty/serial/8250/8250_omap.c:586:20: error: redefinition of 'omap8250_irq'

Current -next fails to build an ARM allmodconfig (and possibly other
things) due to 9e91597f24234 and 9809889c708eb (serial: 8250_omap:
provide complete custom startup & shutdown callbacks) which appear to be
the same commit that's been applied twice somehow.  Not sure what's
going on there...

--EnT6sQnqsTJq4oDy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcIRXAAoJECTWi3JdVIfQzvUIAICPq9dQCUjshf9d3YAEHZDH
vGEpFwpiYSqhLY+MG0AMXaTMue3+SdB4/uW/PN6cSVOpUDZFGnDdE9IUMpzuMm/6
wfw8ocG6z7YOVABhRAI4qEkURMQvWmr9eznjsZjHz35gFRti9Pat2tK3LD1ofFEO
jnTjWK01HIlsNzmOIiSrA0XK2mKTC/A2gyMrpbs8kkBemLyHXX9qCJQD7DI5ElkI
AkSBYrR3rRFTyFGHax9CP4ESuzMiSmxueK5XX7f3q599KTItWw//ZAJ5ZA1kWteo
IxdwbHneQo5XW8LCZATxBEDBzJ19zmiiaybbQOTA8UJWCEkailZpCxqS0KM6yCw=
=2yxF
-----END PGP SIGNATURE-----

--EnT6sQnqsTJq4oDy--
