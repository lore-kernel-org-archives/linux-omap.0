From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: Regression in Linux next again
Date: Thu, 31 May 2018 11:14:18 +0530
Message-ID: <CA+G9fYvmeCaSn4KvHtvygwj5yqwf=gchQAzd1YDYfd1LCwWDLA@mail.gmail.com>
References: <20180529221501.GJ5702@atomide.com> <CGME20180530091325epcas4p20dea07f013a3512ce4ea92120da90f61@epcas4p2.samsung.com>
 <20180530091314.GB6920@sirena.org.uk> <20180530140318eucas1p2af2d01b9678e8914c2b8e099c584ec11~zcQzVKtj30757607576eucas1p2V@eucas1p2.samsung.com>
 <20180530143338.GM6920@sirena.org.uk> <CA+G9fYvff4_9XH8Y4CTadexb2WGV+rAd29Jdo4ztBxqFXKbt5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+G9fYvff4_9XH8Y4CTadexb2WGV+rAd29Jdo4ztBxqFXKbt5Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Maciej Purski <m.purski@samsung.com>, Tony Lindgren <tony@atomide.com>, open list <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>, Tom Gall <tom.gall@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Sam Protsenko <semen.protsenko@linaro.org>
List-Id: linux-omap@vger.kernel.org

On 30 May 2018 at 20:23, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On 30 May 2018 at 20:03, Mark Brown <broonie@kernel.org> wrote:
>> On Wed, May 30, 2018 at 04:03:15PM +0200, Maciej Purski wrote:
>>
>>> I'm afraid, I have no idea, how to fix it quickly. You can revert it and
>>> in the next version I'll fix the build error and split the last patch even
>>> more, so we could perform a more precise bisection. I'd be grateful if you
>>> could push it on your test coupled branch and Tony could test it again before
>>> merging it with next again.
>>
>> Yeah, if we could get testing from Tony first that'd be ideal.
>
> Linux next 4.17.0-rc7-next-20180529 boot failed on x15 device.
> Manually reproduced boot failed problem on x15 device.
> The qemu_arm32 boots successfully.
>
> Ref bug:
> LKFT: linux-next: Boot failed on beagle board x15
> https://bugs.linaro.org/show_bug.cgi?id=3863

This bug still happening on 4.17.0-rc7-next-20180530 on beagle board x15.

Linux version 4.17.0-rc7-next-20180530 (buildslave@x86-64-07) (gcc version
 6.2.1 20161016 (Linaro GCC 6.2-2016.11)) #1 SMP Wed May 30 12:38:23 UTC 2018

- Naresh
