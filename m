From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Wed, 3 Feb 2016 14:06:13 +0100
Message-ID: <CAJZ5v0jbOJc2m=cBrvAuMUHvY8_AQPdJEyt1w-dPikU5expeLA@mail.gmail.com>
References: <20160202210345.GZ19432@atomide.com>
	<Pine.LNX.4.44L0.1602021626540.1653-100000@iolanthe.rowland.org>
	<20160202234626.GD19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160202234626.GD19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 3, 2016 at 12:46 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Alan Stern <stern@rowland.harvard.edu> [160202 13:46]:
>> On Tue, 2 Feb 2016, Tony Lindgren wrote:
>>
>> > > Also, what is autosuspend_delay set to for your device?  And is
>> > > runtime_auto set?
>> >
>> > It's 100 at that point, see the commented snippet below from
>> > omap_hsmmc_probe():
>> >
>> >     pm_runtime_enable(host->dev);
>> >     pm_runtime_get_sync(host->dev);
>> >     pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY);
>> >     /* NOTE: pm_runtime_dont_use_autosuspend(host->dev) needed here? */
>> >     pm_runtime_use_autosuspend(host->dev);
>> >     ...
>> >     /* gets -EPROBE_DEFER */
>> > err_irq:
>> >     ...
>> >     pm_runtime_put_sync(host->dev);
>>
>> You could try changing this to pm_runtime_put_sync_suspend().  But
>> putting pm_runtime_dont_use_autosuspend() before the put_sync seems
>> like a perfectly reasonable thing to do, especially if you feel you
>> should reverse all the changes you made at the start.
>
> They both seem to fix the problem.
>
>> >         pm_runtime_disable(host->dev);
>> >     /* NOTE: suspend callback never gets called unless
>> >      * pm_runtime_dont_use_autosuspend() is called
>> >      * before pm_runtime_put_sync() above.
>> >      */
>> >      ...
>> >
>> > > > > Does pm_runtime_use_autosuspend() get called by the probe routine?  If
>> > > > > it does, then perhaps you can get what you want by having the probe
>> > > > > routine call pm_runtime_dont_use_autosuspend() whenever it's about to
>> > > > > return an error -- particularly -EDEFER.
>> > > >
>> > > > Yes so far that's the only fix that seems to work like I posted
>> > > > earlier. But is that the right fix though?
>> > >
>> > > No, not really.  Ideally you would leave autosuspend turned on.  The
>> > > delay would be long enough to that after -EDEFER, another probe would
>> > > start before the delay expired.  But shortly after the last probe
>> > > attempt, the delay would expire and the device would then be put in low
>> > > power.
>> >
>> > But then what about the new reinit function? To me it seems that
>> > we should not attempt to maintain a state from the earlier failed
>> > probe. Or are you thinking we just skip the reinit if autosuspend
>> > is set?
>>
>> The reinit function gets called too late to do what you want -- namely,
>> put the hardware in a low-power state.
>
> Right, the problem is the lack of suspend on the first probe. But
> for having autosuspend timeout long enough for the next probe
> would mean that we can't reset the PM runtime state in between.
>
>> That _is_ what you want, isn't it?  The alternative is to leave
>> dev->power.rpm_status set to RPM_ACTIVE, to match the hardware's actual
>> state.
>
> As far as I can tell things work just fine if the failed probe
> suspend the device at the end of the failed probe.
>
>> Given that the reinit function is supposed to restore the initial
>> settings, it probably ought to call pm_runtime_dont_use_autosuspend().
>> But that won't be enough to fix your problem.
>>
>> > > > If we wanted to have some generic fix, it seems we would have to pass
>> > > > a new flag in pm_runtime_put_sync() to ignore any autosuspend
>> > > > configuration. But I don't know if that's what we want to or should
>> > > > do though?
>> > >
>> > > I don't think so.
>> >
>> > So should we just establish a policy that pm_runtime_use_autosuspend()
>> > needs to be paired with pm_runtime_dont_use_autosuspend() for
>> > pm_runtime_put_sync() to work?
>>
>> Your understanding is slightly wrong.  pm_runtime_put_sync() _does_
>> work -- that is, it does what it's supposed to do.  The difficulty is
>> that what it's supposed to do doesn't match what you think.
>>
>> pm_runtime_put_sync() is supposed to follow the driver's wishes.  It
>> invokes the driver's runtime_idle callback if there is one, and the
>> callback routine can start a suspend or an autosuspend.  If there is no
>> callback, it will use whatever autosuspend setting the driver has set
>> up.  If you want to override the autosuspend setting, use
>> pm_runtime_put_sync_suspend() instead.
>
> Yes.. That works too. I guess the thing to consider is if we should
> make pm_runtime_put_sync() always sync along the lines of a patch
> I posted earlier today. That could avoid quite a bit of confusion
> as already seen in this thread :)

No, we shouldn't.

As I said, the current behavior is actually well documented (in
kerneldoc comments and elsewhere).

Thanks,
Rafael
