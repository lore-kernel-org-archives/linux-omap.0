From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/8] time: Add persistent clock support
Date: Tue, 26 Jun 2018 10:12:53 +0800
Message-ID: <CAMz4ku+CkJxCXxV+qb1MuysE+VvGGxs3nOEnxjEuOfa2S-Yo4g@mail.gmail.com>
References: <cover.1528878545.git.baolin.wang@linaro.org> <d330f02c8ef2a348b179850e1745a52ab9c47e90.1528878545.git.baolin.wang@linaro.org>
 <alpine.DEB.2.21.1806232224510.8650@nanos.tec.linutronix.de> <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALAqxLWgfy8X75GOK5WttzRfgbwBxW0ibnQaFxcLrUTFmHMSUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, Russell King - ARM Linux <linux@armlinux.org.uk>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Miroslav Lichvar <mlichvar@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Vi
List-Id: linux-omap@vger.kernel.org

Hi John,

On 26 June 2018 at 01:23, John Stultz <john.stultz@linaro.org> wrote:
> On Sat, Jun 23, 2018 at 5:14 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
>> On Wed, 13 Jun 2018, Baolin Wang wrote:
>>> Moreover we can register the clocksource with CLOCK_SOURCE_SUSPEND_NONSTOP
>>> to be one persistent clock, then we can simplify the suspend/resume
>>> accounting by removing CLOCK_SOURCE_SUSPEND_NONSTOP timing. After that
>>> we can only compensate the OS time by persistent clock or RTC.
>>
>> That makes sense because it adds a gazillion lines of code and removes 5?
>> Not really,
>>
>>> +/**
>>> + * persistent_clock_read_data - data required to read persistent clock
>>> + * @read: Returns a cycle value from persistent clock.
>>> + * @last_cycles: Clock cycle value at last update.
>>> + * @last_ns: Time value (nanoseconds) at last update.
>>> + * @mask: Bitmask for two's complement subtraction of non 64bit clocks.
>>> + * @mult: Cycle to nanosecond multiplier.
>>> + * @shift: Cycle to nanosecond divisor.
>>> + */
>>> +struct persistent_clock_read_data {
>>> +     u64 (*read)(void);
>>> +     u64 last_cycles;
>>> +     u64 last_ns;
>>> +     u64 mask;
>>> +     u32 mult;
>>> +     u32 shift;
>>> +};
>>> +/**
>>> + * persistent_clock - represent the persistent clock
>>> + * @read_data: Data required to read from persistent clock.
>>> + * @seq: Sequence counter for protecting updates.
>>> + * @freq: The frequency of the persistent clock.
>>> + * @wrap: Duration for persistent clock can run before wrapping.
>>> + * @alarm: Update timeout for persistent clock wrap.
>>> + * @alarm_inited: Indicate if the alarm has been initialized.
>>> + */
>>> +struct persistent_clock {
>>> +     struct persistent_clock_read_data read_data;
>>> +     seqcount_t seq;
>>> +     u32 freq;
>>> +     ktime_t wrap;
>>> +     struct alarm alarm;
>>> +     bool alarm_inited;
>>> +};
>>
>> NAK!
>>
>> There is no reason to invent yet another set of data structures and yet
>> more read functions with a sequence counter. which are just a bad and
>> broken copy of the existing timekeeping/clocksource code. And of course the
>> stuff is not serialized against multiple registrations, etc. etc.
>>
>> Plus the utter nonsense that any call site has to do the same thing over
>> and over:
>>
>>     register():
>>     start_alarm_timer();
>>
>> Why is this required in the first place? It's not at all. The only place
>> where such an alarm timer will be required is when the system actually goes
>> to suspend. Starting it at registration time is pointless and even counter
>> productive. Assume the clocksource wraps every 2 hours. So you start it at
>> boot time and after 119 minutes uptime the system suspends. So it will
>> wakeup one minute later to update the clocksource. Heck no. If the timer is
>> started when the machine actually suspends it will wake up earliest in 120
>> minutes.
>>
>> And you even add that to the TSC which does not need it at all. It will
>> wrap in about 400 years on a 2GHZ machine. So you degrade the functionality
>> instead of improving it.
>>
>> So no, this is not going anywhere.
>>
>> Let's look at the problem itself:
>>
>>    You want to use one clocksource for timekeeping during runtime which is
>>    fast and accurate and another one for suspend time injection which is
>>    slower and/or less accurate because the fast one stops in suspend.
>>
>>    Plus you need an alarmtimer which makes sure that the clocksource does
>>    not wrap around during suspend.
>>
>> Now lets look what we have already:
>>
>>    Both clocksources already exist and are registered as clocksources with
>>    all required data in the clocksource core.
>>
>> Ergo the only sane and logical conclusion is to expand the existing
>> infrastructure to handle that.
>>
>> When a clocksource is registered, then the registration function already
>> makes decisions about using it as timekeeping clocksource. So add a few
>> lines of code to check whether the newly registered clocksource is suitable
>> and preferred for suspend.
>>
>>         if (!stops_in_suspend(newcs)) {
>>                 if (!suspend_cs || is_preferred_suspend_cs(newcs))
>>                         suspend_cs = newcs;
>>         }
>>
>> The is_preferred_suspend_cs() can be based on rating, the maximum suspend
>> length which can be achieved or whatever is sensible. It should start of as
>> a very simple decision function based on rating and not an prematurely
>> overengineered monstrosity.
>>
>> The suspend/resume() code needs a few very simple changes:
>>
>> xxx_suspend():
>>         clocksource_prepare_suspend();
>>
>>   Note, this is _NOT_ timekeeping_suspend() because that is invoked _AFTER_
>>   alarmtimer_suspend(). So if an alarm timer is required it needs to be
>>   armed before that. A trivial solution might be to just call it from
>>   alarmtimer_suspend(), but that a minor detail to worry about.
>>
>> timekeeping_suspend()
>> {
>>         clocksource_enter_suspend();
>>         ...
>>
>> timekeeping_resume()
>> {
>> ...
>>         if (clocksource_leave_suspend(&nsec)) {
>>                 ts_delta = ns_to_timespec64(nsec);
>>                 sleeptime_injected = true;
>>         } else if (......
>>
>>
>> Now lets look at the new functions:
>>
>> void clocksource_prepare_suspend(void)
>> {
>>         if (!suspend_cs)
>>                 return;
>>
>>         if (needs_alarmtimer(suspend_cs))
>>                 start_suspend_alarm(suspend_cs);
>> }
>>
>> void clocksource_enter_suspend(void)
>> {
>>         if (!suspend_cs)
>>                 return;
>>         suspend_start = suspend_cs->read();
>> }
>>
>> bool clocksource_leave_suspend(u64 *nsec)
>> {
>>         u64 now, delta;
>>
>>         if (!suspend_cs)
>>                 return false;
>>
>>         now = suspend_cs->read();
>>         delta = clocksource_delta(now, suspend_start, suspend_cs->mask);
>>         *nsec = mul_u64_u32_shr(delta, suspend_cs->mult, suspend_cs->shift);
>>         return true;
>> }
>>
>> See? It does not need any of this totally nonsensical stuff in your
>> registration function and not any new read functions and whatever, because
>> it simply can use the bog standard mult/shift values. Why? Because the
>> conversion above can cope with a full 64 bit * 32 bit multiply without
>> falling apart. It's already there in timekeeping_resume() otherwise
>> resuming with a NONSTOP TSC would result in bogus sleep times after a few
>> minutes. It's slower than the normal clocksource conversion which is
>> optimized for performance, but thats completely irrelevant on resume. This
>> whole blurb about requiring separate mult/shift values is just plain
>> drivel.
>>
>> Plus any reasonably broad clocksource will not need an alarmtimer at
>> all. Because the only reason it is needed is when the clocksource itself
>> wraps around. And that has absolutely nothing to do with mult/shift
>> values. That just depends on the frequency and the bitwidth of the counter,
>>
>> So it does not need an update function either because in case of broad
>> enough clocksources there is absolutely no need for update and in case of
>> wrapping ones the alarmtimer brings it out of suspend on time. And because
>> the only interesting thing is the delta between suspend and resume this is
>> all a complete non issue.
>>
>> The clocksource core already has all the registration/unregistration
>> functionality plus an interface to reconfigure the frequency, so
>> clocksources can come and go and be reconfigured and all of this just
>> works.
>>
>> Once the extra few lines of code are in place, then you can go and cleanup
>> the existing mess of homebrewn interfaces and claim that this is
>> consolidation and simplification.
>>
>> <rant>
>>
>> What's wrong with you people? Didn't they teach you in school that the
>> first thing to do is proper problem and code analysis? If they did not, go
>> back to them and ask your money back,
>>
>> I'm really tired of these overengineered trainwrecks which are then
>> advertised with bullshit marketing like the best invention since sliced
>> bread. This might work in random corporates, but not here.
>>
>> </rant>
>
> Thomas, what is wrong with *you*?  This is completely unnecessary.
>
> First of all, I sent Baolin on this approach, as I was getting sick of
> seeing the suspend/resume timing continually adding extra warts and
> complexity to handle odd hardware that needs some solution. So I
> suggested he clean that up in a way that lets these multiple ways of
> solving the problem be done in device specific code w/o adding more
> complexity to the core logic - in a fashion how the clocksources
> allowed us to support nice fast/well-behaving hardware w/o preventing
> ugly-but-neccessary solutions like the pit clocksource.
>
> Now, I've also been quite a poor maintainer of late, and haven't done
> much to help with pre-review of Baloin's code.  So that's on me, not
> him.
>
> Admittedly, my taste isn't always great, so there is likely to be a
> better approach, and having your guidance here is *really* valued. I
> just wish we could get it without all this unnecessary vinegar.
>
> I was really lucky to have your guidance and support when I was
> starting in the community. Your helping bring me up as a co-maintainer
> (only a a relatively small set of responsibility compared to your much
> wider maintainership), does let me see that having the responsibility
> of billions of devices running your code is immense and comes with no
> small amount of stress. Juggling the infinite incoming stream of
> review requests on naieve or otherwise lacking code with other
> important development priorities is a major burden, so *I really get
> how frustrating it is*.
>
> And its super annoying to have lots of short-term development requests
> being thrown at you when you're the one who has to maintain it for the
> long term.  But long-long-term, no one is going to be a maintainer
> forever, and we are not going to develop more olympic swimmers if we
> keep peeing in the pool.
>
>
> Baolin: My apologies for leading you poorly here. Work on something
> else for a day to let the flames burn off you, then review Thomas'
> technical feedback, ignoring the harsh style, and try to address his
> technical comments with the approach. I'll try to do better in finding
> time to review your work.

Thanks John, I will follow Thomas' suggestion and re-implement the approach.

---
Baolin Wang
Best Regards
