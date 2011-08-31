From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/6 V4] OMAP4: Hwmod: OMAP temperature sensor
Date: Wed, 31 Aug 2011 17:16:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1108311656160.26173@utopia.booyaka.com>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com> <1314811510-15595-5-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-904751321-1314832604=:26173"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41898 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755594Ab1HaXQp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Aug 2011 19:16:45 -0400
In-Reply-To: <1314811510-15595-5-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-904751321-1314832604=:26173
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Keerthy, Beno=EEt,

On Wed, 31 Aug 2011, Keerthy wrote:

> From: Benoit Cousson <b-cousson@ti.com>
>=20
> OMAP4460 temperature sensor hwmod cannot be auto generated
> since it is part of ctrl module. Hence populating the
> necessary hwmod info manually.

Looking at the 4460 1.x TRM Rev H, does it makes sense to create a=20
separate hwmod structure for this IP block?  It looks to me like these=20
registers are integrated pretty tightly inside the SYSCTRL_GENERAL_CORE IP=
=20
block.  So from a hwmod perspective, it seems to be a different situation=
=20
than, say, the RFBI block inside the DSS subsystem?

Just based on looking at Table 18-110 "Control Module Instance Summary"=20
and Table 18-111 "SYSCTRL_GENERAL_CORE Register Mapping Summary", it seems=
=20
to me that this IP block is best represented as an MFD.  Something like=20
drivers/mfd/wm8350-core.c, which registers a hwmon device, which is then=20
driven by drivers/hwmon/wm8350-hwmon.c.

That should avoid the need for this hwmod entry too.

>=20
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: tony@atomide.com
> Cc: b-cousson@ti.com
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   61 ++++++++++++++++++++++=
++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-o=
map2/omap_hwmod_44xx_data.c
> index 6201422..28bf6d3 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -29,6 +29,7 @@
>  #include <plat/mcbsp.h>
>  #include <plat/mmc.h>
>  #include <plat/i2c.h>
> +#include <plat/temperature_sensor.h>
> =20
>  #include "omap_hwmod_common_data.h"
> =20
> @@ -832,6 +833,63 @@ static struct omap_hwmod omap44xx_aess_hwmod =3D {
>  };
> =20
>  /*
> + * 'temperature_sensor' class
> + * temperature sensor module inside the bandgap / control module
> + */
> +
> +static struct omap_hwmod_class omap44xx_temperature_sensor_hwmod_class =
=3D {
> +=09.name   =3D "temperature_sensor",
> +};
> +
> +static struct omap_hwmod_irq_info omap44xx_temperature_sensor_irqs[] =3D=
 {
> +=09{ .name =3D "thermal_alert", .irq =3D 126 + OMAP44XX_IRQ_GIC_START },
> +};
> +
> +static struct omap_hwmod_addr_space omap44xx_temperature_sensor_addrs[] =
=3D {
> +=09{
> +=09=09.pa_start       =3D 0x4a00232c,
> +=09=09.pa_end         =3D 0x4a00238b,
> +=09},
> +};
> +
> +static struct omap_hwmod omap44xx_temperature_sensor_hwmod;
> +/* l4_cfg -> ctrl_module_core */
> +static struct omap_hwmod_ocp_if omap44xx_l4_cfg__temperature_sensor =3D =
{
> +=09.master         =3D &omap44xx_l4_cfg_hwmod,
> +=09.slave          =3D &omap44xx_temperature_sensor_hwmod,
> +=09.clk            =3D "l4_div_ck",
> +=09.addr           =3D omap44xx_temperature_sensor_addrs,
> +=09.user           =3D OCP_USER_MPU | OCP_USER_SDMA,
> +};
> +
> +/* ctrl_module_core slave ports */
> +static struct omap_hwmod_ocp_if *omap44xx_temperature_sensor_slaves[] =
=3D {
> +=09&omap44xx_l4_cfg__temperature_sensor,
> +};
> +
> +/* temperature sensor dev_attr */
> +static struct omap_temp_sensor_dev_attr temp_sensor_dev_attr =3D {
> +=09.name=09=3D "mpu",
> +};
> +
> +static struct omap_hwmod omap44xx_temperature_sensor_hwmod =3D {
> +=09.name           =3D "temperature_sensor_mpu",
> +=09.class          =3D &omap44xx_temperature_sensor_hwmod_class,
> +=09.mpu_irqs       =3D omap44xx_temperature_sensor_irqs,
> +=09.main_clk       =3D "bandgap_ts_fclk",
> +=09.slaves=09=09=3D omap44xx_temperature_sensor_slaves,
> +=09.slaves_cnt     =3D ARRAY_SIZE(omap44xx_temperature_sensor_slaves),
> +=09.clkdm_name     =3D "l4_wkup_clkdm",
> +=09.prcm           =3D {
> +=09=09.omap4 =3D {
> +=09=09.clkctrl_offs =3D OMAP4_CM_WKUP_BANDGAP_CLKCTRL_OFFSET,
> +=09=09},
> +=09},
> +=09.dev_attr=09=3D &temp_sensor_dev_attr,
> +=09.omap_chip      =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
> +};
> +
> +/*
>   * 'bandgap' class
>   * bangap reference for ldo regulators
>   */
> @@ -5469,6 +5527,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmod=
s[] =3D {
>  =09&omap44xx_timer10_hwmod,
>  =09&omap44xx_timer11_hwmod,
> =20
> +=09/* temperature sensor hwmod */
> +=09&omap44xx_temperature_sensor_hwmod,
> +
>  =09/* uart class */
>  =09&omap44xx_uart1_hwmod,
>  =09&omap44xx_uart2_hwmod,
> --=20
> 1.7.0.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


- Paul
--155748971-904751321-1314832604=:26173--
