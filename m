From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] OMAP4: PandaBoard: remove unused power regulators
Date: Wed, 16 Mar 2011 10:19:41 +0100
Message-ID: <AANLkTing6jerp4mVgVDkW7eTu9LPgwRNAR9KXQPZNWcs@mail.gmail.com>
References: <1300216227-21138-1-git-send-email-x0132446@ti.com>
	<4D7FBA82.40403@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36445 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab1CPJTn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Mar 2011 05:19:43 -0400
Received: by qwk3 with SMTP id 3so1117671qwk.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Mar 2011 02:19:42 -0700 (PDT)
In-Reply-To: <4D7FBA82.40403@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: andy.green@linaro.org, David Anders <x0132446@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, tony@atomide.com

On Tue, Mar 15, 2011 at 8:14 PM, Andy Green <andy@warmcat.com> wrote:
> On 03/15/2011 07:10 PM, Somebody in the thread at some point said:
>>
>> the pandaboard does not use the VUSIM or VAUX1 power regulators on t=
he
>> TWL6030
>> and are left floating. if the VUSIM and VAUX1 power regulators are
>> initilized,
>> noise on the unloaded regulators generates an overcurrent interrupt
>> causing the
>> system to power down. this patch removes the initialization of the u=
nused
>> power
>> regulators of VUSIM and VAUX1.
>>
>> Signed-off-by: David Anders<x0132446@ti.com>
>
> Acked-by: Andy Green <andy.green@linaro.org>
>
> Great job finding this one David.
Great!

Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

>
>> ---
>> =A0arch/arm/mach-omap2/board-omap4panda.c | =A0 28
>> ----------------------------
>> =A01 files changed, 0 insertions(+), 28 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
>> b/arch/arm/mach-omap2/board-omap4panda.c
>> index e944025..abc913b 100644
>> --- a/arch/arm/mach-omap2/board-omap4panda.c
>> +++ b/arch/arm/mach-omap2/board-omap4panda.c
>> @@ -220,19 +220,6 @@ static int __init omap4_twl6030_hsmmc_init(stru=
ct
>> omap2_hsmmc_info *controllers)
>> =A0 =A0 =A0 =A0return 0;
>> =A0}
>>
>> -static struct regulator_init_data omap4_panda_vaux1 =3D {
>> - =A0 =A0 =A0 .constraints =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1000000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3000000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D true,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGU=
LATOR_MODE_NORMAL
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0=3D REGULATOR_CHANG=
E_VOLTAGE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
>> - =A0 =A0 =A0 },
>> -};
>> -
>> =A0static struct regulator_init_data omap4_panda_vaux2 =3D {
>> =A0 =A0 =A0 =A0.constraints =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1200000,
>> @@ -288,19 +275,6 @@ static struct regulator_init_data omap4_panda_v=
pp =3D {
>> =A0 =A0 =A0 =A0},
>> =A0};
>>
>> -static struct regulator_init_data omap4_panda_vusim =3D {
>> - =A0 =A0 =A0 .constraints =3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1200000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 2900000,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=3D true,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGU=
LATOR_MODE_NORMAL
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0=3D REGULATOR_CHANG=
E_VOLTAGE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
>> - =A0 =A0 =A0 },
>> -};
>> -
>> =A0static struct regulator_init_data omap4_panda_vana =3D {
>> =A0 =A0 =A0 =A0.constraints =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 2100000,
>> @@ -356,12 +330,10 @@ static struct twl4030_platform_data
>> omap4_panda_twldata =3D {
>> =A0 =A0 =A0 =A0/* Regulators */
>> =A0 =A0 =A0 =A0.vmmc =A0 =A0 =A0 =A0 =A0 =3D&omap4_panda_vmmc,
>> =A0 =A0 =A0 =A0.vpp =A0 =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vpp,
>> - =A0 =A0 =A0 .vusim =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vusim,
>> =A0 =A0 =A0 =A0.vana =A0 =A0 =A0 =A0 =A0 =3D&omap4_panda_vana,
>> =A0 =A0 =A0 =A0.vcxio =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vcxio,
>> =A0 =A0 =A0 =A0.vdac =A0 =A0 =A0 =A0 =A0 =3D&omap4_panda_vdac,
>> =A0 =A0 =A0 =A0.vusb =A0 =A0 =A0 =A0 =A0 =3D&omap4_panda_vusb,
>> - =A0 =A0 =A0 .vaux1 =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vaux1,
>> =A0 =A0 =A0 =A0.vaux2 =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vaux2,
>> =A0 =A0 =A0 =A0.vaux3 =A0 =A0 =A0 =A0 =A0=3D&omap4_panda_vaux3,
>> =A0 =A0 =A0 =A0.usb =A0 =A0 =A0 =A0 =A0 =A0=3D&omap4_usbphy_data,
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
