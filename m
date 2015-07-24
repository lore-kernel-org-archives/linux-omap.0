From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] thermal: consistently use int for temperatures
Date: Sat, 25 Jul 2015 00:11:02 +0200
Message-ID: <20150724221102.GA31517@amd>
References: <1437463292-24844-1-git-send-email-s.hauer@pengutronix.de>
 <20150723120759.GA17690@amd>
 <20150724062948.GK18700@pengutronix.de>
 <55B244BE.1060203@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55B244BE.1060203@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Jean Delvare <jdelvare@suse.de>, Peter Feuerer <peter@piie.net>, Heiko Stuebner <heiko@sntech.de>, Lukasz Majewski <l.majewski@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, Darren Hart <dvhart@infradead.org>, lm-sensors@lm-sensors.org
List-Id: linux-omap@vger.kernel.org

On Fri 2015-07-24 06:59:26, Guenter Roeck wrote:
> On 07/23/2015 11:29 PM, Sascha Hauer wrote:
> >On Thu, Jul 23, 2015 at 02:07:59PM +0200, Pavel Machek wrote:
> >>On Tue 2015-07-21 09:21:32, Sascha Hauer wrote:
> >>>The thermal code uses int, long and unsigned long for temperatures
> >>>in different places.
> >>>
> >>>Using an unsigned type limits the thermal framework to positive
> >>>temperatures without need. Also several drivers currently will rep=
ort
> >>>temperatures near UINT_MAX for temperatures below 0=B0C. This will=
 probably
> >>>immediately shut the machine down due to overtemperature if starte=
d below
> >>>0=B0C.
> >>>
> >>>'long' is 64bit on several architectures. This is not needed since=
 INT_MAX =B0mC
> >>>is above the melting point of all known materials.
> >>
> >>Can we do something like
> >>
> >>typedef millicelsius_t int;
> >>
> >>...to document the units?
> >
> >I am not very fond of typedefs and I am not sure this adds any value=
=2E I
> >could change it when more people ask for it, but I just sent the new
> >version without this.
> >
>=20
> I thought we are supposed to not introduce new typedefs anyway.

You are not supposed to typedef struct, but typedef for millicelsius_t
would be ok. And it is your only chance if you want people to pay
attention. If you make it int, someone will pass it to long or
something else..
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
