From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V5 1/6] OMAPDSS: DISPC: cleanup cpu_is_xxxx checks
Date: Tue, 21 Aug 2012 13:31:42 +0300
Message-ID: <1345545102.4085.44.camel@deskari>
References: <cover.1343912532.git.cmahapatra@ti.com>
	 <cover.1345468541.git.cmahapatra@ti.com>
	 <978118e2c23e2da40ceb740665fd19f86810b58a.1345468541.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-1EKOmOgCFTNJsn0vIvFC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48469 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756279Ab2HUKbr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 06:31:47 -0400
Received: by lbbgf7 with SMTP id gf7so4543480lbb.8
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 03:31:44 -0700 (PDT)
In-Reply-To: <978118e2c23e2da40ceb740665fd19f86810b58a.1345468541.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-1EKOmOgCFTNJsn0vIvFC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-08-20 at 18:52 +0530, Chandrabhanu Mahapatra wrote:
> All the cpu_is checks have been moved to dispc_init_features function pro=
viding
> a much more generic and cleaner interface. The OMAP version and revision
> specific functions and data are initialized by dispc_features structure w=
hich is
> local to dispc.c.
>=20
> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> ---
>  drivers/video/omap2/dss/dispc.c |  433 +++++++++++++++++++++++++--------=
------
>  1 file changed, 278 insertions(+), 155 deletions(-)
>=20
> diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/di=
spc.c
> index ff52702..3fad33a 100644
> --- a/drivers/video/omap2/dss/dispc.c
> +++ b/drivers/video/omap2/dss/dispc.c
> @@ -81,6 +81,23 @@ struct dispc_irq_stats {
>  	unsigned irqs[32];
>  };
> =20
> +struct dispc_features {
> +	int hp_max;
> +	int vp_max;
> +	int sw_max;
> +	int sw_start;
> +	int fp_start;
> +	int bp_start;

Here you could use a bit smaller datatype. u16 should probably be more
than enough.

> +static int __init dispc_init_features(struct device *dev)
> +{
> +	struct dispc_features *feat =3D devm_kzalloc(dev, sizeof(*feat),
> +								GFP_KERNEL);
> +	if (!feat) {
> +		dev_err(dev, "Failed to allocate DISPC Features\n");
> +		return -ENOMEM;
> +	}
> +
> +	if (cpu_is_omap24xx()) {
> +		memcpy(feat, &omap24xx_dispc_feats, sizeof(*feat));
> +	} else if (cpu_is_omap34xx()) {
> +		if (omap_rev() < OMAP3430_REV_ES3_0)
> +			memcpy(feat, &omap34xx_rev1_0_dispc_feats,
> +							sizeof(*feat));
> +		else
> +			memcpy(feat, &omap34xx_rev3_0_dispc_feats,
> +							sizeof(*feat));
> +	} else if (cpu_is_omap44xx()) {
> +		memcpy(feat, &omap44xx_dispc_feats, sizeof(*feat));
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	dispc.feat =3D feat;
> +
> +	return 0;
> +}

This becomes much cleaner with something like the following (same could
be used in dss.c also):

	const struct dispc_features *src;
	struct dispc_features *dst;

	dst =3D devm_kzalloc(dev, sizeof(*dst), GFP_KERNEL);
	if (!dsst) {
		dev_err(dev, "Failed to allocate DISPC Features\n");
		return -ENOMEM;
	}

	if (cpu_is_omap24xx()) {
		src =3D &omap24xx_dispc_feats;
	} else if (cpu_is_omap34xx()) {
		if (omap_rev() < OMAP3430_REV_ES3_0)
			src =3D &omap34xx_rev1_0_dispc_feats;
		else
			src =3D &omap34xx_rev3_0_dispc_feats;
	} else if (cpu_is_omap44xx()) {
		src =3D &omap44xx_dispc_feats;
	} else {
		return -ENODEV;
	}

	memcpy(dst, src, sizeof(*dst));

	dispc.feat =3D dst;

 Tomi


--=-1EKOmOgCFTNJsn0vIvFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQM2OOAAoJEPo9qoy8lh71wQQP/R5Etq9s7LJ4a/7Tb7nM0Qfr
Jp0R3mz7vh482nZuSxCIDW7MB0a+snXZCAlr9Bxyat0Lct3pwaJpXW5rE8BP0JDI
6c/MQI8n3JaOGw1/x79iKrc+lzEsotEHjGecF/J2wHpi2ivHPMdSfOeWnLYf28GN
w9dj/ud42pgwj0NQdWxT08QdHa/4vi++OCN28ufcyrM5hcpc2Yujpto1Q7wLs8MV
23ptVODrXjRYFqjHIUCTZ42MdKW9gV1c2YtG7r9cMjeYgaEWAoMW8g94y3MibEPP
Zwp6YqcEksVPXZJbG3D5+EgIgFUeISMRczyH8dLstRDbyIHVJkDwf7V47Ihlefqw
XqKkdRbik3vpaY0PDWEpwBt3fS1yvueasqS2XMSCvBqecgFxrkYK1d8otaoba6Hi
qkfH/qc2yQ23xYiFDJwceAOwPZOIb9tQBlDe5ODEhNF1vDVtWghYGs8rG9LMLaws
PQ+OAoMkAx/O02F38tnkTfYaaTpUhy17XXjTjGtQnxh4d5eG2M0X7qC28prWDc5J
TGYMOPD98//xfXvFW0qUI1ML0W0OaRnZ1yvynF0mkv3yMkYe7AQ8fDsPzOBjULnw
sHYNRPFbK4w+1uF23IgdlZ01STU9iciWLxhvnsNynYxOAV/so04w9AufnZky5+5z
kGHa3IOukVdjHyTttyFC
=Baaa
-----END PGP SIGNATURE-----

--=-1EKOmOgCFTNJsn0vIvFC--

