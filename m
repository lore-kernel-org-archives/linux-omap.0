From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Tue, 2 Feb 2016 14:16:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602021402250.1653-100000@iolanthe.rowland.org>
References: <20160202185450.GY19432@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202185450.GY19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2 Feb 2016, Tony Lindgren wrote:

> > I'm still not clear on what you want to accomplish.  It sounds like you 
> > want to perform a runtime suspend following the last probe (if the 
> > probe fails), and in between probes you don't really care (although it 
> > would be preferable to avoid suspending).
> 
> I'd like to have pm_runtime_put_sync() disable the hardware after
> the initial failed probe. Currently that does not happen unless
> pm_runtime_dont_use_autosuspend() is called before pm_runtime_put_sync().

pm_runtime_put_sync() doesn't do anything to the hardware if the usage
count was > 1, because after the decrement it's still nonzero.  Where
is the particular call of pm_runtime_put_sync() that you're interested
in, and what is the usage count when it runs?  It's not at all unusual
for the usage count to be > 1 during a probe.

Also, what is autosuspend_delay set to for your device?  And is 
runtime_auto set?

> > Does pm_runtime_use_autosuspend() get called by the probe routine?  If 
> > it does, then perhaps you can get what you want by having the probe 
> > routine call pm_runtime_dont_use_autosuspend() whenever it's about to 
> > return an error -- particularly -EDEFER.
> 
> Yes so far that's the only fix that seems to work like I posted
> earlier. But is that the right fix though?

No, not really.  Ideally you would leave autosuspend turned on.  The 
delay would be long enough to that after -EDEFER, another probe would 
start before the delay expired.  But shortly after the last probe 
attempt, the delay would expire and the device would then be put in low 
power.

> If we wanted to have some generic fix, it seems we would have to pass
> a new flag in pm_runtime_put_sync() to ignore any autosuspend
> configuration. But I don't know if that's what we want to or should
> do though?

I don't think so.

Alan Stern

