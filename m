From: Tony Lindgren <tony@atomide.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 09:41:46 -0800
Message-ID: <20160121174146.GK19432@atomide.com>
References: <201601091616.04193@pali>
 <20160119203314.GE19432@atomide.com>
 <20160121084007.GN7192@pali>
 <2300247.VhtcKLq8UC@saturn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2300247.VhtcKLq8UC@saturn>
Sender: linux-kernel-owner@vger.kernel.org
To: joerg Reisenweber <joerg@openmoko.org>
Cc: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* joerg Reisenweber <joerg@openmoko.org> [160121 02:30]:
> On Thu 21 January 2016 09:40:07 Pali Roh=C3=A1r wrote:
> > On Tuesday 19 January 2016 12:33:15 Tony Lindgren wrote:
> > > Hi,
> > >=20
> > > * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160109 07:16]:
> > > > Hello,
> > > >=20
> > > > when I boot 4.4.0-rc7+ kernel compiled with g_nokia into zImage=
 on Nokia
> > > > N900 into userspace then usb gadget (g_nokia) does not work. No=
tebook,
> > > > connected on other side does not see any usb device... Connecti=
ng and
> > > > disconnecting cable does not change anything, still not work.
> > > >=20
> > > > But if I run this command
> > > > $ echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/=
mode
> > > >=20
> > > >=20
> > > > then gadget starts working. Other side see usb device and can u=
se it.
> > > > Also connecting and disconnecting usb cable working fine. After
> > > > connecting it again, usb device OK.
> > >=20
> > > N900 had the PHY interrupt wired to the bq chip instead of twl403=
0, right?
>=20
> which interrupt? I'll try to answer based on assumptions: 1707 PHY co=
nnects to=20
> bq24150 charger via CHRG_DET signal.
> I guess you're talking about the VBUS detection which is done in twl4=
030 VBUS-
> pin R8.

Right, I'm confusing things a bit here. If the VBUS detection is done i=
n
twl4030, then it should notify the USB subsystem. But on n900 the USB
phy is not ti,twl4030-usb, it's the 1707 instead.

So my guess is that in drivers/phy/phy-twl4030-usb.c the interrupt neve=
r
gets enabled as the PHY driver never gets probed?

Then for supporting the USB host mode.. We should add regulator support
to the USB PHY driver so if the ID pin is grounded, the PHY driver enab=
les
the VBUS regulator. That too seems to need some coordination between th=
e
drivers/phy/phy-twl4030-usb.c and 1707 driver if the ID pin interrupt i=
s
only detected in drivers/phy/phy-twl4030-usb.c.

> N900 PHY (1707) is connected to musb core via ULPI=20
> (https://www.mentor.com/products/ip/usb/usb20otg/phy_interfaces), it =
has no=20
> I2C interface and no other IRQ than what's implemented in (normally p=
owered-
> down?) ULPI already.
> I guess the problem in this case is along the USB VBUS and ID pin A/B=
 OTG=20
> detection: the USB jack's ID pin is _not_ connected to the PHY in N90=
0 but=20
> rather is connected to TWL4030 aka GAIA ID pin R11 which afaik is par=
t of the=20
> otherwise unused (except VBUS detection?) PHY in TWL4030.=20
> It seems to me the actually used PHY 1707 does not support ID, neithe=
r does it=20
> support a dedicated IRQ line for VBUS.

Yes so it seems.

> Generally musb-core and buses should be suspended/off by default, for=
 energy=20
> conservation reasons (seemingly ~40mA on Vbatt!), and only get enable=
d when=20
> twl4030 detects +5V on VBUS (also before my hostmode botch tries to t=
alk to=20
> the musb core debug registers which needs to happen before VBUS gets =
applied)

I also think there's also some related twl4030 errata where it's
recommended the USB PHY is in suspend mode instead of disabled.

Regards,

Tony
