From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Mon, 1 Feb 2016 10:11:35 -0800
Message-ID: <20160201181135.GL19432@atomide.com>
References: <20160126224804.GB19432@atomide.com>
 <CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
 <20160126232212.GE19432@atomide.com>
 <CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
 <20160126235222.GF19432@atomide.com>
 <CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
 <20160128165810.GA19432@atomide.com>
 <CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160201 08:45]:
> On 28 January 2016 at 17:58, Tony Lindgren <tony@atomide.com> wrote:
> >
> > The MMC hardware will not get idled properly any longer blocking any
> > deeper idle states.
> >
> >> Did the driver not probe successfully the second try? If so, what happened.
> >
> > It probes fine after a -EPROBE_DEFER on the vmmc i2c regulator.
> > But the PM runtime usecounts are wrong.
> 
> Okay. How did you verify this?

Well that was just based on what I see in the dmesg:

omap_device: omap_device_enable() called from invalid state 1

> I think the easiest way would be to make sure the usage count is
> *one*, just before the omap_hsmmc calls mmc_add_host() in its
> ->probe() function.
> 
> If it's *two*, that confirms this theory.

Here's with use count dumped for one MMC:

omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
omap_hsmmc 4809c000.mmc: Got CD GPIO
omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
omap_hsmmc 4809c000.mmc: GPIO lookup for consumer cd
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
omap_hsmmc 4809c000.mmc: Got CD GPIO
omap_hsmmc 4809c000.mmc: GPIO lookup for consumer wp
omap_hsmmc 4809c000.mmc: using device tree for GPIO lookup
omap_hsmmc 4809c000.mmc: using lookup tables for GPIO lookup
omap_hsmmc 4809c000.mmc: lookup for GPIO wp failed
omap_hsmmc 4809c000.mmc: omap_device: omap_device_enable() called from invalid state 1
omap_hsmmc 4809c000.mmc: PM runtime use count: 0

So it seems you're right, it's the state not the count.

> > So one of the failing cases seems to be:
> >
> > 1. Device driver probe sets pm_runtime_set_autosuspend_delay()
> 
> Only when "someone" in-before has set the autosuspend delay to a
> negative value, this will affect the usage count.
> 
> I didn't find any in-kernel user that would set this for the
> omap_hsmmc device, so it needs to be done from userspace via sysfs. It
> would be really great if you could help to confirm this.

No nothing is setting that from userspace.

> But more importantly, I fail to understand why commit 5de85b9d57ab
> ("PM / runtime: Re-init runtime PM states at probe error and driver
> unbind"), is changing the behaviour in this regards.
> Potentially we might have a different runtime PM status than we had
> before when probing the second try, but how could that mess up the
> usage count...?

Yes I think you're right here, it's the state, not the count.

> Although, I wondering whether it could be that it's the PM domain
> that's preventing the omap_hsmmc device from becoming runtime
> suspended.
> 
> Perhaps the PM domain returns an error code from its
> ->runtime_suspend() callback?

We certainly see a warning there.

> Okay, so we definitely seem to have an issue with the changed runtime
> PM status (suspended) the second probe time.
> 
> That's indeed caused by 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind").

Yup.

> For example due to commit 5de85b9d57ab ("PM / runtime: Re-init runtime
> PM states at probe error and driver unbind"), the ->runtime_resume()
> callback seems now to be called twice in a row, without in-between
> having the ->runtime_suspend() callback being invoked. Does really the
> PM domain cope with that correctly?

That might explain the warning above.

> > BTW, do you have some hardware to test with that has PM runtime
> > implemnted and actually working with mainline kernel?
> 
> Oh, yes. Although I don't have an omap3, I wish I had.

OK good to hear. Anyways, getting an omap3 should be in tens of
whatever units if you need one to test with.

> Also, I have locally a "runtime PM test driver", which helps me to
> test various runtime PM sequences.

Now that would be good to have in the mainline kernel. Of course it
still is a very limited test.

Regards,

Tony
