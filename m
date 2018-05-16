From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [RFC PATCH 00/10] Add persistent clock support
Date: Wed, 16 May 2018 15:11:48 +0800
Message-ID: <CAMz4kuJomy9Lkjm47qdKrTTmohaGYZNAUG5gV7kf+L46bQfpdg@mail.gmail.com>
References: <cover.1526285602.git.baolin.wang@linaro.org> <20180515102715.GO29062@mai>
 <CAMz4kuJjhhty7HigPEA6Gm4HtFk_3t1aCwbX3c0mLLQF8SZBLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuJjhhty7HigPEA6Gm4HtFk_3t1aCwbX3c0mLLQF8SZBLw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, linux@armlinux.org.uk, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, mlichvar@redhat.com, rdunlap@infradead.org, Kate Stewart <kstewart@linuxfoundation.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thierry Reding <thierry.reding@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Linus Walleij <linus.walleij@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Ingo Molnar <mingo@kernel.org>H
List-Id: linux-omap@vger.kernel.org

On 16 May 2018 at 10:20, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Daniel,
>
> On 15 May 2018 at 18:27, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On Mon, May 14, 2018 at 04:55:26PM +0800, Baolin Wang wrote:
>>> Hi,
>>>
>>> We will meet below issues when compensating the suspend time for the timekeeping.
>>>
>>> 1. We have too many different ways of dealing with persistent timekeeping
>>> across architectures, so it is hard for one driver to compatable with different
>>> architectures.
>>>
>>> 2. On some platforms (such as Spreadtrum platform), we registered the high
>>> resolution timer as one clocksource to update the OS time, but the high
>>> resolution timer will be stopped in suspend state. So we use another one
>>> always-on timer (but low resolution) to calculate the suspend time to
>>> compensate the OS time. Though we can register the always-on timer as one
>>> clocksource, we need re-calculate the mult/shift with one larger conversion
>>> range to calculate the suspend time and need update the clock in case of
>>> running over the always-on timer.
>>
>> First, can you elaborate what you mean by 'suspend state' ? On which power
>
> What I mean is the high resolution timer will be stopped when the
> system goes into suspend state.
>
>> domain the clocksource belongs to?
>
> On Spreadtrum platform, It belongs to one power domain named
> "APCPU_TOP", that will be power down when the system goes into suspend
> state.

Sorry, I made a mistake here. Our high resolution timer is on one
always-on power domain, but it's clock will be shut down when the
system goes into suspend.

-- 
Baolin.wang
Best Regards
