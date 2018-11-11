From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 3/4] drm/omap: dsi: Ensure the device is active during
 probe
Date: Sun, 11 Nov 2018 01:48:28 +0100
Message-ID: <20181111004828.klbhwqopp3zybdtw@earth.universe>
References: <20181110111654.4387-1-laurent.pinchart@ideasonboard.com>
 <20181110111654.4387-4-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1890382908=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20181110111654.4387-4-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org


--===============1890382908==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rl2hjj63iwk6blk4"
Content-Disposition: inline


--rl2hjj63iwk6blk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 10, 2018 at 01:16:53PM +0200, Laurent Pinchart wrote:
> The probe function performs hardware access to read the number of
> supported data lanes from a configuration register and thus requires the
> device to be active. Ensure this by surrounding the access with
> dsi_runtime_get() and dsi_runtime_put() calls.
>=20
> Fixes: edb715dffdee ("drm/omap: dss: dsi: Move initialization code from b=
ind to probe")
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/omapdrm/dss/dsi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index 394c129cfb3b..b9d5ad7e67d8 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -5409,11 +5409,14 @@ static int dsi_probe(struct platform_device *pdev)
> =20
>  	/* DSI on OMAP3 doesn't have register DSI_GNQ, set number
>  	 * of data to 3 by default */
> -	if (dsi->data->quirks & DSI_QUIRK_GNQ)
> +	if (dsi->data->quirks & DSI_QUIRK_GNQ) {
> +		dsi_runtime_get(dsi);
>  		/* NB_DATA_LANES */
>  		dsi->num_lanes_supported =3D 1 + REG_GET(dsi, DSI_GNQ, 11, 9);
> -	else
> +		dsi_runtime_put(dsi);
> +	} else {
>  		dsi->num_lanes_supported =3D 3;
> +	}
> =20
>  	r =3D dsi_init_output(dsi);
>  	if (r)
> --=20
> Regards,
>=20
> Laurent Pinchart
>=20

--rl2hjj63iwk6blk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlvnfFwACgkQ2O7X88g7
+ppwChAAmWL0zLyRqp8D/kcTFbRoty995v+XfpA1OekXed4+ZVZS5Br4MpcT9RnW
u28VtPa9EKmVBJXA5ItzRc6bC6gWRTOiTNv8EiPDQiQO9/m0L0oXTSUGGFSvZ/EA
jNJ0rk4q5KEI9Tl8UTCsf1ThEKGTOUWPJdcIlr7/5EYhIrVIeQDeFffYUPGwYO9C
EPda0kJvr2lrAO4B7FK1ofp+tvLNh4ELK5Fhv+kCKH6UPhslCZ1R5NFeJbNwhJcI
cE2Dvj2PXJiy1ANwPe00EN9KAVXU2PYJQoIsQn+wGZRKHUch8pMjM4uVgkhOp7NV
ZGd+RKY1yGdBZ1TPaGKH8dgV43wRVtuJY/rRV8UKmFZUVq14wgdJKY3b9VxuedM7
fAg02oyuhqIw7KYWdoiWH/6dmva3hDQL3hGXCYwN4Xzl66Ho3Tj6c9q9FDdPIFB5
cSCIoeeB2bERGxlSFpEYvN0MHY47YrHNvOYCC/mQVzp4Ktu/UN027nniKvASd2Uo
CpKFAmIYkf8fOs4k+f+fHQB+SreJ6HCKzLT5YrIldYeNK8INzpFCVuw8js/kdZc3
dgUEUxYhVdtu2Nl06W8mnlmJKGob0z22PHybZsbKVNNJFMCMIdYxszJCd+MZxPNq
cw7eVKOv1Z+AnMN9b4DmLpFFRXt8KKa8L+TcAjT6QqM5awsNp14=
=tT+a
-----END PGP SIGNATURE-----

--rl2hjj63iwk6blk4--

--===============1890382908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1890382908==--
