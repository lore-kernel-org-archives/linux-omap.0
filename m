From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Mon, 23 Dec 2013 09:49:24 +0200
Message-ID: <52B7EB04.6000606@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <20131219175644.GE32243@n2100.arm.linux.org.uk> <20131219182252.GP27438@atomide.com> <20131220112700.GF32243@n2100.arm.linux.org.uk> <20131220114837.GH32243@n2100.arm.linux.org.uk> <52B44982.4020501@ti.com> <20131220160432.GZ27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KJwKSqLwuSsxiv7u6BihOIl4HfB1VxSVd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59164 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756670Ab3LWHt7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Dec 2013 02:49:59 -0500
In-Reply-To: <20131220160432.GZ27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--KJwKSqLwuSsxiv7u6BihOIl4HfB1VxSVd
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-20 18:04, Tony Lindgren wrote:

>> This looks odd... Presuming the panel device was probed successfully, =
it
>> should always get the gpios or return an error. Only if gpio_is_valid(=
)
>> returns false for the gpio, it skips it and continues. But in this cas=
e,
>> the gpio number comes from the platform data, so it should always be v=
alid.
>>
>> And if it wasn't probed successfully, then there shouldn't be a fb0.
>=20
> I bet that's it though. If the display is probed before twl4030 GPIO
> is initialized, the GPIO numbers will be 0. I'm using omap2plus_defconf=
ig
> which has DSS built as modules.

Ah, right, I see. The gpio numbers for the panel pdata are initialized
to -1 (not 0) in the board file. The twl init code will set those to
their appropriate numbers, but if the panel is probed before twl, the
panel driver just presumes gpios are not needed as they are -1.

 Tomi



--KJwKSqLwuSsxiv7u6BihOIl4HfB1VxSVd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSt+sEAAoJEPo9qoy8lh71sR4QAKJJYHe5QjKLVPkqIzoMlgNV
inMp7JJkJPvC6blNtkUqog6OXrMEdk9M4wQahOqyNwLM+O+q4AgmOvskbWrjrmpj
MD2ZVHS+sLOAtqCj+u0ywIgq5ZBeUevQJN9GBqwulX/sT9uKW14uXyYyDjBPMi4g
pAEGcWH8BEUlzFtfLTDQq9gEOFubBmHf9t1giu//jN1O6aXqhNy3UDmeabqsSsmZ
RUFmOuDCmKi6sUuSmzq3mvdE9+Hhs9zYQruYVBb0wh93ILGRUq86IPTViHBDrjEP
5MHuTA0BJSVsoM9mOpBuLW66vDxhKIpGUpKPASifk8F4Z++Fnb+yQCfBvJx5bthc
tmb9wiVH4dkhlFEiH8czgBYPYzSDEJns8danVnxY1faXOR4eUhoFSNoUahk+4HsA
ovGmmuHbm4egHUZjud61Bh/ntzd5AVWVXkRvFYdzsH9fHhilev1oEJKIGI0C2YKd
M8DxmULJeTJ2+XdaBDQPaf9ipbEDrbPawdor6U6k6k8LAaCyFydphNhwdISHxcUQ
mKzFUlAogaWhvYgD0tUEHtjrhUL1JykMGc1aPJ6TMiUDAz4LUieVDWiePGlN3nKA
darZHPiNfOAxquUReyFjMjBw4Uc3ol6bojHoJdjbif1e0qIE36RkSJZ7m8nIRydU
R1yKsrpgnncCqp1+IXOj
=zV5E
-----END PGP SIGNATURE-----

--KJwKSqLwuSsxiv7u6BihOIl4HfB1VxSVd--
