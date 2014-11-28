From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v9 0/7] Enable L2 cache support on Exynos4210/4x12 SoCs
Date: Fri, 28 Nov 2014 09:55:53 +0100
Message-ID: <54783899.2060604@samsung.com>
References: <1416224909-4290-1-git-send-email-m.szyprowski@samsung.com>
 <20141127225100.GA3840@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141127225100.GA3840@n2100.arm.linux.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomasz Figa <tomasz.figa@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Kukjin Kim <kgene.kim@samsung.com>, lauraa@codeaurora.org, linux-omap@vger.kernel.org, linus.walleij@linaro.org, tony@atomide.com, drake@endlessm.com, loeliger@gmail.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-omap@vger.kernel.org

Hello,

On 2014-11-27 23:51, Russell King - ARM Linux wrote:
> On Mon, Nov 17, 2014 at 12:48:22PM +0100, Marek Szyprowski wrote:
>> This is an updated patchset, which intends to add support for L2 cache
>> on Exynos4 SoCs on boards running under secure firmware, which requires
>> certain initialization steps to be done with help of firmware, as
>> selected registers are writable only from secure mode.
>>
>> First four patches extend existing support for secure write in L2C driver
>> to account for design of secure firmware running on Exynos. Namely:
>>   1) direct read access to certain registers is needed on Exynos, because
>>      secure firmware calls set several registers at once,
>>   2) not all boards are running secure firmware, so .write_sec callback
>>      needs to be installed in Exynos firmware ops initialization code,
>>   3) write access to {DATA,TAG}_LATENCY_CTRL registers fron non-secure world
>>      is not allowed and so must use l2c_write_sec as well,
>>   4) on certain boards, default value of prefetch register is incorrect
>>      and must be overridden at L2C initialization.
>> For boards running with firmware that provides access to individual
>> L2C registers this series should introduce no functional changes. However
>> since the driver is widely used on other platforms I'd like to kindly ask
>> any interested people for testing.
>>
>> Further three patches add implementation of .write_sec and .configure
>> callbacks for Exynos secure firmware and necessary DT nodes to enable
>> L2 cache.
>>
>> Changes in this version tested on Exynos4412-based TRATS2 and OdroidU3+
>> boards (both with secure firmware). There should be no functional change
>> for Exynos boards running without secure firmware. I do not have access
>> to affected non-Exynos boards, so I could not test on them.
> So, I applied this series, and now I get a conflicts between my tree and
> arm-soc for:
>
> arch/arm/mach-exynos/firmware.c
> arch/arm/mach-exynos/sleep.S
>
> So, I'm going to un-stage the exynos bits, and we'll have to work out
> some way to handle those.

I've already pointed that those patches depend on other previously merged to
exynos and arm-soc trees, but both Arnd and Kukjin said that those patch 
series
should go via your kernel tree:

https://lkml.org/lkml/2014/11/15/158

That's why in v9 I rebased patches once again onto vanilla v3.18-rc4 and 
uploaded
to your patch tracker. I see the following two possibilities to get them 
merged:

1. Merge patches to rmk tree and resolve the merge conflict. The 
conflict IS quite
easy to resolve - both trees, arm-soc and rmk only adds some code and 
the goal is
simply to have both chunks added.

2. Merge the previous version (v8 from the above link) to arm-soc tree, 
where it
applies cleanly on for-next, preferably with Russell's Acked-by.

Arnd, Russell: which approach do you prefer? How can I help to get it 
merged?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
