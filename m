From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] thermal: consistently use int for temperatures
Date: Tue, 21 Jul 2015 09:31:11 +0200
Message-ID: <20150721073111.GH5161@pengutronix.de>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
 <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9hhd1zrc9yb.fsf@e105922-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

Hi Punit,

On Fri, Jul 17, 2015 at 12:14:36PM +0100, Punit Agrawal wrote:
> Hi Sascha,
>=20
> Sascha Hauer <s.hauer@pengutronix.de> writes:
>=20
> > The thermal code uses int, long and unsigned long for temperatures
> > in different places.
> >
> > Using an unsigned type limits the thermal framework to positive
> > temperatures without need. Also several drivers currently will repo=
rt
> > temperatures near UINT_MAX for temperatures below 0=B0C. This will =
probably
> > immediately shut the machine down due to overtemperature if started=
 below
> > 0=B0C.
> >
> > 'long' is 64bit on several architectures. This is not needed since =
INT_MAX =B0mC
> > is above the melting point of all known materials.
> >
> > Consistently use a plain 'int' for temperatures throughout the ther=
mal code and
> > the drivers. This only changes the places in the drivers where the =
temperature
> > is passed around as pointer, when drivers internally use another ty=
pe this is
> > not changed.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>=20
> Thanks for moving over the thermal sub-system in Linux to consistentl=
y
> use a single type.
>=20
> In your patch, you missed migrating over power_allocator governor and
> it's associated trace events. It got merged for v4.2.
>=20
> Could you incorporate something like below in your next version?

It seems I have changed drivers/thermal/power_allocator.c but missed
include/trace/events/thermal_power_allocator.h. Please check out the v2
patch I just sent.

Sascha

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
