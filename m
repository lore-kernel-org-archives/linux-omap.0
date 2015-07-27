From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: n900 in 4.2-rc0: repeating oopses
Date: Mon, 27 Jul 2015 09:12:04 +0200
Message-ID: <20150727071204.GA28038@pali>
References: <20150629091146.GA5103@amd>
 <20150630092404.GA19285@amd>
 <20150630095310.GF27720@pali>
 <20150701065932.GS4156@atomide.com>
 <20150701072255.GA17577@pali>
 <20150701095954.GD7969@amd>
 <20150701103421.GV4156@atomide.com>
 <20150701130903.GG7969@amd>
 <20150702061620.GY4156@atomide.com>
 <20150726223119.GA28514@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150726223119.GA28514@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

On Monday 27 July 2015 00:31:19 Pavel Machek wrote:
> On Wed 2015-07-01 23:16:21, Tony Lindgren wrote:
> > * Pavel Machek <pavel@ucw.cz> [150701 06:11]:
> > > On Wed 2015-07-01 03:34:22, Tony Lindgren wrote:
> > > >=20
> > > > Works for me after enabling the idle timeouts with the followin=
g
> > > > script and blanking the screen and disconnecting USB:
> > >=20
> > > Um. I'm forcing suspend with "echo mem > /sys/power/state" . (It
> > > worked in 4.1). That should just make it sleep, no autosuspend-re=
lated
> > > trickery... (But yes, I guess I should set up the leds and try
> > > autosuspend, too.)
> >=20
> > That too works just fine for me with omap2plus_defconfig after
> > echo enabled > /sys/class/tty/ttyO2/power/wakeup as I have n900
> > in my test rack.
>=20
> Going through that. AFAICT, you are not using devicetree on n900?
>=20
> CONFIG_MACH_NOKIA_RX51=3Dy
>=20
> Unfortunately, not having serials, it is tricky to get any output fro=
m
> that cnofiguration, so I don't know what I got wrong...
> 									Pavel

You can try to test it in qemu. It has emulation also of serial.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
