From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 10/20] mfd: mt6397: Use devm_mfd_add_devices() for
 mfd_device registration
Date: Mon, 11 Apr 2016 10:31:11 +0100
Message-ID: <20160411093111.GA7994@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-11-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-11-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com, John Crispin <blogic@openwrt.org>, Javier Martinez Canillas <javier@osg.samsung.com>
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

On Fri, 08 Apr 2016, Laxman Dewangan wrote:

> Use devm_mfd_add_devices() for MFD devices registration and get
> rid of .remove callback to remove MFD child-devices. This is done
> by managed device framework.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> CC: John Crispin <blogic@openwrt.org>
> CC: Javier Martinez Canillas <javier@osg.samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
>=20
> ---
> Changes from V1:
> - Convert mfd to MFD.
> - Collected reviewed by.
>=20
>  drivers/mfd/mt6397-core.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> index 8e8d932..5a3ffa3 100644
> --- a/drivers/mfd/mt6397-core.c
> +++ b/drivers/mfd/mt6397-core.c
> @@ -276,8 +276,9 @@ static int mt6397_probe(struct platform_device *p=
dev)
>  		pmic->int_con[1] =3D MT6323_INT_CON1;
>  		pmic->int_status[0] =3D MT6323_INT_STATUS0;
>  		pmic->int_status[1] =3D MT6323_INT_STATUS1;
> -		ret =3D mfd_add_devices(&pdev->dev, -1, mt6323_devs,
> -				ARRAY_SIZE(mt6323_devs), NULL, 0, NULL);
> +		ret =3D devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
> +					   ARRAY_SIZE(mt6323_devs), NULL,
> +					   0, NULL);
>  		break;
> =20
>  	case MT6397_CID_CODE:
> @@ -286,8 +287,9 @@ static int mt6397_probe(struct platform_device *p=
dev)
>  		pmic->int_con[1] =3D MT6397_INT_CON1;
>  		pmic->int_status[0] =3D MT6397_INT_STATUS0;
>  		pmic->int_status[1] =3D MT6397_INT_STATUS1;
> -		ret =3D mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> -				ARRAY_SIZE(mt6397_devs), NULL, 0, NULL);
> +		ret =3D devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> +					   ARRAY_SIZE(mt6397_devs), NULL,
> +					   0, NULL);
>  		break;
> =20
>  	default:
> @@ -312,13 +314,6 @@ fail_irq:
>  	return ret;
>  }
> =20
> -static int mt6397_remove(struct platform_device *pdev)
> -{
> -	mfd_remove_devices(&pdev->dev);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id mt6397_of_match[] =3D {
>  	{ .compatible =3D "mediatek,mt6397" },
>  	{ .compatible =3D "mediatek,mt6323" },
> @@ -334,7 +329,6 @@ MODULE_DEVICE_TABLE(platform, mt6397_id);
> =20
>  static struct platform_driver mt6397_driver =3D {
>  	.probe =3D mt6397_probe,
> -	.remove =3D mt6397_remove,
>  	.driver =3D {
>  		.name =3D "mt6397",
>  		.of_match_table =3D of_match_ptr(mt6397_of_match),

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
