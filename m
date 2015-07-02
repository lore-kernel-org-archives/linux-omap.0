From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] ARM: DTS: am437x-sk-evm: Use simple-card for audio
 support
Date: Thu, 2 Jul 2015 07:10:45 -0500
Message-ID: <20150702121045.GC5837@saruman.tx.rr.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 02, 2015 at 02:58:04PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> There is no reason to use the davinci-evm machine driver's compatible for=
 audio
> support since the setup is simple and the common simple-audio-card can ha=
ndle it
> just fine.
> Also add McASP1 sleep pin configuration.
>=20
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   ARM: DTS: am437x-sk-evm: Add sleep pin settings for mcasp1
>   ARM: DTS: am437x-sk-evm: Switch using simple-audio-card for audio
>     support

you should add a patch enabling CONFIG_SND_SIMPLE_CARD=3Dm in
omap2plus_defconfig

--=20
balbi

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlSpFAAoJEIaOsuA1yqREEN4QALNMaEcBc3/2hCROhB+kvG3J
aGlfuzztOBcp//F+zUul9K0egyr/CSIs/b6l2FS9mj+1Ra/HI7Qc58E/UIXKMLMs
8N/E+A3MMlotZpc4tSo3tEBlrbVI4r1n8JLfV2OOzwR09V8je+mx16zJkneF7oD9
gJhse+kATNhn6DWy/1M0tk7rLAe9zobiuYQBajEvggwPpdpmTS/xWUzw+NdRYHWk
c5GVhv8Gt/2/GBNE0irLmbJWVxsirlNdtn7irY6s/NW4tv31zx+9B97ohYpWocz2
U9KIzYca0ZuNO37xuCdx5rk6JpEiByYkllQ6sV5KMnSSI7dbTj3RPJiewM1AJ30a
8ZfnkY8BM9IpM9bi8o4r8EPZs3SdOIAxvbze3wr+3UEXK/E0N5tKALfAftiBfaZD
zS0tT/xZ36ZW5QJzlISbDGnWk+2D0X/l2imtfNcGO3IapcGmF1xBpO4w9m/xgmwh
kGmj8CWjg+hCigMk+a7dTbMm35gACluyWRnRuVs/lnHLxbKJJ2A90m88XGXI8yOb
ew7T7fuRAxzmbXy04+t5VCTjRxN2MUVp0SSFThwTlEbQzweydHFDbdkGOyfudGO7
yiAP679bbEYuUMj5xoN6x+WKZ2lboWC5P3KCq4x7QwP79ZHlJi892x6Uns73Gttx
SrCdw0lzyTXl2aFgtddm
=jKol
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
