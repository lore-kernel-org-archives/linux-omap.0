From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Fri, 21 Aug 2015 10:48:07 +0200
Message-ID: <20150821084807.GD27391@pali>
References: <201507241803.42891@pali>
 <55D6E466.5060706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D6E466.5060706@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Friday 21 August 2015 11:42:14 Tomi Valkeinen wrote:
>=20
>=20
> On 24/07/15 19:03, Pali Roh=C3=A1r wrote:
> > Hello,
> >=20
> > when on N900 (real HW or qemu) I run this command
> >=20
> > / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && echo=
 0 > /sys/class/graphics/fb0/size
> >=20
> > then kernel crash with this error message
> >=20
> > / # [   29.904113] Division by zero in kernel.
>=20

Hi! Thanks for explaining.

> The problem is that fb console uses the kernel mmapped framebuffer, b=
ut
> omapfb is not aware of the fb console. So the above commands free the
> framebuffer, as omapfb thinks no one is using it, and then fb console
> tries to touch the fb.
>=20

What about refusing those calls from fb console? So fb console will not
know about this problem and omapfb will just ignore drawn functions?

> omapfb tracks mmaps from userspace, and refuses to free a fb it it's
> mmapped.
>=20
> I don't know how to fix it straight away. Maybe there's a way for oma=
pfb
> to check if the fbcon uses the fb in question, and if so, refuses to
> release/resize the memory.
>=20
>  Tomi
>=20

Maemo userspace (on Nokia N900) uses above commands to initialize
graphic and Xserver. So it would be nice if disabling framebuffer would
work even if fbcon.ko is loaded (or compiled directly into zImage).

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
