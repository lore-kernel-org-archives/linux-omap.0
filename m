From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Fri, 2 Sep 2016 12:58:55 +0300
Message-ID: <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="Wn0CAoc5voNXRbQPjWQrdcen7lK0Stoqb"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160902090600.27262-3-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--Wn0CAoc5voNXRbQPjWQrdcen7lK0Stoqb
Content-Type: multipart/mixed; boundary="56RQLSse3egPd9gF7npX1j9WhuSn76R0M";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Message-ID: <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
In-Reply-To: <20160902090600.27262-3-nm@ti.com>

--56RQLSse3egPd9gF7npX1j9WhuSn76R0M
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/09/16 12:06, Nishanth Menon wrote:

> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/b=
oot/dts/am57xx-beagle-x15-revb1.dts
> new file mode 100644
> index 000000000000..da61dbba7768
> --- /dev/null
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
> @@ -0,0 +1,24 @@
> +/*
> + * Copyright (C) 2014-2016 Texas Instruments Incorporated - http://www=
=2Eti.com/
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "am57xx-beagle-x15-common.dtsi"
> +
> +/ {
> +	model =3D "TI AM5728 BeagleBoard-X15 rev B1";
> +};
> +
> +&tpd12s015 {
> +	gpios =3D <&gpio7 10 GPIO_ACTIVE_HIGH>,	/* gpio7_10, CT CP HPD */
> +		<&gpio2 30 GPIO_ACTIVE_HIGH>,	/* gpio6_30, LS OE */

Wrong gpio in the comment.

 Tomi


--56RQLSse3egPd9gF7npX1j9WhuSn76R0M--

--Wn0CAoc5voNXRbQPjWQrdcen7lK0Stoqb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyU1fAAoJEPo9qoy8lh71xWwP/j7q9GCxDVgtiAeqXL9Lm8f4
7U54PHwzz053NdCoyrq5JqCX/Is+xmpSJba4WpH93tmfb0DHq32Cl359nG9oIiYO
+g5AMqIA2BNIYO72UCmohdT7zdQ3Xw5Aih5pVzLtSAg8ewfZfZ8BcwMMKYMvymYX
0F9Na9JCENG4tMEKI0SiEAUm9wH8DcQXzq8oEZay7fNi9By/ThNalhF2GhIzJ+GI
DwFiwG8hcn2oGKlqptuh9KpOjuZfTiLXMjyhmaR72ANGaXaNn7V5RSc6rhDHolM2
HlD1zDfkhbJ8Uhp/PRe2HRjI6G7aiaUcLMWfqRXs0hqn+ft9xzF/IVdMF9rQl83D
AUCk+cdJ+6pVi1drL9jF30O8e9P3FdCLJ3pHugl1k2/u4tPfwmm5OFB0WODE1Afk
Z9JyoTbsPAEg5BoQChQyEOhedbPr39SeeAMQ36v2VuxkbgHDHwMwikJ2o3GNluKM
SVcZBoC3tpEkn3/LpsrrWs4jXFyHzxGQhcvT0aCwDKqQflyXA+10TTc/jTXu/+UW
d5PzmP4n1CE5D4wBSIygd/AzWG6AdTTnJfkbWG5qJo4xx9z4jB2D+G7xLSev3/uu
1z+MXy6JcqY9Sl2J2NgBWE4TBDIAJFtrubTZseNx9t8PbuJVTjrFzHQqOuc53f1w
dXgr4ZCZT1Ep+QpppXE9
=butK
-----END PGP SIGNATURE-----

--Wn0CAoc5voNXRbQPjWQrdcen7lK0Stoqb--
