From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH V3] OMAP3+: SR Layer Cleanup
Date: Thu, 12 May 2011 18:53:51 +0530
Message-ID: <BANLkTik4e=LiTUK1FgPsNWy3TqHGw55FRQ@mail.gmail.com>
References: <1305105166-26109-1-git-send-email-shweta.gulati@ti.com>
	<4DCBC74C.4020101@ti.com>
	<BANLkTinCjAh_huFr3Oy-RU81W=L=L5xohQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:41662 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756015Ab1ELNXy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 May 2011 09:23:54 -0400
Received: by mail-bw0-f48.google.com with SMTP id 8so2045878bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 12 May 2011 06:23:51 -0700 (PDT)
In-Reply-To: <BANLkTinCjAh_huFr3Oy-RU81W=L=L5xohQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Menon, Nishanth" <nm@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi,

On Thu, May 12, 2011 at 6:19 PM, Gulati, Shweta <shweta.gulati@ti.com> =
wrote:
> Hi,
>
> On Thu, May 12, 2011 at 5:11 PM, Cousson, Benoit <b-cousson@ti.com> w=
rote:
>> Hi Shweta,
>>
>> On 5/11/2011 11:12 AM, Gulati, Shweta wrote:
>>>
>>> To set sr ntarget values =A0for all volt_domain,
>>> volt_table is retrieved by doing a look_up of 'vdd_name'
>>> field from omap_hwmod but voltage domain pointer does not
>>> belong to omap_hwmod and is not used anywhere else.
>>> As a part of voltage layer and SR Layer clean up volt
>>> pointer is removed from omap_hwmod and added in dev
>>> attributes of SR.
>>>
>>> Tested on OMAP3630 SDP and OMAP4430 SDP Board
>>>
>>> Signed-off-by: Shweta Gulati<shweta.gulati@ti.com>
>>> Cc: Nishanth Menon<nm@ti.com>
>>> ---
>>> V3:
>>> =A0 =A0Changed the Subject and Rephrased Commit log as reviewed
>>> =A0 =A0by Nishanth Menon.
>>> =A0V2:
>>> =A0 =A0Rebased on latest 'pm-wip/voltdm_a' branch.
>>>
>>> =A0arch/arm/mach-omap2/omap_hwmod_3xxx_data.c =A0 | =A0 17 ++++++++=
+++++----
>>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c =A0 | =A0 19 ++++++++=
++++++++---
>>
>> Since this patch is touching some hwmod files, it will be good to Cc=
 Paul
>> and me. It is far from obvious from the subject that hwmod data are =
involved
>> in this patch.
> Will do
>>> =A0arch/arm/mach-omap2/smartreflex.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 1=
0 ++++++++++
>>> =A0arch/arm/mach-omap2/sr_device.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 11 +++++++----
>>> =A0arch/arm/plat-omap/include/plat/omap_hwmod.h | =A0 =A01 -
>>> =A05 files changed, 46 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>> b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>> index 3cd91ac..6a704bd 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
>>> @@ -29,6 +29,7 @@
>>>
>>> =A0#include "omap_hwmod_common_data.h"
>>>
>>> +#include "smartreflex.h"
>>> =A0#include "prm-regbits-34xx.h"
>>> =A0#include "cm-regbits-34xx.h"
>>> =A0#include "wd_timer.h"
>>> @@ -2904,6 +2905,10 @@ static struct omap_hwmod_class
>>> omap36xx_smartreflex_hwmod_class =3D {
>>> =A0};
>>>
>>> =A0/* SR1 */
>>> +static struct omap_sr_dev_attr sr1_dev_attr =3D {
>>> + =A0 =A0 =A0 .voltdm_name =A0 =3D "mpu_iva",
>>> +};
>>> +
>>> =A0static struct omap_hwmod_ocp_if *omap3_sr1_slaves[] =3D {
>>> =A0 =A0 =A0 =A0 &omap3_l4_core__sr1,
>>> =A0};
>>> @@ -2912,7 +2917,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1_hwmod",
>>> =A0 =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap34xx_smartreflex_=
hwmod_class,
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu_iva",
>>> =A0 =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>>> @@ -2924,6 +2928,7 @@ static struct omap_hwmod omap34xx_sr1_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3_sr1_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr1_slaves=
),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr1_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP3430ES2 |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 CHIP_IS_OMAP3430ES3_0 |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 CHIP_IS_OMAP3430ES3_1),
>>> @@ -2934,7 +2939,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr1_hwmod",
>>> =A0 =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap36xx_smartreflex_=
hwmod_class,
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr1_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu_iva",
>>> =A0 =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>>> @@ -2946,10 +2950,15 @@ static struct omap_hwmod omap36xx_sr1_hwmod=
 =3D {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3_sr1_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr1_slaves=
),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr1_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP3630ES1),
>>> =A0};
>>>
>>> =A0/* SR2 */
>>> +static struct omap_sr_dev_attr sr2_dev_attr =3D {
>>> + =A0 =A0 =A0 .voltdm_name =A0 =A0=3D "core",
>>> +};
>>> +
>>> =A0static struct omap_hwmod_ocp_if *omap3_sr2_slaves[] =3D {
>>> =A0 =A0 =A0 =A0 &omap3_l4_core__sr2,
>>> =A0};
>>> @@ -2958,7 +2967,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2_hwmod",
>>> =A0 =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap34xx_smartreflex_=
hwmod_class,
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
>>> =A0 =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>>> @@ -2970,6 +2978,7 @@ static struct omap_hwmod omap34xx_sr2_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3_sr2_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr2_slaves=
),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr2_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP3430ES2 |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 CHIP_IS_OMAP3430ES3_0 |
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 CHIP_IS_OMAP3430ES3_1),
>>> @@ -2980,7 +2989,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sr2_hwmod",
>>> =A0 =A0 =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D&omap36xx_smartreflex_=
hwmod_class,
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "sr2_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
>>> =A0 =A0 =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>>> @@ -2992,6 +3000,7 @@ static struct omap_hwmod omap36xx_sr2_hwmod =3D=
 {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap3_sr2_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap3_sr2_slaves=
),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr2_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP3630ES1),
>>> =A0};
>>>
>>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> index 3e88dd3..1331b39 100644
>>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>>> @@ -30,6 +30,7 @@
>>>
>>> =A0#include "omap_hwmod_common_data.h"
>>>
>>> +#include "smartreflex.h"
>>> =A0#include "cm1_44xx.h"
>>> =A0#include "cm2_44xx.h"
>>> =A0#include "prm44xx.h"
>>> @@ -3775,6 +3776,10 @@ static struct omap_hwmod_class
>>> omap44xx_smartreflex_hwmod_class =3D {
>>> =A0};
>>>
>>> =A0/* smartreflex_core */
>>> +static struct omap_sr_dev_attr sr_core_dev_attr =3D {
>>
>> In order to stick to the convention used so far for the other dev_at=
tr,
>> please use the following :
>> +/* smartreflex_core dev_attr */
>> +static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr =3D=
 {
>>
>>> + =A0 =A0 =A0 .voltdm_name =A0 =3D "core",
>>> +};
>>
>> And you should move it on top of the omap44xx_smartreflex_XXX_hwmod
>> structure.
> Will do.
>>> +
>>> =A0static struct omap_hwmod omap44xx_smartreflex_core_hwmod;
>>> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_core_irqs=
[] =3D {
>>> =A0 =A0 =A0 =A0 { .irq =3D 19 + OMAP44XX_IRQ_GIC_START },
>>> @@ -3809,7 +3814,6 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_core_hwmod =3D {
>>> =A0 =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_core=
_irqs,
>>> =A0 =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartrefl=
ex_core_irqs),
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "smartreflex_core_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "core",
>>> =A0 =A0 =A0 =A0 .prcm =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OM=
AP4430_CM_ALWON_SR_CORE_CLKCTRL,
>>> @@ -3817,10 +3821,15 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_core_hwmod =3D {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_co=
re_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartre=
flex_core_slaves),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr_core_dev_attr,
>>
>> Move .dev_attr before the .slaves.
=46ollowing the convention used with other dev_attr, all dev_attr are
defined after slaves.
>> The two last points are applicable for every SR instances.
> Ok.
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP4430),
>>> =A0};
>>>
>>> =A0/* smartreflex_iva */
>>> +static struct omap_sr_dev_attr sr_iva_dev_attr =3D {
>>> + =A0 =A0 =A0 .voltdm_name =A0 =3D "iva",
>>> +};
>>> +
>>> =A0static struct omap_hwmod omap44xx_smartreflex_iva_hwmod;
>>> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_iva_irqs[=
] =3D {
>>> =A0 =A0 =A0 =A0 { .irq =3D 102 + OMAP44XX_IRQ_GIC_START },
>>> @@ -3855,7 +3864,6 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_iva_hwmod =3D {
>>> =A0 =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_iva_=
irqs,
>>> =A0 =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartrefl=
ex_iva_irqs),
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "smartreflex_iva_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "iva",
>>> =A0 =A0 =A0 =A0 .prcm =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OM=
AP4430_CM_ALWON_SR_IVA_CLKCTRL,
>>> @@ -3863,10 +3871,15 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_iva_hwmod =3D {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_iv=
a_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartre=
flex_iva_slaves),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr_iva_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP4430),
>>> =A0};
>>>
>>> =A0/* smartreflex_mpu */
>>> +static struct omap_sr_dev_attr sr_mpu_dev_attr =3D {
>>> + =A0 =A0 =A0 .voltdm_name =A0 =3D "mpu",
>>> +};
>>> +
>>> =A0static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod;
>>> =A0static struct omap_hwmod_irq_info omap44xx_smartreflex_mpu_irqs[=
] =3D {
>>> =A0 =A0 =A0 =A0 { .irq =3D 18 + OMAP44XX_IRQ_GIC_START },
>>> @@ -3901,7 +3914,6 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_mpu_hwmod =3D {
>>> =A0 =A0 =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_smartreflex_mpu_=
irqs,
>>> =A0 =A0 =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(omap44xx_smartrefl=
ex_mpu_irqs),
>>> =A0 =A0 =A0 =A0 .main_clk =A0 =A0 =A0 =3D "smartreflex_mpu_fck",
>>> - =A0 =A0 =A0 .vdd_name =A0 =A0 =A0 =3D "mpu",
>>> =A0 =A0 =A0 =A0 .prcm =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_reg =3D OM=
AP4430_CM_ALWON_SR_MPU_CLKCTRL,
>>> @@ -3909,6 +3921,7 @@ static struct omap_hwmod
>>> omap44xx_smartreflex_mpu_hwmod =3D {
>>> =A0 =A0 =A0 =A0 },
>>> =A0 =A0 =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_smartreflex_mp=
u_slaves,
>>> =A0 =A0 =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_smartre=
flex_mpu_slaves),
>>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&sr_mpu_dev_attr,
>>> =A0 =A0 =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OM=
AP4430),
>>> =A0};
>>>
>>> diff --git a/arch/arm/mach-omap2/smartreflex.h
>>> b/arch/arm/mach-omap2/smartreflex.h
>>> index 5f35b9e..9a7f770 100644
>>> --- a/arch/arm/mach-omap2/smartreflex.h
>>> +++ b/arch/arm/mach-omap2/smartreflex.h
>>> @@ -197,6 +197,16 @@ struct omap_sr_nvalue_table {
>>> =A0};
>>>
>>> =A0/**
>>> + * struct omap_sr_dev_attr - Smartreflex Device attribute.
>>> + *
>>> + * @voltdm_name: =A0 =A0 =A0 Name of voltdomain of SR instance
>>
>> You should be more specific. This is the name of the SR sensor volta=
ge
>> domain.
>> The Smartreflex controller IPs are all inside the CORE voltage domai=
n.
> Ok.
>> Regards,
>> Benoit
>>
>
>
>
> --
> Thanks,
> Regards,
> Shweta
>



--=20
Thanks,
Regards,
Shweta
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
