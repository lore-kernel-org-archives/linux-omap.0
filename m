From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Powering OMAP's pins
Date: Wed, 26 Sep 2012 10:05:42 +0300
Message-ID: <1348643142.2376.13.camel@deskari>
References: <1348568474.2342.35.camel@deskari>
	 <20120925153806.GC4840@atomide.com> <1348592700.2342.49.camel@deskari>
	 <20120925190721.GD4840@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-0eyZLJN92fKTuND74iZV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47208 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605Ab2IZHFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 03:05:48 -0400
Received: by lbon3 with SMTP id n3so1246207lbo.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 00:05:45 -0700 (PDT)
In-Reply-To: <20120925190721.GD4840@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>


--=-0eyZLJN92fKTuND74iZV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-09-25 at 12:07 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 10:06]:
> > On Tue, 2012-09-25 at 08:38 -0700, Tony Lindgren wrote:
> > > * Tomi Valkeinen <tomi.valkeinen@ti.com> [120925 03:22]:
> > > > Hi Tony,
> > > >=20
> > > > Each pin of OMAP requires a particular power to be enabled for the =
pin
> > > > to function (Ball Characteristics table from data manual). Is there=
 a
> > > > plan how this is managed with pinctrl? Currently each driver needs =
to
> > > > make sure the correct regulators are enabled for the pins it uses, =
which
> > > > is platform specific and messy.
> > > >=20
> > > > As a driver maintainer, I would wish that the pins would just get
> > > > enabled automatically when I call pm_runtime_get()...
> > >=20
> > > Hmm can you clarify a bit what exactly do you want to do there
> > > with pm_runtime_get()? Call the regulator framework?
> >=20
> > Well, I'm not very familiar with pinctrl, but if I've understood right,
> > a set of pins are assigned to a driver in DT data (or wherever, that's
> > not relevant). Those pins should be automatically configured and enable=
d
> > when the driver uses pm_runtime_get() to enable its hardware.
> >=20
> > And if I've also understood right, the pinctrl discussions related to
> > omap have only dealt with pin muxing itself. But that's not enough to
> > get the pin functional, but the relevant regulator needs to be enabled
> > also.
> >=20
> > So when I call pm_runtime_get in the omapdss driver, I imagine that the
> > runtime PM and pinctrl would together handle muxing the pins for
> > omapdss's use, and also enable the relevant regulators to make the pins
> > usable.
>=20
> But aren't these regulators something that potentially are dynamically
> configured by the driver? For example, vdds_(sd)mmc1 depends on which
> card is plugged in.

Ah, ok. Are there other cases than mmc where the voltage(?) needs to be
dynamically configured?

> So to me it seesm that it's best to define the regulators and claim them
> by the driver using them rather than try to use automatically. It's

Well, in mmc case it sounds it's the driver's job. Perhaps the DSS pins
are special cases, then. I don't see any dynamic configuration needed
there.

Sometimes the regulator for the pins is implicitly enabled as it's
needed by a DSS component. For example when using DSI pins, the vdda_dsi
used by the pins is already enabled as it's used for the DSI itself, so
the pins just happen to work.

But then the same pins that are used for DSI can be used for other
things. On omap3430 DSI's dx0 pin can also be muxed to dss_data0,
uart1_cts, gpio_70. Of these, I'm mainly interested in the dss_data0, of
course.

So if I want to use parallel dss output, which uses dss_data0 pin,
omapdss driver needs to enable vdda_dsi on omap3430, even though there's
no other use for vdda_dsi in the parallel output case. But on omap4430
data0 pins seems to be powered by vdds_1p8v. On AM35xx something else.
So either I need to program all those into the omapdss driver, which is
not the right way as they are platform specific things, or I need to
pass some kind of pin data from platform data to omapdss driver, giving
the required regulator for each pin.

And how about the uart1_cts or gpio_70 pins on 3430? Do both uart and
gpio drivers need to have similar kind of platform data, giving the
required regulator so that the pin can be enabled?

> sort of the same situation as with GPIO pins?

How are the GPIO pins handled? They have this kind of pin-regulator
mapping?

 Tomi


--=-0eyZLJN92fKTuND74iZV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQYqlGAAoJEPo9qoy8lh71jWkP/2484zwj3qB5LIG+Q3qhn9Aq
V3pJU3dxIN+zuyoil4XrA0KlSfTKTKdh5eIEBzUVZVCYjEqi9LCLnP14b9ErWJQQ
mOIbHLNw2hO6o5GdvlXPaTnInYPOQZFlrOMhZW9M0icT700WCAiKaIo530R28HNi
4r7YqiERlmjn7jFbKRCYUih3fkdVhXt40DoU+X+Dvy67GyrJGGBwfdG0hX3BjsK4
k+Uns21Oo8vJFCUV7lfRJWWK3nPyreaPIZ7jJQ9Yrxz4pRcBqon4z0HP9YplmWfw
Brjb7fuIbpo/tM0M1BbxmKyXXvLkTboMDO4wztzUlqurDxHXvyaclifJD9Y5/Bhs
U3WQ27VehoXTBGFB3QfMIZ2mX7LrmppRMNZUNNOmf5QZYwP4aJ+q6rotajbeiWqM
kgY9A0hoqgpAueVoRlex7R8LNEYnOZX1sjLMwaLoZBAKEDMKN57a+Mp210wDvvbf
4u3E3F2kSpZxRG+1lVjpt5KxTpTiGe7SPSew6HmcHSZ/73Z+hJvEHcQ1JX/yYh+l
x+zU554YbS8PNp1SuqLacL3B2dY6oymOknLiuKwtT0fvrtowr6NC+rrnbYrw328N
e23Jk4S6WqpiizzX2Q2839hRM06hrSaLFiR1KBvBF4TpzQ5WcijLYg4SqXQcV55u
bkAyfjIz0Jvrh1KHQpmS
=zfSn
-----END PGP SIGNATURE-----

--=-0eyZLJN92fKTuND74iZV--

