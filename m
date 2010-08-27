From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 05/10] [PM-WIP-MMC] OMAP4 hwmod: Updating hwmod data for
 MMC controllers
Date: Fri, 27 Aug 2010 20:04:52 +0530
Message-ID: <AANLkTik7Z32wj97ggGn40qPYnLfBOxt4fy6Rn_w9d_1x@mail.gmail.com>
References: <16128.10.24.255.18.1282335050.squirrel@dbdmail.itg.ti.com>
	<4C722AAA.9040905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36725 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753535Ab0H0Oex convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Aug 2010 10:34:53 -0400
Received: by vws3 with SMTP id 3so2918275vws.19
        for <linux-omap@vger.kernel.org>; Fri, 27 Aug 2010 07:34:53 -0700 (PDT)
In-Reply-To: <4C722AAA.9040905@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "tony@atomide.com" <tony@atomide.com>

Benoit,

On Mon, Aug 23, 2010 at 1:30 PM, Cousson, Benoit <b-cousson@ti.com> wro=
te:
> Hi Kishore,
>
> On 8/20/2010 10:10 PM, Kadiyala, Kishore wrote:
>>
>> Update register offsets and dev attributes for MMC controllers on
>> OMAP4
>>
>> Cc: Kevin Hilman<khilman@deeprootsystems.com>
>> Cc: Benoit Cousson<b-cousson@ti.com>
>> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 17 +++++++++++++=
++--
>> =A01 files changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> index b7268f6..db62b84 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -22,6 +22,7 @@
>>
>> =A0#include<plat/omap_hwmod.h>
>> =A0#include<plat/cpu.h>
>> +#include<plat/mmc.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -408,8 +409,8 @@ static struct omap_hwmod omap44xx_l4_wkup_hwmod =
=3D {
>> =A0 */
>>
>> =A0static struct omap_hwmod_class_sysconfig omap44xx_mmc_sysc =3D {
>> - =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x0000,
>> - =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0010,
>> + =A0 =A0 =A0 .rev_offs =A0 =A0 =A0 =3D 0x02FC,
>> + =A0 =A0 =A0 .sysc_offs =A0 =A0 =A0=3D 0x0110,
>
> You should not use these registers. MMC is one of the few IP that con=
tains
> both legacy and highlander version of the registers, hence the _HL pr=
efix
> for the MMCHS_HL_REV and MMCHS_HL_SYSCONFIG.
>
> I don't know why the legacy registers are still there, but you should=
 use
> the highlander version.

Thanks for the info. I will drop the patch.

Regards,
Kishore
>
> Regards,
> Benoit
>
>> =A0 =A0 =A0 =A0.syss_offs =A0 =A0 =A0=3D 0x0114,
>> =A0 =A0 =A0 =A0.sysc_flags =A0 =A0 =3D (SYSC_HAS_SIDLEMODE | SYSC_HA=
S_EMUFREE |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SYSC_HAS_SOFTRES=
ET | SYSC_HAS_MIDLEMODE),
>> @@ -424,6 +425,11 @@ static struct omap_hwmod_class
>> omap44xx_mmc_hwmod_class =3D {
>> =A0};
>>
>> =A0/* mmc1 */
>> +
>> +static struct mmc_dev_attr mmc1_dev_attr =3D {
>> + =A0 =A0 =A0 .flags =3D MMC_INTERNAL_XCVR,
>> +};
>> +
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc1_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 83 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -478,10 +484,16 @@ static struct omap_hwmod omap44xx_mmc1_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc1_slav=
es),
>> =A0 =A0 =A0 =A0.masters =A0 =A0 =A0 =A0=3D omap44xx_mmc1_masters,
>> =A0 =A0 =A0 =A0.masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_mmc1_mast=
ers),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&mmc1_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>> =A0/* mmc2 */
>> +
>> +static struct mmc_dev_attr mmc2_dev_attr =3D {
>> + =A0 =A0 =A0 .flags =3D MMC_SUPPORTS_EXTERNAL_XCVR,
>> +};
>> +
>> =A0static struct omap_hwmod_irq_info omap44xx_mmc2_irqs[] =3D {
>> =A0 =A0 =A0 =A0{ .irq =3D 86 + OMAP44XX_IRQ_GIC_START },
>> =A0};
>> @@ -536,6 +548,7 @@ static struct omap_hwmod omap44xx_mmc2_hwmod =3D=
 {
>> =A0 =A0 =A0 =A0.slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_mmc2_slav=
es),
>> =A0 =A0 =A0 =A0.masters =A0 =A0 =A0 =A0=3D omap44xx_mmc2_masters,
>> =A0 =A0 =A0 =A0.masters_cnt =A0 =A0=3D ARRAY_SIZE(omap44xx_mmc2_mast=
ers),
>> + =A0 =A0 =A0 .dev_attr =A0 =A0 =A0 =3D&mmc2_dev_attr,
>> =A0 =A0 =A0 =A0.omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP=
4430),
>> =A0};
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
