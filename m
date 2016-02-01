From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Mon, 1 Feb 2016 23:17:54 +0100
Message-ID: <CAJZ5v0gOtJE24Hu8R9jx7kBktmd__qFUNF_KnsCDLwgidskUvw@mail.gmail.com>
References: <20160126224804.GB19432@atomide.com>
	<CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
	<20160126232212.GE19432@atomide.com>
	<CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
	<20160126235222.GF19432@atomide.com>
	<CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
	<20160128165810.GA19432@atomide.com>
	<CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
	<20160201181135.GL19432@atomide.com>
	<20160201220657.GO19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160201220657.GO19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 1, 2016 at 11:06 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [160201 10:12]:
>> * Ulf Hansson <ulf.hansson@linaro.org> [160201 08:45]:
>> > On 28 January 2016 at 17:58, Tony Lindgren <tony@atomide.com> wrote:
>> > >
>> > > The MMC hardware will not get idled properly any longer blocking any
>> > > deeper idle states.
>> > >
>> > >> Did the driver not probe successfully the second try? If so, what happened.
>> > >
>> > > It probes fine after a -EPROBE_DEFER on the vmmc i2c regulator.
>> > > But the PM runtime usecounts are wrong.
>> >
>> > Okay. How did you verify this?
>>
>> Well that was just based on what I see in the dmesg:
>>
>> omap_device: omap_device_enable() called from invalid state 1
>
> So we're now missing the idling of hardare after -EPROBE_DEFER..
> Does the following patch work for you guys?
>
> Regards,
>
> Tony
>
> 8< -----------------------------
> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 1 Feb 2016 13:40:46 -0800
> Subject: [PATCH] PM / runtime: Fix PM runtime reinit
>
> Commit 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at probe
> error and driver unbind") added calls to reinit the PM runtime. This
> however broke things for idling the hardware at least if the driver
> probing has pm_runtime_set_autosuspend_delay() and -EPROBE_DEFER
> happens.
>
> Fix the problem by adding a check for configured autosuspend if
> RPM_ACTIVE is set. Then reset the autosuspend, and suspend the
> device to make sure the hardware gets idled.
>
> Let's also cut down one level of nestedness and remove a negative
> test by returning early if pm_runtime_enabled(dev) as there is
> currently nothing for us to do in that case.
>
> Fixes: 5de85b9d57ab ("PM / runtime: Re-init runtime PM states at
> probe error and driver unbind")
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -1419,17 +1419,25 @@ void pm_runtime_init(struct device *dev)
>   */
>  void pm_runtime_reinit(struct device *dev)
>  {
> -       if (!pm_runtime_enabled(dev)) {
> -               if (dev->power.runtime_status == RPM_ACTIVE)
> +       if (pm_runtime_enabled(dev))
> +               return;
> +
> +       if (dev->power.runtime_status == RPM_ACTIVE) {
> +               if (dev->power.use_autosuspend) {
> +                       __pm_runtime_use_autosuspend(dev, false);
> +                       pm_runtime_suspend(dev);

This won't work, because runtime PM is disabled at this point.

What about doing this instead:

               if (dev->power.use_autosuspend)
                       __pm_runtime_use_autosuspend(dev, false);

               pm_runtime_set_suspended(dev);


> +               } else {
>                         pm_runtime_set_suspended(dev);
> -               if (dev->power.irq_safe) {
> -                       spin_lock_irq(&dev->power.lock);
> -                       dev->power.irq_safe = 0;
> -                       spin_unlock_irq(&dev->power.lock);
> -                       if (dev->parent)
> -                               pm_runtime_put(dev->parent);
>                 }
>         }
> +
> +       if (dev->power.irq_safe) {
> +               spin_lock_irq(&dev->power.lock);
> +               dev->power.irq_safe = 0;
> +               spin_unlock_irq(&dev->power.lock);
> +               if (dev->parent)
> +                       pm_runtime_put(dev->parent);
> +       }
>  }
>
>  /**
