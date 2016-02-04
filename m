From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Thu, 4 Feb 2016 11:04:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602041059070.1515-100000@iolanthe.rowland.org>
References: <CAPDyKFr3jqh5bDFOuKLgomhQ2P9+yN5Ps8E0CH8r-oOjvBuswg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr3jqh5bDFOuKLgomhQ2P9+yN5Ps8E0CH8r-oOjvBuswg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 4 Feb 2016, Ulf Hansson wrote:

> Just wanted to add yet some new findings while I was looking into this
> regression.
> 
> So, the reason why pm_runtime_put_sync() doesn't idle the device in
> these cases, is because autosuspend is respected and for some reason
> the autosuspend timer hasn't expired.

No doubt the autosuspend delay is longer than the time it takes for a 
probe to fail.

> I was wondering *why* the timer isn't considered as expired, because
> the driver don't call pm_runtime_mark_last_busy() in the failing probe
> case...
> 
> Then I realized the following commit was merged a few releases ago,
> which makes the runtime PM core to invoke pm_runtime_mark_last_busy()
> for us.
> 
> commit 56f487c78015936097474fd89b2ccb229d500d0f
> Author: Tony Lindgren <tony@atomide.com>
> Date:   Wed May 13 16:36:32 2015 -0700
> PM / Runtime: Update last_busy in rpm_resume
> 
> So, this commit actually causes the devices to stay active after a
> failed probe attempt.
> 
> I think it's a good idea to revert this change, but what to you think?

I disagree.  The whole idea of autosuspend is to prevent the device's
power state from bouncing up and down too rapidly.  This implies that 
whenever the device gets resumed, we should wait at least the minimum 
autosuspend delay before allowing the next autosuspend.

Perhaps you think that it's silly to behave that way in this case,
because the device wasn't accessed at all during the time it was at
full power.  That's a valid objection, but the proper solution is not
to revert the 56f487c78015 commit.  Rather, change the driver to avoid
doing a pm_runtime_resume_sync until you _know_ that the device will be
accessed soon.

Alan Stern

