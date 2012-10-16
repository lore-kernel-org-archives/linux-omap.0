From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Tue, 16 Oct 2012 12:53:33 +0300
Message-ID: <20121016095333.GD5548@arwen.pp.htv.fi>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
 <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35725 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088Ab2JPJ7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 05:59:11 -0400
Content-Disposition: inline
In-Reply-To: <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautam.vivek@samsung.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, gregkh@linuxfoundation.org, balbi@ti.com, rob.herring@calxeda.com, thomas.abraham@linaro.org, kishon@ti.com, av.tikhomirov@samsung.com

--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
> This patch adds support to parse probe data for
> dwc3-exynos driver using device tree.
>=20
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exyno=
s.c
> index ca65978..d11ef49 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/usb/otg.h>
>  #include <linux/usb/nop-usb-xceiv.h>
> +#include <linux/of.h>
> =20
>  #include "core.h"
> =20
> @@ -87,6 +88,8 @@ err1:
>  	return ret;
>  }
> =20
> +static u64 dwc3_exynos_dma_mask =3D DMA_BIT_MASK(32);
> +
>  static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
>  {
>  	struct dwc3_exynos_data	*pdata =3D pdev->dev.platform_data;
> @@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct platfo=
rm_device *pdev)
>  		goto err0;
>  	}
> =20
> +	/*
> +	 * Right now device-tree probed devices don't get dma_mask set.
> +	 * Since shared usb code relies on it, set it here for now.
> +	 * Once we move to full device tree support this will vanish off.
> +	 */
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask =3D &dwc3_exynos_dma_mask;

says who ?

$ git grep -e dma_mask drivers/of/
drivers/of/platform.c:  dev->dev.dma_mask =3D &dev->archdata.dma_mask;
drivers/of/platform.c:  dev->archdata.dma_mask =3D 0xffffffffUL;
drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D ~0;
drivers/of/platform.c:  dev->dma_mask =3D ~0;

-ECONFUSED

--=20
balbi

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfS6dAAoJEIaOsuA1yqREU70P/31FAZR+jlHuqevWMhskUVtz
Wrs1kWYn6K/CaHc+H5xLhUuw7OUnWogPngbbu4WbMhS4h/nTPnlOhzdDenz24ZlR
3pzIYDivgCHVWT3LjTBumsjIqiflH4CrhcTaLbvw1wLVg+H6qmxfefvIUYMvUxl6
b//ZlHRhr4Rzu9dLy0o4VbFMG8YHwIZf3mNOzELlCWYq1Z23ottTvoFgd4876lac
qpqwDwX1RnS61wZ+zZ4b6FLWrHzUJSfjnKTEcvIAyZrawYVChnozXP1KWRCkz9pw
6NqOZ9jxtRKvTXxYGy08QQSqp4AWn2n1uqyc3x7pmYxTGoDRNiJl1vemoBGPTNgv
mIP0RS7Eghg7ChP5PWszekRBdstzpGPyYuew5KxnKSr2NOCjY1vKz+7bijKPXRho
DUOFpAqinhsfkgRs4Zsn0UgndZvbpZNcbujIQcw6dyzukKHp2mzRF6tBLIFUd5dB
d2gR836olwVIIzh7FgMxJb0psywzDCmLYEz0HWyuJDVyfgn8d7e+K/7SPPNuPkK8
p9FIlXoEezttKlqRxDKuUKKcoWoAZchTDoZVC2+m62/B8BX0+q8FvV1iE2zxrYtn
X5ieAzE7PBW07uKPziFs/pcKTSK+UrAu6Tytd3Vz0qimMPEn2IUkJsn3WkG1J3uQ
2H0dQKIysYnPlN4Iv8sN
=jtd/
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
