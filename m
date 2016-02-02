From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 11:15:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Ulf Hansson wrote:

> On 2 February 2016 at 04:05, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Alan Stern <stern@rowland.harvard.edu> [160201 15:50]:
> >>
> >> You get here only if runtime PM is disabled, right?  So the rpm_idle
> >> call won't do anything -- "disabled" means don't make any callbacks.
> >
> > Hmm sorry yes I'm confused again. Yeah it looks like calling rpm_idle
> > just has a side effect that makes a difference here.
> >
> >> Tony, exactly what are you trying to do here?  Do you want this to
> >> invoke a runtime-PM callback in the subsystem, power domain, or driver?
> >> (Is there even a driver bound to the device when this function runs?)
> >
> > I guess I need to add more printks to figure out what's going on here.
> > But yeah, I'm not seeing the callback happening at the interconnect
> > level so hardware and PM runtime states won't match on the following
> > probe after -EPROBE_DEFER.
> >
> >> The function's name suggests that it merely resets the data stored in
> >> dev->power without actually touching the hardware.  Is that what you
> >> really want?
> >
> > I guess you mean pm_runtime_set_suspended() above? I'm seeing a state
> > where we now set pm_runtime_set_suspended() between failed device
> > probes and the device is still active in hardware.
> >
> > The patch below also helps with the problem and leaves out the
> > rpm_suspend() call from loop so it might give more hints.
> >
> > The difference here from what Rafael suggested earlier is calling
> > __pm_runtime_use_autosuspend() and then not calling
> > pm_runtime_set_suspended().
> >
> > However, it seems the below patch keeps hardware active in the
> > autoidle case though, so chances are there is more that needs to
> > be done here. Anyways, I'll try to debug it more tomorrow.
> >
> 
> Your observations is correct. The hardware will be kept active
> in-between the probe attempts (and thus also if probing fails).
> Although, that's not a regression as that's the behaviour you get from
> runtime PM, when drivers are implemented like omap_hsmmc.

Perhaps this is what we should do.  If probing gets deferred a few 
times, doing runtime suspends and resumes in between will be a waste of 
time.

> Instead of the suggested approaches, I think the regression should be
> fixed at the PM domain level (omap hwmod). I have attached a patch
> below, please give it try as it's untested.
> 
> To solve the other problem (allowing devices to become inactive
> in-between at probe failures), I see two options (not treated as
> regressions).
> 1)
> Change the behaviour of pm_runtime_put_sync(), to *not* respect the
> autosuspend mode.
> I think I prefer this option, as it seems like autosuspend should be
> respected only via the asynchronous runtime PM APIs.

?  pm_runtime_put_sync() _already_ does not respect the autosuspend 
mode.  If you want to respect it, you have to call 
pm_runtime_put_sync_autosuspend() instead.

> 2)
> Change the failing drivers, to before calling pm_runtime_put_sync()
> also invoke pm_runtime_dont_use_autosusend(). Or other similar
> approach.

Given the above, this seems unnecessary.

Alan Stern

