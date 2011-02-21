From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 12:43:07 -0600
Message-ID: <AANLkTikbjZ7GH7+bx94r6saYuGzCt9aito-Y8NS94SoQ@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:37423 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752039Ab1BUSuY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Feb 2011 13:50:24 -0500
Received: by mail-gy0-f182.google.com with SMTP id 4so1289754gyh.41
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 10:50:23 -0800 (PST)
In-Reply-To: <1297884951-3019-3-git-send-email-dacohen@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <dacohen@gmail.com>
Cc: hiroshi.doyu@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>

Hi,

On Wed, Feb 16, 2011 at 1:35 PM, David Cohen <dacohen@gmail.com> wrote:
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu=
2.c
> index 49a1e5e..adb083e 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
=2E..
>
> =A0 =A0 =A0 =A0da =3D iommu_read_reg(obj, MMU_FAULT_AD);
> =A0 =A0 =A0 =A0*ra =3D da;
>
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TLBMISS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TLB_MISS;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TRANS_FAULT;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_EMUMISS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_EMU_MISS;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TBLWALK_FAULT;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_MULTIHITFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_MULTIHIT_FAULT=
;

I still don't think this adds any value, "generic layer" and omap
errors are the same thing in this case... OTOH OMAP 1710 (not
supported by iommu yet) has the following bits:

3 Prefetch_err
2 Perm_fault
1 Tlb_miss
0 Trans_fault

They don't match any of your "generic layer errors" masks for reading,
hence more generic errors will need to be defined, and then more OMAP#
masks... I think we just need to stick with the mach specific errors,
and let mach code handle its specifics when reporting.

But anyway it is just me...

> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
> index f55f458..b0e0efc 100644
> --- a/arch/arm/plat-omap/iommu.c
> +++ b/arch/arm/plat-omap/iommu.c
> @@ -780,25 +780,19 @@ static void iopgtable_clear_entry_all(struct io=
mmu *obj)
> =A0*/
> =A0static irqreturn_t iommu_fault_handler(int irq, void *data)
> =A0{
> - =A0 =A0 =A0 u32 stat, da;
> + =A0 =A0 =A0 u32 da, errs;
> =A0 =A0 =A0 =A0u32 *iopgd, *iopte;
> - =A0 =A0 =A0 int err =3D -EIO;
> =A0 =A0 =A0 =A0struct iommu *obj =3D data;
>
> =A0 =A0 =A0 =A0if (!obj->refcount)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_NONE;
>
> - =A0 =A0 =A0 /* Dynamic loading TLB or PTE */
> - =A0 =A0 =A0 if (obj->isr)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D obj->isr(obj);
> -
> - =A0 =A0 =A0 if (!err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> -
> =A0 =A0 =A0 =A0clk_enable(obj->clk);
> - =A0 =A0 =A0 stat =3D iommu_report_fault(obj, &da);
> + =A0 =A0 =A0 errs =3D iommu_report_fault(obj, &da);
> =A0 =A0 =A0 =A0clk_disable(obj->clk);
> - =A0 =A0 =A0 if (!stat)
> +
> + =A0 =A0 =A0 /* Fault callback or TLB/PTE Dynamic loading */
> + =A0 =A0 =A0 if (obj->isr && !obj->isr(obj, da, errs, obj->isr_priv)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_HANDLED;

BTW, why not changing the name isr for cb, it is confusing since there
is another fault_isr called by mmu, AFAIK nobody uses obj->isr

> =A0 =A0 =A0 =A0iommu_disable(obj);
> @@ -806,15 +800,16 @@ static irqreturn_t iommu_fault_handler(int irq,=
 void *data)
> =A0 =A0 =A0 =A0iopgd =3D iopgd_offset(obj, da);
>
> =A0 =A0 =A0 =A0if (!iopgd_is_table(*iopgd)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *=
pgd:%08x\n", obj->name,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 da, iopgd, *iopgd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(obj->dev, "%s: errs:0x%08x da:0=
x%08x pgd:0x%p "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "*pgd:px%08x\n", obj->n=
ame, errs, da, iopgd, *iopgd);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return IRQ_NONE;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0iopte =3D iopte_offset(iopgd, da);
>
> - =A0 =A0 =A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p =
*pte:%08x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 obj->name, da, iopgd, *iopgd, iopte, *i=
opte);
> + =A0 =A0 =A0 dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%p *=
pgd:0x%08x "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "pte:0x%p *pte:0x%08x\n", obj->name, er=
rs, da, iopgd, *iopgd,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iopte, *iopte);
>
> =A0 =A0 =A0 =A0return IRQ_NONE;
> =A0}
> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
> =A0}
> =A0EXPORT_SYMBOL_GPL(iommu_put);
>
> +int iommu_set_isr(const char *name,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int (*isr)(struct iommu *obj, u32 d=
a, u32 iommu_errs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *priv),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *isr_priv)

So I think the following will be bad practice:

        mmu =3D iommu_get("iva2");
        if (!IS_ERR(mmu))
                mmu->isr =3D mmu_fault_callback;

Shall we think anything to prevent such mis-usage?

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
