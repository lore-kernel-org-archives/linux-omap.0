From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] thermal: consistently use int for temperatures
Date: Mon, 6 Jul 2015 11:18:14 -0700
Message-ID: <20150706181814.GB40907@vmdeb7>
References: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1436167189-29835-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 06, 2015 at 09:19:49AM +0200, Sascha Hauer wrote:
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
>=20
> Consistently use a plain 'int' for temperatures throughout the therma=
l code and
> the drivers. This only changes the places in the drivers where the te=
mperature
> is passed around as pointer, when drivers internally use another type=
 this is
> not changed.
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

=2E..

>  drivers/platform/x86/acerhdf.c                     |  9 ++++----
>  drivers/platform/x86/intel_mid_thermal.c           |  9 ++++----

=46or these two:

Reviewed-by: Darren Hart <dvhart@linux.intel.com>

--=20
Darren Hart
Intel Open Source Technology Center
