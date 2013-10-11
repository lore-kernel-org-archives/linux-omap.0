From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v8 6/6] mtd: nand: omap: updated devm_xx for all resource
 allocation and free calls
Date: Fri, 11 Oct 2013 10:56:09 -0500
Message-ID: <20131011155609.GU25706@radagast>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <1381498603-15715-7-git-send-email-pekon@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YnIutncTLXsDZs5t"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55822 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758419Ab3JKP47 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Oct 2013 11:56:59 -0400
Content-Disposition: inline
In-Reply-To: <1381498603-15715-7-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: mark.rutland@arm.com, robherring2@gmail.com, olof@lixom.net, computersforpeace@gmail.com, dedekind1@gmail.com, Pawel.Moll@arm.com, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, bcousson@baylibre.com, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

--YnIutncTLXsDZs5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2013 at 07:06:43PM +0530, Pekon Gupta wrote:
> "Managed Device Resource" or devm_xx calls takes care of automatic freeing
> of the resource in case of:
> - failure during driver probe
> - failure during resource allocation
> - detaching or unloading of driver module (rmmod)
> Reference: Documentation/driver-model/devres.txt
>=20
> Though OMAP NAND driver handles freeing of resource allocation in most of
> the cases, but using devm_xx provides more clean and effortless approach
> to handle all such cases.
>=20
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/mtd/nand/omap2.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
> index a783dae..0f2b0d1 100644
> --- a/drivers/mtd/nand/omap2.c
> +++ b/drivers/mtd/nand/omap2.c
> @@ -1658,7 +1658,8 @@ static int omap_nand_probe(struct platform_device *=
pdev)
>  		return -ENODEV;
>  	}
> =20
> -	info =3D kzalloc(sizeof(struct omap_nand_info), GFP_KERNEL);
> +	info =3D devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
> +				GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
> =20
> @@ -1690,13 +1691,14 @@ static int omap_nand_probe(struct platform_device=
 *pdev)
>  	info->phys_base =3D res->start;
>  	info->mem_size =3D resource_size(res);
> =20
> -	if (!request_mem_region(info->phys_base, info->mem_size,
> -				pdev->dev.driver->name)) {
> +	if (!devm_request_mem_region(&pdev->dev, info->phys_base,
> +				info->mem_size,	pdev->dev.driver->name)) {
>  		err =3D -EBUSY;
>  		goto out_free_info;
>  	}
> =20
> -	info->nand.IO_ADDR_R =3D ioremap(info->phys_base, info->mem_size);
> +	info->nand.IO_ADDR_R =3D devm_ioremap(&pdev->dev, info->phys_base,
> +						info->mem_size);
>  	if (!info->nand.IO_ADDR_R) {
>  		err =3D -ENOMEM;
>  		goto out_release_mem_region;
> @@ -1799,8 +1801,9 @@ static int omap_nand_probe(struct platform_device *=
pdev)
>  			err =3D -ENODEV;
>  			goto out_release_mem_region;
>  		}
> -		err =3D request_irq(info->gpmc_irq_fifo,	omap_nand_irq,
> -					IRQF_SHARED, "gpmc-nand-fifo", info);
> +		err =3D devm_request_irq(&pdev->dev, info->gpmc_irq_fifo,
> +					omap_nand_irq, IRQF_SHARED,
> +					"gpmc-nand-fifo", info);
>  		if (err) {
>  			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
>  						info->gpmc_irq_fifo, err);
> @@ -1814,8 +1817,9 @@ static int omap_nand_probe(struct platform_device *=
pdev)
>  			err =3D -ENODEV;
>  			goto out_release_mem_region;
>  		}
> -		err =3D request_irq(info->gpmc_irq_count,	omap_nand_irq,
> -					IRQF_SHARED, "gpmc-nand-count", info);
> +		err =3D devm_request_irq(&pdev->dev, info->gpmc_irq_count,
> +					omap_nand_irq, IRQF_SHARED,
> +					"gpmc-nand-count", info);
>  		if (err) {
>  			dev_err(&pdev->dev, "requesting irq(%d) error:%d",
>  						info->gpmc_irq_count, err);
> @@ -2031,10 +2035,10 @@ out_release_mem_region:
>  	if (info->dma)
>  		dma_release_channel(info->dma);
>  	if (info->gpmc_irq_count > 0)
> -		free_irq(info->gpmc_irq_count, info);
> +		devm_free_irq(&pdev->dev, info->gpmc_irq_count, info);
>  	if (info->gpmc_irq_fifo > 0)
> -		free_irq(info->gpmc_irq_fifo, info);
> -	release_mem_region(info->phys_base, info->mem_size);
> +		devm_free_irq(&pdev->dev, info->gpmc_irq_fifo, info);
> +	devm_release_mem_region(&pdev->dev, info->phys_base, info->mem_size);
>  out_free_info:
>  #ifdef CONFIG_MTD_NAND_ECC_BCH
>  	if (info->nand.ecc.priv) {
> @@ -2042,7 +2046,7 @@ out_free_info:
>  		info->nand.ecc.priv =3D NULL;
>  	}
>  #endif
> -	kfree(info);
> +	devm_kfree(&pdev->dev, info);
> =20
>  	return err;
>  }
> @@ -2062,15 +2066,15 @@ static int omap_nand_remove(struct platform_devic=
e *pdev)
>  		dma_release_channel(info->dma);
> =20
>  	if (info->gpmc_irq_count > 0)
> -		free_irq(info->gpmc_irq_count, info);
> +		devm_free_irq(&pdev->dev, info->gpmc_irq_count, info);
>  	if (info->gpmc_irq_fifo > 0)
> -		free_irq(info->gpmc_irq_fifo, info);
> +		devm_free_irq(&pdev->dev, info->gpmc_irq_fifo, info);
> =20
>  	/* Release NAND device, its internal structures and partitions */
>  	nand_release(&info->mtd);
> -	iounmap(info->nand.IO_ADDR_R);
> -	release_mem_region(info->phys_base, info->mem_size);
> -	kfree(info);
> +	devm_iounmap(&pdev->dev, info->nand.IO_ADDR_R);
> +	devm_release_mem_region(&pdev->dev, info->phys_base, info->mem_size);
> +	devm_kfree(&pdev->dev, info);
>  	return 0;
>  }
> =20
> --=20
> 1.8.1
>=20

--=20
balbi

--YnIutncTLXsDZs5t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSWB+ZAAoJEIaOsuA1yqREMLkP/RU2kavLOfnd5ZfNMD56SXKu
Xn0obNtBQ9PAEPtFGRMG62wp+r3vibso+T0Fzp9w/M25ERLyQD9jj3UqSz/5meaf
GSzJ8k011REGgaBwV+AeH6R/msvo21QVg0U16mJWuraqSW/cJjFy2n45TmO+6a3F
r76muttfpbyeWcTJ0DJLLPzBGwsYOofAKdKilmMzHrqHq9FaN7HAnzJ9OttqlyXp
mOSmlb5XJRWw8GXcfdKG0Nqt7em7hWh9DxAjplm4cYJUualRvt7ygCyAeUijr9L3
Kx1QZOSKpoIGQ5KY2/JWa2HOAb1E3m9Qo+Rkpgo6enadm8Tj78a2XvsTQJ73EypA
ipvYuPY3fSMqnqs8GQPDkZBze9jTrFVcy7cN7AcD3fo2itWltxnPGgOpZ/9uPwFr
lqcOMvcDN/RbOmU7bJbTq2F9DelbB91UZFDw+n7NJ/6skfh7OodlCga5yc86ycVY
esQFX2/XLWt1ucL7hqXaSLNxGWeuMKXaMWa8DVK8xA91EDZTZyhgx8Wy5Mw9tCsW
VaybIqXTYkEXEdgPkkWF93Q8hsz5X6Hxv+tWCoCyZNZSbW1Ls6X09LG0BN0nlyKx
9EI5UnwTh2Le+eIahKX4aLdsDiky78iLFJsi/OOUZGhnwOi7O4sEwmcHvAOwCiDI
FU0UWG0m86qtpVQM/kp/
=FcJP
-----END PGP SIGNATURE-----

--YnIutncTLXsDZs5t--
