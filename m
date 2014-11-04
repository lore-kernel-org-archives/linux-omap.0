From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mfd: twl4030-power: Fix poweroff with PM configuration
 enabled
Date: Tue, 4 Nov 2014 07:42:32 -0800
Message-ID: <20141104154231.GP31454@atomide.com>
References: <20141102180756.GH31454@atomide.com>
 <5458D29E.50908@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5458D29E.50908@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Lee Jones <lee.jones@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Igor Grinberg <grinberg@compulab.co.il> [141104 05:22]:
> Hi Tony,
> 
> On 11/02/14 20:07, Tony Lindgren wrote:
> > Commit e7cd1d1eb16f ("mfd: twl4030-power: Add generic reset
> > configuration") enabled configuring the PM features for twl4030.
> > 
> > This caused poweroff command to fail on devices that have the
> > BCI charger on twl4030 wired, or have power wired for VBUS.
> > Instead of powering off, the device reboots. This is because
> > voltage is detected on charger or VBUS with the default bits
> > enabled for the power transition registers.
> > 
> > To fix the issue, let's just clear VBUS and CHG bits as we want
> > poweroff command to keep the system powered off.
> 
> What about devices that really need to start once VBUS or CHG is connected?

More handling can be added for some cases. With this patch the
poweron bits will clear to defaults if power is completely removed.
So start-up with VBUS and CHG works in that case.

However, if you have a battery connected, and you poweroff, with
this patch the device won't power up with VBUS or CHG connected.

Note that most battery operated devices are not using the charger
on twl4030 because it has issues charging a completely empty
battery AFAIK. So most battery powered devices have been using an
external USB charger chip that's not affected by this patch.

We could consider exporting a function for the charger driver to
configure the poweron mask. And we could also consider passing a
mask in ti,use_poweroff = 0xff.

> It seems to me that forcing these bits on power off can break that kind of
> devices and these settings should really be board specific.
> What do you think?

There's a patch series for "[RFC,01/16] kernel: Add support for
poweroff handler call chain" that should help with that. For sure
the poweroff handling needs to be board specific as some systems
may need to use a GPIO to shut off a regulator powering something
before powering off the SoC.

Regards,

Tony
