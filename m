From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Thu, 4 Feb 2016 11:20:03 +0100
Message-ID: <CAPDyKFr3jqh5bDFOuKLgomhQ2P9+yN5Ps8E0CH8r-oOjvBuswg@mail.gmail.com>
References: <20160202210345.GZ19432@atomide.com>
	<Pine.LNX.4.44L0.1602021626540.1653-100000@iolanthe.rowland.org>
	<20160202234626.GD19432@atomide.com>
	<CAJZ5v0hdDdFDiieDnsjummg6F+nV7fi=gFa=oFweyP7-ApsHrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hdDdFDiieDnsjummg6F+nV7fi=gFa=oFweyP7-ApsHrQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Tony Lindgren <tony@atomide.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 3 February 2016 at 18:18, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Feb 3, 2016 at 12:46 AM, Tony Lindgren <tony@atomide.com> wrote:
>> * Alan Stern <stern@rowland.harvard.edu> [160202 13:46]:
>>> On Tue, 2 Feb 2016, Tony Lindgren wrote:
>>>
>>> > > Also, what is autosuspend_delay set to for your device?  And is
>>> > > runtime_auto set?
>>> >
>>> > It's 100 at that point, see the commented snippet below from
>>> > omap_hsmmc_probe():
>>> >
>>> >     pm_runtime_enable(host->dev);
>>> >     pm_runtime_get_sync(host->dev);
>>> >     pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
>>> >     /* NOTE: pm_runtime_dont_use_autosuspend(host->dev) needed here? */
>>> >     pm_runtime_use_autosuspend(host->dev);
>>> >     ...
>>> >     /* gets -EPROBE_DEFER */
>>> > err_irq:
>>> >     ...
>>> >     pm_runtime_put_sync(host->dev);
>>>
>>> You could try changing this to pm_runtime_put_sync_suspend().  But
>>> putting pm_runtime_dont_use_autosuspend() before the put_sync seems
>>> like a perfectly reasonable thing to do, especially if you feel you
>>> should reverse all the changes you made at the start.
>
> FWIW, I'd call pm_runtime_dont_use_autosuspend() before put_sync().
>
> After all, the driver doesn't want to use autosuspend going forward,
> so stating that explicitly looks like the right thing to do.

Just wanted to add yet some new findings while I was looking into this
regression.

So, the reason why pm_runtime_put_sync() doesn't idle the device in
these cases, is because autosuspend is respected and for some reason
the autosuspend timer hasn't expired.
I was wondering *why* the timer isn't considered as expired, because
the driver don't call pm_runtime_mark_last_busy() in the failing probe
case...

Then I realized the following commit was merged a few releases ago,
which makes the runtime PM core to invoke pm_runtime_mark_last_busy()
for us.

commit 56f487c78015936097474fd89b2ccb229d500d0f
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed May 13 16:36:32 2015 -0700
PM / Runtime: Update last_busy in rpm_resume

So, this commit actually causes the devices to stay active after a
failed probe attempt.

I think it's a good idea to revert this change, but what to you think?

Kind regards
Uffe
