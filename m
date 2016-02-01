From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Mon, 1 Feb 2016 17:44:01 +0100
Message-ID: <CAPDyKFoQHpqdCa4fzHycP0OT2KsNTxWm7JZSe8Mauh+rxqGtGg@mail.gmail.com>
References: <20160126224804.GB19432@atomide.com>
	<CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
	<20160126232212.GE19432@atomide.com>
	<CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
	<20160126235222.GF19432@atomide.com>
	<CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
	<20160128165810.GA19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160128165810.GA19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 28 January 2016 at 17:58, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> * Ulf Hansson <ulf.hansson@linaro.org> [160128 06:30]:
>> On 27 January 2016 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
>> > * Rafael J. Wysocki <rafael@kernel.org> [160126 15:38]:
>> >> On Wed, Jan 27, 2016 at 12:22 AM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > * Rafael J. Wysocki <rafael@kernel.org> [160126 15:15]:
>> >> >> On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >> >> > Hi,
>> >> >> >
>> >> >> > Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
>> >> >> > PM states at probe error and driver unbind") broke PM on at least
>>
>> I need to understand the issue here in a bit more detail, could you
>> please try to fill out some of my gaps!?
>>
>> In *what way* did it break PM?
>
> The MMC hardware will not get idled properly any longer blocking any
> deeper idle states.
>
>> Did the driver not probe successfully the second try? If so, what happened.
>
> It probes fine after a -EPROBE_DEFER on the vmmc i2c regulator.
> But the PM runtime usecounts are wrong.

Okay. How did you verify this?

I think the easiest way would be to make sure the usage count is
*one*, just before the omap_hsmmc calls mmc_add_host() in its
->probe() function.

If it's *two*, that confirms this theory.

>
>> >> >> > omap3. It seems we now need to additionally also call
>> >> >> > pm_runtime_dont_use_autosuspend() to get things working again?
>> >> >> >
>> >> >> > The following fixes idling on omap3, but I'm wondering if we
>> >> >> > should do something in pm_runtime_reinit() instead?
>>
>> I understand this as the second (or third, forth, whatever) probing
>> attempt actually succeeds, right!?
>
> Right.
>
>> Is the issue you are seeing, that the device never becomes runtime
>> suspended due to commit 5de85b9d57ab ("PM / runtime: Re-init runtime
>> PM states at probe error and driver unbind")?
>
> Correct.
>
>> >> > Looks like we have RPM_ACTIVE set in pm_runtime_reinit() if that
>> >> > gives any clues.
>>
>> That's a good clue. Although, there could be several reasons to why.
>>
>> Rafael has pointed out one valid potential case, but I want to be sure
>> that's really what happening here.
>>
>> *If* the problem is that the device doesn't becomes runtime suspended,
>> that will anyway be prevented as long as the autosuspend_delay has
>> been set to a negative value. That's why I wonder whether this really
>> is the case here.
>
> That seems to be the case here. In device driver probe, commenting out
> pm_runtime_set_autosuspend_delay(host->dev, MMC_AUTOSUSPEND_DELAY)
> also makes things work again.

Okay. Interesting. :-)

>
> So one of the failing cases seems to be:
>
> 1. Device driver probe sets pm_runtime_set_autosuspend_delay()

Only when "someone" in-before has set the autosuspend delay to a
negative value, this will affect the usage count.

I didn't find any in-kernel user that would set this for the
omap_hsmmc device, so it needs to be done from userspace via sysfs. It
would be really great if you could help to confirm this.

But more importantly, I fail to understand why commit 5de85b9d57ab
("PM / runtime: Re-init runtime PM states at probe error and driver
unbind"), is changing the behaviour in this regards.
Potentially we might have a different runtime PM status than we had
before when probing the second try, but how could that mess up the
usage count...?

>
> 2. Device driver probe initially fails with -EPROBE_DEFER

So that happened before as well.

Although, we now get a different runtime PM status (suspended) the
second probe time.

>
> 3. PM runtime usecounts get messed up

Perhaps, but let's try to validate that as it should be rather easy.

>
>> For omap3, I assume there's a PM domain (the so called hwmod) being
>> attached to the omap_hsmmc device at device registration point!?
>
> Correct. It uses the notifiers like bus code does in general.

Yes, there perfectly okay.

Although, I wondering whether it could be that it's the PM domain
that's preventing the omap_hsmmc device from becoming runtime
suspended.

Perhaps the PM domain returns an error code from its
->runtime_suspend() callback?

>
> FYI, most SoCs don't have hardware based autoidle signaling between
> the interconnect and the interconnect targets. So the hwmod code is
> still needed until we have converted it into a proper interconnect +
> module target drivers.
>
>> In that path depending on a specific hwmod flag, the device will be
>> given the an initial *active* runtime PM status, via invoking
>> pm_runtime_set_active().
>>
>> *If* that's the case, it affects the probing sequence, as the
>> pm_runtime_get_sync() won't trigger the ->runtime_resume() callbacks
>> to be invoked in the first probe attempt.
>
> It has worked since pm runtime. And it works with MMC as as a loadable
> module just fine when no -EPROBE_DEFER happens.

Okay, so we definitely seem to have an issue with the changed runtime
PM status (suspended) the second probe time.

That's indeed caused by 5de85b9d57ab ("PM / runtime: Re-init runtime
PM states at probe error and driver unbind").

>
>> Moreover, according to the data I received in this regression report
>> so far, it seems like probing the second time has *always* been done
>> with the device in runtime PM active state. Could that be the reason
>> to why it "happens" to work?
>
> Not correct. I think that speculation is not related to the $subject
> regression at all.

I think it's important in this context, as it could affect how the PM
domain may treat the device. As I mentioned earlier.

For example due to commit 5de85b9d57ab ("PM / runtime: Re-init runtime
PM states at probe error and driver unbind"), the ->runtime_resume()
callback seems now to be called twice in a row, without in-between
having the ->runtime_suspend() callback being invoked. Does really the
PM domain cope with that correctly?

>
> BTW, do you have some hardware to test with that has PM runtime
> implemnted and actually working with mainline kernel?

Oh, yes. Although I don't have an omap3, I wish I had.

Also, I have locally a "runtime PM test driver", which helps me to
test various runtime PM sequences.

Kind regards
Uffe
