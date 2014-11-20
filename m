From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Thu, 20 Nov 2014 13:13:48 +0100
Message-ID: <20141120121348.GB27527@amd>
References: <546AFEA5.9020000@samsung.com>
 <20141118084603.GC4059@amd>
 <546B19C8.2090008@samsung.com>
 <20141118113256.GA10022@amd>
 <546B40FA.2070409@samsung.com>
 <20141118132159.GA21089@amd>
 <546B6D86.8090701@samsung.com>
 <20141118165148.GA11711@amd>
 <546C66A5.6060201@samsung.com>
 <546CD90B.8060903@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546CD90B.8060903@iki.fi>
Sender: linux-leds-owner@vger.kernel.org
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org, Linux LED Subsystem <linux-leds@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi!

> >> But regulators already have "regulator-max-microamp" property. So what
> >> about:
> >>
> >> max-microamp :     maximum intensity in microamperes of the LED
> >>                 (torch LED for flash devices)
> >> max-flash-microamp :     initial intensity in microamperes of the
> >>               flash LED; it is required to enable support
> >>               for the flash led
> >> flash-timeout-microseconds : timeout in microseconds after which flash
> >>               led is turned off
> >>
> >> If you had indicator on the same led, I guess
> >>
> >> indicator-microamp : recommended intensity in microamperes of the LED
> >>                  for indication
> 
> The value for the indicator is maximum as well, not just a
> recommendation.

Actually, no.

This is all for one LED, if you want to use it as a flash, torch and
indicator. You already know the maximum value with max-microamp.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
