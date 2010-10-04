From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH 2/4] iovmm: fix roundup for next area and end check for
 the last area
Date: Mon, 4 Oct 2010 15:11:09 +0300
Message-ID: <AANLkTin1p=WqRQvoXvtcVrhEUx5wK8R_bDwUOE+-sD2M@mail.gmail.com>
References: <1285902536-7043-1-git-send-email-x0095840@ti.com>
	<1285902536-7043-2-git-send-email-x0095840@ti.com>
	<1285902536-7043-3-git-send-email-x0095840@ti.com>
	<20101001105711.GA11617@esdhcp036161.research.nokia.com>
	<496565EC904933469F292DDA3F1663E602F46544F9@dlee06.ent.ti.com>
	<20101001175327.GA13657@esdhcp036161.research.nokia.com>
	<496565EC904933469F292DDA3F1663E602F465461A@dlee06.ent.ti.com>
	<20101002074944.GB14377@esdhcp036161.research.nokia.com>
	<496565EC904933469F292DDA3F1663E602F3E074E3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <496565EC904933469F292DDA3F1663E602F3E074E3@dlee06.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: David Cohen <david.cohen@nokia.com>, "Doyu Hiroshi (Nokia-MS/Espoo)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-MS/Helsinki)" <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi,

I have no access to my @nokia.com e-mail at this moment, so I'm
replying using my personal one.

On Mon, Oct 4, 2010 at 6:17 AM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>
>> On Fri, Oct 01, 2010 at 09:21:36PM +0200, ext Guzman Lugo, Fernando =
wrote:
>> >
>> > > On Fri, Oct 01, 2010 at 06:10:30PM +0200, ext Guzman Lugo,
>> > > Fernando wrote:
>> > > >
>> > >
>> > > [snip]
>> > >
>> > > > > > =C2=A0arch/arm/plat-omap/iovmm.c | =C2=A0 =C2=A06 +++---
>> > > > > > =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>> > > > > >
>> > > > > > diff --git a/arch/arm/plat-omap/iovmm.c
>> > > > > b/arch/arm/plat-omap/iovmm.c
>> > > > > > index 24ca9c4..fc6b109 100644
>> > > > > > --- a/arch/arm/plat-omap/iovmm.c
>> > > > > > +++ b/arch/arm/plat-omap/iovmm.c
>> > > > > > @@ -289,19 +289,19 @@ static struct iovm_struct
>> > > > > *alloc_iovm_area(struct iommu *obj, u32 da,
>> > > > > > =C2=A0 =C2=A0 =C2=A0 prev_end =3D 0;
>> > > > > > =C2=A0 =C2=A0 =C2=A0 list_for_each_entry(tmp, &obj->mmap, =
list) {
>> > > > > >
>> > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_end >=
=3D start)
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prev_end >=
 start)
>> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 break;
>> > > > > >
>> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (start=
 + bytes <=3D tmp->da_start)
>> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 goto found;
>> > > > > >
>> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags=
 & IOVMF_DA_ANON)
>> > > > > > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 start =3D roundup(tmp->da_end +
>> > > 1, alignement);
>> > > > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 start =3D roundup(tmp->da_end,
>> > > alignement);
>> > > > >
>> > > > > There's a lack of comment here, but the purpose of
>> > > > > tmp->da_end + 1 is to create a gap between iovm areas to
>> > > > > force to trigger iommu faults when some access exceeds a
>> > > valid area.
>> > > > > Without this gap, such situation may produce data
>> > > corruption which
>> > > > > is much more difficult to track.
>> > > >
>> > > > That only works when you are accessing sequencially beyond
>> > > the End of
>> > > > the vm_area. However if you are accessing a random address
>> > > Which is in
>> > > > the mmu tables you still can corrupt memory which does Not
>> > > belong to
>> > > > you. That looks not very effective then why waste Memory?
>> > >
>> > > The main intention is to detect sequential access beyond the
>> > > end of the vm area and it is effective for that purpose.
>> > > i.e., OMAP3 ISP has a hw issue which makes its H3A submodule,
>> > > responsible to produce statistics data for the captured
>> > > image, to write more data than it should. The workaround
>> > > described in the errata wasn't enough to avoid error
>> > > conditions, so a different approach was implemented. This gap
>> > > did help me to make sure the new workaround is valid and no
>> > > data corruption was occurring anymore.
>> > > Anyway, I can't see why memory is being wasted.
>> > >
>> >
>> > I was taking about vitual memory waste (maybe not so important).
>> > Is ok for me then keep the gap. Do other changes look good to
>> > You?
>>
>> Do you mean in this patch?
>> All changes make sense only if you're removing the gap, except for t=
he
>> fix below.
>
> The thing is, the dspbridge needs to map some register in order to DS=
P
> can read and configure some of them. We need to map some pages
> with fix addresses and to do that I use iommu_kmap. So when some
> of that pages are contiguous I get his error:
>
> "%s: no space to fit %08x(%x) flags: %08x\n"
>
> Which is not true. The page to page perfectly fix, but the check with=
 1 byte
> more avoid that it could be mapped and I am getting the error.
>
> I am not agree with the gap, but I am ok when it is not fixed address=
 as
> below code
>
> if (flags & IOVMF_DA_ANON)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0start =3D roundup(tmp->da_end + 1, alignem=
ent);
>
> But it is breaking the tidspbridge when the gap is used for fixed add=
resses.
>
> It should not fail when we want to map a page what is freed just beca=
use of the gap.
> Please let me know what you thing.

I got your point. I agree the gap shouldn't be forced for fixed da.
IMO you can apply this change when !(flags & IOVMF_DA_ANON).

Regards,

David

>
> Thanks,
> Fernando.
>
>>
>> [snip]
>>
>> > > > > >
>> > > > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prev_end =
=3D tmp->da_end;
>> > > > > > =C2=A0 =C2=A0 =C2=A0 }
>> > > > > >
>> > > > > > - =C2=A0 =C2=A0 if ((start > prev_end) && (ULONG_MAX - sta=
rt >=3D bytes))
>> > > > > > + =C2=A0 =C2=A0 if ((start >=3D prev_end) && (ULONG_MAX - =
start +
>> > > 1 >=3D bytes))
>>
>> This fix is partially valid. The correct change must be only:
>> - =C2=A0 =C2=A0 =C2=A0 if ((start > prev_end) && (ULONG_MAX - start =
>=3D bytes))
>> + =C2=A0 =C2=A0 =C2=A0 if ((start > prev_end) && (ULONG_MAX - start =
+ 1 >=3D bytes))
>>
>> Otherwise you wouldn't guarantee the gap for fixed da.
>>
>> Br,
>>
>> David
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
