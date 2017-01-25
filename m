From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 13:17:14 -0800
Message-ID: <20170125211714.GA36291@dtor-ws>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws>
 <20170125192711.GB27255@dtor-ws>
 <20170125203907.df2elgy3ao2o2e3h@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125203907.df2elgy3ao2o2e3h@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acp>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 08:39:07PM +0000, Mark Brown wrote:
> On Wed, Jan 25, 2017 at 11:27:11AM -0800, Dmitry Torokhov wrote:
> 
> > For the record, the main issue for the drivers, which is being solved by
> > exposing power supplies to the driver, is the following:
> 
> > 1. We suspend the device. Since there is no regulators the driver
> > assumes that it will retain it's state upon resume
> 
> That's *not* a sensible thing for drivers to assume regardless of the
> presence or absence of explicitly controlled regulators, that just seems
> like a plain old driver bug.  Even if there are regulators that doesn't
> mean there isn't a suspend mode configuration that disables those
> regulators.

That means your platform description is incomplete, AKA a plain old
device tree bug.

> 
> > I would really hate to go through _every_ driver and add the following
> > code to the resume path:
> > 
> > #if IS_ENABLED(CONFIG_ACPI)
> > 	if (acpi_device_was_powered_off_between_suspend_and_now(dev)) {
> > 		completely_reinitialize_device(dev);
> > 	}
> > #endif
> 
> That's not an ACPI thing, unless the device thinks it's actively
> providing a wakeup source then if the system suspends the driver should
> not be surprised to have power pulled - that's pretty normal.  If the
> driver is a wakeup source then it's a bit different.

>From the practical standpoint many drivers make this assumption because
this shortens resume time for device. I.e. it makes difference whether
we go through full controller reset, possibly reloading firmware, and
applying desired configuration, versus taking the chip out of deep sleep
mode.

The decision on resume time vs power draw is up to the platform
designers of course.

So if we indeed saying that drivers should expect handling power loss
even when devices are not on a hot-pluggable buses then we need a
generic API for querying whether device lost it's state or not.

Thanks.

-- 
Dmitry
