From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Fri, 9 Mar 2018 07:11:53 -0800
Message-ID: <20180309151153.GR5799@atomide.com>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
 <20180308112528.GC6019@sirena.org.uk>
 <20180309083414.s57eq3kw325magwz@dell>
 <20180309124017.GB5252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309124017.GB5252@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180309 12:41]:
> On Fri, Mar 09, 2018 at 08:34:14AM +0000, Lee Jones wrote:
> > On Thu, 08 Mar 2018, Mark Brown wrote:
> 
> > > Linux.  Clocks are a big issue with audio stuff, right now sections of
> > > the clock tree get handled in the CODEC driver but we're going to want
> > > to push them out to a clock driver so we're not reimplementing handling
> > > for clocks.
> 
> > How is the CODEC controlled?  Does it have its own registers?  I guess
> > by "it's not a separate device or IP" you mean that it doesn't.  But
> > that begs the question, how does this then device differ from all the
> > other devices (adc, battery, charger, regulator, rtc, pwrbutton,
> > usb-phy and led)?
> 
> I'm not convinced that this is a particularly good idea for the other
> functions but anyway...  the big thing here is that in these devices the
> CODEC is generally not the level that the IP is created at, it's a
> collection of interlinked IPs which usually includes not only audio
> stuff but also some clocking stuff.  The repeatable blocks that could
> get reused independently are generally a level down from the CODEC
> level, for example if you look at something like wm8994 there's a couple
> of identical FLL IPs which could make sense to enumerate individually in
> the DT.  The top level generally doesn't get reused and is purely an
> encoding of what Linux is currently doing.

It seems that most of the components in the PMICs are just standard
components packed into the PMIC with a control interface provided
over I2C or SPI.

So using compatible for things like ADC, RTC and so on makes sense
if eventually figure out which ones are shared across various
drivers.

Sounds like audio is a bit more fuzzy like Mark describes above.
And by not using a compatible for audio we can have things working
while not establishing and ABI for something that might change
in the future.

Regards,

Tony
