From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 13:03:46 -0800
Message-ID: <20160202210345.GZ19432@atomide.com>
References: <20160202185450.GY19432@atomide.com>
 <Pine.LNX.4.44L0.1602021402250.1653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602021402250.1653-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [160202 11:17]:
> On Tue, 2 Feb 2016, Tony Lindgren wrote:
> > I'd like to have pm_runtime_put_sync() disable the hardware after
> > the initial failed probe. Currently that does not happen unless
> > pm_runtime_dont_use_autosuspend() is called before pm_runtime_put_sync().
> 
> pm_runtime_put_sync() doesn't do anything to the hardware if the usage
> count was > 1, because after the decrement it's still nonzero.  Where
> is the particular call of pm_runtime_put_sync() that you're interested
> in, and what is the usage count when it runs?  It's not at all unusual
> for the usage count to be > 1 during a probe.

The usage count is 0 at that point, it seems the be the RPM_AUTO
causing the issues that we set at the end of rpm_idle().

> Also, what is autosuspend_delay set to for your device?  And is 
> runtime_auto set?

It's 100 at that point, see the commented snippet below from
omap_hsmmc_probe():

	pm_runtime_enable(host->dev);
	pm_runtime_get_sync(host->dev);
	pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
	/* NOTE: pm_runtime_dont_use_autosuspend(host->dev) needed here? */
	pm_runtime_use_autosuspend(host->dev);
	...
	/* gets -EPROBE_DEFER */
err_irq:
	...
	pm_runtime_put_sync(host->dev);
        pm_runtime_disable(host->dev);
	/* NOTE: suspend callback never gets called unless
	 * pm_runtime_dont_use_autosuspend() is called
	 * before pm_runtime_put_sync() above.
	 */
	 ...

> > > Does pm_runtime_use_autosuspend() get called by the probe routine?  If 
> > > it does, then perhaps you can get what you want by having the probe 
> > > routine call pm_runtime_dont_use_autosuspend() whenever it's about to 
> > > return an error -- particularly -EDEFER.
> > 
> > Yes so far that's the only fix that seems to work like I posted
> > earlier. But is that the right fix though?
> 
> No, not really.  Ideally you would leave autosuspend turned on.  The 
> delay would be long enough to that after -EDEFER, another probe would 
> start before the delay expired.  But shortly after the last probe 
> attempt, the delay would expire and the device would then be put in low 
> power.

But then what about the new reinit function? To me it seems that
we should not attempt to maintain a state from the earlier failed
probe. Or are you thinking we just skip the reinit if autosuspend
is set?

> > If we wanted to have some generic fix, it seems we would have to pass
> > a new flag in pm_runtime_put_sync() to ignore any autosuspend
> > configuration. But I don't know if that's what we want to or should
> > do though?
> 
> I don't think so.

So should we just establish a policy that pm_runtime_use_autosuspend()
needs to be paired with pm_runtime_dont_use_autosuspend() for
pm_runtime_put_sync() to work?

Regards,

Tony
