From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: OMAPFB: panel-sony-acx565akm: fix bad unlock
 balance
Date: Mon, 18 Nov 2013 15:36:51 +0200
Message-ID: <528A17F3.5020500@ti.com>
References: <1384195298-31542-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vHMRrc5567TEpw1kaB2CmlEbKdgdlxSmm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56009 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab3KRNhD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Nov 2013 08:37:03 -0500
In-Reply-To: <1384195298-31542-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, stable@vger.kernel.org

--vHMRrc5567TEpw1kaB2CmlEbKdgdlxSmm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-11-11 20:41, Aaro Koskinen wrote:
> When booting Nokia N900 smartphone with v3.12 + omap2plus_defconfig
> (LOCKDEP enabled) and CONFIG_DISPLAY_PANEL_SONY_ACX565AKM enabled,
> the following BUG is seen during the boot:
>=20
> [    7.302154] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    7.307128] [ BUG: bad unlock balance detected! ]
> [    7.312103] 3.12.0-los.git-2093492-00120-g5e01dc7 #3 Not tainted
> [    7.318450] -------------------------------------
> [    7.323425] kworker/u2:1/12 is trying to release lock (&ddata->mutex=
) at:
> [    7.330657] [<c031b760>] acx565akm_enable+0x12c/0x18c
> [    7.335998] but there are no more locks to release!
>=20
> Fix by removing double unlock and handling the locking completely insid=
e
> acx565akm_panel_power_on() when doing the power on.
>=20
> Reported-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: stable@vger.kernel.org
> ---
>  drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/=
drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> index e6d56f7..d94f35d 100644
> --- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> +++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
> @@ -526,6 +526,8 @@ static int acx565akm_panel_power_on(struct omap_dss=
_device *dssdev)
>  	struct omap_dss_device *in =3D ddata->in;
>  	int r;
> =20
> +	mutex_lock(&ddata->mutex);
> +
>  	dev_dbg(&ddata->spi->dev, "%s\n", __func__);
> =20
>  	in->ops.sdi->set_timings(in, &ddata->videomode);
> @@ -614,10 +616,7 @@ static int acx565akm_enable(struct omap_dss_device=
 *dssdev)
>  	if (omapdss_device_is_enabled(dssdev))
>  		return 0;
> =20
> -	mutex_lock(&ddata->mutex);
>  	r =3D acx565akm_panel_power_on(dssdev);
> -	mutex_unlock(&ddata->mutex);
> -
>  	if (r)
>  		return r;
> =20
>=20

Thanks, this is better. lock and unlock in different functions makes me
feel very uneasy...

 Tomi



--vHMRrc5567TEpw1kaB2CmlEbKdgdlxSmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSihfzAAoJEPo9qoy8lh71CFAP/Rf1AcafQcQW9oKMC8WZvwpB
a9SzKhSy1095v79lyt5sXfCSaEpuM/AVoAbPR0hMxZdO9rwtSM209+s7RqvNuHPt
i6ruPjL1f5IAQ1csGlA97qVl9D+pZbDHBb+il79CDYiMOqhixgb0tjWjsrxMudt0
fUBFF8D+7QMaR+z3UMT8aZTkg2Uu4hC5TJSSsYLMxbgX20C2POXzD25rxarpKA6x
fCEBymVVmeDw7TLmIYhJ8g/RWeXc3PoSIRipbZwK/XyeDkkSzx9bfmyU5NDfrPTl
WkmwXUuG9N2H7dCLD59ETObfwQGJg2ysUGwBcuQQutOJ3Z7PEWxy9N3mHzoOGaow
5uFyILrYg0dWx/Nr47dB4D4lj4aZf6motnDB6WC+QUxTwlOMWz6odf6dMDmjez+w
2nDXLmpsXd798TFhakNXAK68tNi2HCaCGOVItlD4DInnjeXqa69sfNrCtD9V23g2
lc1EU6n7MdRBVpgxbJ9MKR6Z5crL3bjVeaGJEKL4Hr3KzW+Ci/77eQHgYHVqSHzF
DpAki5sfbXibD8/vnqDZy8hJmcHnbyJfuwX8CRk7ZoPafl1VfBRIKLtfck+pGm2v
hITHVaUHYnxetOnOXL/xIMVoDb3lGpz4TRPkc6SEtdQuw5Zd0jovBEorusMcA0nM
MFVhMRHn9qVx73yIQkjr
=JK1Q
-----END PGP SIGNATURE-----

--vHMRrc5567TEpw1kaB2CmlEbKdgdlxSmm--
