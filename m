From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 3/3] exynos5: usb: dwc3: Add the suspend/resume
 functionality
Date: Thu, 11 Oct 2012 10:39:05 +0300
Message-ID: <20121011073905.GH10030@arwen.pp.htv.fi>
References: <1349877949-18872-1-git-send-email-vikas.sajjan@linaro.org>
 <1349877949-18872-4-git-send-email-vikas.sajjan@linaro.org>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:33584 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758088Ab2JKHo2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Oct 2012 03:44:28 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so1071120lbo.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Oct 2012 00:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1349877949-18872-4-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas C Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>


--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 10, 2012 at 07:35:49PM +0530, Vikas C Sajjan wrote:
> From: Vikas Sajjan <vikas.sajjan@linaro.org>
>=20
> Adding the suspend and resume functionality to exynos dwc3 driver
>=20
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |   60 ++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exyno=
s.c
> index ca65978..1154cee 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dwc3-exynos.h>
>  #include <linux/dma-mapping.h>
> @@ -200,11 +201,70 @@ static int __devexit dwc3_exynos_remove(struct plat=
form_device *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int dwc3_exynos_suspend(struct device *dev)
> +{
> +	struct dwc3_exynos_data	*pdata =3D dev->platform_data;
> +	struct dwc3_exynos	*exynos;
> +	struct platform_device *pdev =3D to_platform_device(dev);

you shouldn't have to access platform device here.

> +
> +	exynos =3D dev_get_drvdata(dev);
> +
> +	if (!exynos)
> +		return -EINVAL;

this shouldn't ever be the case and if it is, it deserves the Oops.

> +
> +	if (pdata && pdata->phy_exit)
> +		pdata->phy_exit(pdev, pdata->phy_type);

NAK, you should introduce a proper PHY driver and handle PHY suspend
generically in dwc3/core.c

> +	clk_disable(exynos->clk);
> +
> +	return 0;
> +}
> +
> +static int dwc3_exynos_resume(struct device *dev)
> +{
> +	struct dwc3_exynos_data	*pdata =3D dev->platform_data;
> +	struct dwc3_exynos	*exynos;
> +	struct platform_device *pdev =3D to_platform_device(dev);

ditto

> +	exynos =3D dev_get_drvdata(dev);
> +
> +	if (!exynos)
> +		return -EINVAL;

ditto

> +	clk_enable(exynos->clk);
> +
> +	/* PHY initialization */
> +	if (!pdata) {
> +		dev_dbg(&pdev->dev, "missing platform data\n");
> +	} else {
> +		if (pdata->phy_init)
> +			pdata->phy_init(pdev, pdata->phy_type);
> +	}

missing PHY driver

> +	/* runtime set active to reflect active state. */
> +	pm_runtime_disable(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops dwc3_exynos_pm_ops =3D {
> +	.suspend		=3D dwc3_exynos_suspend,
> +	.resume			=3D dwc3_exynos_resume,
> +};

right here you should:

#define DWC3_EXYNOS_DEV_PM_OPS	&(dwc3_exynos_pm_ops)
#else
#define DWC3_EXYNOS_DEV_PM_OPS	NULL

> +#endif /* CONFIG_PM */
> +
>  static struct platform_driver dwc3_exynos_driver =3D {
>  	.probe		=3D dwc3_exynos_probe,
>  	.remove		=3D __devexit_p(dwc3_exynos_remove),
>  	.driver		=3D {
>  		.name	=3D "exynos-dwc3",
> +#ifdef CONFIG_PM
> +		.pm =3D &dwc3_exynos_pm_ops,

		.pm =3D DWC3_EXYNOS_DEV_PM_OPS,

> +#endif

avoid the ifdeferry all over, see above.

--=20
balbi

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdneZAAoJEIaOsuA1yqREqj4QALBvEc9KHiRmWovnsxi8Vq1S
aiC3Ghe9XZswr0HoZD6MQ2iUtTutZsnyV5UmeUDk56zZJ5EWo6NCoXHIkk+p9ogE
mh+7Hkx/ATxj/jZUYWY7Z5SRIqAmyB5Hnuit1pNWbhzwSZgdSji22AgaNZ7ZHLUg
QfuH7S/Mf/tmrUYPUZRrESQylp2Jx/JBtewoIZbqzwGvgygWHo6XukJXBSGVgtXe
aiTZVo7b582eJD8GKkjfBlYMqKMaTZSjtfSBZjMbLDxV4fQYpAagvwgP4n0oGtMi
OLDl22BdNzf7cDT9GCokIx9MPFrpd3DbeOT6vx9uI15c2Vz2XN2mYOEaqCn+9h3J
RmVDKmhwytgGKwR/WDsrX6io6itJqv4UH8T9HDMC1eMb/tbDJsAfBPwcceEjLckO
3Ka1r89RFjQcX1l7skcr/qgU+2+OG8jN4gXQo0ZnUVJP7fG8PJieRZ91JYMvkJGI
KtUy7f9a5S7H0Ht8xVOWrv8sdicQ4arsESmC0Pe6BVxaxcwCBGEYqeUeGW5B1OaD
gOfoRzjL8sTXXiKMhoeDmETn2U3RD49/Ou36raGeL9YgitTprmikpZwOPn/YLduH
IVT5qsRnf5DzqsuNP+w9v479yVv1KxcgNPotcg8BoI3UoZVq/d3a4mjUGkZ3vrEs
hjkrFHWGnBRpbH2JM82Y
=+spw
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--
