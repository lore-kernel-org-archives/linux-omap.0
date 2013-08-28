From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Odd behavior with dpll4_m4x2_ck on omap3 + DT
Date: Wed, 28 Aug 2013 13:14:24 +0300
Message-ID: <521DCD80.1060600@ti.com>
References: <521DC143.2010506@ti.com> <521DC770.5050000@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="R34hQheH0lwFe8nrde5wUkHTFU6I6pDmx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754859Ab3H1KOb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Aug 2013 06:14:31 -0400
In-Reply-To: <521DC770.5050000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, Stefan Roese <sr@denx.de>

--R34hQheH0lwFe8nrde5wUkHTFU6I6pDmx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 28/08/13 12:48, Tero Kristo wrote:
> On 08/28/2013 12:22 PM, Tomi Valkeinen wrote:
>> Hi,
>>
>> I'm seeing odd clock behavior with Beagle, booting with DT. I'm using
>> v3.11-rc7 + DSS DT patches.
>=20
> I guess you are not using the clock DT patches? Just making sure I
> didn't break anything. :)

No, plain rc7 with my DSS DT patches.

>> So, for some reason, the first clk_set_rate goes wrong. Any ideas?
>=20
> Hmm, strange. I am not seeing similar behavior, but I am calling
> clk_set_rate in different location.... also I am using clock DT patches=

> (don't try the current version though, as I am reworking them.)
>=20
> [    0.000000] dpll4_ck: 432000000
> [    0.000000] dpll4_m4_ck: 72000000
> [    0.000000] dpll4_m4x2_ck: 144000000
> [    0.000000] dss1_alwon_fck_3430es2: 144000000
> [    0.000000] dpll4_ck: 432000000
> [    0.000000] dpll4_m4_ck: 86400000
> [    0.000000] dpll4_m4x2_ck: 172800000
> [    0.000000] dss1_alwon_fck_3430es2: 172800000
>=20
> Do you see the error only when setting to some specific rate (86400000)=

> or it doesn't matter?

I also tried setting to 72000000, with the same result.

Do you know if I can somehow easily get debug prints from the clock
framework, that could lighten up the issue?

 Tomi



--R34hQheH0lwFe8nrde5wUkHTFU6I6pDmx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSHc2AAAoJEPo9qoy8lh71gTUP/0aOF9HpB8qyeYErTMQM1eYD
V653CDJp0DPEtADYtEWzwiTLdns9KvYO6M6n8L10TZqMDpeURaWq6253a1AFblQ1
pqzo4w0crRaUAGTEkmYZo5SBs4qT7eL2cO7c9Y/UTg0puZ6nHR99bE/ZB6f9KGnC
0zA5mvWJjki4M/Axcf6Eox4riqWwEbru1V5VG7bDFlqArhoSOwgJppYkl45PYPFB
zL3dJlwTMfEG9merMd2ynfjetOzrQja9TFH0Na13fiIW1Ih9FnXrfsFt3WbtAMa7
pJkw9PTLdV/Rw977vtQRCTDXhA3/HY77BnwmG9XfAz5hAPJ++v9HHW688YsKp4Bg
Lr1PC3cugjXQ5Fqyds98f9XH9JeEjNa20EVH2c4mcLk0AsUn3MKLYK6V5sVSYgQb
XXCpDt6q/hjj6MarL48cMz4GbyeMeWkSv4Duta/VINHuVEEY6Bka6Q7H6fjgUEMl
l9D7TQ15WFH5SuX4i1OWFfZZHmxrPXhf+pVgZp3ZEiZltr2WWrvaEE8UU6TPZJ1o
q/8Dy8e14K+zhHKnedqu6LxLZiixxHi6/66Fm+N/PX+qUQKETS9wl6mKQ4IwHtlw
ssvDdN+zhG0Us3mg9hPZ3wBbSuHiRnBufy+8wgqlGTHGej9aTy1aagwkiFYt+VSU
NmO8P0hkmIyRxWnRYqFh
=+eGa
-----END PGP SIGNATURE-----

--R34hQheH0lwFe8nrde5wUkHTFU6I6pDmx--
