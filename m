From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 08:27:06 -0800
Message-ID: <20160203162705.GG19432@atomide.com>
References: <20160201232833.GR19432@atomide.com>
 <Pine.LNX.4.44L0.1602011844540.2869-100000@netrider.rowland.org>
 <20160202030533.GT19432@atomide.com>
 <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <CAPDyKFras1o13WBZzaZ_Snnj5TBQQFWKr=PtCjUvwe+yGPQn9w@mail.gmail.com>
 <20160202163536.GU19432@atomide.com>
 <CAPDyKFosQjkHDVSvy67+hstjjFseXQP5WYXrJE19GgVFYJ099w@mail.gmail.com>
 <20160202234145.GC19432@atomide.com>
 <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqLi8xOUeoxUTAmif5QrOjVpV_2CDLv4hjO_C9iOnv+5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Ulf Hansson <ulf.hansson@linaro.org> [160203 02:24]:
> On 3 February 2016 at 00:41, Tony Lindgren <tony@atomide.com> wrote:
>
> > Well we actually pretty much have devices in that state to start
> > with.
> 
> That's not true, not even for omap.
> 
> There are definitely devices which HW state is reflected by RPM_ACTIVE
> at boot. It's the responsible of the subsystem/driver (including PM
> domains) to make sure the runtime PM status is updated accordingly, to
> reflect the real HW state.
> 
> For omap hwmod, at device registration in omap_device_build_from_dt()
> it may actually invoke pm_runtime_set_active() if the device is
> enabled. To my understanding, that's done to synchronize the real HW
> state with the runtime PM status, right?

Sure we do have cases where the bootloader state needs to be
preserved for some devices. Like GPIO pin state to power memory on
some devices! :)

> >> To me, it's the responsible of the PM domain to *help* with the
> >> synchronization, not prevent it as it currently does.
> >
> > The problem is that the hardware state gets out of sync with
> > PM runtime. And that's going to be a pain to debug later on.
> 
> I don't see the problem, but of course you know omap for better than I do.

Well there's also the long term maintenance aspect at least I
need to consider.

> So if you are concerned about this, perhaps adding a dev_dbg print
> when the omap hwmod's ->runtime_suspend() callback returns zero could
> be a way forward?

If we downgrade it to a debug statement or a warning, we'll soon end
up with even more driver specific warnings than we already have.
And I don't want to be chasing people around to fix their drivers
for eavery new driver that gets submitted.

Also, without this error I would not even originally have noticed we
have a problem :) So I suggest the following:

1. I'll do a series of patches to fix up the handful of omap
   specific drivers with pm_runtime_use_autosuspend() that depend
   on omap_device

2. I'll also do a patch to improve the omap_device error message
   so new drivers are easy to fix. Something like:

  "%() called from invalid state %d, use pm_runtime_put_sync_suspend()?"

Does that sounds OK to you?

Regards,

Tony
