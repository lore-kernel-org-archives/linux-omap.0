From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 3 Feb 2016 19:02:32 +0100
Message-ID: <CAPDyKFrsbW+vOoKBDvkNbJa=aUZE1EcikCqrAuO4cv+TkW-FnA@mail.gmail.com>
References: <20160201232833.GR19432@atomide.com>
	<Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
	<20160202030533.GT19432@atomide.com>
	<CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
	<CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
	<20160202163536.GU19432@atomide.com>
	<CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
	<20160202234145.GC19432@atomide.com>
	<CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
	<20160203162705.GG19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160203162705.GG19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 3 February 2016 at 17:27, Tony Lindgren <tony@atomide.com> wrote:
>
>> >> To me, it's the responsible of the PM domain to *help* with the
>> >> synchronization, not prevent it as it currently does.
>> >
>> > The problem is that the hardware state gets out of sync with
>> > PM runtime. And that's going to be a pain to debug later on.
>>
>> I don't see the problem, but of course you know omap for better than I do.
>
> Well there's also the long term maintenance aspect at least I
> need to consider.
>
>> So if you are concerned about this, perhaps adding a dev_dbg print
>> when the omap hwmod's ->runtime_suspend() callback returns zero could
>> be a way forward?
>
> If we downgrade it to a debug statement or a warning, we'll soon end
> up with even more driver specific warnings than we already have.
> And I don't want to be chasing people around to fix their drivers
> for eavery new driver that gets submitted.
>
> Also, without this error I would not even originally have noticed we
> have a problem :) So I suggest the following:

Well, I am actually not removing that existing warning in the
omap_device_enable(), as it's being called from other places as well.

It's just the runtime PM path that's being changed.

>
> 1. I'll do a series of patches to fix up the handful of omap
>    specific drivers with pm_runtime_use_autosuspend() that depend
>    on omap_device
>
> 2. I'll also do a patch to improve the omap_device error message
>    so new drivers are easy to fix. Something like:
>
>   "%() called from invalid state %d, use pm_runtime_put_sync_suspend()?"
>
> Does that sounds OK to you?

Sure.

>
> Regards,
>
> Tony

One more thing though. I just realized that you have yet another issue
to consider going for the approach fixing *only* drivers.

Let me summarize it here:

If userspace has prevented runtime PM (pm_runtime_forbid()) when a
driver becomes unbound, the driver will not be able to suspend the
device by using any of the pm_runtime_suspend() APIs, as the usage
count is isn't zero.

As pm_runtime_reinit() is invoked as part of the driver unbind
sequence, the runtime PM status goes out of sync. A following driver
rebind will then trigger the warning when the PM domain's
->runtime_resume() callback gets invoked. Again, forever preventing
the device from being runtime suspended.

How do you intend to solve this case?
I guess there are two options, pick up the patch I posted for omap
hwmod or make use of pm_runtime_force_suspend() in the driver.

Kind regards
Uffe
