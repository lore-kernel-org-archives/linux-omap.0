From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: omapdss: Division by zero in kernel
Date: Wed, 26 Aug 2015 12:16:12 +0200
Message-ID: <20150826101612.GI27333@pali>
References: <201507241803.42891@pali>
 <55D6E466.5060706@ti.com>
 <20150821084807.GD27391@pali>
 <55D6ECB5.6010708@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55D6ECB5.6010708@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jyri Sarha <jsarha@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On Friday 21 August 2015 12:17:41 Tomi Valkeinen wrote:
>=20
>=20
> On 21/08/15 11:48, Pali Roh=C3=A1r wrote:
> > On Friday 21 August 2015 11:42:14 Tomi Valkeinen wrote:
> >>
> >>
> >> On 24/07/15 19:03, Pali Roh=C3=A1r wrote:
> >>> Hello,
> >>>
> >>> when on N900 (real HW or qemu) I run this command
> >>>
> >>> / # echo 0 > /sys/devices/platform/omapdss/overlay0/enabled && ec=
ho 0 > /sys/class/graphics/fb0/size
> >>>
> >>> then kernel crash with this error message
> >>>
> >>> / # [   29.904113] Division by zero in kernel.
> >>
> >=20
> > Hi! Thanks for explaining.
> >=20
> >> The problem is that fb console uses the kernel mmapped framebuffer=
, but
> >> omapfb is not aware of the fb console. So the above commands free =
the
> >> framebuffer, as omapfb thinks no one is using it, and then fb cons=
ole
> >> tries to touch the fb.
> >>
> >=20
> > What about refusing those calls from fb console? So fb console will=
 not
> > know about this problem and omapfb will just ignore drawn functions=
?
>=20
> Hmm, I'm not sure I understand what you mean... omapfb is not drawing
> anything, fbcon is doing the drawing independently to the fb. And the=
 fb
> suddenly disappears without fbcon realizing that.
>=20
> >> omapfb tracks mmaps from userspace, and refuses to free a fb it it=
's
> >> mmapped.
> >>
> >> I don't know how to fix it straight away. Maybe there's a way for =
omapfb
> >> to check if the fbcon uses the fb in question, and if so, refuses =
to
> >> release/resize the memory.
> >>
> >>  Tomi
> >>
> >=20
> > Maemo userspace (on Nokia N900) uses above commands to initialize
> > graphic and Xserver. So it would be nice if disabling framebuffer w=
ould
> > work even if fbcon.ko is loaded (or compiled directly into zImage).
>=20
> Ok. And N900 has fbcon enabled? I wonder how it survives...
>=20

Depends on compiled kernel. Original stock Nokia kernel 2.6.28 has it
disabled, but when I recompiled it with fbcon (either static linked int=
o
zImage or external fbcon.ko) it works and I do not see any problem.

So I think it survives...

> fbcon can be unbound from userspace with something like:
>=20
> echo 0 > /sys/class/vtconsole/vtcon1/bind
>=20
> After that I think the memory can be freed.
>=20
> But obviously the kernel should not crash here, no question about tha=
t.
>=20
>  Tomi
>=20

Maybe just adding that test for zero to prevent division by zero?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
