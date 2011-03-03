From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH 3/3] OMAP4: Enable Turbo and Nitro OPP for OMAP4
Date: Thu, 3 Mar 2011 14:37:12 +0530
Message-ID: <AANLkTikBKcx+g16BWUxPtZQ5BavSBhHpg9r4TMAqG-gZ@mail.gmail.com>
References: <1297837112-8924-1-git-send-email-shweta.gulati@ti.com>
	<AANLkTiny+AM9p-AsmJwsJttxuuUoDwceZL=7TWRCmphR@mail.gmail.com>
	<87ei6pecwi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:39068 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754690Ab1CCJHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 04:07:14 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so1042656bwz.7
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 01:07:12 -0800 (PST)
In-Reply-To: <87ei6pecwi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Menon, Nishanth" <nm@ti.com>, linux-omap@vger.kernel.org

Hi,

On Wed, Mar 2, 2011 at 9:24 PM, Kevin Hilman <khilman@ti.com> wrote:
> "Menon, Nishanth" <nm@ti.com> writes:
>
>> On Wed, Feb 16, 2011 at 11:48, Shweta Gulati <shweta.gulati@ti.com> =
wrote:
>>> All OMAP4 boards support OPP-Turbo (800M) and OPP-Nitro (1G).
>> s/All OMAP4/Almost all/ - there are a minority of boards that use
>> OMAP4430-800 device instead of the OMAP4430-1000 device.
>> Also please use the full term 1GHz instead of 1G
Ok, Will do.
>>> Enable them by default in OPPTable. For 800Mhz devices where
>> s/For 800Mhz/For the small minority of boards which use OMAP4430-800
>> (800MHz device),
>>> OPP-Nitro is not supported, OPP-Nitro should be disabled
>>> from board file.
Will do.
>> even though the TI documentation terminology is Turbo, Nitro etc.., =
I
>> suggest using frequencies to better map things historically.
>
> I agree, IMO the Turbo & Nitro names are useless.
Ok, Will Post V2.
> Kevin
>
>>>
>>> Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
>>> ---
>>> =A0arch/arm/mach-omap2/opp4xxx_data.c | =A0 =A04 ++--
>>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-oma=
p2/opp4xxx_data.c
>>> index 705fe9a..48d79e5 100644
>>> --- a/arch/arm/mach-omap2/opp4xxx_data.c
>>> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
>>> @@ -31,9 +31,9 @@ static struct omap_opp_def __initdata omap44xx_op=
p_def_list[] =3D {
>>> =A0 =A0 =A0 =A0/* MPU OPP2 - OPP100 */
>>> =A0 =A0 =A0 =A0OPP_INITIALIZER("mpu", true, 600000000, OMAP4430_VDD=
_MPU_OPP100_UV),
>>> =A0 =A0 =A0 =A0/* MPU OPP3 - OPP-Turbo */
>>> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 800000000, OMAP4430_VDD=
_MPU_OPPTURBO_UV),
>>> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 800000000, OMAP4430_VDD_=
MPU_OPPTURBO_UV),
>>> =A0 =A0 =A0 =A0/* MPU OPP4 - OPP-SB */
>>> - =A0 =A0 =A0 OPP_INITIALIZER("mpu", false, 1008000000, OMAP4430_VD=
D_MPU_OPPNITRO_UV),
>>> + =A0 =A0 =A0 OPP_INITIALIZER("mpu", true, 1008000000, OMAP4430_VDD=
_MPU_OPPNITRO_UV),
>>> =A0 =A0 =A0 =A0/* L3 OPP1 - OPP50 */
>>> =A0 =A0 =A0 =A0OPP_INITIALIZER("l3_main_1", true, 100000000, OMAP44=
30_VDD_CORE_OPP50_UV),
>>> =A0 =A0 =A0 =A0/* L3 OPP2 - OPP100, OPP-Turbo, OPP-SB */
>>> --
>>> 1.7.0.4
>>
>> I am ok with the overall patch - with the minor suggestions above.
>>
>> Regards,
>> Nishanth Menon
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
