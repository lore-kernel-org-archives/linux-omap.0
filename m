From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta
	serial keyboard port
Date: Fri, 11 Dec 2009 00:01:28 -0800
Message-ID: <20091211080128.GD30274@core.coreip.homeip.net>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <200912110410.00123.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200912110410.00123.jkrzyszt@tis.icnet.pl>
Sender: linux-input-owner@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, e3-hacking@earth.li
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 11, 2009 at 04:09:58AM +0100, Janusz Krzysztofik wrote:
> Friday 11 December 2009 03:36:58 Dmitry Torokhov napisa=C5=82(a):
> > On Thu, Dec 10, 2009 at 09:07:50PM +0100, Janusz Krzysztofik wrote:
> > > +
> > > +/*
> > > + * This table converts the amstrad mailboard scancodes to normal=
 PC-
> > > AT scancodes
> > > + * The diagram below shows the amstrad keyboard, with the raw
> > > scancodes
> > > + *
> > > + *   (70) (7A) (46) (7C) (77)   Amstrad     (72) (69) (1A) (2A)
> > > (1C) (15)
> > > + * [  71][1:74][2:73][3:6B][4:22][5:1B][6:1D][7:1E][8:79][9:7D]
> > > [0:75][  6C]
> > > + *  [Q:21][W:23][E:24][R:26][T:52][Y:5D][U:0D][I:0E][O:32][P:34]=
  |
> > > return|
> > > + *   [A:31][S:33][D:35][F:36][G:29][H:5B][J:03][K:76][L:3A][@:3B=
]
> > >
> > > |   2C|
> > >
> > > + *  [  3C][Z:3D][X:4E][C:54][V:0B][B:05][N:41][M:42][.:43][  3E]
> > > [  55]
> > > + *  [  83][  06][  49][           4B         ][,:44][  16][  2E]
> > > [  09]
> > > + *
> > > + * These scancodes are then translated to AT scancodes using the
> > > following table
> > > + * The amstrad keyboard does not produce any extended scancodes,
> > > but we need to
> > > + * translate some amstrad scancodes to a AT extended scancode,
> > > hence the 16bit
> > > + * value for the translated scancode
> > > + *
> >
> > No, please write a proper keyboard driver instead of creating this
> > Frankenstain monster. It is not a generic serio-style data source s=
o it
> > should not use serio, should reside in drivers/input/keyboard and c=
reate
> > input device by itself.
> >
> > Thanks.
>=20
> Hi Dmitry,
>=20
> Thanks for your opinion.
>=20
> Lack of support for Amstrad Delta external keybord is not a problem f=
or me,=20
> since I use the machine as an IP phone, not a network terminal. I jus=
t=20
> thought it would be nice for other users to have this old but perfect=
ly=20
> working driver integrated into the mainline. But if it is that bad as=
 you=20
> say, I have no problem with dropping it.
>=20
> I'll see if I'm able to create a proper driver myself when I find som=
e spare=20
> time.

Yes, that would be great, thank you. In fact it should end up about the
same as this driver, except instead of creating and registering serio
port you will need to register input_dev structure and instead of
translating into atkbd scancodes you need to translate directly into
Linux keycodes (KEY_A, KEY_1 and so on).

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
