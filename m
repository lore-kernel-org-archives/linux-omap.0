From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 05/20] mfd: atmel-hlcdc: Use devm_mfd_add_devices()
 for mfd_device registration
Date: Mon, 11 Apr 2016 10:15:39 +0100
Message-ID: <20160411091539.GS4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-6-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-6-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Boris Brezillon <boris.brezillon@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
> - Collected acks.
>=20
>  drivers/mfd/atmel-hlcdc.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mfd/atmel-hlcdc.c b/drivers/mfd/atmel-hlcdc.c
> index 06c2058..eca7ea6 100644
> --- a/drivers/mfd/atmel-hlcdc.c
> +++ b/drivers/mfd/atmel-hlcdc.c
> @@ -128,16 +128,9 @@ static int atmel_hlcdc_probe(struct platform_dev=
ice *pdev)
> =20
>  	dev_set_drvdata(dev, hlcdc);
> =20
> -	return mfd_add_devices(dev, -1, atmel_hlcdc_cells,
> -			       ARRAY_SIZE(atmel_hlcdc_cells),
> -			       NULL, 0, NULL);
> -}
> -
> -static int atmel_hlcdc_remove(struct platform_device *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> -
> -	return 0;
> +	return devm_mfd_add_devices(dev, -1, atmel_hlcdc_cells,
> +				    ARRAY_SIZE(atmel_hlcdc_cells),
> +				    NULL, 0, NULL);
>  }
> =20
>  static const struct of_device_id atmel_hlcdc_match[] =3D {
> @@ -152,7 +145,6 @@ MODULE_DEVICE_TABLE(of, atmel_hlcdc_match);
> =20
>  static struct platform_driver atmel_hlcdc_driver =3D {
>  	.probe =3D atmel_hlcdc_probe,
> -	.remove =3D atmel_hlcdc_remove,
>  	.driver =3D {
>  		.name =3D "atmel-hlcdc",
>  		.of_match_table =3D atmel_hlcdc_match,

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
