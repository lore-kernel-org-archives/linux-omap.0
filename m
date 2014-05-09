From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Fri, 9 May 2014 10:38:54 +0300
Message-ID: <536C860E.1000501@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="pHgu2KOiCS7HbWwD4sJa6MmD8Hur9V33G"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44981 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756204AbaEIHjU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 03:39:20 -0400
In-Reply-To: <1398815562-24113-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--pHgu2KOiCS7HbWwD4sJa6MmD8Hur9V33G
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/04/14 02:52, Tony Lindgren wrote:
> Otherwise we can get often errors like the following and the
> display won't come on:
>=20
> omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> the output with video overlays disabled
>=20
> There are some earlier references to this issue:
>=20
> http://www.spinics.net/lists/linux-omap/msg59511.html
> http://www.spinics.net/lists/linux-omap/msg59724.html

Those don't sound like the same issue, but it's hard to say. What kind
of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and
without this patch?

What resolution do you have? If it's a very high resolution (say, DVI
output to a monitor), it could just be an issue of
not-enough-memory-bandwidth.

> It seems that it's safe to set the lower values even for 3630.
> If we can confirm that 3630 works with the higher values
> reliably we can add further detection.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/=
omap2/dss/dss.c
> index d55266c..ad6561f 100644
> --- a/drivers/video/fbdev/omap2/dss/dss.c
> +++ b/drivers/video/fbdev/omap2/dss/dss.c
> @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feat=
s __initconst =3D {
>  	.dpi_select_source	=3D	&dss_dpi_select_source_omap2_omap3,
>  };
> =20
> +/* Supposedly 3630 can use div 32 mult 2, but that needs to be recheck=
ed */
>  static const struct dss_features omap3630_dss_feats __initconst =3D {
> -	.fck_div_max		=3D	32,
> -	.dss_fck_multiplier	=3D	1,
> +	.fck_div_max		=3D	16,
> +	.dss_fck_multiplier	=3D	2,

These values tell about the clock hardware, they are not settings that
can be changed to change the clock. OMAP3630 has a fixed x2 multiplier
and a divider with maximum value of 16.

 Tomi



--pHgu2KOiCS7HbWwD4sJa6MmD8Hur9V33G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbIYOAAoJEPo9qoy8lh71RJ0QAJC4W1o98J2/WqowIkoCb+j4
wCGBGi4t7SFi8RVvngVN6MADuYzcY3gP0aBWHAEXufugArSO1rfiDfqGYD5SYgPI
LoR/z6hD1Ez1/JaBAChsurpTX7q118zsmTBgF9B2HGKJrw2ZM/20uR9NRRIPhYHt
7H1QykB5G7zvD2zpU6LLjs920GwP0Q661djAeXXOep2H+4TaG6xc8/Nwe/V1OreD
E0y3Jk9k6MY04yvrKc0Iv9v1VySQL2Kat5GDD0c6UW9Yjx1jyX4PUnlhjIOFxdi/
TUzqXAk97y7lESObUAqLs5SOSwyxDE64o/jzq2OCROffCDgx5pixJuhouIz08/Pd
BNltnwyhyvwESAWWP7qtf/EQ7DhxPsjY3t+WMJfUunl+2ptMf4OUPT7Nj5qaGgso
PvKxpcB0/qRGbqiZtTOcNdD5mCsVmUenke9qLHQeisNLwiBYr71GtRqoATWCDfUz
cyYizVqop1F4Z9KrB53IO/vyXdAW0Gk3ZskByNHGnwY047bGzUWWWn5t5HsFuopR
HNR99HIdNGQoBPfnXNIsV7XBNfSptVxxcrzLhb0ypcomw0Fs5FRDTps/Bo67sV/p
Szk0S78S8zeqIThGCrUyUDkz3ppaGvfi3/r2IsBrPfUlV060i8gcx17j6FdI6kA+
MWPyrLrlwB86yRfu4aFN
=fan5
-----END PGP SIGNATURE-----

--pHgu2KOiCS7HbWwD4sJa6MmD8Hur9V33G--
