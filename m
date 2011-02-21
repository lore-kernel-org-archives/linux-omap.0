From: David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during fault handling
Date: Mon, 21 Feb 2011 11:07:01 +0200
Message-ID: <AANLkTimdWknRuk+QSV3bFU=qQGMsmmH-dj6a_QaTp49r@mail.gmail.com>
References: <1297884951-3019-1-git-send-email-dacohen@gmail.com>
	<1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40529 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753264Ab1BUJHC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 04:07:02 -0500
Received: by wyb38 with SMTP id 38so873695wyb.19
        for <linux-omap@vger.kernel.org>; Mon, 21 Feb 2011 01:07:01 -0800 (PST)
In-Reply-To: <20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

On Mon, Feb 21, 2011 at 10:18 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>=
 wrote:
> From: David Cohen <dacohen@gmail.com>
> Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during f=
ault handling
> Date: Wed, 16 Feb 2011 21:35:51 +0200
>
>> Add support to register an isr for IOMMU fault situations and adapt =
it
>> to allow such (*isr)() to be used as fault callback. Drivers using I=
OMMU
>> module might want to be informed when errors happen in order to debu=
g it
>> or react.
>>
>> Signed-off-by: David Cohen <dacohen@gmail.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/iommu2.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0| =C2=A0 17 +++++++++-
>> =C2=A0arch/arm/plat-omap/include/plat/iommu.h | =C2=A0 14 ++++++++-
>> =C2=A0arch/arm/plat-omap/iommu.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 52 ++++++++++++++++++++++---------
>> =C2=A03 files changed, 65 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iomm=
u2.c
>> index 49a1e5e..adb083e 100644
>> --- a/arch/arm/mach-omap2/iommu2.c
>> +++ b/arch/arm/mach-omap2/iommu2.c
>> @@ -146,18 +146,31 @@ static void omap2_iommu_set_twl(struct iommu *=
obj, bool on)
>> =C2=A0static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 u32 stat, da;
>> + =C2=A0 =C2=A0 u32 errs =3D 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
>> =C2=A0 =C2=A0 =C2=A0 stat &=3D MMU_IRQ_MASK;
>> - =C2=A0 =C2=A0 if (!stat)
>> + =C2=A0 =C2=A0 if (!stat) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ra =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>> + =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 da =3D iommu_read_reg(obj, MMU_FAULT_AD);
>> =C2=A0 =C2=A0 =C2=A0 *ra =3D da;
>>
>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TLBMISS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR=
_TLB_MISS;
>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR=
_TRANS_FAULT;
>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_EMUMISS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR=
_EMU_MISS;
>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR=
_TBLWALK_FAULT;
>> + =C2=A0 =C2=A0 if (stat & MMU_IRQ_MULTIHITFAULT)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errs |=3D OMAP_IOMMU_ERR=
_MULTIHIT_FAULT;
>> =C2=A0 =C2=A0 =C2=A0 iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>>
>> - =C2=A0 =C2=A0 return stat;
>> + =C2=A0 =C2=A0 return errs;
>> =C2=A0}
>>
>> =C2=A0static void omap2_tlb_read_cr(struct iommu *obj, struct cr_reg=
s *cr)
>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/plat=
-omap/include/plat/iommu.h
>> index 19cbb5e..174f1b9 100644
>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>> @@ -31,6 +31,7 @@ struct iommu {
>> =C2=A0 =C2=A0 =C2=A0 struct clk =C2=A0 =C2=A0 =C2=A0*clk;
>> =C2=A0 =C2=A0 =C2=A0 void __iomem =C2=A0 =C2=A0*regbase;
>> =C2=A0 =C2=A0 =C2=A0 struct device =C2=A0 *dev;
>> + =C2=A0 =C2=A0 void =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*isr_p=
riv;
>
> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
> used for iommu but client needs the place to pass its info to its
> custom handler. Any better idea?

(*isr)() relies in the same situation, as it belongs to the client.
Without this priv_data, it's necessary to create a global variable to
store client's private data on client side. IMO, it is worse.

Br,

David

>
>
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0refcount;
>> =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0iommu_lock; =C2=A0 =C2=
=A0 /* global for this whole object */
>> @@ -47,7 +48,7 @@ struct iommu {
>> =C2=A0 =C2=A0 =C2=A0 struct list_head =C2=A0 =C2=A0 =C2=A0 =C2=A0mma=
p;
>> =C2=A0 =C2=A0 =C2=A0 struct mutex =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mmap_lock; /* protect mmap */
>>
>> - =C2=A0 =C2=A0 int (*isr)(struct iommu *obj);
>> + =C2=A0 =C2=A0 int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs=
, void *priv);
>>
>> =C2=A0 =C2=A0 =C2=A0 void *ctx; /* iommu context: registres saved ar=
ea */
>> =C2=A0 =C2=A0 =C2=A0 u32 da_start;
>> @@ -109,6 +110,13 @@ struct iommu_platform_data {
>> =C2=A0 =C2=A0 =C2=A0 u32 da_end;
>> =C2=A0};
>>
>> +/* IOMMU errors */
>> +#define OMAP_IOMMU_ERR_TLB_MISS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(1 << 0)
>> +#define OMAP_IOMMU_ERR_TRANS_FAULT =C2=A0 (1 << 1)
>> +#define OMAP_IOMMU_ERR_EMU_MISS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(1 << 2)
>> +#define OMAP_IOMMU_ERR_TBLWALK_FAULT (1 << 3)
>> +#define OMAP_IOMMU_ERR_MULTIHIT_FAULT =C2=A0 =C2=A0 =C2=A0 =C2=A0(1=
 << 4)
>> +
>> =C2=A0#if defined(CONFIG_ARCH_OMAP1)
>> =C2=A0#error "iommu for this processor not implemented yet"
>> =C2=A0#else
>> @@ -161,6 +169,10 @@ extern size_t iopgtable_clear_entry(struct iomm=
u *obj, u32 iova);
>> =C2=A0extern int iommu_set_da_range(struct iommu *obj, u32 start, u3=
2 end);
>> =C2=A0extern struct iommu *iommu_get(const char *name);
>> =C2=A0extern void iommu_put(struct iommu *obj);
>> +extern int iommu_set_isr(const char *name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int (*isr)(struct iommu *obj, u32 da, u32 iommu_errs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *priv),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0void *isr_priv);
>>
>> =C2=A0extern void iommu_save_ctx(struct iommu *obj);
>> =C2=A0extern void iommu_restore_ctx(struct iommu *obj);
>> diff --git a/arch/arm/plat-omap/iommu.c b/arch/arm/plat-omap/iommu.c
>> index f55f458..b0e0efc 100644
>> --- a/arch/arm/plat-omap/iommu.c
>> +++ b/arch/arm/plat-omap/iommu.c
>> @@ -780,25 +780,19 @@ static void iopgtable_clear_entry_all(struct i=
ommu *obj)
>> =C2=A0 */
>> =C2=A0static irqreturn_t iommu_fault_handler(int irq, void *data)
>> =C2=A0{
>> - =C2=A0 =C2=A0 u32 stat, da;
>> + =C2=A0 =C2=A0 u32 da, errs;
>> =C2=A0 =C2=A0 =C2=A0 u32 *iopgd, *iopte;
>> - =C2=A0 =C2=A0 int err =3D -EIO;
>> =C2=A0 =C2=A0 =C2=A0 struct iommu *obj =3D data;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!obj->refcount)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;
>>
>> - =C2=A0 =C2=A0 /* Dynamic loading TLB or PTE */
>> - =C2=A0 =C2=A0 if (obj->isr)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D obj->isr(obj);
>> -
>> - =C2=A0 =C2=A0 if (!err)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
>> -
>> =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
>> - =C2=A0 =C2=A0 stat =3D iommu_report_fault(obj, &da);
>> + =C2=A0 =C2=A0 errs =3D iommu_report_fault(obj, &da);
>> =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
>> - =C2=A0 =C2=A0 if (!stat)
>> +
>> + =C2=A0 =C2=A0 /* Fault callback or TLB/PTE Dynamic loading */
>> + =C2=A0 =C2=A0 if (obj->isr && !obj->isr(obj, da, errs, obj->isr_pr=
iv))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
>>
>> =C2=A0 =C2=A0 =C2=A0 iommu_disable(obj);
>> @@ -806,15 +800,16 @@ static irqreturn_t iommu_fault_handler(int irq=
, void *data)
>> =C2=A0 =C2=A0 =C2=A0 iopgd =3D iopgd_offset(obj, da);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!iopgd_is_table(*iopgd)) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s: d=
a:%08x pgd:%p *pgd:%08x\n", obj->name,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 da, iopgd, *iopgd);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(obj->dev, "%s: e=
rrs:0x%08x da:0x%08x pgd:0x%p "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 "*pgd:px%08x\n", obj->name, errs, da, iopgd, *iopgd);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> =C2=A0 =C2=A0 =C2=A0 iopte =3D iopte_offset(iopgd, da);
>>
>> - =C2=A0 =C2=A0 dev_err(obj->dev, "%s: da:%08x pgd:%p *pgd:%08x pte:=
%p *pte:%08x\n",
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obj->name, da, iopgd, *i=
opgd, iopte, *iopte);
>> + =C2=A0 =C2=A0 dev_err(obj->dev, "%s: errs:0x%08x da:0x%08x pgd:0x%=
p *pgd:0x%08x "
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "pte:0x%p *pte:0x%08x\n"=
, obj->name, errs, da, iopgd, *iopgd,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iopte, *iopte);
>>
>> =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE;
>> =C2=A0}
>> @@ -917,6 +912,33 @@ void iommu_put(struct iommu *obj)
>> =C2=A0}
>> =C2=A0EXPORT_SYMBOL_GPL(iommu_put);
>>
>> +int iommu_set_isr(const char *name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int (*isr)(struct=
 iommu *obj, u32 da, u32 iommu_errs,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0void *priv),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *isr_priv)
>> +{
>> + =C2=A0 =C2=A0 struct device *dev;
>> + =C2=A0 =C2=A0 struct iommu *obj;
>> +
>> + =C2=A0 =C2=A0 dev =3D driver_find_device(&omap_iommu_driver.driver=
, NULL, (void *)name,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_match_by_alias);
>> + =C2=A0 =C2=A0 if (!dev)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>> +
>> + =C2=A0 =C2=A0 obj =3D to_iommu(dev);
>> + =C2=A0 =C2=A0 mutex_lock(&obj->iommu_lock);
>> + =C2=A0 =C2=A0 if (obj->refcount !=3D 0) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&obj->iommu=
_lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EBUSY;
>> + =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 obj->isr =3D isr;
>> + =C2=A0 =C2=A0 obj->isr_priv =3D isr_priv;
>> + =C2=A0 =C2=A0 mutex_unlock(&obj->iommu_lock);
>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(iommu_set_isr);
>> +
>> =C2=A0/*
>> =C2=A0 * =C2=A0 OMAP Device MMU(IOMMU) detection
>> =C2=A0 */
>> --
>> 1.7.2.3
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
