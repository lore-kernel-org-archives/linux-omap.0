From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during fault handling
Date: Wed, 16 Feb 2011 18:28:49 +0200
Message-ID: <AANLkTikcd9EkgUpm9JMPoiG+O3_CVBGO9T_45Me-qWn3@mail.gmail.com>
References: <1297780591-15613-1-git-send-email-dacohen@gmail.com>
	<1297780591-15613-2-git-send-email-dacohen@gmail.com>
	<20110215.164822.811675675026794737.Hiroshi.DOYU@nokia.com>
	<AANLkTikK0zAYtSaA1LCdkn2t4_XiTH_DmESEzw8MLvfU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:60850 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121Ab1BPQ2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 11:28:50 -0500
Received: by iyj8 with SMTP id 8so1383439iyj.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 08:28:50 -0800 (PST)
In-Reply-To: <AANLkTikK0zAYtSaA1LCdkn2t4_XiTH_DmESEzw8MLvfU@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Tue, Feb 15, 2011 at 5:10 PM, David Cohen <dacohen@gmail.com> wrote:
> On Tue, Feb 15, 2011 at 4:48 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
>> Hi David,
>
> Hi Hiroshi,
>
>>
>> Sorry for a bit late reply....
>
> You're just in time. :)
>
>>
>> From: David Cohen <dacohen@gmail.com>
>> Subject: [PATCH v2 1/1] OMAP: IOMMU: add support to callback during =
fault handling
>> Date: Tue, 15 Feb 2011 16:36:31 +0200
>>
>>> Add support to register a callback for IOMMU fault situations. Driv=
ers using
>>> IOMMU module might want to be informed when such errors happen in o=
rder to
>>> debug it or react.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 21 +++++++++++++--
>>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 15 +++++++++=
+-
>>> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0| =C2=A0 41 ++++++++++++++++++++++++++++---
>>> =C2=A03 files changed, 69 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iom=
mu2.c
>>> index 14ee686..504310d 100644
>>> --- a/arch/arm/mach-omap2/iommu2.c
>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>> @@ -143,10 +143,10 @@ static void omap2_iommu_set_twl(struct iommu =
*obj, bool on)
>>> =C2=A0 =C2=A0 =C2=A0 __iommu_set_twl(obj, false);
>>> =C2=A0}
>>>
>>> -static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *=
iommu_errs)
>>> =C2=A0{
>>> =C2=A0 =C2=A0 =C2=A0 int i;
>>> - =C2=A0 =C2=A0 u32 stat, da;
>>> + =C2=A0 =C2=A0 u32 stat, da, errs;
>>> =C2=A0 =C2=A0 =C2=A0 const char *err_msg[] =3D {
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "tlb miss",
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "translation fault=
",
>>> @@ -157,8 +157,10 @@ static u32 omap2_iommu_fault_isr(struct iommu =
*obj, u32 *ra)
>>>
>>> =C2=A0 =C2=A0 =C2=A0 stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
>>> =C2=A0 =C2=A0 =C2=A0 stat &=3D MMU_IRQ_MASK;
>>> - =C2=A0 =C2=A0 if (!stat)
>>> + =C2=A0 =C2=A0 if (!stat) {
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *iommu_errs =3D 0;
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>> + =C2=A0 =C2=A0 }
>>>
>>> =C2=A0 =C2=A0 =C2=A0 da =3D iommu_read_reg(obj, MMU_FAULT_AD);
>>> =C2=A0 =C2=A0 =C2=A0 *ra =3D da;
>>> @@ -171,6 +173,19 @@ static u32 omap2_iommu_fault_isr(struct iommu =
*obj, u32 *ra)
>>> =C2=A0 =C2=A0 =C2=A0 }
>>> =C2=A0 =C2=A0 =C2=A0 printk("\n");
>>>
>>> + =C2=A0 =C2=A0 errs =3D 0;
>>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TLBMISS)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ER=
R_TLB_MISS;
>>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ER=
R_TRANS_FAULT;
>>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_EMUMISS)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ER=
R_EMU_MISS;
>>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ER=
R_TBLWALK_FAULT;
>>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_MULTIHITFAULT)
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ER=
R_MULTIHIT_FAULT;
>>> + =C2=A0 =C2=A0 *iommu_errs =3D errs;
>>> +
>>> =C2=A0 =C2=A0 =C2=A0 iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>>>
>>> =C2=A0 =C2=A0 =C2=A0 return stat;
>>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/pla=
t-omap/include/plat/iommu.h
>>> index 19cbb5e..5a2475f 100644
>>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>>> @@ -31,6 +31,7 @@ struct iommu {
>>> =C2=A0 =C2=A0 =C2=A0 struct clk =C2=A0 =C2=A0 =C2=A0*clk;
>>> =C2=A0 =C2=A0 =C2=A0 void __iomem =C2=A0 =C2=A0*regbase;
>>> =C2=A0 =C2=A0 =C2=A0 struct device =C2=A0 *dev;
>>> + =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*faul=
t_cb_priv;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0refcount;
>>> =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0iommu_lock; =C2=A0 =C2=
=A0 /* global for this whole object */
>>> @@ -48,6 +49,7 @@ struct iommu {
>>> =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mmap_lock; /* protect mmap */
>>>
>>> =C2=A0 =C2=A0 =C2=A0 int (*isr)(struct iommu *obj);
>>> + =C2=A0 =C2=A0 void (*fault_cb)(struct iommu *obj, u32 da, u32 iom=
mu_errs, void *priv);
>>
>> What about making use of (*isr)() for fault call back as well?
>>
>> Basic concept is that, client can decide how to deal with iommu
>> fault. For example, for advanced case, client wants daynamic loading=
 of
>> TLB(or PTE), or for ISP case, clients just want more appropriate fau=
lt
>> reporting. This (*isr)() could be used in such flexibility.
>
> In this case, it seems we can re-use it.
>
>>
>> =C2=A0 785 =C2=A0 * =C2=A0 =C2=A0 =C2=A0Device IOMMU generic operati=
ons
>> =C2=A0 786 =C2=A0 */
>> =C2=A0 787 =C2=A0static irqreturn_t iommu_fault_handler(int irq, voi=
d *data)
>> =C2=A0 788 =C2=A0{
>> =C2=A0 789 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 stat, da;
>> =C2=A0 790 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *iopgd, *iopte;
>> =C2=A0 791 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int err =3D -EIO;
>> =C2=A0 792 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu *obj =3D d=
ata;
>> =C2=A0 793
>> =C2=A0 794 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj->refcount)
>> =C2=A0 795 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return IRQ_NONE;
>> =C2=A0 796
>> =C2=A0 797 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Dynamic loading TLB =
or PTE */
>> =C2=A0 798 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (obj->isr)
>> =C2=A0 799 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0err =3D obj->isr(obj);
>> =C2=A0 800
>> =C2=A0 801 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!err)
>> =C2=A0 802 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return IRQ_HANDLED;
>> =C2=A0 803
>> =C2=A0 804 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_enable(obj->clk);
>> =C2=A0 805 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat =3D iommu_report_f=
ault(obj, &da);
>> =C2=A0 806 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(obj->clk);
>> =C2=A0 807 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!stat)
>> =C2=A0 808 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return IRQ_HANDLED;
>> =C2=A0 809
>> =C2=A0 810 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_disable(obj);
>>
>> I guess that this modifying the above code could make (*isr)()
>> flexible to be used for any purpose for clients? For me, having both
>> following may be a bit residual.
>

There are few possible issues in this case. (*isr)() is meant to
replace the generic fault handler on iommu, but the fault callback
isn't. Basically fault callback needs to call specific iommu fault
report to know faulty 'da' and iommu errors, so part of the generic
fault handler must be called.

One possible solution is always call specific fault report before
(*isr)(). IMO it makes sense as (*isr)() might want to know at least
the current faults.
But in this case, specific fault report should not print anything else
as only the upper layer and user will know when a fault is actually an
error or not. So, they're responsible for error messages.

I'm sending a v3 with these changes. Comments will be welcome.

Br,

David

> I agree. We need to add 'void *isr_priv' to iommu struct and the
> function to register isr.
> I'll send a v3 soon.
>
> Regards,
>
> David
>
>>
>>> =C2=A0 =C2=A0 =C2=A0 int (*isr)(struct iommu *obj);
>>> + =C2=A0 =C2=A0 void (*fault_cb)(struct iommu *obj, u32 da, u32 iom=
mu_errs, void *priv);
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
