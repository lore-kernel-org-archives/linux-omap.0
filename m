From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Fri, 9 Mar 2018 08:34:14 +0000
Message-ID: <20180309083414.s57eq3kw325magwz@dell>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
 <20180308112528.GC6019@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308112528.GC6019@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org

On Thu, 08 Mar 2018, Mark Brown wrote:

> On Thu, Mar 08, 2018 at 10:48:31AM +0000, Lee Jones wrote:
> > On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> 
> > > I had it in PATCHv1-PATCHv4. It was removed, since Mark didn't want
> > > to have it in the DT ABI.
> 
> > Right, but why?  Is it not a hardware device?  I think converting from
> > devm_of_platform_populate() for one sub-device is a bit drastic.
> 
> It's not a separate physical device or IP and doesn't exist outside of
> the MFD, it's just how Linux is currently choosing to divide up the chip
> right now but that's totally open to change even in future versions of
> Linux.  Clocks are a big issue with audio stuff, right now sections of
> the clock tree get handled in the CODEC driver but we're going to want
> to push them out to a clock driver so we're not reimplementing handling
> for clocks.

How is the CODEC controlled?  Does it have its own registers?  I guess
by "it's not a separate device or IP" you mean that it doesn't.  But
that begs the question, how does this then device differ from all the
other devices (adc, battery, charger, regulator, rtc, pwrbutton,
usb-phy and led)?

I'm asking, not to be awkward, but to avoid 50 lines of potentially
unnecessary static code.  If this is a real (sub-)device, even if it's
part of a larger, single device (MFD) then there is no reason why it
can't be represented as a single, albeit empty node.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
