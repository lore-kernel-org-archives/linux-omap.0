From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH 4/6 V4] OMAP4: Hwmod: OMAP temperature sensor
Date: Tue, 6 Sep 2011 23:54:17 +0530
Message-ID: <CAJ6a13ZLk2oPyFCjW_QL0fBgLB47hbHyXVMXuBdyUiXShVWGnA@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-5-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311656160.26173@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:41801 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753642Ab1IFSYS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Sep 2011 14:24:18 -0400
Received: by mail-gw0-f51.google.com with SMTP id 17so3289863gwj.10
        for <linux-omap@vger.kernel.org>; Tue, 06 Sep 2011 11:24:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1108311656160.26173@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com

On Thu, Sep 1, 2011 at 4:46 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Keerthy, Beno=EEt,
>
> On Wed, 31 Aug 2011, Keerthy wrote:
>
>> From: Benoit Cousson <b-cousson@ti.com>
>>
>> OMAP4460 temperature sensor hwmod cannot be auto generated
>> since it is part of ctrl module. Hence populating the
>> necessary hwmod info manually.
>
> Looking at the 4460 1.x TRM Rev H, does it makes sense to create a
> separate hwmod structure for this IP block? =A0It looks to me like th=
ese
> registers are integrated pretty tightly inside the SYSCTRL_GENERAL_CO=
RE IP
> block. =A0So from a hwmod perspective, it seems to be a different sit=
uation
> than, say, the RFBI block inside the DSS subsystem?
>
> Just based on looking at Table 18-110 "Control Module Instance Summar=
y"
> and Table 18-111 "SYSCTRL_GENERAL_CORE Register Mapping Summary", it =
seems
> to me that this IP block is best represented as an MFD. =A0Something =
like
> drivers/mfd/wm8350-core.c, which registers a hwmon device, which is t=
hen
> driven by drivers/hwmon/wm8350-hwmon.c.

In case of OMAP4460 only one instance of thermal sensor is present.
If i take the case of OMAP5 multiple (3) instances are present. I agree
all the registers are part of SYSCTRL. Defining a hwmod i could easily
call omap_hwmod_for_each_by_class() for multiple instances. WIthout
hwmod i am not sure how to cater to this requirement. Any inputs?

>
> That should avoid the need for this hwmod entry too.
>
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc: tony@atomide.com
>> Cc: b-cousson@ti.com
>> ---
>> =A0arch/arm/mach-omap2/omap_hwmod_44xx_data.c | =A0 61 +++++++++++++=
+++++++++++++++
>> =A01 files changed, 61 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/m=
ach-omap2/omap_hwmod_44xx_data.c
>> index 6201422..28bf6d3 100644
>> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
>> @@ -29,6 +29,7 @@
>> =A0#include <plat/mcbsp.h>
>> =A0#include <plat/mmc.h>
>> =A0#include <plat/i2c.h>
>> +#include <plat/temperature_sensor.h>
>>
>> =A0#include "omap_hwmod_common_data.h"
>>
>> @@ -832,6 +833,63 @@ static struct omap_hwmod omap44xx_aess_hwmod =3D=
 {
>> =A0};
>>
>> =A0/*
>> + * 'temperature_sensor' class
>> + * temperature sensor module inside the bandgap / control module
>> + */
>> +
>> +static struct omap_hwmod_class omap44xx_temperature_sensor_hwmod_cl=
ass =3D {
>> + =A0 =A0 .name =A0 =3D "temperature_sensor",
>> +};
>> +
>> +static struct omap_hwmod_irq_info omap44xx_temperature_sensor_irqs[=
] =3D {
>> + =A0 =A0 { .name =3D "thermal_alert", .irq =3D 126 + OMAP44XX_IRQ_G=
IC_START },
>> +};
>> +
>> +static struct omap_hwmod_addr_space omap44xx_temperature_sensor_add=
rs[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_start =A0 =A0 =A0 =3D 0x4a00232c,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .pa_end =A0 =A0 =A0 =A0 =3D 0x4a00238b,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct omap_hwmod omap44xx_temperature_sensor_hwmod;
>> +/* l4_cfg -> ctrl_module_core */
>> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__temperature_sensor=
 =3D {
>> + =A0 =A0 .master =A0 =A0 =A0 =A0 =3D &omap44xx_l4_cfg_hwmod,
>> + =A0 =A0 .slave =A0 =A0 =A0 =A0 =A0=3D &omap44xx_temperature_sensor=
_hwmod,
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D "l4_div_ck",
>> + =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D omap44xx_temperature_sensor_=
addrs,
>> + =A0 =A0 .user =A0 =A0 =A0 =A0 =A0 =3D OCP_USER_MPU | OCP_USER_SDMA=
,
>> +};
>> +
>> +/* ctrl_module_core slave ports */
>> +static struct omap_hwmod_ocp_if *omap44xx_temperature_sensor_slaves=
[] =3D {
>> + =A0 =A0 &omap44xx_l4_cfg__temperature_sensor,
>> +};
>> +
>> +/* temperature sensor dev_attr */
>> +static struct omap_temp_sensor_dev_attr temp_sensor_dev_attr =3D {
>> + =A0 =A0 .name =A0 =3D "mpu",
>> +};
>> +
>> +static struct omap_hwmod omap44xx_temperature_sensor_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "temperature_sensor_mpu",
>> + =A0 =A0 .class =A0 =A0 =A0 =A0 =A0=3D &omap44xx_temperature_sensor=
_hwmod_class,
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D omap44xx_temperature_sensor_irqs=
,
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "bandgap_ts_fclk",
>> + =A0 =A0 .slaves =A0 =A0 =A0 =A0 =3D omap44xx_temperature_sensor_sl=
aves,
>> + =A0 =A0 .slaves_cnt =A0 =A0 =3D ARRAY_SIZE(omap44xx_temperature_se=
nsor_slaves),
>> + =A0 =A0 .clkdm_name =A0 =A0 =3D "l4_wkup_clkdm",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap4 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .clkctrl_offs =3D OMAP4_CM_WKUP_BANDGAP_CL=
KCTRL_OFFSET,
>> + =A0 =A0 =A0 =A0 =A0 =A0 },
>> + =A0 =A0 },
>> + =A0 =A0 .dev_attr =A0 =A0 =A0 =3D &temp_sensor_dev_attr,
>> + =A0 =A0 .omap_chip =A0 =A0 =A0=3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430)=
,
>> +};
>> +
>> +/*
>> =A0 * 'bandgap' class
>> =A0 * bangap reference for ldo regulators
>> =A0 */
>> @@ -5469,6 +5527,9 @@ static __initdata struct omap_hwmod *omap44xx_=
hwmods[] =3D {
>> =A0 =A0 =A0 &omap44xx_timer10_hwmod,
>> =A0 =A0 =A0 &omap44xx_timer11_hwmod,
>>
>> + =A0 =A0 /* temperature sensor hwmod */
>> + =A0 =A0 &omap44xx_temperature_sensor_hwmod,
>> +
>> =A0 =A0 =A0 /* uart class */
>> =A0 =A0 =A0 &omap44xx_uart1_hwmod,
>> =A0 =A0 =A0 &omap44xx_uart2_hwmod,
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



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
