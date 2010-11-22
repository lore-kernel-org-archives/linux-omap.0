From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 22 Nov 2010 12:03:55 +0530
Message-ID: <AANLkTikxf-+iM0QMvkms6Ykz64x043-B1pNA96pi=OFh@mail.gmail.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com> <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com> <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com> <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com> <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com> <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52452 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab0KVGeh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 01:34:37 -0500
Received: by iwn40 with SMTP id 40so8053300iwn.17
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:34:36 -0800 (PST)
In-Reply-To: <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>, Partha Basak <p-basak2@ti.com>

On Sat, Nov 20, 2010 at 08:09, Tarun Kanti DebBarma <tarun.kanti@ti.com=
> wrote:
> From: Thara Gopinath <thara@ti.com>
>
> Add routines to converts dmtimers to platform devices. The device dat=
a
> is obtained from hwmod database of respective platform and is registe=
red
> to device model after successful binding to driver. It also provides
> provision to access timers during early boot when pm_runtime framewor=
k
> is not completely up and running.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> [p-basak2@ti.com: pm_runtime logic]

Where is runtime logic in this patch? The patch description says "pm_ru=
ntime
framework is not completely up and running"

> Signed-off-by: Partha Basak <p-basak2@ti.com>
> ---
> =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> =A0arch/arm/mach-omap2/dmtimer.c | =A0296 +++++++++++++++++++++++++++=
++++++++++++++
> =A02 files changed, 297 insertions(+), 1 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/dmtimer.c
>
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index ce7b1f0..148f4d7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -4,7 +4,7 @@
>
> =A0# Common support
> =A0obj-y :=3D id.o io.o control.o mux.o devices.o serial.o gpmc.o tim=
er-gp.o pm.o \
> - =A0 =A0 =A0 =A0common.o
> + =A0 =A0 =A0 =A0common.o dmtimer.o
>
> =A0omap-2-3-common =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0=3D irq.o sdrc.o prm2xxx_3xxx.o
> =A0hwmod-common =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 omap_hwmod.o \
> diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmti=
mer.c
> new file mode 100644
> index 0000000..b5951b1
> --- /dev/null
> +++ b/arch/arm/mach-omap2/dmtimer.c
> @@ -0,0 +1,296 @@
> +/**
> + * OMAP2PLUS Dual-Mode Timers - platform device registration
> + *
> + * Contains first level initialization routines which extracts timer=
s
> + * information from hwmod database and registers with linux device m=
odel.
> + * It also has low level function to chnage the timer input clock so=
urce.
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti=
=2Ecom/
> + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> + *
> + * Copyright (C) 2010 Texas Instruments Incorporated
> + * Thara Gopinath <thara@ti.com>

Don't repeat the same copyright information twice:
"Copyright (C) 2010 Texas Instruments Incorporated"

> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See th=
e
> + * GNU General Public License for more details.
> + */
> +#undef DEBUG
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +
> +#include <mach/irqs.h>
> +#include <plat/dmtimer.h>
> +#include <plat/powerdomain.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
> +#include <linux/pm_runtime.h>

Why is "linux/pm_runtime.h" required in this file? I don't find any use=
 here.
Also check if "plat/powerdomain.h" is required.

> +
> +static int early_timer_count __initdata =3D 1;
> +
> +/**
> + * omap2_dm_timer_set_src - change the timer input clock source
> + * @pdev: =A0 =A0 =A0timer platform device pointer
> + * @timer_clk: current clock source
> + * @source: =A0 =A0array index of parent clock source
> + */
> +static int omap2_dm_timer_set_src(struct platform_device *pdev, int =
source)
> +{
> + =A0 =A0 =A0 int ret;
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata =3D pdev->dev.platf=
orm_data;
> + =A0 =A0 =A0 struct clk *fclk =3D clk_get(&pdev->dev, "fck");
> + =A0 =A0 =A0 struct clk *new_fclk;
> + =A0 =A0 =A0 char *fclk_name =3D "32k_ck"; /* default name */
> +
> + =A0 =A0 =A0 switch(source) {
> + =A0 =A0 =A0 case OMAP_TIMER_SRC_SYS_CLK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk_name =3D "sys_ck";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case OMAP_TIMER_SRC_32_KHZ:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk_name =3D "32k_ck";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case OMAP_TIMER_SRC_EXT_CLK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pdata->timer_ip_type =3D=3D OMAP_TI=
MER_IP_VERSION_1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fclk_name =3D "alt_ck";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s:%d: invalid clk=
 src.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> +
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(fclk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s:%d: clk_get() F=
AILED\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 new_fclk =3D clk_get(&pdev->dev, fclk_name);
> + =A0 =A0 =A0 if (IS_ERR_OR_NULL(new_fclk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s:%d: clk_get() %=
s FAILED\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, __LINE__, fcl=
k_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(fclk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D clk_set_parent(fclk, new_fclk);
> + =A0 =A0 =A0 if (IS_ERR_VALUE(ret)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev, "%s:clk_set_parent(=
) to %s FAILED\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, fclk_name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clk_put(new_fclk);
> + =A0 =A0 =A0 clk_put(fclk);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +struct omap_device_pm_latency omap2_dmtimer_latency[] =3D {
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .deactivate_func =3D omap_device_idle_h=
wmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .activate_func =A0 =3D omap_device_enab=
le_hwmods,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .flags =3D OMAP_DEVICE_LATENCY_AUTO_ADJ=
UST,
> + =A0 =A0 =A0 },
> +};
> +
> +/**
> + * omap_dm_timer_early_init - build and register early timer device
> + * with an associated timer hwmod
> + * @oh: timer hwmod pointer to be used to build timer device
> + * @user: parameter that can be passed from calling hwmod API
> + *
> + * early init is called in the last part of omap2_init_common_hw
> + * for each early timer class using omap_hwmod_for_each_by_class.
> + * it registers each of the timer devices present in the system.
> + * at the end of function call memory is allocated for omap_device
> + * and hwmod for early timer and the device is registered to the
> + * framework ready to be probed by the driver.
> + */
> +static int __init omap2_timer_early_init(struct omap_hwmod *oh, void=
 *user)

Again a repeat comment from other hwmod reviews:
if "user" is not used, rename it as "unused"

> +{
> + =A0 =A0 =A0 int id;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 char *name =3D "omap-timer";
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata;
> + =A0 =A0 =A0 struct omap_device *od;
> +
> + =A0 =A0 =A0 pr_debug("%s:%s\n", __func__, oh->name);
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No memory for [%s]\n", __fu=
nc__, oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdata->is_early_init =3D 1;
> +
> + =A0 =A0 =A0 /* hook clock set/get functions */
> + =A0 =A0 =A0 pdata->set_timer_src =3D omap2_dm_timer_set_src;
> +
> + =A0 =A0 =A0 /* read timer ip version */
> + =A0 =A0 =A0 pdata->timer_ip_type =3D oh->class->rev;
> + =A0 =A0 =A0 if (pdata->timer_ip_type =3D=3D OMAP_TIMER_IP_VERSION_2=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->func_offst =3D 0x14;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->intr_offst =3D 0x10;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->func_offst =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->intr_offst =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* extract the id from name filed in hwmod database
> + =A0 =A0 =A0 =A0* and use the same for constructing ids' for the
> + =A0 =A0 =A0 =A0* timer devices. in a way, we are avoiding usage of
> + =A0 =A0 =A0 =A0* static variable witin the function to do the same.
> + =A0 =A0 =A0 =A0* CAUTION: we have to be careful and make sure the
> + =A0 =A0 =A0 =A0* name in hwmod database does not change in which ca=
se
> + =A0 =A0 =A0 =A0* we might either make corresponding change here or
> + =A0 =A0 =A0 =A0* switch back static variable mechanism.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 sscanf(oh->name, "timer%2d", &id);
> +
> + =A0 =A0 =A0 od =3D omap_device_build(name, id, oh, pdata, sizeof(*p=
data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_dmtimer_latency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap2_dmtime=
r_latency), 1);
> +
> + =A0 =A0 =A0 if (IS_ERR(od)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Cant build omap_device for =
%s:%s.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, name, oh->nam=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 early_timer_count++;
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* pdata can be freed because omap_device_build
> + =A0 =A0 =A0 =A0* creates its own memory pool
> + =A0 =A0 =A0 =A0*/

No need to mention this.

> + =A0 =A0 =A0 kfree(pdata);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * omap2_dm_timer_init - build and register timer device with an
> + * associated timer hwmod
> + * @oh: =A0 =A0 =A0 =A0timer hwmod pointer to be used to build timer=
 device
> + * @user: =A0 =A0 =A0parameter that can be passed from calling hwmod=
 API
> + *
> + * called by omap_hwmod_for_each_by_class to register each of the ti=
mer
> + * devices present in the system. the number of timer devices is kno=
wn
> + * by parsing through the hwmod database for a given class name. at =
the
> + * end of function call memory is allocated for omap_device and hwmo=
d
> + * for timer and the device is registered to the framework ready to =
be
> + * proved by the driver.
> + */
> +static int __init omap2_timer_init(struct omap_hwmod *oh, void *user=
)

omap2_timer_init() and omap2_timer_early_init() looks similar except fo=
r
pdata->is_early_init value. Why not have a common function and call it
with appropriate pdata->is_early_init value?

> +{
> + =A0 =A0 =A0 int id;
> + =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 char *name =3D "omap-timer";
> + =A0 =A0 =A0 struct omap_device *od;
> + =A0 =A0 =A0 struct dmtimer_platform_data *pdata;
> +
> + =A0 =A0 =A0 if (!oh) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:NULL hwmod pointer (oh)\n", =
__func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 pr_debug("%s:%s\n", __func__, oh->name);
> +
> + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> + =A0 =A0 =A0 if (!pdata) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s:No memory for [%s]\n", =A0__=
func__, oh->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 pdata->is_early_init =3D 0;
> +
> + =A0 =A0 =A0 /* hook clock set/get functions */
> + =A0 =A0 =A0 pdata->set_timer_src =3D omap2_dm_timer_set_src;
> +
> + =A0 =A0 =A0 /* read timer ip version */
> + =A0 =A0 =A0 pdata->timer_ip_type =3D oh->class->rev;
> + =A0 =A0 =A0 if (pdata->timer_ip_type =3D=3D OMAP_TIMER_IP_VERSION_2=
) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->func_offst =3D 0x14;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->intr_offst =3D 0x10;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->func_offst =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->intr_offst =3D 0;
> + =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* extract the id from name filed in hwmod database
> + =A0 =A0 =A0 =A0* and use the same for constructing ids' for the
> + =A0 =A0 =A0 =A0* timer devices. in a way, we are avoiding usage of
> + =A0 =A0 =A0 =A0* static variable witin the function to do the same.
> + =A0 =A0 =A0 =A0* CAUTION: we have to be careful and make sure the
> + =A0 =A0 =A0 =A0* name in hwmod database does not change in which ca=
se
> + =A0 =A0 =A0 =A0* we might either make corresponding change here or
> + =A0 =A0 =A0 =A0* switch back static variable mechanism.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 sscanf(oh->name, "timer%2d", &id);
> +
> + =A0 =A0 =A0 od =3D omap_device_build(name, id, oh,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata, sizeof(*pdata),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_dmtimer_latency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap2_dmtime=
r_latency), 0);
> +
> + =A0 =A0 =A0 if (IS_ERR(od)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: Cant build omap_device for =
%s:%s.\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, name, oh->nam=
e);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D =A0-EINVAL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* pdata can be freed because omap_device_build
> + =A0 =A0 =A0 =A0* creates its own memory pool
> + =A0 =A0 =A0 =A0*/

Ditto.

> + =A0 =A0 =A0 kfree(pdata);
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * omap2_dm_timer_early_init - top level early timer initialization
> + * called in the last part of omap2_init_common_hw
> + *
> + * uses dedicated hwmod api to parse through hwmod database for
> + * given class name and then build and register the timer device.
> + * at the end driver is registered and early probe initiated.
> + */
> +void __init omap2_dm_timer_early_init(void)
> +{
> + =A0 =A0 =A0 if (omap_hwmod_for_each_by_class("timer",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_timer_early_init, NULL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: device registration FAILE=
D\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 early_platform_driver_register_all("earlytimer");
> + =A0 =A0 =A0 early_platform_driver_probe("earlytimer", early_timer_c=
ount, 0);
> +}
> +
> +/**
> + * omap_timer_init - top level timer device initialization
> + *
> + * uses dedicated hwmod api to parse through hwmod database for
> + * given class names and then build and register the timer device.
> + */
> +static int __init omap2_dmtimer_device_init(void)
> +{
> + =A0 =A0 =A0 int ret =3D omap_hwmod_for_each_by_class("timer", omap2=
_timer_init, NULL);
> +
> + =A0 =A0 =A0 if (unlikely(ret))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: device registration FAILE=
D\n", __func__);
> +
> + =A0 =A0 =A0 return ret;
> +}
> +arch_initcall(omap2_dmtimer_device_init);
> --
> 1.6.0.4
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
