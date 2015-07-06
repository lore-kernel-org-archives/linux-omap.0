From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH] thermal: consistently use int for temperatures
Date: Mon, 06 Jul 2015 12:26:40 +0200
Message-ID: <20150706122640.2a61ca05@amdc2363>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

Hi Sascha,

> The thermal code uses int, long and unsigned long for temperatures
> in different places.
>=20
> Using an unsigned type limits the thermal framework to positive
> temperatures without need. Also several drivers currently will report
> temperatures near UINT_MAX for temperatures below 0=C2=B0C. This will
> probably immediately shut the machine down due to overtemperature if
> started below 0=C2=B0C.
>=20
> 'long' is 64bit on several architectures. This is not needed since
> INT_MAX =C2=B0mC is above the melting point of all known materials.
>=20
> Consistently use a plain 'int' for temperatures throughout the
> thermal code and the drivers. This only changes the places in the
> drivers where the temperature is passed around as pointer, when
> drivers internally use another type this is not changed.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha, thanks for this cleanup work.=20

Reviewed-by: Lukasz Majewski <l.majewski@samsung.com>

--=20
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
