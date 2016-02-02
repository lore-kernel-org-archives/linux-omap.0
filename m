From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 08:49:10 -0800
Message-ID: <20160202164910.GV19432@atomide.com>
References: <CAPDyKFqQb+jtTpZbq6EvbfAk28yVkgdtiOswngNH_BjCWBDxFg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602021112320.1653-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [160202 08:17]:
> On Tue, 2 Feb 2016, Ulf Hansson wrote:
> > 
> > Your observations is correct. The hardware will be kept active
> > in-between the probe attempts (and thus also if probing fails).
> > Although, that's not a regression as that's the behaviour you get from
> > runtime PM, when drivers are implemented like omap_hsmmc.
> 
> Perhaps this is what we should do.  If probing gets deferred a few 
> times, doing runtime suspends and resumes in between will be a waste of 
> time.

That sounds like an optimization though. We'd still have to disable
the deviec somehow after deferred probe gives up.

> ?  pm_runtime_put_sync() _already_ does not respect the autosuspend 
> mode.  If you want to respect it, you have to call 
> pm_runtime_put_sync_autosuspend() instead.

I think you found the real bug there. So the right fix is to
call pm_runtime_put_sync_autosuspend() at the end of failed
probe in omap_hsmmc. Let me give that a try here.

Can we add some warning to pm_runtime_put_sync() about that?

Regards,

Tony
