From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH 3/3] omap: iovmm: don't check 'da' to set
 IOVMF_DA_FIXED/IOVMF_DA_ANON flags
Date: Tue, 8 Mar 2011 13:33:36 -0600
Message-ID: <AANLkTimcSRB+AS=UEAtfc6D=BYWB7Nedj3LQyCnG4bVf@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-4-git-send-email-dacohen@gmail.com>
	<AANLkTikvUah8LPXCeV4Opi09DJ4ZoHAc2xUVTcDhNK=Q@mail.gmail.com>
	<20110308.200901.212929907269368357.Hiroshi.DOYU@nokia.com>
	<AANLkTi=E+9sjGEpCmHPFLFRGTQujDv8747Jf8=ukU1hC@mail.gmail.com>
	<AANLkTikmWdQZZJHTmJsDTrSX434pKfpqJWZ6RWGB7ec6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33078 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754877Ab1CHTdm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 14:33:42 -0500
In-Reply-To: <AANLkTikmWdQZZJHTmJsDTrSX434pKfpqJWZ6RWGB7ec6@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com

On Tue, Mar 8, 2011 at 12:57 PM, David Cohen <dacohen@gmail.com> wrote:
> Hi Hiroshi, Fernando,
>
> On Tue, Mar 8, 2011 at 8:53 PM, Guzman Lugo, Fernando
> <fernando.lugo@ti.com> wrote:
>> On Tue, Mar 8, 2011 at 12:09 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>>> From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
>>> Subject: Re: [PATCH 3/3] omap: iovmm: don't check 'da' to set IOVMF=
_DA_FIXED/IOVMF_DA_ANON flags
>>> Date: Tue, 8 Mar 2011 11:59:43 -0600
>>>
>>>> On Tue, Mar 8, 2011 at 6:46 AM, David Cohen <dacohen@gmail.com> wr=
ote:
>>>>> Currently IOVMM driver sets IOVMF_DA_FIXED/IOVMF_DA_ANON flags ac=
cording
>>>>> to input 'da' address when mapping memory:
>>>>> da =3D=3D 0: IOVMF_DA_ANON
>>>>> da !=3D 0: IOVMF_DA_FIXED
>>>>>
>>>>> It prevents IOMMU to map first page with fixed 'da'. To avoid suc=
h
>>>>> issue, IOVMM will not automatically set IOVMF_DA_FIXED. It should=
 now
>>>>> come from the user. IOVMF_DA_ANON will be automatically set if
>>>>> IOVMF_DA_FIXED isn't set.
>>>>>
>>>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>>>> ---
>>>>> =A0arch/arm/plat-omap/iovmm.c | =A0 12 ++++++++----
>>>>> =A01 files changed, 8 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovm=
m.c
>>>>> index 11c9b76..dde9cb0 100644
>>>>> --- a/arch/arm/plat-omap/iovmm.c
>>>>> +++ b/arch/arm/plat-omap/iovmm.c
>>>>> @@ -654,7 +654,8 @@ u32 iommu_vmap(struct iommu *obj, u32 da, con=
st struct sg_table *sgt,
>>>>> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
>>>>> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
>>>>> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
>>>>> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>>>>> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;
>>>>
>>>> could we use only one? both are mutual exclusive, what happen if f=
lag
>>>> is IOVMF_DA_FIXED | IOVMF_DA_ANON? so, I suggest to get rid of
>>>> IOVMF_DA_ANON.
>>>
>>> Then, what about introducing some MACRO? Better names?
>>>
>>> #define set_iovmf_da_anon(flags)
>>> #define set_iovmf_da_fix(flags)
>>> #define set_iovmf_mmio(flags)
>>
>> will they be used by the users?
>>
>> I think people are more used to use
>>
>> iommu_vmap(obj, da, sgt, IOVMF_MMIO | IOVMF_DA_ANON);
>
> I'd be happier with this approach, instead of the macros. :)
> It's intuitive and very common on kernel.
>
>>
>> than
>>
>> set_iovmf_da_anon(flags)
>> set_iovmf_mmio(flags)
>> iommu_vmap(obj, da, sgt, flags);
>>
>> I don't have problem with the change, but I think how it is now is o=
k,
>> just that we don't we two bits to handle anon/fixed da, it can be
>> managed it only 1 bit (one flag), or is there a issue?
>
> We can exclude IOVMF_DA_ANON and stick with IOVMF_DA_FIXED only.
> I can resend my patch if we agree it's OK.

sounds perfect to me.

Regards,
=46ernando.

>
> Regards,
>
> David
>
>>
>> Regards,
>> Fernando.
>>> ......
>>>
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
