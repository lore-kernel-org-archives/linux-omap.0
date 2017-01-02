From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Nokia N900 sound driver and ECI GPIOs
Date: Mon, 2 Jan 2017 10:29:21 +0100
Message-ID: <20170102092921.GC6728@pali>
References: <201701012054.54505@pali>
 <20170101223639.GA13868@amd>
 <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4f150265-aa9b-c1f3-4634-9df8b320836b@bitmer.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Eduardo Valentin <edubezval@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, Sebastian Reichel <sre@kernel.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, joerg Reisenweber <joerg@openmoko.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 02 January 2017 11:01:48 Jarkko Nikula wrote:
> Hi
> 
> On 01/02/2017 12:36 AM, Pavel Machek wrote:
> >> Jarkko, you are listed as original author of that driver. Do you (or
> >> anybody else) remember what that rx51_set_eci_switches() function is
> >> doing? And what gpio 178 controls? I was even not able to find gpio 178
> >> in RX-51 Schematics [6].
> >>
> >> And do you know something about Nokia ECI headsets supports for Nokia
> >> N900. Looks like there is already some kernel code but support for ECI
> >> bus or multibuttons headset is missing.
> > 
> Multibutton ECI headset support using GPIO was planned during early in
> HW design phase but wasn't implemented for the actual product. I don't
> remember was it due no actual product requirement for it or GPIO based
> implementation was not reliable. If I remember correctly ECI protocol
> carries information by shorting mic bias to ground at some 1 kHz rate so
> trying to detect those pulses by SW won't work too well without hard
> real-time OS.
> 
> Even ECI is not implemented in final product the production HW still has
> two switches to route mic bias to voltage detection circuit, tv-out or
> codec. One of the switches is statically driven because only codec or
> tv-out route is needed. See commit 31164c7cf119 ("ASoC: omap: rx51: Add
> headset support")

I know about two gpio switches (TVOUT_EN and ECI_SWITCH=182). But
nothing about gpio 178, which looks like third switch. That statically
driven is gpio 182.

> > I'd like to get detection of headset button presses to work in recent
> > kernels, but could not figure it out :-(.
> > 
> My vague memory doesn't tell how basic button press detection was
> implemented in Maemo kernel. Was it codec, same voltage detection
> circuit than ECI or some another GPIO? I don't even remember did we
> implement it for the MeeGo N900 developer edition :-(

In Maemo 2.6.28 kernel is detection of pressing one button headset. It
is implemented in nokia-av.c and rx51.c files.

I started porting that code to mainline kernel, but I stopped at that
unknown gpio 178.

-- 
Pali Rohár
pali.rohar@gmail.com
