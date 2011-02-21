From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 23:12:20 +0200
Message-ID: <AANLkTi=rJZo2KwryYznFp6Qq25Oh0+F44OKV-khuQyte@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52787 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab1BUVMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 16:12:22 -0500
Received: by wwa36 with SMTP id 36so6551150wwa.1
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 13:12:20 -0800 (PST)
In-Reply-To: <AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>

On Mon, Feb 21, 2011 at 8:43 PM, Ramirez Luna, Omar <omar.ramirez@ti.co=
m> wrote:
> Hi,

Hi,

Thanks for the comments.

>
> On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrot=
e:
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iomm=
u2.c
>> index 49a1e5e..adb083e 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
> ...
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0da =3D iommu_read_reg(obj, MMU_FAULT_AD);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0*ra =3D da;
>>
>> + =C2=A0 =C2=A0 =C2=A0 if (stat & MMU_IRQ_TLBMISS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IO=
MMU_ERR_TLB_MISS;
>> + =C2=A0 =C2=A0 =C2=A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IO=
MMU_ERR_TRANS_FAULT;
>> + =C2=A0 =C2=A0 =C2=A0 if (stat & MMU_IRQ_EMUMISS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IO=
MMU_ERR_EMU_MISS;
>> + =C2=A0 =C2=A0 =C2=A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IO=
MMU_ERR_TBLWALK_FAULT;
>> + =C2=A0 =C2=A0 =C2=A0 if (stat & MMU_IRQ_MULTIHITFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IO=
MMU_ERR_MULTIHIT_FAULT;
>
> I still don't think this adds any value, "generic layer" and omap
> errors are the same thing in this case... OTOH OMAP 1710 (not
> supported by iommu yet) has the following bits:
>
> 3 Prefetch_err
> 2 Perm_fault
> 1 Tlb_miss
> 0 Trans_fault
>
> They don't match any of your "generic layer errors" masks for reading=
,

Have you noticed:
 0 =3D OMAP_IOMMU_ERR_TRANS_FAULT
 1 =3D OMAP_IOMMU_ERR_TLB_MISS

2 and 3 could be added.

> hence more generic errors will need to be defined, and then more OMAP=
#
> masks... I think we just need to stick with the mach specific errors,
> and let mach code handle its specifics when reporting.

How many are we talking about? I don't think every new OMAP version it
would completely re-invent IOMMU faults.
Generic errors codes make easier to threat possible IOMMU users which
have (partially or totally) common drivers for different OMAP
versions.
Unless it's really an out-of-control number of generic faults, I don't
see it as a real problem.

>
> But anyway it is just me...
>
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index f55f458..b0e0efc 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -780,25 +780,19 @@ static void iopgtable_clear_entry_all(struct i=
ommu *obj)
>> =C2=A0*/
>> =C2=A0static irqreturn_t iommu_fault_handler(int irq, void *data)
>> =C2=A0{
>> - =C2=A0 =C2=A0 =C2=A0 u32 stat, da;
>> + =C2=A0 =C2=A0 =C2=A0 u32 da, errs;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *iopgd, *iopte;
>> - =C2=A0 =C2=A0 =C2=A0 int err =3D -EIO;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iommu *obj =3D data;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj->refcount)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NO=
NE;
>>
>> - =C2=A0 =C2=A0 =C2=A0 /* Dynamic loading TLB or PTE */
>> - =C2=A0 =C2=A0 =C2=A0 if (obj->isr)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D obj->isr(=
obj);
>> -
>> - =C2=A0 =C2=A0 =C2=A0 if (!err)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLE=
D;
>> -
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_enable(obj->clk);
>> - =C2=A0 =C2=A0 =C2=A0 stat =3D iommu_report_fault(obj, &da);
>> + =C2=A0 =C2=A0 =C2=A0 errs =3D iommu_report_fault(obj, &da);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk_disable(obj->clk);
>> - =C2=A0 =C2=A0 =C2=A0 if (!stat)
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* Fault callback or TLB/PTE Dynamic loading =
*/
>> + =C2=A0 =C2=A0 =C2=A0 if (obj->isr && !obj->isr(obj, da, errs, obj-=
>isr_priv))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HA=
NDLED;
>
> BTW, why not changing the name isr for cb, it is confusing since ther=
e
> is another fault_isr called by mmu, AFAIK nobody uses obj->isr

The main purpose of this function is to be an ISR, not only callback.
But as you noticed, nobody is using it yet, but OMAP3 ISP should start
to use it soon.

>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_disable(obj);
>> @@ -806,15 +800,16 @@ static irqreturn_t iommu_fault_handler(int irq=
, void *data)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0iopgd =3D iopgd_offset(obj, da);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iopgd_is_table(*iopgd)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev,=
 "%s: da:%08x pgd:%p *pgd:%08x\n", obj->name,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 da, iopgd, *iopgd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev,=
 "%s: errs:0x%08x da:0x%08x pgd:0x%p "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 "*pgd:px%08x\n", obj->name, errs, da, iopgd, *iopgd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NO=
NE;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0iopte =3D iopte_offset(iopgd, da);
>>
>> - =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%0=
8x pte:%p *pte:%08x\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj->name, da, io=
pgd, *iopgd, iopte, *iopte);
>> + =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x =
pgd:0x%p *pgd:0x%08x "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "pte:0x%p *pte:0x=
%08x\n", obj->name, errs, da, iopgd, *iopgd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iopte, *iopte);
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NONE;
>> =C2=A0}
>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(iommu_put);
>>
>> +int iommu_set_isr(const char *name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*isr)=
(struct iommu *obj, u32 da, u32 iommu_errs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *priv),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *isr_=
priv)
>
> So I think the following will be bad practice:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu =3D iommu_get("iva2");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!IS_ERR(mmu))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmu->isr =3D m=
mu_fault_callback;
>
> Shall we think anything to prevent such mis-usage?

Well, the IOMMU user has access to IOMMU obj, so it can not only
change the (*isr)() but to mess with a lot of other stuff. The only
way to prevent it is to avoid user to have obj. But then, this fix (or
issue) does not belong to this patch.

Br,

David

>
> Regards,
>
> Omar
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
