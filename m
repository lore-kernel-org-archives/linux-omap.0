From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Thu, 21 Apr 2016 15:04:50 +0200
Message-ID: <20160421130450.GQ29406@pali>
References: <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd>
 <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160417175539.GA502@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 17 April 2016 19:55:40 Pavel Machek wrote:
> Hi!
>=20
> > > > > > Ok, it works now. I was doing tests in daylight so it was p=
oorly
> > > > > > visible. The right part of keyboard stays lit (but that's e=
xpected
> > > > > > AFAICT), but the left part blinks.
> > > > >=20
> > > > > During idle, both should go off and are doing so for me. Both=
 LEDs off
> > > > > indicates off mode, left LED off is for retention mode. So yo=
u still
> > > > > have something blocking off mode, maybe check:
> > > > >=20
> > > > > echo 1 > /sys/kernel/debug/pm_debug/enable_off_mode
> > > >=20
> > > > What is the power difference between retention and off? I'm now=
 down
> > > > to cca 25mA, which should be around 50 hours standby time. Not =
ideal,
> > > > but should be usable.
> >=20
> > The 25mA sounds way too big to me even for retention mode, some
> > devices must be still on.
>=20
> Yes, cca 60mW.=20
>=20
> > The off mode makes a huge difference for standby time, it should cu=
t
> > down the total power consumption to something like 10+ mW with mode=
m
> > enabled. Aproximately the breakdown is roughly: 900 uW for omap, 5 =
mW
> > for memory and 5 or more for the modem. Sorry I don't know the exac=
t
> > numbers for the modem. But with 37xx torpedo, mainline kernel is
> > already getting very close to the 900 uW + 5 mW numbers for the CPU
> > module during idle measured from the ina219 shunt on the torpedo
> > devkit.
>=20
> CONFIG_HSI breaks power management completely, so power management
> with modem will be another topic. =20

Sebastian, any idea why power management does not work for HSI?

> > > > In the meantime, I found what is causing the rention mode to br=
eak for
> > > > me: CONFIG_HSI (aka wireless modem support). With HSI off, it s=
eems to work.
> > > >=20
> > > > I still get problems with the camera button, in config similar =
to
> > > > defconfig.  For some reason, I'm even getting (autorepeating) ^=
@ on
> > > > console. As long as I hold camera button down, I even get it in=
to off
> > > > mode for brief period.
> > >=20
> > > Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
> > > mode... once per screen blank, for about a second. (Does CONFIG_K=
EYBOARD_GPIO also cause
> > > problems for you?)
> > >=20
> > > Any idea why it enters off mode only once after each screenblank?
> >=20
> > After disabling CONFIG_PROVE_LOCKING, loading the LCD modules, and
> > blanking the screen, my n900 hits off mode just fine about once
> > a second. Sounds like you still have some extra devices enabled
> > causing it.
>=20
> I checked again... also with vanilla 4.6-rc2 to double check... same =
effect.
>=20
> Aha, got it... cat-ing /sys/kernel/debug/pm_debug/count breaks the
> off mode. If I don't do that (tm), it seems to work way better.

So what is result? Is power management working for CONFIG_KEYBOARD_GPIO=
?
Or problem is somewhere in CONFIG_PROVE_LOCKING?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
