From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 04/16] mtd: onenand: omap2: Remove regulator support
Date: Wed, 15 Nov 2017 15:15:31 +0100
Message-ID: <20171115141531.snx7dlmtuxzvvxgr@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111211908.66xd2bw4xoeudz7g@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5013821807778910886=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111211908.66xd2bw4xoeudz7g@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============5013821807778910886==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgoclgvfroywcoxe"
Content-Disposition: inline


--sgoclgvfroywcoxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:19:08PM +0100, Ladislav Michl wrote:
> As no platform data user sets regulator_can_sleep, regulator code is
> no-op and can be deleted.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Changes:
>  -v2: new patch
>  -v3: none
>  -v4: none
>=20
>  drivers/mtd/onenand/omap2.c | 42 +--------------------------------------=
---
>  1 file changed, 1 insertion(+), 41 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 24a1388d3031..a03e1fe4aa48 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -34,7 +34,6 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/gpio.h>
> =20
>  #include <asm/mach/flash.h>
> @@ -59,7 +58,6 @@ struct omap2_onenand {
>  	int dma_channel;
>  	int freq;
>  	int (*setup)(void __iomem *base, int *freq_ptr);
> -	struct regulator *regulator;
>  	u8 flags;
>  };
> =20
> @@ -583,30 +581,6 @@ static void omap2_onenand_shutdown(struct platform_d=
evice *pdev)
>  	memset((__force void *)c->onenand.base, 0, ONENAND_BUFRAM_SIZE);
>  }
> =20
> -static int omap2_onenand_enable(struct mtd_info *mtd)
> -{
> -	int ret;
> -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
> -
> -	ret =3D regulator_enable(c->regulator);
> -	if (ret !=3D 0)
> -		dev_err(&c->pdev->dev, "can't enable regulator\n");
> -
> -	return ret;
> -}
> -
> -static int omap2_onenand_disable(struct mtd_info *mtd)
> -{
> -	int ret;
> -	struct omap2_onenand *c =3D container_of(mtd, struct omap2_onenand, mtd=
);
> -
> -	ret =3D regulator_disable(c->regulator);
> -	if (ret !=3D 0)
> -		dev_err(&c->pdev->dev, "can't disable regulator\n");
> -
> -	return ret;
> -}
> -
>  static int omap2_onenand_probe(struct platform_device *pdev)
>  {
>  	struct omap_onenand_platform_data *pdata;
> @@ -726,22 +700,11 @@ static int omap2_onenand_probe(struct platform_devi=
ce *pdev)
>  		}
>  	}
> =20
> -	if (pdata->regulator_can_sleep) {
> -		c->regulator =3D regulator_get(&pdev->dev, "vonenand");
> -		if (IS_ERR(c->regulator)) {
> -			dev_err(&pdev->dev,  "Failed to get regulator\n");
> -			r =3D PTR_ERR(c->regulator);
> -			goto err_release_dma;
> -		}
> -		c->onenand.enable =3D omap2_onenand_enable;
> -		c->onenand.disable =3D omap2_onenand_disable;
> -	}
> -
>  	if (pdata->skip_initial_unlocking)
>  		this->options |=3D ONENAND_SKIP_INITIAL_UNLOCKING;
> =20
>  	if ((r =3D onenand_scan(&c->mtd, 1)) < 0)
> -		goto err_release_regulator;
> +		goto err_release_dma;
> =20
>  	r =3D mtd_device_register(&c->mtd, pdata ? pdata->parts : NULL,
>  				pdata ? pdata->nr_parts : 0);
> @@ -754,8 +717,6 @@ static int omap2_onenand_probe(struct platform_device=
 *pdev)
> =20
>  err_release_onenand:
>  	onenand_release(&c->mtd);
> -err_release_regulator:
> -	regulator_put(c->regulator);
>  err_release_dma:
>  	if (c->dma_channel !=3D -1)
>  		omap_free_dma(c->dma_channel);
> @@ -779,7 +740,6 @@ static int omap2_onenand_remove(struct platform_devic=
e *pdev)
>  	struct omap2_onenand *c =3D dev_get_drvdata(&pdev->dev);
> =20
>  	onenand_release(&c->mtd);
> -	regulator_put(c->regulator);
>  	if (c->dma_channel !=3D -1)
>  		omap_free_dma(c->dma_channel);
>  	omap2_onenand_shutdown(pdev);
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--sgoclgvfroywcoxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMS/8ACgkQ2O7X88g7
+prMvRAAloGGuoswk4Dyo0XpqgGm/TGja18K8VQj0VdRb4O4K7rl6zhLQlHilLOu
gQVY12ox65AMEz0Sq9x4bYQlV3nM1APmIsBpPA9OLsG0a0p9R2fnpO6FLt01kg8G
6p8iueYsk+BAToYWtrwVQR+hIeIi7v9lcZPd9PUkOOHbj3j0MVqWn+cvzmcAzdTR
b9P8LiCWCcLV/JU8fEbpOCb4d5pswRIa5pr9hSDFiZ/u3vOiyplDLsZRXuI2oYIF
ze+CPHvpivQOsVf2ipkcXlc4ktJ5J6mzRS8w45/1DQK3Pw5qcnZEvOck8lpJaB31
imK7dKxCWoPLqD75LQomSsxjv4Ds0fIjCd0tOmz9cyQ8wDvJjUEl92uFDdomSJ0L
X0AXUzKQbTEtwbKjdiZL9qsmBikcX6isYVzzdAnbbmF8hJjFWjTnuH0misIuxlzR
sksG4RAhEvn2Om2Krryl+uLRxhNgyMeZ/X0Ep9MX9jhBXYKFJHGRVwXeZTUNpbQ5
+ob9V6xHYp8F5WrHUCYyxiF7WmECiJs2KfgOVxrjI3++1eIUwPZ8EOY7KuU4m0G5
if9cdV2w1h4JM+OJReEwIUbosXrdMAOfYCVyBTuXmoVpOBPTp1ro7kOz8hlbSqoU
jytLBNuI4nc077oolq5t2K1Nr+jg5kSwphWXuiFA7ViYxhRMNpQ=
=SZ3B
-----END PGP SIGNATURE-----

--sgoclgvfroywcoxe--


--===============5013821807778910886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============5013821807778910886==--
