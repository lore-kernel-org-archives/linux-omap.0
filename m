From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900: musb is in wrong state after boot
Date: Thu, 21 Jan 2016 09:40:07 +0100
Message-ID: <20160121084007.GN7192@pali>
References: <201601091616.04193@pali>
 <20160119203314.GE19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160119203314.GE19432@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Sebastian Reichel <sre@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Nishanth Menon <nm@ti.com>, joerg Reisenweber <joerg@openmoko.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 19 January 2016 12:33:15 Tony Lindgren wrote:
> Hi,
>=20
> * Pali Roh=C3=A1r <pali.rohar@gmail.com> [160109 07:16]:
> > Hello,
> >=20
> > when I boot 4.4.0-rc7+ kernel compiled with g_nokia into zImage on =
Nokia=20
> > N900 into userspace then usb gadget (g_nokia) does not work. Notebo=
ok,=20
> > connected on other side does not see any usb device... Connecting a=
nd=20
> > disconnecting cable does not change anything, still not work.
> >=20
> > But if I run this command
> > $ echo peripheral > /sys/bus/platform/devices/musb-hdrc.0.auto/mode=
=20
>=20
>=20
> > then gadget starts working. Other side see usb device and can use i=
t.=20
> > Also connecting and disconnecting usb cable working fine. After=20
> > connecting it again, usb device OK.
>=20
> N900 had the PHY interrupt wired to the bq chip instead of twl4030, r=
ight?

I do not know now. I tried to find it in N900 schemantics, but do not
see it.

CCing Joerg, do you know?

> You can fix this issue similar to phy-twl4030-usb.c. In function
> twl4030_phy_power_on() we call schedule_delayed_work() that checks
> the state of the ID pin on boot up.

I looked at that code, but do not see what and how can be fixed :-(

> I think that's only needed for the i2c based PHY's with MUSB, with
> the others the USB driver has a better idea of the current state.
>=20
> Regards,
>=20
> Tony

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
