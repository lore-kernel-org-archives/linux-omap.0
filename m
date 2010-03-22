From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [RFC][PATCH 4/5] input: serio: add support for Amstrad Delta serial keyboard port
Date: Mon, 22 Mar 2010 22:07:47 +0100
Message-ID: <201003222207.48707.jkrzyszt@tis.icnet.pl>
References: <D615D960-7E56-492A-9CA0-BA66CF3AAF9B@gmail.com> <20091212232003.GA16760@core.coreip.homeip.net> <200912140111.36458.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <200912140111.36458.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

(dropping Tony and e3-hacking for now)

Monday 14 December 2009 01:11:34 Janusz Krzysztofik wrote:
> Hi Dmitry,
>
> Sunday 13 December 2009 00:20:03 Dmitry Torokhov napisa=C5=82(a):
> > atkbd is supposed to support PS/2 devices speaking AT keyboard prot=
ocol.
> > We also do support such devices behind dumb controllers that do not
> > allow querying the device but we expect those to at least produce t=
he
> > standard scancodes.
>
> As far as I can understand, using the atkbd driver is not a good idea=
 in
> this case because of the keyboard not producing standard scancodes,
> correct?
>
> Isn't the hpps2atkbd.h provided keycode table an already supported wa=
y of
> introducing exceptions to this standard scancodes requirement? Why co=
uldn't
> this method be reused here?
>
> What I am afraid of is if the driver supposed to be created instead
> wouldn't require reiplementing most of the atkbd code.
>
> > I would need to know a bit more about the gamepad, but so far I sti=
ll
> > think that current attempot of creating intermediate serio module w=
hich
> > allows to use atkbd driver is not the proper solution.
>
> I modified the serio driver to send exactly what it gets from the buf=
fer
> and examined its output with serio_raw. The gamepad (can be connected
> simultaneously) appeared to send exactly the same scancodes as the ke=
yboard
> did. I couldn't see how those might be destinguished whether coming f=
rom
> the keybord or from the gamepad. Thus, handling them both together as=
 a
> single device would probably be the only option here.
>
> With both devices connected and keys pressed simultaneously, errors o=
ccure
> at the lowest level: parity check failed, invalid stop bit, etc. I do=
n't
> think it would be possible to do anything about this. But this also m=
eans
> that trying to query them in order to get a sensible response would
> probably be not reliable.
>
> Any thoughts?
>
> Thanks,
> Janusz

Hi Dmitry,

You probably missed my last message.

Meanwhile, I've connected the Amstrad Delta keyboard to a PC. I can con=
firm it=20
speaks PS/2 protocol and is automatically detected by atkbd/i8042 drive=
rs.=20
The initial handshake sequence actually looks exactly the same as that =
of a=20
standard AT keyboard. The problem persists about different scancodes, g=
iving=20
wrong keystrokes.

OTOH, the Amstrad Delta gamepad seems simplified. Connected alone to a =
PC,=20
works as well but only when i8042.dumbkbd is set. However, when both de=
vices=20
are connected in parallel, initial keyboard handshake allows for both b=
eing=20
used (not simultaneously) in default 2-way i8042 mode.

Resuming, if there were a boot/module option to atkbd allowing for non-=
default=20
scancode table, or another similiar possibility, both devices would wor=
k with=20
a PC using exsisting drivers.

Even if the chance of anyone using this tiny keyboard with a PC is rath=
er low,=20
do you still suggest that creating a new, standalone keyboard driver fo=
r it=20
is a good idea?

Thanks,
Janusz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
