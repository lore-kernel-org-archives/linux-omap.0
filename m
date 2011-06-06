From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Mon, 6 Jun 2011 19:33:07 +0530
Message-ID: <BANLkTikU+tgnECLmTqOgXJ1wmvbG0tVT0g@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
	<87sjrsw0h2.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:56211 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752785Ab1FFODL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Jun 2011 10:03:11 -0400
Received: by mail-wy0-f170.google.com with SMTP id 34so3199800wyb.29
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 07:03:07 -0700 (PDT)
In-Reply-To: <87sjrsw0h2.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Kevin,

On Thu, Jun 2, 2011 at 11:59 PM, Kevin Hilman <khilman@ti.com> wrote:
> Lesly A M <leslyam@ti.com> writes:
>
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_re=
set.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script can be used by any board file to update
>> the power data in twl4030_platform_data.
>
> What about existing board files that are using their own scripts?
>
> On n900 for example, board-rx51-peripherals.c has its own custom
> scripts which are registered at board init time. =A0These are then
> over written by your new driver which loads later.
>
> So first, can you verify if the n900 scripts can/should be replaced b=
y
> these generic ones. =A0And second, please find a way for board files =
to
> override these scripts at runtime instead of using a Kconfig.

Customer boards have to modify the script for their board
(may be using modem which is not present in SDP).
Is it ok to add a flag to check whether the board file has already
initialized the script.

>> Since the TWL4030 power script has dependency with APIs in twl4030-p=
ower.c
>> removing the __init for these APIs.
>
> I think separating this part out into a separate patch, with a better
> description would make the rest of this patch much more readable. =A0=
As it
> is, it doesn't make much sense since all the script functions and dat=
a
> are __init or __initdata.
Ok

> These changes also introduce a new complier warning:
>
> =A0CC =A0 =A0 =A0drivers/mfd/twl4030-power.o
> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c: In function 'twl403=
0_power_init':
> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c:457:5: warning: 'err=
' may be used uninitialized in this function
> /work/kernel/omap/pm/drivers/mfd/twl4030-power.c:171:6: note: 'err' w=
as declared here

Ok, I will fix it
>
>> For more information please see:
>> =A0 =A0 =A0 http://omapedia.org/wiki/TWL4030_power_scripts
>
> This is an excellent wiki, thank for the detailed description!
>
>> Signed-off-by: Lesly A M <leslyam@ti.com>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: David Derrick <dderrick@ti.com>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> ---
>> =A0arch/arm/configs/omap2plus_defconfig | =A0 =A01 +
>> =A0arch/arm/mach-omap2/devices.c =A0 =A0 =A0 =A0| =A0 15 ++
>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>> =A0drivers/mfd/twl4030-power.c =A0 =A0 =A0 =A0 =A0| =A0 31 ++--
>> =A0drivers/mfd/twl4030-script-omap.c =A0 =A0| =A0373 +++++++++++++++=
+++++++++++++++++++
>> =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 41 ++++-
>> =A07 files changed, 454 insertions(+), 19 deletions(-)
>> =A0create mode 100644 drivers/mfd/twl4030-script-omap.c
>>
>> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs=
/omap2plus_defconfig
>> index 076db52..d9b9858 100644
>> --- a/arch/arm/configs/omap2plus_defconfig
>> +++ b/arch/arm/configs/omap2plus_defconfig
>> @@ -184,6 +184,7 @@ CONFIG_TWL4030_WATCHDOG=3Dy
>> =A0CONFIG_MENELAUS=3Dy
>> =A0CONFIG_TWL4030_CORE=3Dy
>> =A0CONFIG_TWL4030_POWER=3Dy
>> +CONFIG_TWL4030_SCRIPT=3Dm
>> =A0CONFIG_REGULATOR=3Dy
>> =A0CONFIG_REGULATOR_TWL4030=3Dy
>> =A0CONFIG_REGULATOR_TPS65023=3Dy
>> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/dev=
ices.c
>> index 7b85585..7653329 100644
>> --- a/arch/arm/mach-omap2/devices.c
>> +++ b/arch/arm/mach-omap2/devices.c
>> @@ -329,6 +329,20 @@ static void omap_init_audio(void)
>> =A0static inline void omap_init_audio(void) {}
>> =A0#endif
>>
>> +#ifdef CONFIG_ARCH_OMAP3
>
> Shouldn't this depend on CONFIG_TWL4030_SCRIPT ?
Ok

>> +static struct platform_device omap_twl4030_script =3D {
>> + =A0 =A0 .name =A0 =3D "twl4030_script",
>> + =A0 =A0 .id =A0 =A0 =3D -1,
>> +};
>> +
>> +static void omap_init_twl4030_script(void)
>> +{
>> + =A0 =A0 platform_device_register(&omap_twl4030_script);
>> +}
>> +#else
>> +static inline void omap_init_twl4030_script(void) {}
>> +#endif
>
> I guess this gets to the debate about whether these scripts should be=
 in
> drivers/mfd or in arch/arm/mach-omap2, =A0but wherever the script dat=
a
> lives, this platform_device definition and register should be also.
>
> IOW, there's not a clean separation between driver and device current=
ly.
> IMO, The platform_driver part should just be part of twl4030-power.c,
> and all the scripts and platform_device creation/registration should =
be
> part of the script file.
>
> As far as where the script device data should go, I'd vote for
> drivers/mfd, where it can be compiled as a module along with the rest=
 of
> the twl4030 code.

Any final conclusion ?

>> =A0#if defined(CONFIG_SPI_OMAP24XX) || defined(CONFIG_SPI_OMAP24XX_M=
ODULE)
>>
>> =A0#include <plat/mcspi.h>
>> @@ -691,6 +705,7 @@ static int __init omap2_init_devices(void)
>> =A0 =A0 =A0 omap_init_sham();
>> =A0 =A0 =A0 omap_init_aes();
>> =A0 =A0 =A0 omap_init_vout();
>> + =A0 =A0 omap_init_twl4030_script();
>>
>> =A0 =A0 =A0 return 0;
>> =A0}
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 3ed3ff0..bed88ce 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -204,6 +204,17 @@ config TWL4030_POWER
>> =A0 =A0 =A0 =A0 and load scripts controlling which resources are swi=
tched off/on
>> =A0 =A0 =A0 =A0 or reset when a sleep, wakeup or warm reset event oc=
curs.
>>
>> +config TWL4030_SCRIPT
>> + =A0 =A0 tristate "Support TWL4030 script for OMAP3 boards"
>> + =A0 =A0 depends on TWL4030_CORE && TWL4030_POWER
>> + =A0 =A0 help
>> + =A0 =A0 =A0 Say yes here if you want to use the twl4030 power scri=
pts
>> + =A0 =A0 =A0 for OMAP3 boards. Power bus message sequence for
>> + =A0 =A0 =A0 TWL4030 to enter sleep/wakeup/warm_reset.
>> +
>> + =A0 =A0 =A0 TWL4030 power scripts which can be used by different
>> + =A0 =A0 =A0 OMAP3 boards with the power companion chip (TWL4030 se=
ries).
>> +
>
> Why do we need another Kconfig for this? =A0It should be enabled and
> overridden at runtime via board files.

Kconfig option was added when script was changed to insert-able module,
which was suggested by Tony as comment for last version.

Thanks & Regards,
Lesly
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
