From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] N900: add device tree
Date: Thu, 4 Jul 2013 23:32:56 +0300
Message-ID: <20130704203256.GB27374@blackmetal.musicnaut.iki.fi>
References: <20130613145724.GH8164@atomide.com>
 <20130613155240.GB3775@amd.pavel.ucw.cz>
 <20130613161418.GJ8164@atomide.com>
 <20130613230808.GA14876@amd.pavel.ucw.cz>
 <20130614055629.GM8164@atomide.com>
 <20130614212816.GA31768@atrey.karlin.mff.cuni.cz>
 <20130617111031.GQ20992@atomide.com>
 <20130701211753.GC15318@amd.pavel.ucw.cz>
 <20130704171939.GA27374@blackmetal.musicnaut.iki.fi>
 <20130704202145.GB10752@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130704202145.GB10752@amd.pavel.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, b-cousson@ti.com, pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Jul 04, 2013 at 10:21:45PM +0200, Pavel Machek wrote:
> > > This adds device tree with neccessary support to boot with functional
> > > video (on both emulator and real N900 device).
> > 
> > Is this really correct? You have commented out the USB, so there is no
> > way for a developer to interact with the device.
> 
> Well... I do not have USB & SDcard set up, so my testing was "does it
> show failed to mount root message on screen". 
> 
> Now, if I do quick test of enabling it on 3.9, I get:
> 
>   DTC     arch/arm/boot/dts/omap3-n900.dtb
> Error: arch/arm/boot/dts/omap3-n900.dts:92.2-3 label or path,
> 'usb_otg_hs', not found
> FATAL ERROR: Syntax error parsing input tree
> make[1]: *** [arch/arm/boot/dts/omap3-n900.dtb] Error 1
> make: *** [dtbs] Error 2

You need 3.10. It was added in ad871c10b55654910ba97af00a00e65725da5e40
(ARM: dts: OMAP: Add usb_otg and glue data to OMAP3+ boards).

3.9 is very old. :-)

> If you could test the patches with the USB support uncommented, that
> would be very good...

I can do that, but not before next week.

A.
