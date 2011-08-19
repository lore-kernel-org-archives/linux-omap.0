From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [RFC PATCH 6/6 V2] hwmon: OMAP4: On die temperature sensor driver
Date: Fri, 19 Aug 2011 18:23:16 +0530
Message-ID: <CAJ6a13YLdEUxWEQ2nAmvqE33RLBow_zNw04y_PknFtMr98fM9Q@mail.gmail.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
	<1313664735-8917-7-git-send-email-j-keerthy@ti.com>
	<20110819021333.GA27544@ericsson.com>
	<CAJ6a13b6EQNhkQ+i5vf0kxKJ3RadY7iSCSJwZ5_sd3Y0BydUow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41404 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279Ab1HSMxT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 19 Aug 2011 08:53:19 -0400
Received: by mail-gw0-f46.google.com with SMTP id a12so1888239gwa.5
        for <linux-omap@vger.kernel.org>; Fri, 19 Aug 2011 05:53:17 -0700 (PDT)
In-Reply-To: <CAJ6a13b6EQNhkQ+i5vf0kxKJ3RadY7iSCSJwZ5_sd3Y0BydUow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 19, 2011 at 11:34 AM, J, KEERTHY <j-keerthy@ti.com> wrote:
> On Fri, Aug 19, 2011 at 7:43 AM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
>> On Thu, Aug 18, 2011 at 06:52:15AM -0400, Keerthy wrote:
>>> On chip temperature sensor driver. The driver monitors the temperat=
ure of
>>> the MPU subsystem of the OMAP4. It sends notifications to the user =
space if
>>> the temperature crosses user defined thresholds via kobject_uevent =
interface.
>>> The user is allowed to configure the temperature thresholds vis sys=
fs nodes
>>> exposed using hwmon interface.
>>>
>>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>>> Cc: Jean Delvare <khali@linux-fr.org>
>>> Cc: Guenter Roeck <guenter.roeck@ericsson.com>
>>> Cc: lm-sensors@lm-sensors.org
>>
>> High level review:
>>
>> - too much and too broad mutex locking. show functions should not ne=
ed locks at all,
>> =A0set functions only while data is written into registers and into =
platform data.
>
> Ok. I will clean this.

Even the show function might read an inconsistent value without
a mutex lock if the registers were written using set function was
preempted. There is a necessity for mutex locking even in show function=
=2E

>
>> - driver is quite noisy. There should definitely not be any log mess=
ages
>> =A0if a set parameter is wrong. Show functions already return an err=
or value
>> =A0to the user; a log message indicating the error again just create=
s noise.
>> =A0For one boolean set during probe (is_efuse_valid), each subsequen=
t show results
>> =A0in a log message if it is false. Some errors result in multiple l=
og messages.
>
> A user tries to set an invalid temperature threshold. The user should
> be notified about this. The invalid temperature will not be set. The =
user
> should not be allowed to set an invalid temperature. It is to inform
> the user about precisely the problem with the parameter.
>
> In some of the samples the bandgap is not trimmed and hence
> temperature reported will be wrong. So every time a user tries to rea=
d
> he is alerted that the temperatures are not accurate.
>
>> - Wrong use of EINVAL throughout the driver (EINVAL is "Invalid Argu=
ment")
>
> Ok. I will correct this.
>
>> - excessive ( )
>
> Ok.
>
>> - linear search through a sorted array is very expensive. Consider u=
sing a binary search.
>
> Yes. I will implement binary search.
>
>> - temp_to_adc_conversion return code (error if negative) is not chec=
ked properly.
>
> Ok. I will add checks.
>
>>
>> I am sure there are other problems, but those are difficult to find =
with all the noise
>> above.
>>
>> Guenter
>>
>>> ---
>>> =A0Documentation/hwmon/omap_temp_sensor | =A0 27 +
>>> =A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 11 +
>>> =A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
>>> =A0drivers/hwmon/omap_temp_sensor.c =A0 =A0 | =A0918 ++++++++++++++=
++++++++++++++++++++
>>> =A04 files changed, 957 insertions(+), 0 deletions(-)
>>> =A0create mode 100644 Documentation/hwmon/omap_temp_sensor
>>> =A0create mode 100644 drivers/hwmon/omap_temp_sensor.c
>>>
>>> diff --git a/Documentation/hwmon/omap_temp_sensor b/Documentation/h=
wmon/omap_temp_sensor
>>> new file mode 100644
>>> index 0000000..e01a6d6
>>> --- /dev/null
>>> +++ b/Documentation/hwmon/omap_temp_sensor
>>> @@ -0,0 +1,27 @@
>>> +Kernel driver omap_temp_sensor
>>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>>> +
>>> +Supported chips:
>>> + =A0* Texas Instruments OMAP4460
>>> + =A0 =A0Prefix: 'omap_temp_sensor'
>>> + =A0 =A0Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp=
102.html
>>> +
>>> +Author:
>>> + =A0 =A0 =A0 =A0J Keerthy <j-keerthy@ti.com>
>>> +
>>> +Description
>>> +-----------
>>> +
>>> +The Texas Instruments OMAP4 family of chips have a bandgap tempera=
ture sensor.
>>> +The temperature sensor feature is used to convert the temperature =
of the device
>>> +into a decimal value coded on 10 bits. An internal ADC is used for=
 conversion.
>>> +The recommended operating temperatures must be in the range -40 de=
gree Celsius
>>> +to 123 degree celsius for standard conversion.
>>> +The thresholds are programmable and upon crossing the thresholds a=
n interrupt
>>> +is generated. The OMAP temperature sensor has a programmable updat=
e rate in
>>> +milli seconds.
>>> +(Currently the driver programs a default of 2000 milli seconds).
>>> +
>>> +The driver provides the common sysfs-interface for temperatures (s=
ee
>>> +Documentation/hwmon/sysfs-interface under Temperatures).
>>> +
>>> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
>>> index 5f888f7..9c9cd8b 100644
>>> --- a/drivers/hwmon/Kconfig
>>> +++ b/drivers/hwmon/Kconfig
>>> @@ -323,6 +323,17 @@ config SENSORS_F71805F
>>> =A0 =A0 =A0 =A0 =A0 This driver can also be built as a module. =A0I=
f so, the module
>>> =A0 =A0 =A0 =A0 =A0 will be called f71805f.
>>>
>>> +config SENSORS_OMAP_BANDGAP_TEMP_SENSOR
>>> + =A0 =A0 =A0 bool "OMAP on-die temperature sensor hwmon driver"
>>> + =A0 =A0 =A0 depends on HWMON && ARCH_OMAP && OMAP_TEMP_SENSOR
>>> + =A0 =A0 =A0 help
>>> + =A0 =A0 =A0 =A0 If you say yes here you get support for hardware
>>> + =A0 =A0 =A0 =A0 monitoring features of the OMAP on die temperatur=
e
>>> + =A0 =A0 =A0 =A0 sensor.
>>> +
>>> + =A0 =A0 =A0 =A0 Continuous conversion programmable delay
>>> + =A0 =A0 =A0 =A0 mode is used for temperature conversion.
>>> +
>>> =A0config SENSORS_F71882FG
>>> =A0 =A0 =A0 =A0 tristate "Fintek F71882FG and compatibles"
>>> =A0 =A0 =A0 =A0 help
>>> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
>>> index 28061cf..d0f89f5 100644
>>> --- a/drivers/hwmon/Makefile
>>> +++ b/drivers/hwmon/Makefile
>>> @@ -91,6 +91,7 @@ obj-$(CONFIG_SENSORS_MAX6639) +=3D max6639.o
>>> =A0obj-$(CONFIG_SENSORS_MAX6642) =A0+=3D max6642.o
>>> =A0obj-$(CONFIG_SENSORS_MAX6650) =A0+=3D max6650.o
>>> =A0obj-$(CONFIG_SENSORS_MC13783_ADC)+=3D mc13783-adc.o
>>> +obj-$(CONFIG_SENSORS_OMAP_BANDGAP_TEMP_SENSOR) =A0+=3D omap_temp_s=
ensor.o
>>> =A0obj-$(CONFIG_SENSORS_PC87360) =A0+=3D pc87360.o
>>> =A0obj-$(CONFIG_SENSORS_PC87427) =A0+=3D pc87427.o
>>> =A0obj-$(CONFIG_SENSORS_PCF8591) =A0+=3D pcf8591.o
>>> diff --git a/drivers/hwmon/omap_temp_sensor.c b/drivers/hwmon/omap_=
temp_sensor.c
>>> new file mode 100644
>>> index 0000000..586a361
>>> --- /dev/null
>>> +++ b/drivers/hwmon/omap_temp_sensor.c
>>> @@ -0,0 +1,918 @@
>>> +/*
>>> + * OMAP4 Temperature sensor driver file
>>> + *
>>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.=
ti.com/
>>> + * Author: J Keerthy <j-keerthy@ti.com>
>>> + * Author: Moiz Sonasath <m-sonasath@ti.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or
>>> + * modify it under the terms of the GNU General Public License
>>> + * version 2 as published by the Free Software Foundation.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,=
 but
>>> + * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the=
 GNU
>>> + * General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public Licen=
se
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>>> + * 02110-1301 USA
>>> + *
>>> + */
>>> +
>>> +#include <linux/interrupt.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/init.h>
>>> +#include <plat/omap_device.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/device.h>
>>> +#include <linux/jiffies.h>
>>> +#include <linux/hwmon.h>
>>> +#include <linux/hwmon-sysfs.h>
>>> +#include <linux/stddef.h>
>>> +#include <linux/sysfs.h>
>>> +#include <linux/err.h>
>>> +#include <linux/types.h>
>>> +#include <linux/mutex.h>
>>> +#include <linux/pm_runtime.h>
>>> +#include <linux/delay.h>
>>> +#include <plat/temperature_sensor.h>
>>> +
>>> +#define TSHUT_THRESHOLD_HOT =A0 =A0122000 =A0/* 122 deg C */
>>> +#define TSHUT_THRESHOLD_COLD =A0 100000 =A0/* 100 deg C */
>>> +#define BGAP_THRESHOLD_T_HOT =A0 73000 =A0 /* 73 deg C */
>>> +#define BGAP_THRESHOLD_T_COLD =A071000 =A0 /* 71 deg C */
>>> +#define OMAP_ADC_START_VALUE =A0 530
>>> +#define OMAP_ADC_END_VALUE =A0 =A0 923
>>> +
>>> +/*
>>> + * omap_temp_sensor structure
>>> + * @hwmon_dev - device pointer
>>> + * @clock - Clock pointer
>>> + * @registers - Pointer to structure with register offsets and bit=
fields
>>> + * @sensor_mutex - Mutex for sysfs, irq and PM
>>> + * @irq - MPU Irq number for thermal alert
>>> + * @phy_base - Physical base of the temp I/O
>>> + * @clk_rate - Holds current clock rate
>>> + * @temp_sensor_ctrl - temp sensor control register value
>>> + * @bg_ctrl - bandgap ctrl register value
>>> + * @bg_counter - bandgap counter value
>>> + * @bg_threshold - bandgap threshold register value
>>> + * @temp_sensor_tshut_threshold - bandgap tshut register value
>>> + * @is_efuse_valid - Flag to determine if efuse is valid or not
>>> + * @clk_on - Manages the current clock state
>>> + */
>>> +struct omap_temp_sensor {
>>> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *hwmon_dev;
>>> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*clock;
>>> + =A0 =A0 =A0 struct omap_temp_sensor_registers *registers;
>>> + =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0sensor_mutex; /* =
Mutex for sysfs, irq and PM */
>>> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq;
>>> + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0*phy_base;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_rate;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sens=
or_ctrl;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_ctrl;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_counte=
r;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bg_thresh=
old;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sens=
or_tshut_threshold;
>>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0is_efuse_=
valid;
>>> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_on;
>>> +};
>>> +
>>> +/*
>>> + * Temperature values in milli degree celsius
>>> + * ADC code values from 530 to 923
>>> + */
>>> +static int adc_to_temp[] =3D {
>>> + =A0 =A0 =A0 -40000, -40000, -40000, -40000, -39800, -39400, -3900=
0, -38600, -38200,
>>> + =A0 =A0 =A0 -37800, -37300, -36800, -36400, -36000, -35600, -3520=
0, -34800,
>>> + =A0 =A0 =A0 -34300, -33800, -33400, -33000, -32600, -32200, -3180=
0, -31300,
>>> + =A0 =A0 =A0 -30800, -30400, -30000, -29600, -29200, -28700, -2820=
0, -27800,
>>> + =A0 =A0 =A0 -27400, -27000, -26600, -26200, -25700, -25200, -2480=
0, -24400,
>>> + =A0 =A0 =A0 -24000, -23600, -23200, -22700, -22200, -21800, -2140=
0, -21000,
>>> + =A0 =A0 =A0 -20600, -20200, -19700, -19200, -18800, -18400, -1800=
0, -17600,
>>> + =A0 =A0 =A0 -17200, -16700, -16200, -15800, -15400, -15000, -1460=
0, -14200,
>>> + =A0 =A0 =A0 -13700, -13200, -12800, -12400, -12000, -11600, -1120=
0, -10700,
>>> + =A0 =A0 =A0 -10200, -9800, -9400, -9000, -8600, -8200, -7700, -72=
00, -6800,
>>> + =A0 =A0 =A0 -6400, -6000, -5600, -5200, -4800, -4300, -3800, -340=
0, -3000,
>>> + =A0 =A0 =A0 -2600, -2200, -1800, -1300, -800, -400, 0, 400, 800, =
1200, 1600,
>>> + =A0 =A0 =A0 2100, 2600, 3000, 3400, 3800, 4200, 4600, 5100, 5600,=
 6000, 6400,
>>> + =A0 =A0 =A0 6800, 7200, 7600, 8000, 8500, 9000, 9400, 9800, 10200=
, 10600, 11000,
>>> + =A0 =A0 =A0 11400, 11900, 12400, 12800, 13200, 13600, 14000, 1440=
0, 14800,
>>> + =A0 =A0 =A0 15300, 15800, 16200, 16600, 17000, 17400, 17800, 1820=
0, 18700,
>>> + =A0 =A0 =A0 19200, 19600, 20000, 20400, 20800, 21200, 21600, 2210=
0, 22600,
>>> + =A0 =A0 =A0 23000, 23400, 23800, 24200, 24600, 25000, 25400, 2590=
0, 26400,
>>> + =A0 =A0 =A0 26800, 27200, 27600, 28000, 28400, 28800, 29300, 2980=
0, 30200,
>>> + =A0 =A0 =A0 30600, 31000, 31400, 31800, 32200, 32600, 33100, 3360=
0, 34000,
>>> + =A0 =A0 =A0 34400, 34800, 35200, 35600, 36000, 36400, 36800, 3730=
0, 37800,
>>> + =A0 =A0 =A0 38200, 38600, 39000, 39400, 39800, 40200, 40600, 4110=
0, 41600,
>>> + =A0 =A0 =A0 42000, 42400, 42800, 43200, 43600, 44000, 44400, 4480=
0, 45300,
>>> + =A0 =A0 =A0 45800, 46200, 46600, 47000, 47400, 47800, 48200, 4860=
0, 49000,
>>> + =A0 =A0 =A0 49500, 50000, 50400, 50800, 51200, 51600, 52000, 5240=
0, 52800,
>>> + =A0 =A0 =A0 53200, 53700, 54200, 54600, 55000, 55400, 55800, 5620=
0, 56600,
>>> + =A0 =A0 =A0 57000, 57400, 57800, 58200, 58700, 59200, 59600, 6000=
0, 60400,
>>> + =A0 =A0 =A0 60800, 61200, 61600, 62000, 62400, 62800, 63300, 6380=
0, 64200,
>>> + =A0 =A0 =A0 64600, 65000, 65400, 65800, 66200, 66600, 67000, 6740=
0, 67800,
>>> + =A0 =A0 =A0 68200, 68700, 69200, 69600, 70000, 70400, 70800, 7120=
0, 71600,
>>> + =A0 =A0 =A0 72000, 72400, 72800, 73200, 73600, 74100, 74600, 7500=
0, 75400,
>>> + =A0 =A0 =A0 75800, 76200, 76600, 77000, 77400, 77800, 78200, 7860=
0, 79000,
>>> + =A0 =A0 =A0 79400, 79800, 80300, 80800, 81200, 81600, 82000, 8240=
0, 82800,
>>> + =A0 =A0 =A0 83200, 83600, 84000, 84400, 84800, 85200, 85600, 8600=
0, 86400,
>>> + =A0 =A0 =A0 86800, 87300, 87800, 88200, 88600, 89000, 89400, 8980=
0, 90200,
>>> + =A0 =A0 =A0 90600, 91000, 91400, 91800, 92200, 92600, 93000, 9340=
0, 93800,
>>> + =A0 =A0 =A0 94200, 94600, 95000, 95500, 96000, 96400, 96800, 9720=
0, 97600,
>>> + =A0 =A0 =A0 98000, 98400, 98800, 99200, 99600, 100000, 100400, 10=
0800, 101200,
>>> + =A0 =A0 =A0 101600, 102000, 102400, 102800, 103200, 103600, 10400=
0, 104400,
>>> + =A0 =A0 =A0 104800, 105200, 105600, 106100, 106600, 107000, 10740=
0, 107800,
>>> + =A0 =A0 =A0 108200, 108600, 109000, 109400, 109800, 110200, 11060=
0, 111000,
>>> + =A0 =A0 =A0 111400, 111800, 112200, 112600, 113000, 113400, 11380=
0, 114200,
>>> + =A0 =A0 =A0 114600, 115000, 115400, 115800, 116200, 116600, 11700=
0, 117400,
>>> + =A0 =A0 =A0 117800, 118200, 118600, 119000, 119400, 119800, 12020=
0, 120600,
>>> + =A0 =A0 =A0 121000, 121400, 121800, 122200, 122600, 123000
>>> +};
>>> +
>>> +static unsigned long omap_temp_sensor_readl(struct omap_temp_senso=
r
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 *temp_sensor, u32 reg)
>>> +{
>>> + =A0 =A0 =A0 return __raw_readl(temp_sensor->phy_base + reg);
>>> +}
>>> +
>>> +static void omap_temp_sensor_writel(struct omap_temp_sensor *temp_=
sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 u32 val, u32 reg)
>>> +{
>>> + =A0 =A0 =A0 __raw_writel(val, (temp_sensor->phy_base + reg));
>>> +}
>>> +
>>> +static int adc_to_temp_conversion(int adc_val)
>>> +{
>>> + =A0 =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
>>> +}
>>> +
>>> +static int temp_to_adc_conversion(long temp)
>>> +{
>>> + =A0 =A0 =A0 int i;
>>> +
>>> + =A0 =A0 =A0 for (i =3D 0; i <=3D OMAP_ADC_END_VALUE - OMAP_ADC_ST=
ART_VALUE; i++)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[i])
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return OMAP_ADC_START=
_VALUE + i - 1;
>>> +
>>> + =A0 =A0 =A0 return -EINVAL;
>>> +}
>>> +
>>> +static void omap_configure_temp_sensor_thresholds(struct omap_temp=
_sensor
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *temp_sensor)
>>> +{
>>> + =A0 =A0 =A0 u32 temp, t_hot, t_cold, tshut_hot, tshut_cold;
>>> +
>>> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_HOT=
);
>>> + =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(BGAP_THRESHOLD_T_CO=
LD);
>>> +
>>> + =A0 =A0 =A0 /* Configure the TALERT thresholds */
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 temp |=3D (t_hot << __ffs(temp_sensor->registers->thr=
eshold_thot_mask)) |
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (t_cold << __ffs(temp_sensor->registe=
rs->threshold_tcold_mask));
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshol=
d);
>>> +
>>> + =A0 =A0 =A0 tshut_hot =3D temp_to_adc_conversion(TSHUT_THRESHOLD_=
HOT);
>>> + =A0 =A0 =A0 tshut_cold =3D temp_to_adc_conversion(TSHUT_THRESHOLD=
_COLD);
>>> +
>>> + =A0 =A0 =A0 /* Configure the TSHUT thresholds */
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->thsut_threshold);
>>> + =A0 =A0 =A0 temp |=3D (tshut_hot << __ffs(temp_sensor->registers-=
>tshut_hot_mask))
>>> + =A0 =A0 =A0 =A0 =A0 | (tshut_cold << __ffs(temp_sensor->registers=
->tshut_hot_mask));
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->thsut_threshold);
>>> +}
>>> +
>>> +static void omap_configure_temp_sensor_counter(struct omap_temp_se=
nsor
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0*temp_sensor, u32 counter)
>>> +{
>>> + =A0 =A0 =A0 u32 val;
>>> +
>>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_counter);
>>> + =A0 =A0 =A0 val &=3D ~(temp_sensor->registers->counter_mask);
>>> + =A0 =A0 =A0 val |=3D (counter << __ffs(temp_sensor->registers->co=
unter_mask));
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_counter);
>>> +}
>>> +
>>> +static void omap_enable_continuous_mode(struct omap_temp_sensor *t=
emp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 bool enable)
>>> +{
>>> + =A0 =A0 =A0 u32 val;
>>> +
>>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_mode_ctrl);
>>> +
>>> + =A0 =A0 =A0 if (enable)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D (1 << __ffs(temp_sensor->reg=
isters->mode_ctrl_mask));
>>> + =A0 =A0 =A0 else
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(temp_sensor->registers->mo=
de_ctrl_mask);
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_mode_ctrl);
>>> +}
>>> +
>>> +/* Sysfs hook functions */
>>> +
>>> +static ssize_t show_temp_max(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribu=
te *devattr, char *buf)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 int temp;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_th=
ot_mask)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 >> __ffs(temp_sensor-=
>registers->threshold_thot_mask);
>>> +
>>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_EN=
D_VALUE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mut=
ex);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>>> +}
>>> +
>>> +static ssize_t set_temp_max(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device=
_attribute *devattr,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *b=
uf, size_t count)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val, =
t_cold, t_hot, temp;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>>> + =A0 =A0 =A0 if ((t_hot < OMAP_ADC_START_VALUE || t_hot > OMAP_ADC=
_END_VALUE)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* obtain the T cold value */
>>> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 t_cold =3D (t_cold & temp_sensor->registers->threshol=
d_tcold_mask) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->threshold_tcold_mask);
>>> +
>>> + =A0 =A0 =A0 if (t_hot < t_cold) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_HOT value less=
er than T_COLD\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* write the new t_hot value */
>>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_thot=
_mask);
>>> + =A0 =A0 =A0 reg_val |=3D (t_hot <<
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->threshold_thot_mask));
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> +
>>> + =A0 =A0 =A0 /* Read the current temperature */
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->temp_sensor_ctrl);
>>> + =A0 =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If user sets the HIGH threshold(t_hot) greater t=
han the current
>>> + =A0 =A0 =A0 =A0* temperature(temp) unmask the HOT interrupts
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (t_hot > temp) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(te=
mp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers=
->mask_cold_mask);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_hot_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, =
reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and=
 cold thresholds,
>>> + =A0 =A0 =A0 =A0* Enable both masks.
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (temp > t_cold && temp < t_hot) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(te=
mp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_cold_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_hot_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, =
reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4=
460_BGAP_CTRL_OFFSET);
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immedi=
ately compare
>>> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordi=
ngly
>>> + =A0 =A0 =A0 =A0*/
>>> +out:
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 return count;
>>> +}
>>> +
>>> +static ssize_t show_temp_max_hyst(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribute *devattr, cha=
r *buf)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshol=
d);
>>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->threshold_tc=
old_mask) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->registers->thresho=
ld_tcold_mask);
>>> +
>>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_EN=
D_VALUE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid value\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mut=
ex);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 return snprintf(buf, 16, "%d\n", temp);
>>> +}
>>> +
>>> +static ssize_t set_temp_max_hyst(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0st=
ruct device_attribute *devattr,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0co=
nst char *buf, size_t count)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor =
=3D dev_get_drvdata(dev);
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 reg_val, t_hot, t_cold, temp;
>>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0val;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>>> + =A0 =A0 =A0 if (t_cold < OMAP_ADC_START_VALUE || t_cold > OMAP_AD=
C_END_VALUE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid range");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* obtain the T HOT value */
>>> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 t_hot =3D (t_hot & temp_sensor->registers->threshold_=
thot_mask) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->threshold_thot_mask);
>>> +
>>> + =A0 =A0 =A0 if (t_cold > t_hot) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Error! T_COLD value gre=
ater than T_HOT\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* write the new t_cold value */
>>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> + =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->threshold_tcol=
d_mask);
>>> + =A0 =A0 =A0 reg_val |=3D (t_cold <<
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->threshold_tcold_mask));
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_threshold);
>>> +
>>> + =A0 =A0 =A0 /* Read the current temperature */
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_c=
trl);
>>> + =A0 =A0 =A0 temp &=3D (temp_sensor->registers->bgap_dtemp_mask);
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If user sets the LOW threshold(t_cold) lower tha=
n the current
>>> + =A0 =A0 =A0 =A0* temperature(temp) unmask the COLD interrupts
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (t_cold < temp) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(te=
mp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers=
->mask_hot_mask);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_cold_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, =
reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* If current temperature is in-between the hot and=
 cold thresholds,
>>> + =A0 =A0 =A0 =A0* Enable both masks.
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (temp < t_hot && temp > t_cold) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(te=
mp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_cold_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D temp_sensor->registers->=
mask_hot_mask;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, =
reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* else no need to do anything since HW will immedi=
ately compare
>>> + =A0 =A0 =A0 =A0* the new threshold and generate interrupt accordi=
ngly
>>> + =A0 =A0 =A0 =A0*/
>>> +
>>> +out:
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 return count;
>>> +}
>>> +
>>> +static ssize_t show_update_rate(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct device_attribu=
te *devattr, char *buf)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D =
0, ret =3D 0;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 if (!temp_sensor->clk_rate) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "clk_rate is NULL\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_counter);
>>> + =A0 =A0 =A0 temp =3D (temp & temp_sensor->registers->counter_mask=
) >>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __ffs(temp_sensor->re=
gisters->counter_mask);
>>> + =A0 =A0 =A0 temp =3D temp * 1000 / (temp_sensor->clk_rate);
>>> +
>>> +out:
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 if (!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>>> +
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +static ssize_t set_update_rate(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct=
 device_attribute *devattr,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const =
char *buf, size_t count)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_val;
>>> + =A0 =A0 =A0 long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 if (strict_strtol(buf, 10, &val)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 val *=3D temp_sensor->clk_rate / 1000;
>>> + =A0 =A0 =A0 reg_val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_counter);
>>> +
>>> + =A0 =A0 =A0 reg_val &=3D ~(temp_sensor->registers->counter_mask);
>>> + =A0 =A0 =A0 reg_val |=3D val;
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, reg_val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_counter);
>>> +
>>> +out:
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 return count;
>>> +}
>>> +
>>> +static int omap_temp_sensor_read_temp(struct device *dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 struct device_attribute *devattr,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 char *buf)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp, ret=
 =3D 0;
>>> +
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_c=
trl);
>>> + =A0 =A0 =A0 temp &=3D temp_sensor->registers->bgap_dtemp_mask;
>>> +
>>> + =A0 =A0 =A0 if (!temp_sensor->is_efuse_valid)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid EFUSE, Non-trim=
med BGAP, Temp not accurate\n");
>>> +
>>> + =A0 =A0 =A0 /* look up for temperature in the table and return th=
e temperature */
>>> + =A0 =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_EN=
D_VALUE) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "invalid adc code report=
ed %d", temp);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp =3D adc_to_temp[temp - OMAP_ADC_START_VALUE];
>>> +
>>> +out:
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 if (!ret)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return sprintf(buf, "%d\n", temp);
>>> +
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, omap_temp_sensor_r=
ead_temp,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 NULL, 0);
>>> +static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO, show_temp_=
max,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max, 0);
>>> +static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IWUSR | S_IRUGO, show_=
temp_max_hyst,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_temp_max_hyst=
, 0);
>>> +static SENSOR_DEVICE_ATTR(update_rate, S_IWUSR | S_IRUGO, show_upd=
ate_rate,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_update_rate, =
0);
>>> +
>>> +static struct attribute *omap_temp_sensor_attributes[] =3D {
>>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_input.dev_attr.attr,
>>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max.dev_attr.attr,
>>> + =A0 =A0 =A0 &sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
>>> + =A0 =A0 =A0 &sensor_dev_attr_update_rate.dev_attr.attr,
>>> + =A0 =A0 =A0 NULL
>>> +};
>>> +
>>> +static const struct attribute_group omap_temp_sensor_group =3D {
>>> + =A0 =A0 =A0 .attrs =3D omap_temp_sensor_attributes,
>>> +};
>>> +
>>> +static int omap_temp_sensor_clk_enable(struct omap_temp_sensor *te=
mp_sensor)
>>> +{
>>> + =A0 =A0 =A0 u32 ret =3D 0;
>>> +
>>> + =A0 =A0 =A0 if (temp_sensor->clk_on) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "cloc=
k already on\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 ret =3D pm_runtime_get_sync(temp_sensor->hwmon_dev);
>>> + =A0 =A0 =A0 if (ret < 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "get =
sync failed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp_sensor->clk_on =3D 1;
>>> +
>>> +out:
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +static int omap_temp_sensor_clk_disable(struct omap_temp_sensor *t=
emp_sensor)
>>> +{
>>> + =A0 =A0 =A0 u32 ret =3D 0;
>>> +
>>> + =A0 =A0 =A0 if (!temp_sensor->clk_on) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "cloc=
k already off\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* Gate the clock */
>>> + =A0 =A0 =A0 ret =3D pm_runtime_put_sync(temp_sensor->hwmon_dev);
>>> + =A0 =A0 =A0 if (ret < 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev, "put =
sync failed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 temp_sensor->clk_on =3D 0;
>>> +
>>> +out:
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +static irqreturn_t omap_talert_irq_handler(int irq, void *data)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 t_hot, t_cold, temp;
>>> +
>>> + =A0 =A0 =A0 temp_sensor =3D data;
>>> + =A0 =A0 =A0 mutex_lock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 /* Read the status of t_hot */
>>> + =A0 =A0 =A0 t_hot =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_status)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->regist=
ers->status_hot_mask;
>>> +
>>> + =A0 =A0 =A0 /* Read the status of t_cold */
>>> + =A0 =A0 =A0 t_cold =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_status)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & temp_sensor->regist=
ers->status_cold_mask;
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources
>>> + =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then mask t_hot=
 and
>>> + =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold and unmask t_=
hot
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 if (t_hot) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(temp_sensor->registers->m=
ask_hot_mask);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mas=
k_cold_mask;
>>> + =A0 =A0 =A0 } else if (t_cold) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~(temp_sensor->registers->m=
ask_cold_mask);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D temp_sensor->registers->mas=
k_hot_mask;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, temp,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>>> +
>>> + =A0 =A0 =A0 /* kobject_uvent to user space telling thermal thresh=
old crossed */
>>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_CH=
ANGE);
>>> +
>>> + =A0 =A0 =A0 mutex_unlock(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 return IRQ_HANDLED;
>>> +}
>>> +
>>> +static int __devinit omap_temp_sensor_probe(struct platform_device=
 *pdev)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor_pdata =A0 *pdata =A0=3D pdev-=
>dev.platform_data;
>>> + =A0 =A0 =A0 struct omap_temp_sensor =A0 =A0 =A0 =A0 *temp_sensor;
>>> + =A0 =A0 =A0 struct resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mem;
>>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ret =3D 0;
>>> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 val, clk_rate;
>>> +
>>> + =A0 =A0 =A0 if (!pdata) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data mi=
ssing\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp_sensor =3D kzalloc(sizeof(*temp_sensor), GFP_KER=
NEL);
>>> + =A0 =A0 =A0 if (!temp_sensor)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>>> +
>>> + =A0 =A0 =A0 mutex_init(&temp_sensor->sensor_mutex);
>>> +
>>> + =A0 =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0=
);
>>> + =A0 =A0 =A0 if (!mem) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\=
n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp_sensor->irq =3D platform_get_irq_byname(pdev, "t=
hermal_alert");
>>> + =A0 =A0 =A0 if (temp_sensor->irq < 0) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname f=
ailed\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D temp_sensor->irq;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp_sensor->phy_base =3D ioremap(mem->start, resourc=
e_size(mem));
>>> + =A0 =A0 =A0 temp_sensor->clock =3D NULL;
>>> + =A0 =A0 =A0 temp_sensor->registers =3D pdata->registers;
>>> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D &pdev->dev;
>>> +
>>> + =A0 =A0 =A0 pm_runtime_enable(&pdev->dev);
>>> + =A0 =A0 =A0 pm_runtime_irq_safe(&pdev->dev);
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* check if the efuse has a non-zero value if not
>>> + =A0 =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>>> + =A0 =A0 =A0 =A0* may not be accurate
>>> + =A0 =A0 =A0 =A0*/
>>> +
>>> + =A0 =A0 =A0 if (omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->bgap_efuse))
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->is_efuse_valid =3D 1;
>>> +
>>> + =A0 =A0 =A0 platform_set_drvdata(pdev, temp_sensor);
>>> + =A0 =A0 =A0 dev_set_drvdata(&pdev->dev, temp_sensor);
>>> + =A0 =A0 =A0 temp_sensor->clock =3D clk_get(temp_sensor->hwmon_dev=
, "fck");
>>> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->clock)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->clock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(temp_sensor->hwmon_dev,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "unable to get fclk: =
%d\n", ret);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 ret =3D omap_temp_sensor_clk_enable(temp_sensor);
>>> + =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot enable te=
mp sensor\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 clk_rate =3D clk_round_rate(temp_sensor->clock, 20000=
00);
>>> + =A0 =A0 =A0 if (clk_rate < 1000000 || clk_rate =3D=3D 0xffffffff)=
 {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Error round rate=
\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 ret =3D clk_set_rate(temp_sensor->clock, clk_rate);
>>> + =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock=
 rate\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 temp_sensor->clk_rate =3D clk_rate;
>>> + =A0 =A0 =A0 omap_enable_continuous_mode(temp_sensor, 1);
>>> + =A0 =A0 =A0 omap_configure_temp_sensor_thresholds(temp_sensor);
>>> + =A0 =A0 =A0 /* 1 ms */
>>> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor, 1);
>>> +
>>> + =A0 =A0 =A0 /* Wait till the first conversion is done wait for at=
 least 1ms */
>>> + =A0 =A0 =A0 usleep_range(1000, 2000);
>>> +
>>> + =A0 =A0 =A0 /* Read the temperature once due to hw issue*/
>>> + =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->register=
s->temp_sensor_ctrl);
>>> +
>>> + =A0 =A0 =A0 /* Set 2 seconds time as default counter */
>>> + =A0 =A0 =A0 omap_configure_temp_sensor_counter(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->clk_rate * 2);
>>> +
>>> + =A0 =A0 =A0 temp_sensor->hwmon_dev =3D hwmon_device_register(&pde=
v->dev);
>>> + =A0 =A0 =A0 if (IS_ERR(temp_sensor->hwmon_dev)) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "hwmon_device_reg=
ister failed.\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(temp_sensor->hwmon_de=
v);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto hwmon_reg_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 ret =3D sysfs_create_group(&pdev->dev.kobj,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&o=
map_temp_sensor_group);
>>> + =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "could not create=
 sysfs files\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto sysfs_create_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_AD=
D);
>>> +
>>> + =A0 =A0 =A0 ret =3D request_threaded_irq(temp_sensor->irq, NULL,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_talert_irq_handler, IRQF_TRIGGER=
_RISING | IRQF_ONESHOT,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "temp_sensor", temp_s=
ensor);
>>> + =A0 =A0 =A0 if (ret) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded=
 irq failed.\n");
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>>> + =A0 =A0 =A0 }
>>> +
>>> + =A0 =A0 =A0 /* unmask the T_COLD and unmask T_HOT at init */
>>> + =A0 =A0 =A0 val =3D omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>>> + =A0 =A0 =A0 val |=3D temp_sensor->registers->mask_cold_mask
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 | temp_sensor->registers->mask_hot_ma=
sk;
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor, val,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +
>>> +req_irq_err:
>>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_RE=
MOVE);
>>> + =A0 =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap=
_temp_sensor_group);
>>> +sysfs_create_err:
>>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>>> +hwmon_reg_err:
>>> + =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>>> +clken_err:
>>> + =A0 =A0 =A0 clk_put(temp_sensor->clock);
>>> +plat_res_err:
>>> + =A0 =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 kfree(temp_sensor);
>>> + =A0 =A0 =A0 return ret;
>>> +}
>>> +
>>> +static int __devexit omap_temp_sensor_remove(struct platform_devic=
e *pdev)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D platform_get=
_drvdata(pdev);
>>> +
>>> + =A0 =A0 =A0 hwmon_device_unregister(&pdev->dev);
>>> + =A0 =A0 =A0 kobject_uevent(&temp_sensor->hwmon_dev->kobj, KOBJ_RE=
MOVE);
>>> + =A0 =A0 =A0 sysfs_remove_group(&temp_sensor->hwmon_dev->kobj,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap_temp_sensor_gro=
up);
>>> + =A0 =A0 =A0 omap_temp_sensor_clk_disable(temp_sensor);
>>> + =A0 =A0 =A0 clk_put(temp_sensor->clock);
>>> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
>>> + =A0 =A0 =A0 free_irq(temp_sensor->irq, temp_sensor);
>>> + =A0 =A0 =A0 mutex_destroy(&temp_sensor->sensor_mutex);
>>> + =A0 =A0 =A0 kfree(temp_sensor);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +#ifdef CONFIG_PM
>>> +static void omap_temp_sensor_save_ctxt(struct omap_temp_sensor *te=
mp_sensor)
>>> +{
>>> + =A0 =A0 =A0 temp_sensor->temp_sensor_ctrl =3D omap_temp_sensor_re=
adl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->temp_sensor_c=
trl);
>>> + =A0 =A0 =A0 temp_sensor->bg_ctrl =3D omap_temp_sensor_readl(temp_=
sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_mask_ctr=
l);
>>> + =A0 =A0 =A0 temp_sensor->bg_counter =3D omap_temp_sensor_readl(te=
mp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_counter)=
;
>>> + =A0 =A0 =A0 temp_sensor->bg_threshold =3D omap_temp_sensor_readl(=
temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->bgap_threshol=
d);
>>> + =A0 =A0 =A0 temp_sensor->temp_sensor_tshut_threshold =3D
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_readl(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor->registers->thsut_thresho=
ld);
>>> +}
>>> +
>>> +static void omap_temp_sensor_restore_ctxt(struct omap_temp_sensor =
*temp_sensor)
>>> +{
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->temp_sensor_ctrl,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->temp_sensor_ctrl);
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->bg_ctrl,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_mask_ctrl);
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->bg_counter,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_counter);
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->bg_threshold,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->bgap_threshold);
>>> + =A0 =A0 =A0 omap_temp_sensor_writel(temp_sensor,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->temp_sensor_tshut_threshold,
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_=
sensor->registers->thsut_threshold);
>>> +}
>>> +
>>> +static int omap_temp_sensor_suspend(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static int omap_temp_sensor_resume(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_sensor);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static int omap_temp_sensor_runtime_suspend(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> +
>>> + =A0 =A0 =A0 omap_temp_sensor_save_ctxt(temp_sensor);
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static int omap_temp_sensor_runtime_resume(struct device *dev)
>>> +{
>>> + =A0 =A0 =A0 static int context_loss_count;
>>> + =A0 =A0 =A0 int temp;
>>> + =A0 =A0 =A0 struct omap_temp_sensor *temp_sensor =3D dev_get_drvd=
ata(dev);
>>> +
>>> + =A0 =A0 =A0 temp =3D omap_device_get_context_loss_count(to_platfo=
rm_device(dev));
>>> +
>>> + =A0 =A0 =A0 if (temp !=3D context_loss_count && context_loss_coun=
t !=3D 0)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_restore_ctxt(temp_se=
nsor);
>>> +
>>> + =A0 =A0 =A0 context_loss_count =3D temp;
>>> +
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops omap_temp_sensor_dev_pm_ops =3D {
>>> + =A0 =A0 =A0 .suspend =3D omap_temp_sensor_suspend,
>>> + =A0 =A0 =A0 .resume =3D omap_temp_sensor_resume,
>>> + =A0 =A0 =A0 .runtime_suspend =3D omap_temp_sensor_runtime_suspend=
,
>>> + =A0 =A0 =A0 .runtime_resume =3D omap_temp_sensor_runtime_resume,
>>> +};
>>> +
>>> +#endif
>>> +
>>> +static struct platform_driver omap_temp_sensor_driver =3D {
>>> + =A0 =A0 =A0 .probe =3D omap_temp_sensor_probe,
>>> + =A0 =A0 =A0 .remove =3D omap_temp_sensor_remove,
>>> + =A0 =A0 =A0 .driver =3D {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "omap_temp_=
sensor",
>>> +#ifdef CONFIG_PM
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pm =3D &omap_temp_se=
nsor_dev_pm_ops,
>>> +#endif
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>>> +};
>>> +
>>> +int __init omap_temp_sensor_init(void)
>>> +{
>>> + =A0 =A0 =A0 return platform_driver_register(&omap_temp_sensor_dri=
ver);
>>> +}
>>> +module_init(omap_temp_sensor_init);
>>> +
>>> +static void __exit omap_temp_sensor_exit(void)
>>> +{
>>> + =A0 =A0 =A0 platform_driver_unregister(&omap_temp_sensor_driver);
>>> +}
>>> +module_exit(omap_temp_sensor_exit);
>>> +
>>> +MODULE_DESCRIPTION("OMAP446X temperature sensor Driver");
>>> +MODULE_LICENSE("GPL");
>>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
>>> --
>>> 1.7.0.4
>>>
>>
>
>
>
> --
> Regards and Thanks,
> Keerthy
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
