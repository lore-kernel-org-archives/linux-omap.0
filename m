From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta
 serial keyboard port
Date: Wed, 24 Mar 2010 09:16:04 -0700
Message-ID: <20100324161604.GA6338@core.coreip.homeip.net>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com>
 <20091212232003.GA16760@core.coreip.homeip.net>
 <200912140111.36458.jkrzyszt@tis.icnet.pl>
 <201003222207.48707.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f223.google.com ([209.85.220.223]:48047 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147Ab0CXQQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Mar 2010 12:16:19 -0400
Content-Disposition: inline
In-Reply-To: <201003222207.48707.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Mar 22, 2010 at 10:07:47PM +0100, Janusz Krzysztofik wrote:
> (dropping Tony and e3-hacking for now)
>=20
> Monday 14 December 2009 01:11:34 Janusz Krzysztofik wrote:
> > Hi Dmitry,
> >
> > Sunday 13 December 2009 00:20:03 Dmitry Torokhov napisa=C5=82(a):
> > > atkbd is supposed to support PS/2 devices speaking AT keyboard pr=
otocol.
> > > We also do support such devices behind dumb controllers that do n=
ot
> > > allow querying the device but we expect those to at least produce=
 the
> > > standard scancodes.
> >
> > As far as I can understand, using the atkbd driver is not a good id=
ea in
> > this case because of the keyboard not producing standard scancodes,
> > correct?
> >
> > Isn't the hpps2atkbd.h provided keycode table an already supported =
way of
> > introducing exceptions to this standard scancodes requirement? Why =
couldn't
> > this method be reused here?
> >
> > What I am afraid of is if the driver supposed to be created instead
> > wouldn't require reiplementing most of the atkbd code.
> >
> > > I would need to know a bit more about the gamepad, but so far I s=
till
> > > think that current attempot of creating intermediate serio module=
 which
> > > allows to use atkbd driver is not the proper solution.
> >
> > I modified the serio driver to send exactly what it gets from the b=
uffer
> > and examined its output with serio_raw. The gamepad (can be connect=
ed
> > simultaneously) appeared to send exactly the same scancodes as the =
keyboard
> > did. I couldn't see how those might be destinguished whether coming=
 from
> > the keybord or from the gamepad. Thus, handling them both together =
as a
> > single device would probably be the only option here.
> >
> > With both devices connected and keys pressed simultaneously, errors=
 occure
> > at the lowest level: parity check failed, invalid stop bit, etc. I =
don't
> > think it would be possible to do anything about this. But this also=
 means
> > that trying to query them in order to get a sensible response would
> > probably be not reliable.
> >
> > Any thoughts?
> >
> > Thanks,
> > Janusz
>=20
> Hi Dmitry,
>=20

Hi Janusz,

> You probably missed my last message.
>=20
> Meanwhile, I've connected the Amstrad Delta keyboard to a PC. I can c=
onfirm it=20
> speaks PS/2 protocol and is automatically detected by atkbd/i8042 dri=
vers.=20
> The initial handshake sequence actually looks exactly the same as tha=
t of a=20
> standard AT keyboard.

OK, since the device really speaks PS/2 protocol I withdraw my objectio=
n
of using serio + atkbd combo, however we should not be doing translatio=
n
in serio.

> The problem persists about different scancodes, giving=20
> wrong keystrokes.

This can be dealt with from userspace by loading correct keymap.

>=20
> OTOH, the Amstrad Delta gamepad seems simplified. Connected alone to =
a PC,=20
> works as well but only when i8042.dumbkbd is set. However, when both =
devices=20
> are connected in parallel, initial keyboard handshake allows for both=
 being=20
> used (not simultaneously) in default 2-way i8042 mode.
>=20
> Resuming, if there were a boot/module option to atkbd allowing for no=
n-default=20
> scancode table, or another similiar possibility, both devices would w=
ork with=20
> a PC using exsisting drivers.

You can train UDEV to load proper keymap. What does teh device report a=
s
'version' in sysfs (output of 'cat
/sys/bus/serio/devices/serio0/input/input3/id/bustype', please adjust
serioX and inputX to match yours)?

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
