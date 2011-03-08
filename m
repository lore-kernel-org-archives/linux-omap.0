From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 1/3] omap: iovmm: disallow mapping NULL address
Date: Tue, 8 Mar 2011 22:07:09 +0200
Message-ID: <AANLkTim2R1VPDYUff+1PFpdsxYYNM8G3FrzSsYgShe74@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-2-git-send-email-dacohen@gmail.com>
	<AANLkTikkUYFuhH-b2vKX8jVoT18wH_+WPzGbfFNWQK6K@mail.gmail.com>
	<AANLkTikH=oYFOuvvG2y4yj=6UUnPCyEtq8AMc9bF9VrH@mail.gmail.com>
	<AANLkTim6rGp54i9cT0FMoRniiF4umKK5+agOSkfKvZAT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46276 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752257Ab1CHUHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 15:07:11 -0500
In-Reply-To: <AANLkTim6rGp54i9cT0FMoRniiF4umKK5+agOSkfKvZAT@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: Hiroshi.DOYU@nokia.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com, Michael Jones <michael.jones@matrix-vision.de>

On Tue, Mar 8, 2011 at 9:53 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
> On Tue, Mar 8, 2011 at 1:06 PM, David Cohen <dacohen@gmail.com> wrote=
:
>> On Tue, Mar 8, 2011 at 8:06 PM, Guzman Lugo, Fernando
>> <fernando.lugo@ti.com> wrote:
>>> On Tue, Mar 8, 2011 at 6:46 AM, David Cohen <dacohen@gmail.com> wro=
te:
>>>> From: Michael Jones <michael.jones@matrix-vision.de>
>>>>
>>>> commit c7f4ab26e3bcdaeb3e19ec658e3ad9092f1a6ceb allowed mapping
>>>> the NULL address if da_start=3D=3D0, which would then not get unma=
pped.
>>>> Disallow this again. =C2=A0And spell variable 'alignment' correctl=
y.
>>>>
>>>> Signed-off-by: Michael Jones <michael.jones@matrix-vision.de>
>>>> ---
>>>> =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 16 ++++++++++------
>>>> =C2=A01 files changed, 10 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm=
=2Ec
>>>> index 6dc1296..11c9b76 100644
>>>> --- a/arch/arm/plat-omap/iovmm.c
>>>> +++ b/arch/arm/plat-omap/iovmm.c
>>>> @@ -271,20 +271,24 @@ static struct iovm_struct *alloc_iovm_area(s=
truct iommu *obj, u32 da,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 size_t bytes, u32 flags)
>>>> =C2=A0{
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iovm_struct *new, *tmp;
>>>> - =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignement;
>>>> + =C2=A0 =C2=A0 =C2=A0 u32 start, prev_end, alignment;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj || !bytes)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_=
PTR(-EINVAL);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D da;
>>>> - =C2=A0 =C2=A0 =C2=A0 alignement =3D PAGE_SIZE;
>>>> + =C2=A0 =C2=A0 =C2=A0 alignment =3D PAGE_SIZE;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & IOVMF_DA_ANON) {
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D obj->=
da_start;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Don't map ad=
dress 0 */
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (obj->da_sta=
rt)
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D obj->da_start;
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D obj->da_start + alignment;
>>>
>>> else part obj->da_star is always 0, so why not?
>>> start =3D alignment;
>>
>> The patch is not from me, but I can fix it if Michael agrees.
>>
>>>
>>> so, why I understand, it now it is possible mapp address 0x0 only i=
f
>>> IOVMF_DA_ANON is not set, right? maybe that would be mention in the
>>> patch.
>>
>> Indeed address 0x0 was never meant to be mapped. The mentioned commi=
t
>> on the patch's description did that without noticing. But the new
>> change is documented in the code by the comment "Don't map address 0=
"
>
> yeah, but it only applies when "flags & IOVMF_DA_ANON", So if I use
> IOVMF_DA_FIXED and da_start =3D=3D 0, I will be able to map some area
> which starts from address 0x0, right? =C2=A0if so, that looks good to=
 me
> and the description should mention that if is disallowing mapping
> address 0x0 when IOVMF_DA_ANON is used.

Yes, that's the case. I will update the comment. I hope Michael does
not complain about the changes. :)

Br,

David

>
> Regards,
> Fernando.
>
>> and it's also mentioned on the patch description. Is it OK for you?
>>
>> Regards,
>>
>> David Cohen
>>
>>>
>>> Regards,
>>> Fernando.
>>>
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags &=
 IOVMF_LINEAR)
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 alignement =3D iopgsz_max(bytes);
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D round=
up(start, alignement);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 alignment =3D iopgsz_max(bytes);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 start =3D round=
up(start, alignment);
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (start < obj->da_start || sta=
rt > obj->da_end ||
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
obj->da_end - start < bytes) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ERR_=
PTR(-EINVAL);
>>>> @@ -304,7 +308,7 @@ static struct iovm_struct *alloc_iovm_area(str=
uct iommu *obj, u32 da,
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto found;
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tmp->da=
_end >=3D start && flags & IOVMF_DA_ANON)
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D roundup(tmp->da_end + 1, alignement);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 start =3D roundup(tmp->da_end + 1, alignment);
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prev_end =3D=
 tmp->da_end;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>> --
>>>> 1.7.0.4
>>>>
>>>>
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
