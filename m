From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/2] USB: dwc3-exynos: Add support for device tree
Date: Fri, 26 Oct 2012 15:01:09 +0300
Message-ID: <20121026120109.GC26342@arwen.pp.htv.fi>
References: <1350377157-28465-1-git-send-email-gautam.vivek@samsung.com>
 <1350377157-28465-2-git-send-email-gautam.vivek@samsung.com>
 <20121016095333.GD5548@arwen.pp.htv.fi>
 <507D31B3.40707@ti.com>
 <20121016100838.GC17416@arwen.pp.htv.fi>
 <CAFp+6iG1SuJ=wO61=D_pTdRzkM+t62mN3b7=3cZiom8tigyaBQ@mail.gmail.com>
 <20121026081344.GC23501@arwen.pp.htv.fi>
 <508A77A6.3080402@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41404 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932469Ab2JZMHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 08:07:03 -0400
Content-Disposition: inline
In-Reply-To: <508A77A6.3080402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: balbi@ti.com, Vivek Gautam <gautamvivek1987@gmail.com>, rob.herring@calxeda.com, kishon <kishon@ti.com>, av.tikhomirov@samsung.com, gregkh@linuxfoundation.org, devicetree-discuss@lists.ozlabs.org, linux-usb@vger.kernel.org, Vivek Gautam <gautam.vivek@samsung.com>, linux-omap@vger.kernel.org

--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 26, 2012 at 01:44:38PM +0200, Benoit Cousson wrote:
> Hi Felipe,
>=20
> On 10/26/2012 10:13 AM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Thu, Oct 25, 2012 at 11:37:33AM +0530, Vivek Gautam wrote:
> >> Hi,
> >>
> >> On Tue, Oct 16, 2012 at 3:38 PM, Felipe Balbi <balbi@ti.com> wrote:
> >>> Hi,
> >>>
> >>> On Tue, Oct 16, 2012 at 03:36:43PM +0530, kishon wrote:
> >>>> Hi,
> >>>>
> >>>> On Tuesday 16 October 2012 03:23 PM, Felipe Balbi wrote:
> >>>>> On Tue, Oct 16, 2012 at 02:15:56PM +0530, Vivek Gautam wrote:
> >>>>>> This patch adds support to parse probe data for
> >>>>>> dwc3-exynos driver using device tree.
> >>>>>>
> >>>>>> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> >>>>>> ---
> >>>>>>  drivers/usb/dwc3/dwc3-exynos.c |   20 ++++++++++++++++++++
> >>>>>>  1 files changed, 20 insertions(+), 0 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc=
3-exynos.c
> >>>>>> index ca65978..d11ef49 100644
> >>>>>> --- a/drivers/usb/dwc3/dwc3-exynos.c
> >>>>>> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> >>>>>> @@ -21,6 +21,7 @@
> >>>>>>  #include <linux/clk.h>
> >>>>>>  #include <linux/usb/otg.h>
> >>>>>>  #include <linux/usb/nop-usb-xceiv.h>
> >>>>>> +#include <linux/of.h>
> >>>>>>
> >>>>>>  #include "core.h"
> >>>>>>
> >>>>>> @@ -87,6 +88,8 @@ err1:
> >>>>>>    return ret;
> >>>>>>  }
> >>>>>>
> >>>>>> +static u64 dwc3_exynos_dma_mask =3D DMA_BIT_MASK(32);
> >>>>>> +
> >>>>>>  static int __devinit dwc3_exynos_probe(struct platform_device *pd=
ev)
> >>>>>>  {
> >>>>>>    struct dwc3_exynos_data *pdata =3D pdev->dev.platform_data;
> >>>>>> @@ -103,6 +106,14 @@ static int __devinit dwc3_exynos_probe(struct=
 platform_device *pdev)
> >>>>>>            goto err0;
> >>>>>>    }
> >>>>>>
> >>>>>> +   /*
> >>>>>> +    * Right now device-tree probed devices don't get dma_mask set.
> >>>>>> +    * Since shared usb code relies on it, set it here for now.
> >>>>>> +    * Once we move to full device tree support this will vanish o=
ff.
> >>>>>> +    */
> >>>>>> +   if (!pdev->dev.dma_mask)
> >>>>>> +           pdev->dev.dma_mask =3D &dwc3_exynos_dma_mask;
> >>>>>
> >>>>> says who ?
> >>>>>
> >>>>> $ git grep -e dma_mask drivers/of/
> >>>>> drivers/of/platform.c:  dev->dev.dma_mask =3D &dev->archdata.dma_ma=
sk;
> >>>>> drivers/of/platform.c:  dev->archdata.dma_mask =3D 0xffffffffUL;
> >>>>> drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D DMA_BIT_MASK=
(32);
> >>>>> drivers/of/platform.c:  dev->dev.coherent_dma_mask =3D ~0;
> >>>>> drivers/of/platform.c:  dev->dma_mask =3D ~0;
> >>>>>
> >>>>> -ECONFUSED
> >>>>
> >>>> dma_mask is set under some ifdef except for "dev->dma_mask =3D ~0;".
> >>>> However I agree with you for coherent_dma_mask case.
> >>>
> >>> indeed. Should we try to patch that instead ?
> >>>
> >>> Rob, should we set dma_mask at the driver or do you have a nicer way =
to
> >>> handle it ??
> >>>
> >> Can i have suggestions here please ? :)
> >=20
> > Benoit, can you answer here since nobody else does ?
>=20
> Well, I wish I could, but honestly I don't have a clue :-(

fair enough, then we will go with Vivek's approach, I'll wait until next
friday before looking into these patches again though.

--=20
balbi

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQinuFAAoJEIaOsuA1yqREGS8P/iCKCYBKgklZ+qQGMFY5f8lF
fZR3CAQA9i/oh9K1iEec7jxPu6qIC3GEegmdiUsz1J6eTXDJ7E6FxHSPSXBmgfGT
Wcte26dcA1IXHLmiIhBKaJHVfHQl64WYe1iXGYDRoXL2oZxJEy0sjzj1L0x/z6KM
c/Gk2wxMv5vGX6W5PSkLMF1/uD16OnXO8DVXrjh4KUfM8nHqdugHcXDU38wmhvd6
lVo19OmzOihqgGSs933825yfpdzFSdOpuHurqLpyCUh477Id0TjPgRpE0sWftsoc
kyH5OmpqoDODjlamp/Ntl81hLlkOTCEUF6JhJ47R/lg+HLUOI4wFKM8VxdEmB3IU
/yBE70fR1YbsULMs53KI5FGKnSQOwUKCCOrBAnxlg3nXTZXVctEPQcDlUUIq1Q2e
QQbYOlAlbfdNbl+ffa022CRtF1Tb54+d2+zDs9S70Bji2KZTnfVt3RlIa5grEyKo
bry0TWkZWZk5MhlW2xbr6Qu67QhKVM7VqBRF5YqXtNaIlG5DCGjkJFDWOjWhWaqR
5GbNvm0MD1J6UcsIkSt/FZmtUWRciJB9xtHomDWuIpspNt4+h1PS2fEBTYFHjdbm
9MKmpLVCx4Hccm2Bb2mrJJTPc0Ichn0h4OxX/a1Rlsj6V91IONVEcwHjTSCp6NnU
NskygUNUiHtJFUolceHn
=TE6W
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
