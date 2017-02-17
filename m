From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Fri, 17 Feb 2017 12:40:41 -0800
Message-ID: <20170217204041.GE13050@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr Cvek <petr>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

On Sat, Jan 28, 2017 at 10:44:35PM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 28.01.2017 um 20:33 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > 
> > Hi Nikolaus,
> > 
> > On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller wrote:
> >> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> >> introduced common DT bindings for touchscreens [1] and a helper function to
> >> parse the DT.
> >> 
> >> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
> >> added another helper for parsing axis inversion and swapping
> >> and applying them to x and y coordinates.
> >> 
> >> Both helpers have been integrated to accommodate any orientation of the
> >> touch panel in relation to the LCD.
> >> 
> >> A new feature is to introduce scaling the min/max ADC values to the screen
> >> size.
> >> 
> >> This makes it possible to pre-calibrate the touch so that is (almost)
> >> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> >> well enough operate the touch before a user space calibration step can
> >> improve the precision.
> > 
> > I question whether doing scaling in kernel is really right solution.
> 
> Since lower left corner does not exactly report [0 0] and upper right corner
> does not report [4095 4095] from the ADC we need offset and steepness correction
> of the ADC values.
> 
> This steepness is the scaling that must happen in kernel and I don't understand
> why you want to propagate this ADC errors to user-space by avoiding scaling.
> 
> Let me iterate what we want to achieve:
> * use new common bindings
> * offset and steepness calibration of the ADC (called pre-calibration).
>   This makes a real device much more reliable to operate with factory installed
>   scaling factors.
> * flipping and rotation
> 
> (note that touch pixel to LCD pixel scaling is not explicitly on this list!)

That was explicitly called out in the patch:

"A new feature is to introduce scaling the min/max ADC values to the
screen size."

> 
> Now to achieve the ADC pre-calibration we must calculate
> 
> 	x' = (x - ti,min-x) / (ti,max-x-ti,min-x) giving a rante from 0.0 ... 1.0
> 
> This is scaled up to what is defined by touchscreen-size-x, i.e.
> 
> 	x' = (touchscreen-size-x * (x - ti,min-x)) / (ti,max-x-ti,min-x)
> 
> How do you want to avoid this scaling to take place? It happens automatically.
> It is not even an additional line of code. And is necessary for compensating ADC
> offsets and steepness.
> 
> So the only way to avoid the scaling option is to eliminate the precalibration/ADC
> compensation which is essential for a device which has no means to properly
> calibrate before operating the device through touch.
> 
> The other option would be to avoid common bindings and set
> 
> 	touchscreen-size-x = (ti,max-x-ti,min-x)
> 
> This is heavily dependent on specific ADC offsets forwarded to user-space.
> IMHO the worst we can do (and the current tsc2007 driver does it that way!).
> 
> > 
> > Why do you want this?
> 
> It seems that you assume that we want to enforce 1:1 scaling between touch pixels
> and LCD pixels and have designed code to achieve exactly that.
> 
> This is not the case. It is just a byproduct that you can do it.
> 
> And since it is easier to understand we have made the examples this way.
> 
> > If your touch resolution is lower than your screen
> > then it might be useful, but if it is lower then you are losing data
> > that can be very helpful for gesture recognition, and I hope you design
> > your userspace so it can handle not only "bad" hardware, but "good" as
> > well. And even with "bad" there are a lot of tricks that can be done to
> > get "better" touch position in userspace.
> 
> You can just *choose* DT parameters touchscreen-size-x to match the LCD size.
> This of course reduces the touch precision to full LCD pixels. For finger-
> touch operated devices, subpixel precision is rarely needed.
> 
> Also, some user-spaces (e.g. older Replicant for GTA04) assume that there is
> such an 1:1 mapping and they will be perfectly happy about this. 
> 
> But, if you can modify your user-space easily, you can also choose a different
> factor.
> 
> You can for example define touchscreen-size-x=<4096> and then you get almost
> the highest precision of the ADC and won't loose any bits. Or even define a
> bigger range and get steps >1 bit.
> 
> LCD driver (e.g. X11 calibration matrix) can scale it down again to LCD pixels.
> 
> So effectively we get for LCD pixels when the touch sets a mouse pointer:
> 
> 	x'' = user-space-scale * <<input-event<< ((touchscreen-size-x * (x - ti,min-x)) / (ti,max-x-ti,min-x))
> 
> The most simple setup would then be but others are possible:
> 
> 	user-space-scale = 1
> 	touchscreen-size-x = LCD-size-x
> 
> Let me cite myself:
> 
> >> This makes it possible to pre-calibrate the touch so that is (almost)

Yes, it allows you to pre-calibrate, I get it. But you still do properly
calibrate later, right? So you are doing double work here, once in
kernel, and second time in userspace.

I'd be more open to allowing setting the "min-axis" values to allow
reporting typical range for given device, and let userspace scale as it
sees fit.

> 
> > 
> >> 
> >> Please note that the old ti,fuzz properties have been removed since they
> >> are replaced by the common bindings touchscreen-fuzz-x/y/z.
> >> 
> >> Finally, calculate_pressure has been renamed to calculate_resistance
> >> because that is what it is doing.
> > 
> > That is not what your patch does though. In the presence of
> > "ti,report-resistance" parameter you start reporting resistance through
> > ABS_PRESSURE
> 
> Well, there is some historic confusion wether this driver reports resistance
> or pressure.
> 
> The unpatched tsc2007 driver does it wrong (please test!) and we fix it on
> the fly (because a separate patch is much more complex than doing it right
> immediately).
> 
> This ti,report-resistance property is a means to get the old (wrong) meaning back
> in case someone urgently needs it and can't fix the user-space workaround which
> he must be using.
>
> 
> AFAIK there is no mainline board using the DT except ours (and the upcoming
> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can remove this
> compatibility property. We don't need it for our devices.
>

You seem to be treating DT data as something very fluid, which is wrong.
You need to treat it as a firmware, unlikely to change once device is
shipped. Unlike legacy platform data, the fact that DTS files are not
present in mainline does not mean that we can ignore such users and
change behavior at will.

That said, if driver behavior is out of line from the subsystem
expectations, we need to fix it.

 
> That the function name is wrong is a second issue and this double negation might
> confuse a litte.
> 
> Please test on a real device if the patched driver reports pressure now (unless
> ti,report-resistance is specified).

I unfortunately can not test this driver as I do not have the hardware.
So all my observations are from code and data sheets.

That said, what is the values emitted as ABS_PRESSURE when finger is not
touching the device, barely touching the device, or pressing firmly?
It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
confusion as to what is being reported.

I am adding a few more folks to the CC so we can try and soft this out.
Sebastian, Pali, Pavel, any input here?

Thanks.

-- 
Dmitry
