From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 3/3] OMAP4: Enable Turbo and Nitro OPP for OMAP4
Date: Wed, 02 Mar 2011 07:54:21 -0800
Message-ID: <87ei6pecwi.fsf@ti.com>
References: <1297837112-8924-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTiny+AM9p-AsmJwsJttxuuUoDwceZL=7TWRCmphR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:37656 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751384Ab1CBPy0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Mar 2011 10:54:26 -0500
Received: by yic13 with SMTP id 13so2846yic.31
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 07:54:24 -0800 (PST)
In-Reply-To: <AANLkTiny+AM9p-AsmJwsJttxuuUoDwceZL=7TWRCmphR@mail.gmail.com>
	(Nishanth Menon's message of "Wed, 2 Mar 2011 16:58:23 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, Feb 16, 2011 at 11:48, Shweta Gulati <shweta.gulati@ti.com> w=
rote:
>> All OMAP4 boards support OPP-Turbo (800M) and OPP-Nitro (1G).
> s/All OMAP4/Almost all/ - there are a minority of boards that use
> OMAP4430-800 device instead of the OMAP4430-1000 device.
> Also please use the full term 1GHz instead of 1G
>> Enable them by default in OPPTable. For 800Mhz devices where
> s/For 800Mhz/For the small minority of boards which use OMAP4430-800
> (800MHz device),
>> OPP-Nitro is not supported, OPP-Nitro should be disabled
>> from board file.
>
> even though the TI documentation terminology is Turbo, Nitro etc.., I
> suggest using frequencies to better map things historically.

I agree, IMO the Turbo & Nitro names are useless.

Kevin

>>
>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>> ---
>> =C2=A0arch/arm/mach-omap2/opp4xxx_data.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap=
2/opp4xxx_data.c
>> index 705fe9a..48d79e5 100644
>> --- a/arch/arm/mach-omap2/opp4xxx_data.c
>> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
>> @@ -31,9 +31,9 @@ static struct omap_opp_def __initdata omap44xx_opp=
_def_list[] =3D {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MPU OPP2 - OPP100 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPP_INITIALIZER("mpu", true, 600000000, O=
MAP4430_VDD_MPU_OPP100_UV),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MPU OPP3 - OPP-Turbo */
>> - =C2=A0 =C2=A0 =C2=A0 OPP_INITIALIZER("mpu", false, 800000000, OMAP=
4430_VDD_MPU_OPPTURBO_UV),
>> + =C2=A0 =C2=A0 =C2=A0 OPP_INITIALIZER("mpu", true, 800000000, OMAP4=
430_VDD_MPU_OPPTURBO_UV),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* MPU OPP4 - OPP-SB */
>> - =C2=A0 =C2=A0 =C2=A0 OPP_INITIALIZER("mpu", false, 1008000000, OMA=
P4430_VDD_MPU_OPPNITRO_UV),
>> + =C2=A0 =C2=A0 =C2=A0 OPP_INITIALIZER("mpu", true, 1008000000, OMAP=
4430_VDD_MPU_OPPNITRO_UV),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* L3 OPP1 - OPP50 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPP_INITIALIZER("l3_main_1", true, 100000=
000, OMAP4430_VDD_CORE_OPP50_UV),
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>> --
>> 1.7.0.4
>
> I am ok with the overall patch - with the minor suggestions above.
>
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
