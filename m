From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: Re: [PATCH] config: arm: omap2: remove PROVE_LOCKING from defconfig
Date: Tue, 13 Nov 2018 11:22:21 +0100
Message-ID: <21ce2c61-0b20-41f2-4d12-3c5b1c4b7925@partner.samsung.com>
References: <CGME20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af@eucas1p2.samsung.com>
        <20181009153624eucas1p2ad30aea33ad1c869f11bd9ca1156d9af~b_rxQW8J90311703117eucas1p2U@eucas1p2.samsung.com>
        <20181108165958.GK56134@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108165958.GK56134@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 11/8/18 5:59 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lukasz Luba <l.luba@partner.samsung.com> [181009 08:36]:
>> PROVE_LOCKING enables LOCKDEP, which causes big overhead on cache and
>> bus transactions.
>>
>> On some ARM big.LITTLE architecutres (Exynos 5433) the overhead is really big.
>> The overhead can be measures using hackbench which will speed up
>> by x3 times (11sec -> 3.4sec).
>> When you check transaction on cache or buses, the results are way higher
>> than normal for the same hackbench test:
>> L1d cache invalidations: 26mln vs 4mln
>> L2u cache invalidations: 42mln vs 12mln
>> bus cyc/access: 30cyc/access vs. 20cyc/access
>> context switch is x3 times cheaper
>>
>> Enable this option only when you have some locking issue to investigate.
> 
> I'm all for this, but this disables also other less intrusive
> debug options. It used to be that we'd get locking issues merged
> into drivers and I think that's how it originally got enabled.
That's common reason for a few defconfigs in mainline.
> 
> So we should take a look which ones we can or want to keep.
> Or just disable CONFIG_DEBUG completely.
Ideally, the CI should try a few 'types' of configs,
generated based on the 'defconfig'. Some 'smart' script might
cut the debug options for an image for performance regression tests.
> 
> For distros, that's multi_v7_defconfig nowadays for most part
> so I think most people using omap2plus_defconfig are developers
> working on various devices.
> 
> Regards,
> 
> Tony

Regards,
Lukasz
