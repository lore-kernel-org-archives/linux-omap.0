From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sat, 28 Jan 2017 11:33:42 -0800
Message-ID: <20170128193342.GB38136@dtor-ws>
References: <cover.1482936802.git.hns@goldelico.com>
 <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Petr Cvek <petr>
List-Id: linux-omap@vger.kernel.org

Hi Nikolaus,

On Wed, Dec 28, 2016 at 03:53:16PM +0100, H. Nikolaus Schaller wrote:
> commit b98abe52fa8e ("Input: add common DT binding for touchscreens")
> introduced common DT bindings for touchscreens [1] and a helper function to
> parse the DT.
> 
> commit ed7c9870c9bc ("Input: of_touchscreen - add support for inverted / swapped axes")
> added another helper for parsing axis inversion and swapping
> and applying them to x and y coordinates.
> 
> Both helpers have been integrated to accommodate any orientation of the
> touch panel in relation to the LCD.
> 
> A new feature is to introduce scaling the min/max ADC values to the screen
> size.
> 
> This makes it possible to pre-calibrate the touch so that is (almost)
> exactly matches the LCD pixel coordinates it is glued onto. This allows to
> well enough operate the touch before a user space calibration step can
> improve the precision.

I question whether doing scaling in kernel is really right solution.

Why do you want this? If your touch resolution is lower than your screen
then it might be useful, but if it is lower then you are losing data
that can be very helpful for gesture recognition, and I hope you design
your userspace so it can handle not only "bad" hardware, but "good" as
well. And even with "bad" there are a lot of tricks that can be done to
get "better" touch position in userspace.

> 
> Please note that the old ti,fuzz properties have been removed since they
> are replaced by the common bindings touchscreen-fuzz-x/y/z.
> 
> Finally, calculate_pressure has been renamed to calculate_resistance
> because that is what it is doing.

That is not what your patch does though. In the presence of
"ti,report-resistance" parameter you start reporting resistance through
ABS_PRESSURE without any indication to the userspace that meaning of
event changed. This is no better if than reporting it through ABS_X. You
should not override meaning of input events.

Thanks.

-- 
Dmitry
