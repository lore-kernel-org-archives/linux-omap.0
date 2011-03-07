From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH] omap: iommu: disallow mapping NULL address
Date: Mon, 7 Mar 2011 21:41:21 +0200
Message-ID: <AANLkTimac512Gu0_vyPjThvNxXHsXTRD73B0d1bHnnAg@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
	<AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
	<AANLkTi=8Sss-5xfgPmgx=J_T__=hrC1rQU-xBOdKC8Ve@mail.gmail.com>
	<4D74D94F.7040702@matrix-vision.de>
	<AANLkTikokA2hGMYA3vfBOxa0jPr0tjbLfYW603+zicry@mail.gmail.com>
	<AANLkTikzAjUrec+c6zcSCx6auaR9QvbWwwTbXpGYuOoZ@mail.gmail.com>
	<AANLkTi=KncNfW0NEEoV+mrT_Ft2j-c=rQG=qbeR6tLQK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59738 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab1CGTlX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 14:41:23 -0500
In-Reply-To: <AANLkTi=KncNfW0NEEoV+mrT_Ft2j-c=rQG=qbeR6tLQK@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>, Hiroshi.DOYU@nokia.com, Michael Jones <michael.jones@matrix-vision.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org

On Mon, Mar 7, 2011 at 9:25 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Mon, Mar 7, 2011 at 1:19 PM, David Cohen <dacohen@gmail.com> wrote=
:
>> On Mon, Mar 7, 2011 at 9:17 PM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>>> On Mon, Mar 7, 2011 at 7:10 AM, Michael Jones
>>> <michael.jones@matrix-vision.de> wrote:
>>>> From e7dbe4c4b64eb114f9b0804d6af3a3ca0e78acc8 Mon Sep 17 00:00:00 =
2001
>>>> From: Michael Jones <michael.jones@matrix-vision.de>
>>>> Date: Mon, 7 Mar 2011 13:36:15 +0100
>>>> Subject: [PATCH] omap: iommu: disallow mapping NULL address
>>>>
>>>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>>>> the NULL address if da_start=3D=3D0. =C2=A0Force da_start to exclu=
de the
>>>> first page.
>>>
>>> what about devices that uses page 0? ipu after reset always starts
>>> from 0x00000000 how could we map that address??
>>
>> from 0x0? The driver sees da =3D=3D 0 as error. May I ask you why do=
 you want it?
>
> unlike DSP that you can load a register with the addres the DSP will
> boot, IPU core always starts from address 0x00000000, so if you take
> IPU out of reset it will try to access address 0x0 if not map it,
> there will be a mmu fault.

Hm. Looks like the iommu should not restrict any da. The valid da
range should rely only on pdata.
Michael, what about just update ISP's da_start on omap-iommu.c file?
Set it to 0x1000.

Hiroshi, any opinion?

Br,

David

>
> Regards,
> Fernando.
>
>>
>> Br,
>>
>> David
>>
>>>
>>> Regards,
>>> Fernando.
>>>
>>>>
>>>> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
>>>> ---
>>>> =C2=A0arch/arm/plat-omap/iommu.c | =C2=A0 =C2=A06 ++++--
>>>> =C2=A01 files changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu=
=2Ec
>>>> index 5990ea6..dcb5513 100644
>>>> --- a/arch/arm/plat-omap/iommu.c
>>>> +++ b/arch/arm/plat-omap/iommu.c
>>>> @@ -850,7 +850,7 @@ int iommu_set_da_range(struct iommu *obj, u32 =
start, u32 end)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (end < start || !PAGE_ALIGN(start | =
end))
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;
>>>>
>>>> - =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D start;
>>>> + =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D max(start, (u32)PAGE_SIZE=
);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->da_end =3D end;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>>>> @@ -950,7 +950,9 @@ static int __devinit omap_iommu_probe(struct p=
latform_device *pdev)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->name =3D pdata->name;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->dev =3D &pdev->dev;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->ctx =3D (void *)obj + sizeof(*obj)=
;
>>>> - =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D pdata->da_start;
>>>> +
>>>> + =C2=A0 =C2=A0 =C2=A0 /* reserve the first page for NULL */
>>>> + =C2=A0 =C2=A0 =C2=A0 obj->da_start =3D max(pdata->da_start, (u32=
)PAGE_SIZE);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->da_end =3D pdata->da_end;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_init(&obj->iommu_lock);
>>>> --
>>>> 1.7.4.1
>>>>
>>>>
>>>> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
>>>> Registergericht: Amtsgericht Stuttgart, HRB 271090
>>>> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
