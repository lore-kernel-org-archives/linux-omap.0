From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: PM regression with commit 5de85b9d57ab PM runtime re-init in v4.5-rc1
Date: Thu, 28 Jan 2016 15:29:36 +0100
Message-ID: <CAPDyKFqD6Y6HcgVds_oWBZ8L7Kdh2VX_WZCGApf-1a_6GHCQ5g@mail.gmail.com>
References: <20160126224804.GB19432@atomide.com>
	<CAJZ5v0i79X5JjOZiu4cOZ0Esd5BxAvutF8d17asDzq9ECcML-g@mail.gmail.com>
	<20160126232212.GE19432@atomide.com>
	<CAJZ5v0gTRvyWHVmYNb8Q1QZzhVhokXo541+48mFyDRYv7Hi-Uw@mail.gmail.com>
	<20160126235222.GF19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160126235222.GF19432@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Kevin Hilman <khilman@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On 27 January 2016 at 00:52, Tony Lindgren <tony@atomide.com> wrote:
> * Rafael J. Wysocki <rafael@kernel.org> [160126 15:38]:
>> On Wed, Jan 27, 2016 at 12:22 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > * Rafael J. Wysocki <rafael@kernel.org> [160126 15:15]:
>> >> On Tue, Jan 26, 2016 at 11:48 PM, Tony Lindgren <tony@atomide.com> wrote:
>> >> > Hi,
>> >> >
>> >> > Looks like commit 5de85b9d57ab ("PM / runtime: Re-init runtime
>> >> > PM states at probe error and driver unbind") broke PM on at least

I need to understand the issue here in a bit more detail, could you
please try to fill out some of my gaps!?

In *what way* did it break PM?

Did the driver not probe successfully the second try? If so, what happened.

>> >> > omap3. It seems we now need to additionally also call
>> >> > pm_runtime_dont_use_autosuspend() to get things working again?
>> >> >
>> >> > The following fixes idling on omap3, but I'm wondering if we
>> >> > should do something in pm_runtime_reinit() instead?

I understand this as the second (or third, forth, whatever) probing
attempt actually succeeds, right!?

Is the issue you are seeing, that the device never becomes runtime
suspended due to commit 5de85b9d57ab ("PM / runtime: Re-init runtime
PM states at probe error and driver unbind")?

>> >>
>> >> Well, does it actually help if you add
>> >> pm_runtime_dont_use_autosuspend(dev) to pm_runtime_reinit()?
>> >
>> > No adding it to pm_runtime_reinit() does not help.
>>
>> Yes, I realized that it wouldn't help only after sending the previous
>> message, sorry about that.
>>
>> The reason why it helps in the driver code seems to be that
>> autosuspend_delay happens to be negative, so update_autosuspend()
>> decrements the usage counter that would have stayed incremented
>> otherwise.  Or at least that's the only way it can help I see ATM.
>
> Oh OK.
>
>> > Looks like we have RPM_ACTIVE set in pm_runtime_reinit() if that
>> > gives any clues.

That's a good clue. Although, there could be several reasons to why.

Rafael has pointed out one valid potential case, but I want to be sure
that's really what happening here.

*If* the problem is that the device doesn't becomes runtime suspended,
that will anyway be prevented as long as the autosuspend_delay has
been set to a negative value. That's why I wonder whether this really
is the case here.

For omap3, I assume there's a PM domain (the so called hwmod) being
attached to the omap_hsmmc device at device registration point!?
In that path depending on a specific hwmod flag, the device will be
given the an initial *active* runtime PM status, via invoking
pm_runtime_set_active().

*If* that's the case, it affects the probing sequence, as the
pm_runtime_get_sync() won't trigger the ->runtime_resume() callbacks
to be invoked in the first probe attempt.

Moreover, according to the data I received in this regression report
so far, it seems like probing the second time has *always* been done
with the device in runtime PM active state. Could that be the reason
to why it "happens" to work?

>>
>> It looks like pm_runtime_reinit() should clear the usage counter too.
>
> Yeah if we do this when !pm_runtime_enabled(dev) it seems it's
> safe to pretty much reset everything?
>
> Regards,
>
> Tony

Kind regards
Uffe
