From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/5] HSI: nokia-modem: drop support for disabled pm
Date: Mon, 8 Feb 2016 09:50:25 +0100
Message-ID: <20160208085025.GA30075@pali>
References: <1454203187-688-1-git-send-email-sre@kernel.org>
 <1454203187-688-5-git-send-email-sre@kernel.org>
 <201601311224.34249@pali>
 <20160131161052.GA16550@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160131161052.GA16550@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Sunday 31 January 2016 17:10:52 Sebastian Reichel wrote:
> Hi,
>=20
> On Sun, Jan 31, 2016 at 12:24:34PM +0100, Pali Roh=C3=A1r wrote:
> > On Sunday 31 January 2016 02:19:46 Sebastian Reichel wrote:
> > > Disabled power management means, that the driver can only be
> > > used together with further out-of-tree kernel patches. There
> > > is no reason to support this in the mainline kernel and not
> > > having support for it means, that userspace can automatically
> > > detect if we are running kernel based power management.
> >=20
> > I'm against this change. It will break support for (patched) Maemo =
and=20
> > proprietary Nokia sscd modem daemon.
>=20
> Do you have some links for this? So far my assumption was, that sscd
> requires /sys/devices/platform/gpio-switch, so you either need to
> patch sscd somehow, or patch the kernel to provide gpio-switch, or
> provide some kind of userspace wrapper.

I can either patch kernel to provide gpio-switch interface or use some
kind of user space hacks to provide this interface (e.g mount bind or
fuse fs mounted to that location).

> > Also you can export GPIOs manually via sysfs and touch that state. =
Which=20
> > means that you can do power management with mainline kernel even if=
 you=20
> > set nokia-modem.pm=3D0.
>=20
> Yeah... You export GPIOs manually. Did you actually try this? You

Yes, this is what preinit script is doing.

> will end up with exactly the same result as nokia-modem.pm=3D1, just
> with a few less symlinks. Also you have to make sure, that you
> actually exported the right gpios, since the global gpio number is
> dependent on the gpio-controller registration order.
>=20
> > So please drop this patch.
>=20
> Please provide facts, that Maemo can use pm=3D0 without additional
> kernel patches and does not work with pm=3D1.

Currently we use simple kernel driver which register gpio-switch
interface. Why to remove something which is 1) working and is 2) useful
for users & developers?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
