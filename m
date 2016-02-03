From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Wed, 3 Feb 2016 10:48:25 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602031026460.2041-100000@iolanthe.rowland.org>
References: <20160202234626.GD19432@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202234626.GD19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Tony Lindgren wrote:

> * Alan Stern <stern@rowland.harvard.edu> [160202 13:46]:
> > On Tue, 2 Feb 2016, Tony Lindgren wrote:
> > 
> > > > Also, what is autosuspend_delay set to for your device?  And is 
> > > > runtime_auto set?
> > > 
> > > It's 100 at that point, see the commented snippet below from
> > > omap_hsmmc_probe():
> > > 
> > > 	pm_runtime_enable(host->dev);
> > > 	pm_runtime_get_sync(host->dev);
> > > 	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
> > > 	/* NOTE: pm_runtime_dont_use_autosuspend(host->dev) needed here? */
> > > 	pm_runtime_use_autosuspend(host->dev);
> > > 	...
> > > 	/* gets -EPROBE_DEFER */
> > > err_irq:
> > > 	...
> > > 	pm_runtime_put_sync(host->dev);
> > 
> > You could try changing this to pm_runtime_put_sync_suspend().  But
> > putting pm_runtime_dont_use_autosuspend() before the put_sync seems
> > like a perfectly reasonable thing to do, especially if you feel you
> > should reverse all the changes you made at the start.
> 
> They both seem to fix the problem.

So you could use either one.  In my opinion, the 
pm_runtime_dont_use_autosuspend() solution is a little cleaner.

> > The reinit function gets called too late to do what you want -- namely, 
> > put the hardware in a low-power state.
> 
> Right, the problem is the lack of suspend on the first probe. But
> for having autosuspend timeout long enough for the next probe
> would mean that we can't reset the PM runtime state in between.

That's one way to look at it.  But in principle you don't need to
suspend the device after an unsuccessful probe.  You can just leave it
at high power.  If this causes problems for a second probe, it's the 
second probe's own fault for assuming the actual state matches the PM 
status.

> > pm_runtime_put_sync() is supposed to follow the driver's wishes.  It
> > invokes the driver's runtime_idle callback if there is one, and the
> > callback routine can start a suspend or an autosuspend.  If there is no
> > callback, it will use whatever autosuspend setting the driver has set
> > up.  If you want to override the autosuspend setting, use
> > pm_runtime_put_sync_suspend() instead.
> 
> Yes.. That works too. I guess the thing to consider is if we should
> make pm_runtime_put_sync() always sync along the lines of a patch
> I posted earlier today. That could avoid quite a bit of confusion
> as already seen in this thread :)

As Rafael pointed out, pm_runtime_put_sync() has well-documented 
behavior.  It shouldn't be changed.  I don't see how changing the 
behavior would reduce anybody's confusion.  At least, anybody who reads 
the documentation carefully.

Alan Stern

