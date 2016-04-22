From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 retention mode in v4.6, camera buttons fun
Date: Fri, 22 Apr 2016 09:05:11 +0200
Message-ID: <20160422070511.GW29406@pali>
References: <20160407234134.GQ16484@atomide.com>
 <20160411093023.GC11814@amd>
 <20160411094130.GA5753@amd>
 <20160411211026.GH5995@atomide.com>
 <20160412121658.GA32486@amd>
 <20160412123013.GA12296@amd>
 <20160412163055.GP5995@atomide.com>
 <20160417175539.GA502@amd>
 <20160421130450.GQ29406@pali>
 <20160421212808.GA31979@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160421212808.GA31979@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Tomi Valkeinen <tomi.valkeinen@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thursday 21 April 2016 23:28:08 Pavel Machek wrote:
> Hi!
>=20
> > > CONFIG_HSI breaks power management completely, so power managemen=
t
> > > with modem will be another topic. =20
> >=20
> > Sebastian, any idea why power management does not work for HSI?
> >=20
> > > > > > In the meantime, I found what is causing the rention mode t=
o break for
> > > > > > me: CONFIG_HSI (aka wireless modem support). With HSI off, =
it seems to work.
> > > > > >=20
> > > > > > I still get problems with the camera button, in config simi=
lar to
> > > > > > defconfig.  For some reason, I'm even getting (autorepeatin=
g) ^@ on
> > > > > > console. As long as I hold camera button down, I even get i=
t into off
> > > > > > mode for brief period.
> > > > >=20
> > > > > Ok, if I turn off CONFIG_KEYBOARD_GPIO, I get it into off
> > > > > mode... once per screen blank, for about a second. (Does CONF=
IG_KEYBOARD_GPIO also cause
> > > > > problems for you?)
> > > > >=20
> > > > > Any idea why it enters off mode only once after each screenbl=
ank?
> > > >=20
> > > > After disabling CONFIG_PROVE_LOCKING, loading the LCD modules, =
and
> > > > blanking the screen, my n900 hits off mode just fine about once
> > > > a second. Sounds like you still have some extra devices enabled
> > > > causing it.
> > >=20
> > > I checked again... also with vanilla 4.6-rc2 to double check... s=
ame effect.
> > >=20
> > > Aha, got it... cat-ing /sys/kernel/debug/pm_debug/count breaks th=
e
> > > off mode. If I don't do that (tm), it seems to work way better.
> >=20
> > So what is result? Is power management working for CONFIG_KEYBOARD_=
GPIO?
>=20
> camera and unlock button GPIOs seem to break the powermanagement,
> too. I disabled it for now.

So this sounds like a problem in gpio keyboard driver. Maybe you can
ping maintainers of that driver?

> Next hint I got from Sebastian was that I may need to enable power
> management in /sys.
>=20
> pavel@n900:/my/tui/ofone$ cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/runt=
ime_status
> active
> pavel@n900:/my/tui/ofone$ cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/auto=
suspend_delay_ms
> cat:
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/auto=
suspend_delay_ms:
> Input/output error
> root@n900:/my/tui/ofone# cat
> /sys/devices/platform/68000000.ocp/48058000.ssi-controller/power/cont=
rol
> auto
>=20
> I could not get it to sleep :-(.
>=20
> Best regards,
> 								Pavel
>=20

Maybe down phonet0 interface and other hsi/ssi interfaces?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
