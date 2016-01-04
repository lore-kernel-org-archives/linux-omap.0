From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: twl4030-power different data in DTS and board code
Date: Mon, 4 Jan 2016 08:50:39 -0800
Message-ID: <20160104165039.GB12777@atomide.com>
References: <201601021513.32814@pali>
 <20160102171430.GC12622@atomide.com>
 <201601022239.27379@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601022239.27379@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machel <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160102 13:39]:
> On Saturday 02 January 2016 18:14:31 Tony Lindgren wrote:
>=20
> > The n900 specific code was based on something before the TI generic
> > values were available I think. And the last time I looked at it I
> > came to the conclusion the n900 specific code is no better.
>=20
> Hm... if generic values are better, why old values are still there (i=
n=20
> board n900 code)?

We never had PM working in a generic way for the legacy booting but
relied on board specific configuration instead for the ones that did
work. Probably not worth changing the board-*.c file configuration
unless you want to test that the new generic settings work.

> > Or did I miss something? Are you seeing some issues with PM with dt=
s
> > based code?
>=20
> I'm just asking why we have different code for DST and board...

OK. Yeah no reason beyond somebody taking the time to verify that the
generic settings work on n900 in legacy booting mode :)

> > We can certainly add it to twl4030-power if it provides something
> > that the "ti,twl4030-power-idle-osc-off" does not.
>=20
> But do we need 'compatible =3D "ti,twl4030-power-n900"' specification=
 in=20
> omap3-n900.dts file at all?

Well that generally done to allow adding support for the board specific
configuration if needed with a fallback to the generic configuration.
That's used quite a bit, for example boards typically set the compatibl=
e
to the specific board but still end up booting with a generic one
sucha as "ti,omap3".

Regards,

Tony
