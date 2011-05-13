From: "Manuel, Lesly Arackal" <leslyam@ti.com>
Subject: Re: [PATCH v10 4/7] MFD: TWL4030: power scripts for OMAP3 boards
Date: Fri, 13 May 2011 13:23:10 +0530
Message-ID: <BANLkTinCqz9e_t8XXyYGDu5rNkuwe8DqQg@mail.gmail.com>
References: <1304687833-4578-1-git-send-email-leslyam@ti.com>
	<1304687833-4578-5-git-send-email-leslyam@ti.com>
	<20110512105607.GM31483@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:50073 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757878Ab1EMHxL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 May 2011 03:53:11 -0400
Received: by mail-wy0-f177.google.com with SMTP id 28so2113951wyb.8
        for <linux-omap@vger.kernel.org>; Fri, 13 May 2011 00:53:10 -0700 (PDT)
In-Reply-To: <20110512105607.GM31483@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, David Derrick <dderrick@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

Hi Tony,

On Thu, May 12, 2011 at 4:26 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Lesly A M <leslyam@ti.com> [110506 06:14]:
>> Power bus message sequence for TWL4030 to enter sleep/wakeup/warm_re=
set.
>>
>> TWL4030 power scripts which can be used by different OMAP3 boards
>> with the power companion chip (TWL4030 series).
>>
>> The twl4030 generic script can be used by any board file to update
>> the power data in twl4030_platform_data.
>>
>> Since the TWL4030 power script has dependency with APIs in twl4030-p=
ower.c
>> removing the __init for these APIs.
>>
>> For more information please see:
>> =A0 =A0 =A0 http://omapedia.org/wiki/TWL4030_power_scripts
>>
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
> This should be if defined(CONFIG_TWL4030_SCRIPT) ||
> defined(CONFIG_TWL4030_SCRIPT_MODULE) instead. And you should
> probably only enable it based on some board specific flag.

Ok

>
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
>
> The changes above probably also conflict with what I have
> in devel-cleanup branch. So maybe split it so I can take this
> part?
Ok, I will split this change to a separate patch.

> Also, please note that patches touching arch/arm/*omap*/
> files should also be sent with linux-arm-kernel list Cc'd.
Ok

Regards,
Lesly
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
