From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Mon, 7 Mar 2011 13:17:14 -0600
Message-ID: <AANLkTikokA2hGMYA3vfBOxa0jPr0tjbLfYW603+zicry@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
	<AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
	<AANLkTi=8Sss-5xfgPmgx=J_T__=hrC1rQU-xBOdKC8Ve@mail.gmail.com>
	<4D74D94F.7040702@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:38651 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751940Ab1CGTRQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 14:17:16 -0500
In-Reply-To: <4D74D94F.7040702@matrix-vision.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>
Cc: David Cohen <dacohen@gmail.com>, Hiroshi.DOYU@nokia.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org

On Mon, Mar 7, 2011 at 7:10 AM, Michael Jones
<michael.jones@matrix-vision.de> wrote:
> From e7dbe4c4b64eb114f9b0804d6af3a3ca0e78acc8 Mon Sep 17 00:00:00 200=
1
> From: Michael Jones <michael.jones@matrix-vision.de>
> Date: Mon, 7 Mar 2011 13:36:15 +0100
> Subject: [PATCH] omap: iommu: disallow mapping NULL address
>
> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
> the NULL address if da_start=3D=3D0. =A0Force da_start to exclude the
> first page.

what about devices that uses page 0? ipu after reset always starts
from 0x00000000 how could we map that address??

Regards,
=46ernando.

>
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
> =A0arch/arm/plat-omap/iommu.c | =A0 =A06 ++++--
> =A01 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index 5990ea6..dcb5513 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -850,7 +850,7 @@ int iommu_set_da_range(struct iommu *obj, u32 sta=
rt, u32 end)
> =A0 =A0 =A0 =A0if (end < start || !PAGE_ALIGN(start | end))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 obj->da_start =3D start;
> + =A0 =A0 =A0 obj->da_start =3D max(start, (u32)PAGE_SIZE);
> =A0 =A0 =A0 =A0obj->da_end =3D end;
>
> =A0 =A0 =A0 =A0return 0;
> @@ -950,7 +950,9 @@ static int __devinit omap_iommu_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0obj->name =3D pdata->name;
> =A0 =A0 =A0 =A0obj->dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0obj->ctx =3D (void *)obj + sizeof(*obj);
> - =A0 =A0 =A0 obj->da_start =3D pdata->da_start;
> +
> + =A0 =A0 =A0 /* reserve the first page for NULL */
> + =A0 =A0 =A0 obj->da_start =3D max(pdata->da_start, (u32)PAGE_SIZE);
> =A0 =A0 =A0 =A0obj->da_end =3D pdata->da_end;
>
> =A0 =A0 =A0 =A0mutex_init(&obj->iommu_lock);
> --
> 1.7.4.1
>
>
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
