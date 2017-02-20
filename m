From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 17:07:14 -0800
Message-ID: <20170220010714.GB8358@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <558407EE-4884-4CC3-9098-79DC4B222868@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <558407EE-4884-4CC3-9098-79DC4B222868-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Petr Cvek <petr>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

On Sat, Feb 18, 2017 at 12:32:48PM +0100, H. Nikolaus Schaller wrote:
> Hi Dmitry,
> 
> > Am 17.02.2017 um 21:40 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > 
> > Hi Nikolaus,
> > 
> > On Sat, Jan 28, 2017 at 10:44:35PM +0100, H. Nikolaus Schaller wrote:
> >> Hi Dmitry,
> >> 
> >>> Am 28.01.2017 um 20:33 schrieb Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>> 
> >>> Hi Nikolaus,
> >>> 
> >>> On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller wrote:
> >>>> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> >>>> introduced common DT bindings for touchscreens [1] and a helper function to
> >>>> parse the DT.
> >>>> 
> >>>> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
> >>>> added another helper for parsing axis inversion and swapping
> >>>> and applying them to x and y coordinates.
> >>>> 
> >>>> Both helpers have been integrated to accommodate any orientation of the
> >>>> touch panel in relation to the LCD.
> >>>> 
> >>>> A new feature is to introduce scaling the min/max ADC values to the screen
> >>>> size.
> >>>> 
> >>>> This makes it possible to pre-calibrate the touch so that is (almost)
> >>>> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> >>>> well enough operate the touch before a user space calibration step can
> >>>> improve the precision.
> >>> 
> >>> I question whether doing scaling in kernel is really right solution.
> >> 
> >> Since lower left corner does not exactly report [0 0] and upper right corner
> >> does not report [4095 4095] from the ADC we need offset and steepness correction
> >> of the ADC values.
> >> 
> >> This steepness is the scaling that must happen in kernel and I don't understand
> >> why you want to propagate this ADC errors to user-space by avoiding scaling.
> >> 
> >> Let me iterate what we want to achieve:
> >> * use new common bindings
> >> * offset and steepness calibration of the ADC (called pre-calibration).
> >>  This makes a real device much more reliable to operate with factory installed
> >>  scaling factors.
> >> * flipping and rotation
> >> 
> >> (note that touch pixel to LCD pixel scaling is not explicitly on this list!)
> > 
> > That was explicitly called out in the patch:
> > 
> > "A new feature is to introduce scaling the min/max ADC values to the
> > screen size."
> 

> Because it is a feature that was not planned nor required, but is
> there. So it came into the description of what can be done. If this is
> the key problem I am happy with removing it from the commit messages.
> 
> Anyways, scaling to screen coordinates is not my invention. It is
> based on
> 
> 	http://lxr.free-electrons.com/source/Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
> 
> which defines the size to be in pixels. Well, a resistive touch screen
> does not have pixels.  It might have a resolution/precision given by
> the ADC conversion steps but I assume this is not meant here.
> 
> So this scaling to screen size was also stimulated by this DT
> bindings.
> 

OK, now I see where you are coming from. You assume that pixels
mentioned in the DT binding are LCD pixels, however this is incorrect.
They are "pixels" or the touch controller, i.e. native unites in which
device reports coordinates, as opposed to points per inch, or
millimeters, or whatever. These "pixels" do not have to have 1:1
relation to the LCD pixels; in fact they rarely do.

Input driver may set resolution for given axis in units per mm (or units
per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and if you
check the binding, you can use "touchscreen-x-mm" and "touchscreen-y-mm"
to specify the size of entire touch surface and set resolution from it
so that userspace can calculate the proper scaling factor.

> > 
> >> 
> >> Now to achieve the ADC pre-calibration we must calculate
> >> 
> >> 	x' = (x - ti,min-x) / (ti,max-x-ti,min-x) giving a rante from 0.0 ... 1.0
> >> 
> >> This is scaled up to what is defined by touchscreen-size-x, i.e.
> >> 
> >> 	x' = (touchscreen-size-x * (x - ti,min-x)) / (ti,max-x-ti,min-x)
> >> 
> >> How do you want to avoid this scaling to take place? It happens automatically.
> >> It is not even an additional line of code. And is necessary for compensating ADC
> >> offsets and steepness.
> >> 
> >> So the only way to avoid the scaling option is to eliminate the precalibration/ADC
> >> compensation which is essential for a device which has no means to properly
> >> calibrate before operating the device through touch.
> >> 
> >> The other option would be to avoid common bindings and set
> >> 
> >> 	touchscreen-size-x = (ti,max-x-ti,min-x)
> >> 
> >> This is heavily dependent on specific ADC offsets forwarded to user-space.
> >> IMHO the worst we can do (and the current tsc2007 driver does it that way!).
> >> 
> >>> 
> >>> Why do you want this?
> >> 
> >> It seems that you assume that we want to enforce 1:1 scaling between touch pixels
> >> and LCD pixels and have designed code to achieve exactly that.
> >> 
> >> This is not the case. It is just a byproduct that you can do it.
> >> 
> >> And since it is easier to understand we have made the examples this way.
> >> 
> >>> If your touch resolution is lower than your screen
> >>> then it might be useful, but if it is lower then you are losing data
> >>> that can be very helpful for gesture recognition, and I hope you design
> >>> your userspace so it can handle not only "bad" hardware, but "good" as
> >>> well. And even with "bad" there are a lot of tricks that can be done to
> >>> get "better" touch position in userspace.
> >> 
> >> You can just *choose* DT parameters touchscreen-size-x to match the LCD size.
> >> This of course reduces the touch precision to full LCD pixels. For finger-
> >> touch operated devices, subpixel precision is rarely needed.
> >> 
> >> Also, some user-spaces (e.g. older Replicant for GTA04) assume that there is
> >> such an 1:1 mapping and they will be perfectly happy about this. 
> >> 
> >> But, if you can modify your user-space easily, you can also choose a different
> >> factor.
> >> 
> >> You can for example define touchscreen-size-x=<4096> and then you get almost
> >> the highest precision of the ADC and won't loose any bits. Or even define a
> >> bigger range and get steps >1 bit.
> >> 
> >> LCD driver (e.g. X11 calibration matrix) can scale it down again to LCD pixels.
> >> 
> >> So effectively we get for LCD pixels when the touch sets a mouse pointer:
> >> 
> >> 	x'' = user-space-scale * <<input-event<< ((touchscreen-size-x * (x - ti,min-x)) / (ti,max-x-ti,min-x))
> >> 
> >> The most simple setup would then be but others are possible:
> >> 
> >> 	user-space-scale = 1
> >> 	touchscreen-size-x = LCD-size-x
> >> 
> >> Let me cite myself:
> >> 
> >>>> This makes it possible to pre-calibrate the touch so that is (almost)
> > 
> > Yes, it allows you to pre-calibrate, I get it. But you still do properly
> > calibrate later, right?
> 
> No. We want to get rid of this step unless we need to improve the precision by
> some tiny %.
> 
> Why do we want to get rid of it?
> 
> This needs a longer explanation.
> 
> First of all we are working on the Letux distribution which aims at supporting
> multiple devices in the same way and with a single SD card image that contains
> one or multiple rootfs (Debian X11, QtMoko, Replicant etc.) the kernel uImage
> and DTB files for each supported device.
> 
> One of the ideas is to allow users to swap the SD card from one device to the
> other. This means that the touch screen calibration must magically be carried
> along - or we enforce to recalibrate every time the sd card is swapped back or
> forth.
> 
> The same is true for prebuilt SD-images. To have a single (no longer device specific)
> download requires to have a well defined default calibration. Especially on
> devices where you have no keyboard where you can ask the user to manually fine-tune
> something.
> 
> Our challenge is to make it work well without asking for explicit calibration.
> This is where pre-calibration comes into the game.
> 
> It turns out to be related to the touch screen properties and how it is glued onto
> the specific LCD panel, i.e. hardware and its description.
> 
> So the natural location of defining this relation is the DTB for each device
> and not the user-space. And it happens that we already have one per device
> (touch screen, lcd, tsc variant) on the SD card.
> 
> > So you are doing double work here, once in
> > kernel, and second time in userspace.
> 
> This is no longer required, as long as we can use the default 1:1 coordinate mapping
> of e.g. framebuffer or X11 based GUI toolkits.
> 
> If we don't have the 1:1 mapping of touch screen input event coordinates
> to LCD pixels we have a mess of different scaling factors back in user-space
> again. And the problem is setting them up properly in an installable .tbz
> or .dd image.

Why? Nothing stops you from querying the device and figure out scaling.
We do that, for example, on Chrome OS, where we do not have 1:1 matching
between LCDs and touch controllers, and still we do not have static
transformation matrices on the file system either.

> 
> Recently, you have raised another topic I had indeed not thought abut, which is
> the potential subpixel precision of a resistive touch. You get approx. 12
> bit from the ADC but the x coordinate of the 480 pixel wide screen is just 9
> bit. So scaling the input event coordinates to pixels throws away 3 bits.
> 
> But there are two things to consider.
> 
> One is that we could set the pre-calibration to keep as much resolution as
> possible, ca. 12 pixels and make the user-space scale down to screen coordinates.
> 
> Unfortunately that differs between devices and hence we need not only
> different DTBs (which we already have) but different scale factors in user-space.
> 
> Next, one could argue that subpixel coordinates should not be handled by
> scaling input event coordinates up and then down again in user-space. The
> correct solution would be that input events could report fixed or floating
> point coordinates, but this is probably beyond what we all want to do.
> 
> The other thing is noise. No resistive touch screen I have seen in the wild with
> the tsc2007 or tsc2046 controller has the precision to really report subpixels.
> Rather we have to set the fuzz between 3 or 10 or so. Which means that those
> bits we cut off by scaling to screen coordinates are already lost in noise.

I really do not care what exactly tsc2007 or any other particular
touchscreen controller does. Please design your software so that it can
use wide range of devices, from noisy to noiseless. If there is noise,
filter it out. It there is a nice touch controller with a lot of
precision - use it, do not dumb it down to the lowest common
denominator.

> 
> > 
> > I'd be more open to allowing setting the "min-axis" values to allow
> > reporting typical range for given device, and let userspace scale as it
> > sees fit.
> 
> The problem is: what is "typical range"? It turns out to be a completely
> arbitrary definition.
> 
> I see a choice between:
> a) full theoretical ADC range
> b) millimeters
> c) pixels of the LCD the touch is glued to

d) Native reporting units for the touch controller. You will have the
touch controller output range, you will have your LCD screen size, and
you scale one into another.

> 
> For me, the most natural and practical "typical range" still seems to be the
> pixels of the lcd panel the touch is glued onto.
> 
> The reason why I see it as superior to the others is that only this leads to
> a stable 1:1 mapping in user-space avoiding to adjust any factors there.
> 
> And this 1:1 saves a lot of configuration hassle if you swap GUI systems
> (X, Wayland, Android, DirectFB, fb based Qt, ...).

Yes, they will need to do that, if they want to use "nice" hardware and
not lose precision. And since they need to do that anyway, there is no
point in doing it in kernel, not with per driver code, and not even in
input core.

You are getting this feedback from several people, please consider topic
of adding scaling to the drivers closed. The only transformations that I
think make sense is to "normalize" output with axis swaps and
inversions, so that kernel uses the same notion of coordinates for all
devices, regardless of how the device was mounted.

> 
> > 
> >> 
> >>> 
> >>>> 
> >>>> Please note that the old ti,fuzz properties have been removed since they
> >>>> are replaced by the common bindings touchscreen-fuzz-x/y/z.
> >>>> 
> >>>> Finally, calculate_pressure has been renamed to calculate_resistance
> >>>> because that is what it is doing.
> >>> 
> >>> That is not what your patch does though. In the presence of
> >>> "ti,report-resistance" parameter you start reporting resistance through
> >>> ABS_PRESSURE
> >> 
> >> Well, there is some historic confusion wether this driver reports resistance
> >> or pressure.
> >> 
> >> The unpatched tsc2007 driver does it wrong (please test!) and we fix it on
> >> the fly (because a separate patch is much more complex than doing it right
> >> immediately).
> >> 
> >> This ti,report-resistance property is a means to get the old (wrong) meaning back
> >> in case someone urgently needs it and can't fix the user-space workaround which
> >> he must be using.
> >> 
> >> 
> >> AFAIK there is no mainline board using the DT except ours (and the upcoming
> >> OMAP5-Pyra), so we shouldn't care too much. If you prefer, you can remove this
> >> compatibility property. We don't need it for our devices.
> >> 
> > 
> > You seem to be treating DT data as something very fluid, which is wrong.
> 
> No,only sometimes.
> 
> Of course it should be done right once. Of course there is long discussion about
> what is right...
> 
> > You need to treat it as a firmware, unlikely to change once device is
> > shipped. Unlike legacy platform data, the fact that DTS files are not
> > present in mainline does not mean that we can ignore such users and
> > change behavior at will.
> 
> Well, it happens to me as maintainer of a 99.5% mainline device every
> now and then. Of course this should not be an argument to do it equally bad here.
> 
> One more thought: for some devices it is easier to modify the DTB "firmware"
> than the user space (e.g. if you have no access to it because it is maintained
> by somebody else).

And still, according to DT folks, device tree forms an ABI and thus we
are not to change it, even if it is easy.

> 
> > 
> > That said, if driver behavior is out of line from the subsystem
> > expectations, we need to fix it.
> > 
> > 
> >> That the function name is wrong is a second issue and this double negation might
> >> confuse a litte.
> >> 
> >> Please test on a real device if the patched driver reports pressure now (unless
> >> ti,report-resistance is specified).
> > 
> > I unfortunately can not test this driver as I do not have the hardware.
> 
> Ah, ok. This is indeed a road block.
> 
> Maybe someone else with a real tsc2007 hardware is reading this discussion and can comment?
> 
> > So all my observations are from code and data sheets.
> 
> > That said, what is the values emitted as ABS_PRESSURE when finger is not
> > touching the device, barely touching the device, or pressing firmly?
> 
> > It seems that between TSC2007, TSC2004, TSC2005, and ADS7846, we have
> > confusion as to what is being reported.
> 
> Indeed. The original tsc2007 jumps from 0 to a maximum value and goes down when
> pressing more firmly. This is not "pressure". The other drivers (I have tested
> the OpenPandora with tsc2046) are doing it in a monotonic curve.

OK, then this is clearly wrong and we need to fix it (without any funky
flags).

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
