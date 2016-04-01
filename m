From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Fri, 1 Apr 2016 14:45:23 +0200
Message-ID: <20160401124523.GB10776@amd>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
 <20160329145209.GB31858@earth>
 <20160330193520.GY9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160330193520.GY9329@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > On Tue, Mar 29, 2016 at 12:51:28PM +0200, Pavel Machek wrote:
> > > For 1-3 in the series, Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > > Like the Nokia N900, the N950 has leds to show
> > > > the state of sys_clkreq and sys_off_mode pins.
> > > > 
> > > > A detailed description for the LEDs and
> > > > OMAP's sleep states can be found in Tony's
> > > > commit for the Nokia N900:
> > > > 
> > > > c1be2032f66df9e1238bd5bc4ca666de88a62abc
> > > 
> > > I must say I've seen it on N900, and yes, it is useful, but no, I
> > > don't think this is right.
> > >
> > > This is not a LED. This is a interface that changes meaning of two
> > > other LEDs. I guess it should go to debugfs somewhere.
> 
> Eh that sounds like a GPIO LED to me :) And it already has a
> /sys/class/leds/debug interface.
> 
> The two LEDs this GPIO controls are hardwired to sys_clkreq and
> sys_off_mode pins that are the control signals between the SoC
> and PMIC.

No, not on N900. On N900, these LEDs are normally used for keyboard
backlight.

> In theory you could steal the sys_clkreq and sys_off_mode pins
> from the PMIC at the cost of breaking PM. But I doubt anybody
> wants to do that considering it's a battery operated device.

No. It seems that on N900, you can select whether sys_clkreq and
sys_off_mode is binary-or'ed with normal control of two keyboard
backlight LEDs.

> > I don't think we should diverge N900 and N950 userspace
> > APIs in this regard.
> > 
> > Actually the correct way would be a custom trigger
> > for the leds IMHO. I don't know if the led framework
> > supports per led custom triggers, though.
> 
> Sure, there are something like 10 triggers already. And
> you can already change them using:
> 
> echo none > /sys/class/leds/debug::sleep/trigger
> 
> That still does not change the fact that the LEDs trigger
> based on the state of sys_clkreq and sys_off_mode.
> 
> Maybe I'm not following what you guys are trying to achieve
> here though :) If so, please let me know.

...and this is what this GPIO does. So it is not exactly a LED. You
can turn it on, but than, _two_ LEDs will start blinking. You can't
control them with the brightess control. "Heartbeat" trigger is going
to be very confusing on debug::sleep.

Best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
