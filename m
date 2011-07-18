From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv3 3/6] regulator: omap smps regulator driver
Date: Mon, 18 Jul 2011 21:22:19 +0300
Message-ID: <20110718182218.GJ25081@legolas.emea.dhcp.ti.com>
References: <1311010522-5868-1-git-send-email-t-kristo@ti.com>
 <1311010522-5868-4-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:45284 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110Ab1GRSWX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jul 2011 14:22:23 -0400
Received: by mail-ew0-f49.google.com with SMTP id 3so1979817ewy.36
        for <linux-omap@vger.kernel.org>; Mon, 18 Jul 2011 11:22:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311010522-5868-4-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com, toddpoynor@google.com, broonie@opensource.wolfsonmicro.com, lrg@ti.com


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 18, 2011 at 08:35:19PM +0300, Tero Kristo wrote:
> diff --git a/drivers/regulator/omap-smps-regulator.c b/drivers/regulator/=
omap-smps-regulator.c
> new file mode 100644
> index 0000000..8b56e4f
> --- /dev/null
> +++ b/drivers/regulator/omap-smps-regulator.c
> @@ -0,0 +1,179 @@
> +/*
> + * omap-vp-regulator.c -- support SMPS regulators for OMAP chips

name is wrong here.

> + *
> + * Copyright (C) 2011 Texas Instruments, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/ctype.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/err.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/driver.h>
> +#include <linux/regulator/machine.h>
> +#include <linux/regulator/omap-smps.h>
> +#include <plat/voltage.h>
> +
> +#define DRIVER_NAME		"omap-smps"
> +
> +struct omap_smps_reg_info {
> +	const char		*vdd_name;
> +	struct regulator_dev	*rdev;
> +	struct voltagedomain	*voltdm;
> +	struct regulator_desc	desc;
> +};
> +
> +static int omap_smps_set_voltage(struct regulator_dev *rdev, int min_uV,
> +				    int max_uV, unsigned *selector)
> +{
> +	struct omap_smps_reg_info	*info =3D rdev_get_drvdata(rdev);
> +	return voltdm_scale(info->voltdm, min_uV);
> +}
> +
> +static int omap_smps_get_voltage(struct regulator_dev *rdev)
> +{
> +	struct omap_smps_reg_info	*info =3D rdev_get_drvdata(rdev);
> +	return omap_vp_get_curr_volt(info->voltdm);
> +}
> +
> +static struct regulator_ops omap_smps_ops =3D {

should this be const ?

--=20
balbi

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOJHnaAAoJEAv8Txj19kN17R4H/iTnx7zWSI3fG2vtLBF+Z7gO
ltiEVy1RWtPLDLC55ZD10B19LbmZOSAlQSeRyhWaUbOiIxo6N4m3/FKTT8d8mAHb
0QPOMmnP3hdpH9/6dLmnK6lcN8IZZ31ti83AXRKk1wnAXX5zLqBmC0G/8eQIS3A/
OhWFEuS6Wxh+j5EXVOoZjtBrFJlGDBXmUMo1EsRPf84Fg9/49Ae5uuRlWcTuy2ce
pyUbEPo3jyh1wffnybWpm/wj3ARRMKNexBrk9J7K9oQ/KZrx+r+60IKNZhPtevYh
+Gtfo8eOl6h0q5cnRdRkrrMSIfhGZr5aJ1bfC+sUg9AHxTNlk++BNUQ30KkhP4Y=
=yE6w
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
