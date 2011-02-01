From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH 2/2] OMAP: Cleanup IOMMU error messages
Date: Mon, 31 Jan 2011 21:16:30 -0600
Message-ID: <AANLkTinC+6ypf3+7NTc32Jj8jXE3MnZf-mvQ-aLKyP-7@mail.gmail.com>
References: <1296494708-17569-1-git-send-email-david.cohen@nokia.com>
	<1296494708-17569-3-git-send-email-david.cohen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:38058 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753581Ab1BADQb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 22:16:31 -0500
Received: by mail-yi0-f48.google.com with SMTP id 17so2501561yib.35
        for <linux-omap@vger.kernel.org>; Mon, 31 Jan 2011 19:16:30 -0800 (PST)
In-Reply-To: <1296494708-17569-3-git-send-email-david.cohen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Cohen <david.cohen@nokia.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Hi David,

On Mon, Jan 31, 2011 at 11:25 AM, David Cohen <david.cohen@nokia.com> w=
rote:
> IOMMU error messages are duplicated. They're printed on IOMMU specifi=
c
> layer for OMAP2,3 and once again on the above layer. With this patch,
> the error message is printed on the above layer only.

So, you say they are duplicated, previously the type of fault was
printed in the omap2,3 code and the addresses involving the error
printed on plat code... with this patch both messages are printed on
plat code, I don't see where the duplication/fix is about.

AFAIK, your patch removes this line:

 -       dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);

Which I assume is the one being printed again in plat code, right?

> Signed-off-by: David Cohen <david.cohen@nokia.com>
> ---
> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 33 +++++=
++++++++--------------
> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 =A02 +-
> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 36 +++=
+++++++++++++++++----------
> =A03 files changed, 41 insertions(+), 30 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu=
2.c
> index 14ee686..bb3d75b 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -143,33 +143,32 @@ static void omap2_iommu_set_twl(struct iommu *o=
bj, bool on)
> =A0 =A0 =A0 =A0__iommu_set_twl(obj, false);
> =A0}
>
> -static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
> +static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra, u32 *io=
mmu_errs)
> =A0{
> - =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u32 errs =3D 0;
> =A0 =A0 =A0 =A0u32 stat, da;
> - =A0 =A0 =A0 const char *err_msg[] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "tlb miss",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "translation fault",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "emulation miss",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "table walk fault",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "multi hit fault",
> - =A0 =A0 =A0 };

AFAIU, this code living in mach-omap2, means that this errors are
common for omap2,3,4 which they are. Does moving them to plat code
implies that all omap platforms expect these errors?

> =A0 =A0 =A0 =A0stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
> =A0 =A0 =A0 =A0stat &=3D MMU_IRQ_MASK;
> - =A0 =A0 =A0 if (!stat)
> + =A0 =A0 =A0 if (!stat) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *iommu_errs =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0da =3D iommu_read_reg(obj, MMU_FAULT_AD);
> =A0 =A0 =A0 =A0*ra =3D da;
>
> - =A0 =A0 =A0 dev_err(obj->dev, "%s:\tda:%08x ", __func__, da);
> -
> - =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(err_msg); i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (stat & (1 << i))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("%s ", err_msg[i=
]);
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 printk("\n");
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TLBMISS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TLB_MISS;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TRANS_FAULT;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_EMUMISS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_EMU_MISS;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_TBLWALK_FAULT;
> + =A0 =A0 =A0 if (stat & MMU_IRQ_MULTIHITFAULT)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D IOMMU_ERR_MULTIHIT_FAULT;
> + =A0 =A0 =A0 *iommu_errs =3D errs;

Is there any point in doing this?

Basically: *iommu_errs =3D stat, given that the mask values and the
error defines are the same for each case.

Besides I haven't seen two errors trigger a single interrupt.

=2E..
>
> - =A0 =A0 =A0 iopte =3D iopte_offset(iopgd, da);
> -
> - =A0 =A0 =A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:%p =
*pte:%08x\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, da, iopgd, *iopgd, iopte, *io=
pte);
> + =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(err_msg); i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (errs & (1 << i))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_CONT " %s",=
 err_msg[i]);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 printk("\n");

I think we should get rid of the "printks".

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
