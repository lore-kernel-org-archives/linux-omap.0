From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 10:57:45 +0200
Message-ID: <AANLkTinTCGhH9HgGEr1ciHL5Vf+gQxecr17O6Z9OTOWv@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
	<20110221082240.GL3094@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36709 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab1BUI5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 03:57:46 -0500
Received: by wyb38 with SMTP id 38so867122wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 00:57:45 -0800 (PST)
In-Reply-To: <20110221082240.GL3094@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, Feb 21, 2011 at 10:22 AM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Feb 21, 2011 at 10:18:56AM +0200, Hiroshi DOYU wrote:
>> From: David Cohen <dacohen@gmail.com>
>> Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during =
fault handling
>> Date: Wed, 16 Feb 2011 21:35:51 +0200
>>
>> > Add support to register an isr for IOMMU fault situations and adap=
t it
>> > to allow such (*isr)() to be used as fault callback. Drivers using=
 IOMMU
>> > module might want to be informed when errors happen in order to de=
bug it
>> > or react.
>> >
>> > Signed-off-by: David Cohen <dacohen@gmail.com>
>> > ---
>> > =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 17 +++++++++-
>> > =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 14 ++++++++=
-
>> > =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++++++++---------
>> > =C2=A03 files changed, 65 insertions(+), 18 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/io=
mmu2.c
>> > index 49a1e5e..adb083e 100644
>> > --- a/arch/arm/mach-omap2/iommu2.c
>> > +++ b/arch/arm/mach-omap2/iommu2.c
>> > @@ -146,18 +146,31 @@ static void omap2_iommu_set_twl(struct iommu=
 *obj, bool on)
>> > =C2=A0static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>> > =C2=A0{
>> > =C2=A0 =C2=A0 u32 stat, da;
>> > + =C2=A0 u32 errs =3D 0;
>> >
>> > =C2=A0 =C2=A0 stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
>> > =C2=A0 =C2=A0 stat &=3D MMU_IRQ_MASK;
>> > - =C2=A0 if (!stat)
>> > + =C2=A0 if (!stat) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ra =3D 0;
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> > + =C2=A0 }
>> >
>> > =C2=A0 =C2=A0 da =3D iommu_read_reg(obj, MMU_FAULT_AD);
>> > =C2=A0 =C2=A0 *ra =3D da;
>> >
>> > + =C2=A0 if (stat & MMU_IRQ_TLBMISS)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR_TLB_=
MISS;
>> > + =C2=A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR_TRAN=
S_FAULT;
>> > + =C2=A0 if (stat & MMU_IRQ_EMUMISS)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR_EMU_=
MISS;
>> > + =C2=A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR_TBLW=
ALK_FAULT;
>> > + =C2=A0 if (stat & MMU_IRQ_MULTIHITFAULT)
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR_MULT=
IHIT_FAULT;
>> > =C2=A0 =C2=A0 iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>> >
>> > - =C2=A0 return stat;
>> > + =C2=A0 return errs;
>> > =C2=A0}
>> >
>> > =C2=A0static void omap2_tlb_read_cr(struct iommu *obj, struct cr_r=
egs *cr)
>> > diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/pl=
at-omap/include/plat/iommu.h
>> > index 19cbb5e..174f1b9 100644
>> > --- a/arch/arm/plat-omap/include/plat/iommu.h
>> > +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> > @@ -31,6 +31,7 @@ struct iommu {
>> > =C2=A0 =C2=A0 struct clk =C2=A0 =C2=A0 =C2=A0*clk;
>> > =C2=A0 =C2=A0 void __iomem =C2=A0 =C2=A0*regbase;
>> > =C2=A0 =C2=A0 struct device =C2=A0 *dev;
>> > + =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*isr_priv;
>>
>> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
>> used for iommu but client needs the place to pass its info to its
>> custom handler. Any better idea?
>
> I'm not sure if it makes sense as I don't know the mailbox block, but
> maybe moving to GENIRQ ? Then IRQ subsystem would take care of the
> "dev_id"

Not sure if it fits in this case. It's a different module (IOMMU user)
which needs to get a callback from IOMMU when a fault happens.
Is there any GENIRQ usage currently in this scenario?

Br,

David

>
> --
> balbi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
