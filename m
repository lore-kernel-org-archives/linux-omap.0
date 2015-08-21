From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Fri, 21 Aug 2015 11:42:14 +0300
Message-ID: <55D6E466.5060706@ti.com>
References: <201507241803.42891@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3fXiekjU5QQHo2X9se3IiX54UKFeu3Jig"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507241803.42891@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--3fXiekjU5QQHo2X9se3IiX54UKFeu3Jig
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24/07/15 19:03, Pali Roh=C3=A1r wrote:
> Hello,
>=20
> when on N900 (real HW or qemu) I run this command
>=20
> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0 >=
 /sys/class/graphics/fb0/size
>=20
> then kernel crash with this error message
>=20
> / # [   29.904113] Division by zero in kernel.

The problem is that fb console uses the kernel mmapped framebuffer, but
omapfb is not aware of the fb console. So the above commands free the
framebuffer, as omapfb thinks no one is using it, and then fb console
tries to touch the fb.

omapfb tracks mmaps from userspace, and refuses to free a fb it it's
mmapped.

I don't know how to fix it straight away. Maybe there's a way for omapfb
to check if the fbcon uses the fb in question, and if so, refuses to
release/resize the memory.

 Tomi


--3fXiekjU5QQHo2X9se3IiX54UKFeu3Jig
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1uRmAAoJEPo9qoy8lh71FzYP/1nBOv9YOJ+f8yCeXQMr4qFU
wZKpfElAmUeXP+9uWhKiXIsHENzaw0M1shR/UoTgE3oe7nreVke5/2X7zImGCnwd
Qk+AZpLtZQ6I1dsIw7+ya24H/7MSyDi+JHrdfVmjJfDePKikEREjr0oWbjLE02fy
fxN0ka2lVFvQKYPgKWq43OQhLeFIcFpcGkv0PfaYgdg93XZycdtgKiFs2NoGMyG7
tbhf4WvMx4ICwVtz1wqmrYJMh+x5sVAi5yNEZUTeZc5SO54OzyuVM2jo9ip3rgsz
y26ZrszRLIsNbhJDD1X00QtdWqXYfsgimpkvFBJJBgnvX2+cysGe/7g1FyzXoFRN
hqsR17T5AHe6kR99gVG9jftmFn7pEb3rRr2hUwvJ5nlJwiDTd9oYQS3GGt53SOQU
RGkcMbu4vJrLcFSk3PylwGsUKmKQEkaTXk/HCytyWm0dfR5ftvH4MMvT5Vq3l2pE
tP2sdEK5DtrBlyCWSSIDZVBaFNP4jxOAWV5K1rT41Grm9cJaMuYolpG2dzS7I69N
EcMG8u0hltXE43vKvDiFVzQwKYTyLvMV7+08h/zNWS71WurkI6qbZZWOubf/18mg
8oNjboIj1X0Z2MW3fHv62Casx2n+2xnOy3rEodlv/sQi5vL67WdGUL3LwCYaEZVX
2ZAuOL5o+ThndqBL8I2c
=HNet
-----END PGP SIGNATURE-----

--3fXiekjU5QQHo2X9se3IiX54UKFeu3Jig--
