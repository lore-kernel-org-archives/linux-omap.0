From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] omapdss: features: fixed supported outputs for OMAP4
Date: Mon, 11 Mar 2013 14:28:56 +0200
Message-ID: <513DCE08.20404@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1362493070-17706-5-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE080EC0DBB00BC1EA08B20A3"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58039 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828Ab3CKM3E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 08:29:04 -0400
In-Reply-To: <1362493070-17706-5-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org

--------------enigE080EC0DBB00BC1EA08B20A3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-05 16:17, Archit Taneja wrote:
> The support outputs struct for overlay managers is incorrect for OMAP4.=
 Make
> these changes:
>=20
> - DPI isn't supported via the LCD1 overlay manager, remove DPI as a sup=
ported
>   output.
> - the TV manager can suppport DPI, but the omapdss driver doesn't suppo=
rt that
>   yet, we require some muxing at the DSS level, and we also need to con=
figure
>   the hdmi pll in the DPI driver so that the TV manager has a pixel clo=
ck. We
>   don't support that yet.
>=20
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  drivers/video/omap2/dss/dss_features.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/oma=
p2/dss/dss_features.c
> index d7d66ef..7f791ae 100644
> --- a/drivers/video/omap2/dss/dss_features.c
> +++ b/drivers/video/omap2/dss/dss_features.c
> @@ -202,12 +202,10 @@ static const enum omap_dss_output_id omap3630_dss=
_supported_outputs[] =3D {
> =20
>  static const enum omap_dss_output_id omap4_dss_supported_outputs[] =3D=
 {
>  	/* OMAP_DSS_CHANNEL_LCD */
> -	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
> -	OMAP_DSS_OUTPUT_DSI1,
> +	OMAP_DSS_OUTPUT_DBI | OMAP_DSS_OUTPUT_DSI1,
> =20
>  	/* OMAP_DSS_CHANNEL_DIGIT */
> -	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
> -	OMAP_DSS_OUTPUT_DPI,
> +	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI,
> =20
>  	/* OMAP_DSS_CHANNEL_LCD2 */
>  	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
>=20

Thanks, I'll apply this to omapdss fixes branch.

 Tomi



--------------enigE080EC0DBB00BC1EA08B20A3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRPc4IAAoJEPo9qoy8lh716f8P/39UeK7L+quyFSuTFYdQIKnn
Ct4QQs/VBoG1hCWczYxInr7ZpE8dnzOPvy57JXvVaZT8fxQ1F9vyoJW0nvWh/dmu
cLpt2mBgAMTuPiMK5lJEPx4Txw4/In9XkhdbXFAaADEa5ZQeisKdFPf5R/TRrx4e
g0hcxmx/xGIz474MXwbm3wzViKK/9f1t0jYOxA0/zDTY7cvX1OHzk1YrVHhMDNKb
+a2AqN/bT8G7rkRzjbmUzeXv3ifWY6y/ik2odESjGQQa0qRlwm65U3PWcDa9lMnw
d0D375rNpRD9qSNjlxnk3u1P3BiTpPgvlXxvuJ14oWe2hwwguNXRMEPtQLxqcL6E
0tNv0A/zf++5YbYKXA+O1jS/oZKYSvlNClUYqAUMun0wsaTB5VU2clNRNMuv/+R0
z8FaK/tBiEsXG2YFh8sUe3Sxi9LSRskypm1E3Dr/V+ry7KEbn16/GFbGYRKx4l6T
khLSvrCUqFwUhe5+5Gntbj639UIbAFru8mhkZAyD3JS1j4ec9zk2pr3Y7Jtwl+yD
vAiwalwpaBefAbRS0yLj+N0CKBp44bSgez9Kw4zd/FxKn2hjTviE84P8IQAefkvX
Ygrt6m547PWrs23VfF8r7rWvGe0EiAzfLxsDwmz0pHLsTI5NsWNyM+cQck2l6dSu
JYYdLK0aXuZvUbaXy01p
=LqOj
-----END PGP SIGNATURE-----

--------------enigE080EC0DBB00BC1EA08B20A3--
