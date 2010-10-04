From: David Cohen <david.cohen@nokia.com>
Subject: Re: [PATCH 2/4] iovmm: fix roundup for next area and end check for
 the last area
Date: Mon, 4 Oct 2010 18:35:46 +0300
Message-ID: <20101004153546.GA16610@esdhcp036161.research.nokia.com>
References: <1285902536-7043-2-git-send-email-x0095840@ti.com>
 <1285902536-7043-3-git-send-email-x0095840@ti.com>
 <20101001105711.GA11617@esdhcp036161.research.nokia.com>
 <496565EC904933469F292DDA3F1663E602F46544F9@dlee06.ent.ti.com>
 <20101001175327.GA13657@esdhcp036161.research.nokia.com>
 <496565EC904933469F292DDA3F1663E602F465461A@dlee06.ent.ti.com>
 <20101002074944.GB14377@esdhcp036161.research.nokia.com>
 <496565EC904933469F292DDA3F1663E602F3E074E3@dlee06.ent.ti.com>
 <AANLkTin1p=WqRQvoXvtcVrhEUx5wK8R_bDwUOE+-sD2M@mail.gmail.com>
 <496565EC904933469F292DDA3F1663E602F471BB0C@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <496565EC904933469F292DDA3F1663E602F471BB0C@dlee06.ent.ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "ext Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: David Cohen <dacohen@gmail.com>, "Doyu Hiroshi (Nokia-MS/Espoo)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-MS/Helsinki)" <felipe.contreras@nokia.com>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Oct 04, 2010 at 05:37:04PM +0200, ext Guzman Lugo, Fernando wro=
te:
> =20
>=20
> > -----Original Message-----
> > From: David Cohen [mailto:dacohen@gmail.com]=20
> > Sent: Monday, October 04, 2010 7:11 AM
> > To: Guzman Lugo, Fernando
> > Cc: David Cohen; Doyu Hiroshi (Nokia-MS/Espoo); Contreras=20
> > Felipe (Nokia-MS/Helsinki); Palande Ameya=20
> > (Nokia-MS/Helsinki); linux-kernel@vger.kernel.org;=20
> > andy.shevchenko@gmail.com; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 2/4] iovmm: fix roundup for next area and=20
> > end check for the last area
> >=20
> > Hi,
> >=20
> > I have no access to my @nokia.com e-mail at this moment, so=20
> > I'm replying using my personal one.
> >=20
> > On Mon, Oct 4, 2010 at 6:17 AM, Guzman Lugo, Fernando=20
> > <fernando.lugo@ti.com> wrote:
> > >
> > >> On Fri, Oct 01, 2010 at 09:21:36PM +0200, ext Guzman Lugo,=20
> > Fernando wrote:
> > >> >
> > >> > > On Fri, Oct 01, 2010 at 06:10:30PM +0200, ext Guzman Lugo,=20
> > >> > > Fernando wrote:
> > >> > > >
> > >> > >
> > >> > > [snip]
> > >> > >
> > >> > > > > > =A0arch/arm/plat-omap/iovmm.c | =A0 =A06 +++---
> > >> > > > > > =A01 files changed, 3 insertions(+), 3 deletions(-)
> > >> > > > > >
> > >> > > > > > diff --git a/arch/arm/plat-omap/iovmm.c
> > >> > > > > b/arch/arm/plat-omap/iovmm.c
> > >> > > > > > index 24ca9c4..fc6b109 100644
> > >> > > > > > --- a/arch/arm/plat-omap/iovmm.c
> > >> > > > > > +++ b/arch/arm/plat-omap/iovmm.c
> > >> > > > > > @@ -289,19 +289,19 @@ static struct iovm_struct
> > >> > > > > *alloc_iovm_area(struct iommu *obj, u32 da,
> > >> > > > > > =A0 =A0 =A0 prev_end =3D 0;
> > >> > > > > > =A0 =A0 =A0 list_for_each_entry(tmp, &obj->mmap, list)=
 {
> > >> > > > > >
> > >> > > > > > - =A0 =A0 =A0 =A0 =A0 =A0 if (prev_end >=3D start)
> > >> > > > > > + =A0 =A0 =A0 =A0 =A0 =A0 if (prev_end > start)
> > >> > > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > >> > > > > >
> > >> > > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (start + bytes <=3D tmp=
->da_start)
> > >> > > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto found=
;
> > >> > > > > >
> > >> > > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (flags & IOVMF_DA_ANON)
> > >> > > > > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D ro=
undup(tmp->da_end +
> > >> > > 1, alignement);
> > >> > > > > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 start =3D ro=
undup(tmp->da_end,
> > >> > > alignement);
> > >> > > > >
> > >> > > > > There's a lack of comment here, but the purpose of
> > >> > > > > tmp->da_end + 1 is to create a gap between iovm areas to
> > >> > > > > force to trigger iommu faults when some access exceeds a
> > >> > > valid area.
> > >> > > > > Without this gap, such situation may produce data
> > >> > > corruption which
> > >> > > > > is much more difficult to track.
> > >> > > >
> > >> > > > That only works when you are accessing sequencially beyond
> > >> > > the End of
> > >> > > > the vm_area. However if you are accessing a random address
> > >> > > Which is in
> > >> > > > the mmu tables you still can corrupt memory which does Not
> > >> > > belong to
> > >> > > > you. That looks not very effective then why waste Memory?
> > >> > >
> > >> > > The main intention is to detect sequential access=20
> > beyond the end=20
> > >> > > of the vm area and it is effective for that purpose.
> > >> > > i.e., OMAP3 ISP has a hw issue which makes its H3A submodule=
,=20
> > >> > > responsible to produce statistics data for the=20
> > captured image, to=20
> > >> > > write more data than it should. The workaround=20
> > described in the=20
> > >> > > errata wasn't enough to avoid error conditions, so a differe=
nt=20
> > >> > > approach was implemented. This gap did help me to make=20
> > sure the=20
> > >> > > new workaround is valid and no data corruption was occurring=
=20
> > >> > > anymore.
> > >> > > Anyway, I can't see why memory is being wasted.
> > >> > >
> > >> >
> > >> > I was taking about vitual memory waste (maybe not so important=
).
> > >> > Is ok for me then keep the gap. Do other changes look=20
> > good to You?
> > >>
> > >> Do you mean in this patch?
> > >> All changes make sense only if you're removing the gap, except f=
or=20
> > >> the fix below.
> > >
> > > The thing is, the dspbridge needs to map some register in=20
> > order to DSP=20
> > > can read and configure some of them. We need to map some pages wi=
th=20
> > > fix addresses and to do that I use iommu_kmap. So when some of th=
at=20
> > > pages are contiguous I get his error:
> > >
> > > "%s: no space to fit %08x(%x) flags: %08x\n"
> > >
> > > Which is not true. The page to page perfectly fix, but the=20
> > check with=20
> > > 1 byte more avoid that it could be mapped and I am getting=20
> > the error.
> > >
> > > I am not agree with the gap, but I am ok when it is not=20
> > fixed address=20
> > > as below code
> > >
> > > if (flags & IOVMF_DA_ANON)
> > > =A0 =A0 =A0 =A0start =3D roundup(tmp->da_end + 1, alignement);
> > >
> > > But it is breaking the tidspbridge when the gap is used for=20
> > fixed addresses.
> > >
> > > It should not fail when we want to map a page what is freed=20
> > just because of the gap.
> > > Please let me know what you thing.
> >=20
> > I got your point. I agree the gap shouldn't be forced for fixed da.
> > IMO you can apply this change when !(flags & IOVMF_DA_ANON).
>=20
> As for not fixed address it always travers the list from the
> Beginning. The only change need to revert in my patch is when
> We roundup. That means keeping:
>=20
> if (flags & IOVMF_DA_ANON)
>  =A0 =A0 =A0 =A0start =3D roundup(tmp->da_end + 1, alignement);
>=20
> Is enough to create the gap for not fixed address. I will
> Update the patch and send them again.

Sounds fine for me. Please, update the patch and I'll ack it.

Br,

David

>=20
> Thanks,
> Fernando.
>=20
> >=20
> > Regards,
> >=20
> > David
> >=20
> > >
> > > Thanks,
> > > Fernando.
> > >
> > >>
> > >> [snip]
> > >>
> > >> > > > > >
> > >> > > > > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_end =3D tmp->da_end;
> > >> > > > > > =A0 =A0 =A0 }
> > >> > > > > >
> > >> > > > > > - =A0 =A0 if ((start > prev_end) && (ULONG_MAX - start=
 >=3D=20
> > >> > > > > > bytes))
> > >> > > > > > + =A0 =A0 if ((start >=3D prev_end) && (ULONG_MAX - st=
art +
> > >> > > 1 >=3D bytes))
> > >>
> > >> This fix is partially valid. The correct change must be only:
> > >> - =A0 =A0 =A0 if ((start > prev_end) && (ULONG_MAX - start >=3D =
bytes))
> > >> + =A0 =A0 =A0 if ((start > prev_end) && (ULONG_MAX - start + 1 >=
=3D bytes))
> > >>
> > >> Otherwise you wouldn't guarantee the gap for fixed da.
> > >>
> > >> Br,
> > >>
> > >> David
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe=20
> > linux-omap"=20
> > > in the body of a message to majordomo@vger.kernel.org More=20
> > majordomo=20
> > > info at =A0http://vger.kernel.org/majordomo-info.html
> > >
> >=20
