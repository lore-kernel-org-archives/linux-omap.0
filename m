From: Tony Lindgren <tony@atomide.com>
Subject: Re: Missing OMAP PM layer
Date: Mon, 25 Jan 2016 08:34:42 -0800
Message-ID: <20160125163442.GU19432@atomide.com>
References: <201601242123.58871@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201601242123.58871@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [160124 12:24]:
> Hello,
>=20
> make menuconfig allows me to choose "OMAP PM layer selection" and the=
=20
> only one option is CONFIG_OMAP_PM_NOOP "No-op/debug PM layer".
>=20
> What does it mean? Power manager is noop?
>=20
> I see that it has only two corresponding files in mainline kernel:
> arch/arm/mach-omap2/omap-pm.h
> arch/arm/mach-omap2/omap-pm-noop.c
>=20
> Nokia's kernels (for N900 and N950) had also:
> arch/arm/mach-omap2/omap-pm-srf.c
>=20
> Can somebody explain it what happened with omap power management?
>=20
> Looks like that omap-pm.h provides some API, but the only implementat=
ion=20
> is noop which do nothing.

I believe none of that is needed any longer in mainline.

Kevin, care to descrbibe what should be done here?

Regards,

Tony
