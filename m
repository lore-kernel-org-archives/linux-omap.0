From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 5/6 V4] OMAP4: Temperature sensor device support
Date: Fri, 9 Sep 2011 11:28:34 +0200
Message-ID: <CAORVsuUM-mHBosmdpLdy=4Y17Kb76W=HCxP5ZEgSqm6qo3+Uug@mail.gmail.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-6-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51195 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757899Ab1IIJ2f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 05:28:35 -0400
Received: by vxi9 with SMTP id 9so937548vxi.19
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 02:28:35 -0700 (PDT)
In-Reply-To: <1314811510-15595-6-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

Hi Keerthy,

On Wed, Aug 31, 2011 at 7:25 PM, Keerthy <j-keerthy@ti.com> wrote:
> The device file adds the device support for OMAP4
> on die temperature sensor.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: tony@atomide.com
> ---
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0arch/arm/mach-omap2/temp_sensor_device.c | =A0188 ++++++++++++++++=
++++++++++++++
> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 ++
> =A03 files changed, 201 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index 2d5d981..5812fb4 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_OMAP4) +=3D prm44xx.o $(hwmod-com=
mon)
>
> =A0obj-$(CONFIG_OMAP_MCBSP) +=3D mcbsp.o
>
> +obj-$(CONFIG_OMAP_TEMP_SENSOR) =A0 =A0 =A0 =A0 =A0+=3D temp_sensor_d=
evice.o
> =A0obj-$(CONFIG_TWL4030_CORE) +=3D omap_twl.o
>
> =A0# SMP support ONLY available for OMAP4
> diff --git a/arch/arm/mach-omap2/temp_sensor_device.c b/arch/arm/mach=
-omap2/temp_sensor_device.c
> new file mode 100644
> index 0000000..12d6789
> --- /dev/null
> +++ b/arch/arm/mach-omap2/temp_sensor_device.c
> @@ -0,0 +1,188 @@
> +/*
> + * OMAP on die Temperature sensor device file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + * Author: J Keerthy <j-keerthy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the G=
NU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/mutex.h>
> +#include <linux/idr.h>
> +#include <plat/omap_device.h>
> +#include "pm.h"
> +#include <plat/temperature_sensor.h>
> +
> +
> +int omap_temp_sensor_device_idle(struct omap_device *od)
> +{
> + =A0 =A0 =A0 struct =A0omap_temp_sensor_registers =A0 =A0 =A0*regist=
ers;
> + =A0 =A0 =A0 struct =A0resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*mem;
> + =A0 =A0 =A0 void =A0 =A0__iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *phy_base;
> + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 timeout;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ret =3D 0, temp;
> +
> + =A0 =A0 =A0 mem =3D platform_get_resource(&od->pdev, IORESOURCE_MEM=
, 0);
> + =A0 =A0 =A0 if (!mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev, "no mem resource=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 phy_base =3D ioremap(mem->start, resource_size(mem));
> +
> + =A0 =A0 =A0 if (!phy_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev, "ioremap failed\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 registers =3D &omap_mpu_temp_sensor_reg=
isters;
> +
> + =A0 =A0 =A0 temp =3D __raw_readl(phy_base + registers->temp_sensor_=
ctrl);
> + =A0 =A0 =A0 temp |=3D registers->bgap_tempsoff_mask;
> +
> + =A0 =A0 =A0 /* BGAP_TEMPSOFF should be set to 1 before gating clock=
 */
> + =A0 =A0 =A0 __raw_writel(temp, phy_base + registers->temp_sensor_ct=
rl);
> + =A0 =A0 =A0 temp =3D __raw_readl(phy_base + registers->bgap_status)=
;
> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(5);
> +
> + =A0 =A0 =A0 /* wait till the clean stop bit is set or till the time=
out expires */
> + =A0 =A0 =A0 while (!(temp | registers->status_clean_stop_mask) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(time_after(jiffies, t=
imeout))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp =3D __raw_readl(phy_base + registe=
rs->bgap_status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 usleep_range(500, 2000);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (time_after(jiffies, timeout))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev, "Clean stop bit =
not set\n");
> +
> + =A0 =A0 =A0 ret =3D omap_device_idle_hwmods(od);
> + =A0 =A0 =A0 iounmap(phy_base);
> +plat_res_err:
> + =A0 =A0 =A0 return ret;
> +}
> +
> +int omap_temp_sensor_device_activate(struct omap_device *od)
> +{
> + =A0 =A0 =A0 struct =A0omap_temp_sensor_registers =A0 =A0 =A0*regist=
ers;
> + =A0 =A0 =A0 struct =A0resource =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0*mem;
> + =A0 =A0 =A0 void =A0 =A0__iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *phy_base;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ret =3D 0, temp;
> +
> + =A0 =A0 =A0 ret =3D omap_device_enable_hwmods(od);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 mem =3D platform_get_resource(&od->pdev, IORESOURCE_MEM=
, 0);
> + =A0 =A0 =A0 if (!mem) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev, "no mem resource=
\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 phy_base =3D ioremap(mem->start, resource_size(mem));
> + =A0 =A0 =A0 if (!phy_base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&od->pdev.dev, "ioremap failed\=
n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto plat_res_err;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!strcmp(od->hwmods[0]->dev_attr, "mpu"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 registers =3D &omap_mpu_temp_sensor_reg=
isters;
> +
> + =A0 =A0 =A0 temp =3D __raw_readl(phy_base + registers->temp_sensor_=
ctrl);
> + =A0 =A0 =A0 temp &=3D ~(registers->bgap_tempsoff_mask);
> + =A0 =A0 =A0 /* BGAP_TEMPSOFF should be reset to 0 */
> + =A0 =A0 =A0 __raw_writel(temp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 phy_base + registers->t=
emp_sensor_ctrl);
> + =A0 =A0 =A0 iounmap(phy_base);
> +
> +plat_res_err:
> + =A0 =A0 =A0 return ret;
> +}

I do not think it is a good thing to ioremap and iounmap the resource
registers every time you need to access the device.
That should be gone in init/deinit functions instead.

Regards,
Jean

> +
> +static struct omap_device_pm_latency omap_temp_sensor_latency[] =3D =
{
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_temp_sensor_d=
evice_idle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =3D =A0omap_temp_sensor_=
device_activate,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJ=
UST,
> + =A0 =A0 =A0 }
> +};
> +
> +static DEFINE_IDR(temp_sensor_device_idr);
> +
> +static int temp_sensor_dev_init(struct omap_hwmod *oh, void *user)
> +{
> + =A0 =A0 =A0 struct =A0omap_temp_sensor_pdata =A0 =A0 =A0 =A0 =A0*te=
mp_sensor_pdata;
> + =A0 =A0 =A0 struct =A0omap_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 *od;
> + =A0 =A0 =A0 struct =A0omap_temp_sensor_dev_attr =A0 =A0 =A0 *temp_s=
ensor_dev_attr;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 num;
> +
> + =A0 =A0 =A0 temp_sensor_pdata =3D
> + =A0 =A0 =A0 =A0 =A0 kzalloc(sizeof(*temp_sensor_pdata), GFP_KERNEL)=
;
> + =A0 =A0 =A0 if (!temp_sensor_pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&oh->od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Unable to allocate mem=
ory for temp sensor pdata\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D idr_pre_get(&temp_sensor_device_idr, GFP_KERNEL=
);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_id;
> + =A0 =A0 =A0 ret =3D idr_get_new(&temp_sensor_device_idr, temp_senso=
r_pdata, &num);
> + =A0 =A0 =A0 if (ret < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_id;
> +
> + =A0 =A0 =A0 temp_sensor_dev_attr =3D oh->dev_attr;
> + =A0 =A0 =A0 if (!strcmp(temp_sensor_dev_attr->name, "mpu")) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_pdata->registers =3D &omap_=
mpu_temp_sensor_registers;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&oh->od->pdev.dev, "Invalid de=
vice attribute\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_id;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 od =3D omap_device_build("omap_temp_sensor", num,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh, temp_sensor_pdata, sizeof(*temp_sen=
sor_pdata),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_temp_sensor_latency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap_temp_sensor_latency), 0=
);
> +
> + =A0 =A0 =A0 if (IS_ERR(od)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&oh->od->pdev.dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Could not build omap_d=
evice for %s\n", oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(od);
> + =A0 =A0 =A0 }
> +
> +fail_id:
> + =A0 =A0 =A0 kfree(temp_sensor_pdata);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +int __init omap_devinit_temp_sensor(void)
> +{
> + =A0 =A0 =A0 if (!cpu_is_omap446x())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 return omap_hwmod_for_each_by_class("temperature_sensor=
",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp_sensor_dev_init, N=
ULL);
> +}
> +
> +arch_initcall(omap_devinit_temp_sensor);
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 6e6735f..8fd8e80 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -115,6 +115,18 @@ config OMAP_MCBSP
> =A0 =A0 =A0 =A0 =A0Say Y here if you want support for the OMAP Multic=
hannel
> =A0 =A0 =A0 =A0 =A0Buffered Serial Port.
>
> +config OMAP_TEMP_SENSOR
> + =A0 =A0 =A0 bool "OMAP Temp Sensor Support"
> + =A0 =A0 =A0 depends on ARCH_OMAP
> + =A0 =A0 =A0 default n
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Say Y here if you want support for the temp sensor
> + =A0 =A0 =A0 =A0 on OMAP4460.
> +
> + =A0 =A0 =A0 =A0 This provides the temperature of the MPU
> + =A0 =A0 =A0 =A0 subsystem. Only one instance of on die temperature
> + =A0 =A0 =A0 =A0 sensor is present.
> +
> =A0config OMAP_MBOX_FWK
> =A0 =A0 =A0 =A0tristate "Mailbox framework support"
> =A0 =A0 =A0 =A0depends on ARCH_OMAP
> --
> 1.7.0.4
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
