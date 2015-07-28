From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Tue, 28 Jul 2015 13:56:02 +0200
Message-ID: <20150728115602.GL13765@pali>
References: <201507241803.42891@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507241803.42891@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Friday 24 July 2015 18:03:42 Pali Roh=C3=A1r wrote:
> Hello,
>=20
> when on N900 (real HW or qemu) I run this command
>=20
> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo 0=
 > /sys/class/graphics/fb0/size
>=20
> then kernel crash with this error message
>=20
> / # [   29.904113] Division by zero in kernel.
> ** 3375 printk messages dropped ** [   29.963836] [<c01e0008>] (__aea=
bi_uidivmod) from [<c022071c>]=20
> (cfb_imageblit+0xac/0x464)
> ** 8426 printk messages dropped ** [   30.111083] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8380 printk messages dropped ** [   30.258209] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7813 printk messages dropped ** [   30.400054] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7666 printk messages dropped ** [   30.538391] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7687 printk messages dropped ** [   30.676544] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 7960 printk messages dropped ** [   30.819915] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8317 printk messages dropped ** [   30.966979] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8590 printk messages dropped ** [   31.122528] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 8885 printk messages dropped ** [   31.287658] [<c0218ed0>] (fbcon=
_scroll) from [<c025af90>] (scrup+0x60/0x128)
> ** 9408 printk messages dropped ** [   31.461425] [<c02187a4>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 9787 printk messages dropped ** [   31.644287] [<c02187e8>] (fbcon=
_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10081 printk messages dropped ** [   31.833984] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10501 printk messages dropped ** [   32.031066] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10816 printk messages dropped ** [   32.233001] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10900 printk messages dropped ** [   32.440490] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.645233] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   32.848999] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10837 printk messages dropped ** [   33.053833] [<c02187a4>] (fbco=
n_redraw.isra.12) from [<c0218ed0>]=20
> (fbcon_scroll+0x6a0/0xcbc)
> ** 10838 printk messages dropped ** [   33.258361] [<c0218ed0>] (fbco=
n_scroll) from [<c025af90>] (scrup+0x60/0x128)
>=20
> I suspect that problem is in omapdss.
>=20
> I do not know if size 0 make sense, but Maemo userspace is calling ab=
ove
> commands and on Nokia's 2.6.28 kernel there is no crash or error mess=
age.
>=20
> IMHO Division by zero in kernel should not be there even if userspace
> call "incorrect" command.
>=20

PING! Any idea what to do with Division by zero in kernel?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
