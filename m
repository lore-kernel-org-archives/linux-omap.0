From: David Cohen <dacohen@gmail.com>
Subject: Re: omap3isp cache error when unloading
Date: Fri, 4 Mar 2011 18:49:46 +0200
Message-ID: <AANLkTi=8Sss-5xfgPmgx=J_T__=hrC1rQU-xBOdKC8Ve@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
	<AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
Sender: linux-media-owner@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>, Hiroshi.DOYU@nokia.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, fernando.lugo@ti.com, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[snip]

>> From 2712f2fd087ca782e964c912c7f1973e7d84f2b7 Mon Sep 17 00:00:00 20=
01
>> From: Michael Jones <michael.jones@matrix-vision.de>
>> Date: Fri, 4 Mar 2011 15:09:48 +0100
>> Subject: [PATCH] omap: iovmm: disallow mapping NULL address
>>
>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>> the NULL address if da_start=3D=3D0, which would then not get unmapp=
ed.
>> Disallow this again. =C2=A0And spell variable 'alignment' correctly.
>>
>> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
>> ---
>> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 16 ++++++++++------
>> =C2=A01 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
>> index 6dc1296..11c9b76 100644
>> --- a/arch/arm/plat-omap/iovmm.c
>> +++ b/arch/arm/plat-omap/iovmm.c
>> @@ -271,20 +271,24 @@ static struct iovm_struct *alloc_iovm_area(str=
uct iommu *obj, u32 da,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size_t bytes, u32 flags)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovm_struct *new, *tmp;
>> - =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignement;
>> + =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignment;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj || !bytes)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PT=
R(-EINVAL);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D da;
>> - =C2=A0 =C2=A0 =C2=A0 alignement =3D PAGE_SIZE;
>> + =C2=A0 =C2=A0 =C2=A0 alignment =3D PAGE_SIZE;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & IOVMF_DA_ANON) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D obj->da=
_start;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don't map addr=
ess 0 */
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (obj->da_start=
)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D obj->da_start;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D obj->da_start + alignment;
>
> It seems to be fine for me now. Let's see what Hiroshi says.

Sorry, I'm afraid I changed my mind after take a look into the driver. =
:)
Try to correct obj->da_start in the functions iommu_set_da_range() and
omap_iommu_probe(). That should be the correct way. Your patch doesn't
fix this situation when IOVMF_DA_ANON isn't set.
After obj->da_start is correctly set, your current patch is non longer =
required.

Regards,

David

>
> Regards,
>
> David
>
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & I=
OVMF_LINEAR)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 alignement =3D iopgsz_max(bytes);
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D roundup=
(start, alignement);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 alignment =3D iopgsz_max(bytes);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D roundup=
(start, alignment);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (start < obj->da_start || start=
 > obj->da_end ||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o=
bj->da_end - start < bytes) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PT=
R(-EINVAL);
>> @@ -304,7 +308,7 @@ static struct iovm_struct *alloc_iovm_area(struc=
t iommu *obj, u32 da,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto found;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp->da_e=
nd >=3D start && flags & IOVMF_DA_ANON)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D roundup(tmp->da_end + 1, alignement);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D roundup(tmp->da_end + 1, alignment);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev_end =3D =
tmp->da_end;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> --
>> 1.7.4.1
>>
>>
>>
>> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
>> Registergericht: Amtsgericht Stuttgart, HRB 271090
>> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>>
>
