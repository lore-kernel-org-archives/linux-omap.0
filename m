From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/26] ARM: omap4-panda.dts: add display information
Date: Mon, 9 Dec 2013 14:56:20 +0200
Message-ID: <52A5BDF4.2070304@ti.com>
References: <1386160133-24026-1-git-send-email-tomi.valkeinen@ti.com>	<1386160133-24026-16-git-send-email-tomi.valkeinen@ti.com> <CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="sweC9I40gClxwW27U3q7MX5Ud9fwMgckI"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41596 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933133Ab3LIM4Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Dec 2013 07:56:24 -0500
In-Reply-To: <CABxcv=m+-9V2qwvuQgJavQ3qOb2+fBcAoW9G_Mi33BTHCWE85g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>

--sweC9I40gClxwW27U3q7MX5Ud9fwMgckI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2013-12-06 10:57, Javier Martinez Canillas wrote:

>> +       tfp410: encoder@0 {
>> +               compatible =3D "ti,tfp410";
>> +               gpios =3D <&gpio1 0 0>;   /* 0, power-down */
>> +
>=20
> Please use the constants from include/dt-bindings/ instead of magic
> numbers, i.e:
>=20
> gpios =3D <&gpio1 0 GPIO_ACTIVE_HIGH>;   /* 0, power-down */

Thanks, fixed now (for all .dts files)

However... The TFP410 gpio is "power-down". I think we should actually
mark it as GPIO_ACTIVE_LOW, as setting it to 0 powers down the device.

 Tomi



--sweC9I40gClxwW27U3q7MX5Ud9fwMgckI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSpb30AAoJEPo9qoy8lh71nU0QAKXbwnH5YsMsNEZwCQWu6gTt
J4QMj9/LP/Dcm7PMdT7Y+Acuqnen4v2zYbNeiYflOPlT02XAmk+QqmMTUeI74R6o
l1xlqXD4NZbAy7m3BQERQFQ3uBTmrKdtnlePKm/4MpXN6d0Sdxbg1CYiFv7AetaK
U5ES0+N6CiCb5dq1AlaAG/qAxMu28EiJQ2xRyrmThHM5jDsg29N4+zY1+Io/nlqj
D0G/9tSUUQdLzKmPzLbDSaSnX8MAYuh8DqD3gIoQZfbaqSmTPwmwk2iIuyEQtRCs
bpNPGP9lSkvqLWQK6o6j2eyNv/fmcRlD4nbCJhTyAcl39kWhtfO+W5Uh7zXtgioG
mgeWiLozKbRLwtwfwrDIs2C1RzuIzrfxRoG7pQLzuMTU8dFtru1yhLwe3UfZkQPt
B1RAc77QsbvaAfZ9UKX1/iy8JOEqOj2FyI6+QgaBVrcHduTKPOU9Lq1BZYtgnwqg
WKQtqY+Qr8+HynjUg3eaH0wIIP+s2ZswUq34pFpVP3LuA8u9tqwkOinVaPDpLfRt
p4FyOxMCMsqyBrGbnSyCoyCtQaGw2lc7jSgugDUBPQSX6syssxocgFBKD8NCA6fO
Cp/0obq5q+7TSwXD4OlFdIAfySaN/FeGXeITnupGQ7jNBt/T73uN/zFZClvysTdl
fPQHb59QlPhsA1W70Mev
=1HkV
-----END PGP SIGNATURE-----

--sweC9I40gClxwW27U3q7MX5Ud9fwMgckI--
