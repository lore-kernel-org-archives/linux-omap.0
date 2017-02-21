From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 09:47:24 +0100
Message-ID: <20170221084724.GB9795@pali>
References: <cover.1482936802.git.hns@goldelico.com>
 <20170220010714.GB8358@dtor-ws>
 <B30D00D0-1967-4BD5-A304-E2ADC815A805@goldelico.com>
 <201702202042.15878@pali>
 <A41872A2-F095-47F8-B122-FFAE430B0D7F@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <A41872A2-F095-47F8-B122-FFAE430B0D7F-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjami>
List-Id: linux-omap@vger.kernel.org

Hi!

On Tuesday 21 February 2017 08:14:09 H. Nikolaus Schaller wrote:
> Hi Pali,
> 
> > Am 20.02.2017 um 20:42 schrieb Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > 
> > Hi Nikolaus!
> > 
> > On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >> Hi Dmitry,
> >> 
> >>> Input driver may set resolution for given axis in units per mm (or
> >>> units per radian for rotational axis ABS_RX, ABS_RY, ABS_RZ), and
> >>> if you check the binding, you can use "touchscreen-x-mm" and
> >>> "touchscreen-y-mm" to specify the size of entire touch surface and
> >>> set resolution from it so that userspace can calculate the proper
> >>> scaling factor.
> >> 
> >> How is this information exposed by the kernel to user-space? By
> >> scanning the DT file or tree?
> > 
> > Set input_abs_set_res() from kernel.
> 
> I can't find this function defined anywhere but used in 101 LOC.
> LXR doesn't know it either: http://lxr.free-electrons.com/ident?i=input_abs_set_res
> 
> What is going on here?

It is inline function defined by preprocessor. This should help you:

git grep INPUT_GENERATE_ABS_ACCESSORS
git grep input_abs_set_res

> > And in userspace call EVIOCGABS
> > ioctl() on input device. Look at struct input_absinfo, you should have
> > all needed information here. This is generic input interface, no DT is
> > needed.
> 
> Ok, if this is not set by a driver it is indeed a driver bug.

Zero value is special and means "driver does not know it". In case
driver really does not know it, then it is not a driver bug.

> But we have to define it's value in DT because the tsc2007 does not know
> anything about the panel dimensions.

Yes, driver itself does not know it and DT seems to be correct place.

> IMHO something that should be done by generic of_touchscreen.c

I agree. DT for specific hardware can pass these information into
touchscreen driver (which does not have to know these parameters) and it
exports it to userspace.

> If of_touchscreen would simply pass the touchscreen-size parameters
> to input_abs_set_res() and the bindings would define it to be units/mm
> it might have saved us all a lot of work and discussion.

Seem that nobody until now needed such thing and everybody is (probably)
using Xorg userspace with userspace calibration.

But it really make sense to set input_abs_set_res() from DT.

> > 
> > I hope that XServer is already using it for evdev devices...
> > 
> > For whole implementation look at evtest program. That should be good
> > starting point for your userspace implementation.
> > 
> > While I'm watching this discussion... in my opinion kernel should just
> > invert input axes (when needed) and should not do any other
> > normalization or integer/floating-point re-calibration/re-calculation.
> > If it correctly exports minimum value, maximum value and resolution then
> > userspace can correctly re-scale input events to units which userspace
> > needs (e.g. mapping into LCD screen pixels or whatever is needed).
> 
> BR and thanks,
> Nikolaus
> 

-- 
Pali Rohár
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
