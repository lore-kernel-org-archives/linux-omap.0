From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Thu, 4 Feb 2016 22:11:55 +0100
Message-ID: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
References: <CAPDyKFr3jqh5bDFOuKLgomhQ2P9+yN5Ps8E0CH8r-oOjvBuswg@mail.gmail.com>
	<Pine.LNX.4.44L0.1602041059070.1515-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.1602041059070.1515-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 4 February 2016 at 17:04, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Thu, 4 Feb 2016, Ulf Hansson wrote:
>
>> Just wanted to add yet some new findings while I was looking into this
>> regression.
>>
>> So, the reason why pm_runtime_put_sync() doesn't idle the device in
>> these cases, is because autosuspend is respected and for some reason
>> the autosuspend timer hasn't expired.
>
> No doubt the autosuspend delay is longer than the time it takes for a
> probe to fail.
>
>> I was wondering *why* the timer isn't considered as expired, because
>> the driver don't call pm_runtime_mark_last_busy() in the failing probe
>> case...
>>
>> Then I realized the following commit was merged a few releases ago,
>> which makes the runtime PM core to invoke pm_runtime_mark_last_busy()
>> for us.
>>
>> commit 56f487c78015936097474fd89b2ccb229d500d0f
>> Author: Tony Lindgren <tony@atomide.com>
>> Date:   Wed May 13 16:36:32 2015 -0700
>> PM / Runtime: Update last_busy in rpm_resume
>>
>> So, this commit actually causes the devices to stay active after a
>> failed probe attempt.
>>
>> I think it's a good idea to revert this change, but what to you think?
>
> I disagree.  The whole idea of autosuspend is to prevent the device's
> power state from bouncing up and down too rapidly.  This implies that
> whenever the device gets resumed, we should wait at least the minimum
> autosuspend delay before allowing the next autosuspend.

I am really not questioning the autosuspend feature at all, it's a
really great feature!

Now, I question the minor benefit we actually gain from having the
runtime PM core to update the mark in rpm_resume().

To me, the best decision when to update the mark is know by the
driver/subsystem for the device and not the core.

In most cases the mark will be updated after a request has been
completed, which leads to one unnecessary update at rpm_resume().

In this path (the resume), you really want to keep latencies to a
minimum and for sure not do unnecessary things.

>
> Perhaps you think that it's silly to behave that way in this case,
> because the device wasn't accessed at all during the time it was at
> full power.  That's a valid objection, but the proper solution is not
> to revert the 56f487c78015 commit.  Rather, change the driver to avoid
> doing a pm_runtime_resume_sync until you _know_ that the device will be
> accessed soon.

That's not always going to work.

Sometimes you need to access the device when trying to probe. Failing
later in probe, shows just *one* case where it doesn't make sense to
update the last busy mark. I suspect there may be other cases as well.

Of course one can always use runtime PM APIs which overrides the
autosuspend mode, so it's not a big deal.

Kind regards
Uffe
