From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 3/6] OMAP4460: Temperature sensor data
Date: Fri, 23 Sep 2011 19:17:48 +0530
Message-ID: <CAJ6a13bKycJYKa9CG8sgPr8PMO62RYZJ=_UD3ZfjoYQm4GbN0A@mail.gmail.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com>
	<1316705361-12175-4-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56590 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752422Ab1IWNru convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 09:47:50 -0400
Received: by mail-wy0-f179.google.com with SMTP id 36so3790580wyg.38
        for <linux-omap@vger.kernel.org>; Fri, 23 Sep 2011 06:47:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109222319210.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 23, 2011 at 11:33 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> some comments
>
> On Thu, 22 Sep 2011, Keerthy wrote:
>
>> The register set and the
>> bit fields might vary across OMAP versions. Hence
>> creating a structure comprising of all the registers
>> and bit fields to make the driver uniform for all the
>> versions with different register sets. The data file
>> contains the structure populated with register offsets
>> and bit fields corresponding to OMAP4460 on die sensor.
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: tony@atomide.com
>> ---
>> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A0=
2 +-
>> =A0arch/arm/mach-omap2/temp_sensor4460_data.c | =A0115 +++++++++++++=
+++++
>> =A0arch/arm/plat-omap/include/plat/scm.h =A0 =A0 =A0| =A0175 +++++++=
+++++++++++++++++++++
>> =A03 files changed, 291 insertions(+), 1 deletions(-)
>> =A0create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
>> =A0create mode 100644 arch/arm/plat-omap/include/plat/scm.h
>>
>> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Make=
file
>> index 46a3497..e6f8d36 100644
>> --- a/arch/arm/mach-omap2/Makefile
>> +++ b/arch/arm/mach-omap2/Makefile
>> @@ -86,7 +86,7 @@ obj-$(CONFIG_ARCH_OMAP3) =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
>> =A0obj-$(CONFIG_ARCH_OMAP4) =A0 =A0 =A0 =A0 =A0 =A0 +=3D prcm.o cm2x=
xx_3xxx.o cminst44xx.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0cm44xx.o prcm_mpu44xx.o \
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0prminst44xx.o vc44xx_data.o \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0vp44xx_data.o
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0vp44xx_data.o temp_sensor4460_data.o
>
> This is not part of the PRCM, so it should not be added here.
>
> It also should be conditional on CONFIG_SOC_OMAP4460. =A0If that Kcon=
fig
> entry doesn't exist, it should be added.

Ok. I will add it.

>
>> =A0# OMAP voltage domains
>> =A0ifeq ($(CONFIG_PM),y)
>> diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/m=
ach-omap2/temp_sensor4460_data.c
>> new file mode 100644
>> index 0000000..2804615
>> --- /dev/null
>> +++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
>
> Is there some reason why this shouldn't go into drivers/ in some form=
?

This is used by mach-omap2.

>
>> @@ -0,0 +1,115 @@
>> +/*
>> + * OMAP4460 on die Temperature sensor data file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#include <linux/slab.h>
>> +#include "control.h"
>> +#include <plat/scm.h>
>> +
>> +/*
>> + * OMAP4460 has one instance of thermal sensor for MPU
>> + * need to describe the individual bit fields
>> + */
>> +struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers =3D=
 {
>
> This is going to break if we want to compile a kernel with support
> for, say, the 4430 and 4460 temperature sensors.

Ok. I will rename this as omap4460_temp_sensor_registers

>
>> + =A0 =A0 .temp_sensor_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4460=
_TEMP_SENSOR_CTRL_OFFSET,
>> + =A0 =A0 .bgap_tempsoff_mask =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4460_B=
GAP_TEMPSOFF_MASK,
>> + =A0 =A0 .bgap_soc_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP=
4460_BGAP_TEMP_SENSOR_SOC_MASK,
>> + =A0 =A0 .bgap_eocz_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_BGAP_TEMP_SENSOR_EOCZ_MASK,
>> + =A0 =A0 .bgap_dtemp_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP44=
60_BGAP_TEMP_SENSOR_DTEMP_MASK,
>> +
>> + =A0 =A0 .bgap_mask_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_BGAP_CTRL_OFFSET,
>> + =A0 =A0 .mask_hot_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP=
4460_MASK_HOT_MASK,
>> + =A0 =A0 .mask_cold_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_MASK_COLD_MASK,
>> +
>> + =A0 =A0 .bgap_mode_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_BGAP_CTRL_OFFSET,
>> + =A0 =A0 .mode_ctrl_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_SINGLE_MODE_MASK,
>> +
>> + =A0 =A0 .bgap_counter =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP=
4460_BGAP_COUNTER_OFFSET,
>> + =A0 =A0 .counter_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP=
4460_COUNTER_MASK,
>> +
>> + =A0 =A0 .bgap_threshold =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_BGAP_THRESHOLD_OFFSET,
>> + =A0 =A0 .threshold_thot_mask =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4460_T=
_HOT_MASK,
>> + =A0 =A0 .threshold_tcold_mask =A0 =A0 =A0 =A0 =A0 =3D OMAP4460_T_C=
OLD_MASK,
>> +
>> + =A0 =A0 .thsut_threshold =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP44=
60_BGAP_TSHUT_OFFSET,
>
> "tshut" is misspelled.

I will correct this.

>
>> + =A0 =A0 .tshut_hot_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP44=
60_TSHUT_HOT_MASK,
>> + =A0 =A0 .tshut_cold_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP44=
60_TSHUT_COLD_MASK,
>> +
>> + =A0 =A0 .bgap_status =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OM=
AP4460_BGAP_STATUS_OFFSET,
>> + =A0 =A0 .status_clean_stop_mask =A0 =A0 =A0 =A0 =3D OMAP4460_CLEAN=
_STOP_MASK,
>> + =A0 =A0 .status_bgap_alert_mask =A0 =A0 =A0 =A0 =3D OMAP4460_BGAP_=
ALERT_MASK,
>> + =A0 =A0 .status_hot_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP44=
60_HOT_FLAG_MASK,
>> + =A0 =A0 .status_cold_mask =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4460=
_COLD_FLAG_MASK,
>> +
>> + =A0 =A0 .bgap_efuse =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OM=
AP4460_FUSE_OPP_BGAP,
>> +};
>> +
>> +/*
>> + * Temperature values in milli degree celsius
>> + * ADC code values from 530 to 923
>> + */
>> +int adc_to_temp[OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE + 1] =3D =
{
>
> This too looks likely to break if we want to compile a kernel with su=
pport
> for, say, the 4430 and 4460 temperature sensors.

I will change this omap4460_adc_to_temp

>
>> + =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -39000, -3=
8600, -38200,
>> + =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -35200, -3=
4800,
>> + =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -31800, -3=
1300,
>> + =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -28200, -2=
7800,
>> + =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -24800, -2=
4400,
>> + =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -21400, -2=
1000,
>> + =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -18000, -1=
7600,
>> + =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -14600, -1=
4200,
>> + =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -11200, -1=
0700,
>> + =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -7200, -=
6800,
>> + =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -3400, -3=
000,
>> + =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, 1200,=
 1600,
>> + =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600, 6000=
, 6400,
>> + =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200, 106=
00, 11000,
>> + =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 14400, 14=
800,
>> + =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 18200, 18=
700,
>> + =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 22100, 22=
600,
>> + =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 25900, 26=
400,
>> + =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 29800, 30=
200,
>> + =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 33600, 34=
000,
>> + =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 37300, 37=
800,
>> + =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 41100, 41=
600,
>> + =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 44800, 45=
300,
>> + =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 48600, 49=
000,
>> + =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 52400, 52=
800,
>> + =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 56200, 56=
600,
>> + =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 60000, 60=
400,
>> + =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 63800, 64=
200,
>> + =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 67400, 67=
800,
>> + =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 71200, 71=
600,
>> + =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 75000, 75=
400,
>> + =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 78600, 79=
000,
>> + =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 82400, 82=
800,
>> + =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 86000, 86=
400,
>> + =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 89800, 90=
200,
>> + =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 93400, 93=
800,
>> + =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 97200, 97=
600,
>> + =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 100800,=
 101200,
>> + =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 104000, 10=
4400,
>> + =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 107400, 10=
7800,
>> + =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 110600, 11=
1000,
>> + =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 113800, 11=
4200,
>> + =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 117000, 11=
7400,
>> + =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 120200, 12=
0600,
>> + =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
>> +};
>> diff --git a/arch/arm/plat-omap/include/plat/scm.h b/arch/arm/plat-o=
map/include/plat/scm.h
>> new file mode 100644
>> index 0000000..47aa38f
>> --- /dev/null
>> +++ b/arch/arm/plat-omap/include/plat/scm.h
>
> If this is being used by a driver, then this header file should go in=
to
> the appropriate drivers/ subdirectory. =A0If it is being used by code=
 in
> arch/arm/mach-omap2, then please use the existing
> arch/arm/mach-omap2/control.h instead.

The header file has structures used both by drivers/ and mach-omap.
So kept it in plat-omap.

>
>> @@ -0,0 +1,175 @@
>> +/*
>> + * OMAP system control module header file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful, =
but
>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the =
GNU
>> + * General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>> + * 02110-1301 USA
>> + *
>> + */
>> +
>> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
>
> This macro name doesn't match the filename.

Oops yes. I will correct this.

>
> You're also missing important #includes here for things like mutexes
> and kernel types that you use later on in the file.

Those header files are included in c files.

>
>> +
>> +/* Offsets from the base of temperature sensor registers */
>> +
>> +#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET =A0 =A0 0x32C
>> +#define OMAP4460_BGAP_CTRL_OFFSET =A0 =A0 =A0 =A0 =A0 =A00x378
>> +#define OMAP4460_BGAP_COUNTER_OFFSET =A0 =A0 =A0 =A0 0x37C
>> +#define OMAP4460_BGAP_THRESHOLD_OFFSET =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
0x380
>> +#define OMAP4460_BGAP_TSHUT_OFFSET =A0 =A0 =A0 =A0 =A0 0x384
>> +#define OMAP4460_BGAP_STATUS_OFFSET =A0 =A0 =A0 =A0 =A00x388
>> +#define OMAP4460_FUSE_OPP_BGAP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 -0x260
>> +
>> +#define OMAP_ADC_START_VALUE =A0 =A0530
>> +#define OMAP_ADC_END_VALUE =A0 =A0 =A0923
>
> Are these OMAP4460, OMAP4xxx, or OMAP2+ specific?

OMAP4460. I will pass even these values through pdata
since they differ from platform to platform.

>
>> +
>> +/*
>> + * The register offsets and but fields might change across
>> + * OMAP versions hence populating them in this structure.
>> + */
>> +struct omap_temp_sensor_registers {
>> + =A0 =A0 u32 =A0 =A0 temp_sensor_ctrl;
>> + =A0 =A0 u32 =A0 =A0 bgap_tempsoff_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_soc_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_eocz_mask;
>> + =A0 =A0 u32 =A0 =A0 bgap_dtemp_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_mask_ctrl;
>> + =A0 =A0 u32 =A0 =A0 mask_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 mask_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_mode_ctrl;
>> + =A0 =A0 u32 =A0 =A0 mode_ctrl_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_counter;
>> + =A0 =A0 u32 =A0 =A0 counter_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_threshold;
>> + =A0 =A0 u32 =A0 =A0 threshold_thot_mask;
>> + =A0 =A0 u32 =A0 =A0 threshold_tcold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 thsut_threshold;
>
> "tshut" misspelled here.

I will correct this.

>
>> + =A0 =A0 u32 =A0 =A0 tshut_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 tshut_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_status;
>> + =A0 =A0 u32 =A0 =A0 status_clean_stop_mask;
>> + =A0 =A0 u32 =A0 =A0 status_bgap_alert_mask;
>> + =A0 =A0 u32 =A0 =A0 status_hot_mask;
>> + =A0 =A0 u32 =A0 =A0 status_cold_mask;
>> +
>> + =A0 =A0 u32 =A0 =A0 bgap_efuse;
>> +};
>> +
>> +/**
>> + * struct omap4460plus_scm_dev_attr - device attributes for scm
>
> There are loads of references to 'omap4460plus' when it seems to me t=
hat
> much of this driver should also apply to OMAP4430 also. =A0Shouldn't =
this
> driver be named something like 'omap4430plus_scm' or even
> better 'omap4_scm' ?

This is used by hwmod. Hence keeping it in the header file.

>
>> + * @cnt - Number of temperature sensors
>> + * @list - array of pointers to register sets of temp sensors
>> + * @name - array of pointers to names of the temp sensors
>> + * @t_shut - Thermal shutdown interrupt handling required
>> + */
>
> First, thanks for supplying kerneldoc comments. =A0However, the forma=
t of
> your comments does not match Documentation/kernel-doc-nano-HOWTO.txt =
-
> please go back and review this text file and update your comments
> appropriately.

Ok

>
>> +struct omap4460plus_scm_dev_attr {
>> + =A0 =A0 int cnt;
>> + =A0 =A0 struct omap_temp_sensor_registers *list[10];
>> + =A0 =A0 const char *name[10];
>> + =A0 =A0 bool t_shut;
>> +};
>
> You're already passing in lots of data via
> arch/arm/mach-omap2/temp_sensor4460_data.c. =A0Shouldn't this data go=
 into
> this file?

This is used by hwmod. Hence keeping it in the header file.

>
>> +
>> +/* forward declaration */
>> +struct scm;
>> +
>> +/**
>> + * struct temp_sensor_hwmon - temperature sensor hwmon device struc=
ture
>> + * @scm_ptr - pointer to system control module structure
>> + * @pdev - platform device pointer for hwmon device
>> + * @name - Name of the hwmon temp sensor device
>> + */
>> +struct temp_sensor_hwmon {
>> + =A0 =A0 struct scm =A0 =A0 =A0 =A0 =A0 =A0 =A0*scm_ptr;
>> + =A0 =A0 struct platform_device =A0*pdev;
>> + =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
>> +};
>> +
>> +/**
>> + * struct system control module - scm device structure
>> + * @dev - device pointer
>> + * @registers - Pointer to the list of register offsets and bitfiel=
ds
>> + * @fclock - pointer to functional clock of temperature sensor
>> + * @div_clk - pointer to parent clock of temperature sensor fclk
>> + * @tsh_ptr - pointer to temperature sesnor hwmon struct
>> + * @name - pointer to list of temperature sensor instance names is =
scm
>> + * @scm_mutex - Mutex for sysfs, irq and PM
>> + * @irq - MPU Irq number for thermal alert
>> + * @phy_base - Physical base of the temp I/O
>> + * @clk_rate - Holds current clock rate
>> + * @temp_sensor_ctrl - temp sensor control register value
>> + * @bg_ctrl - bandgap ctrl register value
>> + * @bg_counter - bandgap counter value
>> + * @bg_threshold - bandgap threshold register value
>> + * @temp_sensor_tshut_threshold - bandgap tshut register value
>> + * @cnt - count of temperature sensor device in scm
>> + */
>> +struct scm {
>> + =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *dev;
>> + =A0 =A0 struct omap_temp_sensor_registers **registers;
>> + =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*fclock;
>> + =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*div_clk;
>> + =A0 =A0 struct temp_sensor_hwmon *tsh_ptr;
>> + =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0**name;
>> + =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0scm_mutex; /* Mutex fo=
r sysfs, irq and PM */
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
>> + =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ct=
rl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counter;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_threshold;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_ts=
hut_threshold;
>> + =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cnt;
>> +};
>> +
>> +extern struct omap_temp_sensor_registers omap_mpu_temp_sensor_regis=
ters;
>> +extern int adc_to_temp[394];
>> +
>> +/*
>> + * struct omap4460plus_scm_pdata - omap4460plus_scm platform data
>> + * @registers - =A0pointer to list of register sets of temp sensors
>> + * @name - pointer to list of names of temp sensors
>> + * @cnt =A0 =A0 =A0- Number of temperature sensors
>> + * @min_freq - The minimum frequency for temp sensor to be operatio=
nal
>> + * @max_freq - The maximum frequency at which temp sensor is operat=
ional
>> + * @t_shut - Thermal shutdown interrupt handling required
>> + */
>> +struct omap4460plus_scm_pdata {
>> + =A0 =A0 struct omap_temp_sensor_registers **registers;
>> + =A0 =A0 const char **name;
>> + =A0 =A0 int cnt;
>> + =A0 =A0 u32 min_freq;
>> + =A0 =A0 u32 max_freq;
>> + =A0 =A0 bool t_shut;
>> +};
>> +
>> +int omap4460plus_scm_show_temp_max(struct scm *scm_ptr, int id);
>> +int omap4460plus_scm_show_temp_max_hyst(struct scm *scm_ptr, int id=
);
>> +int omap4460plus_scm_set_temp_max(struct scm *scm_ptr, int id, int =
val);
>> +int omap4460plus_scm_set_temp_max_hyst(struct scm *scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int id, int val);
>> +int omap4460plus_scm_show_update_interval(struct scm *scm_ptr, int =
id);
>> +void omap4460plus_scm_set_update_interval(struct scm *scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 u32 interval, int id);
>> +int omap4460plus_scm_read_temp(struct scm *scm_ptr, int id);
>> +
>> +#endif
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
