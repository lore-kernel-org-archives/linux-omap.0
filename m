From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Tue, 21 Feb 2017 09:53:28 +0100
Message-ID: <20170221085328.GC9795@pali>
References: <cover.1482936802.git.hns@goldelico.com>
 <201702202207.38582@pali>
 <A77657DA-BFF3-4A4E-9302-047B77072F3A@goldelico.com>
 <201702202254.35023@pali>
 <4BA8DA1B-D6CB-4D38-AAD6-3B1CF217E521@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4BA8DA1B-D6CB-4D38-AAD6-3B1CF217E521-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>, Mika =?utf-8?B?UGVudHRpbMOk?= <mika.penttila-MRsr7dthA9VWk0Htik3J/w@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>, Eric Engestrom <eric-op+oiCINJLTt9jDmeYuA0g@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Tissoires <benjami>
List-Id: linux-omap@vger.kernel.org

On Tuesday 21 February 2017 07:42:17 H. Nikolaus Schaller wrote:
> Hi Pali,
> 
> > Am 20.02.2017 um 22:54 schrieb Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> > 
> > On Monday 20 February 2017 22:24:31 H. Nikolaus Schaller wrote:
> >> Hi Pali,
> >> 
> >>> Am 20.02.2017 um 22:07 schrieb Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>> 
> >>> On Monday 20 February 2017 21:35:18 H. Nikolaus Schaller wrote:
> >>>> Hi Pali,
> >>>> 
> >>>>> Am 20.02.2017 um 20:42 schrieb Pali Rohár <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> >>>>> 
> >>>>> Hi Nikolaus!
> >>>>> 
> >>>>> On Monday 20 February 2017 17:50:04 H. Nikolaus Schaller wrote:
> >>>>>> Hi Dmitry,
> >>>>>> 
> >>>>>>> Input driver may set resolution for given axis in units per mm
> >>>>>>> (or units per radian for rotational axis ABS_RX, ABS_RY,
> >>>>>>> ABS_RZ), and if you check the binding, you can use
> >>>>>>> "touchscreen-x-mm" and "touchscreen-y-mm" to specify the size
> >>>>>>> of entire touch surface and set resolution from it so that
> >>>>>>> userspace can calculate the proper scaling factor.
> >>>>>> 
> >>>>>> How is this information exposed by the kernel to user-space? By
> >>>>>> scanning the DT file or tree?
> >>>>> 
> >>>>> Set input_abs_set_res() from kernel. And in userspace call
> >>>>> EVIOCGABS ioctl() on input device. Look at struct input_absinfo,
> >>>>> you should have all needed information here. This is generic
> >>>>> input interface, no DT is needed.
> >>>> 
> >>>> This assumes that I can and want to write a graphics system
> >>>> myself.
> >>> 
> >>> Not only. There are already existing graphics systems. And you need
> >>> to provide needed information from kernel, so they can start using
> >>> it.
> >>> 
> >>> So input_abs_set_res() is needed to use in your kernel driver.
> >> 
> >> I didn't know about this feature and obviously nobody else has
> >> implemented it in the tsc2007 driver.
> > 
> > So... before doing other things, can you deeply look at it and check if
> > it really fixes this problem? Because I think that yes.
> > 
> > You can probably set it from DT and in your DT file you can have stored
> > screen size (or resolution factor).
> > 
> > Also for testing, you can set it even via userspace (ioctl which I wrote
> > in previous email).
> 
> Interesting thing. It does not seem to be well known because nobody else
> brought it up during several months of lenghty discussions.
> 
> I have seen it is in use for scaling topics, e.g. https://lkml.org/lkml/2015/7/9/749

E.g. my touchpad (ALPS) exports this information. It is not touchscreen
device, but still it is absolute positioned device. And looking into
kernel tree it is used by more input drivers...

> > 
> >>>> And if it does, it does it in a
> >>>> plethora of different implementation states. That is the reason
> >>>> why we want to solve it once for all userlands in the kernel and
> >>>> not rely on user-space help.
> >>> 
> >>> For me this looks like "we are going to fix userspace bugs in
> >>> kernel".
> >> 
> >> Such things are system bugs and it is neither necessarily a userspace
> >> or kernel bug.
> > 
> > In case kernel defines stable API/ABI and correctly provides information
> > via that API/ABI and application does not work correctly, then I would
> > say it is bug in application. Not in kernel.
> 
> So a kernel can simply add a new interface and declare bugs for userland?

That is something different. But yes it could be problematic if you
create userspace and immediately after that kernel define some API which
is against usage of your userspace. So something like this would depend
on situation.

But I hope right now it is clear. That resolution property is there for
a long time and new code (which is your case) should use it.

> > 
> > We can say that some kernel API/ABI is wrong too. And in this case it
> > could be bug in kernel.
> > 
> > So is current stable kernel API/ABI for input device wrong? I do not
> > thing.
> 
> Difficult to judge because there is scarce documentation of this.
> 
> > But if you think that yes, please show us what exactly and we can
> > start discussing how to fix such problem which you see/have. I know that
> > no application is without bugs, but in my opinion problem which you are
> > describing is already solved and defined by current stable kernel ABI.
> > 
> >>> Really! Not a good idea. Plus I still see this as abusing kernel
> >>> API/ABI as resolution should be handled differently as you are
> >>> proposing.
> >> 
> >> I don't understand what you say here. Where are we abusing kernel
> >> API/ABI?
> > 
> > I mean that we already have stable API/ABI how to export size of input
> > screen from kernel to userspace. And you want to rescale event data
> > directly in kernel to workaround problem of screen size. So I think this
> > is abusing API/ABI as kernel already have API for it.
> 
> BR and thanks,
> Nikolaus
> 

-- 
Pali Rohár
pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
