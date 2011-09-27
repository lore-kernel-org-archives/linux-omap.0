From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH] mfd: OMAP4460+: System control module driver
Date: Tue, 27 Sep 2011 11:10:18 +0530
Message-ID: <CAJ6a13ZrOSOqAOqbadT6ZE6NRWzfxD+f6mzUDfKR6fP53zW4+Q@mail.gmail.com>
References: <1316710311-14075-1-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1109230016190.10719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:46290 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752790Ab1I0FkU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 01:40:20 -0400
Received: by mail-wy0-f181.google.com with SMTP id 19so7494963wyf.26
        for <linux-omap@vger.kernel.org>; Mon, 26 Sep 2011 22:40:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1109230016190.10719@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org

On Fri, Sep 23, 2011 at 12:20 PM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi
>
> some comments:
>
> On Thu, 22 Sep 2011, Keerthy wrote:
>
>> The system control module has several components. On die temperature=
 is a part
>> of system control module. The system control module driver registers=
 the
>> temperature sensor as a client. A hwmon driver for temperature senso=
r to
>> route the temperature and the thresholds to the user space.
>>
>> The system control module driver patch depends on the following seri=
es
>> found here: http://comments.gmane.org/gmane.linux.ports.arm.omap/644=
36
>>
>>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> Cc:sameo@linux.intel.com
>
> This should also be sent to the linux-arm-kernel@lists.infradead.org =
and
> linux-kernel@vger.kernel.org lists as well as the linux-omap list.
>

Ok

>> ---
>> =A0drivers/mfd/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A09 +
>> =A0drivers/mfd/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A02 +-
>> =A0drivers/mfd/omap4460plus_scm.c | =A0581 +++++++++++++++++++++++++=
+++++++++++++++
>> =A03 files changed, 591 insertions(+), 1 deletions(-)
>> =A0create mode 100644 drivers/mfd/omap4460plus_scm.c
>>
>> Index: linux-omap-2.6/drivers/mfd/Kconfig
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-2.6.orig/drivers/mfd/Kconfig =A0 2011-09-22 18:35:25.=
636575640 +0530
>> +++ linux-omap-2.6/drivers/mfd/Kconfig =A0 =A0 =A0 =A02011-09-22 18:=
35:43.412576517 +0530
>> @@ -212,6 +212,15 @@
>> =A0 =A0 =A0 =A0 and other features that are often used in portable d=
evices like
>> =A0 =A0 =A0 =A0 cell phones and PDAs.
>>
>> +config OMAP4460PLUS_SCM
>> + =A0 =A0 bool "Texas Instruments OMAP4460 System control module"
>> + =A0 =A0 depends on ARCH_OMAP && OMAP_SCM_DEV
>> + =A0 =A0 help
>> + =A0 =A0 =A0 If you say yes here you get support for the Texas Inst=
ruments
>> + =A0 =A0 =A0 OMAP4460 system control module. This includes support =
for
>> + =A0 =A0 =A0 on die temperature sensor which is a part of System co=
ntrol
>> + =A0 =A0 =A0 module.
>> +
>
> It seems to me that this driver should work for the OMAP4430 as well.=
 =A0Is
> there a reason why this is marked as OMAP4460 all over?

Ok. The system control module should work for OMAP4430 as well.
The temperature sensor is different for OMAP4430 and OMAP4460.
The register layout and functionality and even the programming model
is different. So i plan to keep the SCM driver common and make
temperature sensor driver OMAP4460PLUS. Is this approach fine?
Please let me know about your thoughts on this.

>
>> =A0config TWL4030_CORE
>> =A0 =A0 =A0 bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0=
 Support"
>> =A0 =A0 =A0 depends on I2C=3Dy && GENERIC_HARDIRQS
>> Index: linux-omap-2.6/drivers/mfd/Makefile
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-omap-2.6.orig/drivers/mfd/Makefile =A02011-09-22 18:35:25.=
604576115 +0530
>> +++ linux-omap-2.6/drivers/mfd/Makefile =A0 =A0 =A0 2011-09-22 18:35=
:43.416576975 +0530
>> @@ -42,7 +42,7 @@
>> =A0obj-$(CONFIG_MFD_TPS65912_I2C) =A0 =A0 =A0 +=3D tps65912-i2c.o
>> =A0obj-$(CONFIG_MFD_TPS65912_SPI) =A0+=3D tps65912-spi.o
>> =A0obj-$(CONFIG_MENELAUS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D menelaus.=
o
>> -
>> +obj-$(CONFIG_OMAP4460PLUS_SCM) =A0 =A0 =A0 +=3D omap4460plus_scm.o
>> =A0obj-$(CONFIG_TWL4030_CORE) =A0 +=3D twl-core.o twl4030-irq.o twl6=
030-irq.o
>> =A0obj-$(CONFIG_TWL4030_MADC) =A0 =A0 =A0+=3D twl4030-madc.o
>> =A0obj-$(CONFIG_TWL4030_POWER) =A0 =A0+=3D twl4030-power.o
>> Index: linux-omap-2.6/drivers/mfd/omap4460plus_scm.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- /dev/null 1970-01-01 00:00:00.000000000 +0000
>> +++ linux-omap-2.6/drivers/mfd/omap4460plus_scm.c =A0 =A0 2011-09-22=
 18:53:05.132583900 +0530
>
> Please split this file into at least two files, as is the standard
> practice for MFD drivers. =A0There should be one omap4-scm-core.c fil=
e, and
> one omap4-scm-tempsensor.c file. =A0Everything temperature sensor-spe=
cific
> should go into the omap4-scm-tempsensor.c file.

Ok. I will have two files one as core and one for temperature sensor.

>
>> @@ -0,0 +1,581 @@
>> +/*
>> + * OMAP4 system control module driver file
>> + *
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.t=
i.com/
>> + * Author: J Keerthy <j-keerthy@ti.com>
>> + * Author: Moiz Sonasath <m-sonasath@ti.com>
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
>> +#include <linux/interrupt.h>
>> +#include <linux/clk.h>
>> +#include <linux/io.h>
>> +#include <linux/slab.h>
>> +#include <linux/platform_device.h>
>> +#include <plat/omap_device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/err.h>
>> +#include <linux/types.h>
>> +#include <linux/mutex.h>
>> +#include <linux/delay.h>
>> +#include <plat/scm.h>
>> +
>> +#define TSHUT_HOT =A0 =A0 =A0 =A0 =A0 =A0920 =A0 =A0 /* 122 deg C *=
/
>> +#define TSHUT_COLD =A0 =A0 =A0 =A0 =A0 866 =A0 =A0 /* 100 deg C */
>> +#define T_HOT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0800 =A0=
 =A0 /* 73 deg C */
>> +#define T_COLD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 795 =A0 =
=A0 /* 71 deg C */
>> +#define MAX_FREQ =A0 =A0 =A0 =A0 =A0 =A0 2000000
>> +#define MIN_FREQ =A0 =A0 =A0 =A0 =A0 =A0 1000000
>> +#define MIN_TEMP =A0 =A0 =A0 =A0 =A0 =A0 -40000
>> +#define MAX_TEMP =A0 =A0 =A0 =A0 =A0 =A0 123000
>> +#define HYST_VAL =A0 =A0 =A0 =A0 =A0 =A0 5000
>
> Are any of these definitions specific to one chip? =A0Or do they appl=
y to
> all OMAP4 chips?

All of these are specific to OMAP4460. Can i pass them as part of
pdata since they are
platform specific?

>
>> +
>> +static u32 omap4460plus_scm_readl(struct scm
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *scm_ptr, u32 reg)
>> +{
>> + =A0 =A0 return __raw_readl(scm_ptr->phy_base + reg);
>> +}
>> +
>> +static void omap4460plus_scm_writel(struct scm *scm_ptr, u32 val, u=
32 reg)
>> +{
>> + =A0 =A0 __raw_writel(val, scm_ptr->phy_base + reg);
>> +}
>> +
>> +static int adc_to_temp_conversion(int adc_val)
>> +{
>> + =A0 =A0 return adc_to_temp[adc_val - OMAP_ADC_START_VALUE];
>> +}
>> +
>> +static int temp_to_adc_conversion(long temp)
>> +{
>> + =A0 =A0 int high, low, mid;
>> +
>> + =A0 =A0 if (temp < adc_to_temp[0] ||
>> + =A0 =A0 =A0 =A0 temp > adc_to_temp[OMAP_ADC_END_VALUE - OMAP_ADC_S=
TART_VALUE])
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> +
>> + =A0 =A0 high =3D OMAP_ADC_END_VALUE - OMAP_ADC_START_VALUE;
>> + =A0 =A0 low =3D 0;
>> + =A0 =A0 mid =3D (high + low) / 2;
>> +
>> + =A0 =A0 while (low < high) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (temp < adc_to_temp[mid])
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 high =3D mid - 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 low =3D mid + 1;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mid =3D (low + high) / 2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return OMAP_ADC_START_VALUE + low;
>> +}
>> +
>> +static void temp_sensor_unmask_interrupts(struct scm *scm_ptr, int =
id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 t_hot, u32 t_cold)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 u32 temp, reg_val;
>> +
>> + =A0 =A0 /* Read the current on die temperature */
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> + =A0 =A0 temp =3D omap4460plus_scm_readl(scm_ptr, tsr->temp_sensor_=
ctrl);
>> + =A0 =A0 temp &=3D tsr->bgap_dtemp_mask;
>> +
>> + =A0 =A0 reg_val =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_mask=
_ctrl);
>> + =A0 =A0 if (temp < t_hot)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D tsr->mask_hot_mask;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~tsr->mask_hot_mask;
>> +
>> + =A0 =A0 if (t_cold < temp)
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D tsr->mask_cold_mask;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val &=3D ~tsr->mask_cold_mask;
>> +
>> + =A0 =A0 omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_mask_c=
trl);
>> +}
>> +
>> +static int add_hyst(int adc_val, int hyst_val)
>> +{
>> + =A0 =A0 int temp =3D adc_to_temp_conversion(adc_val);
>> +
>> + =A0 =A0 temp +=3D hyst_val;
>> +
>> + =A0 =A0 return temp_to_adc_conversion(temp);
>> +}
>> +
>> +static void temp_sensor_configure_thot(struct scm *scm_ptr, int id,=
 int t_hot)
>> +{
>> + =A0 =A0 int cold, thresh_val;
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 u32 reg_val;
>> +
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> + =A0 =A0 /* obtain the T cold value */
>> + =A0 =A0 thresh_val =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_t=
hreshold);
>> + =A0 =A0 cold =3D (thresh_val & tsr->threshold_tcold_mask) >>
>> + =A0 =A0 =A0 =A0 __ffs(tsr->threshold_tcold_mask);
>> +
>> + =A0 =A0 if (t_hot <=3D cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change the t_cold to t_hot - 5000 milli=
degrees */
>> + =A0 =A0 =A0 =A0 =A0 =A0 cold =3D add_hyst(t_hot, -HYST_VAL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_cold value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D thresh_val & (~tsr->threshold_=
tcold_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D cold << __ffs(tsr->threshold_=
tcold_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4460plus_scm_writel(scm_ptr, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tsr->bgap_threshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 thresh_val =3D reg_val;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 reg_val =3D thresh_val & ~tsr->threshold_thot_mask;
>> + =A0 =A0 reg_val |=3D (t_hot << __ffs(tsr->threshold_thot_mask));
>> + =A0 =A0 omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_thresh=
old);
>> + =A0 =A0 temp_sensor_unmask_interrupts(scm_ptr, id, t_hot, cold);
>> +}
>> +
>> +static void temp_sensor_configure_tcold(struct scm *scm_ptr, int id=
, int t_cold)
>> +{
>> + =A0 =A0 int hot, thresh_val;
>> + =A0 =A0 u32 reg_val;
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> +
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> + =A0 =A0 /* obtain the T cold value */
>> + =A0 =A0 thresh_val =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_t=
hreshold);
>> + =A0 =A0 hot =3D (thresh_val & tsr->threshold_thot_mask) >>
>> + =A0 =A0 =A0 =A0 __ffs(tsr->threshold_thot_mask);
>> +
>> + =A0 =A0 if (t_cold >=3D hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* change the t_hot to t_cold + 5000 milli=
degrees */
>> + =A0 =A0 =A0 =A0 =A0 =A0 hot =3D add_hyst(t_cold, HYST_VAL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* write the new t_hot value */
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val =3D thresh_val & (~tsr->threshold_=
thot_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 reg_val |=3D hot << __ffs(tsr->threshold_t=
hot_mask);
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4460plus_scm_writel(scm_ptr, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tsr->bgap_threshold);
>> + =A0 =A0 =A0 =A0 =A0 =A0 thresh_val =3D reg_val;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* write the new t_cold value */
>> + =A0 =A0 reg_val =3D thresh_val & ~tsr->threshold_tcold_mask;
>> + =A0 =A0 reg_val |=3D (t_cold << __ffs(tsr->threshold_tcold_mask));
>> + =A0 =A0 omap4460plus_scm_writel(scm_ptr, reg_val, tsr->bgap_thresh=
old);
>> + =A0 =A0 temp_sensor_unmask_interrupts(scm_ptr, id, hot, t_cold);
>> +}
>> +
>> +static void configure_temp_sensor_counter(struct scm *scm_ptr, int =
id,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 counter)
>> +{
>> + =A0 =A0 u32 val;
>> +
>> + =A0 =A0 val =3D omap4460plus_scm_readl(scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
scm_ptr->registers[id]->bgap_counter);
>> + =A0 =A0 val &=3D ~scm_ptr->registers[id]->counter_mask;
>> + =A0 =A0 val |=3D counter << __ffs(scm_ptr->registers[id]->counter_=
mask);
>> + =A0 =A0 omap4460plus_scm_writel(scm_ptr, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scm_ptr->r=
egisters[id]->bgap_counter);
>> +
>> +}
>> +
>> +int omap4460plus_scm_show_temp_max(struct scm *scm_ptr, int id)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> + =A0 =A0 temp =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_thresho=
ld);
>> + =A0 =A0 temp =3D (temp & tsr->threshold_thot_mask)
>> + =A0 =A0 =A0 =A0 >> __ffs(tsr->threshold_thot_mask);
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 return temp;
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_show_temp_max);
>> +
>> +int omap4460plus_scm_set_temp_max(struct scm *scm_ptr, int id, int =
val)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 u32 t_hot;
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> +
>> + =A0 =A0 if (val < MIN_TEMP - HYST_VAL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 t_hot =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if (t_hot < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return t_hot;
>> +
>> + =A0 =A0 mutex_lock(&scm_ptr->scm_mutex);
>> + =A0 =A0 temp_sensor_configure_thot(scm_ptr, id, t_hot);
>> + =A0 =A0 mutex_unlock(&scm_ptr->scm_mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_set_temp_max);
>> +
>> +int omap4460plus_scm_show_temp_max_hyst(struct scm *scm_ptr, int id=
)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 int temp;
>> +
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> + =A0 =A0 temp =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_thresho=
ld);
>> + =A0 =A0 temp =3D (temp & tsr->threshold_tcold_mask)
>> + =A0 =A0 =A0 =A0 >> __ffs(tsr->threshold_tcold_mask);
>> + =A0 =A0 temp =3D adc_to_temp_conversion(temp);
>> +
>> + =A0 =A0 return temp;
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_show_temp_max_hyst);
>> +
>> +int omap4460plus_scm_set_temp_max_hyst(struct scm *scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0int id, int val)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 u32 t_cold;
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> +
>> + =A0 =A0 if (val < MIN_TEMP + HYST_VAL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 t_cold =3D temp_to_adc_conversion(val);
>> + =A0 =A0 if (t_cold < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return t_cold;
>> +
>> + =A0 =A0 mutex_lock(&scm_ptr->scm_mutex);
>> + =A0 =A0 temp_sensor_configure_tcold(scm_ptr, id, t_cold);
>> + =A0 =A0 mutex_unlock(&scm_ptr->scm_mutex);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_set_temp_max_hyst);
>> +
>> +void omap4460plus_scm_set_update_interval(struct scm *scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u32 interval, int id)
>> +{
>> + =A0 =A0 interval =3D interval * scm_ptr->clk_rate / 1000;
>> + =A0 =A0 mutex_lock(&scm_ptr->scm_mutex);
>> + =A0 =A0 configure_temp_sensor_counter(scm_ptr, id, interval);
>> + =A0 =A0 mutex_unlock(&scm_ptr->scm_mutex);
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_set_update_interval);
>> +
>> +int omap4460plus_scm_show_update_interval(struct scm *scm_ptr, int =
id)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 int time;
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> +
>> + =A0 =A0 time =3D omap4460plus_scm_readl(scm_ptr, tsr->bgap_counter=
);
>> + =A0 =A0 time =3D (time & tsr->counter_mask) >> __ffs(tsr->counter_=
mask);
>> + =A0 =A0 time =3D time * 1000 / scm_ptr->clk_rate;
>> +
>> + =A0 =A0 return time;
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_show_update_interval);
>> +
>> +int omap4460plus_scm_read_temp(struct scm *scm_ptr, int id)
>> +{
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> + =A0 =A0 int temp;
>> + =A0 =A0 tsr =3D scm_ptr->registers[id];
>> +
>> + =A0 =A0 temp =3D omap4460plus_scm_readl(scm_ptr, tsr->temp_sensor_=
ctrl);
>> + =A0 =A0 temp &=3D tsr->bgap_dtemp_mask;
>> +
>> + =A0 =A0 /* look up for temperature in the table and return the tem=
perature */
>> + =A0 =A0 if (temp < OMAP_ADC_START_VALUE || temp > OMAP_ADC_END_VAL=
UE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EIO;
>> +
>> + =A0 =A0 return adc_to_temp_conversion(temp);
>> +}
>> +EXPORT_SYMBOL(omap4460plus_scm_read_temp);
>> +
>> +/**
>> + * enable_continuous_mode() - One time enbaling of continuous conve=
rsion mode
>> + * @scm_ptr - pointer to scm instance
>> + */
>> +static void enable_continuous_mode(struct scm *scm_ptr)
>> +{
>> + =A0 =A0 u32 val;
>> + =A0 =A0 int i;
>> +
>> + =A0 =A0 for (i =3D 0; i < scm_ptr->cnt; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap4460plus_scm_readl(scm_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0scm_ptr->registers[i]->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0bgap_mode_ctrl);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 val |=3D 1 << __ffs(scm_ptr->registers[i]-=
>mode_ctrl_mask);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4460plus_scm_writel(scm_ptr, val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 scm_ptr->registers[i]->bgap_mode_ctrl);
>> + =A0 =A0 }
>> +}
>> +
>> +static irqreturn_t talert_irq_handler(int irq, void *data)
>> +{
>> + =A0 =A0 struct scm *scm_ptr;
>> + =A0 =A0 int t_hot =3D 0, t_cold, temp, i;
>> + =A0 =A0 struct omap_temp_sensor_registers *tsr;
>> +
>> + =A0 =A0 scm_ptr =3D data;
>> + =A0 =A0 mutex_lock(&scm_ptr->scm_mutex);
>> + =A0 =A0 /* Read the status of t_hot */
>> + =A0 =A0 for (i =3D 0; i < scm_ptr->cnt; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 tsr =3D scm_ptr->registers[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 t_hot =3D omap4460plus_scm_readl(scm_ptr, =
tsr->bgap_status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & tsr->status_hot_mask;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Read the status of t_cold */
>> + =A0 =A0 =A0 =A0 =A0 =A0 t_cold =3D omap4460plus_scm_readl(scm_ptr,=
 tsr->bgap_status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & tsr->status_cold_mask;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp =3D omap4460plus_scm_readl(scm_ptr, t=
sr->bgap_mask_ctrl);
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* One TALERT interrupt: Two sources
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* If the interrupt is due to t_hot then=
 mask t_hot and
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* and unmask t_cold else mask t_cold an=
d unmask t_hot
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t_hot) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~tsr->mask_hot_m=
ask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D tsr->mask_cold_m=
ask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (t_cold) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp &=3D ~tsr->mask_cold_=
mask;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp |=3D tsr->mask_hot_ma=
sk;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4460plus_scm_writel(scm_ptr, temp, tsr=
->bgap_mask_ctrl);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (t_hot || t_cold)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* kobject_uvent to user s=
pace threshold crossed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobject_uevent(&scm_ptr->t=
sh_ptr[i].pdev->dev.kobj,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0KOBJ_CHANGE);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_unlock(&scm_ptr->scm_mutex);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +void omap4460plus_scm_client_dev_register(struct temp_sensor_hwmon =
*tsh_ptr,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 int i, const char *name)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 tsh_ptr->pdev =3D platform_device_alloc(name, i);
>> + =A0 =A0 if (tsh_ptr->pdev =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(tsh_ptr->scm_ptr->dev, "Failed to =
allocate %s\n", name);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 tsh_ptr->pdev->dev.parent =3D tsh_ptr->scm_ptr->dev;
>> + =A0 =A0 platform_set_drvdata(tsh_ptr->pdev, tsh_ptr);
>> + =A0 =A0 ret =3D platform_device_add(tsh_ptr->pdev);
>> + =A0 =A0 if (ret !=3D 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(tsh_ptr->scm_ptr->dev, "Failed to =
register %s: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 name, ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 platform_device_put(tsh_ptr->pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 tsh_ptr->pdev =3D NULL;
>> + =A0 =A0 }
>> +}
>> +
>> +static int __devinit omap4460plus_scm_probe(struct platform_device =
*pdev)
>> +{
>> + =A0 =A0 struct omap4460plus_scm_pdata *pdata =3D pdev->dev.platfor=
m_data;
>> + =A0 =A0 struct scm *scm_ptr;
>> + =A0 =A0 struct resource *mem;
>> + =A0 =A0 int ret =3D 0, i;
>> + =A0 =A0 int clk_rate;
>> + =A0 =A0 u32 max_freq, min_freq;
>> +
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "platform data missing=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr =3D kzalloc(sizeof(*scm_ptr), GFP_KERNEL);
>> + =A0 =A0 if (!scm_ptr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory allocation fai=
led\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr->tsh_ptr =3D kzalloc(sizeof(*scm_ptr->tsh_ptr) * p=
data->cnt,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 GFP_KERNEL);
>> + =A0 =A0 if (!scm_ptr) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory allocation fai=
led for tsh\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(scm_ptr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_init(&scm_ptr->scm_mutex);
>> + =A0 =A0 mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!mem) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "no mem resource\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr->irq =3D platform_get_irq_byname(pdev, "thermal_al=
ert");
>> + =A0 =A0 if (scm_ptr->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "get_irq_byname failed=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D scm_ptr->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr->phy_base =3D ioremap(mem->start, resource_size(me=
m));
>
> Isn't this a virtual address?

Yes. I will change the field name.

>
>> + =A0 =A0 if (!scm_ptr->phy_base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr->registers =3D pdata->registers;
>> + =A0 =A0 scm_ptr->name =3D pdata->name;
>> + =A0 =A0 scm_ptr->dev =3D &pdev->dev;
>> + =A0 =A0 scm_ptr->cnt =3D pdata->cnt;
>> +
>> + =A0 =A0 if (pdata->max_freq && pdata->min_freq) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D pdata->max_freq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D pdata->min_freq;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 max_freq =3D MAX_FREQ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 min_freq =3D MIN_FREQ;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* check if the efuse has a non-zero value if not
>> + =A0 =A0 =A0* it is an untrimmed sample and the temperatures
>> + =A0 =A0 =A0* may not be accurate
>> + =A0 =A0 =A0*/
>> + =A0 =A0 if (omap4460plus_scm_readl(scm_ptr, scm_ptr->registers[0]-=
>bgap_efuse))
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Invalid EFUSE, Non-tri=
mmed BGAP, Temp not accurate\n");
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, scm_ptr);
>> + =A0 =A0 scm_ptr->fclock =3D clk_get(&pdev->dev, "fck");
>> + =A0 =A0 scm_ptr->div_clk =3D clk_get(&pdev->dev, "div_ck");
>> + =A0 =A0 clk_enable(scm_ptr->fclock);
>> +
>> + =A0 =A0 clk_rate =3D clk_round_rate(scm_ptr->div_clk, max_freq);
>> + =A0 =A0 if (clk_rate < min_freq || clk_rate =3D=3D 0xffffffff) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D clk_set_rate(scm_ptr->div_clk, clk_rate);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot set clock rate=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto clken_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 scm_ptr->clk_rate =3D clk_rate;
>> +
>> + =A0 =A0 enable_continuous_mode(scm_ptr);
>> + =A0 =A0 /* 1 clk cycle */
>> + =A0 =A0 for (i =3D 0; i < pdata->cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 configure_temp_sensor_counter(scm_ptr, i, =
1);
>> +
>> + =A0 =A0 /* Wait till the first conversion is done wait for at leas=
t 1ms */
>> + =A0 =A0 usleep_range(1000, 2000);
>
> Please use macros for these constants. =A0Maybe add some comments why=
 the
> upper range should be bounded at 2000 microseconds? =A0If there's no =
obvious
> rationale, it might be best to increase this to something much higher=
?

Ok i will use macros. I will add comments. This is suggested by the
architecture team.

>
>> +
>> + =A0 =A0 /* Set 2 seconds time as default counter */
>> + =A0 =A0 for (i =3D 0; i < pdata->cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 configure_temp_sensor_counter(scm_ptr, i,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 scm_ptr->clk_rate * 2);
>
> This should be a macro. =A0Also maybe a quick comment on why it is 2
> seconds?

Ok i will convert it to a macro. I will add comments.

>
> Also I'd suggest dropping in a brief comment here about other SCM
> subdevices, to help the MFD maintainer out understand why this is an =
MFD
> device. =A0For example, child drivers should eventually be added for =
eFuses
> and debobs/hwobs.

Ok. I will add comments.

>
>
>> + =A0 =A0 for (i =3D 0; i < pdata->cnt; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 scm_ptr->tsh_ptr[i].scm_ptr =3D scm_ptr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scm_ptr->tsh_ptr[i].name =3D scm_ptr->name=
[i];
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap4460plus_scm_client_dev_register(&(scm=
_ptr->tsh_ptr[i]),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0i, "temp_sensor_hwmon");
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_configure_thot(scm_ptr, i, T_H=
OT);
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_configure_tcold(scm_ptr, i, T_=
COLD);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D request_threaded_irq(scm_ptr->irq, NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tal=
ert_irq_handler,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQ=
=46_TRIGGER_RISING | IRQF_ONESHOT, "TAlert",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0scm=
_ptr);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Request threaded irq =
failed.\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto req_irq_err;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 mutex_lock(&scm_ptr->scm_mutex);
>> +
>> + =A0 =A0 for (i =3D 0; i < pdata->cnt; i++)
>> + =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_unmask_interrupts(scm_ptr, i, =
OMAP_ADC_END_VALUE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP_ADC_START_VALUE);
>> +
>> + =A0 =A0 mutex_unlock(&scm_ptr->scm_mutex);
>> +
>> + =A0 =A0 return 0;
>> +
>> +req_irq_err:
>> + =A0 =A0 clk_disable(scm_ptr->fclock);
>> +clken_err:
>> + =A0 =A0 clk_put(scm_ptr->fclock);
>> + =A0 =A0 clk_put(scm_ptr->div_clk);
>> + =A0 =A0 iounmap(scm_ptr->phy_base);
>> +plat_res_err:
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 mutex_destroy(&scm_ptr->scm_mutex);
>> + =A0 =A0 kfree(scm_ptr->tsh_ptr);
>> + =A0 =A0 kfree(scm_ptr);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit omap4460plus_scm_remove(struct platform_device=
 *pdev)
>> +{
>> + =A0 =A0 struct scm *scm_ptr =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 free_irq(scm_ptr->irq, scm_ptr);
>> + =A0 =A0 clk_disable(scm_ptr->fclock);
>> + =A0 =A0 clk_put(scm_ptr->fclock);
>> + =A0 =A0 clk_put(scm_ptr->div_clk);
>> + =A0 =A0 iounmap(scm_ptr->phy_base);
>> + =A0 =A0 dev_set_drvdata(&pdev->dev, NULL);
>> + =A0 =A0 mutex_destroy(&scm_ptr->scm_mutex);
>> + =A0 =A0 kfree(scm_ptr);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver omap4460plus_scm_driver =3D {
>> + =A0 =A0 .probe =3D omap4460plus_scm_probe,
>> + =A0 =A0 .remove =3D omap4460plus_scm_remove,
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "omap4460plus_scm",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
>> +};
>> +
>> +int __init omap4460plus_scm_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&omap4460plus_scm_driver);
>> +}
>> +
>> +module_init(omap4460plus_scm_init);
>> +
>> +static void __exit omap4460plus_scm_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&omap4460plus_scm_driver);
>> +}
>> +
>> +module_exit(omap4460plus_scm_exit);
>> +
>> +MODULE_DESCRIPTION("OMAP446X plus system control module Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("platform:" DRIVER_NAME);
>> +MODULE_AUTHOR("J Keerthy <j-keerthy@ti.com>");
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
