From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] exynos5: usb: dwc3: Add the suspend/resume
 functionality
Date: Mon, 15 Oct 2012 15:12:11 +0300
Message-ID: <20121015121211.GJ24333@arwen.pp.htv.fi>
References: <1350133825-24181-1-git-send-email-vikas.sajjan@linaro.org>
 <1350133825-24181-4-git-send-email-vikas.sajjan@linaro.org>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VIOdPewhitSMo36n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57257 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752262Ab2JOMRm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Oct 2012 08:17:42 -0400
Content-Disposition: inline
In-Reply-To: <1350133825-24181-4-git-send-email-vikas.sajjan@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, sarah.a.sharp@linux.intel.com, balbi@ti.com, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--VIOdPewhitSMo36n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 13, 2012 at 06:40:25PM +0530, Vikas Sajjan wrote:
> Adding the suspend and resume functionality to exynos dwc3 driver

better commit log.

> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Vikas C Sajjan <vikas.sajjan@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |   39 ++++++++++++++++++++++++++++++++++=
+++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exyno=
s.c
> index ca65978..2781301 100644
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
> @@ -200,11 +201,49 @@ static int __devexit dwc3_exynos_remove(struct plat=
form_device *pdev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM
> +static int dwc3_exynos_suspend(struct device *dev)
> +{
> +	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> +
> +	BUG_ON(!exynos);

drop this. It's nonsense. This will never happen and if it does
clk_disable() call will already oops for us.

> +
> +	clk_disable(exynos->clk);
> +
> +	return 0;
> +}
> +
> +static int dwc3_exynos_resume(struct device *dev)
> +{
> +	struct dwc3_exynos *exynos =3D dev_get_drvdata(dev);
> +
> +	BUG_ON(!exynos);

drop this. It's nonsense. This will never happen and if it does
clk_enable() call will already oops for us.

> +	clk_enable(exynos->clk);
> +
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

use SET_SYSTEM_SLEEP_PM_OPS()

> +};
> +#define DWC3_EXYNOS_DEV_PM_OPS  &(dwc3_exynos_pm_ops)
> +#else
> +#define DWC3_EXYNOS_DEV_PM_OPS  NULL
> +#endif /* CONFIG_PM */
> +
>  static struct platform_driver dwc3_exynos_driver =3D {
>  	.probe		=3D dwc3_exynos_probe,
>  	.remove		=3D __devexit_p(dwc3_exynos_remove),
>  	.driver		=3D {
>  		.name	=3D "exynos-dwc3",
> +		.pm =3D DWC3_EXYNOS_DEV_PM_OPS,
>  	},
>  };
> =20
> --=20
> 1.7.6.5
>=20

--=20
balbi

--VIOdPewhitSMo36n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe/2bAAoJEIaOsuA1yqREZPkQALPvX8mk2+qr2DMqIf9bFMZN
64lcKGuLznImSuMKyqxH1swMBTinB0Ym02hcR2NVs0s1Q/uFqQAp43ke8iNjB7U/
pge/9RRezVohNwB1L+o/JUBSPUCjVtupw+3Z5xeRGJctWxLfQEzaW/GDP+0LCDzx
CVGloNOo9GUHT1sI+xGlYt0zIMrfvNbfARhjk5J6ckGWJSgIkl994U5e7icqdnjj
wjLEPDDUn/ym3INSzbM/mQVqwWlqD5Vsh/xmCh2rQGp2bgtFve6h8com/Qa53Trt
hssqbYQNT2hf38tSyJfJcNXyJnoRvtB7RJBtbK86xeW6JOxbWAoLPeLJxBJw5XjZ
xibDAd2TsIjEZKFWXwAgKuPvZGBVWyCCjVaTcLtxy5pOhPeHtNz2NpxnZfyBmyr6
2/tnCvvCO5kKVM6PK4/Cr9SmInUSApEFeFIuPS8Nx5AAuM6IkRSVa7Uhy/OkGtnS
XDXvOHfj+0Ol8T6W5KuZYGb6whqfsXRnUe0o/WdOYQwDBXE+g+vqMBOQCxFdf5BI
Cpzq3bz/plDDN4ENhYNDxqbdqAYXRC5HLCDR5FFj9Zev71AqEZroGV1+YsG2j/t8
7UHMgrEX4kw2gAE25e04wVOPgNc6m71FNLcpAHpD0rMbHDRJVHQ7osYEsVHlnfC7
rOwXNuXq9g4wOhXeWNJy
=zoH2
-----END PGP SIGNATURE-----

--VIOdPewhitSMo36n--
