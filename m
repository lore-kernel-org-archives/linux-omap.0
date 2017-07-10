From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ARM: dts: omap4-droid4: add soundcard
Date: Mon, 10 Jul 2017 13:26:02 +0100
Message-ID: <20170710122602.srdzonm3s6gcqhnf@sirena.org.uk>
References: <20170707164229.5868-1-sebastian.reichel@collabora.co.uk>
 <20170707164229.5868-4-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="olg6lzizx3gns3l4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170707164229.5868-4-sebastian.reichel@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--olg6lzizx3gns3l4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2017 at 06:42:29PM +0200, Sebastian Reichel wrote:

> +	soundcard {
> +		compatible = "simple-audio-card";
> +		simple-audio-card,name = "Droid 4 Audio";

New systems should be using the of-graph card which is more flexible and
extensible than simple-card.

--olg6lzizx3gns3l4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlljcloACgkQJNaLcl1U
h9APNgf8CY2qlt7rvqTEnozXXl1djhxuLrgvUldr3zcDfo2lbbhPIgTArGRTOPgd
UJfj+CepBfzzamp98W0Pix1zRBW4PG2jYgsij4AbA5LSj5NkOgm7hGngJXFZD+eW
1nZnz6p8d1BX79e9CnKP1yZncs8+1eRoTaiS0L4BJxu5N7fT/mBv+9ArogOT2Ltd
zZKGxvGoi7EKBdxH13jEG45PKLQMIOoxelhz9IESsvBtWkzjj0rqJ6iWXyF85GZ8
jVAorkeensXPZgH4TcAZukFLlzkEj1rQeNe7ThnPnDSBheySuuLsEhomr9NkrZbb
RxQI62NZ5AtwwmICwHibslsu7qEHLA==
=V697
-----END PGP SIGNATURE-----

--olg6lzizx3gns3l4--
