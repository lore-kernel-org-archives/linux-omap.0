From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Fri, 26 Oct 2012 11:13:44 +0300
Message-ID: <20121026081344.GC23501@arwen.pp.htv.fi>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
 <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
 <20121016095333.GD5548@arwen.pp.htv.fi>
 <507D31B3.40707@ti.com>
 <20121016100838.GC17416@arwen.pp.htv.fi>
 <CAFp+6iG1SuJ=wO61=D_pTdRzkM+t62mN3b7=3cZiom8tigyaBQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47341 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757043Ab2JZITj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 04:19:39 -0400
Content-Disposition: inline
In-Reply-To: <CAFp+6iG1SuJ=wO61=D_pTdRzkM+t62mN3b7=3cZiom8tigyaBQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vivek Gautam <gautamvivek1987@gmail.com>
Cc: balbi@ti.com, rob.herring@calxeda.com, kishon <kishon@ti.com>, av.tikhomirov@samsung.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

--p2kqVDKq5asng8Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 25, 2012 at 11:37:33AM +0530, Vivek Gautam wrote:
> Hi,
>=20
> On Tue, Oct 16, 2012 at 3:38 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Tue, Oct 16, 2012 at 03:36:43PM +0530, kishon wrote:
> >> Hi,
> >>
> >> On Tuesday 16 October 2012 03:23 PM, Felipe Balbi wrote:
> >> >On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
> >> >>This patch adds support to parse probe data for
> >> >>dwc3-exynos driver using device tree.
> >> >>
> >> >>Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> >> >>---
> >> >>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
> >> >>  1 files changed, 20 insertions(+), 0 deletions(-)
> >> >>
> >> >>diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-=
exynos.c
> >> >>index ca65978..d11ef49 100644
> >> >>--- a/drivers/usb/dwc3/dwc3-exynos.c
> >> >>+++ b/drivers/usb/dwc3/dwc3-exynos.c
> >> >>@@ -21,6 +21,7 @@
> >> >>  #include <linux/clk.h>
> >> >>  #include <linux/usb/otg.h>
> >> >>  #include <linux/usb/nop-usb-xceiv.h>
> >> >>+#include <linux/of.h>
> >> >>
> >> >>  #include "core.h"
> >> >>
> >> >>@@ -87,6 +88,8 @@ err1:
> >> >>    return ret;
> >> >>  }
> >> >>
> >> >>+static u64 dwc3_exynos_dma_mask =3D DMA_BIT_MASK(32);
> >> >>+
> >> >>  static int __devinit dwc3_exynos_probe(struct platform_device *pde=
v)
> >> >>  {
> >> >>    struct dwc3_exynos_data *pdata =3D pdev->dev.platform_data;
> >> >>@@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct p=
latform_device *pdev)
> >> >>            goto err0;
> >> >>    }
> >> >>
> >> >>+   /*
> >> >>+    * Right now device-tree probed devices don't get dma_mask set.
> >> >>+    * Since shared usb code relies on it, set it here for now.
> >> >>+    * Once we move to full device tree support this will vanish off.
> >> >>+    */
> >> >>+   if (!pdev->dev.dma_mask)
> >> >>+           pdev->dev.dma_mask =3D &dwc3_exynos_dma_mask;
> >> >
> >> >says who ?
> >> >
> >> >$ git grep -e dma_mask drivers/of/
> >> >drivers/of/platform.c:  dev->dev.dma_mask =3D &dev->archdata.dma_mask;
> >> >drivers/of/platform.c:  dev->archdata.dma_mask =3D 0xffffffffUL;
> >> >drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D DMA_BIT_MASK(3=
2);
> >> >drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D ~0;
> >> >drivers/of/platform.c:  dev->dma_mask =3D ~0;
> >> >
> >> >-ECONFUSED
> >>
> >> dma_mask is set under some ifdef except for "dev->dma_mask =3D ~0;".
> >> However I agree with you for coherent_dma_mask case.
> >
> > indeed. Should we try to patch that instead ?
> >
> > Rob, should we set dma_mask at the driver or do you have a nicer way to
> > handle it ??
> >
> Can i have suggestions here please ? :)

Benoit, can you answer here since nobody else does ?

--=20
balbi

--p2kqVDKq5asng8Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQikY4AAoJEIaOsuA1yqRE4wAP/044T3PSq6IngMPWVDxeg0o+
DsZ75BKHs0krnjQlCWBSAa+M9FLGJfo6smbiXVuCGE2ldiw7kH4+oOT7MTQdYDSu
BEm4A2eTN0ycXw7WaXSqn9mcCdb/Xv4W+t8BH7P9cthqPGjfW7Koz/lQrgPLlKyl
rRGiFI13q9pabpeUSqD6sG5SwBh2tv9v8odD9PZwwKzIsU2lyTsEg4Dya3Zw+5FD
6bsWiflhPZxAgMzIVunjWPmL85oPlySXlJiRP95zmg8926RbNy2xPculvSNGrl54
nfv2aw89iavfaakJjzsfVdJpgMukmrNXKCN03uJJ2i43fVwLS3p3How6AjLxY8P4
e7QgC4wmP+I1/ZGZwYYPz+uf8B27UqGCCdNEfpgyOhZMBQHbGuOZ3xLqk0VH5lGb
lJ2pUGBb3AkV01Cb8Z8tH1tWrliBZrAtOXhD/RQzq1PSCItIwD3lbzWBOF0e8ufa
eCVlVwFKangVH1e7fxXGzn54r85lEPWrSnGdJu4o3V43nUo8VmMPdZ36mKwZ+kQw
Hk4YR0xq0GEiwHEZrOBIWuTuwv4pQDnN78S1ZOxlhDOhxcpHD1n6QIvFcXAw3fit
T34Izqee9GejygkfdOELsuP1Byih4iQX+hQPcCezpITnuThSyI/GXelbxWCNLvfa
lPdALfErp9aZqW9smHe8
=svbj
-----END PGP SIGNATURE-----

--p2kqVDKq5asng8Dg--
