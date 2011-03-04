From: David Cohen <dacohen@gmail.com>
Subject: Re: omap3isp cache error when unloading
Date: Fri, 4 Mar 2011 17:45:12 +0200
Message-ID: <AANLkTinSJpjPXWHWduLbRSmb=La3sv82ufwgsq-uR7S2@mail.gmail.com>
References: <4D6D219D.7020605@matrix-vision.de>
	<201103022018.23446.laurent.pinchart@ideasonboard.com>
	<4D6FBC7F.1080500@matrix-vision.de>
	<AANLkTikAKy=CzTqEv-UGBQ1EavqmCStPNFZ5vs7vH5VK@mail.gmail.com>
	<4D70F985.8030902@matrix-vision.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <4D70F985.8030902@matrix-vision.de>
Sender: linux-media-owner@vger.kernel.org
To: Michael Jones <michael.jones@matrix-vision.de>, Hiroshi.DOYU@nokia.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, fernando.lugo@ti.com, Sakari Ailus <sakari.ailus@maxwell.research.nokia.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Mar 4, 2011 at 4:39 PM, Michael Jones
<michael.jones@matrix-vision.de> wrote:
> Hi David,

Hi Michael,

>
> On 03/04/2011 02:12 PM, David Cohen wrote:
>> Hi,
>>
>> [snip]
>>
>>> Sorry, I should've mentioned: I'm using your media-0005-omap3isp br=
anch
>>> based on 2.6.38-rc5. =C2=A0I didn't have the problem with 2.6.37, e=
ither.
>>> It's actually not related to mis-configuring the ISP pipeline like =
I
>>> thought at first- it also happens after I have successfully capture=
d images.
>>>
>>> I've since tracked down the problem, although I don't understand th=
e
>>> cache management well enough to be sure it's a proper fix, so hopef=
ully
>>> some new recipients on this can make suggestions/comments.
>>>
>>> The patch below solves the problem, which modifies a commit by Fern=
ando
>>> Guzman Lugo from December.
>>>
>>> -Michael
>>>
>>> From db35fb8edca2a4f8fd37197d77fd58676cb1dcac Mon Sep 17 00:00:00 2=
001
>>> From: Michael Jones <michael.jones@matrix-vision.de>
>>> Date: Thu, 3 Mar 2011 16:50:39 +0100
>>> Subject: [PATCH] fix iovmm slab cache error on module unload
>>>
>>> modify "OMAP: iommu: create new api to set valid da range"
>>>
>>> This modifies commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb.
>>> ---
>>> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 =C2=A05 ++++-
>>> =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.=
c
>>> index 6dc1296..2fba6f1 100644
>>> --- a/arch/arm/plat-omap/iovmm.c
>>> +++ b/arch/arm/plat-omap/iovmm.c
>>> @@ -280,7 +280,10 @@ static struct iovm_struct *alloc_iovm_area(str=
uct iommu *obj, u32 da,
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0alignement =3D PAGE_SIZE;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & IOVMF_DA_ANON) {
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D obj->d=
a_start;
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Reserve =
the first page for NULL
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D obj->d=
a_start + PAGE_SIZE;
>>
>> IMO if obj->da_start !=3D 0, no need to add PAGE_SIZE. Otherwise, it
>> does make sense to correct wrong obj->da_start =3D=3D 0. Another thi=
ng is
>> this piece of code is using alignement (alignment) variable instead =
of
>> PAGE_SIZE (which is the same value).
>>
>> Br,
>>
>> David
>
> I believe the following patch addresses your comments. =C2=A0I couldn=
't
> resist also fixing the misspelling of alignment when I was using the
> variable in my patch.
>
> -Michael
>
> From 2712f2fd087ca782e964c912c7f1973e7d84f2b7 Mon Sep 17 00:00:00 200=
1
> From: Michael Jones <michael.jones@matrix-vision.de>
> Date: Fri, 4 Mar 2011 15:09:48 +0100
> Subject: [PATCH] omap: iovmm: disallow mapping NULL address
>
> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
> the NULL address if da_start=3D=3D0, which would then not get unmappe=
d.
> Disallow this again. =C2=A0And spell variable 'alignment' correctly.
>
> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
> ---
> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 16 ++++++++++------
> =C2=A01 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.c
> index 6dc1296..11c9b76 100644
> --- a/arch/arm/plat-omap/iovmm.c
> +++ b/arch/arm/plat-omap/iovmm.c
> @@ -271,20 +271,24 @@ static struct iovm_struct *alloc_iovm_area(stru=
ct iommu *obj, u32 da,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 size_t bytes, u32 flags)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovm_struct *new, *tmp;
> - =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignement;
> + =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignment;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj || !bytes)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(-EINVAL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D da;
> - =C2=A0 =C2=A0 =C2=A0 alignement =3D PAGE_SIZE;
> + =C2=A0 =C2=A0 =C2=A0 alignment =3D PAGE_SIZE;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & IOVMF_DA_ANON) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D obj->da_=
start;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don't map addre=
ss 0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (obj->da_start)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 start =3D obj->da_start;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 start =3D obj->da_start + alignment;

It seems to be fine for me now. Let's see what Hiroshi says.

Regards,

David

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & IO=
VMF_LINEAR)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 alignement =3D iopgsz_max(bytes);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D roundup(=
start, alignement);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 alignment =3D iopgsz_max(bytes);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D roundup(=
start, alignment);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (start < obj->da_start || start =
> obj->da_end ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0o=
bj->da_end - start < bytes) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_PTR=
(-EINVAL);
> @@ -304,7 +308,7 @@ static struct iovm_struct *alloc_iovm_area(struct=
 iommu *obj, u32 da,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0goto found;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp->da_en=
d >=3D start && flags & IOVMF_DA_ANON)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 start =3D roundup(tmp->da_end + 1, alignement);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 start =3D roundup(tmp->da_end + 1, alignment);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev_end =3D t=
mp->da_end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> --
> 1.7.4.1
>
>
>
> MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
> Registergericht: Amtsgericht Stuttgart, HRB 271090
> Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
>
