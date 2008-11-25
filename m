From: David Brownell <david-b@pacbell.net>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 10:42:36 -0800
Message-ID: <200811251042.36549.david-b@pacbell.net>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:41984 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751924AbYKYTFd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 14:05:33 -0500
In-Reply-To: <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

On Tuesday 25 November 2008, Grazvydas Ignotas wrote:
> Hi,
>=20
> TWL4030 and compatibles have 2 pulse-width modulation (PWM) generator=
s
> (PWM0 and PWM1). They are used for backlight control and charger LED
> in pandora board. I wasn't able to find any drivers for them in
> linux-omap tree. Is there anyone working on these?=20

There are actually four PWM signals ... two associated with LEDs
(or VIBRA.M, or VIBRA.P; high current) with fast input clocks,
then PWM0 and PWM1 with slower input clocks which are alternate
GPIO settings.  PWM1 can be used as VIBRA.SYNC.

The two LED PWMs are used as GPIOs on the Beagle ... so the GPIO
driver supports them as output-only GPIOs, setting the LED PWMs
up to be "always on" or "always off".

In short:  all the PWM-equipped pins have "clean" driver support,
but only for using them as GPIOs, not as PWM.


> If not, what would=20
> be the proper way to expose them? May be as LED driver?
> I saw lcd_omap*evm.c just write to LED PWM registers over i2c to
> control backlight, I wonder if I should just do the same.

Right now, just use LEDA and LEDB as GPIO-19 and GPIO-20, like
Beagle does; ditto for PWM-0/GPIO-6 and PWM-1/GPIO-7.

Near term, something to support led_classdev.brightness_{set,get}
methods would make sense to me, for LEDA and LEDB.  The EVMs could
set up LEDA devices and hook them up to the "backlight" trigger.
The same thing could be done for PWM0 and PWM1.

Long term, we may have a PWM framework ... but it's not ready yet,
and hasn't even been refreshed recently either.  And so far as I
know, ALSA has no notion of supporting the VIBRA module hookup
options for "audio" output.

- Dave



> Gra=C5=BEvydas
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
