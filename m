From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Mon, 7 Mar 2011 21:19:37 +0200
Message-ID: <AANLkTikzAjUrec+c6zcSCx6auaR9QvbWwwTbXpGYuOoZ@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
	<AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
	<AANLkTi=8Sss-5xfgPmgx=J_T__=hrC1rQU-xBOdKC8Ve@mail.gmail.com>
	<4D74D94F.7040702@matrix-vision.de>
	<AANLkTikokA2hGMYA3vfBOxa0jPr0tjbLfYW603+zicry@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTikokA2hGMYA3vfBOxa0jPr0tjbLfYW603+zicry@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Michael Jones <michael.jones@matrix-vision.de>, Hiroshi.DOYU@nokia.com, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Mar 7, 2011 at 9:17 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Mon, Mar 7, 2011 at 7:10 AM, Michael Jones
> <michael.jones@matrix-vision.de> wrote:
>> From e7dbe4c4b64eb114f9b0804d6af3a3ca0e78acc8 Mon Sep 17 00:00:00 20=
01
>> From: Michael Jones <michael.jones@matrix-vision.de>
>> Date: Mon, 7 Mar 2011 13:36:15 +0100
>> Subject: [PATCH] omap: iommu: disallow mapping NULL address
>>
>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>> the NULL address if da_start=3D=3D0. =C2=A0Force da_start to exclude=
 the
>> first page.
>
> what about devices that uses page 0? ipu after reset always starts
> from 0x00000000 how could we map that address??

from 0x0? The driver sees da =3D=3D 0 as error. May I ask you why do yo=
u want it?

Br,

David

>
> Regards,
> Fernando.
>
>>
>> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
>> ---
>> =C2=A0arch/arm/plat-omap/iommu.c | =C2=A0 =C2=A06 ++++--
>> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index 5990ea6..dcb5513 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -850,7 +850,7 @@ int iommu_set_da_range(struct iommu *obj, u32 st=
art, u32 end)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end < start || !PAGE_ALIGN(start | en=
d))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVA=
L;
>>
>> - =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D start;
>> + =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D max(start, (u32)PAGE_SIZE);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->da_end =3D end;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>> @@ -950,7 +950,9 @@ static int __devinit omap_iommu_probe(struct pla=
tform_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->name =3D pdata->name;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->dev =3D &pdev->dev;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->ctx =3D (void *)obj + sizeof(*obj);
>> - =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D pdata->da_start;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* reserve the first page for NULL */
>> + =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D max(pdata->da_start, (u32)P=
AGE_SIZE);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->da_end =3D pdata->da_end;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&obj->iommu_lock);
>> --
>> 1.7.4.1
>>
>>
>> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
>> Registergericht: Amtsgericht Stuttgart, HRB 271090
>> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>>
>
