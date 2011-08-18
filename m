From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 3/6 V2] OMAP4460: Temperature sensor data
Date: Thu, 18 Aug 2011 14:32:26 +0300
Message-ID: <20110818113225.GT14514@legolas.emea.dhcp.ti.com>
References: <1313664735-8917-1-git-send-email-j-keerthy@ti.com>
 <1313664735-8917-4-git-send-email-j-keerthy@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zpd1bWBxfrI+71+6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:55019 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755508Ab1HRLcc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Aug 2011 07:32:32 -0400
Received: by bkd1 with SMTP id 1so1897198bkd.40
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 04:32:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313664735-8917-4-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com


--zpd1bWBxfrI+71+6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 18, 2011 at 04:22:12PM +0530, Keerthy wrote:
> The register set and the
> bit fields might vary across OMAP versions. Hence
> creating a structure comprising of all the registers
> and bit fields to make the driver uniform for all the
> versions with different register sets. The data file
> contains the structure populated with register offsets
> and bit fields corresponding to OMAP4460 on die sensor.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Cc: tony@atomide.com
> ---
>  arch/arm/mach-omap2/Makefile                       |    2 +-
>  arch/arm/mach-omap2/temp_sensor4460_data.c         |   63 ++++++++++++++
>  .../plat-omap/include/plat/temperature_sensor.h    |   89 ++++++++++++++=
++++++
>  3 files changed, 153 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
>  create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h
>=20
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index fb02937..2d5d981 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -86,7 +86,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+=3D prcm.o cm2xxx_3xxx.o prm=
2xxx_3xxx.o \
>  obj-$(CONFIG_ARCH_OMAP4)		+=3D prcm.o cm2xxx_3xxx.o cminst44xx.o \
>  					   cm44xx.o prcm_mpu44xx.o \
>  					   prminst44xx.o vc44xx_data.o \
> -					   vp44xx_data.o
> +					   vp44xx_data.o temp_sensor4460_data.o
> =20
>  # OMAP voltage domains
>  ifeq ($(CONFIG_PM),y)
> diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/mach-o=
map2/temp_sensor4460_data.c
> new file mode 100644
> index 0000000..294963d
> --- /dev/null
> +++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
> @@ -0,0 +1,63 @@
> +/*
> + * OMAP4460 on die Temperature sensor data file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Author: J Keerthy <j-keerthy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#include <linux/slab.h>
> +#include "control.h"
> +#include <plat/temperature_sensor.h>
> +
> +/*
> + * OMAP4460 has one instance of thermal sensor for MPU
> + * need to describe the individual bit fields
> + */
> +struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers =3D {
> +	.temp_sensor_ctrl		=3D OMAP4460_TEMP_SENSOR_CTRL_OFFSET,
> +	.bgap_tempsoff_mask		=3D OMAP4460_BGAP_TEMPSOFF_MASK,
> +	.bgap_soc_mask			=3D OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK,
> +	.bgap_eocz_mask			=3D OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK,
> +	.bgap_dtemp_mask		=3D OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK,
> +
> +	.bgap_mask_ctrl			=3D OMAP4460_BGAP_CTRL_OFFSET,
> +	.mask_hot_mask			=3D OMAP4460_MASK_HOT_MASK,
> +	.mask_cold_mask			=3D OMAP4460_MASK_COLD_MASK,
> +
> +	.bgap_mode_ctrl			=3D OMAP4460_BGAP_CTRL_OFFSET,
> +	.mode_ctrl_mask			=3D OMAP4460_SINGLE_MODE_MASK,
> +
> +	.bgap_counter			=3D OMAP4460_BGAP_COUNTER_OFFSET,
> +	.counter_mask			=3D OMAP4460_COUNTER_MASK,
> +
> +	.bgap_threshold			=3D OMAP4460_BGAP_THRESHOLD_OFFSET,
> +	.threshold_thot_mask		=3D OMAP4460_T_HOT_MASK,
> +	.threshold_tcold_mask		=3D OMAP4460_T_COLD_MASK,
> +
> +	.thsut_threshold		=3D OMAP4460_BGAP_TSHUT_OFFSET,
> +	.tshut_hot_mask			=3D OMAP4460_TSHUT_HOT_MASK,
> +	.tshut_cold_mask		=3D OMAP4460_TSHUT_COLD_MASK,
> +
> +	.bgap_status			=3D OMAP4460_BGAP_STATUS_OFFSET,
> +	.status_clean_stop_mask		=3D OMAP4460_CLEAN_STOP_MASK,
> +	.status_bgap_alert_mask		=3D OMAP4460_BGAP_ALERT_MASK,
> +	.status_hot_mask		=3D OMAP4460_HOT_FLAG_MASK,
> +	.status_cold_mask		=3D OMAP4460_COLD_FLAG_MASK,
> +
> +	.bgap_efuse			=3D OMAP4460_FUSE_OPP_BGAP,
> +};
> diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h b/arch/=
arm/plat-omap/include/plat/temperature_sensor.h
> new file mode 100644
> index 0000000..a3186f9
> --- /dev/null
> +++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
> @@ -0,0 +1,89 @@
> +/*
> + * OMAP Temperature sensor header file
> + *
> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> + * Author: J Keerthy <j-keerthy@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> + * 02110-1301 USA
> + *
> + */
> +
> +#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> +#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
> +
> +/* Offsets from the base of temperature sensor registers */
> +
> +#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET	0x00
> +#define OMAP4460_BGAP_CTRL_OFFSET		0x4c
> +#define OMAP4460_BGAP_COUNTER_OFFSET		0x50
> +#define OMAP4460_BGAP_THRESHOLD_OFFSET		0x54
> +#define OMAP4460_BGAP_TSHUT_OFFSET		0x58
> +#define OMAP4460_BGAP_STATUS_OFFSET		0x5c
> +#define OMAP4460_FUSE_OPP_BGAP			-0xcc
> +
> +/*
> + * The register offsets and but fields might change across
				^ bit fields.

--=20
balbi

--zpd1bWBxfrI+71+6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOTPhJAAoJEAv8Txj19kN1b0UH/Rkd3paoYW9cp6Y+lPoJoLFm
9i1GfURRzgCiEhQV/KYCrEOvpGG2wMp+RPEOzJd22gIycrmbDMsbNuq+bi/FPfjE
DPGbwWz+Qzg7wKtBxPF169bWBerhInKpnBiaz+Neq9tX2XRPEai2arCB329/UaLJ
QP2PrKWpsz/Md5/Zny/80sHJ/jADA0ihJVO8wTBzoZr37w502gEsjJ9KtaY4Mgp+
kXe0XbLmqtklKuzVzqX4F8f11VQT/GS1bsByF4863t95tAKk3g4/7vsOn5x8sc6B
b8F0Du6McEAzfHgKVPVbqwbbgcaqMcMvzTgbt8P3z6+Z1d55UqNk5v0nbfVdXLw=
=cOl6
-----END PGP SIGNATURE-----

--zpd1bWBxfrI+71+6--
