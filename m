From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: ams_delta: use GPIO lookup table
Date: Mon, 21 May 2018 11:05:03 +0100
Message-ID: <20180521100503.GA24638@sirena.org.uk>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
 <20180518210954.29044-3-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="envbJBWh7q8WU6mo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518210954.29044-3-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2018 at 11:09:51PM +0200, Janusz Krzysztofik wrote:
> Now as the Amstrad Delta board provides GPIO lookup tables, switch from
> GPIO numbers to GPIO descriptors and use the table to locate required
> GPIO pins.

Acked-by: Mark Brown <broonie@kernel.org>

--envbJBWh7q8WU6mo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsCmc4ACgkQJNaLcl1U
h9DG0Af/UE7Z72qRF50Yg/UqUfLu60IQ6PX2zlv8XLEh1YdSXf0sIPdW4xsjUYKI
B5eF5/fXlrjYYiIxMe9kNZT8jfPW7QP+lkpD07CIf2Io3+AGNHU+NuflzyEOqODX
uJia7Umel8v7868BkFoyBpmEUVcHl8Gpo4k3e3T79PcBXvSmQusoupFWC/apcdT/
xSKEmqpHYV5gdeiSIBBGVsb48oQ+GKlwEpsdPCGXkl63WuSg+QH5miaTIIiQyRZ8
3q3PD70Jxv2QUvoZ6bRTStoZRk2D8PcnNauk4hJ/gKnw1FceWNNVtmAYVG7xOZwW
bazFSdj285WRNlhe7N/Qw7x0JGBztg==
=PRAh
-----END PGP SIGNATURE-----

--envbJBWh7q8WU6mo--
