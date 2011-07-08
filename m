From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC 2/4] omap3beagle: Instantiate VDD1 and VDD2 regulators
Date: Fri, 8 Jul 2011 19:22:04 +0300
Message-ID: <20110708162203.GC31978@legolas.emea.dhcp.ti.com>
References: <1310140588-26078-1-git-send-email-t-kristo@ti.com>
 <1310140588-26078-3-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:37484 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750808Ab1GHQWJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:22:09 -0400
Received: by mail-bw0-f42.google.com with SMTP id 19so2111675bwa.29
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:22:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310140588-26078-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, lrg@ti.com, broonie@opensource.wolfsonmicro.com, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Thomas Petazzoni <t-petazzoni@ti.com>


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 08, 2011 at 06:56:26PM +0300, Tero Kristo wrote:
> From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>=20
> Instantiate the VDD1 and VDD2 regulators and connect them to their
> respective consumers: mpu.0 for VDD1 and l3_main.0 for VDD2.
>=20
> TODO:
>=20
>  * As these instantiations will be identical for all OMAP3 boards,
>    find a way of sharing them throughout the different OMAP3 boards.
>=20
> Signed-off-by: Thomas Petazzoni <t-petazzoni@ti.com>
> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   35 +++++++++++++++++++++++++=
++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap=
2/board-omap3beagle.c
> index 78cf5f2..6d3a266 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -24,6 +24,7 @@
>  #include <linux/input.h>
>  #include <linux/gpio_keys.h>
>  #include <linux/opp.h>
> +#include <linux/regulator/driver.h>
> =20
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
> @@ -400,6 +401,38 @@ static struct regulator_init_data beagle_vpll2 =3D {
>  	.consumer_supplies	=3D beagle_vdvi_supplies,
>  };
> =20
> +static struct regulator_consumer_supply beagle_vdd1_supply =3D

should be array.

> +	REGULATOR_SUPPLY("vcc", "mpu.0");
> +
> +static struct regulator_consumer_supply beagle_vdd2_supply =3D

should be array

> +	REGULATOR_SUPPLY("vcc", "l3_main.0");
> +
> +static struct regulator_init_data beagle_vdd1 =3D {
> +	.constraints =3D {
> +		.name			=3D "VDD1",
> +		.min_uV			=3D 600000,
> +		.max_uV			=3D 1450000,
> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		=3D REGULATOR_CHANGE_VOLTAGE,
> +	},
> +	.num_consumer_supplies	=3D 1,

ARRAY_SIZE(beagle_vdd1_supply)

> +	.consumer_supplies	=3D &beagle_vdd1_supply,
> +};
> +
> +static struct regulator_init_data beagle_vdd2 =3D {
> +	.constraints =3D {
> +		.name			=3D "VDD2",
> +		.min_uV			=3D 600000,
> +		.max_uV			=3D 1450000,
> +		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask		=3D REGULATOR_CHANGE_VOLTAGE,
> +	},
> +	.num_consumer_supplies	=3D 1,

ARRAY_SIZE(beagle_vdd1_supply)

--=20
balbi

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOFy6rAAoJEAv8Txj19kN1q7oIAIiDr+i5u+NuIGmk0CY6av0s
oft1fy+3k6FfDMMF5hyEu0gNSeBxitdPC2UDbFmKyo27d9eP75yncIlWTHDVFC2I
Tjk1743G9+FGjzNq2FfL4SiwGmv1H/Z/AsVH1J+x6m+R5bSSporLWBNOAzTnaGS1
hHNU33pkjC+asRKMSpdH4rsw4ESg5vuKdN8hP6dqTLTq5umDmrCcg6UAHmMO/KiQ
NdnlzmjC+ItqRgKe6bMNSbLYXiKkBFJtnQnVPTRYyFSv6IQMnPl3Lfg0Ll3KObrx
aEJOaS+OMGr3Rbs5K3TOy/mUXLMyNRJ1ZUZInqi9ysH6WQmNxlgH83PkquwqwVY=
=npS1
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
