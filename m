From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Wed, 9 Apr 2014 15:14:45 +0530
Message-ID: <5345168D.9000001@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <534412FD.5030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40459 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758306AbaDIJpX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Apr 2014 05:45:23 -0400
In-Reply-To: <534412FD.5030308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Tuesday 08 April 2014 08:47 PM, Santosh Shilimkar wrote:
> On Tuesday 08 April 2014 10:53 AM, Sekhar Nori wrote:
>> On Friday 04 April 2014 03:48 PM, Russell King - ARM Linux wrote:
>>> On Fri, Apr 04, 2014 at 03:40:29PM +0530, Sekhar Nori wrote:
>>>> diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
>>>> index f8b8dac..6b2a056 100644
>>>> --- a/arch/arm/mach-omap2/omap4-common.c
>>>> +++ b/arch/arm/mach-omap2/omap4-common.c
>>>> @@ -224,6 +224,14 @@ int __init omap4_l2_cache_init(void)
>>>>  
>>>>  	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
>>>>  }
>>>> +
>>>> +int __init am43xx_l2_cache_init(void)
>>>> +{
>>>> +	u32 aux_ctrl = L310_AUX_CTRL_DATA_PREFETCH |
>>>> +		       L310_AUX_CTRL_INSTR_PREFETCH;
>>>
>>> It would be good to documenting the difference between this and OMAP4,
>>> and why you have chosen different values.
>>
>> There are two main differences:
>>
>> 1) OMAP4 sets Shared attribute override enable bit. TBH, I think this is
>> not needed even in OMAP4 with latest kernel, but I am not sure if I can
>> do this safely without breaking any usecase currently working with OMAP4.
>>
> Wrong. Shared bit is mandatory for the OMAP4. Its a SMP system
> which needs that.

Can you please explain a little bit more since I am obviously lacking
the background on OMAP4?

Commit b0f20ff9 ("omap4: l2x0: Set share override bit") talks about
possibility of data corruption due to speculative prefetch and coherent
DMA buffers having a cachable alias. But based on recent mailing list
discussions, with introduction of CMA, we should not have such a
cachable alias since the mapping is modified in place. If
arm_memblock_steal() or memblock_remove() is used, thats not a problem
as well since that memory is not mapped in kernel page tables.

As I indicated earlier, I am too not in favor of changing anything on
OMAP4 but it will be instructive to know exactly which scenarios shared
bit becomes mandatory on OMAP4.

>> 2) OMAP4 sets NS lockdown and NS interrupt access control bits. I
>> searched through the commit history of L2 cache support on OMAP4 but
>> there is no mention of why this was needed on OMAP4. I am checking
>> internally on the history behind this.
>>
> These have also come from the aligned settings with hardware folks.

Okay. AFAIK, There has not been such a recommendation from hardware team
of AM437x AFAIK. But, the AM437x ROM does leave these two bits set after
booting so even though Linux does not touch these, these are already set.

Given this, I see no reason for not setting the same bits again from
Linux just to get close to OMAP4 code.

>  
>> 3) OMAP4 sets cache replacement policy to RR which is not a big deal
>> since thats the default anyway. We can probably drop this setting even
>> from OMAP4.
>>
> Don't change anything on OMAP4 since these settings have come up from
> multiple alignments.

I agree. Thats what the $subject series is doing too.

> In my view, Aegis can use exact same setting as OMAP4. Things like
> shared bit etc would not make much difference because of UP config,
> keeping that doesn't hurt either.
> 
> Why don't you just re-use that as is ? Sorry if I have missed any
> other discussion on the thread.

We could reuse as is. I don't see any functional issue. This is what I
will probably do for the next version of the series. The only setting
thats actually being done differently is the Shared attribute override
enable bit.

Thanks,
Sekhar
