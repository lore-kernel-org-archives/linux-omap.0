From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 08:09:51 -0800
Message-ID: <20160203160951.GF19432@atomide.com>
References: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [160203 07:46]:
> On Wed, 3 Feb 2016, Ulf Hansson wrote:
> 
> > > Let me summarize my understanding of this thread so far.
> > >
> > > It looks like the omap3 code initializes hardware in ->probe() and
> > > then it may return -EPROBE_DEFER due to some unmet dependencies.  In
> > > that case the hardware is not reset to the previous state and the
> > > runtime PM framework is left in the state that corresponds to the
> > > current hardware state.  Before we had pm_runtime_reinit(), everything
> > > worked as expected on the second ->probe() call, because things were
> > > in sync then.
> > 
> > Correct!

Well not quite correct. After failed probe PM runtime is set to reset
state while hardware is still enabled.

> > Before pm_runtime_reinit(), the failing probe case (-EPROBE_DEFER)
> > worked fine because the HW state and the runtime PM status was in
> > sync. The device was powered and the runtime PM status was RPM_ACTIVE.
> > 
> > >
> > > The introduction of pm_runtime_reinit() changed the situation and now
> > > effectively the hardware is required to be reset to the initial state
> > > if -EPROBE_DEFER is to be returned too.
> > 
> > Not correct. The hardware doesn't need a reset as it stays powered
> > after a failed probe.

It is really best to disable the hardware after a failed probe
like we do with pm_runtime_put_sync_(suspend)() and pm_runtime_disable().

This is because there may never be another probe attempt and we want
to have unclaimed devices shut off (or idled) for PM.

> > Instead, only the runtime PM status needs to be synchronized with the
> > HW state the next probe attempt.
>
> In other words, the probe routine assumes the actual state is the same
> as the PM status.  This may have been true before pm_runtime_reinit()
> came along, but it's not true now.
> 
> > In other words, when the PM domain's ->runtime_resume() callbacks gets
> > called due to a pm_runtime_get_sync() in the second probe attempt, it
> > may find that the HW is already powered and can return zero instead of
> > resetting it.

Certainly that should at least produce a warning in the hardware
specific implementation. It's a state mismatch between PM runtime
and the hardware specific implementation.

And as discussed, the problem does not exist as long as we understand
that we need to use pm_runtime_put_sync_suspend() if the driver has
set pm_runtime_use_autoidle(). Or else use the combination of
pm_runtime_dont_use_autoidle() and pm_runtime_put_sync().

> What's wrong with going ahead and resetting the hardware anyway?

Nothing, unless a state needs to be maintained for things like GPIO
pins power memory :)

Regards,

Tony
