From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Fri, 21 Aug 2015 12:17:41 +0300
Message-ID: <55D6ECB5.6010708@ti.com>
References: <201507241803.42891@pali> <55D6E466.5060706@ti.com> <20150821084807.GD27391@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EAGKAipAvqRcWFEjknQUX6SoFgRrptc4F"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150821084807.GD27391@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--EAGKAipAvqRcWFEjknQUX6SoFgRrptc4F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21/08/15 11:48, Pali Roh=C3=A1r wrote:
> On Friday 21 August 2015 11:42:14 Tomi Valkeinen wrote:
>>
>>
>> On 24/07/15 19:03, Pali Roh=C3=A1r wrote:
>>> Hello,
>>>
>>> when on N900 (real HW or qemu) I run this command
>>>
>>> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0=
 > /sys/class/graphics/fb0/size
>>>
>>> then kernel crash with this error message
>>>
>>> / # [   29.904113] Division by zero in kernel.
>>
>=20
> Hi! Thanks for explaining.
>=20
>> The problem is that fb console uses the kernel mmapped framebuffer, bu=
t
>> omapfb is not aware of the fb console. So the above commands free the
>> framebuffer, as omapfb thinks no one is using it, and then fb console
>> tries to touch the fb.
>>
>=20
> What about refusing those calls from fb console? So fb console will not=

> know about this problem and omapfb will just ignore drawn functions?

Hmm, I'm not sure I understand what you mean... omapfb is not drawing
anything, fbcon is doing the drawing independently to the fb. And the fb
suddenly disappears without fbcon realizing that.

>> omapfb tracks mmaps from userspace, and refuses to free a fb it it's
>> mmapped.
>>
>> I don't know how to fix it straight away. Maybe there's a way for omap=
fb
>> to check if the fbcon uses the fb in question, and if so, refuses to
>> release/resize the memory.
>>
>>  Tomi
>>
>=20
> Maemo userspace (on Nokia N900) uses above commands to initialize
> graphic and Xserver. So it would be nice if disabling framebuffer would=

> work even if fbcon.ko is loaded (or compiled directly into zImage).

Ok. And N900 has fbcon enabled? I wonder how it survives...

fbcon can be unbound from userspace with something like:

echo 0 > /sys/class/vtconsole/vtcon1/bind

After that I think the memory can be freed.

But obviously the kernel should not crash here, no question about that.

 Tomi


--EAGKAipAvqRcWFEjknQUX6SoFgRrptc4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1uy1AAoJEPo9qoy8lh717mMQAJIr6z9Om0WWHyoda6FEF5Se
ynBZ1wGX8atx8lcFMwLJl8KJHFVfQe3krwVaPh13b4tj4PRFiIh3Al7+HqezO1Ku
7c6/nPRvhNFHBm71OtDR4lcsIGcrVQfyvZzT0tF4EVI9zumu8xcJ+tSL59CE+bKx
5pT7p6SwdzXVZp/KRGXuJ/qBAjQnQCLGJAKDfCgkxvoLuW4FCockSRlCbbacMut6
H2P4dGhn+ILTrO3JJXJwWaoaug/S/wXi0nH7BjGcNElZvTX8re9ZHCNw/YafDd7O
cLeFOhDOzKx4LySEcQmnj0BLOuC89IzuRRTcQMmA9bCAjdkJt7HcXufwFC0eJNrq
UDrcgDS9KDLgjlOq6vGEFtwW3SBpnvzQcFwHkVVz6xXSiJKhwGR4fKOuxW/oXmRD
N1nvT2f9A90JKIKygBLMNUVLDURJ5fCK5asgEDGDZ2ockRy18JXJz+39WhC1R8ML
jfGbRI8sWY9ZpZlki1byPmFbsDHbqydsukx4oGPvaJ2qzfTGc56EjpzKkXcWTXyU
cu8NjMnvvuA2J2UvnABAximdB5niTMYhInw3IxwsMKFtJY5+IqpCteRAyivNwJg3
qhOqcBFg+/pizPZZkqHkThgk9ZgOkt+YYXugTYveFNLGQNO0cd/JDNn+cKXhKIWt
chRQjhu4p7FJxezwWid6
=gAkY
-----END PGP SIGNATURE-----

--EAGKAipAvqRcWFEjknQUX6SoFgRrptc4F--
