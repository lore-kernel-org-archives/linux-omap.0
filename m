From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
Date: Thu, 4 Feb 2016 17:09:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Thu, 4 Feb 2016, Ulf Hansson wrote:

> I am really not questioning the autosuspend feature at all, it's a
> really great feature!
> 
> Now, I question the minor benefit we actually gain from having the
> runtime PM core to update the mark in rpm_resume().

As Tony pointed out, it prevents some devices from going to sleep right 
away.

> To me, the best decision when to update the mark is know by the
> driver/subsystem for the device and not the core.
> 
> In most cases the mark will be updated after a request has been
> completed, which leads to one unnecessary update at rpm_resume().

Sure, but that update is a simple assignment statement.  It's about as 
cheap as you can get, short of doing nothing at all.

> In this path (the resume), you really want to keep latencies to a
> minimum and for sure not do unnecessary things.
> 
> >
> > Perhaps you think that it's silly to behave that way in this case,
> > because the device wasn't accessed at all during the time it was at
> > full power.  That's a valid objection, but the proper solution is not
> > to revert the 56f487c78015 commit.  Rather, change the driver to avoid
> > doing a pm_runtime_resume_sync until you _know_ that the device will be
> > accessed soon.
> 
> That's not always going to work.
> 
> Sometimes you need to access the device when trying to probe. Failing
> later in probe, shows just *one* case where it doesn't make sense to
> update the last busy mark. I suspect there may be other cases as well.

I don't follow your reasoning.  If you don't update the last_busy mark 
then the probe fails, the device goes to sleep immediately, and then 
wakes up again a fraction of a second later for another probe attempt 
(if the error was -EDEFER).  Thus you get an unnecessary suspend 
followed by an unnecessary resume.

If the error was something other than -EDEFER and there will be no more 
probes, then yes -- the device remains at full power for longer than 
necessary.  But how often does that happen?  In general, people have 
drivers that _do_ work with their devices.

> Of course one can always use runtime PM APIs which overrides the
> autosuspend mode, so it's not a big deal.

Or turn autosuspend off completely when you know you're not going to
want it any more.  True.

Alan Stern

