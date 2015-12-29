From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: OMAPFB: panel-sony-acx565akm: fix missing mutex
 unlocks
Date: Tue, 29 Dec 2015 09:46:17 +0200
Message-ID: <56823A49.7080508@ti.com>
References: <52C956E9.2030008@gmail.com>
 <1388927585-5640-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <52CFD1ED.7010302@ti.com> <52D1113C.8020807@gmail.com>
 <52D3BE08.9040508@ti.com> <567D44B3.6090309@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UkQl1C9WSoj2bUHmjx5jLWlpbUXrmnBt4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <567D44B3.6090309@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: plagnioj@jcrosoft.com, pali.rohar@gmail.com, pavel@ucw.cz, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <freemangordon@abv.bg>, Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: linux-omap@vger.kernel.org

--UkQl1C9WSoj2bUHmjx5jLWlpbUXrmnBt4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25/12/15 15:29, Ivaylo Dimitrov wrote:
>=20
> Hi Tomi,
>=20
> On 13.01.2014 12:20, Tomi Valkeinen wrote:
>> On 2014-01-11 11:39, Ivaylo Dimitrov wrote:
>>
>>> The patch does not apply cleanly on top of rc7, however I applied it =
by
>>> hand. So far it seems it fixes the issue brought by
>>> c37dd677988ca50bc8bc60ab5ab053720583c168, though I didn't test if
>>> mutex_lock/mutex_unlock are complementary in every code path (at leas=
t
>>> not explicitly, I guess maemo is doing it for us anyway :) ).
>>
>> Ok, thanks.
>>
>>> So, shall I send a patch incorporating your code changes, or you will=
 do
>>> it?
>>
>> I can handle it.
>>
>>   Tomi
>>
>>
>=20
> I still don't see those fixes in mainline, shall I send a patch?

Oh, I'm sorry, I must have forgotten about that. Please, send a new patch=
=2E

 Tomi


--UkQl1C9WSoj2bUHmjx5jLWlpbUXrmnBt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWgjpJAAoJEPo9qoy8lh714zcP/1BMHAQGzYn6HpUOZ+H1XKCF
h0m7Q32Lm/j+HUXL68JHAhVFXeclyKMFjKcejLT8BJjb0ubPtgyC/5PkxTzbaZ2T
Rmz96QOOHjT3QUbh+UlBBbNEUv9MvTMH+VaNYQKm6WlVT46hgY6NcNh/6H/9jpje
wBElMZ9j+rTWaGqeYh+IYQ/jOZa337SI/1l2k/9K1dp1B6aI44XdOV0++KNq8R/p
B29UftbzeIfVr6rrJnWFaAbEnZCPhHADYwBXURBhgRwMCgh3Dqv4mlbU9m4UFDY4
Tqp2o6mBCuesP4YCncBbOzOyY8gymZ1bHJ41dgti7kIIwMR8lbd9brooB6Isy102
anENhHlei76Q2kYsE86dAWex0TtMnYI6DedleAON+qT2OianEgpra0ndv67spW88
TSe3aiQB78Y+b7I9GjyIFNaLVWs1c/oPlNAh97e/KtLMBOFyV2V+aCCC+565ASxK
GSBBNXaaVyAchL0JAn+TM2lCjHnLS0kShh8pXIqGiFIIVKNiT92ZwCm/LVMP/PtV
hOyJDRMCDcIzqLhwTDfKNmIhjs4h8V95KPItU7GfliV5TWKVaFKfczDJgLo3SeeX
AxkNBhwNeAUGIQHQA92JJmzgeKwirZmH9Nam09Szv120lxAg8I9B/ZnfSRzmtgF0
0Etz/d3tzLl6EI5UVt96
=Tfnf
-----END PGP SIGNATURE-----

--UkQl1C9WSoj2bUHmjx5jLWlpbUXrmnBt4--
