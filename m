From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta
	serial keyboard port
Date: Sat, 12 Dec 2009 15:20:03 -0800
Message-ID: <20091212232003.GA16760@core.coreip.homeip.net>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <200912110410.00123.jkrzyszt@tis.icnet.pl> <20091211080128.GD30274@core.coreip.homeip.net> <200912122134.08795.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51609 "HELO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S935252AbZLMB4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Dec 2009 20:56:35 -0500
Received: by pwj9 with SMTP id 9so1298196pwj.21
        for <linux-omap@vger.kernel.org>; Sat, 12 Dec 2009 17:56:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200912122134.08795.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li

Hi Janusz,

On Sat, Dec 12, 2009 at 09:34:07PM +0100, Janusz Krzysztofik wrote:
> Friday 11 December 2009 09:01:28 Dmitry Torokhov napisa=C5=82(a):
> > On Fri, Dec 11, 2009 at 04:09:58AM +0100, Janusz Krzysztofik wrote:
> > > Friday 11 December 2009 03:36:58 Dmitry Torokhov napisa=C5=82(a):
> > > > On Thu, Dec 10, 2009 at 09:07:50PM +0100, Janusz Krzysztofik wr=
ote:
> > > > > +
> > > > > +/*
> > > > > + * This table converts the amstrad mailboard scancodes to no=
rmal PC-
> > > > > AT scancodes
> > > > > + * The diagram below shows the amstrad keyboard, with the ra=
w
> > > > > scancodes
> > > > > + *
> > > > > + *   (70) (7A) (46) (7C) (77)   Amstrad     (72) (69) (1A) (=
2A)
> > > > > (1C) (15)
> > > > > + * [  71][1:74][2:73][3:6B][4:22][5:1B][6:1D][7:1E][8:79][9:=
7D]
> > > > > [0:75][  6C]
> > > > > + *  [Q:21][W:23][E:24][R:26][T:52][Y:5D][U:0D][I:0E][O:32][P=
:34]  |
> > > > > return|
> > > > > + *   [A:31][S:33][D:35][F:36][G:29][H:5B][J:03][K:76][L:3A][=
@:3B]
> > > > >
> > > > > |   2C|
> > > > >
> > > > > + *  [  3C][Z:3D][X:4E][C:54][V:0B][B:05][N:41][M:42][.:43][ =
 3E]
> > > > > [  55]
> > > > > + *  [  83][  06][  49][           4B         ][,:44][  16][ =
 2E]
> > > > > [  09]
> > > > > + *
> > > > > + * These scancodes are then translated to AT scancodes using=
 the
> > > > > following table
> > > > > + * The amstrad keyboard does not produce any extended scanco=
des,
> > > > > but we need to
> > > > > + * translate some amstrad scancodes to a AT extended scancod=
e,
> > > > > hence the 16bit
> > > > > + * value for the translated scancode
> > > > > + *
> > > >
> > > > No, please write a proper keyboard driver instead of creating t=
his
> > > > Frankenstain monster. It is not a generic serio-style data sour=
ce so it
> > > > should not use serio, should reside in drivers/input/keyboard a=
nd
> > > > create input device by itself.
> > >
> > > I'll see if I'm able to create a proper driver myself when I find=
 some
> > > spare time.
> >
> > Yes, that would be great, thank you. In fact it should end up about=
 the
> > same as this driver, except instead of creating and registering ser=
io
> > port you will need to register input_dev structure and instead of
> > translating into atkbd scancodes you need to translate directly int=
o
> > Linux keycodes (KEY_A, KEY_1 and so on).
>=20
> Dmitry,
>=20
> Thanks for your directions. However, before I get to work, please let=
 me still=20
> better understand what I am really supposed to create here, and why y=
ou think=20
> it should be done one way and not the other. I'd rather avoid submitt=
ing an=20
> input related code that you might find not adequate in the future.
>=20
> First, I have never submitted a single line of code that would be acc=
epted for
> inclusion into drivers/input before. Could you please recommend a
> documentation for me to read, from where I could learn what a proper =
keyboard=20
> driver should look like,

I guess I meant "proper keyboard driver" in the sense of a driver that
creates and registeres its own input_dev and perform direct translation
of data coming form hardware into linux input events.

>  and what kind of devices can be considered as generic=20
> serio-style data sources and what can't, and more?=20

If a same device can be used on different platforms and several devices
may use the same port then I can see the need of creating a serio
abstraction. But if tere is 1:1 relationship then a driver that attache=
s
directly to the hardware might make sense.

> Or should I better give up=20
> being that short of required knowledge?
>=20
> Moreover, please have a look at these two messages posted by Cliff La=
wson, who=20
> worked for Amstrad while the E3 (codename Delta) was being developed,=
 being=20
> involved in that development:
>=20
> http://www.earth.li/pipermail/e3-hacking/2006-April/000445.html
> http://www.earth.li/pipermail/e3-hacking/2006-April/000449.html
>=20
> As one can read, the Amstrad Delta keyboard was described by Cliff as=
 a PS/2=20
> device, even if not connected to a regular PS/2 port but some MPU GPI=
O lines=20
> directly instead.
>=20
> Furthermore, it has been proven by Matt Callow, who created the serio=
 driver=20
> you didn't like, that the atkbd keyboard driver already works fine fo=
r this=20
> keyboard if fed with scancodes matching what it is told to expect.

Of course atkbd would work fine if it is fed the data it expects. The
same can be said for any driver in the tree, isn't it? It is possible
to write HID-to-atkbd or "gpio matrix to atkbd" "serios" but that does
not mean it is the right thing to do.

>=20
> Please also note that the E3 keyboard port is supposed to be used not=
 only for=20
> getting input from the keyboard, but from a bundled gamepad as well. =
Not yet=20
> supported, but who knows if forever.

Can they be used simultaneously? Would not the translation that you
perform right now cause issues with the gamepad? Are you thinking about
reusing one of the existing gamepad modules in the same fashion as you
do for atkbd but translating the data into its native format?

>=20
> That said, do you still think there is a need to create a new, separa=
te=20
> keyboard driver for the device in question? Isn't reusing an existing=
, proven=20
> to be working correctly, keyboard driver module, isn't it a good solu=
tion=20
> here? If not, could you please elaborate on why it's not? I always th=
ought=20
> that being PS/2 compatible is enough for a device to be considered as=
=20
> supported by atkbd, but maybe I just don't understand what the atkbd =
driver is=20
> designed for and what a supported device should look like.

atkbd is supposed to support PS/2 devices speaking AT keyboard protocol=
=2E
We also do support such devices behind dumb controllers that do not
allow querying the device but we expect those to at least produce the
standard scancodes.

>=20
> Moreover, isn't a port, that is supposed to interact with at least tw=
o=20
> distinct input devices, isn't it worth of creating a separate driver =
for it,=20
> be it serio module or anything else that would better match the input=
 subsystem=20
> design?

Yes, if there can be several devices connected to it then it makes sens=
e
to create a port abstraction for different drivers to plug into.

>=20
> In your initial answer, you quoted a part of the patch, namely that c=
ontaining=20
> a description of the driver's scancode translation functionality. I g=
uess you=20
> tried to say that traslating scancodes inside a port driver is wrong.=
 I would=20
> agree with that, without any reservations.

Yes, exactly.

>=20
> But for your other conclusions, could you please reconsider if still =
valid,=20
> and elaborate on them if you think they are?
>=20

I would need to know a bit more about the gamepad, but so far I still
think that current attempot of creating intermediate serio module which
allows to use atkbd driver is not the proper solution.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
