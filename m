From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 00/10] Add persistent clock support
Date: Wed, 16 May 2018 10:58:26 +0800
Message-ID: <CAMz4kuJpip-7wT=Z7izm_CJHzz-U81_a6XB3E-B5rXLVF2YUqA@mail.gmail.com>
References: <cover.1526285602.git.baolin.wang@linaro.org> <20180515135612.GQ29062@mai>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180515135612.GQ29062@mai>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, linux@armlinux.org.uk, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, mlichvar@redhat.com, rdunlap@infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>H
List-Id: linux-omap@vger.kernel.org

HI Daniel,

On 15 May 2018 at 21:56, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
>> Hi,
>>
>> We will meet below issues when compensating the suspend time for the timekeeping.
>>
>> 1. We have too many different ways of dealing with persistent timekeeping
>> across architectures, so it is hard for one driver to compatable with different
>> architectures.
>>
>> 2. On some platforms (such as Spreadtrum platform), we registered the high
>> resolution timer as one clocksource to update the OS time, but the high
>> resolution timer will be stopped in suspend state. So we use another one
>> always-on timer (but low resolution) to calculate the suspend time to
>> compensate the OS time. Though we can register the always-on timer as one
>> clocksource, we need re-calculate the mult/shift with one larger conversion
>> range to calculate the suspend time and need update the clock in case of
>> running over the always-on timer.
>>
>> More duplicate code will be added if other platforms meet this case.
>>
>> 3. Now we have 3 sources that could be used to compensate the OS time:
>> Nonstop clocksource during suspend, persistent clock and rtc device,
>> which is complicated. Another hand is that the nonstop clocksource can
>> risk wrapping if the suspend time is too long, so we need one mechanism
>> to wake up the system before the nonstop clocksource wrapping.
>>
>> According to above issues, we can introduce one common persistent clock
>> framework to compatable with different architectures, in future we will
>> remove the persistent clock implementation for each architecture. Also
>> this framework will implement common code to help drivers to register easily.
>> Moreover if we converted all SUSPEND_NONSTOP clocksource to register to
>> be one persistent clock, we can remove the SUSPEND_NONSTOP clocksource
>> accounting in timekeeping, which means we can only compensate the OS time
>> from persistent clock and RTC.
>>
>> Will be appreciated for any comments. Thank you all.
>
> Why do we need another API ?
>
> Why not remove the present persistent API and rely on the SUSPEND_NONSTOP flag
> to do the right action at suspend and resume?
>
> We register different clocksources, the rating does the selection.
>
> When entering 'suspend', we check against the SUSPEND_NONSTOP flag and switch
> to the first clocksource with the best rating and the flag set. When resuming,
> we switch back to the highest rating.

I agree with John's view he posted before, he said:

"For context, these abstractions have grown out of the need for using
different hardware components for all of these. It was quite common
for x86 hardware to use the acpi_pm for clocksource, lapic/PIT for
clockevent, tsc for sched_clock and CMOS RTC for persistent clock.
While some of these could be backed by the same hardware, it wasn't
common. However, hardware with less restrictions have allowed in some
cases for these to be more unified, but I'm not sure if its particularly common.

Another part of the reason that we don't combine the above
abstractions, even when they are backed by the same hardware, is
because some of the fields used for freq conversion (mult/shift) have
different needs for the different types of accounting.

For instance, with a clocksource, we are very focused on avoiding
error to keep timekeeing accurate, thus we want to use as large a
shift (and thus mult) as possible (and do our shifting as late as
possible in our accounting). However, that then shrinks the amount of
time that can be accumulated in one go w/o causing an overflow.

Where as with sched_clock, we don't worry as much as about accuracy,
so we can use smaller shifts (and thus mults), and thus can go for
longer periods of time between accumulating without worrying.

Similarly for the persistent clock case we don't need need to worry as
much about accuracy, so we can can use smaller shifts, but we are not
in as much of a hot patch, so we can also"

-- 
Baolin.wang
Best Regards
