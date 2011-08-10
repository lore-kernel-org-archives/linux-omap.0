From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC PATCH 5/6] OMAP4460: Temperature sensor data
Date: Wed, 10 Aug 2011 15:37:59 +0300
Message-ID: <20110810123758.GH12882@legolas.emea.dhcp.ti.com>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
 <1312979122-5896-6-git-send-email-j-keerthy@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E69HUUNAyIJqGpVn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:54751 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab1HJMiF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Aug 2011 08:38:05 -0400
Received: by fxbb27 with SMTP id b27so1075297fxb.32
        for <linux-omap@vger.kernel.org>; Wed, 10 Aug 2011 05:38:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1312979122-5896-6-git-send-email-j-keerthy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com


--E69HUUNAyIJqGpVn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 10, 2011 at 05:55:21PM +0530, Keerthy wrote:
> The register set and the
> bit fields might vary across OMAP versions. Hence
> creating a structure comprising of all the registers
> and bit fields to make the driver uniform for all the
> versions with different register sets. The data file
> contains the structure populated with register offsets
> and bit fields corresponding to OMAP4460 on die sensor.
>=20
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  arch/arm/mach-omap2/temp_sensor4460_data.c |   63 ++++++++++++++++++++++=
++++++
>  1 files changed, 63 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c
>=20
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

this is used on previous patch, so you have a compilation error.

--=20
balbi

--E69HUUNAyIJqGpVn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOQnumAAoJEAv8Txj19kN1pBAH/2THCkRc6X/l6H7mI0ZxzkfS
qhtkqnHkxX7CjayR7rpDeJMtC195KcjuUnSW1pYGcEqV5QS90KcaEt98LjdvvtQ3
aFEO544YVwtKutC5aO/ZewPo1fkrc3CAW/RH0xr41BZGk1Bnm1QtUhH94BOuQRFc
c+wgTl3qZo2dvM+MjREkzOQlmA/Guxf57JtfjGBnuVTmsPgxLuiDqFua8WrJn1va
VKkksa+zEhRlW5SU6ZLsiGb3hRRoa7lgTLCwaHhkeN4/a6TjtVbi4b3F8m50wsQf
Q2lCk+moTjbZCk0im6+W9wycTJPwWXL7VL5rHHOHd2qKyN9gB5+/T/HOCGDWqBA=
=cPro
-----END PGP SIGNATURE-----

--E69HUUNAyIJqGpVn--
