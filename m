From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: omapdss: Division by zero in kernel
Date: Fri, 24 Jul 2015 18:03:42 +0200
Message-ID: <201507241803.42891@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1609956.yA967ILsQD";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--nextPart1609956.yA967ILsQD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

when on N900 (real HW or qemu) I run this command

/ # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0 > /sy=
s/class/graphics/fb0/size

then kernel crash with this error message

/ # [   29.904113] Division by zero in kernel.
** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__aeabi_uid=
ivmod) from [<c022071c>]=20
(cfb_imageblit+0xac/0x464)
** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbcon_scrol=
l) from [<c025af90>] (scrup+0x60/0x128)
** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbcon_redra=
w.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fbcon_redr=
aw.isra.12) from [<c0218ed0>]=20
(fbcon_scroll+0x6a0/0xcbc)
** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fbcon_scro=
ll) from [<c025af90>] (scrup+0x60/0x128)

I suspect that problem is in omapdss.

I do not know if size 0 make sense, but Maemo userspace is calling above
commands and on Nokia's 2.6.28 kernel there is no crash or error message.

IMHO Division by zero in kernel should not be there even if userspace
call "incorrect" command.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1609956.yA967ILsQD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWyYd4ACgkQi/DJPQPkQ1JDZQCgwPOH8YzfeGMxGeiagvpuVQFY
ycoAn3LHUR3eQMWXDmLQfC1YY1U0AEXd
=H5AP
-----END PGP SIGNATURE-----

--nextPart1609956.yA967ILsQD--
