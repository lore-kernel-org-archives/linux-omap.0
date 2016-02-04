From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Thu, 4 Feb 2016 09:20:25 -0800
Message-ID: <20160204172025.GQ19432@atomide.com>
References: <CAPDyKFr3jqh5bDFOuKLgomhQ2P9+yN5Ps8E0CH8r-oOjvBuswg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602041059070.1515-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1602041059070.1515-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Alan Stern <stern@rowland.harvard.edu> [160204 08:05]:
> On Thu, 4 Feb 2016, Ulf Hansson wrote:
> 
> > Just wanted to add yet some new findings while I was looking into this
> > regression.
> > 
> > So, the reason why pm_runtime_put_sync() doesn't idle the device in
> > these cases, is because autosuspend is respected and for some reason
> > the autosuspend timer hasn't expired.
> 
> No doubt the autosuspend delay is longer than the time it takes for a 
> probe to fail.
> 
> > I was wondering *why* the timer isn't considered as expired, because
> > the driver don't call pm_runtime_mark_last_busy() in the failing probe
> > case...
> > 
> > Then I realized the following commit was merged a few releases ago,
> > which makes the runtime PM core to invoke pm_runtime_mark_last_busy()
> > for us.
> > 
> > commit 56f487c78015936097474fd89b2ccb229d500d0f
> > Author: Tony Lindgren <tony@atomide.com>
> > Date:   Wed May 13 16:36:32 2015 -0700
> > PM / Runtime: Update last_busy in rpm_resume
> > 
> > So, this commit actually causes the devices to stay active after a
> > failed probe attempt.
> > 
> > I think it's a good idea to revert this change, but what to you think?
> 
> I disagree.  The whole idea of autosuspend is to prevent the device's
> power state from bouncing up and down too rapidly.  This implies that 
> whenever the device gets resumed, we should wait at least the minimum 
> autosuspend delay before allowing the next autosuspend.

Yeah let's not revert 56f487c78015. Without that we have devices
falling right back to sleep.

Regards,

Tony
