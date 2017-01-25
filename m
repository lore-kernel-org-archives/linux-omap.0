From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/7] Implement generic regulator constraints parsing for
 ACPI and OF
Date: Wed, 25 Jan 2017 11:27:11 -0800
Message-ID: <20170125192711.GB27255@dtor-ws>
References: <20170125000641.25520-1-furquan@chromium.org>
 <20170125124911.dxveow7bo3zw5jcc@sirena.org.uk>
 <CAJZ5v0hHSadH1KLOGg029VU2qrY900ak0=NnH5HPBKZ=FpB7HQ@mail.gmail.com>
 <CAEGmHFG1d24k3+qT_aoqRmPFzciAbNObCnzY1d8pQWjEW+3HxA@mail.gmail.com>
 <20170125182319.GB25470@leverpostej>
 <20170125182955.uznr5ehpx4dabcon@sirena.org.uk>
 <20170125184432.GA27255@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170125184432.GA27255@dtor-ws>
Sender: linux-acpi-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Furquan Shaikh <furquan@chromium.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, ACPI Devel Maling List <linux-acp>
List-Id: linux-omap@vger.kernel.org

On Wed, Jan 25, 2017 at 10:44:32AM -0800, Dmitry Torokhov wrote:
> On Wed, Jan 25, 2017 at 06:29:55PM +0000, Mark Brown wrote:
> > On Wed, Jan 25, 2017 at 06:23:20PM +0000, Mark Rutland wrote:
> > > On Wed, Jan 25, 2017 at 08:56:42AM -0800, Furquan Shaikh wrote:
> > 
> > > > That is the reason why the recent change to add ACPI support to fixed
> > > > regulators was done
> > > > (https://github.com/torvalds/linux/blob/master/drivers/regulator/fixed.c#L100).
> > 
> > > To be honest, I'm surprised this got merged.
> > 
> > My understanding was that it was instantiated from another device as an
> > implementation detail of that device, letting it say "this GPIO should
> > be handled as a regulator".
> > 
> > > Mark, this was added in this cycle; can we please rip that out for now?
> > 
> > If it's instantiated directly we probably should.
> > 
> > > We can certainly come up with something that allows drivers to support
> > > both, but trying to do this without updating drivers opens a huge set of
> > > problems.
> > 
> > I think there's a reasonable chance that any ACPI specs could be written
> > in such a way as to allow transparent support in Linux, the main thing
> > I'd worry about is naming issues.
> 
> So if I am reading this correctly, currently ACPI does not expose power
> supplies directly, but rather ties them to the device power state (D0,
> D3cold, etc). Linux drivers do not usually follow that state model and
> expect to have all their power supplies be given to them and then
> figures out what to do with them itself. Given that, what do we do? Do
> we map only entries from _PR3 so they are available to drivers via
> regulator_get()? Or we ask the standard to add method enumerating all
> supplies?

For the record, the main issue for the drivers, which is being solved by
exposing power supplies to the driver, is the following:

1. We suspend the device. Since there is no regulators the driver
assumes that it will retain it's state upon resume
2. System goes into some sleep state
3. System wakes up
4. Device goes through resume, normally disabling wakeup interrupt and
enabling normal processing
5. We end up with non functioning device because the firmware actually
cut the power off without the driver knowing anything about it.

I would really hate to go through _every_ driver and add the following
code to the resume path:

#if IS_ENABLED(CONFIG_ACPI)
	if (acpi_device_was_powered_off_between_suspend_and_now(dev)) {
		completely_reinitialize_device(dev);
	}
#endif

Thanks.

-- 
Dmitry
