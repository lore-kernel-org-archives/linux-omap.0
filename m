From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 10:45:34 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602031034360.2041-100000@iolanthe.rowland.org>
References: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpNRc3Nf9ofXhZrfBa54vXMxWboDScCrYFrZy97m8Y5gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 3 Feb 2016, Ulf Hansson wrote:

> > Let me summarize my understanding of this thread so far.
> >
> > It looks like the omap3 code initializes hardware in ->probe() and
> > then it may return -EPROBE_DEFER due to some unmet dependencies.  In
> > that case the hardware is not reset to the previous state and the
> > runtime PM framework is left in the state that corresponds to the
> > current hardware state.  Before we had pm_runtime_reinit(), everything
> > worked as expected on the second ->probe() call, because things were
> > in sync then.
> 
> Correct!
> 
> Before pm_runtime_reinit(), the failing probe case (-EPROBE_DEFER)
> worked fine because the HW state and the runtime PM status was in
> sync. The device was powered and the runtime PM status was RPM_ACTIVE.
> 
> >
> > The introduction of pm_runtime_reinit() changed the situation and now
> > effectively the hardware is required to be reset to the initial state
> > if -EPROBE_DEFER is to be returned too.
> 
> Not correct. The hardware doesn't need a reset as it stays powered
> after a failed probe.
> 
> Instead, only the runtime PM status needs to be synchronized with the
> HW state the next probe attempt.

In other words, the probe routine assumes the actual state is the same
as the PM status.  This may have been true before pm_runtime_reinit()
came along, but it's not true now.

> In other words, when the PM domain's ->runtime_resume() callbacks gets
> called due to a pm_runtime_get_sync() in the second probe attempt, it
> may find that the HW is already powered and can return zero instead of
> resetting it.

What's wrong with going ahead and resetting the hardware anyway?

Alan Stern

