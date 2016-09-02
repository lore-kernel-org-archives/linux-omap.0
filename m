From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
Date: Fri, 2 Sep 2016 14:48:52 +0300
Message-ID: <f4cff876-4457-4548-31ad-3bbe43607f72@ti.com>
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
 <d3df6f32-1294-17bc-8b5f-236d14a349a0@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="1ASglPqVfcMMikjfKc7uxutPuujCcadOc"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d3df6f32-1294-17bc-8b5f-236d14a349a0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--1ASglPqVfcMMikjfKc7uxutPuujCcadOc
Content-Type: multipart/mixed; boundary="LPwPgBIa5lU1sTI3dKusU1SEKcg5LAe3e";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Message-ID: <f4cff876-4457-4548-31ad-3bbe43607f72@ti.com>
Subject: Re: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Add support for rev B1
References: <20160902090600.27262-1-nm@ti.com>
 <20160902090600.27262-3-nm@ti.com>
 <6617013b-4fcd-76cb-7ef0-9395adcddd8d@ti.com>
 <d3df6f32-1294-17bc-8b5f-236d14a349a0@ti.com>
In-Reply-To: <d3df6f32-1294-17bc-8b5f-236d14a349a0@ti.com>

--LPwPgBIa5lU1sTI3dKusU1SEKcg5LAe3e
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 02/09/16 13:01, Nishanth Menon wrote:
> On 09/02/2016 04:58 AM, Tomi Valkeinen wrote:
>> On 02/09/16 12:06, Nishanth Menon wrote:
>>
>>> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>>> b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>>> new file mode 100644
>>> index 000000000000..da61dbba7768
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
>>> @@ -0,0 +1,24 @@
>>> +/*
>>> + * Copyright (C) 2014-2016 Texas Instruments Incorporated -
>>> http://www.ti.com/
>>> + *
>>> + * This program is free software; you can redistribute it and/or mod=
ify
>>> + * it under the terms of the GNU General Public License version 2 as=

>>> + * published by the Free Software Foundation.
>>> + */
>>> +
>>> +#include "am57xx-beagle-x15-common.dtsi"
>>> +
>>> +/ {
>>> +    model =3D "TI AM5728 BeagleBoard-X15 rev B1";
>>> +};
>>> +
>>> +&tpd12s015 {
>>> +    gpios =3D <&gpio7 10 GPIO_ACTIVE_HIGH>,    /* gpio7_10, CT CP HP=
D */
>>> +        <&gpio2 30 GPIO_ACTIVE_HIGH>,    /* gpio6_30, LS OE */
>>
>> Wrong gpio in the comment.
>=20
> Uggh.. thanks for catching that.. should have been gpio2_30
>=20
> will repost a v2 if there are no further comments at the end of the day=
=2E.

Booting and HDMI works fine:

Tested-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

 Tomi


--LPwPgBIa5lU1sTI3dKusU1SEKcg5LAe3e--

--1ASglPqVfcMMikjfKc7uxutPuujCcadOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyWckAAoJEPo9qoy8lh71wI8QAK5efoVgxyvWcOAwb9RNjUx2
uu33RjtVMZZGSNp3MTyXBsIPv+lF8YM+fJb7npRBCYL2bcuafi8gDDFCY2PVAdy5
sqh2I1Cx9nuVUZjCg2CMVV0atPgtUq/PG3sWXYhjfljvCkLkeb9pm/xxx1qrT43N
JFOprDkgJReGOKTuXuKsn9Ya5617Wa8jqO9fgN/LuVAycVBy66EnHHBO3tVS1cZw
bgd89Tqhl4wS3U0QG4rqtk7MWW0GH4FIQIF8eaY4vOw3EvzcIFOHoKAWuExDmUc3
SI4nQ8nWBMBJl4NOZc2oq74FUOzdA4TVvtgDOfax3sHmPFGWsZUkDARtwyOYAPOH
zKUECionF7W7KDnuxGkScegjeTKx+Lj6ALXOi1Der4PzZpGNZ4jvF0IVt9s5RUoj
t3dT2AQOOmEK+Fo5PzWc6CYqI22HdtGWeZD8C73MVj5IjCMGRw3OOPVIH1SsSxg1
2rCwFYdG2Ly61c0Xe61iSEaJDbW7jSr5s1I8MBDXF1kpcIuz/Cn4GUOIsCl3MT25
HYOF3n+g03XgtvsRVpS5zWkXaCTG4pyB+qfRr0OVAKB9+J9i3xUqN+qEzJRfRr7f
p3DtxXYV9dHI98csnMLia3sRYMH3ZOwviuT+LCZEzoC0rXpm1Dj62bz5apMWJqsG
psEu+vxDEO1QqYZaPysm
=57e0
-----END PGP SIGNATURE-----

--1ASglPqVfcMMikjfKc7uxutPuujCcadOc--
