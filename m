From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] add omap34xx temperature monitoring support
Date: Fri, 26 Dec 2014 08:31:16 -0800
Message-ID: <20141226163115.GA2411@atomide.com>
References: <20141226102933.GA28778@amd>
 <20141226155456.GB12409@atomide.com>
 <20141226161757.GD12409@atomide.com>
 <201412261726.35668@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201412261726.35668@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

* Pali Roh=C3=A1r <pali.rohar@gmail.com> [141226 08:29]:
> On Friday 26 December 2014 17:17:57 Tony Lindgren wrote:
> > > > +
> > > > +#include "../../arch/arm/mach-omap2/control.h"
> > >=20
> > > No need to do this, you can use syscon here like
> > > pbias-regulator.c is doing.
> >=20
> > Oh looks like you're already using syscon, nice. What defines
> > do you need from control.h?
> >=20
> > Those should be in the driver if private to the driver, or
> > else we should have some minimal header in include/linux
> > somewhere if some control.h defines really need to be
> > exposed.
> >=20
> > Regards,
> >=20
> > Tony
>=20
> Hi Tony,
>=20
> Sebastian Reichel has already sent new version of temperature=20
> driver. See email thread with subject:
>=20
> [PATCH 0/3] OMAP3 temperature sensor

Yeah great, looks like I was also reading Sebastian's patch
with the syscon comments above :)

Regards,

Tony
