From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] thermal: consistently use int for temperatures
Date: Thu, 23 Jul 2015 14:07:59 +0200
Message-ID: <20150723120759.GA17690@amd>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

On Tue 2015-07-21 09:21:32, Sascha Hauer wrote:
> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>=20
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0=B0C. This will pr=
obably
> immediately shut the machine down due to overtemperature if started b=
elow
> 0=B0C.
>=20
> 'long' is 64bit on several architectures. This is not needed since IN=
T_MAX =B0mC
> is above the melting point of all known materials.

Can we do something like

typedef millicelsius_t int;

=2E..to document the units?

> Consistently use a plain 'int' for temperatures throughout the therma=
l code and
> the drivers. This only changes the places in the drivers where the te=
mperature
> is passed around as pointer, when drivers internally use another type=
 this is
> not changed.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
