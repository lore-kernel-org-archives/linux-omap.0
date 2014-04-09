From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] ARM: OMAP2+: N900: remove omapdss init for DT boot
Date: Wed, 9 Apr 2014 09:27:15 +0300
Message-ID: <5344E843.8000008@ti.com>
References: <1396990278-16706-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3VS4SmLFJW7PBD2AN28H5aIXguDVdh0Bt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34109 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbaDIG1Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 02:27:24 -0400
In-Reply-To: <1396990278-16706-1-git-send-email-sre@kernel.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

--3VS4SmLFJW7PBD2AN28H5aIXguDVdh0Bt
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/04/14 23:51, Sebastian Reichel wrote:
> Do not try to initialize display for DT boot, since omapdss
> is now initialized via Device Tree. Without this patch the
> display subsystem does not properly come up.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Hi,
>=20
> This patch should be added to 3.15-rc to make display initialization vi=
a DT
> possible. Sorry for not noticing earlier, that this was missing in Tomi=
's
> patchset.
>=20
> -- Sebastian
> ---
>  arch/arm/mach-omap2/board-rx51-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-oma=
p2/board-rx51-video.c
> index 43a90c8..9cfebc5 100644
> --- a/arch/arm/mach-omap2/board-rx51-video.c
> +++ b/arch/arm/mach-omap2/board-rx51-video.c
> @@ -48,7 +48,7 @@ static struct omap_dss_board_info rx51_dss_board_info=
 =3D {
> =20
>  static int __init rx51_video_init(void)
>  {
> -	if (!machine_is_nokia_rx51() && !of_machine_is_compatible("nokia,omap=
3-n900"))
> +	if (!machine_is_nokia_rx51())
>  		return 0;
> =20
>  	if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT)) {
>=20

Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi



--3VS4SmLFJW7PBD2AN28H5aIXguDVdh0Bt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTROhGAAoJEPo9qoy8lh71rQ8QAIbWIisT/0pFDaik9qqg0F4e
IkI2LCAik6pu8bnV3EYC8UCaVzMBlR7nIm46624DIMwBT2A33hVY0yequ/ODiQEd
H1NmDWO9MoopjEbNLqyv0mPCgoxqkSQnTwbGlCNnnY0asmrD2riVHn/kDX8S6rXj
o2k/RWaSlbDaZo6UDz4umAdWtu+kLONVbd0b6TALPIKGD0Z9geFaWMalonJoyCwv
ZcvQOmgYUY8Rh4cuxTY5OKnrKyIS2ErLVPwfHSiL5whTEXRPP/DHvh6FuNMKeXLm
z9DoI71A+ZMT/gfR5cDdOvo3mYgOckHp+jxCHoucR6xNOrTUymhKeAe9yFwJJ4pX
+X6dtokSCkq8b6bT81VUbIZt+Fo7BfNqFL2VBh2jkek/S+Or5YRGcCj9pGWEbpKY
YKBiEShUn0gokG/GpGGzFlrRORqKXQiX6sYDsL215mU1jdULQ9A0b/um8n9pKAB2
UryTeOM31FmOHo16wTMMS9TchYLXUV7Ev7LHQusHJLAfm1oQkxDwteM99EfMmL11
shTZkfMgC9/sA1t4ovgzgpZI1FLk9KvgXwrebv33rxii6uEEojkRI99jvZtxFpYE
1MHvth5HCiSqWt5a3bDqVENAor1ms9fyBavCu/FFb1Y8Ptuh2mKuDY5jbGqDUGAB
WzePFdIFxtqrYmA/yN56
=qrHS
-----END PGP SIGNATURE-----

--3VS4SmLFJW7PBD2AN28H5aIXguDVdh0Bt--
