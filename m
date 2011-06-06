From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Mon, 06 Jun 2011 09:08:30 -0700
Message-ID: <878vtf7xj5.fsf@ti.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
	<87sjrsw0h2.fsf@ti.com>
	<BANLkTikU+tgnECLmTqOgXJ1wmvbG0tVT0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40762 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754049Ab1FFQIe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 12:08:34 -0400
Received: by mail-pz0-f45.google.com with SMTP id 30so2231636pzk.32
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 09:08:33 -0700 (PDT)
In-Reply-To: <BANLkTikU+tgnECLmTqOgXJ1wmvbG0tVT0g@mail.gmail.com> (Lesly
	Arackal Manuel's message of "Mon, 6 Jun 2011 19:33:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Manuel, Lesly Arackal" <leslyam@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

"Manuel, Lesly Arackal" <leslyam@ti.com> writes:

> Hi Kevin,
>
> On Thu, Jun 2, 2011 at 11:59 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Lesly A M <leslyam@ti.com> writes:
>>
>>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_r=
eset.
>>>
>>> TWL4030 power scripts which can be used by different OMAP3 boards
>>> with the power companion chip (TWL4030 series).
>>>
>>> The twl4030 generic script can be used by any board file to update
>>> the power data in twl4030_platform_data.
>>
>> What about existing board files that are using their own scripts?
>>
>> On n900 for example, board-rx51-peripherals.c has its own custom
>> scripts which are registered at board init time. =C2=A0These are the=
n
>> over written by your new driver which loads later.
>>
>> So first, can you verify if the n900 scripts can/should be replaced =
by
>> these generic ones. =C2=A0And second, please find a way for board fi=
les to
>> override these scripts at runtime instead of using a Kconfig.
>
> Customer boards have to modify the script for their board
> (may be using modem which is not present in SDP).
> Is it ok to add a flag to check whether the board file has already
> initialized the script.

Sounds fine.

>>> Since the TWL4030 power script has dependency with APIs in twl4030-=
power.c
>>> removing the __init for these APIs.
>>
>> I think separating this part out into a separate patch, with a bette=
r
>> description would make the rest of this patch much more readable. =C2=
=A0As it
>> is, it doesn't make much sense since all the script functions and da=
ta
>> are __init or __initdata.
> Ok
>
>> These changes also introduce a new complier warning:
>>
>> =C2=A0CC =C2=A0 =C2=A0 =C2=A0drivers/mfd/twl4030-power.o
>> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c: In function 'twl40=
30_power_init':
>> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c:457:5: warning: 'er=
r' may be used uninitialized in this function
>> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c:171:6: note: 'err' =
was declared here
>
> Ok, I will fix it
>>
>>> For more information please see:
>>> =C2=A0 =C2=A0 =C2=A0 http://omapedia.org/wiki/TWL4030_power_scripts
>>
>> This is an excellent wiki, thank for the detailed description!
>>
>>> Signed-off-by: Lesly A M <leslyam@ti.com>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Cc: David Derrick <dderrick@ti.com>
>>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>>> ---
>>> =C2=A0arch/arm/configs/omap2plus_defconfig | =C2=A0 =C2=A01 +
>>> =C2=A0arch/arm/mach-omap2/devices.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 15 ++
>>> =C2=A0drivers/mfd/Kconfig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| =C2=A0 11 +
>>> =C2=A0drivers/mfd/Makefile =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A01 +
>>> =C2=A0drivers/mfd/twl4030-power.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 31 ++--
>>> =C2=A0drivers/mfd/twl4030-script-omap.c =C2=A0 =C2=A0| =C2=A0373 ++=
++++++++++++++++++++++++++++++++
>>> =C2=A0include/linux/i2c/twl.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 41 ++++-
>>> =C2=A07 files changed, 454 insertions(+), 19 deletions(-)
>>> =C2=A0create mode 100644 drivers/mfd/twl4030-script-omap.c
>>>
>>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/config=
s/omap2plus_defconfig
>>> index 076db52..d9b9858 100644
>>> --- a/arch/arm/configs/omap2plus_defconfig
>>> +++ b/arch/arm/configs/omap2plus_defconfig
>>> @@ -184,6 +184,7 @@ CONFIG_TWL4030_WATCHDOG=3Dy
>>> =C2=A0CONFIG_MENELAUS=3Dy
>>> =C2=A0CONFIG_TWL4030_CORE=3Dy
>>> =C2=A0CONFIG_TWL4030_POWER=3Dy
>>> +CONFIG_TWL4030_SCRIPT=3Dm
>>> =C2=A0CONFIG_REGULATOR=3Dy
>>> =C2=A0CONFIG_REGULATOR_TWL4030=3Dy
>>> =C2=A0CONFIG_REGULATOR_TPS65023=3Dy
>>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/de=
vices.c
>>> index 7b85585..7653329 100644
>>> --- a/arch/arm/mach-omap2/devices.c
>>> +++ b/arch/arm/mach-omap2/devices.c
>>> @@ -329,6 +329,20 @@ static void omap_init_audio(void)
>>> =C2=A0static inline void omap_init_audio(void) {}
>>> =C2=A0#endif
>>>
>>> +#ifdef CONFIG_ARCH_OMAP3
>>
>> Shouldn't this depend on CONFIG_TWL4030_SCRIPT ?
> Ok
>
>>> +static struct platform_device omap_twl4030_script =3D {
>>> + =C2=A0 =C2=A0 .name =C2=A0 =3D "twl4030_script",
>>> + =C2=A0 =C2=A0 .id =C2=A0 =C2=A0 =3D -1,
>>> +};
>>> +
>>> +static void omap_init_twl4030_script(void)
>>> +{
>>> + =C2=A0 =C2=A0 platform_device_register(&omap_twl4030_script);
>>> +}
>>> +#else
>>> +static inline void omap_init_twl4030_script(void) {}
>>> +#endif
>>
>> I guess this gets to the debate about whether these scripts should b=
e in
>> drivers/mfd or in arch/arm/mach-omap2, =C2=A0but wherever the script=
 data
>> lives, this platform_device definition and register should be also.
>>
>> IOW, there's not a clean separation between driver and device curren=
tly.
>> IMO, The platform_driver part should just be part of twl4030-power.c=
,
>> and all the scripts and platform_device creation/registration should=
 be
>> part of the script file.
>>
>> As far as where the script device data should go, I'd vote for
>> drivers/mfd, where it can be compiled as a module along with the res=
t of
>> the twl4030 code.
>
> Any final conclusion ?
>
>>> =C2=A0#if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24=
XX_MODULE)
>>>
>>> =C2=A0#include <plat/mcspi.h>
>>> @@ -691,6 +705,7 @@ static int __init omap2_init_devices(void)
>>> =C2=A0 =C2=A0 =C2=A0 omap_init_sham();
>>> =C2=A0 =C2=A0 =C2=A0 omap_init_aes();
>>> =C2=A0 =C2=A0 =C2=A0 omap_init_vout();
>>> + =C2=A0 =C2=A0 omap_init_twl4030_script();
>>>
>>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>> =C2=A0}
>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>> index 3ed3ff0..bed88ce 100644
>>> --- a/drivers/mfd/Kconfig
>>> +++ b/drivers/mfd/Kconfig
>>> @@ -204,6 +204,17 @@ config TWL4030_POWER
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 and load scripts controlling which reso=
urces are switched off/on
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 or reset when a sleep, wakeup or warm r=
eset event occurs.
>>>
>>> +config TWL4030_SCRIPT
>>> + =C2=A0 =C2=A0 tristate "Support TWL4030 script for OMAP3 boards"
>>> + =C2=A0 =C2=A0 depends on TWL4030_CORE && TWL4030_POWER
>>> + =C2=A0 =C2=A0 help
>>> + =C2=A0 =C2=A0 =C2=A0 Say yes here if you want to use the twl4030 =
power scripts
>>> + =C2=A0 =C2=A0 =C2=A0 for OMAP3 boards. Power bus message sequence=
 for
>>> + =C2=A0 =C2=A0 =C2=A0 TWL4030 to enter sleep/wakeup/warm_reset.
>>> +
>>> + =C2=A0 =C2=A0 =C2=A0 TWL4030 power scripts which can be used by d=
ifferent
>>> + =C2=A0 =C2=A0 =C2=A0 OMAP3 boards with the power companion chip (=
TWL4030 series).
>>> +
>>
>> Why do we need another Kconfig for this? =C2=A0It should be enabled =
and
>> overridden at runtime via board files.
>
> Kconfig option was added when script was changed to insert-able modul=
e,
> which was suggested by Tony as comment for last version.

Yes, it needs to be a loadable module, but doesn't need Kconfig.

IMO, it should just be build whenever CONFIG_TWL4030_POWER=3Dy && CONFI=
G_ARCH_OMAP2PLUS=3Dy

Adding another build option means needing to ensure more build-option
testing coverage.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
