From: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Subject: Re: [PATCH 3/3] omap: iovmm: don't check 'da' to set
 IOVMF_DA_FIXED/IOVMF_DA_ANON flags
Date: Tue, 8 Mar 2011 12:53:30 -0600
Message-ID: <AANLkTi=E+9sjGEpCmHPFLFRGTQujDv8747Jf8=ukU1hC@mail.gmail.com>
References: <1299588365-2749-1-git-send-email-dacohen@gmail.com>
	<1299588365-2749-4-git-send-email-dacohen@gmail.com>
	<AANLkTikvUah8LPXCeV4Opi09DJ4ZoHAc2xUVTcDhNK=Q@mail.gmail.com>
	<20110308.200901.212929907269368357.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20110308.200901.212929907269368357.Hiroshi.DOYU@nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: dacohen@gmail.com, linux-omap@vger.kernel.org, linux-media@vger.kernel.org, laurent.pinchart@ideasonboard.com, sakari.ailus@maxwell.research.nokia.com
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 8, 2011 at 12:09 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> From: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
> Subject: Re: [PATCH 3/3] omap: iovmm: don't check 'da' to set IOVMF_D=
A_FIXED/IOVMF_DA_ANON flags
> Date: Tue, 8 Mar 2011 11:59:43 -0600
>
>> On Tue, Mar 8, 2011 at 6:46 AM, David Cohen <dacohen@gmail.com> wrot=
e:
>>> Currently IOVMM driver sets IOVMF_DA_FIXED/IOVMF_DA_ANON flags acco=
rding
>>> to input 'da' address when mapping memory:
>>> da =3D=3D 0: IOVMF_DA_ANON
>>> da !=3D 0: IOVMF_DA_FIXED
>>>
>>> It prevents IOMMU to map first page with fixed 'da'. To avoid such
>>> issue, IOVMM will not automatically set IOVMF_DA_FIXED. It should n=
ow
>>> come from the user. IOVMF_DA_ANON will be automatically set if
>>> IOVMF_DA_FIXED isn't set.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> =A0arch/arm/plat-omap/iovmm.c | =A0 12 ++++++++----
>>> =A01 files changed, 8 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/iovmm.c b/arch/arm/plat-omap/iovmm.=
c
>>> index 11c9b76..dde9cb0 100644
>>> --- a/arch/arm/plat-omap/iovmm.c
>>> +++ b/arch/arm/plat-omap/iovmm.c
>>> @@ -654,7 +654,8 @@ u32 iommu_vmap(struct iommu *obj, u32 da, const=
 struct sg_table *sgt,
>>> =A0 =A0 =A0 =A0flags &=3D IOVMF_HW_MASK;
>>> =A0 =A0 =A0 =A0flags |=3D IOVMF_DISCONT;
>>> =A0 =A0 =A0 =A0flags |=3D IOVMF_MMIO;
>>> - =A0 =A0 =A0 flags |=3D (da ? IOVMF_DA_FIXED : IOVMF_DA_ANON);
>>> + =A0 =A0 =A0 if (~flags & IOVMF_DA_FIXED)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D IOVMF_DA_ANON;
>>
>> could we use only one? both are mutual exclusive, what happen if fla=
g
>> is IOVMF_DA_FIXED | IOVMF_DA_ANON? so, I suggest to get rid of
>> IOVMF_DA_ANON.
>
> Then, what about introducing some MACRO? Better names?
>
> #define set_iovmf_da_anon(flags)
> #define set_iovmf_da_fix(flags)
> #define set_iovmf_mmio(flags)

will they be used by the users?

I think people are more used to use

iommu_vmap(obj, da, sgt, IOVMF_MMIO | IOVMF_DA_ANON);

than

set_iovmf_da_anon(flags)
set_iovmf_mmio(flags)
iommu_vmap(obj, da, sgt, flags);

I don't have problem with the change, but I think how it is now is ok,
just that we don't we two bits to handle anon/fixed da, it can be
managed it only 1 bit (one flag), or is there a issue?

Regards,
=46ernando.
> ......
>
