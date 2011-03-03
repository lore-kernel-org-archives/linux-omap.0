From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP4: Add IVA OPP enteries with Updated Voltage Rail Values.
Date: Thu, 3 Mar 2011 15:39:44 +0530
Message-ID: <AANLkTi=HKUn5VK2KkXCMSHMDoRsgSB98LJnSYJCUgHc5@mail.gmail.com>
References: <1299144429-20942-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTimb4_EXmMwyBfR52Zx9nhZy25W3OZhQy9nKcQZ4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:39763 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753135Ab1CCKJr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 05:09:47 -0500
Received: by bwz8 with SMTP id 8so1084638bwz.7
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 02:09:45 -0800 (PST)
In-Reply-To: <AANLkTimb4_EXmMwyBfR52Zx9nhZy25W3OZhQy9nKcQZ4@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Thu, Mar 3, 2011 at 3:04 PM, Menon, Nishanth <nm@ti.com> wrote:
> On Thu, Mar 3, 2011 at 14:57, Shweta Gulati <shweta.gulati@ti.com> wr=
ote:
>>
>> This Patch adds OPP enteries for IVA =A0in OMAP4 OPP Table
>> and updates IVA voltage Rail values obtained from latest
>> OMAP4430 Data Manual Operating Condition Addendum.
> Do you think =A0we should add the version of the document in the comm=
it
> message - it looks like every "latest" version we look at has some
> update, so we'd know what baseline the code currently maps to when we
> do a git blame at a later point of time
Ok, Will do.
> Regards,
> Nishanth Menon
>
>>
>> Tested on OMAP4430 SDP Board.
>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0| =A0 =A08 ++++=
+++-
>> =A0arch/arm/plat-omap/include/plat/voltage.h | =A0 =A06 +++---
>> =A02 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap=
2/opp4xxx_data.c
>> index 48d79e5..3e0fbdc 100644
>> --- a/arch/arm/mach-omap2/opp4xxx_data.c
>> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
>> @@ -38,7 +38,13 @@ static struct omap_opp_def __initdata omap44xx_op=
p_def_list[] =3D {
>> =A0 =A0 =A0 =A0OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP443=
0_VDD_CORE_OPP50_UV),
>> =A0 =A0 =A0 =A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>> =A0 =A0 =A0 =A0OPP_INITIALIZER("l3_main_1", true, 200000000, OMAP443=
0_VDD_CORE_OPP100_UV),
>> - =A0 =A0 =A0 /* TODO: add IVA, DSP, aess, fdif, gpu */
>> + =A0 =A0 =A0 /* IVA OPP1 - OPP50 */
>> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 133000000, OMAP4430_VDD_I=
VA_OPP50_UV),
>> + =A0 =A0 =A0 /* IVA OPP2 - OPP100 */
>> + =A0 =A0 =A0 OPP_INITIALIZER("iva", true, 266100000, OMAP4430_VDD_I=
VA_OPP100_UV),
>> + =A0 =A0 =A0 /* IVA OPP3 - OPP-Turbo */
>> + =A0 =A0 =A0 OPP_INITIALIZER("iva", false, 332000000, OMAP4430_VDD_=
IVA_OPPTURBO_UV),
>> + =A0 =A0 =A0 /* TODO: add DSP, aess, fdif, gpu */
>> =A0};
>>
>> =A0/**
>> diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/pl=
at-omap/include/plat/voltage.h
>> index 4d9bab1..27555ce 100644
>> --- a/arch/arm/plat-omap/include/plat/voltage.h
>> +++ b/arch/arm/plat-omap/include/plat/voltage.h
>> @@ -51,9 +51,9 @@
>> =A0#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
>> =A0#define OMAP4430_VDD_MPU_OPPNITRO_UV =A0 =A0 =A0 =A0 =A0 1375000
>>
>> -#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0930000
>> -#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1100000
>> -#define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1260000
>> +#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0101300=
0
>> +#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1188000
>> +#define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1300000
>>
>> =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 930000
>> =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0110000=
0
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
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
