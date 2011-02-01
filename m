From: David Cohen <david.cohen@nokia.com>
Subject: Re: [PATCH 2/2] OMAP: Cleanup IOMMU error messages
Date: Tue, 1 Feb 2011 10:41:24 +0200
Message-ID: <20110201084124.GA3499@esdhcp04381.research.nokia.com>
References: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
 <1296494708-17569-3-git-send-email-david.cohen@nokia.com>
 <AANLkTinC+6ypf3+7NTc32Jj8jXE3MnZf-mvQ-aLKyP-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:41221 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab1BAIhW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Feb 2011 03:37:22 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinC+6ypf3+7NTc32Jj8jXE3MnZf-mvQ-aLKyP-7@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

On Mon, Jan 31, 2011 at 09:16:30PM -0600, ext Ramirez Luna, Omar wrote:
> Hi David,

Hi Ramirez,

Thanks for the comments.

>=20
> On Mon, Jan 31, 2011 at 11:25 AM, David Cohen <david.cohen@nokia.com>=
 wrote:
> > IOMMU error messages are duplicated. They're printed on IOMMU speci=
fic
> > layer for OMAP2,3 and once again on the above layer. With this patc=
h,
> > the error message is printed on the above layer only.
>=20
> So, you say they are duplicated, previously the type of fault was
> printed in the omap2,3 code and the addresses involving the error
> printed on plat code... with this patch both messages are printed on
> plat code, I don't see where the duplication/fix is about.
>=20

A little bit of my context:

I'm working on OMAP3ISP driver. Due to hw or sw issues, iommu errors
(mainly iommu faults) are not so rare to happen. e.g. I have 2 hw issue=
s
being workarounded on ISP H3A submodule (one of those a bit serious)
which may lead to iommu faults.
With the current implementation, the error messages are a bit useless
and much "heavy". For each "fault", 2 error lines are printed to show t=
he
same error. On ISP context, usually it will happen *many* times in a
row, making the device not usable even to debug the issue. And the bad
side is we cannot get anything out of those messages which could help t=
o
point out where is the problem. As sometimes it's difficult to reproduc=
e it,
we loose a good chance to show a bit more useful data about the trigger=
ed
error.

My main intentions are:
 - Get rid of one line.
 - TODO: Print something useful to let developers to *know* what is
   going on.
 - TODO: Avoid to flood console to let it able to debug.

> AFAIK, your patch removes this line:
>=20
>  -       dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
>=20
> Which I assume is the one being printed again in plat code, right?

Yes.

>=20
> > Signed-off-by: David Cohen <david.cohen@nokia.com>
> > ---
> > =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 33 +++=
++++++++++--------------
> > =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 =A02 +-
> > =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 36 +=
+++++++++++++++++++----------
> > =A03 files changed, 41 insertions(+), 30 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iom=
mu2.c
> > index 14ee686..bb3d75b 100644
> > --- a/arch/arm/mach-omap2/iommu2.c
> > +++ b/arch/arm/mach-omap2/iommu2.c
> > @@ -143,33 +143,32 @@ static void omap2_iommu_set_twl(struct iommu =
*obj, bool on)
> > =A0 =A0 =A0 =A0__iommu_set_twl(obj, false);
> > =A0}
> >
> > -static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> > +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *=
iommu_errs)
> > =A0{
> > - =A0 =A0 =A0 int i;
> > + =A0 =A0 =A0 u32 errs =3D 0;
> > =A0 =A0 =A0 =A0u32 stat, da;
> > - =A0 =A0 =A0 const char *err_msg[] =3D {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "tlb miss",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "translation fault",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "emulation miss",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "table walk fault",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "multi hit fault",
> > - =A0 =A0 =A0 };
>=20
> AFAIU, this code living in mach-omap2, means that this errors are
> common for omap2,3,4 which they are. Does moving them to plat code
> implies that all omap platforms expect these errors?

That's true. I can work on a different approach.

>=20
> > =A0 =A0 =A0 =A0stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
> > =A0 =A0 =A0 =A0stat &=3D MMU_IRQ_MASK;
> > - =A0 =A0 =A0 if (!stat)
> > + =A0 =A0 =A0 if (!stat) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *iommu_errs =3D 0;
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> > + =A0 =A0 =A0 }
> >
> > =A0 =A0 =A0 =A0da =3D iommu_read_reg(obj, MMU_FAULT_AD);
> > =A0 =A0 =A0 =A0*ra =3D da;
> >
> > - =A0 =A0 =A0 dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> > -
> > - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(err_msg); i++) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & (1 << i))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s ", err_msg=
[i]);
> > - =A0 =A0 =A0 }
> > - =A0 =A0 =A0 printk("\n");
> > + =A0 =A0 =A0 if (stat & MMU_IRQ_TLBMISS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TLB_MISS;
> > + =A0 =A0 =A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TRANS_FAULT;
> > + =A0 =A0 =A0 if (stat & MMU_IRQ_EMUMISS)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_EMU_MISS;
> > + =A0 =A0 =A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TBLWALK_FAULT;
> > + =A0 =A0 =A0 if (stat & MMU_IRQ_MULTIHITFAULT)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_MULTIHIT_FAULT;
> > + =A0 =A0 =A0 *iommu_errs =3D errs;
>=20
> Is there any point in doing this?
>=20
> Basically: *iommu_errs =3D stat, given that the mask values and the
> error defines are the same for each case.

True. But can I assume a specific register value will always match to
the "generic" layer?

>=20
> Besides I haven't seen two errors trigger a single interrupt.

Me neither, but the current implementation assumes it can happen and my
concern is to not change it here.

>=20
> ...
> >
> > - =A0 =A0 =A0 iopte =3D iopte_offset(iopgd, da);
> > -
> > - =A0 =A0 =A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%=
p *pte:%08x\n",
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, da, iopgd, *iopgd, iopte, *=
iopte);
> > + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(err_msg); i++) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (errs & (1 << i))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_CONT " %s=
", err_msg[i]);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 printk("\n");
>=20
> I think we should get rid of the "printks".

By working on a different approach for the printed messages, yes.

Regards,

David

>=20
> Regards,
>=20
> Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
