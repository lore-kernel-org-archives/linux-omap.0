From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during
 fault handling
Date: Mon, 21 Feb 2011 11:51:23 +0200 (EET)
Message-ID: <20110221.115123.739189211216197016.Hiroshi.DOYU@nokia.com>
References: <1297884951-3019-3-git-send-email-dacohen@gmail.com>
	<20110221.101856.76372714451194378.Hiroshi.DOYU@nokia.com>
	<AANLkTimdWknRuk+QSV3bFU=qQGMsmmH-dj6a_QaTp49r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:43355 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386Ab1BUJvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Feb 2011 04:51:51 -0500
In-Reply-To: <AANLkTimdWknRuk+QSV3bFU=qQGMsmmH-dj6a_QaTp49r@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dacohen@gmail.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com

=46rom: ext David Cohen <dacohen@gmail.com>
Subject: Re: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during=
 fault handling
Date: Mon, 21 Feb 2011 11:07:01 +0200

> On Mon, Feb 21, 2011 at 10:18 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.co=
m> wrote:
>> From: David Cohen <dacohen@gmail.com>
>> Subject: [PATCH v3 2/2] OMAP: IOMMU: add support to callback during =
fault handling
>> Date: Wed, 16 Feb 2011 21:35:51 +0200
>>
>>> Add support to register an isr for IOMMU fault situations and adapt=
 it
>>> to allow such (*isr)() to be used as fault callback. Drivers using =
IOMMU
>>> module might want to be informed when errors happen in order to deb=
ug it
>>> or react.
>>>
>>> Signed-off-by: David Cohen <dacohen@gmail.com>
>>> ---
>>> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 17 +++=
++++++-
>>> =A0arch/arm/plat-omap/include/plat/iommu.h | =A0 14 ++++++++-
>>> =A0arch/arm/plat-omap/iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 52 +=
+++++++++++++++++++++---------
>>> =A03 files changed, 65 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iom=
mu2.c
>>> index 49a1e5e..adb083e 100644
>>> --- a/arch/arm/mach-omap2/iommu2.c
>>> +++ b/arch/arm/mach-omap2/iommu2.c
>>> @@ -146,18 +146,31 @@ static void omap2_iommu_set_twl(struct iommu =
*obj, bool on)
>>> =A0static u32 omap2_iommu_fault_isr(struct iommu *obj, u32 *ra)
>>> =A0{
>>> =A0 =A0 =A0 u32 stat, da;
>>> + =A0 =A0 u32 errs =3D 0;
>>>
>>> =A0 =A0 =A0 stat =3D iommu_read_reg(obj, MMU_IRQSTATUS);
>>> =A0 =A0 =A0 stat &=3D MMU_IRQ_MASK;
>>> - =A0 =A0 if (!stat)
>>> + =A0 =A0 if (!stat) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 *ra =3D 0;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> + =A0 =A0 }
>>>
>>> =A0 =A0 =A0 da =3D iommu_read_reg(obj, MMU_FAULT_AD);
>>> =A0 =A0 =A0 *ra =3D da;
>>>
>>> + =A0 =A0 if (stat & MMU_IRQ_TLBMISS)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TLB_MISS;
>>> + =A0 =A0 if (stat & MMU_IRQ_TRANSLATIONFAULT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TRANS_FAULT;
>>> + =A0 =A0 if (stat & MMU_IRQ_EMUMISS)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_EMU_MISS;
>>> + =A0 =A0 if (stat & MMU_IRQ_TABLEWALKFAULT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_TBLWALK_FAULT;
>>> + =A0 =A0 if (stat & MMU_IRQ_MULTIHITFAULT)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 errs |=3D OMAP_IOMMU_ERR_MULTIHIT_FAULT;
>>> =A0 =A0 =A0 iommu_write_reg(obj, stat, MMU_IRQSTATUS);
>>>
>>> - =A0 =A0 return stat;
>>> + =A0 =A0 return errs;
>>> =A0}
>>>
>>> =A0static void omap2_tlb_read_cr(struct iommu *obj, struct cr_regs =
*cr)
>>> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/arch/arm/pla=
t-omap/include/plat/iommu.h
>>> index 19cbb5e..174f1b9 100644
>>> --- a/arch/arm/plat-omap/include/plat/iommu.h
>>> +++ b/arch/arm/plat-omap/include/plat/iommu.h
>>> @@ -31,6 +31,7 @@ struct iommu {
>>> =A0 =A0 =A0 struct clk =A0 =A0 =A0*clk;
>>> =A0 =A0 =A0 void __iomem =A0 =A0*regbase;
>>> =A0 =A0 =A0 struct device =A0 *dev;
>>> + =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0*isr_priv;
>>
>> Ideally I'd like to avoid having "isr_priv" in iommu since it's not
>> used for iommu but client needs the place to pass its info to its
>> custom handler. Any better idea?
>=20
> (*isr)() relies in the same situation, as it belongs to the client.
> Without this priv_data, it's necessary to create a global variable to
> store client's private data on client side. IMO, it is worse.

Ok, I see. Let's go with this. Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
