From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/7] ARM: dts: Enable N950 keyboard sleep leds by default
Date: Sat, 2 Apr 2016 08:47:57 +0200
Message-ID: <20160402064757.GA13872@amd>
References: <1457827580-16919-1-git-send-email-sre@kernel.org>
 <1457827580-16919-5-git-send-email-sre@kernel.org>
 <20160329105128.GA30184@amd>
 <20160329145209.GB31858@earth>
 <20160330193520.GY9329@atomide.com>
 <20160401124523.GB10776@amd>
 <20160401183221.GN9329@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160401183221.GN9329@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi!

> > > The two LEDs this GPIO controls are hardwired to sys_clkreq and
> > > sys_off_mode pins that are the control signals between the SoC
> > > and PMIC.
> > 
> > No, not on N900. On N900, these LEDs are normally used for keyboard
> > backlight.
> 
> Oh I see. I've totally forgotten that as I always keep the debug
> option enabled :) The extra battery consumption by those is quite
> minimal and warns you if you have something hogging the CPU.

Yes, I like it.

> > ...and this is what this GPIO does. So it is not exactly a LED. You
> > can turn it on, but than, _two_ LEDs will start blinking. You can't
> > control them with the brightess control. "Heartbeat" trigger is going
> > to be very confusing on debug::sleep.
> 
> And it occured to me that adding any other policy than
> "default-on" to the GPIO LED will only work when the device
> is active.
> 
> Sounds like the thing to do is to just configure the I2C LED
> controller in the dts file if we don't already have that. And
> assuming it has a Linux driver.

I don't see what you mean here. If you want to always keep the debug
leds on... that may be a bit confusing for the users (and Pali wants
to keep kernel usable for mere mortals it seems).

Anyway, current solution is not too horrible (its wrong but it does
not hurt that much), so...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
