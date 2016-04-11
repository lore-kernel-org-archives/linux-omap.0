From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 07/20] mfd: hi6421-pmic: Use devm_mfd_add_devices()
 for mfd_device registration
Date: Mon, 11 Apr 2016 10:15:54 +0100
Message-ID: <20160411091554.GU4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-8-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-8-git-send-email-ldewangan@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, Guodong Xu <guodong.xu@linaro.org>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: Guodong Xu <guodong.xu@linaro.org>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Run checkpatch with --strict option and fix warning.
>=20
>  drivers/mfd/hi6421-pmic-core.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic=
-core.c
> index f9ded45..3fd703f 100644
> --- a/drivers/mfd/hi6421-pmic-core.c
> +++ b/drivers/mfd/hi6421-pmic-core.c
> @@ -76,8 +76,8 @@ static int hi6421_pmic_probe(struct platform_device=
 *pdev)
> =20
>  	platform_set_drvdata(pdev, pmic);
> =20
> -	ret =3D mfd_add_devices(&pdev->dev, 0, hi6421_devs,
> -			ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
> +	ret =3D devm_mfd_add_devices(&pdev->dev, 0, hi6421_devs,
> +				   ARRAY_SIZE(hi6421_devs), NULL, 0, NULL);
>  	if (ret) {
>  		dev_err(&pdev->dev, "add mfd devices failed: %d\n", ret);
>  		return ret;
> @@ -86,13 +86,6 @@ static int hi6421_pmic_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static int hi6421_pmic_remove(struct platform_device *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id of_hi6421_pmic_match_tbl[] =3D {
>  	{ .compatible =3D "hisilicon,hi6421-pmic", },
>  	{ },
> @@ -105,7 +98,6 @@ static struct platform_driver hi6421_pmic_driver =3D=
 {
>  		.of_match_table =3D of_hi6421_pmic_match_tbl,
>  	},
>  	.probe	=3D hi6421_pmic_probe,
> -	.remove	=3D hi6421_pmic_remove,
>  };
>  module_platform_driver(hi6421_pmic_driver);
> =20

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
