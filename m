From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 16:24:55 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602021614430.1653-100000@iolanthe.rowland.org>
References: <CAPDyKFokWcLSCAh_TX-j-df_M1hN8Qw1gbQt--SyWccGCPiN5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFokWcLSCAh_TX-j-df_M1hN8Qw1gbQt--SyWccGCPiN5Q@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Ulf Hansson wrote:

> > ?  pm_runtime_put_sync() _already_ does not respect the autosuspend
> > mode.  If you want to respect it, you have to call
> > pm_runtime_put_sync_autosuspend() instead.
> 
> Then there's a bug in the runtime PM core.
> 
> From Tony's regression report and from mine own local runtime PM test
> driver, I can see that the device doesn't get RPM_SUSPENDED (the
> ->runtime_suspend() callback isn't called), even when the usage count
> is zero - when pm_runtime_put_sync() is called.

Ah, yes -- I see what's going on.  pm_runtime_put_sync() calls 
__pm_runtime_idle(), rather than __pm_runtime_suspend().  And the idle 
routine always forces RPM_AUTO on.

So what I said was wrong.  pm_runtime_put_sync() respects the driver's 
settings for autosuspend, whereas pm_runtime_put_sync_suspend() and 
pm_runtime_put_sync_autosuspend() override the settings.

> To find the sequence of runtime PM commands, go ahead an have look in
> the omap_hsmmc driver. The problem occurs when the driver bails out in
> probe, when it receives -EPROBE_DEFER when fetching regulators.
> 
> I have some more data to share on this problem from my runtime PM test
> driver. I will try my best to share it tomorrow.

> >> 2)
> >> Change the failing drivers, to before calling pm_runtime_put_sync()
> >> also invoke pm_runtime_dont_use_autosusend(). Or other similar
> >> approach.
> >
> > Given the above, this seems unnecessary.
> 
> Okay, so you are saying that the pm_runtime_put_sync() should idle the
> device even if autosuspend is in use. That seems reasonable, I will
> look into this problem.

Heh -- you are the person who did it.  :-)  See commit d66e6db28df3 
("PM / Runtime: Respect autosuspend when idle triggers suspend").

I guess the intention was that if the driver wants to specify whether 
autosuspend should be respected, it should implement an rpm_idle 
callback routine.

Alan Stern

