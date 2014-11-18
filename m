From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] adp1653: Add device tree bindings for LED controller
Date: Tue, 18 Nov 2014 09:50:13 +0100
Message-ID: <20141118085013.GD4059@amd>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
 <546AFEA5.9020000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <546AFEA5.9020000@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacek Anaszewski <j.anaszewski@samsung.com>
Cc: Sakari Ailus <sakari.ailus@iki.fi>, pali.rohar@gmail.com, sre@debian.org, sre@ring0.de, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, freemangordon@abv.bg, bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue 2014-11-18 09:09:09, Jacek Anaszewski wrote:
> Hi Pavel, Sakari,
> 
> On 11/17/2014 03:58 PM, Sakari Ailus wrote:
> >Hi Pavel,
> >
> >On Sun, Nov 16, 2014 at 08:59:28AM +0100, Pavel Machek wrote:
> >>For device tree people: Yes, I know I'll have to create file in
> >>documentation, but does the binding below look acceptable?
> >>
> >>I'll clean up driver code a bit more, remove the printks. Anything
> >>else obviously wrong?
> >
> >Jacek Anaszewski is working on flash support for LED devices. I think it'd
> >be good to sync the DT bindings for the two, as the types of devices
> >supported by the LED API and the V4L2 flash API are quite similar.
> >
> >Cc Jacek.
> 
> I've already submitted a patch [1] that updates leds common bindings.
> I hasn't been merged yet, as the related LED Flash class patch [2]
> still needs some indicator leds related discussion [3].
> 
> I think this is a good moment to discuss the flash related led common
> bindings.
> 
> [2] http://www.spinics.net/lists/linux-media/msg83100.html

Actually, would it be possible to do the patches the other way around?

V4L2 api already knows about flash, torch and indicators. Provide
glue, so that V4L2 torch automatically appears as two leds in the led
subystem? (white and red in my case?)

[Well, I kind of like the LED class API more, but it appears both you
and me really have two LEDs in one package, and V4L2 already knows
about that so it is better match....?]

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
