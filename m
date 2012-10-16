From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Tue, 16 Oct 2012 13:08:38 +0300
Message-ID: <20121016100838.GC17416@arwen.pp.htv.fi>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
 <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
 <20121016095333.GD5548@arwen.pp.htv.fi>
 <507D31B3.40707@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <507D31B3.40707-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon <kishon-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, av.tikhomirov-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 16, 2012 at 03:36:43PM +0530, kishon wrote:
> Hi,
>=20
> On Tuesday 16 October 2012 03:23 PM, Felipe Balbi wrote:
> >On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
> >>This patch adds support to parse probe data for
> >>dwc3-exynos driver using device tree.
> >>
> >>Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>---
> >>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
> >>  1 files changed, 20 insertions(+), 0 deletions(-)
> >>
> >>diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exy=
nos.c
> >>index ca65978..d11ef49 100644
> >>--- a/drivers/usb/dwc3/dwc3-exynos.c
> >>+++ b/drivers/usb/dwc3/dwc3-exynos.c
> >>@@ -21,6 +21,7 @@
> >>  #include <linux/clk.h>
> >>  #include <linux/usb/otg.h>
> >>  #include <linux/usb/nop-usb-xceiv.h>
> >>+#include <linux/of.h>
> >>
> >>  #include "core.h"
> >>
> >>@@ -87,6 +88,8 @@ err1:
> >>  	return ret;
> >>  }
> >>
> >>+static u64 dwc3_exynos_dma_mask =3D DMA_BIT_MASK(32);
> >>+
> >>  static int __devinit dwc3_exynos_probe(struct platform_device *pdev)
> >>  {
> >>  	struct dwc3_exynos_data	*pdata =3D pdev->dev.platform_data;
> >>@@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct plat=
form_device *pdev)
> >>  		goto err0;
> >>  	}
> >>
> >>+	/*
> >>+	 * Right now device-tree probed devices don't get dma_mask set.
> >>+	 * Since shared usb code relies on it, set it here for now.
> >>+	 * Once we move to full device tree support this will vanish off.
> >>+	 */
> >>+	if (!pdev->dev.dma_mask)
> >>+		pdev->dev.dma_mask =3D &dwc3_exynos_dma_mask;
> >
> >says who ?
> >
> >$ git grep -e dma_mask drivers/of/
> >drivers/of/platform.c:  dev->dev.dma_mask =3D &dev->archdata.dma_mask;
> >drivers/of/platform.c:  dev->archdata.dma_mask =3D 0xffffffffUL;
> >drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(32);
> >drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D ~0;
> >drivers/of/platform.c:  dev->dma_mask =3D ~0;
> >
> >-ECONFUSED
>=20
> dma_mask is set under some ifdef except for "dev->dma_mask =3D ~0;".
> However I agree with you for coherent_dma_mask case.

indeed. Should we try to patch that instead ?

Rob, should we set dma_mask at the driver or do you have a nicer way to
handle it ??

--=20
balbi

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfTImAAoJEIaOsuA1yqREGKEP/inZygOWPAdhgJ82VDonjvW1
LIVYlyuEtVoIAfF+ViXePS+k0UcNloTIX/vBlfTxOMIxVgaPLHagqDC3FSydXdjN
jJjCV7XoNXiXV8eMW/lZPKP1pCq8HCtVClq2YnYq5guCiOjP42PGW7rCnTPmupzF
6vVtIWngYulTWTADlir+SmGfNQrTVx6cP3AT+QXdRGZ8BL7J7b4cU1wQrteHDnCO
dSpcNVMFl+uHwqHiFH/AoC0nOyl3OaZ4RWiSUbPupLY/MaaIj64qDlICQHOhqr95
H7iGJ0aL+5wsbZcqnBinIVD93ZIFyGxAulzgCOdcg/qRMQxjgKxOG8aoVHcELtV8
kv3wiudy0HqKD1vmIxdK8NLT324gKRbBR8chVJbhcHuxy/7Pt1NYNYKOjKseZOtw
3RxBVw4lJ0peLvYN1u0ub+sgJr+iWtL6po6oa4gfUrBFpVEe47l9B6zzlwg8q10o
YFbBKBDFTpVIF+Mf3Il6MZ2IzEU7ZxdyN3XniY/QC2N4582zBBe9qBZvLhxHwDCW
dhh/yvu2hFuDoq5nZTRRUtXdd279fz3C6d3m3A91cLwijxtNbFIwwKcAqXvGj/cv
1PQXvSRofs+NUT/YLuzCIMsna7i4Lh/K5YHjgY0xsbUDyoanbeth+x548iy0Rx6z
P1z0OU4r2lqxqE151PKR
=PXBs
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
