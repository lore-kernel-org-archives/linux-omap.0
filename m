From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH v2] omap: rx51: fix USB
Date: Sat, 10 Dec 2011 09:37:03 +0100
Message-ID: <20111210083702.GB32605@earth.universe>
References: <20111208144044.GA25415@xps8300>
 <1323375780-13190-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1323375780-13190-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Heikki Krogerus <krohei@gmail.com>, Russell King <linux@arm.linux.org.uk>, Anton Vorontsov <cbouatmailru@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>, stable@kernel.org
List-Id: linux-omap@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 08, 2011 at 10:23:00PM +0200, Felipe Contreras wrote:
> The transceiver should be powered on by default, otherwise USB doesn't
> work at all.
>=20
> All kernels after v3.0 are affected.

I tested this patch successfully on 3.1 mainline kernel.
You can add this if you want:

Reviewed-by: Sebastian Reichel <sre@debian.org>

-- Sebastian

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO4xouAAoJENju1/PIO/qacR4P/RlXiHDjB0FJTZjjFMK+4jB9
4xn1WEAys/SjRC55jBqGTMf4X3v5KjzYzTbR+OfEQCfNlm6hgv9gPVaw8dbLkzfm
CH/7kSPmjfli/lP6LZPZmZyXzBbm2V8zmmmjvVmcavTlmGMPE1JfGhN9LKNljpPo
+YI2UafVCD7ReEzRC8mzDKWK+hHihauitilCK9AHZ4lcWU572Oz8pgLZSR//5V6I
MtDB+FK5uSPiu9F4hoBC0mujVoqw9vJMGQFsUfkocdibA5QFAZ737dbhaI+naSGm
sr9PMGTK9ATzsj+coM8ZeH9oYfCuveCO6OUH6McZGS6GK8BSPW5fgC0be01/1WLT
mIo8ssQEpy9xIAjdh11zIuciOPFMQlUt4i8sbzuYXx4hilRrhcKWLCGPJw0iB7S3
gw4qtskmQIdm8SrznDaW3HF+kIWJ6mBQeerEvO7J7PdF4rtleeg9Og0ojYVMfDeu
CdWeWrGHllrwsSMy9E2Fl/7w0BD5IFjPUw1SY2sOig5wuz/DFsuGoVmrLUAdORsQ
Y4Yvw1EM3MWDUKwJ5WrN40HCA93soqzE01ySdHRTl82wQQIKvdwuUUZ4nCu1q3VH
6+78dhQl3TGH2yzVZbusYVoYicH2H5NJg34+ibcDJ0gBZw0d9Qzk2L3N6V2U7R2u
vQyTR3efqYn00zysL0yv
=8wae
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
