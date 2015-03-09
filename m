From: Pavel Machek <pavel@ucw.cz>
Subject: Re: RGB LED control (was Re: "advanced" LED controllers)
Date: Mon, 9 Mar 2015 10:08:46 +0100
Message-ID: <20150309090846.GA6659@amd>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <CAMuHMdUUNzFYHzSR3yLCJuz11vuO3Z4yVWVxRQfutGY1KxZLPQ@mail.gmail.com>
 <CAAVeFuJ7DCs_=iESJRcXwyQ09eD57dZCxGG5CD3LD9_ZGZHP2A@mail.gmail.com>
 <20150302092111.GA19233@amd>
 <CAAVeFuK9eGO2TN+tgDyN8EFzEhgHOy5YCch+LaqS9PNaQXQ4Qg@mail.gmail.com>
 <20150308205732.GA385@amd>
 <CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVgZ1i5zymxmi3-i98n9UPTV=Sq-Oa=ieyfOzETW-DzA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, Felipe Balbi <balbi@ti.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon 2015-03-09 09:08:37, Geert Uytterhoeven wrote:
> Hi Pavel,
> 
> On Sun, Mar 8, 2015 at 9:57 PM, Pavel Machek <pavel@ucw.cz> wrote:
> > Ok, so I played with RGB LED a bit, and we have quite a gap in
> > documentation: what 50% brightness means is non-trivial and very
> > important in case we want to do smooth blinking and color transitions.
> >
> > Signed-off-by: Pavel Machek <pavel@ucw.cz>
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-led b/Documentation/ABI/testing/sysfs-class-led
> > index 3646ec8..649d7a6 100644
> > --- a/Documentation/ABI/testing/sysfs-class-led
> > +++ b/Documentation/ABI/testing/sysfs-class-led
> > @@ -8,6 +8,11 @@ Description:
> >                 non-zero brightness settings. The value is between 0 and
> >                 /sys/class/leds/<led>/max_brightness.
> >
> > +               If LED supports continuous brightness settings, 50% brightness
> > +               should correspond to 50% brightness perceived by human, in a similar
> > +               manner pixel brightness on monitor does (not 50% PWM).
> 
> How many drivers do it right? How many don't?

Not sure. leds-lp5523.c gets is wrong. Easy test is to attempt to set
"electric indigo" color
(http://en.wikipedia.org/wiki/Indigo#Violet-blue) and see what comes
out.

> For those that don't, perhaps we handle the conversion between perceived and
> pwm in the core, e.g. by adding a new flag to led_classdev.flags to indicate
> the need for conversion?

There is not that many drivers that support smooth power
adjustments. But yes, we can probably conversion in the core for
trivial case.

Unfortunately, we only have 8-bits of precision to work with... 
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
