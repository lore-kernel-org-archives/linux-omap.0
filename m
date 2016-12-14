From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH/RFC 6/7] drm: omapdrm: Register omapdrm platform device in
 omapdss driver
Date: Wed, 14 Dec 2016 10:20:39 +0200
Message-ID: <717377fd-6f94-9311-6b2c-fc2cdb7b342e@ti.com>
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1481672306-22564-7-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0577021231=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1481672306-22564-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0577021231==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K3AAAgaruogaSUD9UUMqoHiXu6RwcgnJE"

--K3AAAgaruogaSUD9UUMqoHiXu6RwcgnJE
Content-Type: multipart/mixed; boundary="mWcDFlE2PTWrs8R3FFX2nTxrfAnRXiLfN";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-omap@vger.kernel.org
Message-ID: <717377fd-6f94-9311-6b2c-fc2cdb7b342e@ti.com>
Subject: Re: [PATCH/RFC 6/7] drm: omapdrm: Register omapdrm platform device in
 omapdss driver
References: <1481672306-22564-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1481672306-22564-7-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1481672306-22564-7-git-send-email-laurent.pinchart@ideasonboard.com>

--mWcDFlE2PTWrs8R3FFX2nTxrfAnRXiLfN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14/12/16 01:38, Laurent Pinchart wrote:
> The omapdrm platform device is a virtual device created for the sole
> purpose of handling the omapdss/omapdrm driver split. It should
> eventually be removed. As a first step to ease refactoring move its
> registration from platform code to driver code.
>=20
> The omapdrm driver name must be changed internally to avoid probing bot=
h
> the device registered in platform code and the device registered in the=

> omapdss driver, as that would otherwise break bisection.
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/core.c | 17 +++++++++++++++++
>  drivers/gpu/drm/omapdrm/omap_drv.c |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/omapdrm/dss/core.c b/drivers/gpu/drm/omapd=
rm/dss/core.c
> index 1bf978b5c5bc..b7c44b85b7c3 100644
> --- a/drivers/gpu/drm/omapdrm/dss/core.c
> +++ b/drivers/gpu/drm/omapdrm/dss/core.c
> @@ -22,6 +22,7 @@
> =20
>  #define DSS_SUBSYS_NAME "CORE"
> =20
> +#include <linux/dma-mapping.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/clk.h>
> @@ -285,6 +286,16 @@ static void (*dss_output_drv_unreg_funcs[])(void) =
=3D {
>  	dss_uninit_platform_driver,
>  };
> =20
> +#if IS_ENABLED(CONFIG_DRM_OMAP)

The #ifs are not needed, don't compile this file if there's no DRM_OMAP.

> +static struct platform_device omap_drm_device =3D {
> +	.dev =3D {
> +		.coherent_dma_mask =3D DMA_BIT_MASK(32),
> +	},
> +	.name =3D "omapdrm_",
> +	.id =3D 0,
> +};
> +#endif
> +
>  static int __init omap_dss_init(void)
>  {
>  	int r;
> @@ -300,6 +311,12 @@ static int __init omap_dss_init(void)
>  			goto err_reg;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_DRM_OMAP)
> +	r =3D platform_device_register(&omap_drm_device);
> +	if (r)
> +		goto err_reg;
> +#endif

Where is the unregister?

 Tomi


--mWcDFlE2PTWrs8R3FFX2nTxrfAnRXiLfN--

--K3AAAgaruogaSUD9UUMqoHiXu6RwcgnJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUQDXAAoJEPo9qoy8lh718wIP/jZJPw+dZlRaB4SNCdqnIxvl
CFzX5JZVeBTPS/gSrzaOsCXO9JMBIH5pUrKVv03gPgLy2qs6OzFVtjGK+qY9V9Fi
NSnlOu0FE9qfzttVUB/UNYM31xmmZR0wox9RzLVvF4Revn/vhJv7NaQ6ZXOEGeu5
ngQA79LoVa4rtJcLKGtJLH3B2BnFSC+w0FWedIUir4fy184OVLYLJpKijhxEVUUc
o+6oE28scLvmHN2PZyZ+G9RakrkWYjBR6S02N+qifoqG64uEYG6vV9CnHaEdXUaV
pGHjQeK3rui6YYmajtBM1s4/zglEb+6nMEZnNlmOjGCaWekH6QNSagpyUCNd5z7k
/NMwsEATG9VwKjiNbDaR1yuZrMIP653oO7IqyNX3G4OaedyaAur2T5GiG6USsDrp
boMdAtFAZodGQfdGfVmyy1+k09iMEJsZvrCQQqnqUnaNZtueum8b9xXCcLT8kB2y
Go/q9H8e6iOEzp5aoX6Syi3GrZ4BS2fnmCN49kEpUlKQIuC4PudoaeQH0YXwUC8M
CrG4GewCKvnEpZ92yEEedYfDkIpvgvEbC87qcdlKfq/vKMbPmualImVQF7eMOWaW
kHCVNhqbg7A5Qdij6nyjFxrDwZedollGSV9r/TMvKgRpbFwvpzXwidZRFJ1IcftH
dzZFbZrdk9rqiP6YuJTc
=khJ7
-----END PGP SIGNATURE-----

--K3AAAgaruogaSUD9UUMqoHiXu6RwcgnJE--

--===============0577021231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0577021231==--
