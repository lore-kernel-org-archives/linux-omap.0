From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 10:54:51 -0800
Message-ID: <20160202185450.GY19432@atomide.com>
References: <20160202180555.GW19432@atomide.com>
 <Pine.LNX.4.44L0.1602021335170.1653-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602021335170.1653-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [160202 10:44]:
> On Tue, 2 Feb 2016, Tony Lindgren wrote:
> 
> > * Tony Lindgren <tony@atomide.com> [160202 08:50]:
> > > * Alan Stern <stern@rowland.harvard.edu> [160202 08:17]:
> > > 
> > > > ?  pm_runtime_put_sync() _already_ does not respect the autosuspend 
> > > > mode.  If you want to respect it, you have to call 
> > > > pm_runtime_put_sync_autosuspend() instead.
> > > 
> > > I think you found the real bug there. So the right fix is to
> > > call pm_runtime_put_sync_autosuspend() at the end of failed
> > > probe in omap_hsmmc. Let me give that a try here.
> > 
> > Nope that's not it but getting closer.
> > 
> > The following seems to make things behave for me. Now the
> > question is.. Does it have some undesired side effects?
> 
> Yes, it does.

Yeah noticed..

> I'm still not clear on what you want to accomplish.  It sounds like you 
> want to perform a runtime suspend following the last probe (if the 
> probe fails), and in between probes you don't really care (although it 
> would be preferable to avoid suspending).

I'd like to have pm_runtime_put_sync() disable the hardware after
the initial failed probe. Currently that does not happen unless
pm_runtime_dont_use_autosuspend() is called before pm_runtime_put_sync().

> Does pm_runtime_use_autosuspend() get called by the probe routine?  If 
> it does, then perhaps you can get what you want by having the probe 
> routine call pm_runtime_dont_use_autosuspend() whenever it's about to 
> return an error -- particularly -EDEFER.

Yes so far that's the only fix that seems to work like I posted
earlier. But is that the right fix though?

If we wanted to have some generic fix, it seems we would have to pass
a new flag in pm_runtime_put_sync() to ignore any autosuspend
configuration. But I don't know if that's what we want to or should
do though?

Regards,

Tony
