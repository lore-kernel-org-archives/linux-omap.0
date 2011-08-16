From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 11/15] OMAP3: powerdomain data: add wake-up latency figures
Date: Tue, 16 Aug 2011 16:34:07 +0200
Message-ID: <CAORVsuWPp2SWi-SqHe8Pjoi3MgRriA74TwhsNEUS2L4s9iiqDg@mail.gmail.com>
References: <1313502198-9298-1-git-send-email-j-pihet@ti.com>
	<1313502198-9298-12-git-send-email-j-pihet@ti.com>
	<4E4A7DC9.1040500@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45035 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab1HPOeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Aug 2011 10:34:07 -0400
Received: by vws1 with SMTP id 1so4775983vws.19
        for <linux-omap@vger.kernel.org>; Tue, 16 Aug 2011 07:34:07 -0700 (PDT)
In-Reply-To: <4E4A7DC9.1040500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh <santosh.shilimkar@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Paul Walmsley <paul@pwsan.com>, Magnus Damm <magnus.damm@gmail.com>, Todd Poynor <toddpoynor@google.com>, Jean Pihet <j-pihet@ti.com>

On Tue, Aug 16, 2011 at 4:25 PM, Santosh <santosh.shilimkar@ti.com> wro=
te:
> On Tuesday 16 August 2011 07:13 PM, jean.pihet@newoldbits.com wrote:
>>
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> Figures are added to the power domains structs.
>>
>> Note: the figures are preliminary figures. More accurate measurement=
s
>> are needed. Also the conditions of measurements shall be investigate=
d
>> and described.
>>
>> Tested on OMAP3 Beagleboard in RET/OFF using wake-up latency constra=
ints
>> on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet<j-pihet@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/powerdomains3xxx_data.c | =A0 77
>> +++++++++++++++++++++++++++
>> =A01 files changed, 77 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> index 469a920..64446e7 100644
>> --- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> +++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
>> @@ -31,6 +31,13 @@
>>
>> =A0/*
>> =A0 * Powerdomains
>> + *
>> + * The wakeup_lat values are derived from measurements on
>> + * the actual target.
>> + *
>> + * Note: the latency figures are preliminary and only used
>> + * for the constraints framework validation.
>> + * Actual figures and measurements conditions shall be added.
>> =A0 */
>>
>> =A0static struct powerdomain iva2_pwrdm =3D {
>> @@ -52,6 +59,13 @@ static struct powerdomain iva2_pwrdm =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[2] =3D PWRSTS_OFF_ON,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[3] =3D PWRSTS_ON,
>> =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 .wakeup_lat =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OFF] =3D 1100,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_OSWR] =3D UNSUP_STAT=
E,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_CSWR] =3D 350,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_INACTIVE] =3D UNSUP_=
STATE,
>
> This can easily derived from the PWRST flag instead of hardcoding
> it this way. Also note that INACTIVE PD isn't supported in mainline
> yet because of voltage-domain dependency planned changes.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 [PWRDM_FUNC_PWRST_ON] =3D 0,
>
> All of the PD structures are manually coded. This whole file is
> auto-generated and even these field generation needs to follow
> that path.
Ok I need to check that. Any pointer on how to generate those?

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
