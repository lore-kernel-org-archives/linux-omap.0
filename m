From: Mark Brown <broonie@kernel.org>
Subject: Re: Nokia N900 headset detection & MIC Bias + TVOUT
Date: Mon, 9 Jan 2017 11:27:49 +0000
Message-ID: <20170109112749.6gmtytxuqzfai57e@sirena.org.uk>
References: <201701070007.49137@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hoilff3dtlaga22e"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201701070007.49137@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--hoilff3dtlaga22e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 07, 2017 at 12:07:49AM +0100, Pali Roh=E1r wrote:

> All that is needed in N900 sound driver, file sound/soc/omap/rx51.c. Can=
=20
> you help me which functions should I call to enable/disable it=20
> correctly? In headset detection code I need to be sure that nobody=20
> (other kernel drivers or userspace via alsamixer) except current=20
> function could change Bias settings.

> MIC Bias is controlled by MICBIAS_CTRL in aic34 'B' part codec, file=20
> tlv320aic3x.c.

Microphone biases are normally controlled by supply widgets and managed
via DAPM.  You can see quite a few examples of this in existing drivers.

--hoilff3dtlaga22e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhzc7QACgkQJNaLcl1U
h9DNHwf/VLdwIpzK10VDO+OdOSzja6pfolK0sdcpZGfzEp5ZMHU9SrrDUD93tKXj
GYMILWCg0jEY0OQtzxoBZ03RpeDID325B6nf05gDMmJFoK65bgUCMCvMwfLg0D5F
NheS8onu1cC2Nr3/UZrfHS6/3OhB8YiiIm+UADhdu3m3UU86dRAIhwGRgoelgX5C
FAVCRDE56nbhwwCHs3IfOqSwLId3mn6RD9EMcXDbSzzQ7M1lBUe0FuK68REdk+bW
SpvjJve3iu8ahlCR3bRVh0DCjfBHDqqO6bwj9uIhKZCTXo1DwpVPcaCHQXA9a4uB
2qvQVHMYymO/ZcW/w7z+NkVmf4UpGw==
=PaUv
-----END PGP SIGNATURE-----

--hoilff3dtlaga22e--
